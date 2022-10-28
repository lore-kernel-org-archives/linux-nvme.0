Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BD1C38A02
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 14:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y4JyCpVacLJgNi/rKqhXuP0kv7XL+R+ypdxlnPtZNww=; b=hf8tYtsNg2oXHR0b0kuZ1zaa7O
	Qj2xoPw5lSTGCzpUTwLhLkis9zqkfZmLQPKQL6vAGdscPTqY8auNEDFt6kSwYiOuHbdn/yiiwkFuP
	sDtmLhqtO9mMIavHdK9c036lrXzESIW9fhPmK0z+kdQeKhnSpT2/2uOVFbpp8uaeA0bpYfvBl9ve8
	S7Zy5t78gpddRFFe5b16nLiMrhbqKC9IYI1rHysPaS/ImE2JYa29TdFZcD9BGGyu3aC7qO1tMNAdK
	p0odao8G2ZbnPZeJ5WqhsoltWuZCUwvH6E04KNEeE9bBchXgHmMGBXboYMBGxsITwuvWhSs5LzsY+
	rxCdqTjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooQbx-000EBr-L8; Fri, 28 Oct 2022 14:45:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooQbQ-000Dgq-VV
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 14:44:58 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SA8s3E020408
	for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 07:44:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=Y4JyCpVacLJgNi/rKqhXuP0kv7XL+R+ypdxlnPtZNww=;
 b=huhwPTf1mNy2rBDHWb7nx7kEQhpApOjLLgth3iB4OS0Fk92M1ojl/OGDCvYWOegP9biq
 JszaM2G9K0Hl5DzI3ORHzsN0CWAADDnWtaXxBjXMeYlEB6aulZS6i5BaKIaGDC/lbRu1
 RH7tI68FRBdE0Ze+LFCPr/UhekONL8Ocm/6j2tdRiFF9zB2iDeO1VAIUAO4s6GlCX/5O
 HOl0blPYef+Teh8iBNjjY7aRU2jkL2vTVl9hIcMPhdY61zu6BM3Fa8OqfsSXpLOjHTB9
 gfwij/F8729pIUiOPrPhrCBAr+Ugp+bvVljtD70ItZytFNIPoa6Bvj/nJOCuVcechXIU gg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kg23yqf6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 28 Oct 2022 07:44:52 -0700
Received: from twshared21592.39.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 07:44:50 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 744ACA6091B7; Fri, 28 Oct 2022 07:44:45 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Alan Adamson <alan.adamson@oracle.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCHv3] nvme: quiet user passthrough command errors
Date: Fri, 28 Oct 2022 07:44:35 -0700
Message-ID: <20221028144435.1613982-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JV80m1C6ip_rEQ3JWtvi79hY3pNLhWj0
X-Proofpoint-ORIG-GUID: JV80m1C6ip_rEQ3JWtvi79hY3pNLhWj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_074457_330159_A405BBF9 
X-CRM114-Status: GOOD (  16.28  )
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
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Removed the last open-coded RQF_QUIET flag users since the setting is
  redundant with this generic change.

 drivers/nvme/host/core.c | 4 +---
 drivers/nvme/host/pci.c  | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 686c55cb5d1a..543782dcfba9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -657,7 +657,7 @@ static inline void nvme_clear_nvme_request(struct req=
uest *req)
 	nvme_req(req)->status =3D 0;
 	nvme_req(req)->retries =3D 0;
 	nvme_req(req)->flags =3D 0;
-	req->rq_flags |=3D RQF_DONTPREP;
+	req->rq_flags |=3D RQF_DONTPREP | RQF_QUIET;
 }
=20
 /* initialize a passthrough request */
@@ -1037,7 +1037,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
 			goto out;
 	}
=20
-	req->rq_flags |=3D RQF_QUIET;
 	ret =3D nvme_execute_rq(req, at_head);
 	if (result && ret >=3D 0)
 		*result =3D nvme_req(req)->result;
@@ -1226,7 +1225,6 @@ static void nvme_keep_alive_work(struct work_struct=
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


