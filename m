From: axboe@kernel.dk (Jens Axboe)
Date: Sun, 7 Feb 2016 15:28:55 -0700
Subject: complete boot failure in 4.5-rc1 caused by nvme: make SG_IO
 support optional
In-Reply-To: <1454861040.2329.4.camel@HansenPartnership.com>
References: <1454783624.2809.6.camel@HansenPartnership.com>
 <20160207092241.GA15331@lst.de>
 <1454861040.2329.4.camel@HansenPartnership.com>
Message-ID: <56B7C527.6050300@kernel.dk>

On 02/07/2016 09:04 AM, James Bottomley wrote:
> On Sun, 2016-02-07@10:22 +0100, Christoph Hellwig wrote:
>> Keith said it should be on by default, and I promised him to change
>> it once we run into problems, which I guess this counts as.
>>
>> But just curious:  what distro are you using?  Upstream systemd
>> explicitly rejected using scsi_id for NVMe here:
>>
>> 	https://github.com/systemd/systemd/issues/1453
>>
>> and all my test systems don't do this either.
>
> This was SUSE (in my case, openSUSE Leap).  I just checked the source
> package; they patch the by-id rules back in for NVME:
>
> # PATCH-FIX-SUSE 1101-rules-persistent-device-names-for-NVMe-devices.patch (bsc#944132)
> Patch1101:      1101-rules-persistent-device-names-for-NVMe-devices.patch
>
> The bugzilla is giving access denied for bug id 944132, so it's likely
> some proprietary vendor problem.  The patch has no preamble, so it's
> hard to tell what they were thinking.

I run root-on-nvme on my laptop, and I haven't observed any problems. 
Generally I hate for options to default y unless absolutely necessary, 
it's a sure fire way to feature creep your kernel without noticing. I 
don't think getting all hot about this issue is fair, if the only known 
case is suse.

If anything, let's make the description better. It's trying to be funny, 
it'd be better if it was descriptive and covered this case as well.

-- 
Jens Axboe
