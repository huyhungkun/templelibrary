/*
 *	Temple Library for ActionScript 3.0
 *	Copyright © MediaMonks B.V.
 *	All rights reserved.
 *	
 *	Redistribution and use in source and binary forms, with or without
 *	modification, are permitted provided that the following conditions are met:
 *	1. Redistributions of source code must retain the above copyright
 *	   notice, this list of conditions and the following disclaimer.
 *	2. Redistributions in binary form must reproduce the above copyright
 *	   notice, this list of conditions and the following disclaimer in the
 *	   documentation and/or other materials provided with the distribution.
 *	3. All advertising materials mentioning features or use of this software
 *	   must display the following acknowledgement:
 *	   This product includes software developed by MediaMonks B.V.
 *	4. Neither the name of MediaMonks B.V. nor the
 *	   names of its contributors may be used to endorse or promote products
 *	   derived from this software without specific prior written permission.
 *	
 *	THIS SOFTWARE IS PROVIDED BY MEDIAMONKS B.V. ''AS IS'' AND ANY
 *	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 *	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 *	DISCLAIMED. IN NO EVENT SHALL MEDIAMONKS B.V. BE LIABLE FOR ANY
 *	DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 *	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 *	ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *	
 *	
 *	Note: This license does not apply to 3rd party classes inside the Temple
 *	repository with their own license!
 */

package temple.codecomponents.players.controls
{
	import temple.codecomponents.graphics.CodeGraphicsRectangle;
	import temple.codecomponents.style.CodeStyle;
	import temple.mediaplayers.players.IPlayer;
	import temple.mediaplayers.players.controls.PlayerProgressBar;

	/**
	 * @author Thijs Broerse
	 */
	public class CodePlayerProgressBar extends PlayerProgressBar
	{
		public function CodePlayerProgressBar(player:IPlayer = null, width:Number = 400, height:Number = 10)
		{
			super(width, height);
			construct::codePlayerProgressBar(player, width, height);
		}
		
		/**
		 * @private
		 */
		construct function codePlayerProgressBar(player:IPlayer, width:Number, height:Number):void
		{
			this.background = true;
			this.backgroundAlpha = .3;
			this.backgroundColor = 0xFFFFFF;
			
			this.loadBar = this.addChild(new CodeGraphicsRectangle(width, height, CodeStyle.backgroundColor, .5));
			this.progressBar = this.addChild(new CodeGraphicsRectangle(width, height - 4, CodeStyle.backgroundColor, .8));
			this.progressBar.y = 2;
			this.filters = CodeStyle.backgroundFilters;
			this.player = player;
		}
	}
}