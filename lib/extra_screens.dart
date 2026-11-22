import 'package:flutter/material.dart';
import 'main.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});
  @override State<IntroScreen> createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen> {
  int page=0;
  static const headings=['A Beautiful Beginning','Meaningful Connections','Your Nikah Journey'];
  static const captions=['Discover compatible partners with dignity and respect.','Privacy, intentions and family values come first.','Take the next step at your own pace.'];
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Padding(padding:const EdgeInsets.all(25),child:Column(children:[
    Align(alignment:Alignment.centerRight,child:TextButton(onPressed:()=>Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const AuthScreen())),child:const Text('Skip',style:TextStyle(color:gold)))),
    const Spacer(),Container(width:210,height:230,decoration:BoxDecoration(borderRadius:BorderRadius.circular(110),gradient:const LinearGradient(colors:[cream,Color(0xFFE2BA71)])),child:Icon([Icons.mosque,Icons.favorite_border,Icons.diversity_1][page],size:100,color:dark)),
    const SizedBox(height:35),Text(headings[page],textAlign:TextAlign.center,style:const TextStyle(fontFamily:'serif',fontSize:31,fontWeight:FontWeight.bold,color:dark)),
    const SizedBox(height:12),Text(captions[page],textAlign:TextAlign.center,style:const TextStyle(color:dark,fontSize:15)),
    const Spacer(),Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(3,(i)=>Container(margin:const EdgeInsets.all(4),width:i==page?24:8,height:8,decoration:BoxDecoration(color:i==page?gold:cream,borderRadius:BorderRadius.circular(8))))),
    const SizedBox(height:22),GoldButton(text:page==2?'Continue to ZuMatch':'Next →',onPressed:(){if(page==2){Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>const AuthScreen()));}else{setState(()=>page++);}}),
    const SizedBox(height:22)
  ]))));
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override State<AuthScreen> createState()=>_AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen>{
  bool register=false,obscure=true;
  final email=TextEditingController(),password=TextEditingController();
  @override void dispose(){email.dispose();password.dispose();super.dispose();}
  @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:SingleChildScrollView(padding:const EdgeInsets.all(25),child:Column(crossAxisAlignment:CrossAxisAlignment.stretch,children:[
    const SizedBox(height:30),const Icon(Icons.favorite,color:gold,size:55),
    const Text('ZuMatch',textAlign:TextAlign.center,style:TextStyle(fontFamily:'serif',fontSize:43,fontWeight:FontWeight.bold,color:dark)),
    const Text('MUSLIM MATRIMONY',textAlign:TextAlign.center,style:TextStyle(letterSpacing:2,color:gold)),
    const SizedBox(height:45),Text(register?'Create Your Account':'Welcome Back',style:const TextStyle(fontFamily:'serif',fontSize:29,fontWeight:FontWeight.bold,color:dark)),
    const SizedBox(height:20),if(register)...[field('Full Name',Icons.person_outline),const SizedBox(height:12)],
    TextField(controller:email,keyboardType:TextInputType.emailAddress,decoration:decor('Email Address',Icons.email_outlined)),
    const SizedBox(height:12),TextField(controller:password,obscureText:obscure,decoration:decor('Password',Icons.lock_outline).copyWith(suffixIcon:IconButton(onPressed:()=>setState(()=>obscure=!obscure),icon:Icon(obscure?Icons.visibility_outlined:Icons.visibility_off_outlined)))),
    if(register)...[const SizedBox(height:12),field('City / Location',Icons.location_on_outlined)],
    const SizedBox(height:18),GoldButton(text:register?'Create Account':'Login',onPressed:()=>showDialog(context:context,builder:(_)=>const AlertDialog(title:Text('Backend integration pending'),content:Text('Authentication and OTP will work after the secure backend is connected.')))),
    const SizedBox(height:12),TextButton(onPressed:()=>setState(()=>register=!register),child:Text(register?'Already registered? Login':'New here? Create an account',style:const TextStyle(color:gold))),
    TextButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const MainScreen())),child:const Text('Preview UI without signing in →',style:TextStyle(color:dark))),
    const SizedBox(height:25),const Text('Your privacy and consent matter.',textAlign:TextAlign.center,style:TextStyle(color:gold))
  ]))));
}
InputDecoration decor(String label,IconData icon)=>InputDecoration(labelText:label,prefixIcon:Icon(icon,color:gold),filled:true,fillColor:Colors.white,border:OutlineInputBorder(borderRadius:BorderRadius.circular(14),borderSide:const BorderSide(color:cream)));
Widget field(String label,IconData icon)=>TextField(decoration:decor(label,icon));

