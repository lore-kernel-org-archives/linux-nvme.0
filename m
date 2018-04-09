From: hch@lst.de (Christoph Hellwig)
Date: Mon, 9 Apr 2018 08:50:07 +0200
Subject: [PATCH] nvme: fix flush dependency in delete controller flow
In-Reply-To: <adef82fc-485d-f6a1-4fe1-5a7414940fe5@mellanox.com>
References: <20180405085438.GC2286@lst.de>
 <20180405131426.GL3948@linux.vnet.ibm.com>
 <20180405160852.GA11416@linux.vnet.ibm.com> <20180405195512.GA12678@lst.de>
 <20180406001811.GQ3948@linux.vnet.ibm.com> <20180406061920.GA20628@lst.de>
 <20180406163038.GU3948@linux.vnet.ibm.com>
 <bdb69d1a-07fc-683c-4f3f-a80b830109e4@mellanox.com>
 <20180408164803.GQ3948@linux.vnet.ibm.com>
 <adef82fc-485d-f6a1-4fe1-5a7414940fe5@mellanox.com>
Message-ID: <20180409065007.GA7760@lst.de>

On Mon, Apr 09, 2018@09:39:01AM +0300, Nitzan Carmi wrote:
> I'll be honored :-).
>
> Tested-by: Nitzan Carmi <nitzanc at mellanox.com>

Paul, Nitzan - how do we want to handle the new series?  Might make
sense to add the nvme path to the rcu series?  Nitzan, can you send
the patch to linux-nvme and Paul?
