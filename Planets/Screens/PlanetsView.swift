//
//  PlanetsView.swift
//  Planets
//
//  Created by Furkan Ceylan on 11.08.2024.
//

import SwiftUI
import SceneKit

struct PlanetsView: View {
    
    // MARK: - Animation Properties
    @State private var expandCard: Bool = false
    @State private var currentPlanet: Planet?
    @State private var currentIndex: Int = -1
    @State private var showDetail: Bool = false
    @Namespace var animation
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // MARK: - Functions
    func makeScene(sceneName: String) -> SCNScene {
        guard let scene = SCNScene(named: sceneName) else {fatalError("Scene Name has not detected")}
        return scene
    }
    
    // MARK: - Content
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { proxy in
                    let size = proxy.size
                    StackPlanetsView(size: size)
                        .frame(width: size.width, height: size.height, alignment: .center)
                }
            }//: ZStack Main
            .navigationBarBackButtonHidden(true)
            .overlay {
                // Detail View
                ZStack {
                    if let currentPlanet = currentPlanet, showDetail{
                        LinearGradient(colors: [.purple, .blue, .indigo, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea()
                        DetailView(currentPlanet: currentPlanet)
                    }
                }
            }
        }//: Navigation Stack
    }
        
    
    // MARK: - Stack Planets View
    @ViewBuilder
    func StackPlanetsView(size: CGSize) -> some View {
        let offsetHeight = size.height * 0.1
        ZStack {
            StardomView()
            ForEach(stackPlanet.reversed()){ planet in
                
                let index = getIndex(planet: planet)
                let imageSize = (size.width - CGFloat(index) * 20)
                
                LegacySceneView(scene: {makeScene(sceneName: planet.planetImage)}(), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                    .frame(width: abs(imageSize / 2), height: abs(imageSize / 2))
                    .rotation3DEffect(
                        .init(degrees: expandCard ? -10 : 0),
                        axis: (x: 1.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 1,
                        perspective: 1
                    )
                    .matchedGeometryEffect(id: planet.id, in: animation)
                    .offset(y: CGFloat(index) * -30)
                    .offset(y: expandCard ? -CGFloat(index) * offsetHeight / 3 : 0)
                    .onTapGesture {
                        if expandCard{
                            // Selecting current card
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.8)) {
                                currentPlanet = planet
                                currentIndex = index
                                showDetail = true
                                DispatchQueue.main.async {
                                    audioPlayer(sound: "success", extention: "mp3")
                                }
                            }
                        }else{
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                expandCard = true
                            }
                        }
                    }
                    .offset(y: showDetail && currentIndex != index ? size.height * (currentIndex < index ? -1 : 1) : 0)
                
            }
        }
        .offset(y: expandCard ? offsetHeight * 3 : 0)
        .frame(width: size.width, height: size.height)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                expandCard.toggle()
                hapticFeedback.notificationOccurred(.success)
            }
        }
    }
    
    @ViewBuilder
    func DetailView(currentPlanet: Planet) -> some View {
        
        ZStack {
            StardomView()
            GeometryReader { proxy in
                VStack(spacing: 0){
                    Button(action: {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.8)) {
                            self.currentIndex = -1
                            self.currentPlanet = nil
                            showDetail = false
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundStyle(.black)
                    })
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    
                    ScrollView(.vertical) {
                        VStack(spacing: 25) {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.8)) {
                                
                                LegacySceneView(scene: {makeScene(sceneName: currentPlanet.planetImage)}(), options: [.autoenablesDefaultLighting, .allowsCameraControl])
                                    .frame(width: proxy.size.width, height: proxy.size.width)
                                
                            }
                            Text(findThePlanet(name: currentPlanet.name)?.Name ?? "Nil")
                                .foregroundStyle(.white)
                                .font(.system(.title2, design: .rounded, weight: .bold))
                            
                            ScrollView(.horizontal) {
                                //CustomView
                                HStack {
                                    
                                    ForEach(reflectProperties(of: findThePlanet(name: currentPlanet.name)!), id: \.0) { property in
                                        
                                        CustomPlanetDetailView(title: property.0, value: property.1)
                                            .frame(width: proxy.size.width * 0.4, height: proxy.size.height * 0.3)
                                            .padding(.leading, 25)
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    func getIndex(planet: Planet) -> Int {
        return stackPlanet.firstIndex { currentPlanet in
            return planet.id == currentPlanet.id
        } ?? 0
    }
    
    func findThePlanet(name: String) -> PlanetDataModel? {
        guard let planetDataModel = planetModelArray.flatMap({ $0 }).first(where: {$0.Name == name}) else {return nil}
        return planetDataModel
    }
    
    func reflectProperties(of planet: PlanetDataModel) -> [(String, String)] {
        let mirror = Mirror(reflecting: planet)
        return mirror.children.compactMap { child in
            if let label = child.label {
                return (label, "\(child.value)")
            }
            return nil
        }
    }
}

#Preview {
    ZStack {
        Color.indigo
            .ignoresSafeArea()
        PlanetsView()
    }
}

struct LegacySceneView: UIViewRepresentable {
    var scene: SCNScene
    var options: SceneView.Options
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.backgroundColor = UIColor.clear
        view.allowsCameraControl = options.contains(.allowsCameraControl)
        view.autoenablesDefaultLighting = options.contains(.autoenablesDefaultLighting)
        view.rendersContinuously = options.contains(.rendersContinuously)
        view.isJitteringEnabled = options.contains(.jitteringEnabled)
        view.isTemporalAntialiasingEnabled = options.contains(.temporalAntialiasingEnabled)
        view.scene = scene
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) { }
}
