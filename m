From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 12 Dec 2011 15:47:51 -0500
Subject: TODO list 2011-12-09
In-Reply-To: <5AC4D6A45304E048A30F105EB302760902DD87A0@CORPEXCH1.na.ads.idt.com>
References: <20111209213740.GJ14291@linux.intel.com>
 <5AC4D6A45304E048A30F105EB302760902DD87A0@CORPEXCH1.na.ads.idt.com>
Message-ID: <20111212204751.GL14291@linux.intel.com>

On Mon, Dec 12, 2011@10:59:24AM -0800, Kong, Kwok wrote:
> Mathew,
> 
> Regarding the character device for /dev/nvmeN, can we just create a
> block device namespace 0 with 0 capacity ?
> Ie. nvme0n0.  

That doesn't feel very intuitive to me.  What would be the advantage?
