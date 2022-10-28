Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF0FECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WTZ2hKlgqBkkpG56IbeCqBzXRCIucc0Opz3dNB0xQdg=; b=wH8POrQBFlMmAtS5Mqh/Bw5OnD
	27lB0/WGtNOtY3A+o+PfT3K+Dz0lG5esll6M/xFTqjSVMAF0HhTcf5B3NtOPb6r8FXMUlaMw23SOp
	p4VL0FybYSWzhj2lfuoAcpO+fAJrGjbsDUHCrVOmaRIkHkjxiJ331IIsCXrBa0yTV8WQ8yj1r9kKQ
	I83JGAD1U2b2TCjBoaRI6b6H9Bqz2X3VfQFg1zGyGuzffrpYqauuoVl0LQDJq8ya8EaOJlVQmXWu/
	lQkwnv8Ymv9zFRj3OVGsnp9C38CQyZTSI3utIp7cZYlA2pOCNg76qtIsZoifGzEBwz62VNq4Edbp7
	Ta6uzY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooVkL-0027wZ-QE; Fri, 28 Oct 2022 20:14:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooVkJ-0027vB-MW
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 20:14:29 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SJhm6H017288
	for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 13:14:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=WTZ2hKlgqBkkpG56IbeCqBzXRCIucc0Opz3dNB0xQdg=;
 b=auts0+L+8fB94rMpEpGWzf9bPt5v2QsK5mulliCz5sIVIO2UKYKVbP0c5WLVO9U8Apdl
 ArLpyfMOmm3cRdSinHM56CBLj5zg+qNGklf57ZFxbjqgw2xlkHj6Eic6aBV6Njgj9i3Q
 KQj1dTGFmoV4gVpZs2IK3kN3x/+kErJatkjS/9OUyWz9+0g415olFce0QKH/2+uV8Uoa
 H4yhG3QHuPXz2j3Sn45bdsNug0JZ9flR5iIYcVPBcUBft4iJdnACWiVALUvdYh0eY46r
 5Tixqi/jFbAbhCkqpyRDuDgvpSuO1OXHGCsRoTXY8sXlIxnXEnkXV5QQ/5w8Apd8MhWV 0Q== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kg0h242au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 13:14:23 -0700
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 13:14:22 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 189D9A6334D1; Fri, 28 Oct 2022 13:14:15 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Alan
 Adamson <alan.adamson@oracle.com>,
        Daniel Wagner <dwagner@suse.de>, Kanchan
 Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH-v3] nvme: quiet user passthrough command errors
Date: Fri, 28 Oct 2022 13:14:15 -0700
Message-ID: <20221028201415.3487291-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FCqxSCRnQ-rqY4TBAu66M-MwGmG2va8q
X-Proofpoint-ORIG-GUID: FCqxSCRnQ-rqY4TBAu66M-MwGmG2va8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_131427_772498_AB1E05FC 
X-CRM114-Status: GOOD (  15.93  )
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

From: Keith Busch <kbusch@kernel.org>

The driver is spamming the kernel logs for entirely harmless errors from
user space submitting unsupported commands. Just silence the errors.
The application has direct access to command status, so there's no need
to log these.

And since every passthrough command now uses the quiet flag, move the
setting to the common initializer.

Cc: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Move the quiet to the passthrough-only init (Alan)

 drivers/nvme/host/core.c | 3 +--
 drivers/nvme/host/pci.c  | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 686c55cb5d1a..52ae0bdda65d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -675,6 +675,7 @@ void nvme_init_request(struct request *req, struct nv=
me_command *cmd)
 	if (req->mq_hctx->type =3D=3D HCTX_TYPE_POLL)
 		req->cmd_flags |=3D REQ_POLLED;
 	nvme_clear_nvme_request(req);
+	req->rq_flags |=3D RQF_QUIET;
 	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
 }
 EXPORT_SYMBOL_GPL(nvme_init_request);
@@ -1037,7 +1038,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
 			goto out;
 	}
=20
-	req->rq_flags |=3D RQF_QUIET;
 	ret =3D nvme_execute_rq(req, at_head);
 	if (result && ret >=3D 0)
 		*result =3D nvme_req(req)->result;
@@ -1226,7 +1226,6 @@ static void nvme_keep_alive_work(struct work_struct=
 *work)
 	rq->timeout =3D ctrl->kato * HZ;
 	rq->end_io =3D nvme_keep_alive_end_io;
 	rq->end_io_data =3D ctrl;
-	rq->rq_flags |=3D RQF_QUIET;
 	blk_execute_rq_nowait(rq, false);
 }
=20
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72b5c1addbff..8cd92283cbfc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1436,7 +1436,6 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
=20
 	abort_req->end_io =3D abort_endio;
 	abort_req->end_io_data =3D NULL;
-	abort_req->rq_flags |=3D RQF_QUIET;
 	blk_execute_rq_nowait(abort_req, false);
=20
 	/*
@@ -2485,7 +2484,6 @@ static int nvme_delete_queue(struct nvme_queue *nvm=
eq, u8 opcode)
 	req->end_io_data =3D nvmeq;
=20
 	init_completion(&nvmeq->delete_done);
-	req->rq_flags |=3D RQF_QUIET;
 	blk_execute_rq_nowait(req, false);
 	return 0;
 }
--=20
2.30.2


