From: pmenzel+linux-nvme@molgen.mpg.de (Paul Menzel)
Date: Wed, 24 Jan 2018 23:29:12 +0100
Subject: Report long suspend times of NVMe devices (mostly firmware/device
 issues)
In-Reply-To: <20180122213024.GR12043@localhost.localdomain>
References: <9e398971-762d-bb1a-f798-bf0b18cb5b6b@molgen.mpg.de>
 <20180122213024.GR12043@localhost.localdomain>
Message-ID: <fd0eb2c3-56c3-0e81-cfba-1ffa6a872efd@molgen.mpg.de>

Dear Keith,


Thank you for your reply.

Am 22.01.2018 um 22:30 schrieb Keith Busch:
> On Mon, Jan 22, 2018@10:02:12PM +0100, Paul Menzel wrote:

>> Benchmarking the ACPI S3 suspend and resume times with `sleepgraph.py
>> -config config/suspend-callgraph.cfg` [1], shows that the NVMe disk SAMSUNG
>> MZVKW512HMJP-00000 in the TUXEDO Book BU1406 takes between 0.3 and 1.4
>> seconds, holding up the suspend cycle.
>>
>> The time is spent in `nvme_shutdown_ctrl()`.
>>
>> ### Linux 4.14.1-041401-generic
>>
>>> nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 1439.299 ms Total Resume: 19.865 ms)
>>
>> ### Linux 4.15-rc9
>>
>>> nvme @ 0000:04:00.0 {nvme} async_device (Total Suspend: 362.239 ms Total Resume: 19.897 m
>> It?d be useful, if the Linux kernel logged such issues visibly to the user,
>> so that the hardware manufacturer can be contacted to fix the device
>> (probably the firmware).
>>
>> In my opinion anything longer than 200 ms should be reported similar to [2],
>> and maybe worded like below.
>>
>>> NVMe took more than 200 ms to do suspend routine
>>
>> What do you think?
> 
> The nvme spec guides toward longer times than that. I don't see the
> point of warning users about things operating within spec.

I quickly glanced over NVM Express revision 1.3 specification [1] but 
searching for *second *, I could not find something about this. Could 
you please point me to the section?

In my opinion, it?s a good thing to point users to devices holding up 
suspend.


Kind regards,

Paul


[1] https://nvmexpress.org/wp-content/uploads/NVM_Express_Revision_1.3.pdf
