From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 2 Jul 2017 13:45:49 +0300
Subject: NVMe induced NULL deref in bt_iter()
In-Reply-To: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
References: <bcc46757-6027-ed7f-22b4-e6964d0dedf0@kernel.dk>
Message-ID: <9afc0fd3-e598-dea9-a505-d8fa0f608d16@mellanox.com>



On 6/30/2017 8:26 PM, Jens Axboe wrote:
> Hi Max,

Hi Jens,

>
> I remembered you reporting this. I think this is a regression introduced
> with the scheduling, since ->rqs[] isn't static anymore. ->static_rqs[]
> is, but that's not indexable by the tag we find. So I think we need to
> guard those with a NULL check. The actual requests themselves are
> static, so we know the memory itself isn't going away. But if we race
> with completion, we could find a NULL there, validly.
>
> Since you could reproduce it, can you try the below?

I still can repro the null deref with this patch applied.

>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d0be72ccb091..b856b2827157 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -214,7 +214,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  		bitnr += tags->nr_reserved_tags;
>  	rq = tags->rqs[bitnr];
>
> -	if (rq->q == hctx->queue)
> +	if (rq && rq->q == hctx->queue)
>  		iter_data->fn(hctx, rq, iter_data->data, reserved);
>  	return true;
>  }
> @@ -249,8 +249,8 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>  	if (!reserved)
>  		bitnr += tags->nr_reserved_tags;
>  	rq = tags->rqs[bitnr];
> -
> -	iter_data->fn(rq, iter_data->data, reserved);
> +	if (rq)
> +		iter_data->fn(rq, iter_data->data, reserved);
>  	return true;
>  }

see the attached file for dmesg output.

output of gdb:

(gdb) list *(blk_mq_flush_busy_ctxs+0x48)
0xffffffff8127b108 is in blk_mq_flush_busy_ctxs 
(./include/linux/sbitmap.h:234).
229
230             for (i = 0; i < sb->map_nr; i++) {
231                     struct sbitmap_word *word = &sb->map[i];
232                     unsigned int off, nr;
233
234                     if (!word->word)
235                             continue;
236
237                     nr = 0;
238                     off = i << sb->shift;


when I change the "if (!word->word)" to  "if (word && !word->word)"
I can get null deref at "nr = find_next_bit(&word->word, word->depth, 
nr);". Seems like somehow word becomes NULL.

Adding the linux-nvme guys too.
Sagi has mentioned that this can be null only if we remove the tagset 
while I/O is trying to get a tag and when killing the target we get into
error recovery and periodic reconnects, which does _NOT_ include freeing
the tagset, so this is probably the admin tagset.

Sagi,
you've mention a patch for centrelizing the treatment of the admin 
tagset to the nvme core. I think I missed this patch, so can you please 
send a pointer to it and I'll check if it helps ?


