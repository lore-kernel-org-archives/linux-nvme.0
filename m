From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 13 May 2019 20:36:32 +0000
Subject: [PATCH 0/3] nvme-core: add user command filter
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
 <20190510214255.GA11723@localhost.localdomain>
 <20190513132517.GB2661@infradead.org>
 <20190513164933.GC15437@localhost.localdomain>
Message-ID: <SN6PR04MB4527DBCEE5CD5A54965EA0C4860F0@SN6PR04MB4527.namprd04.prod.outlook.com>

Hi Keith,
On 5/13/19 9:54 AM, Keith Busch wrote:
> On Mon, May 13, 2019@06:25:17AM -0700, Christoph Hellwig wrote:
>> On Fri, May 10, 2019@03:42:56PM -0600, Keith Busch wrote:
>>> On Wed, May 08, 2019@11:36:31AM -0700, Chaitanya Kulkarni wrote:
>>>> This patch-series adds a filter to allow only certain user commands.                                   
>>>> Right now we use this infrastructure to prevent the user get log page
>>>> commands where RAE bit is cleared. We only allow get log pages to be
>>>> read with RAE == 0 where we issue the uevent to the userspace so that
>>>> user can clear the log pages.
>>>>
>>>> Here we white list the log pages which are only allowed when RAE == 0.
>>>> We also allow Vendor Specific log pages irrespective of the RAE.
>>> I'm generally against the passthrough interface examining commands. It
>>> is not for the driver to decide what an admin can't send to their devices.
>> Well, the whole AER model is based around log pages clearing the
>> event, so if userspace clears these events we are in pretty deep
>> trouble.  Would you prefer just setting the RAE bit unconditionally
>> for these log pages?
> What if user space really wants to clear it? We shouldn't just make that
> capability unreachable to admins.
>

I agree that passthru means we should just passthru. But user-pace
doesn't have the access to take

corrective action on clearing the AEN.

The cases where Kernel is responsible for reading and clearing out the
log pages/AENs

if we allow userspace to clear those it will create a problem in the
kernel code if kernel code

expects the aen bit to be set. This can lead to complex bugs where,

1. Kernel expects the log page and aen to be present.

2. But it is been cleared since userspace read it but did not take the
corrective action or doesn't have the

    right interface to take corrective action so it depends on a kernel
(driver) to take the corrective action.
