From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Jan 2015 15:46:36 +0000 (UTC)
Subject: NVMe driver status
In-Reply-To: <000d01d034a8$fa00f060$ee02d120$@samsung.com>
References: <004b01d033df$9d6c2be0$d84483a0$@samsung.com>
 <alpine.LNX.2.00.1501191414000.15481@localhost.lm.intel.com>
 <000d01d034a8$fa00f060$ee02d120$@samsung.com>
Message-ID: <alpine.LNX.2.00.1501201537470.15481@localhost.lm.intel.com>

Okay, I added the repo to here:

http://git.infradead.org/users/kbusch/nvme-legacy.git

It's based off linux-stable v3.18.3, plus a merge from linux-nvme for
nvme parts that were not committed upstream by 3.18.

I don't know what kind of activity to expect this will get, but I'll be
happy to merge applicable upstream commits and apply patches for any new
features or bug fixes people want to see in the bio-based nvme driver.

On Tue, 20 Jan 2015, Sunad Bhandary wrote:
> Hi Keith,
>
> Thanks for clarifying the situation.
>
> If suppose the bio-based driver version is pushed out to a public repo, will
> it be made  just a source repo or
> will it be actively maintained where new patches are acceptable and can be
> merged into the repo ?
>
> Thanks and regards,
> Sunad
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Keith Busch
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
> I have my own repo for maintaining the bio-based version since a lot of OS
> vendors are using older kernels in their minor release cycles. I can push
> this out to a public repo on git.infradead.org if there's interest.
>
> Thanks,
> Keith
>
> On Mon, 19 Jan 2015, Sunad Bhandary wrote:
>> Hi Keith,
>>
>> Currently there are two different variants of the NVMe driver, one
>> with the multi-queue implementation which is under active development
>> and the one without it which is the current driver hosted in the NVMe git
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
