From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 10 Jul 2018 08:45:10 -0600
Subject: [PATCH v2 1/2] nvme-pci: release iomap and prp_pools in
 nvme_pci_free_ctrl
In-Reply-To: <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
 <c9dc94bd6b434273ed69c47b06b4f55fb495254c.1530548893.git.zhangweiping@didichuxing.com>
Message-ID: <20180710144510.GB11548@localhost.localdomain>

I'm getting the following warning with this patch:

[  164.864948] ------------[ cut here ]------------
[  164.864951] kernfs: can not remove 'pools', no directory
[  164.864980] WARNING: CPU: 31 PID: 2904 at fs/kernfs/dir.c:1481 kernfs_remove_by_name_ns+0x84/0x90
[  164.864982] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_raw iptable_security ebtable_filter ebtables ip6table_filter ip6_tables sunrpc vfat fat intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel intel_uncore intel_rapl_perf ipmi_ssif iTCO_wdt joydev iTCO_vendor_support ipmi_si mei_me ipmi_devintf mei ioatdma lpc_ich i2c_i801 ipmi_msghandler dca wmi acpi_power_meter acpi_pad xfs libcrc32c ast i2c_algo_bit drm_kms_helper ttm drm i40e
[  164.865059]  nvme nvme_core crc32c_intel ptp pps_core
[  164.865069] CPU: 31 PID: 2904 Comm: umount Not tainted 4.18.0-rc2+ #197
[  164.865071] Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.00.01.0010.010920180151 01/09/2018
[  164.865074] RIP: 0010:kernfs_remove_by_name_ns+0x84/0x90
[  164.865076] Code: 00 31 c0 5b 5d 41 5c c3 48 c7 c7 80 47 34 94 e8 52 0a 5b 00 b8 fe ff ff ff 5b 5d 41 5c c3 48 c7 c7 e8 c9 0d 94 e8 4c 2d d8 ff <0f> 0b b8 fe ff ff ff eb d0 0f 1f 00 0f 1f 44 00 00 41 57 41 56 41
[  164.865128] RSP: 0018:ffffa3af8bc03d60 EFLAGS: 00010282
[  164.865131] RAX: 0000000000000000 RBX: ffff8d54f101b198 RCX: 0000000000000006
[  164.865133] RDX: 0000000000000007 RSI: 0000000000000096 RDI: ffff8d64fe8d6a30
[  164.865134] RBP: ffffffff940d13f5 R08: 000000000000069f R09: 0000000000000004
[  164.865136] R10: ffffed0a00caa640 R11: 0000000000000001 R12: ffff8d54f101b198
[  164.865137] R13: ffff8d54fa0e7af8 R14: ffff8d54fa320800 R15: ffff8d64a3145538
[  164.865140] FS:  00007fec629c5fc0(0000) GS:ffff8d64fe8c0000(0000) knlGS:0000000000000000
[  164.865141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  164.865143] CR2: 00007efdf3d6b160 CR3: 0000002001c6a005 CR4: 00000000007606e0
[  164.865145] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  164.865147] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  164.865148] PKRU: 55555554
[  164.865149] Call Trace:
[  164.865160]  dma_pool_destroy+0x18c/0x1b0
[  164.865169]  nvme_pci_free_ctrl+0x31/0xa0 [nvme]
[  164.865179]  nvme_free_ctrl+0xba/0x100 [nvme_core]
[  164.865190]  device_release+0x2d/0x80
[  164.865199]  kobject_put+0x81/0x1a0
[  164.865206]  nvme_free_ns+0xc9/0xe0 [nvme_core]
[  164.865214]  __blkdev_put+0x17d/0x1d0
[  164.865221]  ? generic_shutdown_super+0x69/0x110
[  164.865225]  deactivate_locked_super+0x39/0x70
[  164.865230]  cleanup_mnt+0x3b/0x70
[  164.865237]  task_work_run+0x97/0xc0
[  164.865246]  exit_to_usermode_loop+0xd8/0xe0
[  164.865250]  do_syscall_64+0x158/0x160
[  164.865255]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  164.865259] RIP: 0033:0x7fec61a12957
[  164.865260] Code: 55 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 55 2c 00 f7 d8 64 89 01 48
[  164.865312] RSP: 002b:00007ffc1c6070c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[  164.865315] RAX: 0000000000000000 RBX: 00005608458eb2a0 RCX: 00007fec61a12957
[  164.865316] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00005608458eb480
[  164.865318] RBP: 00005608458eb480 R08: 00005608458eb4a0 R09: 0000000000000003
[  164.865320] R10: 00000000fffffffd R11: 0000000000000246 R12: 00007fec627b1184
[  164.865321] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  164.865324] ---[ end trace 45a702454817613a ]---


On Tue, Jul 03, 2018@12:35:22AM +0800, Weiping Zhang wrote:
> nvme_free_ctrl is the final release function all allocated resource
> should be free safety in this function. Release iomap and prp_pools
> in nvme_pci_free_ctrl, otherwise these two resource cann't be
> released if init failed in nvme_reset_work.
> 
> Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba943f211687..92a8b5b2b39e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2279,6 +2279,8 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  	struct nvme_dev *dev = to_nvme_dev(ctrl);
>  
>  	nvme_dbbuf_dma_free(dev);
> +	nvme_release_prp_pools(dev);
> +	nvme_dev_unmap(dev);
>  	put_device(dev->dev);
>  	if (dev->tagset.tags)
>  		blk_mq_free_tag_set(&dev->tagset);
> @@ -2642,8 +2644,6 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_dev_remove_admin(dev);
>  	nvme_free_queues(dev, 0);
>  	nvme_uninit_ctrl(&dev->ctrl);
> -	nvme_release_prp_pools(dev);
> -	nvme_dev_unmap(dev);
>  	nvme_put_ctrl(&dev->ctrl);
>  }
>  
> -- 
