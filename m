From: kbusch@kernel.org (Keith Busch)
Date: Wed, 6 Mar 2019 13:49:58 -0700
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <SN6PR04MB4527804E0DF20A373E42BC2986730@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190305095548.14934-1-sagi@grimberg.me>
 <SN6PR04MB4527C36DBCE293BDA6A7508786730@SN6PR04MB4527.namprd04.prod.outlook.com>
 <2a38f63f-2349-e852-e24e-a046a64bc923@grimberg.me>
 <SN6PR04MB4527804E0DF20A373E42BC2986730@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190306204958.GA1603@localhost.localdomain>

On Wed, Mar 06, 2019@08:38:21PM +0000, Chaitanya Kulkarni wrote:
> On 3/6/19 12:19 PM, Sagi Grimberg wrote:
> > Quick look shows that this is coming from blk_queue_stack_limits for the
> > ns_head.
> > 
> > Looks like nvme_update_disk_info() is reading a bs=0:
> > --
> >           unsigned short bs = 1 << ns->lba_shift;
> > --
> > 
> > bs is 16 bits and lba_shift is 20
> > (coming directly from the tempfile file_inode(ns->file)->i_blkbits)
> > 
> > So this fixes that one as well. Regardless, I think bs should be
> > unsigned int?
> 
> Yes.

blk_queue_logical_block_size() takes an 'unsigned short', so be sure to
check 'bs' is less than USHRT_MAX.
