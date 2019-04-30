From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 30 Apr 2019 03:18:28 +0000
Subject: [PATCH V2 1/3] nvme: introduce nvme-ctrl state name string array
In-Reply-To: <091fabba-234c-d3bb-a882-43b599fb0b21@grimberg.me>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
 <20190429032442.5923-2-chaitanya.kulkarni@wdc.com>
 <067b8ef5-abea-2bc8-9da5-a39ac3b54a1b@intel.com>
 <SN6PR04MB452783333EA5F5FE1190294886390@SN6PR04MB4527.namprd04.prod.outlook.com>
 <1556580424.161891.170.camel@acm.org>
 <091fabba-234c-d3bb-a882-43b599fb0b21@grimberg.me>
Message-ID: <78EA0B2C-0CD6-4C6E-9853-AFBE6F869E6D@wdc.com>

Seems like I missed it. Let me send the V3 along with other comments from Sagi.

?On 4/29/19, 4:29 PM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    
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
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
