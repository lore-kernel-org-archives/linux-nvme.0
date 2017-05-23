From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Tue, 23 May 2017 16:06:27 +0800
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <20170523071705.GD16776@infradead.org>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
Message-ID: <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>

On Tue, May 23, 2017@3:17 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, May 22, 2017@05:04:15PM +0800, Kai-Heng Feng wrote:
>> Hi Andy,
>>
>> Currently, if a power state tradition requires high latency, it may be
>> skipped [1] based on the value of ps_max_latency_us in
>> nvme_configure_apst():
>>
>> if (total_latency_us > ctrl->ps_max_latency_us)
>>     continue;
>>
>> Right now ps_max_latency_us defaults to 25000, but some consumer level
>> NVMe have much higher latency.
>> I understand this value is configurable, but I am wondering if it's
>> possible to ignore the latency on consumer devices, probably based on
>> chassis type, so consumer devices can get most NVMe power saving out
>> of the box?
>
> What is your proposed change?

Ignore the latency limit if it's a mobile device, based on DMI chassis type.
I can write a patch for that.

> Do you have any numbers on how this
> improves power consumption for given workloads and what the performance
> impact is on common benchmarks?

A SanDisk NVMe has entry latency 1,000,000 and exit latency 100,000.
The default latency (25000) does not allow this device enters to
non-operational state. The system power consumption is around 13W.
Make this SanDisk device able to enter PS4 can get a system with
roughly 8W power consumption.
The 5W difference is quite good.

I have no idea about the performance impact though. Is there any
benchmark test storage power management latency?
