From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Dec 2016 12:29:03 -0500
Subject: [RFC 0/1] New PCI Switch Management Driver
In-Reply-To: <735068a7-7805-dad0-b5b0-5218a18f335c@deltatee.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <CAL-B5D3g=ZWRg7Qh8_KumJkdg6F2+2a8=HCz2US7a4g2tKC0Lw@mail.gmail.com>
 <735068a7-7805-dad0-b5b0-5218a18f335c@deltatee.com>
Message-ID: <20161219172903.GB1043@localhost.localdomain>

On Mon, Dec 19, 2016@10:06:56AM -0700, Logan Gunthorpe wrote:
> As I noted, the hardware is compliant and works perfectly fine with the
> in-kernel driver. However, the hardware has many additional custom
> features that are not covered by the PCI specs. For example, it has an
> interface to count packets that match a specific criteria. It also has
> firmware that can be expanded to do completely custom things by the
> user. Additionally, the switch is _very_ configurable and has a
> configuration file that can be uploaded and downloaded.
> 
> All these features and more are exposed through a special management
> endpoint that is completely separate from the standard PCI switch
> interface. This work is a driver for that endpoint and is not required
> to use the switch. It only makes the advanced features available to the
> user.

Since the in-kernel driver binds to the device, won't this driver
conflict with the initialization the in-kernel one already does? Bus
master, MSI setup, etc?

Could you also provide the reasoning against making the functionality
this driver provides in user space?
