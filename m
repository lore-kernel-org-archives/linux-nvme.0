From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 19 Dec 2016 10:26:50 -0700
Subject: [RFC 0/1] New PCI Switch Management Driver
In-Reply-To: <20161219172903.GB1043@localhost.localdomain>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <CAL-B5D3g=ZWRg7Qh8_KumJkdg6F2+2a8=HCz2US7a4g2tKC0Lw@mail.gmail.com>
 <735068a7-7805-dad0-b5b0-5218a18f335c@deltatee.com>
 <20161219172903.GB1043@localhost.localdomain>
Message-ID: <7a537ea0-afb1-48d5-0706-5066dfaef1dd@deltatee.com>



On 19/12/16 10:29 AM, Keith Busch wrote:
> Since the in-kernel driver binds to the device, won't this driver
> conflict with the initialization the in-kernel one already does? Bus
> master, MSI setup, etc?

No. The management interface is on a completely separate PCI endpoint.
So from the kernels perspective, the management interface is just
another PCI device. It has the same vendor and device ID as the switch
but uses separate class codes so it can be bound by an independent driver.

> Could you also provide the reasoning against making the functionality
> this driver provides in user space?

I'm not sure how you mean. I suppose we could write a UIO driver but
that seemed like an ugly solution to me and doesn't seem like an
approach the community prefers. We do have to make use of interrupts so
simply using /sys/bus/pci/.../resourceN wouldn't work either.

Logan