class FiltersScreen extends StatefulWidget{
  const FiltersScreen({super.key});
  @override State<FiltersScreen> createState()=>_FiltersScreenState();
}
class _FiltersScreenState extends State<FiltersScreen>{
  RangeValues ages=const RangeValues(21,32);String city='Any City',education='Any Education',marital='Any Status';
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Advanced Filters')),body:SafeArea(child:ListView(padding:const EdgeInsets.all(20),children:[
    const Text('Preferred Age Range',style:TextStyle(fontWeight:FontWeight.bold,fontSize:17,color:dark)),
    Text('${ages.start.round()} – ${ages.end.round()} years',style:const TextStyle(color:gold)),
    RangeSlider(values:ages,min:18,max:60,divisions:42,activeColor:gold,onChanged:(v)=>setState(()=>ages=v)),
    pick('Location',city,['Any City','Delhi','Lucknow','Mumbai','Hyderabad','Bengaluru'],(v)=>setState(()=>city=v)),
    pick('Education',education,['Any Education','Graduate','Postgraduate','Professional','Other'],(v)=>setState(()=>education=v)),
    pick('Marital Status',marital,['Any Status','Never Married','Divorced','Widowed'],(v)=>setState(()=>marital=v)),
    const SizedBox(height:30),GoldButton(text:'Show Matches',onPressed:()=>Navigator.pop(context)),
    const SizedBox(height:10),const Text('Filter UI preview. Live filtering will be enabled with the backend.',textAlign:TextAlign.center,style:TextStyle(color:gold,fontSize:12))
  ])));
  Widget pick(String label,String value,List<String> items,ValueChanged<String> changed)=>Padding(padding:const EdgeInsets.symmetric(vertical:9),child:DropdownButtonFormField<String>(initialValue:value,decoration:decor(label,Icons.tune),items:items.map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v){if(v!=null)changed(v);}));
}