-------------- next part --------------
Linux version 4.12.0-rc5+ (root at rsws34) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-3) (GCC) ) #62 SMP Mon Jun 19 15:33:59 IDT 2017
nvme nvme0: creating 24 I/O queues.
nvme nvme0: new ctrl: NQN "subsystem_rsws33.mtr.labs.mlnx_1", addr 11.212.40.110:1023
perf: interrupt took too long (2502 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
perf: interrupt took too long (3128 > 3127), lowering kernel.perf_event_max_sample_rate to 63000
perf: interrupt took too long (3918 > 3910), lowering kernel.perf_event_max_sample_rate to 51000
perf: interrupt took too long (4903 > 4897), lowering kernel.perf_event_max_sample_rate to 40000
blk_update_request: I/O error, dev nvme0n1, sector 486252953
blk_update_request: I/O error, dev nvme0n1, sector 254324451
blk_update_request: I/O error, dev nvme0n1, sector 486828506
blk_update_request: I/O error, dev nvme0n1, sector 175268160
blk_update_request: I/O error, dev nvme0n1, sector 204249372
blk_update_request: I/O error, dev nvme0n1, sector 45725385
blk_update_request: I/O error, dev nvme0n1, sector 503167578
blk_update_request: I/O error, dev nvme0n1, sector 220671103
blk_update_request: I/O error, dev nvme0n1, sector 351009498
blk_update_request: I/O error, dev nvme0n1, sector 509040223
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
Buffer I/O error on dev nvme0n100, logical block 65535984, async page read
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
Buffer I/O error on dev nvme0n100, logical block 65535998, async page read
Buffer I/O error on dev nvme0n100, logical block 0, async page read
Buffer I/O error on dev nvme0n100, logical block 1, async page read
Buffer I/O error on dev nvme0n1, logical block 65535984, async page read
Buffer I/O error on dev nvme0n10, logical block 65535984, async page read
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
Buffer I/O error on dev nvme0n1, logical block 65535998, async page read
Buffer I/O error on dev nvme0n10, logical block 65535998, async page read
Buffer I/O error on dev nvme0n1, logical block 0, async page read
Buffer I/O error on dev nvme0n1, logical block 1, async page read
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme nvme0: rescanning
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: rescanning
BUG: unable to handle kernel NULL pointer dereference at           (null)
nvme nvme0: Reconnecting in 10 seconds...
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#1] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 1 PID: 973 Comm: kworker/1:1H Tainted: G            E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046daa2a40 task.stack: ffffc9000497c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc9000497fba8 EFLAGS: 00010246
RAX: ffffc9000497fc18 RBX: 0000000000000000 RCX: ffff8804572f0040
RDX: ffff8804458b7ca0 RSI: ffffc9000497fc18 RDI: ffff8804572f0000
RBP: ffffc9000497fbf8 R08: 0000000000000001 R09: fffffffffff68c3c
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804572f00d8
R13: ffffc9000497fbb8 R14: ffff8804572f0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fa40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc9000497fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce3 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#2] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 2 PID: 5734 Comm: kworker/2:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046a9dc1c0 task.stack: ffffc90004f1c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004f1fba8 EFLAGS: 00010246
RAX: ffffc90004f1fc18 RBX: 0000000000000000 RCX: ffff880457300040
RDX: ffff8804458b7cc0 RSI: ffffc90004f1fc18 RDI: ffff880457300000
RBP: ffffc90004f1fbf8 R08: 0000000000000001 R09: fffffffffff69477
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573000d8
R13: ffffc90004f1fbb8 R14: ffff880457300000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004f1fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce4 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#3] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 3 PID: 4319 Comm: kworker/3:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff880467c78640 task.stack: ffffc90006efc000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90006effba8 EFLAGS: 00010246
RAX: ffffc90006effc18 RBX: 0000000000000000 RCX: ffff880457320040
RDX: ffff8804458b7ce0 RSI: ffffc90006effc18 RDI: ffff880457320000
RBP: ffffc90006effbf8 R08: 0000000000000001 R09: fffffffffff69c47
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573200d8
R13: ffffc90006effbb8 R14: ffff880457320000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 ? pick_next_entity+0x7b/0x120
 worker_thread+0x77/0x420
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90006effba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce5 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#4] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 4 PID: 1029 Comm: kworker/4:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046c46a7c0 task.stack: ffffc90004974000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004977ba8 EFLAGS: 00010246
RAX: ffffc90004977c18 RBX: 0000000000000000 RCX: ffff880457330040
RDX: ffff8804458b7d00 RSI: ffffc90004977c18 RDI: ffff880457330000
RBP: ffffc90004977bf8 R08: 0000000000000001 R09: fffffffffff6a46a
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573300d8
R13: ffffc90004977bb8 R14: ffff880457330000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004977ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce6 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#5] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 5 PID: 964 Comm: kworker/5:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046cd1e5c0 task.stack: ffffc90004044000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004047ba8 EFLAGS: 00010246
RAX: ffffc90004047c18 RBX: 0000000000000000 RCX: ffff880457340040
RDX: ffff8804458b7d20 RSI: ffffc90004047c18 RDI: ffff880457340000
RBP: ffffc90004047bf8 R08: 0000000000000001 R09: fffffffffff6accd
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573400d8
R13: ffffc90004047bb8 R14: ffff880457340000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fb40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004047ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce7 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#6] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 7 PID: 976 Comm: kworker/7:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086dce2500 task.stack: ffffc90004064000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004067ba8 EFLAGS: 00010246
RAX: ffffc90004067c18 RBX: 0000000000000000 RCX: ffff880850ab0040
RDX: ffff8808509a9ba0 RSI: ffffc90004067c18 RDI: ffff880850ab0000
RBP: ffffc90004067bf8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850ab00d8
R13: ffffc90004067bb8 R14: ffff880850ab0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fa40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004067ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce8 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#7] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 6 PID: 936 Comm: kworker/6:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086cede840 task.stack: ffffc90004034000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004037ba8 EFLAGS: 00010246
RAX: ffffc90004037c18 RBX: 0000000000000000 RCX: ffff880850aa0040
RDX: ffff8808509a9bc0 RSI: ffffc90004037c18 RDI: ffff880850aa0000
RBP: ffffc90004037bf8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850aa00d8
R13: ffffc90004037bb8 R14: ffff880850aa0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004037ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ce9 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#8] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 8 PID: 1211 Comm: kworker/8:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086c20e540 task.stack: ffffc90004084000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004087ba8 EFLAGS: 00010246
RAX: ffffc90004087c18 RBX: 0000000000000000 RCX: ffff880850ac0040
RDX: ffff8808509a9b80 RSI: ffffc90004087c18 RDI: ffff880850ac0000
RBP: ffffc90004087bf8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850ac00d8
R13: ffffc90004087bb8 R14: ffff880850ac0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004087ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cea ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#9] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 9 PID: 949 Comm: kworker/9:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086e3e01c0 task.stack: ffffc90003ef0000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003ef3ba8 EFLAGS: 00010246
RAX: ffffc90003ef3c18 RBX: 0000000000000000 RCX: ffff880850ad0040
RDX: ffff8808509a9b60 RSI: ffffc90003ef3c18 RDI: ffff880850ad0000
RBP: ffffc90003ef3bf8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850ad00d8
R13: ffffc90003ef3bb8 R14: ffff880850ad0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fac0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003ef3ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ceb ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#10] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 10 PID: 950 Comm: kworker/10:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086e3dc180 task.stack: ffffc90003f50000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003f53ba8 EFLAGS: 00010246
RAX: ffffc90003f53c18 RBX: 0000000000000000 RCX: ffff880850ae0040
RDX: ffff8808509a9b40 RSI: ffffc90003f53c18 RDI: ffff880850ae0000
RBP: ffffc90003f53bf8 R08: 0000000000000001 R09: fffffffffff6d8a7
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850ae00d8
R13: ffffc90003f53bb8 R14: ffff880850ae0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003f53ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cec ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#11] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 11 PID: 960 Comm: kworker/11:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086c0a40c0 task.stack: ffffc9000400c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc9000400fba8 EFLAGS: 00010246
RAX: ffffc9000400fc18 RBX: 0000000000000000 RCX: ffff880850af0040
RDX: ffff8808509a9b20 RSI: ffffc9000400fc18 RDI: ffff880850af0000
RBP: ffffc9000400fbf8 R08: 0000000000000001 R09: fffffffffff6e0e5
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850af00d8
R13: ffffc9000400fbb8 R14: ffff880850af0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fb40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc9000400fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017ced ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#12] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 12 PID: 2505 Comm: kworker/12:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046e15a440 task.stack: ffffc90005e4c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90005e4fba8 EFLAGS: 00010246
RAX: ffffc90005e4fc18 RBX: 0000000000000000 RCX: ffff880457350040
RDX: ffff8804458b7d40 RSI: ffffc90005e4fc18 RDI: ffff880457350000
RBP: ffffc90005e4fbf8 R08: 0000000000000001 R09: fffffffffff6e459
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573500d8
R13: ffffc90005e4fbb8 R14: ffff880457350000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 ? pick_next_entity+0x7b/0x120
 worker_thread+0x77/0x420
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90005e4fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cee ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#13] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 13 PID: 1001 Comm: kworker/13:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046cfc2800 task.stack: ffffc90004674000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004677ba8 EFLAGS: 00010246
RAX: ffffc90004677c18 RBX: 0000000000000000 RCX: ffff880457360040
RDX: ffff8804458b7d60 RSI: ffffc90004677c18 RDI: ffff880457360000
RBP: ffffc90004677bf8 R08: 0000000000000001 R09: fffffffffff6f05a
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573600d8
R13: ffffc90004677bb8 R14: ffff880457360000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004677ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cef ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#14] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 14 PID: 947 Comm: kworker/14:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046ccd8500 task.stack: ffffc90003ed8000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003edbba8 EFLAGS: 00010246
RAX: ffffc90003edbc18 RBX: 0000000000000000 RCX: ffff880457370040
RDX: ffff8804458b7d80 RSI: ffffc90003edbc18 RDI: ffff880457370000
RBP: ffffc90003edbbf8 R08: 0000000000000001 R09: fffffffffff6f8d1
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573700d8
R13: ffffc90003edbbb8 R14: ffff880457370000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003edbba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf0 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#15] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 15 PID: 987 Comm: kworker/15:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046cd1c580 task.stack: ffffc9000408c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc9000408fba8 EFLAGS: 00010246
RAX: ffffc9000408fc18 RBX: 0000000000000000 RCX: ffff880457380040
RDX: ffff8804458b7da0 RSI: ffffc9000408fc18 RDI: ffff880457380000
RBP: ffffc9000408fbf8 R08: 0000000000000001 R09: fffffffffff70360
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573800d8
R13: ffffc9000408fbb8 R14: ffff880457380000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc9000408fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf1 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#16] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 16 PID: 963 Comm: kworker/16:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046d1988c0 task.stack: ffffc90004024000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004027ba8 EFLAGS: 00010246
RAX: ffffc90004027c18 RBX: 0000000000000000 RCX: ffff880457390040
RDX: ffff8804458b7dc0 RSI: ffffc90004027c18 RDI: ffff880457390000
RBP: ffffc90004027bf8 R08: 0000000000000001 R09: fffffffffff70c9b
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573900d8
R13: ffffc90004027bb8 R14: ffff880457390000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? ttwu_do_wakeup+0x22/0x100
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004027ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf2 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#17] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 17 PID: 5820 Comm: kworker/17:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046d2c69c0 task.stack: ffffc90004094000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004097ba8 EFLAGS: 00010246
RAX: ffffc90004097c18 RBX: 0000000000000000 RCX: ffff8804573b0040
RDX: ffff8804458b7de0 RSI: ffffc90004097c18 RDI: ffff8804573b0000
RBP: ffffc90004097bf8 R08: 0000000000000001 R09: fffffffffff7159b
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804573b00d8
R13: ffffc90004097bb8 R14: ffff8804573b0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004097ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf3 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#18] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 18 PID: 920 Comm: kworker/18:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086d87a7c0 task.stack: ffffc90003ed0000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003ed3ba8 EFLAGS: 00010246
RAX: ffffc90003ed3c18 RBX: 0000000000000000 RCX: ffff880850b00040
RDX: ffff8808509a9b00 RSI: ffffc90003ed3c18 RDI: ffff880850b00000
RBP: ffffc90003ed3bf8 R08: 0000000000000001 R09: fffffffffff72142
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b000d8
R13: ffffc90003ed3bb8 R14: ffff880850b00000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003ed3ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf4 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#19] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 19 PID: 1259 Comm: kworker/19:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086c1864c0 task.stack: ffffc9000543c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc9000543fba8 EFLAGS: 00010246
RAX: ffffc9000543fc18 RBX: 0000000000000000 RCX: ffff880850b10040
RDX: ffff8808509a9ae0 RSI: ffffc9000543fc18 RDI: ffff880850b10000
RBP: ffffc9000543fbf8 R08: 0000000000000001 R09: fffffffffff72b3b
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b100d8
R13: ffffc9000543fbb8 R14: ffff880850b10000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fbc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc9000543fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf5 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#20] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 20 PID: 989 Comm: kworker/20:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086df08740 task.stack: ffffc9000427c000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc9000427fba8 EFLAGS: 00010246
RAX: ffffc9000427fc18 RBX: 0000000000000000 RCX: ffff880850b20040
RDX: ffff8808509a9ac0 RSI: ffffc9000427fc18 RDI: ffff880850b20000
RBP: ffffc9000427fbf8 R08: 0000000000000001 R09: fffffffffff7351d
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b200d8
R13: ffffc9000427fbb8 R14: ffff880850b20000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc9000427fba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf6 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#21] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 21 PID: 919 Comm: kworker/21:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086da2e9c0 task.stack: ffffc900047a4000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc900047a7ba8 EFLAGS: 00010246
RAX: ffffc900047a7c18 RBX: 0000000000000000 RCX: ffff880850b30040
RDX: ffff8808509a9aa0 RSI: ffffc900047a7c18 RDI: ffff880850b30000
RBP: ffffc900047a7bf8 R08: 0000000000000001 R09: fffffffffff73ee8
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b300d8
R13: ffffc900047a7bb8 R14: ffff880850b30000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc900047a7ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf7 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#22] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 22 PID: 932 Comm: kworker/22:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086c5e63c0 task.stack: ffffc90003e78000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003e7bba8 EFLAGS: 00010246
RAX: ffffc90003e7bc18 RBX: 0000000000000000 RCX: ffff880850b40040
RDX: ffff8808509a9a80 RSI: ffffc90003e7bc18 RDI: ffff880850b40000
RBP: ffffc90003e7bbf8 R08: 0000000000000001 R09: fffffffffff74859
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b400d8
R13: ffffc90003e7bbb8 R14: ffff880850b40000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003e7bba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf8 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#23] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 23 PID: 959 Comm: kworker/23:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88086c0e6140 task.stack: ffffc90004004000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90004007ba8 EFLAGS: 00010246
RAX: ffffc90004007c18 RBX: 0000000000000000 RCX: ffff880850b50040
RDX: ffff8808509a9a60 RSI: ffffc90004007c18 RDI: ffff880850b50000
RBP: ffffc90004007bf8 R08: 0000000000000001 R09: fffffffffff751ab
R10: 0000000000000001 R11: 0000000000000001 R12: ffff880850b500d8
R13: ffffc90004007bb8 R14: ffff880850b50000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88087fcc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406e0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90004007ba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cf9 ]---
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: blk_mq_flush_busy_ctxs+0x48/0xc0
PGD 0 
P4D 0 

