From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 11:11:11 -0700
Subject: [PATCH] nvme: make sure ns head inherits underlying device limits
In-Reply-To: <20181026075319.GC5092@lst.de>
References: <20181019222450.25397-1-sagi@grimberg.me>
 <20181022085752.GD18755@lst.de>
 <70bcef36-48da-cae7-4e23-ac9b01814a74@grimberg.me>
 <20181026075319.GC5092@lst.de>
Message-ID: <4cd69ced-7e16-e5dd-716d-53784e2ed32f@grimberg.me>

Christoph,

>> Without this patch at least max_segments and max_hw_sectors of the head
>> device node are degenerated to defaults that have nothing to do with the
>> underlying device limits.
>>
>> This can result in unnecessary bio splitting for the head device
>> node...
> 
> But we never split bios for the multipath queue!

Yes of course we don't, but we can still stack other devices on top
of the multipath device that can split bios and in fact rely on the
underlying queue limits.
