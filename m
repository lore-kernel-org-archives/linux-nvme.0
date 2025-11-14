Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08286CE7B1B
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fRlQbwpcBOl3FM0u2gHYwje7SMxuTpRQlSYzaoOK8nE=; b=urCOHOssr+Ly4rJhBOmX8t+Sav
	qG+dnugifU0/sJ4+FmTJZ6oHd7yGfgU9Pjp7kEDuroDuSAs+nEJJT6XXImijh48s2Np/O876r7pot
	aSZk3zuKHCOfcsHrI/+Oc+t9fDKnUwgpAfN8RQEdxNnPtamy7Ltrm2NFhXIaOgL0xOdLDN4v2qhO8
	eGctylBr/vxdR+GRQKsH+1L/aTjUZzMDWRIHNTK9spulj6e+GboZcFr3e7r4SjMnzSt44JoMEvoJf
	jgzwMhwEF9C50IlPjJP1tz6AjdLwwaVnRKvHXWJP8hswbz7yqYaNWZo3NoUvSsWgjWDL/pWfH1IVZ
	j1J7hgKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvQV-0000000CSuT-3uXM;
	Fri, 14 Nov 2025 15:09:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJvQP-0000000CStt-2XdO
	for linux-nvme@bombadil.infradead.org;
	Fri, 14 Nov 2025 15:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=fRlQbwpcBOl3FM0u2gHYwje7SMxuTpRQlSYzaoOK8nE=; b=fMEpKf1mr4nI8TfReAtVDerfoo
	S025bp5A5UxSchct91T2P3eIKyzIh995yV4kkXmqVQrYVzb+97+onmJf0/LGOrdXZWA6eNsZUiV/X
	e7PvBpp2nz12fkQWuUBobdPGnjbBxqHWCDJLsLv8CjmeDuv5QdA5NjcRmUenmSFh774pgF08i1JdP
	6nrfHqLr8SakAvVbWyFHlxs8RBGRQGohV10NXPy7CjOwdMNlyGVttDZBq/oojMxMQ21wHC8JNd9j1
	RF5LoHRkrYtmy57IHUW41OmOje7XWnPMWTpTwQTtq5E8wwd/fx6c4jrI8DzOhzi6POknoMsbny3jC
	64Mvm7CQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJuYh-00000002lwm-43cW
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 14:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763132947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fRlQbwpcBOl3FM0u2gHYwje7SMxuTpRQlSYzaoOK8nE=;
	b=JGhRd/KkuLFs06Q/KSzFv2zTnTA4/76QIgvp0lL0mC8OGogb3DLrMTgFRKtm+HDvcUi0m8
	/zC2D1hl0jLCCaLnIzMifsEfQpBk4j73WXYcgXVaw6hRkckDbCheVq/ZbupkuP4uqyDxbl
	teRhLz9+rDAkI9xiUv687nunjbrFg9s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763132956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fRlQbwpcBOl3FM0u2gHYwje7SMxuTpRQlSYzaoOK8nE=;
	b=e2VGSnpkaoXLyP0ZxSnHlPW+CcV+tpqink1BCV42HY+7d6uObELrvSRsCdlX+rLo4eYOr6
	dIzcBpat4PTlU+IK+Hw90ZY0cA6GdFZflCNUif8+G3g41IlY/cxxfaV3Ofb18ffqvwugh9
	pf/EU3tlxFzANqb8AYTO7+CrRfnylOU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-hzRcjlXHPiunZwzVHtSrZg-1; Fri,
 14 Nov 2025 10:07:38 -0500
X-MC-Unique: hzRcjlXHPiunZwzVHtSrZg-1
X-Mimecast-MFC-AGG-ID: hzRcjlXHPiunZwzVHtSrZg_1763132857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C249B180028A;
	Fri, 14 Nov 2025 15:07:36 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.89.147])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80F193000198;
	Fri, 14 Nov 2025 15:07:36 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id C5881C189E; Fri, 14 Nov 2025 10:07:35 -0500 (EST)
