From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 24 Mar 2014 09:11:04 -0400
Subject: [PATCH v2] NVMe: silence GCC warning on 32 bit
In-Reply-To: <1393925767.3038.23.camel@x220>
References: <1392714172-2712-1-git-send-email-geert@linux-m68k.org>
 <1392934261.15264.22.camel@x220>
 <alpine.LRH.2.03.1402210921010.4656@AMR>
 <1393925767.3038.23.camel@x220>
Message-ID: <20140324131104.GC5777@linux.intel.com>

On Tue, Mar 04, 2014@10:36:07AM +0100, Paul Bolle wrote:
> Also note that it's actually not clear to me why these warnings only
> trigger on 32 bit. I guess there's some int/long conversion lurking
> somewhere. I haven't found it. 

I bet you're using a different revision of the compiler on 32 and 64 bit.
Different gcc revisions have different abilities to track initialisation.
