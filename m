Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB687C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7055F61246
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 16:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7055F61246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ujbDCFWVWgbOMZsn+Zygiqdc8VX4MwyGanGSWXrsNQI=; b=S2mNdq0DXh6PUX
	z2RJv7t6S3kTyqTDit1nNyqquedWZDjN5vA5raZ1p85J0Q8J9ibtYiI/U5UBfskpR/G4TQqIfeH4E
	72UAKhyrvoJQ7E9qnkVYldeYYG2+nebpelmUXEkf56T/jW2daH9ycZ4AIceuPqSZmT97iIyXgM3tl
	el/GbF9iHFH0dmhQuFjsoPPy5MPrKnyiESJVSYstCnXaaStDxOPJA2A1BcVLZ7wO4gQQhl/g2PVtO
	+sQJCnPnpbuIOQkzbucJ0IzkOO9Q+St0jjNE3jaBVL3lQgpHSuZlROYTUvX7Bga7z10BW8xY6m58R
	i6h0ZSAVwGsc18Dxv59A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqew3-009btU-Vt; Tue, 08 Jun 2021 16:50:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqevi-009bjJ-EO
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 16:50:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C4A068AFE; Tue,  8 Jun 2021 18:50:16 +0200 (CEST)
Date: Tue, 8 Jun 2021 18:50:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michal Kalderon <mkalderon@marvell.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>
Subject: Re: BUG: scheduling while atomic when nvmet_rdma_queue_response
 fails in posting a request
