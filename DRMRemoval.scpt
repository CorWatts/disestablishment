FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
**	DRM Removal Script v2.0
**  
** PREREQUISITES:
** A CD-RW
** A PLAYLIST CONTAINING THE PROTECTED TRACKS YOU WISH TO REMOVE DRM FROM
**
** Summary:
** create a long list of playlists to burn, sourced from one master playlist
** -------- start loop ------------
** burn playlist to cd
** import cd
** diskutil eraseOptical <optical disk>
** iterate to next playlist
** -------- end loop -------------
** delete list of playlists


** INSTRUCTIONS:
** 1. insert the CD-RW
** 2. put all your protected music into a single playlist, note the name of the playlist
** 3. change the originalPlaylist variable to be the name of your playlist
** 4. make sure the CD-RW is mounted and open terminal --> enter "diskutil list".
** 5. find the device with a size of 0B (hopefully that will be your optical disk! make
**    sure!) and then enter the name of that device into the opticalDisk variable
**
**   you can change playlistNameBase to whatever you like, just make sure it has a 
**   completely unique name among your playlists


** NOTICE: this has been tested with OS X 10.6.8 and iTunes 10.4.1
** I have no idea what other versions it might work on. Be careful 
** when running this if your versions do not match up with mine.
*     � 	 		� 
 * * 	 D R M   R e m o v a l   S c r i p t   v 2 . 0 
 * *     
 * *   P R E R E Q U I S I T E S : 
 * *   A   C D - R W 
 * *   A   P L A Y L I S T   C O N T A I N I N G   T H E   P R O T E C T E D   T R A C K S   Y O U   W I S H   T O   R E M O V E   D R M   F R O M 
 * * 
 * *   S u m m a r y : 
 * *   c r e a t e   a   l o n g   l i s t   o f   p l a y l i s t s   t o   b u r n ,   s o u r c e d   f r o m   o n e   m a s t e r   p l a y l i s t 
 * *   - - - - - - - -   s t a r t   l o o p   - - - - - - - - - - - - 
 * *   b u r n   p l a y l i s t   t o   c d 
 * *   i m p o r t   c d 
 * *   d i s k u t i l   e r a s e O p t i c a l   < o p t i c a l   d i s k > 
 * *   i t e r a t e   t o   n e x t   p l a y l i s t 
 * *   - - - - - - - -   e n d   l o o p   - - - - - - - - - - - - - 
 * *   d e l e t e   l i s t   o f   p l a y l i s t s 
 
 
 * *   I N S T R U C T I O N S : 
 * *   1 .   i n s e r t   t h e   C D - R W 
 * *   2 .   p u t   a l l   y o u r   p r o t e c t e d   m u s i c   i n t o   a   s i n g l e   p l a y l i s t ,   n o t e   t h e   n a m e   o f   t h e   p l a y l i s t 
 * *   3 .   c h a n g e   t h e   o r i g i n a l P l a y l i s t   v a r i a b l e   t o   b e   t h e   n a m e   o f   y o u r   p l a y l i s t 
 * *   4 .   m a k e   s u r e   t h e   C D - R W   i s   m o u n t e d   a n d   o p e n   t e r m i n a l   - - >   e n t e r   " d i s k u t i l   l i s t " . 
 * *   5 .   f i n d   t h e   d e v i c e   w i t h   a   s i z e   o f   0 B   ( h o p e f u l l y   t h a t   w i l l   b e   y o u r   o p t i c a l   d i s k !   m a k e 
 * *         s u r e ! )   a n d   t h e n   e n t e r   t h e   n a m e   o f   t h a t   d e v i c e   i n t o   t h e   o p t i c a l D i s k   v a r i a b l e 
 * * 
 * *       y o u   c a n   c h a n g e   p l a y l i s t N a m e B a s e   t o   w h a t e v e r   y o u   l i k e ,   j u s t   m a k e   s u r e   i t   h a s   a   
 * *       c o m p l e t e l y   u n i q u e   n a m e   a m o n g   y o u r   p l a y l i s t s 
 
 
 * *   N O T I C E :   t h i s   h a s   b e e n   t e s t e d   w i t h   O S   X   1 0 . 6 . 8   a n d   i T u n e s   1 0 . 4 . 1 
 * *   I   h a v e   n o   i d e a   w h a t   o t h e r   v e r s i o n s   i t   m i g h t   w o r k   o n .   B e   c a r e f u l   
 * *   w h e n   r u n n i n g   t h i s   i f   y o u r   v e r s i o n s   d o   n o t   m a t c h   u p   w i t h   m i n e . 
 *   
  
 l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��      *** VARIABLES ***     �   $   * * *   V A R I A B L E S   * * *      l         r         m        �    a a a a a a  o      ���� $0 originalplaylist originalPlaylist  @ : playlist of all the songs you want to remove the DRM from     �     t   p l a y l i s t   o f   a l l   t h e   s o n g s   y o u   w a n t   t o   r e m o v e   t h e   D R M   f r o m   ! " ! l     �� # $��   # f ` this script increments from playlist to playlist, after finding the first auto created playlist    $ � % % �   t h i s   s c r i p t   i n c r e m e n t s   f r o m   p l a y l i s t   t o   p l a y l i s t ,   a f t e r   f i n d i n g   t h e   f i r s t   a u t o   c r e a t e d   p l a y l i s t "  & ' & l     �� ( )��   ( g a so make sure there aren't any "normal" playlists in the newly created block of playlists to burn    ) � * * �   s o   m a k e   s u r e   t h e r e   a r e n ' t   a n y   " n o r m a l "   p l a y l i s t s   i n   t h e   n e w l y   c r e a t e d   b l o c k   o f   p l a y l i s t s   t o   b u r n '  + , + l     �� - .��   - k e just having a unique name in playlistNameBase should probably be enough, but I'm just warning you ;)    . � / / �   j u s t   h a v i n g   a   u n i q u e   n a m e   i n   p l a y l i s t N a m e B a s e   s h o u l d   p r o b a b l y   b e   e n o u g h ,   b u t   I ' m   j u s t   w a r n i n g   y o u   ; ) ,  0 1 0 l    2 3 4 2 r     5 6 5 m     7 7 � 8 8  b u r n M e N O W 6 o      ���� $0 playlistnamebase playlistNameBase 3 3 - the base name of each newly created playlist    4 � 9 9 Z   t h e   b a s e   n a m e   o f   e a c h   n e w l y   c r e a t e d   p l a y l i s t 1  : ; : l    < = > < r     ? @ ? m    	����  @ o      ���� 0 playlistnum playlistNum = * $ the number we start incrementing at    > � A A H   t h e   n u m b e r   w e   s t a r t   i n c r e m e n t i n g   a t ;  B C B l    D E F D r     G H G m     I I � J J  / d e v / d i s k 1 H o      ���� 0 opticaldisk opticalDisk E _ Y to locate your optical disk: "diskutil list" **!! MAKE SURE YOU HAVE THE RIGHT DISK !!**    F � K K �   t o   l o c a t e   y o u r   o p t i c a l   d i s k :   " d i s k u t i l   l i s t "   * * ! !   M A K E   S U R E   Y O U   H A V E   T H E   R I G H T   D I S K   ! ! * * C  L M L l    N���� N r     O P O J    ����   P o      ���� 0 playlistlist playlistList��  ��   M  Q R Q l     ��������  ��  ��   R  S T S l     ��������  ��  ��   T  U V U l     �� W X��   W � | The following section was taken from http://www.mactech.com/articles/mactech/Vol.21/21.06/UserInterfaceScripting/index.html    X � Y Y �   T h e   f o l l o w i n g   s e c t i o n   w a s   t a k e n   f r o m   h t t p : / / w w w . m a c t e c h . c o m / a r t i c l e s / m a c t e c h / V o l . 2 1 / 2 1 . 0 6 / U s e r I n t e r f a c e S c r i p t i n g / i n d e x . h t m l V  Z [ Z l     �� \ ]��   \ n h this code block makes sure the "access for assistive devices" is enabled in sys prefs for GUI scripting    ] � ^ ^ �   t h i s   c o d e   b l o c k   m a k e s   s u r e   t h e   " a c c e s s   f o r   a s s i s t i v e   d e v i c e s "   i s   e n a b l e d   i n   s y s   p r e f s   f o r   G U I   s c r i p t i n g [  _ ` _ l    a���� a O    b c b r     d e d 1    ��
