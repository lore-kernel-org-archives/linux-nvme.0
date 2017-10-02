From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:25:26 +0200
Subject: [PATCH] nvme: reset retires after path failover
In-Reply-To: <mqdtvzh38xd.fsf@linux-x5ow.site>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <20171002143503.14507-1-jthumshirn@suse.de> <mqdtvzh38xd.fsf@linux-x5ow.site>
Message-ID: <20171002162526.GB11497@lst.de>

On Mon, Oct 02, 2017@04:45:34PM +0200, Johannes Thumshirn wrote:
> Gah, please ignore this one. I tested on the wrong device.
> 
> But FYI, when triggering a path failure in my RDMA setup (setting one
> switch port down) I get these nice messages:
> [ 1148.124063] nvme nvme0: SEND for CQE 0xffff8817c3720180 failed with
> status transport retry counter exceeded (12)
> [ 1148.180489] nvme nvme0: failed nvme_keep_alive_end_io error=10
> [ 1148.187887] nvme nvme0: Reconnecting in 10 seconds...
> [ 1148.194356] print_req_error: I/O error, dev nvme0n1, sector 1690128
> [ 1148.194361] print_req_error: I/O error, dev nvme0n1, sector 1692168
> [ 1148.194367] print_req_error: I/O error, dev nvme0n1, sector 1694208
> [ 1148.379058] XFS (nvms0n1): writeback error on sector 1628688
> 
> the nvme ones are expected, but I don't really like to see writeback
> errors from the FS here. Something's still a bit off.

I think the problem is our host-internal aborts that have the DNR
bit set.  My earier patches excluded DNR as a reason not to failover
and we'll either need to get back to that or remove DNR from these
sorts of errors.
