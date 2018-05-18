From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 19 May 2018 06:26:28 +0800
Subject: [PATCH V6 11/11] nvme: pci: support nested EH
In-Reply-To: <20180518135751.GI23555@localhost.localdomain>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
 <20180518135751.GI23555@localhost.localdomain>
Message-ID: <20180518222622.GA18334@ming.t460p>

On Fri, May 18, 2018@07:57:51AM -0600, Keith Busch wrote:
> On Fri, May 18, 2018@08:20:05AM +0800, Ming Lei wrote:
> > What I think block/011 is helpful is that it can trigger IO timeout
> > during reset, which can be triggered in reality too.
> 
> As I mentioned earlier, there is nothing wrong with the spirit of
> the test. What's wrong with it is the misguided implemention.
> 
> Do you underestand why it ever passes? The success happens when the
> enabling part of the loop happens to coincide with the driver's enabling,
> creating the pci_dev->enable_cnt > 1, making subsequent disable parts
> of the loop do absolutely nothing; the exact same as the one-liner
> (non-serious) patch I sent to defeat the test.
> 
> A better way to induce the timeout is:
> 
>   # setpci -s <B:D.f> 4.w=0:6
> 
> This will halt the device without messing with the kernel structures,
> just like how a real device failure would occur.

Frankly speaking, I don't care how the test-case is implemented at all.

The big problem is that NVMe driver can't handle IO time-out during
reset context, and finally either the controller becomes DEAD or reset
context hangs forever, and everything can't move on.

The issue can be reproduced easier via io-timeout-fail fault injection.

So could we please face to the real issue instead of working around
test case?

Thanks,
Ming
