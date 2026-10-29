Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F1606A31D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MqxmVIBo;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=ElS4lUxR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Lmh9bB9upAdMad6EJ7uisZmCxAgEKXoW2Y7DwmTY6dA=; b=MqxmVIBosFvDVJ3t8X51fTuTBm
	UiAyRmozsFrlIwmTjP6Vxb0ghwzOt0vPZWZqTDcHK0Pe1L+TO9nTgtEm52ZiZb3zrDhWGusAWyzcW
	dlT8sd/CeL1gevXxJITvLzT8VbtZk/kDfy4x1tOv4YSEpBfdhcGQWMoxZ5tGGUQ2A2IEkxjfYL2i7
	dyeqi3QPoa1HC6eBLbrEkYUG1BovGvGPeFDJC4KieACeHb0jNr2B3bqy8wtTaGEi5mlbU076QQvik
	tLqDDPiVzCUz3Zt+1iIw9gG6SjK1ge7Wcmto/Gj1mDyekbk18rcY83eNqTl2AioqTYkvcbSPqE6R6
	lxg95A9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRT-00000009gMk-43Wm;
	Thu, 29 Oct 2026 15:53:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRP-00000009gBW-1Y69
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:25 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCch0Q426733
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=Lmh9bB9upAdMad6EJ7uisZmCxAgEKXoW2Y7Dw
	mTY6dA=; b=ElS4lUxRk4atrN62EDxTEKMMGgezvPcD7aTZNp5W/x9PJ+JIFsID7
	N6F/dLNM8cgT8U/Sn2NhnO+pEkDq8/b/0hX0TCWk5sEOkb7Sbm07H8PTGfM15t4B
	9Iju5AYkZ0v9fnh8BYe+oRBnqXBoKwOtWO1IIs8IsNs6qWSrKE2OgTu/7HnRe5H5
	vvd/u7LMRD0Rey5buAJelNjdscbQK1vjtdOGOoZ2Q6hniFAXiXdehuiR0YEsIlch
	+rBWJxCmEk83107d6QdqYpb698ze5rP+qK7lhBu+ETIfKZIcvZGkE7Hr1VC2ctsN
	Pbmyq9XBfNv4mytBKKgQwUaLF+r9flOWA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm5vk1js5-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:22 -0700 (PDT)
Received: from twshared8585.02.snb3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:13 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BBD882E22CE7B; Thu, 29 Oct 2026 08:52:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 01/19] nvme-loop: delete the controller if a reset fails
Date: Thu, 29 Oct 2026 08:52:34 -0700
Message-ID: <20261029155252.2332266-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=ccNHPXDM c=1 sm=1 tr=0 ts=6ae36bf2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=maIFttP_AAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
 a=jxjZ0yLLwfVarnHHvKkA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXyaKgBqCvGYUV
 5W5KGZqH8Uq/YkPVXEiz/xTQLenTsF3RIAwseKzShI9EfzPNgn/Y/jGQaidZczHWwqx4R0RTNGF
 be8klN7dv73D/74jWO6w8O+akBUaifawgGImL3i6Fx2wkkhZDEKDUmZgyotAXnMyQacwz9etvOI
 aERguuBClxSukK0a6GcIzKeQxg0as5IY69xcgF0yvzVe1OKkvbN7muPV2BpnPOnptNhYj8G2lbb
 +Axsw7WKZ86JwBcstURuiS5lC7HspttbrV+063o6Ya/kiTOQ8O2DN6Vjup+tScUAHd6O1I6N9Ub
 p/BCLmg+vB7iwflpxx4N2DfL0j4qwz14KgGfsugH0AKQgubYuQjtKbR3QVirGx/Q0qiZrfrg9VZ
 cB3xjjPkvaErwWgmhEXqNw2eEo2OEu5oDFL1tnDlgSQ+fuajXq+iYHXBLSiOFvGWRj5yz/pe+1E
 uS92Q8nkR3WcohG3WmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXxp1PEYRj0RVL
 U93U5ktr5Et2IoJ7kKB3PlJtdMCG7nClB5qq6SCQ9MeSUS2P4Fd9qKnY+/9eMcJBh9JNv4/MFtg
 TextaQfSy1orINpQgV6bQHDkhjh+2jc=
X-Proofpoint-ORIG-GUID: -Rt2xIN9FMiQ8C-hY5TkaCzq-b6AzfNQ
X-Proofpoint-GUID: -Rt2xIN9FMiQ8C-hY5TkaCzq-b6AzfNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085323_421257_B6A96E68 
X-CRM114-Status: GOOD (  16.45  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Josef Bacik <josef@toxicpanda.com>

If the reconnect of a reset fails, nvme_loop_reset_ctrl_work() tears the
controller down by hand with nvme_uninit_ctrl(). Since that was split
from nvme_stop_ctrl() it no longer removes the namespaces, which hold
references to the controller. A reset while the target no longer accepts
the host (allow_any_host 0) is enough to get there: a sysfs reset hangs
in kernfs_drain(), an ioctl reset leaves a controller stuck in
CONNECTING with its block devices, the cntlid can't be reused, and
module unload deletes the controller a second time and hits a
use-after-free.

Do what the other fabrics drivers do and call nvme_delete_ctrl(). The
delete path quiesces the admin queue and only unquiesces it if the queue
is live, which it isn't after a failed reset, so unquiesce it
unconditionally before destroying it so a stuck request can't block the
freeze.

Fixes: d09f2b45f346 ("nvme: split nvme_uninit_ctrl into stop and uninit")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e579a307798b9..80b67608eb155 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -420,6 +420,8 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_=
ctrl *ctrl)
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
 	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
+	/* Left quiesced if a failed reset has left no admin queue behind */
+	nvme_unquiesce_admin_queue(ctrl);
 	nvme_remove_admin_tag_set(ctrl);
 }
=20
@@ -483,9 +485,8 @@ static void nvme_loop_reset_ctrl_work(struct work_str=
uct *work)
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_delete_ctrl(&ctrl->ctrl);
 }
=20
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops =3D {
--=20
2.52.0


