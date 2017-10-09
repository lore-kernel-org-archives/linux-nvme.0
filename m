From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Oct 2017 08:49:45 -0600
Subject: Missing interrupts in kernel 4.5.0-21.cavium.el7.aarch64
In-Reply-To: <CAGSHeY1uhgMT5oQBt8fxEzO1k=s9q9eBaFGm+oVt9a31_Ga9aA@mail.gmail.com>
References: <CAGSHeY1uhgMT5oQBt8fxEzO1k=s9q9eBaFGm+oVt9a31_Ga9aA@mail.gmail.com>
Message-ID: <20171009144945.GB19329@localhost.localdomain>

On Fri, Oct 06, 2017@02:49:06PM -0700, Yogi Wannabe wrote:
> Our NVMe controller works fine with Kernel 3.9.xx. On kernel
> 4.5.0-21.cavium.el7.aarch64 we see some issues with interrupts.
> 
> Upon nvme driver load it, sends an Identify cmd.. The controller
> processes the cmd and sends a completion interrupt. The driver does
> not see this interrupt nor is it visible in /proc/interrupts. After
> admin timeout duration, driver disables controller and calls
> free_irq(). As soon as free_irq() is called, interrupt reaches driver
> and nvme_irq() is called. The interrupt vector is usually 17.
> 
> Are there any known issues that could be causing this weird behavior?

4.5 removed the completion queue polling, relying exclusively on
interrupts to find these sorts of problems.

After that, lots of people reported failures with device initialization.

I don't believe the root caused was found since no issues were reported
when we enabled MSI/MSIx for early init in 4.6.

For more details, see:

  http://lists.infradead.org/pipermail/linux-nvme/2016-May/004653.html

This unfortauntely was not picked up by the 4.5-stable.
