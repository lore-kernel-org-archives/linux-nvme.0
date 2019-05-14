From: kbusch@kernel.org (Keith Busch)
Date: Tue, 14 May 2019 16:22:01 -0600
Subject: PROBLEM: call trace triggered in 5.1.1 in
 drivers/nvme/host/pci.c, 5.0.11 ok
In-Reply-To: <CAC=wYCFzdNNiaXWoAEMoj00f5enk3mJzQrUL9CjZD2RRRxAXNg@mail.gmail.com>
References: <CAC=wYCGgPQPjUUjQTZh4H7b8WRQFGmbKCBRAq75g1BXjBR0L0Q@mail.gmail.com>
 <20190514052027.GB6294@lst.de>
 <CAC=wYCFhKR5YrAwL1agz=USg3DAkx5BtXAfv64nOfTrwTji40Q@mail.gmail.com>
 <20190514055832.GA6843@lst.de>
 <CAC=wYCECcfqoDDMcgVj-4dAEUxNpY62vAEMOD8-eGrZK8wOV-g@mail.gmail.com>
 <20190514135434.GA19837@localhost.localdomain>
 <20190514141220.GA25519@ming.t460p> <20190514141439.GA14213@lst.de>
 <CAC=wYCFzdNNiaXWoAEMoj00f5enk3mJzQrUL9CjZD2RRRxAXNg@mail.gmail.com>
Message-ID: <20190514222201.GD19977@localhost.localdomain>

On Wed, May 15, 2019@08:14:22AM +1000, Adam Carter wrote:
> >
> > Or this one posted yesterday for that matter:
> >
> > https://marc.info/?l=linux-block&m=155772952511144&w=2
> >
> 
> I have re-tested and the issue is fixed for me with the above. Many thanks.

Thank you for verifying.

Replying in plain-text for the mailing lists (they'll reject html
messages, just for future reference), and I assume your response is
providing a Tested-by notice for Christoph's patch.


> Here's my working;
> cd /usr/src
> cp -a linux-5.1.1-gentoo linux-5.1.1-gentoo-patched
> rm linux
> ln -s linux-5.1.1-gentoo-patched linux
> cd linux
> cp ~adam/block.patch
> patch -p0 <block.patch
> patching file block/blk-settings.c
> Hunk #1 succeeded at 309 (offset -1 lines).
> Hunk #2 succeeded at 760 (offset 15 lines).
> make -j8 && make modules_install && make install && grub-mkconfig -o
> /boot/grub/grub.cfg && emerge -1 virtualbox-modules
> 
> Where block.patch is;
> # cat block.patch
> --- block/blk-settings.c
> +++ block/blk-settings.c
> @@ -310,6 +310,9 @@ void blk_queue_max_segment_size(struct request_queue
> *q, unsigned int max_size)
>                 __func__, max_size);
>      }
> 
> +    /* see blk_queue_virt_boundary() for the explanation */
> +    WARN_ON_ONCE(q->limits.virt_boundary_mask);
> +
>      q->limits.max_segment_size = max_size;
>  }
>  EXPORT_SYMBOL(blk_queue_max_segment_size);
> @@ -742,6 +745,14 @@ EXPORT_SYMBOL(blk_queue_segment_boundary);
>  void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
>  {
>      q->limits.virt_boundary_mask = mask;
> +
> +    /*
> +     * Devices that require a virtual boundary do not support
> scatter/gather
> +     * I/O natively, but instead require a descriptor list entry for each
> +     * page (which might not be idential to the Linux PAGE_SIZE).  Because
> +     * of that they are not limited by our notion of "segment size".
> +     */
> +    q->limits.max_segment_size = UINT_MAX;
>  }
>  EXPORT_SYMBOL(blk_queue_virt_boundary);
> 
> -- 
> 2.20.1