Message-ID: <20210608165016.GA13293@lst.de>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_095018_843515_65386215 
X-CRM114-Status: GOOD (  14.49  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

What kernel version is this?

On Sun, May 30, 2021 at 07:33:18AM +0000, Michal Kalderon wrote:
> =

> this leads to nvmet_rdma_release_rsp being called from softirq eventually
> reaching the blk_mq_delay_run_hw_queue which tries to schedule in softirq=
. (full stack below)
> =

> could you please advise what the correct solution should be in this case =
? =

> =

> thanks,
> Michal
> =

> [ 8790.082863] nvmet_rdma: post_recv cmd failed
> [ 8790.083484] nvmet_rdma: sending cmd response failed
> [ 8790.084131] ------------[ cut here ]------------
> [ 8790.084140] WARNING: CPU: 7 PID: 46 at block/blk-mq.c:1422 __blk_mq_ru=
n_hw_queue+0xb7/0x100
> [ 8790.084619] Modules linked in: null_blk nvmet_rdma nvmet nvme_rdma nvm=
e_fabrics nvme_core netconsole qedr(OE) qede(OE) qed(OE) rpcsec_gss_krb5 au=
th_rpcgss nfsv4 dns_resolver nfs lockd grace fscache xt_CHECKSUM nft_chain_=
nat xt_MASQUERADE nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 libcrc32c nft_counter nft_compat tun bridge stp llc nf_tables nfnetli=
nk ib_isert iscsi_target_mod ib_srpt target_core_mod ib_srp scsi_transport_=
srp ib_ipoib ib_umad rpcrdma rdma_ucm ib_iser rdma_cm iw_cm intel_rapl_msr =
intel_rapl_common ib_cm sb_edac libiscsi scsi_transport_iscsi kvm_intel kvm=
 irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sunrpc rapl ib=
_uverbs ib_core cirrus drm_kms_helper drm virtio_balloon i2c_piix4 pcspkr c=
rc32c_intel virtio_net serio_raw net_failover failover floppy crc8 ata_gene=
ric pata_acpi qemu_fw_cfg [last unloaded: qedr]
> [ 8790.084748] CPU: 7 PID: 46 Comm: ksoftirqd/7 Tainted: G=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 OE=A0=A0=A0=A0 5.8.10 #1
> [ 8790.084749] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> [ 8790.084752] RIP: 0010:__blk_mq_run_hw_queue+0xb7/0x100
> [ 8790.084753] Code: 00 48 89 ef e8 ea 34 c8 ff 48 89 df 41 89 c4 e8 1f 7=
f 00 00 f6 83 a8 00 00 00 20 74 b1 41 f7 c4 fe ff ff ff 74 b7 0f 0b eb b3 <=
0f> 0b eb 86 48 83 bf 98 00 00 00 00 48 c7 c0 df 81 3f 82 48 c7 c2
> [ 8790.084754] RSP: 0018:ffffc9000020ba60 EFLAGS: 00010206
> [ 8790.084755] RAX: 0000000000000100 RBX: ffff88809fe8c400 RCX: 00000000f=
fffffff
> [ 8790.084756] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88809=
fe8c400
> [ 8790.084756] RBP: ffff888137b81a50 R08: ffffffffffffffff R09: 000000000=
0000020
> [ 8790.084757] R10: 0000000000000001 R11: ffff8881365d4968 R12: 000000000=
0000000
> [ 8790.084758] R13: ffff888137b81a40 R14: ffff88811e2b9e80 R15: ffff8880b=
3d964f0
> [ 8790.084759] FS:=A0 0000000000000000(0000) GS:ffff88813bbc0000(0000) kn=
lGS:0000000000000000
> [ 8790.084759] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8790.084760] CR2: 000055ca53900da8 CR3: 000000012b83e006 CR4: 000000000=
0360ee0
> [ 8790.084763] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [ 8790.084763] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [ 8790.084764] Call Trace:
> [ 8790.084767]=A0 __blk_mq_delay_run_hw_queue+0x140/0x160
> [ 8790.084768]=A0 blk_mq_get_tag+0x1d1/0x270
> [ 8790.084771]=A0 ? finish_wait+0x80/0x80
> [ 8790.084773]=A0 __blk_mq_alloc_request+0xb1/0x100
> [ 8790.084774]=A0 blk_mq_make_request+0x144/0x5d0
> [ 8790.084778]=A0 generic_make_request+0x2db/0x340
> [ 8790.084779]=A0 ? bvec_alloc+0x82/0xe0
> [ 8790.084781]=A0 submit_bio+0x43/0x160
> [ 8790.084781]=A0 ? bio_add_page+0x39/0x90
> [ 8790.084794]=A0 nvmet_bdev_execute_rw+0x28c/0x360 [nvmet]
> [ 8790.084800]=A0 nvmet_rdma_execute_command+0x72/0x110 [nvmet_rdma]
> [ 8790.084802]=A0 nvmet_rdma_release_rsp+0xc1/0x1e0 [nvmet_rdma]
> [ 8790.084804]=A0 nvmet_rdma_queue_response.cold.63+0x14/0x19 [nvmet_rdma]
> [ 8790.084806]=A0 nvmet_req_complete+0x11/0x40 [nvmet]
> [ 8790.084809]=A0 nvmet_bio_done+0x27/0x100 [nvmet]
> [ 8790.084811]=A0 blk_update_request+0x23e/0x3b0
> [ 8790.084812]=A0 blk_mq_end_request+0x1a/0x120
> [ 8790.084814]=A0 blk_done_softirq+0xa1/0xd0
> [ 8790.084818]=A0 __do_softirq+0xe4/0x2f8
> [ 8790.084821]=A0 ? sort_range+0x20/0x20
> [ 8790.084824]=A0 run_ksoftirqd+0x26/0x40
> [ 8790.084825]=A0 smpboot_thread_fn+0xc5/0x160
> [ 8790.084827]=A0 kthread+0x116/0x130
> [ 8790.084828]=A0 ? kthread_park+0x80/0x80
> [ 8790.084832]=A0 ret_from_fork+0x22/0x30
> [ 8790.084833] ---[ end trace 16ec813ee3f82b56 ]---
> [ 8790.085314] BUG: scheduling while atomic: ksoftirqd/7/46/0x00000100
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
