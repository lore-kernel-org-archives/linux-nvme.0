From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Mar 2017 18:03:34 -0500
Subject: nvme, allocation failures, and aborted commands
In-Reply-To: <3290252.oG8R0O7IFj@natasha>
References: <2324331.vgmPNSfijK@natasha> <24015519.RaUGNvtkS7@natasha>
 <20170306224633.GA21202@localhost.localdomain>
 <3290252.oG8R0O7IFj@natasha>
Message-ID: <20170309230334.GE14329@localhost.localdomain>

On Thu, Mar 09, 2017@03:01:27PM -0700, Thomas Fjellstrom wrote:
> On Monday, March 6, 2017 5:46:33 PM MST Keith Busch wrote:
> > 
> >   echo 128 > /sys/block/nvme0n1/queue/max_hw_sectors_kb
> >   echo 128 > /sys/block/nvme0n1/queue/max_nr_requests
> > 
> 
> First off, theres no max_nr_requests, and echoing into max_hw_sectors_kb gets
> me a permission denied even as root no matter the value I tried.

What I meant to say was "max_sectors_kb" and "nr_request".
