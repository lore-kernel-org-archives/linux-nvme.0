From: luto@amacapital.net (Andy Lutomirski)
Date: Fri, 2 Sep 2016 14:43:48 -0700
Subject: [PATCH v2 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <1472850905.2946.20.camel@linux.intel.com>
References: <cover.1472594203.git.luto@kernel.org>
 <6e6c3cd47858160bf8e34f2edb481c0ef5092d5b.1472594203.git.luto@kernel.org>
 <1472850905.2946.20.camel@linux.intel.com>
Message-ID: <CALCETrVoMEzmjfj--e09F8Ss8Dp9CFAmuuBhFoHOSNDoxHu6aQ@mail.gmail.com>

On Fri, Sep 2, 2016 at 2:15 PM, J Freyensee
<james_p_freyensee@linux.intel.com> wrote:
> On Tue, 2016-08-30@14:59 -0700, Andy Lutomirski wrote:
>> NVME devices can advertise multiple power states.  These states can
>> be either "operational" (the device is fully functional but possibly
>> slow) or "non-operational" (the device is asleep until woken up).
>> Some devices can automatically enter a non-operational state when
>> idle for a specified amount of time and then automatically wake back
>> up when needed.
>>
>> The hardware configuration is a table.  For each state, an entry in
>> the table indicates the next deeper non-operational state, if any,
>> to autonomously transition to and the idle time required before
>> transitioning.
>>
>> This patch teaches the driver to program APST so that each
>> successive non-operational state will be entered after an idle time
>> equal to 100% of the total latency (entry plus exit) associated with
>> that state.  A sysfs attribute 'apst_max_latency_us' gives the
>> maximum acceptable latency in ns; non-operational states with total
>> latency greater than this value will not be used.  As a special
>> case, apst_max_latency_us=0 will disable APST entirely.
>
> May I ask a dumb question?
>
> How does this work with multiple NVMe devices plugged into a system?  I
> would have thought we'd want one apst_max_latency_us entry per NVMe
> controller for individual control of each device?  I have two
> Fultondale-class devices plugged into a system I tried these patches on
> (the 4.8-rc4 kernel) and I'm not sure how the single
> /sys/module/nvme_core/parameters/apst_max_latency_us would work per my
> 2 devices (and the value is using the default 25000).
>

Ah, I faked you out :(

The module parameter (nvme_core/parameters/apst_max_latency_us) just
sets the default for newly probed devices.  The actual setting is in
/sys/devices/whatever (symlinked from /sys/block/nvme0n1/devices, for
example).  Perhaps I should name the former
default_apst_max_latency_us.

>
>>
>> On hardware without APST support, apst_max_latency_us will not be
>> exposed in sysfs.
>
> Not sure that is true, as from what I see so far, Fultondales don't
> support apst yet I still see:
>
> [root at nvme-fabric-host01 nvme-cli]# cat
> /sys/module/nvme_core/parameters/apst_max_latency_us
> 25000

That will be there regardless.  It's the value in the sysfs device
directory that won't be there, which is hopefully why you couldn't
find it.

>
>>
>> In theory, the device can expose "default" APST table, but this
>> doesn't seem to function correctly on my device (Samsung 950), nor
>> does it seem particularly useful.  There is also an optional
>> mechanism by which a configuration can be "saved" so it will be
>> automatically loaded on reset.  This can be configured from
>> userspace, but it doesn't seem useful to support in the driver.
>>
>> On my laptop, enabling APST seems to save nearly 1W.
>>
>> The hardware tables can be decoded in userspace with nvme-cli.
>> 'nvme id-ctrl /dev/nvmeN' will show the power state table and
>> 'nvme get-feature -f 0x0c -H /dev/nvme0' will show the current APST
>> configuration.
>
> nvme get-feature -f 0x0c -H /dev/nvme0
>
> isn't working for me, I get a:
>
> [root at nvme-fabric-host01 nvme-cli]# ./nvme get-feature -f 0x0c -H
> /dev/nvme0
> NVMe Status:INVALID_FIELD(2)
>
> I don't have the time right now to investigate further, but I'll assume
> it's because I have Fultondales (though I would have thought this patch
> would have provided enough code for the latest nvme-cli code to do this
> new get-feature as-is).

I'm assuming it doesn't work because your hardware doesn't support
APST.  nvme get-feature works even without my patches, since it mostly
bypasses the driver.

--Andy
