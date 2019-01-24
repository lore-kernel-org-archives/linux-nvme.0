From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Jan 2019 15:21:27 -0700
Subject: 2016 Changes to nvme.h
In-Reply-To: <75a8b8ac-fa85-39c8-0da6-cc7629422d00@panasas.com>
References: <e20019ce-6f8d-1c1c-a93c-aba61ce5cf3c@panasas.com>
 <20190124172158.GA9600@localhost.localdomain>
 <75a8b8ac-fa85-39c8-0da6-cc7629422d00@panasas.com>
Message-ID: <20190124222127.GA9925@localhost.localdomain>

On Thu, Jan 24, 2019@09:38:11PM +0000, Wilson, Ellis wrote:
> Thank you for the response.  I think I understand the intent now.  Your 
> comment about a userspace library makes total sense.  I still disagree 
> with one thing.  You say, "it is just not a good idea to rely on the 
> kernel to own updating the structures when the kernel has no internal 
> need for it."  And yet, those very structures were moved further 
> /inside/, rather than being deleted wholesale, so the action doesn't 
> quite match up with your explanation from what I can tell.

We do have in-kernel uses for nvme structures, hence the relocation to
an internal definition. We just don't want to export it for user space,
which would (and did) create undue maintenance to non-kernel usage.
