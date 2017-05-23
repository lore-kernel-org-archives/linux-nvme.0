From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 23 May 2017 13:01:46 -0700
Subject: NVMe APST high latency power states being skipped
In-Reply-To: <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>
References: <CAAd53p5pxgO-n0K4khAsYAcWw64tNJwtPwbMHaPksVQMLeXJmA@mail.gmail.com>
 <20170523071705.GD16776@infradead.org>
 <CAAd53p6uX1pKGAaNhYfT0VSRYD8A2e2Ykacak-pqW4GOXFJPug@mail.gmail.com>
 <CALCETrU2Ys=2nsMeHSXRaktNkmuHN7S-_D-pF23RFniqcAhjnQ@mail.gmail.com>
 <84ea5d8fbf0446c58c7b6c85d3868d94@ausx13mpc120.AMER.DELL.COM>
Message-ID: <CALCETrWNU8uquoDiNDeYaoOUyMOAVyWQ73GfrEeWntTcm4ioAw@mail.gmail.com>

On Tue, May 23, 2017@12:56 PM,  <Mario.Limonciello@dell.com> wrote:
>> -----Original Message-----
>> From: Andy Lutomirski [mailto:luto at kernel.org]
>> Sent: Tuesday, May 23, 2017 2:35 PM
>> To: Kai-Heng Feng <kai.heng.feng at canonical.com>
>> Cc: Christoph Hellwig <hch at infradead.org>; Andrew Lutomirski
>> <luto at kernel.org>; linux-nvme <linux-nvme at lists.infradead.org>; Limonciello,
>> Mario <Mario_Limonciello at Dell.com>
>> Subject: Re: NVMe APST high latency power states being skipped
>>
>> On Tue, May 23, 2017 at 1:06 AM, Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>> > On Tue, May 23, 2017 at 3:17 PM, Christoph Hellwig <hch at infradead.org>
>> wrote:
>> >> On Mon, May 22, 2017@05:04:15PM +0800, Kai-Heng Feng wrote:
>> >>> Hi Andy,
>> >>>
>> >>> Currently, if a power state tradition requires high latency, it may be
>> >>> skipped [1] based on the value of ps_max_latency_us in
>> >>> nvme_configure_apst():
>> >>>
>> >>> if (total_latency_us > ctrl->ps_max_latency_us)
>> >>>     continue;
>> >>>
>> >>> Right now ps_max_latency_us defaults to 25000, but some consumer level
>> >>> NVMe have much higher latency.
>> >>> I understand this value is configurable, but I am wondering if it's
>> >>> possible to ignore the latency on consumer devices, probably based on
>> >>> chassis type, so consumer devices can get most NVMe power saving out
>> >>> of the box?
>> >>
>> >> What is your proposed change?
>> >
>> > Ignore the latency limit if it's a mobile device, based on DMI chassis type.
>> > I can write a patch for that.
>> >
>> >> Do you have any numbers on how this
>> >> improves power consumption for given workloads and what the performance
>> >> impact is on common benchmarks?
>> >
>> > A SanDisk NVMe has entry latency 1,000,000 and exit latency 100,000.
>> > The default latency (25000) does not allow this device enters to
>> > non-operational state. The system power consumption is around 13W.
>> > Make this SanDisk device able to enter PS4 can get a system with
>> > roughly 8W power consumption.
>> > The 5W difference is quite good.
>>
>> Can you send the actual 'nvme id-ctrl' output?
>>
>
> I happen to have the output of this disk from another email I'm on so
> I'll share it while it's Kai Heng's night.  There are several disks mentioned
> that have this same concern, here's three of them at the end of this email.
>
>> I suspect that something is screwy here.  This is an entry latency of
>> 1 second and an exit latency of 100ms.  This is *atrocious*.  I don't
>> care what kind of mobile device this is -- making it unresponsive for
>> 1.1 seconds for the round trip will be quite noticeable.  And, with an
>> RSTe-like policy, that's 100 *seconds* of delay before going fully to
>> sleep.  Also, 5W power difference between deep sleep and less deep
>> sleep is also bizarrely large.  The NVMe device shouldn't take 5W of
>> power when idle even in the max-power operational state.
>>
>
> There are some configurations that have multiple NVMe disks.
> For example the Precision 7520 can have up to 3.
>
> NVME Identify Controller:
...
> mn      : A400 NVMe SanDisk 512GB
...
> ps    0 : mp:8.25W operational enlat:0 exlat:0 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:5.30W
> ps    1 : mp:8.25W operational enlat:0 exlat:0 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:3.30W
> ps    2 : mp:8.25W operational enlat:0 exlat:0 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:3.30W
> ps    3 : mp:0.0500W non-operational enlat:51000 exlat:10000 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
> ps    4 : mp:0.0055W non-operational enlat:1000000 exlat:100000 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
>

44.5mW saved and totally crazy latency.

>
> NVME Identify Controller:
...
> mn      : THNSF5512GPUK NVMe SED TOSHIBA 512GB
...
> ps    0 : mp:6.00W operational enlat:0 exlat:0 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
> ps    1 : mp:2.40W operational enlat:0 exlat:0 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:1.90W operational enlat:0 exlat:0 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.0120W non-operational enlat:5000 exlat:25000 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0060W non-operational enlat:100000 exlat:70000 rrt:4 rrl:4
>           rwt:4 rwl:4 idle_power:- active_power:-

6 mW saved and still fairly crazy latency.  70ms means you drop a couple frames.

>
>
> NVME Identify Controller:
...
> mn      : CX2-GB1024-Q11 NVMe LITEON 1024GB
...> ps    0 : mp:8.00W operational enlat:0 exlat:0 rrt:0 rrl:0
>           rwt:0 rwl:0 idle_power:- active_power:-
> ps    1 : mp:4.00W operational enlat:5 exlat:5 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:2.10W operational enlat:5 exlat:5 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.1000W non-operational enlat:5000 exlat:5000 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0100W non-operational enlat:50000 exlat:100000 rrt:4 rrl:4
>           rwt:4 rwl:4 idle_power:- active_power:-

90mW saved and still 100ms latency.  Also, I didn't know that Lite-on
made disks.

I'm not convinced that there's any chassis type for which this type of
default makes sense.

What would perhaps make sense is to have system-wide
performance-vs-power controls and to integrate NVMe power saving into
it, presumably through the pm_qos framework.  Or to export more
information to userspace and have a user tool that sets all this up
generically.
