From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Oct 2016 13:44:21 -0400
Subject: Weirdness with discard cmd and get log pages
In-Reply-To: <20161013231808.GG17823@localhost.localdomain>
References: <CAG3=cOkxyNq3heevOOpOMcezTsEktPfsoWAEVjWdTA28KgVwAg@mail.gmail.com>
 <20161013161519.GE17823@localhost.localdomain>
 <CAG3=cOmGVdQXDvNuzeW2hgfYi7nASGvfgirU__hE5VJnSWue4w@mail.gmail.com>
 <20161013231808.GG17823@localhost.localdomain>
Message-ID: <20161014174421.GB19383@localhost.localdomain>

On Thu, Oct 13, 2016@07:18:09PM -0400, Keith Busch wrote:
> On Thu, Oct 13, 2016@11:18:43AM -0700, Nisha Miller wrote:
> > Yes, that is what I noticed too. I used the nvme-cli command like this:
> > 
> > nvme dsm /dev/nvme0n1 -a 0,0,0,0 --blocks=4,5,6,7 --slbs=100,200,300,400 --ad
> > 
> > This turns up as nvme_user_cmd in the driver, which calls
> > nvme_map_user_pages to setup the SG list.
> 
> Okay, that's what I use too. I'm not observing any issues on a 4.8 kernel
> or back to 4.4 either. I've not tested 3.19 though, and the mechanism
> it uses to map user buffers is completely different. Could you verify if
> your observation exists in a more current stable release?

Just for reference, this is how I've verified 64 ranges. My device
deterministically returns 0 on any deallocated block, and is formatted
with 512b LBAs. 

  # create a random 1MB file
  dd if=/dev/urandom of=~/rand.1M.in bs=1M count=1

  # write it to the device
  dd if=~/rand.1M.in of=/dev/nvme0n1 oflag=direct

  # read it back out
  dd if=/dev/nvme0n1 of=~/rand.1M.out bs=1M count=1 iflag=direct

  # compare the two to verify they're the same
  diff ~/rand.1M.in ~/rand.1M.out

  # write a bunch of 0-filled 8k holes in the original file
  for i in $(seq 0 2 127); do dd if=/dev/zero of=~/rand.1M.in bs=8k seek=$i conv=notrunc count=1 2> /dev/null; done

  # deallocate the exact same ranges as the file's new 0-filled holes 
  nvme dsm /dev/nvme0n1 -d --slbs=`seq 0 32 2016 | tr "\n" "," | sed "s/,$//g"` --blocks=`printf "16,%0.s" {0..63} | sed "s/,$//g"`

  # read the file from the device
  dd if=/dev/nvme0n1 of=~/rand.1M.out bs=1M count=1 iflag=direct

  # verify the contents are still the same
  diff ~/rand.1M.in ~/rand.1M.out

Works for me.
