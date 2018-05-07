From: mr.nuke.me@gmail.com (Alex G.)
Date: Mon, 7 May 2018 15:16:02 -0500
Subject: AER: Malformed TLP recovery deadlock with NVMe drives
In-Reply-To: <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
References: <8cf4e563-5f84-f8bd-88a6-8369cdf07b29@gmail.com>
 <7afd280ad80a73b39e6c9b9a9e29abcc@codeaurora.org>
Message-ID: <5c97a7c2-cb53-4740-fda0-50ba92288c5c@gmail.com>

On 05/07/2018 01:46 PM, okaya@codeaurora.org wrote:
> On 2018-05-07 19:36, Alex G. wrote:
>> Hi! Me again!
>>
>> I'm seeing what appears to be a deadlock in the AER recovery path. It
>> seems that the device_lock() call in report_slot_reset() never returns.
>> How we get there is interesting:
> 
> Can you give this patch a try?
> 
Oh! Patches so soon? Yay!

> https://patchwork.kernel.org/patch/10351515/

Thank you! I tried a few runs. there was one run where we didn't lock
up, but the other runs all went like before.

For comparison, the run that didn't deadlock looked like [2].

Alex

[2] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1429.log

>> Injection of the error happens by changing the maximum payload size to
>> 128 bytes from 256. This is on the switch upstream port.
>> When there's IO to the drive, switch sees a malformed TLP. Switch
>> reports error, AER handles it.
>> More IO goes, another error is triggered, and this time the root port
>> reports it. AER recovery hits the NVMe drive behind the affetced
>> upstream port and deadlocks.
>>
>> I've added some printks in the AER handler to see which lock dies, and I
>> have a fairly succinct log[1], also pasted below. It appears somebody is
>> already holding the lock to the PCI device behind the sick upstream
>> port, and never releases it.
>>
>>
>> I'm not sure how to track down other users of the lock, and I"m hoping
>> somebody may have a brighter idea.
>>
>> Alex
>>
>>
>> [1] http://gtech.myftp.org/~mrnuke/nvme_logs/log-20180507-1308.log
>>
``
