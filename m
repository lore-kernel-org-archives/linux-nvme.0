From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 11 Jul 2018 10:04:37 -0600
Subject: [PATCH v2 1/2] nvme-pci: release iomap and prp_pools in
 nvme_pci_free_ctrl
In-Reply-To: <CAA70yB7J3hSVrpKXDK0V8dYo31qFGzA8RVyRxvaG4eUT6ehTeg@mail.gmail.com>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
 <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>
 <20180710144510.GB11548@localhost.localdomain>
 <CAA70yB6+DKHz0wzXoRyBCv5+TxkKZzDSQajhCf6qT45zLaLCow@mail.gmail.com>
 <20180711150311.GE11548@localhost.localdomain>
 <CAA70yB7J3hSVrpKXDK0V8dYo31qFGzA8RVyRxvaG4eUT6ehTeg@mail.gmail.com>
Message-ID: <20180711160437.GA14205@localhost.localdomain>

On Wed, Jul 11, 2018@11:38:08PM +0800, Weiping Zhang wrote:
> Keith Busch <keith.busch at linux.intel.com> ?2018?7?11??? ??11:03???
> >
> > 8.1: Hot remove /dev/nvme0
> Do you means  "rm -f /dev/nvme0" ?

I mean remove the device from the pci topology, either physically
or simulate with 'echo 1 > /sys/class/nvme/nvme0/device/remove'.