class InterestScreen extends StatelessWidget{
  const InterestScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:ListView(padding:const EdgeInsets.all(18),children:[
    const Text('Interest Requests',style:TextStyle(fontFamily:'serif',fontWeight:FontWeight.bold,fontSize:27,color:dark)),
    const SizedBox(height:12),const Text('Manage your connections respectfully.',style:TextStyle(color:dark)),
    const SizedBox(height:20),const EmptyState(icon:Icons.favorite_outline,title:'No requests yet',subtitle:'Your sent and received interests will appear here.')
  ]));
}
class MessagesScreen extends StatelessWidget{
  const MessagesScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:ListView(padding:const EdgeInsets.all(18),children:[
    const Text('Messages',style:TextStyle(fontFamily:'serif',fontWeight:FontWeight.bold,fontSize:27,color:dark)),
    const SizedBox(height:15),TextField(decoration:decor('Search conversations',Icons.search)),
    const SizedBox(height:22),const EmptyState(icon:Icons.chat_bubble_outline,title:'Start a meaningful conversation',subtitle:'Chats will be available after mutual interest and account verification.'),
    const SizedBox(height:18),OutlinedButton(onPressed:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const ChatPreviewScreen())),child:const Text('View Chat Design Preview',style:TextStyle(color:gold)))
  ]));
}
class ChatPreviewScreen extends StatelessWidget{
  const ChatPreviewScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Conversation Preview')),body:SafeArea(child:Column(children:[
    const Padding(padding:EdgeInsets.all(12),child:Text('Sample messages only • No real conversation',style:TextStyle(color:gold))),
    Expanded(child:ListView(padding:const EdgeInsets.all(16),children:[
      bubble('Assalamu Alaikum! Thank you for your interest.',false),
      bubble('Wa Alaikum Assalam. It is a pleasure to connect.',true),
      bubble('Would you like to discuss our family expectations?',false),
      bubble('Of course, In sha Allah.',true)
    ])),
    Padding(padding:const EdgeInsets.all(12),child:TextField(readOnly:true,onTap:()=>showDialog(context:context,builder:(_)=>const AlertDialog(content:Text('Live chat will be enabled after backend integration.'))),decoration:decor('Type a message...',Icons.emoji_emotions_outlined).copyWith(suffixIcon:const Icon(Icons.send,color:gold))))
  ])));
  Widget bubble(String msg,bool mine)=>Align(alignment:mine?Alignment.centerRight:Alignment.centerLeft,child:Container(constraints:const BoxConstraints(maxWidth:270),margin:const EdgeInsets.symmetric(vertical:7),padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:mine?const Color(0xFFF2D396):Colors.white,borderRadius:BorderRadius.circular(17)),child:Text(msg,style:const TextStyle(color:dark))));
}
class PremiumScreen extends StatelessWidget{
  const PremiumScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('ZuMatch Premium')),body:ListView(padding:const EdgeInsets.all(20),children:[
    const Icon(Icons.workspace_premium,color:gold,size:76),const SizedBox(height:12),
    const Text('Go Premium',textAlign:TextAlign.center,style:TextStyle(fontFamily:'serif',fontSize:34,fontWeight:FontWeight.bold,color:dark)),
    const Text('Unlock more meaningful connections',textAlign:TextAlign.center,style:TextStyle(color:dark)),
    const SizedBox(height:24),
    ...['See who viewed your profile','Advanced search and filters','Priority profile visibility','More interest requests','Enhanced privacy options'].map((s)=>Card(color:Colors.white,child:ListTile(leading:const Icon(Icons.check_circle,color:gold),title:Text(s)))),
    const SizedBox(height:24),
    const Text('Membership options',style:TextStyle(fontSize:21,fontWeight:FontWeight.bold,color:dark)),
    const SizedBox(height:12),...['3 Months','6 Months','12 Months'].map((p)=>Card(color:cream,child:ListTile(title:Text(p),subtitle:const Text('Pricing to be announced'),trailing:const Icon(Icons.arrow_forward_ios,color:gold,size:16)))),
    const SizedBox(height:18),GoldButton(text:'Membership Coming Soon',onPressed:()=>showDialog(context:context,builder:(_)=>const AlertDialog(content:Text('Payments are not enabled in this UI preview.'))))
  ]));
}
class MyProfileScreen extends StatelessWidget{
  const MyProfileScreen({super.key});
  @override Widget build(BuildContext context)=>Scaffold(body:ListView(padding:const EdgeInsets.all(18),children:[
    const Center(child:CircleAvatar(radius:48,backgroundColor:cream,child:Icon(Icons.person_outline,color:gold,size:50))),
    const SizedBox(height:14),const Text('Your Profile',textAlign:TextAlign.center,style:TextStyle(fontFamily:'serif',fontSize:28,fontWeight:FontWeight.bold,color:dark)),
    const Text('Preview Mode',textAlign:TextAlign.center,style:TextStyle(color:gold)),
    const SizedBox(height:22),
    ...[('Edit Profile',Icons.edit_outlined),('Privacy Settings',Icons.lock_outline),('Family / Wali',Icons.people_outline),('Verification',Icons.verified_user_outlined),('Membership',Icons.workspace_premium_outlined),('Help & Support',Icons.help_outline)].map((e)=>Card(color:Colors.white,child:ListTile(leading:Icon(e.$2,color:gold),title:Text(e.$1),trailing:const Icon(Icons.chevron_right),onTap:()=>e.$1=='Membership'?Navigator.push(context,MaterialPageRoute(builder:(_)=>const PremiumScreen())):showDialog(context:context,builder:(_)=>AlertDialog(title:Text(e.$1),content:const Text('This feature will be connected in the next development phase.')))))),
  ]));
}
class EmptyState extends StatelessWidget{
  final IconData icon;final String title,subtitle;
  const EmptyState({super.key,required this.icon,required this.title,required this.subtitle});
  @override Widget build(BuildContext context)=>Padding(padding:const EdgeInsets.symmetric(vertical:65,horizontal:20),child:Column(children:[Icon(icon,size:65,color:gold),const SizedBox(height:18),Text(title,textAlign:TextAlign.center,style:const TextStyle(fontFamily:'serif',fontSize:23,fontWeight:FontWeight.bold,color:dark)),const SizedBox(height:9),Text(subtitle,textAlign:TextAlign.center,style:const TextStyle(color:dark))]));
}
