From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 23 May 2017 12:35:19 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
Message-ID: <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>

On Tue, May 23, 2017 at 1:06 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Tue, May 23, 2017@3:17 PM, Christoph Hellwig <hch@infradead.org> wrote:
>> On Mon, May 22, 2017@05:04:15PM +0800, Kai-Heng Feng wrote:
>>> Hi Andy,
>>>
>>> Currently, if a power state tradition requires high latency, it may be
>>> skipped [1] based on the value of ps_max_latency_us in
>>> nvme_configure_apst():
>>>
>>> if (total_latency_us > ctrl->ps_max_latency_us)
>>>     continue;
>>>
>>> Right now ps_max_latency_us defaults to 25000, but some consumer level
>>> NVMe have much higher latency.
>>> I understand this value is configurable, but I am wondering if it's
>>> possible to ignore the latency on consumer devices, probably based on
>>> chassis type, so consumer devices can get most NVMe power saving out
>>> of the box?
>>
>> What is your proposed change?
>
> Ignore the latency limit if it's a mobile device, based on DMI chassis type.
> I can write a patch for that.
>
>> Do you have any numbers on how this
>> improves power consumption for given workloads and what the performance
>> impact is on common benchmarks?
>
> A SanDisk NVMe has entry latency 1,000,000 and exit latency 100,000.
> The default latency (25000) does not allow this device enters to
> non-operational state. The system power consumption is around 13W.
> Make this SanDisk device able to enter PS4 can get a system with
> roughly 8W power consumption.
> The 5W difference is quite good.

Can you send the actual 'nvme id-ctrl' output?

I suspect that something is screwy here.  This is an entry latency of
1 second and an exit latency of 100ms.  This is *atrocious*.  I don't
care what kind of mobile device this is -- making it unresponsive for
1.1 seconds for the round trip will be quite noticeable.  And, with an
RSTe-like policy, that's 100 *seconds* of delay before going fully to
sleep.  Also, 5W power difference between deep sleep and less deep
sleep is also bizarrely large.  The NVMe device shouldn't take 5W of
power when idle even in the max-power operational state.

--Andy
