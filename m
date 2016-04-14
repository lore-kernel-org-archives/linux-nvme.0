From: axboe@fb.com (Jens Axboe)
Date: Thu, 14 Apr 2016 08:08:16 -0600
Subject: I/O 0 QID 0 timeout, disable controller - kernel 4.4 / 4.5 NVMe
 controller dropouts
In-Reply-To: <20160414132113.GA21794@localhost.localdomain>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
 <20160414132113.GA21794@localhost.localdomain>
Message-ID: <570FA450.7080105@fb.com>

On 04/14/2016 07:21 AM, Keith Busch wrote:
> On Thu, Apr 14, 2016@03:13:22PM +1000, Sam McLeod wrote:
>> We have 6 Supermicro servers all of the same (or very similar spec),
>>
>> Since Kernel 4.4 / 4.5 we've had NVMe devices randomly dropping.
>> It does not relate to a particular server, disk, controller etc... and downgrading to kernel 4.1.
>>
>> With kernel 4.4 the servers would load and the disk randomly disappear.
>> With 4.5 the server loads with one of the disks missing every time.
>>
>>
>> ```
>> [   66.856719] nvme 0000:03:00.0: I/O 0 QID 0 timeout, disable controller
>> [   66.957911] nvme 0000:03:00.0: Identify Controller failed (-4)
>> [   66.957961] nvme 0000:03:00.0: Removing after probe failure status: -5
>> ```
>
> Looks like more fallout from reducing the scope of admin queue completion
> polling...
>
> Jens:
>
> Could we please apply the MSI-x fix commit to 4.6 instead of 4.7 so 4.6
> isn't equally broken? Currently staged in for-next here:
>
>    https://urldefense.proofpoint.com/v2/url?u=http-3A__git.kernel.dk_-3Fp-3Dlinux-2Dblock.git-3Ba-3Dcommitdiff-3Bh-3D788e15abbb9408c9399d7e3445ac9afb3b2fd7d6-3Bhp-3De0489487ec9cd79ee1fa0dc5d3789c08b0e51a2c&d=CwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=cK1a7KivzZRh1fKQMjSm2A&m=WjNBEBATs2DJsluOdhxTZFsQleenkWVxdeLMNPJCTnc&s=7AMgD6x25bdbt4Lp-qTGaHVjXW6yP4GSes8jTZ7SBr0&e=
>
> I'd also like to submit an apporpriate port to stable if no objections.

It feels awfully risky for the current series. Yes, we know this patch 
fixes the reported cases, but I'm worried that there are other 
controllers that will now fail because we don't probe with legacy 
interrupts. But the alternative is polling, which isn't great either and 
would (once again) cause the current and next series to diverge in weird 
and interesting ways.

Hmm

-- 
Jens Axboe
