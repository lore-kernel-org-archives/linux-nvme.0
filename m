From: albi.schlegel@hotmail.com (Albert Schlegel)
Date: Mon, 3 Dec 2018 10:50:44 +0000
Subject: AW: NVMe drive kernel fail after hotplug kernel 4.16.12
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B978F0A162@fmsmsx104.amr.corp.intel.com>
References: <AM6PR03MB4038E7290A514371F9D60E17F87F0@AM6PR03MB4038.eurprd03.prod.outlook.com>
 <AM6PR03MB4038A5FDD819AE34DDDE54A4F87E0@AM6PR03MB4038.eurprd03.prod.outlook.com>,
 <20180613151128.GB5574@localhost.localdomain>
 <AM6PR03MB40389E7C34537DF6CCDF0904F8400@AM6PR03MB4038.eurprd03.prod.outlook.com>,
 <B58D82457FDA0744A320A2FC5AC253B978F0A162@fmsmsx104.amr.corp.intel.com>
Message-ID: <SN6PR07MB42219ADDE6D4E35F953A4A90F8AE0@SN6PR07MB4221.namprd07.prod.outlook.com>

Hi Keith,

unfornately your commit does not fix our problem. Now we get a NULL pointer dereference.
We tested the kernel? 4.20-rc3 and got the following output after power fail of the nvme device:

[  324.913779] nvme nvme0: failed to set APST feature (-19)
[  324.973652] pci 0000:03:00.0: [1987:5008] type 00 class 0x010802
[  324.973678] pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  324.973707] pci 0000:03:00.0: Max Payload Size set to 256 (was 128, max 256)
[  324.974013] pci 0000:03:00.0: BAR 0: assigned [mem 0xf7000000-0xf7003fff 64bit]
[  324.974021] pci 0000:05:00.0: PCI bridge to [bus 06]
[  324.974131] nvme nvme0: pci function 0000:03:00.0
[  324.974146] nvme 0000:03:00.0: enabling device (0000 -> 0002)
[  325.081780] nvme nvme0: missing or invalid SUBNQN field.
[  325.086371] nvme nvme0: allocated 64 MiB host memory buffer.
[  357.462342] nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
[  357.530344] nvme 0000:03:00.0: Refused to change power state, currently in D3
[  357.530404] nvme nvme0: Removing after probe failure status: -19
[  357.562355] BUG: unable to handle kernel NULL pointer dereference at 00000000
[  357.562358] *pdpt = 0000000000000000 *pde = f000eef30000ee01 
[  357.562360] Oops: 0000 [#1] SMP PTI
[  357.562362] CPU: 0 PID: 301 Comm: kworker/u8:3 Not tainted 4.20.0-rc3 #1
[  357.562363] Hardware name: System manufacturer System Product Name/Q170M-C, BIOS 3805 05/10/2018
[  357.562367] Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
[  357.562370] EIP: sbitmap_any_bit_set+0xe/0x40
[  357.562371] Code: 39 56 08 77 df 83 c4 04 5b 5e 5f 5d c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 8b 48 08 85 c9 74 31 55 89 e5 53 8b 58 0c <8b> 03 85 c0 75 1c 31 c0 eb 0c 89 c2 c1 e2 06 8b 14 13 85 d2 75 0c
[  357.562374] EAX: f68d108c EBX: 00000000 ECX: 00000001 EDX: f69c3e64
[  357.562374] ESI: 00000001 EDI: f6a90d20 EBP: f69c3e5c ESP: f69c3e58
[  357.562376] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
[  357.562380] print_req_error: I/O error, dev nvme0n1, sector 0
[  357.562382] CR0: 80050033 CR2: 00000000 CR3: 019b6000 CR4: 003406f0
[  357.562383] Call Trace:
[  357.562402]  blk_mq_run_hw_queue+0xa8/0x100
[  357.562404]  blk_mq_run_hw_queues+0x46/0x60
[  357.562406]  blk_mq_unquiesce_queue+0x23/0x30
[  357.562409]  nvme_kill_queues+0x23/0x50 [nvme_core]
[  357.562412]  nvme_remove_namespaces+0x85/0x90 [nvme_core]
[  357.562414]  nvme_remove+0x72/0x130 [nvme]
[  357.562416]  pci_device_remove+0x38/0xc0
[  357.562419]  device_release_driver_internal+0x141/0x1f0
[  357.562421]  device_release_driver+0x11/0x20
[  357.562422]  nvme_remove_dead_ctrl_work+0x1a/0x30 [nvme]
[  357.562425]  process_one_work+0x130/0x310
[  357.562427]  worker_thread+0x39/0x330
[  357.562429]  kthread+0xe2/0x110
[  357.562431]  ? process_scheduled_works+0x30/0x30
[  357.562433]  ? kthread_create_worker+0x30/0x30
[  357.562435]  ret_from_fork+0x2e/0x38
[  357.562437] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv4 dns_resolver nfsd auth_rpcgss nfs_acl nfs lockd grace fscache sunrpc loop snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic i915 snd_hda_intel snd_hda_codec snd_hda_core drm_kms_helper snd_hwdep snd_pcm eeepc_wmi snd_timer drm asus_wmi snd parport_pc pcc_cpufreq sparse_keymap rfkill evdev xhci_pci rtc_cmos parport iTCO_wdt iTCO_vendor_support xhci_hcd soundcore i2c_i801 i2c_algo_bit nvme mei_me nvme_core mei tpm_tis psmouse i2c_core tpm_tis_core pcspkr serio_raw mxm_wmi button wmi_bmof tpm rng_core video acpi_pad wmi ext4 crc16 mbcache jbd2 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq crc32c_generic crc32c_intel libcrc32c nbd uhci_hcd ehci_hcd usbcore usb_common sg sd_mod ahci libahci thermal e1000e ptp pps_core libata scsi_mod fan
[  357.562466] CR2: 0000000000000000
[  357.562467] ---[ end trace df26c057a341ee3b ]---

Do you have an other idea what could cause this problem?

Thanks!





Von: Busch, Keith <keith.busch at intel.com>
Gesendet: Donnerstag, 5. Juli 2018 21:52
An: Albert Schlegel
Cc: linux-nvme at lists.infradead.org
Betreff: RE: NVMe drive kernel fail after hotplug kernel 4.16.12
?
Super, thanks for the confirmation!

________________________________________
From: Albert Schlegel [mailto:albi.schlegel@hotmail.com]
Sent: Wednesday, July 4, 2018 11:58 PM
To: Busch, Keith <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
Subject: AW: NVMe drive kernel fail after hotplug kernel 4.16.12

Yes, this solves the problem.

Thanks for the patch!
________________________________________
Von: Keith Busch <keith.busch at intel.com>
Gesendet: Mittwoch, 13. Juni 2018 17:11
An: Albert Schlegel
Cc: linux-nvme at lists.infradead.org
Betreff: Re: NVMe drive kernel fail after hotplug kernel 4.16.12
?
On Wed, Jun 13, 2018@01:31:37AM -0700, Albert Schlegel wrote:
> Hi,
>
>
> I have a problem with NVMe drive and hotplug where the kernel (nvme driver) has some problems. I posted the detailed problem here:
> https://www.linuxquestions.org/questions/showthread.php?p=5866497#post5866497
>
>
> Is there a solution for this or it is possible to fix this?

Could you see if this commit fixes your issue?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/nvme/host/pci.c?id=1d39e6928cbd0eb737c51545210b5186d5551ba1
