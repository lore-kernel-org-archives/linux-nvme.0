From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 28 Jan 2013 22:22:37 +0000
Subject: Linux NVME Driver - Added Single MSI supoort
In-Reply-To: <CAKt=Hw+fW7sC6HHjr6tpTXbUBfUzBM+R33T=aPkjC2qyhxF75Q@mail.gmail.com>
References: <CAKt=HwJNYbeh=0hEzHQt6GeKK-S3Hu_sWNiB3XMgrcaxP3zoUQ@mail.gmail.com>
 <B58D82457FDA0744A320A2FC5AC253B9392DDB28@FMSMSX105.amr.corp.intel.com>
 <CAKt=Hw+fW7sC6HHjr6tpTXbUBfUzBM+R33T=aPkjC2qyhxF75Q@mail.gmail.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B9392DE386@FMSMSX105.amr.corp.intel.com>

On Mon, Jan 28, 2013@1:12 PM, Ramachandra Rao Gajula wrote:
> Not much of a trouble to  allocate one MSI-X - at least from the linux
> driver, kernel point of view. If we enable only one vector, NVME
> firmware/hardware should allow that also - at least on spec/theory.
> Secondly, the old code assumes both INTX and MSI-x to be supported,
> while the new code fully uses only MSI-x if MSI-X is supported by the
> hardware.  I would think this is a cleaner approach.

The current code does not assume anything is supported. It tries INTx for a
single command if legacy is supported. If legacy isn't supported, the kthread
will poll the completion. To me, that seems cleaner than setting up MSI-x only
to issue a single command just to take it down immediately after.

> With original code, when we do  "insmod" followed by "rmmod",  the
> driver hangs and this change of order fixes the issue for us.

Were you able to find out why the driver hangs there? I think it should be okay
the way it is. If not, it may be waiting on IO's that the nvme kthread can't 
timeout, so if that's the case, try moving the list_del after the namespaces
are deleted.

What you've done is not okay since there are places that can use the queues
after you freed their memory.

> We needed an ISR that will go through multiple queues. There is no code
> that allowed multiple queues on a single interrupt and so this ISR had
> to be added - to cover the single MSI with multiple queues.

You can call request_irq multiple times with the same irq but with different
nvme queues as the callback data. The kernel will call the ISR once for each
queue you've requested with that irq, so you can reuse the existing nvme_irq
for your ISR.

> The above code only allows one io queue, while the intent of the change
> is to allow multiple queue to go on a single MSI.
> 
> When we add code for multiple MSI messages, this will become cleaner;
> the multiple MSI will reuse multiple MSI-X code.

You must be targeting something not x86, which doesn't support multiple message
MSI. If you really want multiple queues, it is a simple modification to the
patch I attached to make it so. Do you have performance data showing many
IO queues for a single MSI irq has an advantage over one?
