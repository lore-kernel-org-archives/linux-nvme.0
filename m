From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 18 May 2018 07:57:51 -0600
Subject: [PATCH V6 11/11] nvme: pci: support nested EH
In-Reply-To: <20180518001958.GA2742@ming.t460p>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-12-ming.lei@redhat.com>
 <20180516141242.GA20119@localhost.localdomain>
 <20180516231058.GB28727@ming.t460p>
 <20180517022030.GB21959@localhost.localdomain>
 <20180518001958.GA2742@ming.t460p>
Message-ID: <20180518135751.GI23555@localhost.localdomain>

On Fri, May 18, 2018@08:20:05AM +0800, Ming Lei wrote:
> What I think block/011 is helpful is that it can trigger IO timeout
> during reset, which can be triggered in reality too.

As I mentioned earlier, there is nothing wrong with the spirit of
the test. What's wrong with it is the misguided implemention.

Do you underestand why it ever passes? The success happens when the
enabling part of the loop happens to coincide with the driver's enabling,
creating the pci_dev->enable_cnt > 1, making subsequent disable parts
of the loop do absolutely nothing; the exact same as the one-liner
(non-serious) patch I sent to defeat the test.

A better way to induce the timeout is:

  # setpci -s <B:D.f> 4.w=0:6

This will halt the device without messing with the kernel structures,
just like how a real device failure would occur.
