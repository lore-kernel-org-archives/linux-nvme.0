From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Sep 2016 18:47:04 -0400
Subject: Create IO queue variation between kernels
In-Reply-To: <CAG3=cOmN5jGK6kqv_kCiyZL8ypy_uTaA3poooP6cdBLE8AQbJg@mail.gmail.com>
References: <CAG3=cOmN5jGK6kqv_kCiyZL8ypy_uTaA3poooP6cdBLE8AQbJg@mail.gmail.com>
Message-ID: <20160927224704.GE24200@localhost.localdomain>

On Tue, Sep 27, 2016@11:39:53AM -0700, Nisha Miller wrote:
> Hi,
> 
> We plugged our NVMe controller into a server running Kernel 3.19.8 and
> we were able to create multiple IO queues.
> 
> On the same server, if we boot Kernel 2.6.32 we can create only 1 IO
> queue. On 2.6.32, pci_enable_msi_block() always returns number of MSIs
> supported as 1. Since there is no change in the hardware, I'm
> wondering where the problem lies and how we can fix this.
> 
> Any clues, ideas, tips greatly appreciated!

In a 2.6.32 kernel on x86, then enabling code should be going through
arch_setup_msi_irqs, which says it doesn't support multiple MSI's "yet".
You can only do 1 MSI on such an old kernel.