Oops: 0000 [#24] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 0 PID: 928 Comm: kworker/0:1H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_run_work_fn
task: ffff88046c442780 task.stack: ffffc90003ef8000
RIP: 0010:blk_mq_flush_busy_ctxs+0x48/0xc0
RSP: 0018:ffffc90003efbba8 EFLAGS: 00010246
RAX: ffffc90003efbc18 RBX: 0000000000000000 RCX: ffff8804572e0040
RDX: ffff8804458b7c80 RSI: ffffc90003efbc18 RDI: ffff8804572e0000
RBP: ffffc90003efbbf8 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8804572e00d8
R13: ffffc90003efbbb8 R14: ffff8804572e0000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88047fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406f0
Call Trace:
 blk_mq_sched_dispatch_requests+0x16d/0x190
 ? blk_mq_requeue_work+0x18f/0x1b0
 ? pwq_activate_delayed_work+0x47/0x70
 __blk_mq_run_hw_queue+0xa0/0xb0
 blk_mq_run_work_fn+0x2c/0x30
 process_one_work+0x170/0x310
 ? schedule+0x35/0xa0
 ? schedule+0x1/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 7d c0 48 89 75 c8 44 8b 9f e0 00 00 00 45 85 db 74 77 4c 8d 6d c0 c7 45 b8 00 00 00 00 8b 5d b8 48 c1 e3 06 49 03 9e e8 00 00 00 <48> 83 3b 00 74 48 41 8b 8e dc 00 00 00 8b 45 b8 45 31 ff d3 e0 
RIP: blk_mq_flush_busy_ctxs+0x48/0xc0 RSP: ffffc90003efbba8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cfa ]---
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
BUG: unable to handle kernel NULL pointer dereference at           (null)
IP: sbitmap_any_bit_set+0x11/0x40
PGD 0 
P4D 0 

