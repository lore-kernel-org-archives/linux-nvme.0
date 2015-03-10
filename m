From: david.darrington@hgst.com (David Darrington)
Date: Tue, 10 Mar 2015 19:11:50 +0000
Subject: NVMe driver status
In-Reply-To: <002501d05b45$cbc9b790$635d26b0$@samsung.com>
References: <004b01d033df$9d6c2be0$d84483a0$@samsung.com>
 <alpine.LNX.2.00.1501191414000.15481@localhost.lm.intel.com>
 <000d01d034a8$fa00f060$ee02d120$@samsung.com>
 <alpine.LNX.2.00.1501201537470.15481@localhost.lm.intel.com>
 <002501d05b45$cbc9b790$635d26b0$@samsung.com>
Message-ID: <BN3PR0401MB144453DABCDC7F809E4DE017FD180@BN3PR0401MB1444.namprd04.prod.outlook.com>

I'm interested in this also. I know that the there is a quarterly planning call for the ofed Windows NVMe driver. Would there be any interest in having occasional conference calls to discuss items such as these? I would be glad to setup a call, as long as Keith and/or Mathew agree that it is worthwhile and can attend.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Sunad Bhandary
Sent: Tuesday, March 10, 2015 10:21 AM
To: 'Keith Busch'
Cc: linux-nvme at lists.infradead.org
Subject: RE: NVMe driver status

Hi Keith,
Can we initiate some activity on the legacy-nvme maintenance?
 
Can you commit the async controller probe patch for the legacy driver also?
Or I can do this if you want.
Also, I'll be submitting the legacy-nvme version for a couple of patches that we already submitted (write_long, split i/o in IOCtl path).

Going forward, how will the legacy-nvme be maintained?
The legacy-nvme was removed in 3.19. So are we going to have some restrictions on the kernel versions supported by legacy nvme driver

Regards,
Sunad

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Tuesday, January 20, 2015 9:17 PM
To: Sunad Bhandary
Cc: 'Keith Busch'; linux-nvme at lists.infradead.org
Subject: RE: NVMe driver status

Okay, I added the repo to here:

http://git.infradead.org/users/kbusch/nvme-legacy.git

It's based off linux-stable v3.18.3, plus a merge from linux-nvme for nvme parts that were not committed upstream by 3.18.

I don't know what kind of activity to expect this will get, but I'll be happy to merge applicable upstream commits and apply patches for any new features or bug fixes people want to see in the bio-based nvme driver.

On Tue, 20 Jan 2015, Sunad Bhandary wrote:
> Hi Keith,
>
> Thanks for clarifying the situation.
>
> If suppose the bio-based driver version is pushed out to a public 
> repo, will it be made  just a source repo or will it be actively 
> maintained where new patches are acceptable and can be merged into the 
> repo ?
>
> Thanks and regards,
> Sunad
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On 
> Behalf Of Keith Busch
> Sent: Monday, January 19, 2015 8:03 PM
> To: Sunad Bhandary
> Cc: 'Keith Busch'; linux-nvme at lists.infradead.org
> Subject: Re: NVMe driver status
>
> Hi Sunad,
>
> The mainline going forward with kernel 3.19 will be blk-mq, and the 
> linux-nvme tree will be there as well on the next upstream merge.
>
> I have my own repo for maintaining the bio-based version since a lot 
> of OS vendors are using older kernels in their minor release cycles. I 
> can push this out to a public repo on git.infradead.org if there's
interest.
>
> Thanks,
> Keith
>
> On Mon, 19 Jan 2015, Sunad Bhandary wrote:
>> Hi Keith,
>>
>> Currently there are two different variants of the NVMe driver, one 
>> with the multi-queue implementation which is under active development 
>> and the one without it which is the current driver hosted in the NVMe 
>> git
> page.
>>
>> Going forward will the non-multi queue  driver also be maintained or 
>> will it be done away with completely ?
>>
>> Regards,
>> Sunad
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
