From: efremmc2@gmail.com (Efrem Mc)
Date: Fri, 2 Dec 2016 14:22:29 -0500
Subject: Storage Work Group Storage Interface Interactions Specification -
 updates
Message-ID: <CAEhOZreyG71otjMGnSocBUebABuyki67dsJSWxjAW6Gs5oR0Xg@mail.gmail.com>

Hi all:

Scott B. previously provided us with an excellent resource link, it
looks like there are updated specifications.  [I think I might be
getting a NVME drive for my Z170 system, it support Gen 3x4,
32Gb/xftr. My laptop has nvme 512MB PCIe good speeds]

Public review:
http://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_06_Revision_1_08_public-review.pdf

Latest:
http://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_05_Revision_1_00.pdf

Errata 1.03 no others are listed
http://www.trustedcomputinggroup.org/wp-content/uploads/TCG_Storage-SIIS_v1_03_errata_v1.00_r1.00.pdf

Thanks Scott, it was interesting to review,

On Thu, Dec 1, 2016@3:00 PM,  <linux-nvme-request@lists.infradead.org> wrote:
> Send Linux-nvme mailing list submissions to
>         linux-nvme at lists.infradead.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         http://lists.infradead.org/mailman/listinfo/linux-nvme
> or, via email, send a message with subject or body 'help' to
>         linux-nvme-request at lists.infradead.org
>
> You can reach the person managing the list at
>         linux-nvme-owner at lists.infradead.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linux-nvme digest..."
>
>
> Today's Topics:
>
>    1. Re: [PATCH v2 2/4] block: Add Sed-opal library (Scott Bauer)
>    2. Re: [PATCH v2 2/4] block: Add Sed-opal library (Keith Busch)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 1 Dec 2016 10:53:43 -0700
> From: Scott Bauer <scott.bauer at intel.com>
> To: Christoph Hellwig <hch at infradead.org>
> Cc: Keith Busch <keith.busch at intel.com>, sagi at grimberg.me,
>         Rafael.Antognolli at intel.com, linux-nvme at lists.infradead.org,
>         axboe at fb.com, linux-block at vger.kernel.org, jonathan.derrick at intel.com,
>         j.naumann at fu-berlin.de
> Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
> Message-ID: <20161201175343.GA6554 at sbauer-Z170X-UD5>
> Content-Type: text/plain; charset=us-ascii
>
> On Thu, Dec 01, 2016@02:04:56AM -0800, Christoph Hellwig wrote:
>> On Wed, Nov 30, 2016@07:50:07PM -0500, Keith Busch wrote:
>> > I think we should get rid of the "majmin" stuff
>>
>> Absolutely agreed.
>>
>> >
>> > and directly use
>> > block_device. Then if we add the security send/receive operations to the
>> > block_device_operations, that will simplify chaining the security request
>> > to the driver without needing to thread the driver's requested callback
>> > and data the way you have to here since all the necessary information
>> > is encapsulated in the block_device.
>>
>> Maybe.  I need to look at the TCG spec again (oh my good, what a fucking
>> mess), but if I remember the context if it is the whole nvme controller
>> and not just a namespace, so a block_device might be the wrong context.
>> Then again we can always go from the block_device to the controller
>> fairly easily.  So instead of adding the security operation to the
>> block_device_operations which we don't really need for now maybe we
>> should add a security_conext to the block device so that we can avoid
>> all the lookup code?
>
> I spent some time this morning reading through the numerous specs/documents,
> with a lot of coffee.
>
> Specifically in:
> https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_02_Revision_1_00_20111230.pdf
>
> 5.5.2
> Namespace
>
> A target that has multiple Namespaces MAY have  multiple TPers. Each TPer
> SHALL be associated with a different Namespace. Every Namespace on a device
> is not required to have a TPer, but Namespaces that support the TCG Core
> specification commands and functionality SHALL have a TPer. A TPer SHALL only
> be associated with exactly one Namespace. A Namespace MAY have no TPer.
>
> >From reading that it seems we will probably have to keep it at the block layer,
> since its possible to have a valid "Locking range 1" on n1 and a "Locking range 1"
> on n2.
>
>
> [snip]
>
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 1 Dec 2016 13:22:39 -0500
> From: Keith Busch <keith.busch at intel.com>
> To: Scott Bauer <scott.bauer at intel.com>
> Cc: Christoph Hellwig <hch at infradead.org>, sagi at grimberg.me,
>         Rafael.Antognolli at intel.com, linux-nvme at lists.infradead.org,
>         axboe at fb.com, linux-block at vger.kernel.org, jonathan.derrick at intel.com,
>         j.naumann at fu-berlin.de
> Subject: Re: [PATCH v2 2/4] block: Add Sed-opal library
> Message-ID: <20161201182239.GH21081 at localhost.localdomain>
> Content-Type: text/plain; charset=us-ascii
>
> On Thu, Dec 01, 2016@10:53:43AM -0700, Scott Bauer wrote:
>> > Maybe.  I need to look at the TCG spec again (oh my good, what a fucking
>> > mess), but if I remember the context if it is the whole nvme controller
>> > and not just a namespace, so a block_device might be the wrong context.
>> > Then again we can always go from the block_device to the controller
>> > fairly easily.  So instead of adding the security operation to the
>> > block_device_operations which we don't really need for now maybe we
>> > should add a security_conext to the block device so that we can avoid
>> > all the lookup code?
>>
>> I spent some time this morning reading through the numerous specs/documents,
>> with a lot of coffee.
>>
>> Specifically in:
>> https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_02_Revision_1_00_20111230.pdf
>>
>> 5.5.2
>> Namespace
>>
>> A target that has multiple Namespaces MAY have  multiple TPers. Each TPer
>> SHALL be associated with a different Namespace. Every Namespace on a device
>> is not required to have a TPer, but Namespaces that support the TCG Core
>> specification commands and functionality SHALL have a TPer. A TPer SHALL only
>> be associated with exactly one Namespace. A Namespace MAY have no TPer.
>>
>> From reading that it seems we will probably have to keep it at the block layer,
>> since its possible to have a valid "Locking range 1" on n1 and a "Locking range 1"
>> on n2.
>
> Thanks for tracking that down! Specifically for NVMe, security
> send/recieve requires NSID, so it is a little more difficult to get to
> that if we're not using the abstracton that contains the namespace.
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
>
> ------------------------------
>
> End of Linux-nvme Digest, Vol 57, Issue 3
> *****************************************
