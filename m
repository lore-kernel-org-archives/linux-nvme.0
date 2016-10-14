From: marc@merlins.org (Marc MERLIN)
Date: Fri, 14 Oct 2016 14:15:54 -0700
Subject: NVME regression in all kernels after 4.4.x for NVME in M2 slot
 for laptop?
In-Reply-To: <20160929060204.GA17637@merlins.org>
References: <20160805190323.GA12853@merlins.org>
 <20160805205052.GA12688@localhost.localdomain>
 <20160805205449.GC12853@merlins.org>
 <20160815193733.GC18083@localhost.localdomain>
 <20160914024027.GV24451@merlins.org>
 <20160914144615.GA16556@localhost.localdomain>
 <20160929060204.GA17637@merlins.org>
Message-ID: <20161014211554.GQ15090@merlins.org>

Hi Keith,

I'm still stuck with the 4.4.x tree, which is starting to be a problem as
more fixes for btrfs and others are being rolled into newer kernels.

I realize that I'm in a bad place since this problem seems to be impacting
virtually no one as laptops that boot off nvme are likely rare, but is there
any chance this will get fixed somehow?

More importantly, do you have access to a thinkpad or other laptop with NVME
M2 for testing?

Thanks,
Marc

On Thu, Sep 29, 2016@08:02:04AM +0200, Marc MERLIN wrote:
> On Wed, Sep 14, 2016@10:46:16AM -0400, Keith Busch wrote:
> > On Tue, Sep 13, 2016@07:40:27PM -0700, Marc MERLIN wrote:
> > > Did you have any luck/more time recently?
> > > 
> > > Thanks,
> > > Marc
> > 
> > Hi Marc,
> > 
> > I was working with Jens a couple weeks ago on something that sounded
> > possibly related. The blk-mq's CPU offlining could result in deadlock or
> > kernel crash, and we narrowed it down to incorrectly switching software
> > contexts. Jens fixed that in 4.8 with this commit:
> > 
> >   https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=e57690fe009b2ab0cee8a57f53be634540e49c9d
> > 
> > Is there any chance the latest 4.8 RC is working for you?
> 
> My apologies for the late reply, been travelling since then.
> I booted it now (built 10 days ago), shut the lid, got a fast flashing
> of the thinkpad LED (2hz), laptop dead when I re-open the lid.
> 
> Back to 4.4.5, things are ok again.
> 
> Hope this helps.
> 
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
> Microsoft is to operating systems ....
>                                       .... what McDonalds is to gourmet cooking
> Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
