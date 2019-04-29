From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Apr 2019 16:29:00 -0700
Subject: [PATCH V2 1/3] nvme: introduce nvme-ctrl state name string array
In-Reply-To: <1556580424.161891.170.camel@acm.org>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
 <20190429032442.5923-2-chaitanya.kulkarni@wdc.com>
 <067b8ef5-abea-2bc8-9da5-a39ac3b54a1b@intel.com>
 <SN6PR04MB452783333EA5F5FE1190294886390@SN6PR04MB4527.namprd04.prod.outlook.com>
 <1556580424.161891.170.camel@acm.org>
Message-ID: <091fabba-234c-d3bb-a882-43b599fb0b21@grimberg.me>


>>> I haven't been paying attention if this was bought up before but won't
>>> this create multiple copies of this data for every source file the
>>> includes the header file?
>>
>> Yes, we did discuss this.
> 
> Hi Chaitanya,
> 
> In an e-mail from Christoph I found the following recommendation with regard
> to the nvme_ctrl_state_name[] array: "Just keep it near the top of multipath.c."
> and you replied "Okay, that works too."
> 
> Did I perhaps miss something?

That was my recollection too...
