From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 21 Feb 2017 16:03:09 -0700
Subject: [PATCHv4 4/4] block/sed: Embed function data into the function
 sequence
In-Reply-To: <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
References: <1487703556-19913-1-git-send-email-jonathan.derrick@intel.com>
 <1487703556-19913-5-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20170221230308.GA3311@sbauer-Z170X-UD5>

On Tue, Feb 21, 2017@11:59:16AM -0700, Jon Derrick wrote:
> By embedding the function data with the function sequence, we can
> eliminate the external function data and state variable code. It also
> made obvious some other small cleanups.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
Reviewed-by: Scott Bauer <scott.bauer at intel.com>

Also Christoph had reviewed-by on 1-3 on friday, I dont think we need a respin,
but wanted to point that out since his tag isnt on 1-3 v4:
https://marc.info/?l=linux-block&m=148725565212351&w=2
https://marc.info/?l=linux-block&m=148725603312475&w=2
https://marc.info/?l=linuxppc-embedded&m=148725612212503&w=2
