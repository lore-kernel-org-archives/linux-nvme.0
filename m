From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 25 Jul 2018 11:58:53 -0600
Subject: [PATCH v4 3/3] nvme: use blk API to remap ref tags for IOs with
 metadata
In-Reply-To: <1532533577-1600-3-git-send-email-maxg@mellanox.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
 <1532533577-1600-3-git-send-email-maxg@mellanox.com>
Message-ID: <20180725175853.GB16208@localhost.localdomain>

On Wed, Jul 25, 2018@06:46:17PM +0300, Max Gurtovoy wrote:
> Also moved the logic of the remapping to the nvme core driver instead
> of implementing it in the nvme pci driver. This way all the other nvme
> transport drivers will benefit from it (in case they'll implement metadata
> support).

I'm afraid I won't be able to test any of this in the near future, but
the code looks good to me!

Acked-by: Keith Busch <keith.busch at intel.com>