�� 
uien e o      ���� ,0 isuiscriptingenabled isUIScriptingEnabled c m     f f�                                                                                  sevs  alis    �  Macintosh HD               ɕ�pH+   _KSystem Events.app                                               |��7��        ����  	                CoreServices    ɖ�      �8'7     _K N N  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��   `  g h g l    H i���� i Z     H j k���� j =     # l m l o     !���� ,0 isuiscriptingenabled isUIScriptingEnabled m m   ! "��
�� boovfals k O   & D n o n k   * C p p  q r q I  * /������
�� .miscactvnull��� ��� null��  ��   r  s t s r   0 8 u v u 4   0 4�� w
�� 
xppb w m   2 3 x x � y y H c o m . a p p l e . p r e f e r e n c e . u n i v e r s a l a c c e s s v 1   4 7��
�� 
xpcp t  z { z I  9 @�� |��
�� .sysodlogaskr        TEXT | m   9 < } } � ~ ~r Y o u r   s y s t e m   i s   n o t   p r o p e r l y   c o n f i g u r e d   t o   r u n   t h i s   s c r i p t .     
                   P l e a s e   s e l e c t   t h e   " E n a b l e   a c c e s s   f o r   a s s i s t i v e   d e v i c e s "   
                   c h e c k b o x   a n d   t r i g g e r   t h e   s c r i p t   a g a i n   t o   p r o c e e d .��   {  ��  L   A C����  ��   o m   & ' � ��                                                                                  sprf  alis    |  Macintosh HD               ɕ�pH+    TSystem Preferences.app                                          v<�k�        ����  	                Applications    ɖ�      �kh      T  0Macintosh HD:Applications:System Preferences.app  .  S y s t e m   P r e f e r e n c e s . a p p    M a c i n t o s h   H D  #Applications/System Preferences.app   / ��  ��  ��  ��  ��   h  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � > 8 *******************************************************    � � � � p   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * �  � � � l     �� � ���   � Q K ***** this code block creates all the playlists we are going to burn *****    � � � � �   * * * * *   t h i s   c o d e   b l o c k   c r e a t e s   a l l   t h e   p l a y l i s t s   w e   a r e   g o i n g   t o   b u r n   * * * * * �  � � � l     �� � ���   � > 8 *******************************************************    � � � � p   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * �  � � � l  I L ����� � m   I L � � � � � * c r e a t i n g   p l a y l i s t s . . .��  ��   �  � � � l  M � ����� � O   M � � � � k   S � � �  � � � r   S X � � � o   S T���� 0 playlistnum playlistNum � o      ���� (0 playlistcurrentnum playlistCurrentNum �  ��� � X   Y � ��� � � k   v � � �  � � � r   v  � � � b   v { � � � o   v w���� $0 playlistnamebase playlistNameBase � o   w z���� (0 playlistcurrentnum playlistCurrentNum � o      ���� 0 playlistname playlistName �  � � � l  � ��� � ���   � P J we're gonna have to create each new playlist, if it doesn't already exist    � � � � �   w e ' r e   g o n n a   h a v e   t o   c r e a t e   e a c h   n e w   p l a y l i s t ,   i f   i t   d o e s n ' t   a l r e a d y   e x i s t �  � � � Z   � � � ����� � H   � � � � l  � � ����� � I  � ��� ���
�� .coredoexbool        obj  � 4   � ��� �
�� 
cUsP � o   � ����� 0 playlistname playlistName��  ��  ��   � k   � � � �  � � � I  � ����� �
�� .corecrel****      � null��   � �� � �
�� 
kocl � m   � ���
�� 
cUsP � �� ���
�� 
prdt � K   � � � � �� ���
�� 
pnam � o   � ����� 0 playlistname playlistName��  ��   �  ��� � r   � � � � � b   � � � � � o   � ����� 0 playlistlist playlistList � o   � ����� 0 playlistname playlistName � o      ���� 0 playlistlist playlistList��  ��  ��   �  � � � l  � ��� � ���   � U O make sure each playlist will fit onto a CD (max 80min == 4800s) but some songs    � � � � �   m a k e   s u r e   e a c h   p l a y l i s t   w i l l   f i t   o n t o   a   C D   ( m a x   8 0 m i n   = =   4 8 0 0 s )   b u t   s o m e   s o n g s �  � � � l  � ��� � ���   � 5 / are long, so use a lower number for fudge room    � � � � ^   a r e   l o n g ,   s o   u s e   a   l o w e r   n u m b e r   f o r   f u d g e   r o o m �  � � � l  � ��� � ���   � ^ X if you get error messages that the playlist won't fit on a single cd, lower this number    � � � � �   i f   y o u   g e t   e r r o r   m e s s a g e s   t h a t   t h e   p l a y l i s t   w o n ' t   f i t   o n   a   s i n g l e   c d ,   l o w e r   t h i s   n u m b e r �  ��� � Z   � � � ��� � � l  � � ����� � A  � � � � � n   � � � � � 1   � ���
�� 
pDur � 4   � ��� �
�� 
cUsP � o   � ����� 0 playlistname playlistName � m   � ��������  ��   � I  � ��� � �
�� .coreclon****      � **** � o   � ����� 0 atrack aTrack � �� ���
�� 
insh � 4   � ��� �
�� 
cUsP � o   � ����� 0 playlistname playlistName��  ��   � r   � � � � � [   � � � � � o   � ����� (0 playlistcurrentnum playlistCurrentNum � m   � �����  � o      ���� (0 playlistcurrentnum playlistCurrentNum��  �� 0 atrack aTrack � l  \ f ����� � n   \ f � � � 2  b f��
�� 
cFlT � 4   \ b�� �
�� 
cUsP � o   ` a���� $0 originalplaylist originalPlaylist��  ��  ��   � m   M P � ��                                                                                  hook  alis    L  Macintosh HD               ɕ�pH+    T
iTunes.app                                                       ���gT�        ����  	                Applications    ɖ�      �g�.      T  $Macintosh HD:Applications:iTunes.app   
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l  � � ����� � m   � � � � � � � " p l a y l i s t s   c r e a t e d��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � T N *****************************************************************************    � � � � �   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * �  � � � l     �� � ���   � ] W ******** GUI SCRIPTING PART (WARNING: EASILY BREAKABLE BY ITUNES UPDATES!!!) *********    � � � � �   * * * * * * * *   G U I   S C R I P T I N G   P A R T   ( W A R N I N G :   E A S I L Y   B R E A K A B L E   B Y   I T U N E S   U P D A T E S ! ! ! )   * * * * * * * * * �  �  � l     ��   T N *****************************************************************************    � �   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *   l     �~�~   j d ***** this code section searches for and burns each playlist, unmounts and remounts it (which *****    � �   * * * * *   t h i s   c o d e   s e c t i o n   s e a r c h e s   f o r   a n d   b u r n s   e a c h   p l a y l i s t ,   u n m o u n t s   a n d   r e m o u n t s   i t   ( w h i c h   * * * * * 	
	 l     �}�}   k e ***** automatically imports it again), wipes the CD-RW, increments the playlist num, and  starts ***    � �   * * * * *   a u t o m a t i c a l l y   i m p o r t s   i t   a g a i n ) ,   w i p e s   t h e   C D - R W ,   i n c r e m e n t s   t h e   p l a y l i s t   n u m ,   a n d     s t a r t s   * * *
  l     �|�|   4 . ***** over again 															 	     ******    � \   * * * * *   o v e r   a g a i n   	 	 	 	 	 	 	 	 	 	 	 	 	 	 	   	           * * * * * *  l     �{�{   T N *****************************************************************************    � �   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  l     �z�y�x�z  �y  �x    l  � ��w�v r   � � I  � ��u�t
�u .corecnte****       **** o   � ��s�s 0 playlistlist playlistList�t   o      �r�r 0 listsize listSize�w  �v    !  l  � �"�q�p" r   � �#$# o   � ��o�o 0 playlistnum playlistNum$ o      �n�n (0 currentplaylistnum currentPlaylistNum�q  �p  ! %&% l     �m�l�k�m  �l  �k  & '(' l     �j)*�j  ) : 4"starting at playlist location: " & playlistPosition   * �++ h " s t a r t i n g   a t   p l a y l i s t   l o c a t i o n :   "   &   p l a y l i s t P o s i t i o n( ,-, l     �i�h�g�i  �h  �g  - ./. l  ��0�f�e0 V   ��121 k  �33 454 r  676 b  898 o  �d�d $0 playlistnamebase playlistNameBase9 o  �c�c (0 currentplaylistnum currentPlaylistNum7 o      �b�b *0 currentplaylistname currentPlaylistName5 :;: b  <=< m  >> �?? $ b u r n i n g   p l a y l i s t :  = o  �a�a *0 currentplaylistname currentPlaylistName; @A@ l �`�_�^�`  �_  �^  A BCB I $�]D�\
�] .miscactvnull��� ��� nullD m   EE�                                                                                  hook  alis    L  Macintosh HD               ɕ�pH+    T
iTunes.app                                                       ���gT�        ����  	                Applications    ɖ�      �g�.      T  $Macintosh HD:Applications:iTunes.app   
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  �\  C F�[F O  %�GHG O  )�IJI k  4�KK LML l 44�Z�Y�X�Z  �Y  �X  M NON l 44�WPQ�W  P 1 + determine the location of playlist to burn   Q �RR V   d e t e r m i n e   t h e   l o c a t i o n   o f   p l a y l i s t   t o   b u r nO STS r  49UVU m  45�V�V V o      �U�U 0 x  T WXW T  :�YY k  ?}ZZ [\[ Z  ?s]^�T�S] I ?c�R_�Q
�R .coredoexbool        obj _ n  ?_`a` 4  X_�Pb
�P 
sttxb o  [^�O�O *0 currentplaylistname currentPlaylistNamea n  ?Xcdc 4  QX�Ne
�N 
crowe o  TW�M�M 0 x  d n  ?Qfgf 4  LQ�Lh
�L 
outlh m  OP�K�K g n  ?Liji 4  GL�Jk
�J 
scrak m  JK�I�I j 4  ?G�Hl
�H 
cwinl m  CFmm �nn  i T u n e s�Q  ^ k  fooo pqp r  fmrsr o  fi�G�G 0 x  s o      �F�F 20 currentplaylistposition currentPlaylistPositionq t�Et  S  no�E  �T  �S  \ u�Du r  t}vwv [  tyxyx o  tw�C�C 0 x  y m  wx�B�B w o      �A�A 0 x  �D  X z{z l ���@�?�>�@  �?  �>  { |}| I ���=~�<
�= .miscslctuiel       uiel~ n  ��� 4  ���;�
�; 
crow� o  ���:�: 20 currentplaylistposition currentPlaylistPosition� n  ����� 4  ���9�
�9 
outl� m  ���8�8 � n  ����� 4  ���7�
�7 
scra� m  ���6�6 � 4  ���5�
�5 
cwin� m  ���� ���  i T u n e s�<  } ��� I ���4��3
�4 .prcsclicuiel    ��� uiel� n  ����� 4  ���2�
�2 
menI� m  ���1�1 	� n  ����� 4  ���0�
�0 
menE� m  ���/�/ � n  ����� 4  ���.�
�. 
mbri� m  ���� ���  F i l e� 4  ���-�
�- 
mbar� m  ���,�, �3  � ��� l ���+�*�)�+  �*  �)  � ��� l ���(���(  � %  wait until burn window pops up   � ��� >   w a i t   u n t i l   b u r n   w i n d o w   p o p s   u p� ��� V  ����� I ���'��&
�' .sysodelanull��� ��� nmbr� m  ���� ?�      �&  � H  ���� l ����%�$� I ���#��"
�# .coredoexbool        obj � n  ����� 4  ���!�
�! 
sttx� m  ���� ���  D i s c   B u r n e r :� 4  ��� �
�  
cwin� m  ���� ���  B u r n   S e t t i n g s�"  �%  �$  � ��� l ������  �  �  � ��� I �����
� .miscslctuiel       uiel� 4  ����
� 
cwin� m  ���� ���  B u r n   S e t t i n g s�  � ��� I ����
� .prcsclicuiel    ��� uiel� n  ���� 4  ���
� 
butT� m  � �� ���  B u r n� 4  ����
� 
cwin� m  ���� ���  B u r n   S e t t i n g s�  � ��� l ����  �  �  � ��� m  	�� ���  b u r n i n g   c d . . .� ��� l 

����  �  �  � ��� l 

����  � 3 - don't progress until the burning is finished   � ��� Z   d o n ' t   p r o g r e s s   u n t i l   t h e   b u r n i n g   i s   f i n i s h e d� ��� O  
/��� V  .��� I ")���
� .sysodelanull��� ��� nmbr� m  "%�� ?�      �  � H  !�� l  ���� I  �
��	
�
 .coredoexbool        obj � 4  ��
� 
cSrc� o  �� *0 currentplaylistname currentPlaylistName�	  �  �  � m  
���                                                                                  hook  alis    L  Macintosh HD               ɕ�pH+    T
iTunes.app                                                       ���gT�        ����  	                Applications    ɖ�      �g�.      T  $Macintosh HD:Applications:iTunes.app   
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  � ��� l 00����  �  �  � ��� m  03�� ���  i m p o r t i n g   c d . . .� ��� l 44����  �   import the audio cd   � ��� (   i m p o r t   t h e   a u d i o   c d� ��� O  4p��� X  :o���� Q  Yj���� I \a� ���
�  .hookConvcTrk      @ obj � o  \]���� 0 	thistrack 	thisTrack��  � R      ������
�� .ascrerr ****      � ****��  ��  �  � 0 	thistrack 	thisTrack� n  =I��� 2  EI��
�� 
cCDT� 4  =E���
�� 
cSrc� o  AD���� *0 currentplaylistname currentPlaylistName� m  47���                                                                                  hook  alis    L  Macintosh HD               ɕ�pH+    T
iTunes.app                                                       ���gT�        ����  	                Applications    ɖ�      �g�.      T  $Macintosh HD:Applications:iTunes.app   
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  � ��� l qq��������  ��  ��  � ��� m  qt�� ��� . e r a s i n g   o p t i c a l   d i s k . . .� ��� I u~�����
�� .sysoexecTEXT���     TEXT� l uz ����  b  uz m  ux � @ / u s r / s b i n / d i s k u t i l   e r a s e O p t i c a l   o  xy���� 0 opticaldisk opticalDisk��  ��  ��  �  l ��������  ��  ��    l ��	
��  	 &   hit "OK" when the new cd mounts   
 � @   h i t   " O K "   w h e n   t h e   n e w   c d   m o u n t s  O  � O  �� k  ��  V  �� I ������
�� .sysodelanull��� ��� nmbr m  �� ?���������   H  �� l ������ I ������
�� .coredoexbool        obj  n  �� 4  ����
�� 
sttx m  �� �   � Y o u   i n s e r t e d   a   b l a n k   C D .   C h o o s e   a n   a c t i o n   f r o m   t h e   p o p - u p   m e n u   o r   c l i c k   I g n o r e . 4  ����!
�� 
cwin! m  ������ ��  ��  ��   "��" I ����#��
�� .prcsclicuiel    ��� uiel# n  ��$%$ 4  ����&
�� 
butT& m  ��'' �((  O K% 4  ����)
�� 
cwin) m  ������ ��  ��   4  ����*
�� 
prcs* m  ��++ �,,  S y s t e m U I S e r v e r m  �--�                                                                                  sevs  alis    �  Macintosh HD               ɕ�pH+   _KSystem Events.app                                               |��7��        ����  	                CoreServices    ɖ�      �8'7     _K N N  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��   ./. l ����������  ��  ��  / 010 m  ��22 �33 ` i n c r e m e n t i n g   p l a y l i s t   a n d   s t a r t i n g   l o o p   a g a i n . . .1 4��4 r  ��565 [  ��787 o  ������ (0 currentplaylistnum currentPlaylistNum8 m  ������ 6 o      ���� (0 currentplaylistnum currentPlaylistNum��  J 4  )1��9
�� 
prcs9 m  -0:: �;;  i T u n e sH m  %&<<�                                                                                  sevs  alis    �  Macintosh HD               ɕ�pH+   _KSystem Events.app                                               |��7��        ����  	                CoreServices    ɖ�      �8'7     _K N N  :Macintosh HD:System:Library:CoreServices:System Events.app  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �[  2 B  
=>= o  ���� (0 currentplaylistnum currentPlaylistNum> o  	���� 0 listsize listSize�f  �e  / ?@? l     ��������  ��  ��  @ ABA l     ��������  ��  ��  B CDC l     ��EF��  E F @ ***************************************************************   F �GG �   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *D HIH l     ��JK��  J [ U ****** this code block deletes all the previously created temporary playlists ******   K �LL �   * * * * * *   t h i s   c o d e   b l o c k   d e l e t e s   a l l   t h e   p r e v i o u s l y   c r e a t e d   t e m p o r a r y   p l a y l i s t s   * * * * * *I MNM l     ��OP��  O F @ ***************************************************************   P �QQ �   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *N R��R l �S����S O  �TUT X  �V��WV I ����X��
�� .coredelonull���    obj X 4  ����Y
�� 
cUsPY o  ������ *0 theplaylisttodelete thePlaylistToDelete��  �� *0 theplaylisttodelete thePlaylistToDeleteW o  ������ 0 playlistlist playlistListU m  ��ZZ�                                                                                  hook  alis    L  Macintosh HD               ɕ�pH+    T
iTunes.app                                                       ���gT�        ����  	                Applications    ɖ�      �g�.      T  $Macintosh HD:Applications:iTunes.app   
 i T u n e s . a p p    M a c i n t o s h   H D  Applications/iTunes.app   / ��  ��  ��  ��       ��[\��  [ ��
�� .aevtoappnull  �   � ****\ ��]����^_��
�� .aevtoappnull  �   � ****] k    ``  aa  0bb  :cc  Bdd  Lee  _ff  ggg  �hh  �ii  �jj kk  ll .mm R����  ��  ��  ^ �������� 0 atrack aTrack�� 0 	thistrack 	thisTrack�� *0 theplaylisttodelete thePlaylistToDelete_ T �� 7���� I���� f���� ����� x�� }�� � ��������������������������������� �������>��:����m���������������������������������������������������+'2���� $0 originalplaylist originalPlaylist�� $0 playlistnamebase playlistNameBase�� 0 playlistnum playlistNum�� 0 opticaldisk opticalDisk�� 0 playlistlist playlistList
�� 
uien�� ,0 isuiscriptingenabled isUIScriptingEnabled
�� .miscactvnull��� ��� null
�� 
xppb
�� 
xpcp
�� .sysodlogaskr        TEXT�� (0 playlistcurrentnum playlistCurrentNum
�� 
cUsP
�� 
cFlT
�� 
kocl
�� 
cobj
�� .corecnte****       ****�� 0 playlistname playlistName
�� .coredoexbool        obj 
�� 
prdt
�� 
pnam�� 
�� .corecrel****      � null
�� 
pDur���
�� 
insh
�� .coreclon****      � ****�� 0 listsize listSize�� (0 currentplaylistnum currentPlaylistNum�� *0 currentplaylistname currentPlaylistName
�� 
prcs�� 0 x  
�� 
cwin
�� 
scra
�� 
outl
�� 
crow
�� 
sttx�� 20 currentplaylistposition currentPlaylistPosition
�� .miscslctuiel       uiel
�� 
mbar
�� 
mbri
�� 
menE
�� 
menI�� 	
�� .prcsclicuiel    ��� uiel
�� .sysodelanull��� ��� nmbr
�� 
butT
�� 
cSrc
�� 
cCDT
�� .hookConvcTrk      @ obj ��  ��  
�� .sysoexecTEXT���     TEXT
�� .coredelonull���    obj ���E�O�E�OkE�O�E�OjvE�O� *�,E�UO�f  #� *j O*��/*�,FOa j OhUY hOa Oa  ��E` O �*a �/a -[a a l kh  �_ %E` O*a _ /j  %*a a a a _ la  O�_ %E�Y hO*a _ /a  ,a ! �a "*a _ /l #Y _ kE` [OY��UOa $O�j E` %O�E` &O�h_ &_ %�_ &%E` 'Oa (_ '%Oa j O��*a )a */�kE` +O GhZ*a ,a -/a .l/a /k/a 0_ +/a 1_ '/j  _ +E` 2OY hO_ +kE` +[OY��O*a ,a 3/a .l/a /k/a 0_ 2/j 4O*a 5k/a 6a 7/a 8k/a 9a :/j ;O $h*a ,a </a 1a =/j a >j ?[OY��O*a ,a @/j 4O*a ,a A/a Ba C/j ;Oa DOa    h*a E_ '/j a >j ?[OY��UOa FOa  7 4*a E_ '/a G-[a a l kh  
�j HW X I Jh[OY��UOa KOa L�%j MO� C*a )a N/ 7 "h*a ,k/a 1a O/j a Pj ?[OY��O*a ,k/a Ba Q/j ;UUOa RO_ &kE` &UU[OY�+Oa  % "�[a a l kh *a �/j S[OY��U ascr  ��ޭ