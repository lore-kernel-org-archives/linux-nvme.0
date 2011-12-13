From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Mon, 12 Dec 2011 17:38:47 -0800
Subject: TODO list 2011-12-09
In-Reply-To: <20111212204751.GL14291@linux.intel.com>
References: <20111209213740.GJ14291@linux.intel.com>
 <5AC4D6A45304E048A30F105EB302760902DD87A0@CORPEXCH1.na.ads.idt.com>
 <20111212204751.GL14291@linux.intel.com>
Message-ID: <5AC4D6A45304E048A30F105EB302760902DD8A8D@CORPEXCH1.na.ads.idt.com>

There is code in the driver to create devices for NS 1, 2, 3 ...N
already.  It seems to me that it is very easy to create a "controller"
device name with NS=0.  There is really no need to create new code to
create a character device.

i.e. use the same function nvme_alloc_ns() to create NS0 and hence
driver nvme0n0.
The device name becomes:

nvme0n0: controller
nvme0n1: NS 1
name0n2: NS 2
...
...
etc

I am ok with a character device "nvme0" or "nvme0n0" but why do it if a
block device works and the code is there already.

What do you think ?

-Kwok



-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com] 
Sent: Monday, December 12, 2011 12:48 PM
To: Kong, Kwok
Cc: linux-nvme at lists.infradead.org
Subject: Re: TODO list 2011-12-09

On Mon, Dec 12, 2011@10:59:24AM -0800, Kong, Kwok wrote:
> Mathew,
> 
> Regarding the character device for /dev/nvmeN, can we just create a 
> block device namespace 0 with 0 capacity ?
> Ie. nvme0n0.  

That doesn't feel very intuitive to me.  What would be the advantage?
