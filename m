From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Oct 2018 11:44:07 +0200
Subject: [PATCHv2] nvme/pci: Fix hot removal during error handling
In-Reply-To: <97d2a54a-0c0d-f561-23c5-cb10d77ce5f0@grimberg.me>
References: <20181005150927.24120-1-keith.busch@intel.com>
 <d4d7fa23-99b6-de4e-cee5-24205372ac05@grimberg.me>
 <20181005195136.GB24524@localhost.localdomain>
 <97d2a54a-0c0d-f561-23c5-cb10d77ce5f0@grimberg.me>
Message-ID: <20181015094407.GA28869@lst.de>

On Fri, Oct 05, 2018@01:24:24PM -0700, Sagi Grimberg wrote:
>
>>>> -	flush_work(&dev->ctrl.reset_work);
>>>> +	cancel_work_sync(&dev->ctrl.reset_work);
>>>
>>> Does reset_work requeue itself? if not I don't fully understand
>>> this change.
>>
>> You'd have to abuse the state machine if reset_work wanted to requeue
>> itself, so that shouldn't happen.
>>
>> We could just leave it as a flush work, and that should be okay too. The
>> cancel_work_sync should accomplish the same, but also prevent the work
>> from even starting if it just so happens to have been pending in a
>> work queue, but that seems very unlikely.
>
> I don't mind, but was looking to understand what it is trying to
> achieve. If you do change that, would be a good idea to include it in
> the change log

Keith, any plans to resend?  Or should I take this one after all?
