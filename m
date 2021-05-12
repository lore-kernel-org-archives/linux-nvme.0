Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A072C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 10:14:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AB4613BE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 10:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AB4613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C8k1tC7l0xEFGLSG3v6z0rcmw0oHfLsplc+uqWn9kXo=; b=TIOqaTdLsnQjq5vWSIWJiXxYhG
	/rdizHHJwE5hvOG7UWe1XlHNo2dH3p+zmpaV5WCROsBhvX+nx9ITG1U05grZpuObO0cYfpieCpSw1
	dTsQadaQD6YuSGzXlVVKaE3B0ngDOQhzlJgfp5oM+s3eNbxU+sshHGuj/IE68J9OykWSxMTUyw7bn
	7tsbHN03cx2qQBd7rHJSiy9TT3HhYeUFH++IJL4sW0U10hp6OkLyNJRb4dkXLB4lhkpu8lKbw7qX6
	gEywTDUY82PADsB/BGZf0ipPYta6nuqNzq6lZX0AHeeH97JrLHi6vQyvwYrLEOZ1KV0lw82vEXf+Z
	vBCCXOBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lglsW-002VLD-Jn; Wed, 12 May 2021 10:14:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lglsT-002VL3-0b
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 10:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=d6ri+VZHHd/kquSoOPf3tXi05r37HWCGAZWHvfV2gBM=; b=GRbu81Ff+trCCAeE2mOjc1fBrp
 6LaViaBcSNE/md7KnKxQUhOXAs2TQSjbTzBeaZT46bs+Y9bPFAzsuSZxzu8daU5UuvS+bMLHDNIs2
 1djsxDOoZE1P4WsvDAh+L5RMYlIMi1PIgMFffEEmvBucYb+T1kYE3RtN2HOMuIrwXvJ2vjVbwtZWh
 XoDDgTs4UFXiHkPj3aFWaNAzOpa9ovt/oz/g86uu3COlaTU1MDDK7tohhuY4+bul8fHqRtmBpvY/L
 CWo0IjKdLQ2IX2oYJ9TkxJLnRAKHs044TGqXnUSKRK0b/W30dPh+QuyJnccWmIpEKN7SAi/Ag8PSY
 66mGNoJg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lglsP-00AHLu-QR
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 10:14:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EAD31AF21;
 Wed, 12 May 2021 10:13:58 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>
