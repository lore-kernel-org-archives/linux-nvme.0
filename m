From: brandon.schulz@hgst.com (Brandon Schulz)
Date: Wed, 11 Mar 2015 18:06:01 +0000
Subject: NVMe driver status
In-Reply-To: <alpine.LNX.2.00.1503101947270.32385@localhost.lm.intel.com>
References: <004b01d033df$9d6c2be0$d84483a0$@samsung.com>
 <alpine.LNX.2.00.1501191414000.15481@localhost.lm.intel.com>
 <000d01d034a8$fa00f060$ee02d120$@samsung.com>
 <alpine.LNX.2.00.1501201537470.15481@localhost.lm.intel.com>
 <002501d05b45$cbc9b790$635d26b0$@samsung.com>
 <BN3PR0401MB144453DABCDC7F809E4DE017FD180@BN3PR0401MB1444.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503101947270.32385@localhost.lm.intel.com>
Message-ID: <BN1PR0401MB093160344D56E4DE445069D3F2190@BN1PR0401MB0931.namprd04.prod.outlook.com>

Is there any kind of coordination among contributors on backports to legacy-nvme or is it just kind of a free-for-all until someone submits a patch on this list?

Thanks,
Brandon


Brandon Schulz
Systems & Software Architect 
SSD Device Development 
HGST, a Western Digital company
brandon.schulz at hgst.com
o: (507) 322-2257 
 
3605 Hwy 52 N 
Rochester, MN 55901
www.hgst.com


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Tuesday, March 10, 2015 3:02 PM
To: David Darrington
Cc: 'Keith Busch'; linux-nvme at lists.infradead.org; Sunad Bhandary
Subject: RE: NVMe driver status

I'm happy to apply requested changes. I can't necessarily guarantee a particular deadline, though I try to align with interested OS vendors ahead of their release updates if they're using the older version.

Specifically on async probe and others, I'll get these merged in later this week.

On Tue, 10 Mar 2015, David Darrington wrote:
> I'm interested in this also. I know that the there is a quarterly planning call for the ofed Windows NVMe driver. Would there be any interest in having occasional conference calls to discuss items such as these? I would be glad to setup a call, as long as Keith and/or Mathew agree that it is worthwhile and can attend.
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On 
> Behalf Of Sunad Bhandary
> Sent: Tuesday, March 10, 2015 10:21 AM
> To: 'Keith Busch'
> Cc: linux-nvme at lists.infradead.org
> Subject: RE: NVMe driver status
>
> Hi Keith,
> Can we initiate some activity on the legacy-nvme maintenance?
>
> Can you commit the async controller probe patch for the legacy driver also?
> Or I can do this if you want.
> Also, I'll be submitting the legacy-nvme version for a couple of patches that we already submitted (write_long, split i/o in IOCtl path).
>
> Going forward, how will the legacy-nvme be maintained?
> The legacy-nvme was removed in 3.19. So are we going to have some 
> restrictions on the kernel versions supported by legacy nvme driver

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
