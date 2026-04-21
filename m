Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796CFF8FA90
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2026 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d0JoeiB4mXoWEuQdD14i5tn7V+0OHRspnkt8BePfh4M=; b=l3Lra2AsGbO2Yn6D5iY3kqYkTW
	UzaQ8CIET4/0Hugekv0Q2W7077ZEbMuqRPSaK1xHq9AZ6jKSaX0n+ybCRjGox8z6c98vbC0g7f9rM
	zyG09wN3ImYasFiHRLTF0p+YVFgzF1qnKLKec7NCrI/gT0+cemq7OgQ7CBqkILdZ4/thQmkZtnye7
	56k06utmIrvIcl3XizjyZYsZWP8SkZkw+/8JsGZ5texoBEJLYTHKrhs8cbKoqxu6JDDthfCtzqi0J
	s0wiUk7YFclgvdOmUzliTVLyb1lv6XQbcNoSIRI2jeO9sgFLndZzXSAFfglfe0JrBojgsbWdA5XOd
	pPWWHYtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFDot-00000008uAK-2421;
	Tue, 21 Apr 2026 16:19:27 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFDor-00000008u9y-0QtQ
	for linux-nvme@lists.infradead.org;
	Tue, 21 Apr 2026 16:19:26 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LGA2dC2793506
	for <linux-nvme@lists.infradead.org>; Tue, 21 Apr 2026 09:19:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=d0JoeiB4mXoWEuQdD1
	4i5tn7V+0OHRspnkt8BePfh4M=; b=ZiDq5nU13pb0AC3cgTX3EXM1OarKjJBRuk
	gV7hqV/cmP3o4Wbq6SRly4gDU4gAQvkxbDdFJ/30XW8h/pOB3+zMnCvnYnboD4JQ
	Hcxxpz/7Bucq0W6YM1I3hhWtB0NM35ZXCKskRG6tre4SFWgZTtDUh88xppqUQ9iL
	7THzF8ygaiyQNYB8Ez/d2f5Ysrh6RdyHEci7YzE1ofd1740N9y6WPLdZjei8MVUv
	uKTe4u7X008qkj9nLyr61w6WkM4UAVevjr7Su3Fm5CQ00ULUk2eK0CptZeHwWH0j
	Is/COgxuuFEiHOOqEEjcG4v2Vf9P00vaD87SV7WScHmEAF4dlFYQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm58yhg2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 21 Apr 2026 09:19:23 -0700 (PDT)
Received: from twshared11748.04.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 21 Apr 2026 16:19:10 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 8C2EF12B0AC43; Tue, 21 Apr 2026 09:18:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>
CC: <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: fix missed admin queue sq doorbell write
Date: Tue, 21 Apr 2026 09:18:55 -0700
Message-ID: <20260421161855.3980034-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69e7a38b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=Rmh_FCgJpDiOAufgXYUA:9
X-Proofpoint-GUID: C5Ajl4L8pDg4zkVWioRVi4cc_eqrlRjo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX4DX8P8wRPTV8
 MUwofZbgy5GQ5/CVs88Xv5QdCK1I9DwMojkIQs2668o/xn+F52EHvZpn3ico456pLDyvMcxNB35
 xDzvWjO9gAv8HMiMYuw6shoYrJwnM+Y1KS0+mOJaguUXgvYrI+69C71vU7LACQfPAGMe1QKf7Ef
 WxdNX9JlwhPs31tq+VBjHfBmG3ATFrkQhkJLJEivwNg78m8Jmmb+HmmD0XYIUMomgma92i5JyGR
 1P4yECrxi+akRYo/16n4polBZo2vVBQ05u609gHUfEwlXeKsRhc34ofdV0dyJkJBpXt7gWWQ0l7
 MvWDBwJjeOHMokQGVDUR4xLwtlo672f4Y/82Mx/N08zQESf/WZrA9l0YKDCFS4EaCoxe0ppmcli
 fLgxBeQvlbN3Q4hbwcIBEni9AlOWLMTRROUTSNqjON4ib9OCbckk/+6q4edYdjGEpxUeHxvOz5E
 flF+6WVC4I7fZhycWXQ==
X-Proofpoint-ORIG-GUID: C5Ajl4L8pDg4zkVWioRVi4cc_eqrlRjo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_091925_151925_94A871D4 
X-CRM114-Status: GOOD (  10.58  )
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

We can batch admin commands, which means bd->last may be false, skipping
the doorbell write so that we aggregate multiple commands per write. If
a subsequent command can't be dispatched for whatever reason, we have to
provide the blk-mq ops' commit_rqs callback in order to ensure we
properly update the doorbell.

Fixes: 58e5bdeb9c2b ("nvme: enable uring-passthrough for admin commands")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf66272..4c052ed18cb8d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2241,6 +2241,7 @@ static int nvme_create_queue(struct nvme_queue *nvm=
eq, int qid, bool polled)
 static const struct blk_mq_ops nvme_mq_admin_ops =3D {
 	.queue_rq	=3D nvme_queue_rq,
 	.complete	=3D nvme_pci_complete_rq,
+	.commit_rqs	=3D nvme_commit_rqs,
 	.init_hctx	=3D nvme_admin_init_hctx,
 	.init_request	=3D nvme_pci_init_request,
 	.timeout	=3D nvme_timeout,
--=20
2.52.0


