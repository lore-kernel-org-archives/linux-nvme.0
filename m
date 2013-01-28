From: rama@fastorsystems.com (Ramachandra Rao Gajula)
Date: Mon, 28 Jan 2013 12:12:10 -0800
Subject: Linux NVME Driver - Added Single MSI supoort
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B9392DDB28@FMSMSX105.amr.corp.intel.com>
References: <CAKt=HwJNYbeh=0hEzHQt6GeKK-S3Hu_sWNiB3XMgrcaxP3zoUQ@mail.gmail.com>
 <B58D82457FDA0744A320A2FC5AC253B9392DDB28@FMSMSX105.amr.corp.intel.com>
Message-ID: <CAKt=Hw+fW7sC6HHjr6tpTXbUBfUzBM+R33T=aPkjC2qyhxF75Q@mail.gmail.com>

Hi Keith,

Inline comments ...

Thanks,
-Ramachandra

On Thu, Jan 24, 2013@2:54 PM, Busch, Keith <keith.busch@intel.com> wrote:
> On Thu, Jan 24, 2013@9:40 AM, Ramachandra Rao Gajula wrote:
>> -----
>> Fixes include:
>> 1. Support for single MSI interrupt; if MSI-X fails, then a single MSI
>> is enabled.
>>  - Old code didn't enable MSI-X for the initial admin queue setup time,
>> and later enables it at the time of setting up all the queues.
>> The new code enables 1 MSI-X vector for admin queue setup time,
>> disables it and later enables all the vectors needed for the number of
>> queues at the time of setting up all the queues.; not sure if this code
>> is correct for MSI-X and requires some review.
>
> We use the legacy interrupt for the admin queue until we know how many MSI-x vectors we need to allocate. It is used for only one command. It doesn't seem to be worth the trouble to allocate MSI-x for a single command only to bring it down immediately after.
>

Not much of a trouble to  allocate one MSI-X - at least from the linux
driver, kernel point of view. If we enable only one vector, NVME
firmware/hardware should allow that also - at least on spec/theory.
Secondly, the old code assumes both INTX and MSI-x to be supported,
while the new code fully uses only MSI-x if MSI-X is supported by the
hardware.  I would think this is a cleaner approach.


>> 2. Free all the queues before deleting thee nvme devices at the time of
>> driver unload/shutdown.
>
> What you've done here is introduce a potential use-after-free error. You freed the queue's memory while there are still potentially active gendisks and their request_queues in use that may call the make_request_fn, and the kthread may still use the queue. Maybe we need to move the dev_list remove to after the namespaces are deleted so that the kthread can timeout potentially active IO's while we are deleting the gendisks.
>

With original code, when we do  "insmod" followed by "rmmod",  the
driver hangs and this change of order fixes the issue for us.

> Why do you have a completely different ISR for MSI? You can use the same one to make it a lot easier, and we still need to fall back to legacy in the worst case scenario. This all seems a lot more complicated than it has to be. Maybe do something like this instead?
>

We needed an ISR that will go through multiple queues. There is no
code that allowed multiple queues on a single interrupt and so this
ISR had to be added - to cover the single MSI with multiple queues.


> diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
> index 993c014..cd586e4 100644
> --- a/drivers/block/nvme.c
> +++ b/drivers/block/nvme.c
> @@ -1458,6 +1458,9 @@ static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
>                         continue;
>                 } else {
>                         nr_io_queues = 1;
> +                       result = pci_enable_msi(dev->pci_dev);
> +                       if (result == 0)
> +                               dev->entry[0].vector = dev->pci_dev->irq;
>                         break;
>                 }
>         }
> @@ -1721,7 +1724,10 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
>  {
>         struct nvme_dev *dev = pci_get_drvdata(pdev);
>         nvme_dev_remove(dev);
> -       pci_disable_msix(pdev);
> +       if (pdev->msix_enabled)
> +               pci_disable_msix(pdev);
> +       else if (pdev->msi_enabled)
> +               pci_disable_msi(pdev);
>         iounmap(dev->bar);
>         nvme_release_instance(dev);
>         nvme_release_prp_pools(dev)

The above code only allows one io queue, while the intent of the
change is to allow multiple queue to go on a single MSI.

When we add code for multiple MSI messages, this will become cleaner;
the multiple MSI will reuse multiple MSI-X code.
