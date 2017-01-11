From: m@bjorling.me (Matias Bjorling)
Date: Wed, 11 Jan 2017 07:06:12 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
In-Reply-To: <03f7ac72-c0a6-3101-7f07-e8322dcd32f5@wdc.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
 <20170104165745.7uuwl6phm6g6kouu@thunk.org>
 <1b457b77-34d8-ab82-ae1d-279e86053af9@wdc.com>
 <20170110042442.ixxxi4yhj5gu7byh@thunk.org>
 <ddeefd67-afb6-72a4-f59b-6fe623fbfbc3@bjorling.me>
 <03f7ac72-c0a6-3101-7f07-e8322dcd32f5@wdc.com>
Message-ID: <9f8b4f74-c48a-1b66-8870-a2610306345b@bjorling.me>

On 01/11/2017 05:07 AM, Damien Le Moal wrote:
> 
> Matias,
> 
> On 1/10/17 22:06, Matias Bjorling wrote:
>> On 01/10/2017 05:24 AM, Theodore Ts'o wrote:
>>> This may be an area where if we can create the right framework, and
>>> fund some research work, we might be able to get some researchers and
>>> their graduate students interested in doing some work in figuring out
>>> what sort of divisions of responsibilities and hints back and forth
>>> between the storage device and host have the most benefit.
>>>
>>
>> That is a good idea. There is a couple of papers at FAST with
>> Open-Channel SSDs this year.  They look into the interface and various
>> ways to reduce latency fluctuations.
>>
>> One thing I've heard a couple of times is the feature to move the GC
>> read/write process into the firmware. Enabling the host to offload GC
>> data movement, while the keeping the host in control. Would this be
>> beneficial for SMR?
> 
> Host-aware SMR drives already have GC internally implemented (for cases
> when the host does not write sequentially). Host-managed drives do not.
> As for moving an application specific GC code into the device, well,
> code injection in the storage device is not for tomorrow, and likely not
> ever.
> 
> There are however other clever ways to reduce GC related host overhead
> with basic commands. For SCSI, these may be WRITE SCATTERED, EXTENDED
> COPY, and some others can greatly improve overhead over a simple
> read+write loop. A better approach to GC offload may not be a "GC"
> command, but something more generic for moving around LBAs internally
> within the device. That is, if existing commands are not satisfactory.

Hi Damien,

You're right. I was thinking of something similar to scattered
read/write to move data from one place to another. There is no
sector-granularity mapping table maintained by the OCSSD, which leaves
the logic up to the host.

Let me know if you decide to kick of a standardized interface for code
injection. Such an interface is long overdue. ;)
