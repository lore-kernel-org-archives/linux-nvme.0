From: ichavero@chavero.com.mx (=?UTF-8?Q?Iv=c3=a1n_Chavero?=)
Date: Tue, 21 May 2019 16:34:44 -0500
Subject: nvme drive kernel 5.0 problem
In-Reply-To: <20190521142000.GA350@localhost.localdomain>
References: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>
 <CACVXFVPXGKQ9UD6P5RsF5j8yry+1LuLrUeb4F6o74=uGK4Ak4Q@mail.gmail.com>
 <a640a0768d19aedee71a1abad7817a3a71291851.camel@chavero.com.mx>
 <20190521142000.GA350@localhost.localdomain>
Message-ID: <e027eae2-0c39-8e83-5a09-fda82d4c2a52@chavero.com.mx>

El 21/05/19 a las 9:20 a. m., Keith Busch escribi?:
>
> The warning in itself is not necessarily fatal and may not explain why
> the filesystem is having issues. It should just mean that you've only
> a single MSI interrupt vector sharing with the admin queue, so it's an
> unmanagged vector, creating this warning. It should otherwise be usable.
>
> The following should work around the warning assuming the vector count
> is really what's creating your warning: managed irqs should always have
> an offset, so no offset should mean no pci irq affinity.
>
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2a8708c9ac18..d55e1d92cf59 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -464,7 +464,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  		 * affinity), so use the regular blk-mq cpu mapping
>  		 */
>  		map->queue_offset = qoff;
> -		if (i != HCTX_TYPE_POLL)
> +		if (i != HCTX_TYPE_POLL && offset)
>  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
>  		else
>  			blk_mq_map_queues(map);
> --
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

I'm about to test this code but i wanted to point out that i've found also

this errors before the ext4 driver remounts the filesystem as read-only:


[?? 11.304823] print_req_error: operation not supported error, dev
nvme0n1, sector 386138112 flags 4801
[?? 11.305292] print_req_error: operation not supported error, dev
nvme0n1, sector 386139128 flags 4801
[?? 11.307096] print_req_error: operation not supported error, dev
nvme0n1, sector 386140144 flags 4801
[?? 11.307194] print_req_error: operation not supported error, dev
nvme0n1, sector 386141160 flags 4801
[?? 11.307433] print_req_error: operation not supported error, dev
nvme0n1, sector 386142176 flags 4801
[?? 11.307818] print_req_error: operation not supported error, dev
nvme0n1, sector 386143192 flags 4801
[?? 11.307939] print_req_error: operation not supported error, dev
nvme0n1, sector 386144208 flags 4801
[?? 11.308047] print_req_error: operation not supported error, dev
nvme0n1, sector 386145224 flags 4801
[?? 11.308134] print_req_error: operation not supported error, dev
nvme0n1, sector 386146240 flags 4801
[?? 11.308255] print_req_error: operation not supported error, dev
nvme0n1, sector 386147256 flags 4801
[?? 11.309149] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 393675 (offset 0 size 8388608 starting block 98288)
[?? 11.309152] Buffer I/O error on device dm-1, logical block 96256
[?? 11.309158] Buffer I/O error on device dm-1, logical block 96257
[?? 11.309159] Buffer I/O error on device dm-1, logical block 96258
[?? 11.309163] Buffer I/O error on device dm-1, logical block 96259
[?? 11.309164] Buffer I/O error on device dm-1, logical block 96260
[?? 11.309167] Buffer I/O error on device dm-1, logical block 96261
[?? 11.309169] Buffer I/O error on device dm-1, logical block 96262
[?? 11.309172] Buffer I/O error on device dm-1, logical block 96263
[?? 11.309174] Buffer I/O error on device dm-1, logical block 96264
[?? 11.309177] Buffer I/O error on device dm-1, logical block 96265
[?? 11.311152] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 393675 (offset 8388608 size 1343488 starting
block 487678)
[?? 11.383082] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 1966094 (offset 0 size 0 starting block 467904)
[?? 11.400545] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 1966094 (offset 57806848 size 323584 starting
block 5543713)
[

...

[?? 12.525069] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 393675 (offset 0 size 8388608 starting block
491504)
[?? 12.526452] EXT4-fs warning (device dm-1): ext4_end_bio:318: I/O
error 1 writing to inode 393675 (offset 8388608 size 1343488 starting
block 475390)
[?? 13.464615] EXT4-fs (dm-3): mounted filesystem with ordered data
mode. Opts: (null)
[?? 13.468795] EXT4-fs (nvme0n1p5): mounted filesystem with ordered data
mode. Opts: (null)

...

[?? 13.756080] Aborting journal on device dm-1-8.
[?? 13.756611] EXT4-fs error (device dm-1): ext4_journal_check_start:61:
Detected aborted journal
[?? 13.756616] EXT4-fs (dm-1): Remounting filesystem read-only

I think that the real error is this one:

print_req_error: operation not supported error, dev nvme0n1, sector
386138112 flags 4801

but i'm not sure how to interpret this error, my guess is that is a
syncronization issue.


I should point out that i also have other partitions on this device that
get mounted read-write with no problem.


The partition that has the problem is the root partition so my guess is
that its mounted? before

the driver finishes some syncronization or intialization tasks causing
the "operation not supported error"

then, the ext4 driver after some errors protects the partition and
mounts it read-only.


It might be a problem of tuning the nvme driver parameters, since i
could not find any parameters for

the apple device i took the ones that get set automatically on kernel
4.16.11:


options $kernelopts nvme.poll_queues=2 nvme.io_queue_depth=1024
nvme.max_host_mem_size_mb=128 nvme.sgl_threshold=32768
nvme.use_cmb_sqes=Y nvme_core.default_ps_max_latency_us=100000
nvme_core.force_apst=Y nvme_core.io_timeout=30 nvme_core.max_retries=5
nvme_core.shutdown_timeout=5 nvme_core.streams=N?
systemd.unit=multi-user.target


Thanks for the help.


-- 
Iv?n Chavero
Hacker
