From: sbates@raithlin.com (Stephen Bates)
Date: Tue, 4 Oct 2016 06:42:35 -0600
Subject: PROBLEM: nvmet rxe : Kernel oops when running nvmf IO over
 rdma_rxe
In-Reply-To: <e50c485a-00b0-e896-34de-856714fcb454@grimberg.me>
References: <1475179824-10377-1-git-send-email-sbates@raithlin.com>
 <e50c485a-00b0-e896-34de-856714fcb454@grimberg.me>
Message-ID: <20161004124235.GB12272@cgy1-donard.priv.deltatee.com>


Thanks for taking a look at this Sagi. BTW I did see the nvme connect
seemed pretty stable but I will do some longer waits between the
connect and the IO steps to see if I get a panic...

> Type "apropos word" to search for commands related to "word"...
> Reading symbols from drivers/nvme/target/nvmet-rdma.ko...done.
> (gdb) l *(nvmet_rdma_free_rsps+0x80)
> 0xa20 is in nvmet_rdma_free_rsps (drivers/nvme/target/rdma.c:430).
> 425		int i, nr_rsps = queue->recv_queue_size * 2;
> 426
> 427		for (i = 0; i < nr_rsps; i++) {
> 428			struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
> 429
> 430			list_del(&rsp->free_list);
> 431			nvmet_rdma_free_rsp(ndev, rsp);
> 432		}
> 433		kfree(queue->rsps);
> 434	}
> (gdb)
> --


Oh I did addr2line on the [<ffffffff814537b9>]
nvmet_rdma_free_queue+0x49/0x90 at the top of the Call Trace. I see
you looked up the RIP line (which probably makes more sense ;-)).

>
> Anyway, this looks like a use-after-free condition. The strange thing
> is that we don't see any queues being freed twice (we have a print
> there)...
>
> I suspect that either we have some problems with the draining logic in
> rxe or, we uncovered a bug in nvmet-rdma that is triggered with rxe on
> a VM (back when I tested this I didn't get this, so things must have
> changed...)

OK I will see if I can get more information on what we might be using
after the free and report back. If anyone on the RXE side has any
ideas please chip in ;-).

Cheers

Stephen
