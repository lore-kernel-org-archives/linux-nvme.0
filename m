From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 25 Feb 2019 06:49:04 -0800
Subject: [PATCH] nvmet: disable direct I/O when unavailable
In-Reply-To: <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
References: <20190221182234.22345-1-jthumshirn@suse.de>
 <SN6PR04MB4527A810D247541AA7C4A512867F0@SN6PR04MB4527.namprd04.prod.outlook.com>
 <6c3fa30a-d516-a453-a001-1014202ff9ce@suse.de>
 <9d8e96de-d68d-8961-21e8-4cb8e79b4a08@mellanox.com>
 <2185e4e5-086a-d0c2-0fee-a7a5c98267bb@suse.de>
Message-ID: <a85e85d6-6a06-7663-3a12-710b6467dedd@acm.org>

On 2/25/19 1:37 AM, Johannes Thumshirn wrote:
> On 24/02/2019 11:54, Max Gurtovoy wrote:
>> What is the status of iSCSI/SRP targets in this case ?
> 
> iSCSI/SRP passes in the following:
> 
>   /*
>    * Use O_DSYNC by default instead of O_SYNC to forgo syncing
>    * of pure timestamp updates.
>    */
>   flags = O_RDWR | O_CREAT | O_LARGEFILE | O_DSYNC;

That code fragment comes from the LIO file backend. There is no 
requirement for a SCSI target core file backend to use O_DSYNC. SCST 
allows users to choose whether or not O_DSYNC should be used:

	if (virt_dev->wt_flag && !virt_dev->nv_cache)
		open_flags |= O_DSYNC;

Bart.
