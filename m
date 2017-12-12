From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Dec 2017 17:00:48 -0700
Subject: Block Integrity Rq Count Question
In-Reply-To: <MWHPR04MB102571849DD1D1ACD58670DBEA370@MWHPR04MB1025.namprd04.prod.outlook.com>
References: <MWHPR04MB1025EDA7D10216C24D00C573EA300@MWHPR04MB1025.namprd04.prod.outlook.com>
 <20171208221946.GB26887@localhost.localdomain>
 <MWHPR04MB102571849DD1D1ACD58670DBEA370@MWHPR04MB1025.namprd04.prod.outlook.com>
Message-ID: <20171212000047.GE11218@localhost.localdomain>

On Mon, Dec 11, 2017@05:54:35PM +0000, Jeffrey Lien wrote:
> Keith,
> Your comment below makes sense, but I still have a question.   Where in the driver (or maybe it's block layer) is metadata pointer allocated?   I can't find where that happens in the nvme driver so does this happen in the block layer?   And how do we control whether or not it's 1 contiguous buffer or not?

The function 'nvme_init_integrity' sets up our metadata
profile and requests single metadata payload segments with
'blk_queue_max_integrity_segments(disk->queue, 1)', so the fact
that you're getting multiple segments in your payload suggests some
inappropriate merging is going on in the block layer. It looks like
blk_integrity_merge_{bio,rq} are doing the right thing.
