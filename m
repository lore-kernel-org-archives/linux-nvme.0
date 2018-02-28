From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Feb 2018 08:53:53 -0700
Subject: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
In-Reply-To: <cc46058f-bb7a-e108-c6e9-621daddae577@oracle.com>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
 <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>
 <20180228152741.GA16002@localhost.localdomain>
 <8066e06c-90f4-c21b-e36f-89f6e8ca28c5@oracle.com>
 <cc46058f-bb7a-e108-c6e9-621daddae577@oracle.com>
Message-ID: <20180228155353.GB16002@localhost.localdomain>

On Wed, Feb 28, 2018@11:46:20PM +0800, jianchao.wang wrote:
> 
> the irqbalance may migrate the adminq irq away from cpu0.

No, irqbalance can't touch managed IRQs. See irq_can_set_affinity_usr().
