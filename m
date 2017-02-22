From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 22 Feb 2017 13:41:11 -0700
Subject: [GIT PULL] nvme patches for 4.11
In-Reply-To: <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>
References: <1487791916-25599-1-git-send-email-sagi@grimberg.me>
 <6e829c66-8ebf-9aff-a14f-8031ba891876@kernel.dk>
Message-ID: <d6ec5d30-84d6-706b-cfc9-1927619b585e@kernel.dk>

On 02/22/2017 01:28 PM, Jens Axboe wrote:
> On 02/22/2017 12:31 PM, Sagi Grimberg wrote:
>> Hey Jens,
>>
>> This pull-request includes:
>> - autonomous power state transitions from Andy
>> - nvme-rdma support for connecting via configurable source ip
>> - nvmet-rdma cleanups from Max
>> - nvme-fc cleanups from James
>> - quirk fixup for apple from Daniel
>> - various nvme-pci fixes from Keith
>> - expose nvme controller state via sysfs
>> - identify CNS fixup from Parav
>> - enforce fabrics implement ->create_ctrl callout from Johannes
>> - nvme-rdma fix goto tag from Christophe
>> - spelling fixup from Colin
>>
>> Please pull from:
>>
>>   git://git.infradead.org/nvme.git nvme-4.11
> 
> Pulled, but this really should have been sent in at least a
> week earlier...

A few issues with this:

- It throws a merge conflict. No big deal, that was easy enough
  to fix up.

- What is this based on? Looks like some version of my for-next,
  but ends up duplicating 4 patches from me. I don't remember
  if I rebased my for-next this time around, but I often do. It's
  not a stable branch like the for-4.xx/topic branches.

- Out of 22 patches, one commit reverts another commit. That should
  just have been squashed.

I ended up simply fixing all of that up, and generating the patches
and applying. Otherwise the whole history would have been a mess.

-- 
Jens Axboe