Subject: [PATCH] nvmet: Reset ns->file when open fails
Date: Wed, 12 May 2021 12:13:52 +0200
Message-Id: <20210512101352.23725-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_031402_199133_171CD453 
X-CRM114-Status: GOOD (  15.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reset the ns->file value to NULL also in the error case in
nvmet_file_ns_enable().

The ns->file variable points either to file object or contains the
error code after the filp_open() call. This can lead to following
problem:

When the user first setups an invalid file backend and tries to enable
the ns, it will fail. Then the user switches over to a bdev backend
and enables successfully the ns. The first received I/O will crash the
system because the IO backend is chosen based on the ns->file value:

static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
{
	[...]

	if (req->ns->file)
		return nvmet_file_parse_io_cmd(req);

	return nvmet_bdev_parse_io_cmd(req);
}

Reported-by: Enzo Matsumiya <ematsumiya@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Hi,

We saw the backtrace with following (test) configuration:

 nt00:/var/crash/2021-03-22-16:13 # nvmetcli ls /
 o- / ......................................................................................................................... [...]
   o- hosts ................................................................................................................... [...]
   o- ports ................................................................................................................... [...]
   | o- 1 .................................................. [trtype=tcp, traddr=192.168.0.134, trsvcid=4420, inline_data_size=16384]
   |   o- ana_groups .......................................................................................................... [...]
   |   | o- 1 ..................................................................................................... [state=optimized]
   |   o- referrals ........................................................................................................... [...]
   |   o- subsystems .......................................................................................................... [...]
   |     o- nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c ......................................... [...]
   o- subsystems .............................................................................................................. [...]
     o- nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c  [version=1.3, allow_any=1, serial=6e91a39f356a26ee]
       o- allowed_hosts ....................................................................................................... [...]
       o- namespaces .......................................................................................................... [...]
         o- 1 ...................................... [path=/dev/nvme0n1, uuid=1c681585-01ec-48db-b772-9d103c8d47a3, grpid=1, enabled]


 nvmet: creating controller 2 for subsystem nqn.2014-08.org.nvmexpress:NVMf:uuid:44e52e4f-791e-4d37-a718-ff010ba82e5c for NQN nqn.2014-08.org.nvmexpress:uuid:9b9f4d56-59f6-cbf6-2e26-969777c12e5f.
 BUG: kernel NULL pointer dereference, address: 0000000000000012
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 1 PID: 444 Comm: kworker/1:1H Kdump: loaded Tainted: G               X    5.3.18-24.52-default #1 SLE15-SP2
 Hardware name: VMware, Inc. VMware7,1/440BX Desktop Reference Platform, BIOS VMW71.00V.15401161.B64.2001021853 01/02/2020
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:nvmet_file_submit_bvec+0x3f/0x130 [nvmet]
 Code: 00 53 44 89 c5 48 89 fb 48 83 ec 30 48 8b 77 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 28 31 c0 48 8b 07 48 8b 76 50 80 38 01 <48> 8b 76 28 0f 84 c6 00 00 00 4c 8b 6e 20 31 f6 49 89 c8 48 89 d1
 RSP: 0018:ffffa111c0353c98 EFLAGS: 00010202
 RAX: ffff8bf7069d7f30 RBX: ffff8bf706a00008 RCX: 0000000000001000
 RDX: 0000000000000001 RSI: ffffffffffffffea RDI: ffff8bf706a00008
 RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000100 R12: ffff8bf706a000c0
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8bf706a00008
 FS:  0000000000000000(0000) GS:ffff8bf73fc80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000012 CR3: 000000012a394001 CR4: 00000000003606e0
 Call Trace:
  nvmet_file_execute_io+0x1ae/0x270 [nvmet]
  nvmet_tcp_try_recv_pdu+0x364/0x710 [nvmet_tcp]
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  ? __switch_to_asm+0x40/0x70
  ? __switch_to_asm+0x34/0x70
  nvmet_tcp_io_work+0x6d/0xa90 [nvmet_tcp]
  process_one_work+0x1f4/0x3e0
  worker_thread+0x2d/0x3e0
  ? process_one_work+0x3e0/0x3e0
  kthread+0x10d/0x130
  ? kthread_park+0xa0/0xa0
  ret_from_fork+0x35/0x40
 Modules linked in: nvme_fabrics nvmet_tcp nvmet configfs af_packet ip_set nfnetlink iscsi_ibft iscsi_boot_sysfs rfkill x_tables bpfilter vmw_vsock_vmci_transport vsock fuse nls_iso8859_1 nls_cp437 vfat fat intel_rapl_msr intel_rapl_common sb_edac crc32_pclmul ghash_clmulni_intel aesni_intel aes_x86_64 crypto_simd cryptd nvme glue_helper nvme_core joydev pcspkr vmw_balloon vmxnet3 button ac i2c_piix4 vmw_vmci btrfs libcrc32c xor hid_generic raid6_pq usbhid sr_mod cdrom sd_mod ata_generic vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ata_piix ehci_pci drm crc32c_intel uhci_hcd serio_raw ahci libahci ehci_hcd vmw_pvscsi usbcore libata sg dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua scsi_mod efivarfs [last unloaded: ip_tables]
 Supported: Yes, External
 CR2: 0000000000000012

Enzo was not able reproduce it reliable so we can't really say if the
patch fixes the crash he saw. But I figured ns->file should be set
back to NULL.

 drivers/nvme/target/io-cmd-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 715d4376c997..27430d44ef23 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -51,7 +51,9 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
-		return PTR_ERR(ns->file);
+		ret = ns->file;
+		ns->file = NULL;
+		return PTR_ERR(ret);
 	}
 
 	ret = nvmet_file_ns_revalidate(ns);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