Oops: 0000 [#25] SMP
Modules linked in: nvme_rdma rdma_cm iw_cm nvme_fabrics nvme_core ib_ipoib ib_cm netconsole configfs rpcsec_gss_krb5 nfsv4 nfsd auth_rpcgss nfsv3 nfs_acl nfs fscache lockd grace autofs4 sunrpc dm_mirror dm_region_hash dm_log dm_multipath uinput iTCO_wdt iTCO_vendor_support sg pcspkr serio_raw i2c_i801 lpc_ich mfd_core shpchp ipmi_si ipmi_msghandler mlx5_ib ib_core ioatdma mlx5_core ipv6 crc_ccitt dm_mod igb dax dca i2c_algo_bit i2c_core ptp pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) isci(E) libsas(E) scsi_transport_sas(E) [last unloaded: mlx4_core]
CPU: 0 PID: 14184 Comm: kworker/0:2H Tainted: G      D     E   4.12.0-rc5+ #62
Hardware name: Supermicro SYS-1027R-WRF/X9DRW, BIOS 3.0a 08/08/2013
Workqueue: kblockd blk_mq_requeue_work
task: ffff88046d2c8a00 task.stack: ffffc900040ec000
RIP: 0010:sbitmap_any_bit_set+0x11/0x40
RSP: 0018:ffffc900040efbd8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8804572e0000 RCX: ffff880850a3dbb0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8804572e00d8
RBP: ffffc900040efbd8 R08: 0000000000000001 R09: fffffffffffffff4
R10: 0000000000000005 R11: 000000000001c2c8 R12: ffff8804572e0000
R13: ffff880850a3d560 R14: 0000000000000000 R15: ffffc900040efc38
FS:  0000000000000000(0000) GS:ffff88047fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000001c09000 CR4: 00000000000406f0
Call Trace:
 blk_mq_hctx_has_pending+0x18/0x70
 blk_mq_run_hw_queues+0x42/0x70
 blk_mq_requeue_work+0x18f/0x1b0
 ? finish_task_switch+0x1d5/0x230
 ? pick_next_task_idle+0x40/0x50
 process_one_work+0x170/0x310
 ? sched_clock_cpu+0x22/0xc0
 ? schedule+0x35/0xa0
 worker_thread+0x77/0x420
 ? pick_next_task_idle+0x40/0x50
 ? default_wake_function+0xd/0x10
 ? maybe_create_worker+0x110/0x110
 ? schedule+0x35/0xa0
 ? maybe_create_worker+0x110/0x110
 kthread+0x107/0x140
 ? kthread_create_worker+0x50/0x50
 ret_from_fork+0x22/0x30
