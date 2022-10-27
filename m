Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2044ECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KlQyR0dER+VndwVJu/YJXoIBSOrgPj148wgzE47krJQ=; b=WrJKXadowJDSEB4F8Ongj4K3bW
	UpFgG9Exn7tdp9UOur+yvVZ2f2Rp7cLwJYeFiVe8Isq/6466e05EabNVjmxdm04v0Z4c8mJrGbk/s
	Ec3LaXPk0jaOAlJU1x+pyyKNW0hik35XR1Kyju1hjXW67UDx88XyZRgIbvMRIThCuVxqnLQAcpJ7N
	Tyc7nS7VyaM9gkwjYV4q5x6SSo2vuUuTnfeCh2MWnG+zjrIrKdGSwWki0fB9Qz1sJPjBLnnGrFhzi
	6Veyy66epOgUZg8GlJTZVEhAuNISsUypEoc9dDeFOFIEh1/eb7ubIAo4U/wGW7XVnhVHvSnbkI87A
	QCOilhIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4RB-00Dy8k-5s; Thu, 27 Oct 2022 15:04:53 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4R6-00Dy4O-Ql
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 15:04:50 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RCQu4V000906
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 08:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=KlQyR0dER+VndwVJu/YJXoIBSOrgPj148wgzE47krJQ=;
 b=MP/7zwjW1aD5gP0itrXyjfam6mS+AqQi+8BklErMBEN0Jnn5J5v9awK3Mhm5yxJ/SHnO
 29uH6ur1QQIbdBuWkIiKutoHqdfxF10Adk3Alwdw2p0Hy0OS+A329PziBmn2YGiU8V1a
 x1BFUZn+E0w/6xSx40M2/+yW2Nwj86bMTCrcNLPo/sTniTvc/soNv0JtL84PKGAhnecQ
 RNOgKCux4BU0u37QhW4rwfVhpNqiOgJ3BCQ/Kfpk6unmNYLb7hhhjHDb9AyUymrbhydS
 ZNybAVKsIh3Pac6jLM2Gp+m9vWdsN6r7+sEzIsvYTo00OYSsl7yv2FnCJYT8Xphnwb+O AQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kfahs1the-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 08:04:40 -0700
Received: from twshared3704.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 08:04:39 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 92F3FA55A6CA; Thu, 27 Oct 2022 08:04:30 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <chaitanyak@nvidia.com>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
        Alan Adamson <alan.adamson@oracle.com>
Subject: [PATCHv2] nvme: quiet user passthrough command errors
Date: Thu, 27 Oct 2022 08:04:17 -0700
Message-ID: <20221027150417.1954662-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Sl1JwsT4APyE-v8vxUViAnsPpju_WI4T
X-Proofpoint-ORIG-GUID: Sl1JwsT4APyE-v8vxUViAnsPpju_WI4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_080449_099534_716012A1 
X-CRM114-Status: GOOD (  16.42  )
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

And since every passthrough command wants the quiet flag, move the
setting to every user's common initializer.

Cc: Daniel Wagner <dwagner@suse.de>
Cc: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Set the quiet flag in the common initializer instead of open coding
  the flag for each path.

 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
--=20
2.30.2