Date: Fri, 14 Nov 2025 10:07:35 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: fc: stop lsrcv workqueue before freeing a rport
Message-ID: <21255200-a271-4fa0-b099-97755c8acd4c@work>
MIME-Version: 1.0
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bXt7Et5sIwwNQxbR5ZbrQ9gGMHo8nVGP1aZXw8HSW6U_1763132857
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_141352_266626_A55076E9 
X-CRM114-Status: GOOD (  14.04  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

While running blktests/nvme internally we managed to hit
a race in which a lsrcv work is still pending while the
rport gets removed. Strangely, this is way easier to
reproduce on a s390x than any other architecture we test.

	[12996.173074] nvme nvme5: NVME-FC{5}: controller connectivity lost. Awaiting Reconnect
	[12996.173446] Unable to handle kernel pointer dereference in virtual kernel address space
	[12996.173449] Failing address: e64d52f26d80e000 TEID: e64d52f26d80e803
	[12996.173452] Fault in home space mode while using kernel ASCE.
	[12996.173455] AS:0000000195920007 R3:0000000000000024
	[12996.173560] Oops: 0038 ilc:2 [#1]SMP
	[12996.173566] Modules linked in: nvme_fcloop nvmet_fc nvmet nvme_fc nvme_fabrics nvme nvme_core nvme_keyring nvme_auth sunrpc rfkill virtio_gpu virtio_dma_buf drm_client_lib drm_shmem_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm_kms_helper virtio_net net_failover fb failover virtio_input vfio_ccw mdev vfio_iommu_type1 vfio iommufd drm drm_panel_orientation_quirks font i2c_core fuse loop nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock ctcm fsm qeth ccwgroup zfcp scsi_transport_fc qdio dasd_fba_mod dasd_eckd_mod dasd_mod xfs ghash_s390 prng virtio_blk des_s390 libdes sha3_512_s390 sha3_256_s390 sha_common dm_mirror dm_region_hash dm_log dm_mod paes_s390 crypto_engine pkey_cca pkey_ep11 zcrypt pkey_pckmo pkey aes_s390 [last unloaded: nvmet]
	[12996.173639] CPU: 1 UID: 0 PID: 633486 Comm: kworker/1:31 Kdump: loaded Not tainted 6.18.0-0.rc0.53c18dc078bb.1.RHEL100912.el10_1.s390x #1 NONE
	[12996.173644] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
	[12996.173646] Workqueue: events nvme_fc_handle_ls_rqst_work [nvme_fc]
	[12996.173661] Krnl PSW : 0704c00180000000 e64d52f26d80e69e (0xe64d52f26d80e69e)
	[12996.173685]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
	[12996.173688] Krnl GPRS: 0000000000000000 e64d52f26d80e69e 00000001058e9830 00000000874f8800
	[12996.173691]            00000001058e9830 0000017ed7b593d0 0000000000000000 00000000874f8868
	[12996.173693]            00000000ec994000 00000000874f8800 0000000000000000 00000001058e9830
	[12996.173695]            0000000084ef2a00 0000000000000000 0000017ed7b594dc 000000ff5884fbb8
	[12996.173700] Krnl Code: Bad PSW.
	[12996.173702] Call Trace:
	[12996.173703]  [<e64d52f26d80e69e>] 0xe64d52f26d80e69e
	[12996.173707]  [<0000017ed7b32f40>] nvme_fc_xmt_ls_rsp+0x60/0xc0 [nvme_fc]
	[12996.173713]  [<0000017ed7b34218>] nvme_fc_handle_ls_rqst_work+0x138/0x240 [nvme_fc]
	[12996.173719]  [<0000017f5702b8cc>] process_one_work+0x1bc/0x3e0
	[12996.173730]  [<0000017f5702c53e>] worker_thread+0x23e/0x440
	[12996.173734]  [<0000017f5703830c>] kthread+0x12c/0x280
	[12996.173738]  [<0000017f56fb1d6c>] __ret_from_fork+0x3c/0x140
	[12996.173744]  [<0000017f57af236a>] ret_from_fork+0xa/0x30
	[12996.173750] Last Breaking-Event-Address:
	[12996.173750]  [<0000017ed7b594da>] fcloop_t2h_xmt_ls_rsp+0x10a/0x140 [nvme_fcloop]
	[12996.173757] Kernel panic - not syncing: Fatal exception: panic_on_oops

Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
Cc: Paul Ely <paul.ely@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Aristeu Rozanski <aris@redhat.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 03987f497a5b5..1762f62ebf820 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -518,6 +518,8 @@ nvme_fc_free_rport(struct kref *ref)
 			localport_to_lport(rport->remoteport.localport);
 	unsigned long flags;
 
+	cancel_work_sync(&rport->lsrcv_work);
+
 	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
 	WARN_ON(!list_empty(&rport->ctrl_list));
 


