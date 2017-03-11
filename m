From: thomas@fjellstrom.ca (Thomas Fjellstrom)
Date: Sat, 11 Mar 2017 09:31:20 -0700
Subject: nvme, allocation failures, and aborted commands
In-Reply-To: <20170309230334.GE14329@localhost.localdomain>
References: <2324331.vgmPNSfijK@natasha> <3290252.oG8R0O7IFj@natasha>
 <20170309230334.GE14329@localhost.localdomain>
Message-ID: <1871788.SKK3W9ikuM@natasha>

On Thursday, March 9, 2017 6:03:34 PM MST Keith Busch wrote:
> On Thu, Mar 09, 2017@03:01:27PM -0700, Thomas Fjellstrom wrote:
> > On Monday, March 6, 2017 5:46:33 PM MST Keith Busch wrote:
> > > 
> > >   echo 128 > /sys/block/nvme0n1/queue/max_hw_sectors_kb
> > >   echo 128 > /sys/block/nvme0n1/queue/max_nr_requests
> > > 
> > 
> > First off, theres no max_nr_requests, and echoing into max_hw_sectors_kb 
gets
> > me a permission denied even as root no matter the value I tried.
> 
> What I meant to say was "max_sectors_kb" and "nr_request".
> 

That seems to have quieted any errors. Performance hasn't suffered any.

I had also tried a test with the mq-deadline scheduler instead of none, and it 
helped as well but did eventually show some command aborted errors.

I'm just wondering why this is something that can happen. Shouldn't the 
default be "just work"? Is there no way to query the device for some sane 
defaults?

I understand the Samsung 960 Evo m.2 (I have the 256GB model) isn't the 
highest end device out there, but it should be quite popular and should "just 
work" or a lot of people will complain or decide linux is broken.

-- 
Thomas Fjellstrom
thomas at fjellstrom.ca
