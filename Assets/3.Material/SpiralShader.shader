// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SpiralShader"
{
	Properties
	{
		_Scale("Scale", Range( 0 , 0.1)) = 0
		_XOffset("XOffset", Float) = 0
		_MainColor("MainColor", Color) = (1,1,1,1)
		_Fold("Fold", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _Fold;
		uniform float _Scale;
		uniform float _XOffset;
		uniform float4 _MainColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float ThetaMax135 = 21.0;
			float Fold163 = _Fold;
			float2 appendResult154 = (float2(Fold163 , 0.0));
			float2 uv_TexCoord89 = v.texcoord.xy + appendResult154;
			float clampResult124 = clamp( ( 1.0 - uv_TexCoord89.x ) , 0.0 , 1.0 );
			float Mask94 = clampResult124;
			float lerpResult92 = lerp( ThetaMax135 , -1.0 , Mask94);
			float _Theta96 = lerpResult92;
			float temp_output_162_0 = (0.007 + (( 1.0 - Fold163 ) - 0.0) * (_Scale - 0.007) / (1.0 - 0.0));
			float r101 = ( _Theta96 * temp_output_162_0 );
			float x114 = ( r101 * cos( _Theta96 ) );
			float y107 = ( r101 * sin( _Theta96 ) );
			float2 appendResult116 = (float2(( x114 - ( Mask94 * (0.0 + (ThetaMax135 - 0.0) * (_XOffset - 0.0) / (50.0 - 0.0)) ) ) , ( y107 + ( temp_output_162_0 * ( ThetaMax135 * -1.0 ) ) )));
			float2 VertexOffset119 = appendResult116;
			v.vertex.xyz += float3( VertexOffset119 ,  0.0 );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Albedo = _MainColor.rgb;
			float temp_output_144_0 = 0.0;
			o.Specular = temp_output_144_0;
			o.Gloss = temp_output_144_0;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
0;240;1323;779;1431.173;-704.9144;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;93;-1900.115,-153.0382;Inherit;False;1743.415;313.3011;Mask;7;163;94;124;90;89;154;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;153;-1751.543,-65.83978;Inherit;False;Property;_Fold;Fold;4;0;Create;True;0;0;False;0;False;0;0.38;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;163;-1414.438,-30.0773;Inherit;False;Fold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;154;-1156.601,-32.20679;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;89;-950.7401,-91.33823;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;90;-723.5735,-58.18283;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;124;-515.2143,-61.70838;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;97;-2009.656,201.8671;Inherit;False;1384.834;278.7694;Theta;5;96;92;135;95;91;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-1967.759,253.8671;Inherit;False;Constant;_ThetaMax;ThetaMax;2;0;Create;True;0;0;False;0;False;21;21;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;-364.3735,-62.36623;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;95;-1687.882,356.2552;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-1669.343,264.2185;Inherit;False;ThetaMax;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;102;-2159.396,519.6815;Inherit;False;1089.566;453.9085;r;9;164;165;162;101;100;98;99;171;172;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;164;-2087.905,653.4924;Inherit;False;163;Fold;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;92;-1412.308,251.8671;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;165;-1853.618,652.0848;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;96;-1080.968,296.6147;Inherit;False;_Theta;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;99;-2142.937,813.8469;Inherit;False;Property;_Scale;Scale;0;0;Create;True;0;0;False;0;False;0;0.0316;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;162;-1641.395,702.9406;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.007;False;4;FLOAT;0.028;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;98;-1809.28,569.6812;Inherit;False;96;_Theta;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;109;-1982.771,1047.056;Inherit;False;909.7001;367.6367;x;5;114;110;115;112;113;X coordinate;1,0.1745283,0.1745283,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;-2048.304,1480.648;Inherit;False;1024.253;982.4688;y;14;149;151;148;152;174;167;150;147;107;104;103;105;106;178;Y coordinate;0.2085262,0.6226415,0.2436519,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-1442.786,595.2112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;113;-1886.665,1221.679;Inherit;False;96;_Theta;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;101;-1288.56,647.3268;Inherit;False;r;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;106;-1937.177,1627.185;Inherit;False;96;_Theta;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;115;-1730.9,1226.027;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;103;-1829.168,1530.648;Inherit;False;101;r;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;105;-1781.177,1629.185;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;112;-1778.657,1125.142;Inherit;False;101;r;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-1600.177,1586.185;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-780.5706,1249.202;Inherit;False;135;ThetaMax;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-833.715,1077.147;Inherit;False;Property;_XOffset;XOffset;1;0;Create;True;0;0;False;0;False;0;16.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;110;-1579.665,1181.679;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-862.6777,944.4261;Inherit;False;135;ThetaMax;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;107;-1219.173,1604.754;Inherit;False;y;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;131;-641.5353,924.7782;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;50;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-1324.859,1188.192;Inherit;False;x;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;183;-577.3103,1289.214;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;129;-585.7798,781.2987;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;118;-443.4672,1025.726;Inherit;False;107;y;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;-403.6034,880.4227;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-406.9233,779.7308;Inherit;False;114;x;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-401.2731,1171.805;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-20;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;127;-165.5886,823.1324;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;180;-258.761,1025.469;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;116;52.58691,894.9249;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;340.4651,923.0137;Inherit;False;VertexOffset;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;106.4793,-85.68242;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-1977.871,2092.416;Inherit;False;135;ThetaMax;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;144;133.7802,217.1848;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;137;68.10416,32.01474;Inherit;False;Property;_MainColor;MainColor;2;0;Create;True;0;0;False;0;False;1,1,1,1;1,0.6808246,0.1372549,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;397.8538,-66.65902;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1882.643,2304.901;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-1769.926,1966.301;Inherit;False;Property;_YOFfset;YOFfset;5;0;Create;True;0;0;False;0;False;0;12.81;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;172;-2039.773,890.749;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;51.83563,355.1616;Inherit;False;119;VertexOffset;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-1982.217,2178.182;Inherit;False;Property;_YOffset;YOffset;3;0;Create;True;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;149;-1738.853,2108.534;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;30;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;-1551.395,1855.432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;167;-1808.308,1889.44;Inherit;False;94;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;148;-1541.249,2098.671;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;152;-1357.277,2112.803;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-1805.479,877.1436;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;140;594.4914,66.83173;Float;False;True;-1;2;ASEMaterialInspector;0;0;Lambert;SpiralShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;163;0;153;0
WireConnection;154;0;163;0
WireConnection;89;1;154;0
WireConnection;90;0;89;1
WireConnection;124;0;90;0
WireConnection;94;0;124;0
WireConnection;135;0;91;0
WireConnection;92;0;135;0
WireConnection;92;2;95;0
WireConnection;165;0;164;0
WireConnection;96;0;92;0
WireConnection;162;0;165;0
WireConnection;162;4;99;0
WireConnection;100;0;98;0
WireConnection;100;1;162;0
WireConnection;101;0;100;0
WireConnection;115;0;113;0
WireConnection;105;0;106;0
WireConnection;104;0;103;0
WireConnection;104;1;105;0
WireConnection;110;0;112;0
WireConnection;110;1;115;0
WireConnection;107;0;104;0
WireConnection;131;0;136;0
WireConnection;131;4;130;0
WireConnection;114;0;110;0
WireConnection;183;0;182;0
WireConnection;128;0;129;0
WireConnection;128;1;131;0
WireConnection;181;0;162;0
WireConnection;181;1;183;0
WireConnection;127;0;117;0
WireConnection;127;1;128;0
WireConnection;180;0;118;0
WireConnection;180;1;181;0
WireConnection;116;0;127;0
WireConnection;116;1;180;0
WireConnection;119;0;116;0
WireConnection;146;1;145;0
WireConnection;149;0;151;0
WireConnection;149;4;150;0
WireConnection;178;0;167;0
WireConnection;178;1;174;0
WireConnection;148;0;149;0
WireConnection;148;1;147;0
WireConnection;152;1;148;0
WireConnection;171;0;99;0
WireConnection;171;1;172;0
WireConnection;140;0;137;0
WireConnection;140;3;144;0
WireConnection;140;4;144;0
WireConnection;140;11;120;0
ASEEND*/
//CHKSM=63918280F423E81FF2A201DF36A27DDA9B54A3C8