Code: 4f 10 2b 74 01 08 39 57 08 77 d8 c9 c3 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 8b 77 08 55 48 89 e5 85 f6 74 22 48 8b 57 10 31 c0 <48> 83 3a 00 74 0f eb 18 48 8b 4a 40 48 83 c2 40 48 85 c9 75 0b 
RIP: sbitmap_any_bit_set+0x11/0x40 RSP: ffffc900040efbd8
CR2: 0000000000000000
---[ end trace 762d84a0fc017cfb ]---
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: Connect rejected: status 8 (invalid service ID).
nvme nvme0: rdma_resolve_addr wait failed (-104).
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: Failed reconnect attempt 1
nvme nvme0: Reconnecting in 10 seconds...
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: Connect rejected: status 8 (invalid service ID).
nvme nvme0: rdma_resolve_addr wait failed (-104).
nvme nvme0: Failed reconnect attempt 2
nvme nvme0: Reconnecting in 10 seconds...
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme-fabrics ctl: nvme_revalidate_ns: Identify failure
nvme nvme0: Connect rejected: status 8 (invalid service ID).
nvme nvme0: rdma_resolve_addr wait failed (-104).
nvme nvme0: Failed reconnect attempt 3
nvme nvme0: Reconnecting in 10 seconds...
nvme nvme0: Connect rejected: status 8 (invalid service ID).
nvme nvme0: rdma_resolve_addr wait failed (-104).
nvme nvme0: Failed reconnect attempt 4
nvme nvme0: Reconnecting in 10 seconds...
nvme nvme0: Connect rejected: status 8 (invalid service ID).
nvme nvme0: rdma_resolve_addr wait failed (-104).
nvme nvme0: Failed reconnect attempt 5
nvme nvme0: Reconnecting in 10 seconds...
