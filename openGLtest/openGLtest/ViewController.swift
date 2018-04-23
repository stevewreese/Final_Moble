//
//  ViewController.swift
//  openGLtest
//
//  Created by u0396206 on 4/23/18.
//  Copyright © 2018 u0396206. All rights reserved.
//

import GLKit

class ViewController: GLKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let glkView: GLKView = view as! GLKView
        glkView.context = EAGLContext(api: .openGLES2)!
        EAGLContext.setCurrent(glkView.context)
        
        let vertexShaderSource: NSString = """
        "
            void main(){
                gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
            }
        "
        """
        
        var vertexShaderSourceMemory = vertexShaderSource.utf8String
        let vertexShader: GLuint = glCreateShader(GLenum(GL_VERTEX_SHADER))
        glShaderSource(vertexShader, 1, &vertexShaderSourceMemory, nil)
        glCompileShader(vertexShader)
        
        let fragmentShaderSource: NSString = """
        "
            void main(){
                gl_Position = vec4(1.0, 1.0, 0.0, 1.0);
            }
        "
        """
        
        var fragmentShaderSourceMemory = fragmentShaderSource.utf8String
        let fragmentShader: GLuint = glCreateShader(GLenum(GL_FRAGMENT_SHADER))
        glShaderSource(fragmentShader, 1, &fragmentShaderSourceMemory, nil)
        glCompileShader(fragmentShader)
        
        glColor4f(1.0, 0.0, 0.0, 1.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        //TODO DRAW A TRIANGLE
        let triangleData: [Float] = [
            +0.80, -0.30,
            -0.30, +0.70,
            -0.65, -0.65,
        ]
        
        glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, triangleData)
        
        glDrawArrays(GLenum(GL_TRIANGLES), 0, 3)
    }


}

