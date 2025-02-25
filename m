Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDEEC021A4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ms8g50/1YJ68Be3VPvGpC5CwwNMeTtrPr9S/ofkhzmQ=; b=wO5yo+BGW3nqO4bFql6RqfbQg6
	NJay6P8rAaI8ZOONfh9Abgr+c/tcvUKbfzblJ/FaVsg+x3IHmJvdM7aKH0PIzxhuCY9310lV8UdNw
	KcF/60OANfce86hjQvakbHzeJbW63V8VNKYZGzlrlJ4gnW9LfKzE03bePCX+AIPKlOkwHV22ZYhdi
	nWITWZYAo9sIi+/6WK1kL+hy2D2g+rxmc+a8iAuF+/yKDUeY8UgvBYYRcXENKPcMNc3brUB6AgWLb
	6lb3UWXg+qspq/UthM2okHgv++34XQXKs4u7voxl5zv8Rc/djE3+H5Mg7ezqplEfEJ0FisvoRvAc1
	ehQ8OxRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmjsk-0000000FiIa-0Uui;
	Tue, 25 Feb 2025 01:37:10 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmjrc-0000000FiFW-372A
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 01:36:01 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P024U2016484
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 17:35:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=ms8g50/1YJ68Be3VPv
	GpC5CwwNMeTtrPr9S/ofkhzmQ=; b=Q8MZHmRtfAynuz2WupCt9msZnqMO2cv9aK
	gNVgnAmlHDvfHUyOGuGKwA0YFFHXEnuVm98SYXiiconKj8fhfDvY3H8jQWldw1Ox
	pBOiMHFMvQ009BQNwmX966K1g2CHWfprgpwhT7NmTNcgUkG/dAZ19EhgbsDFY0pD
	so3TE5crl2TzxXrgACYPJBM1X1FVuFb+ti7XBB2cggqkgtFUaQLIWBlCu7VWYwDc
	0wI7FYSZhhFIE3QxUnkrKUwKoGA1N8CuUDFJLBS9yFChuWhhmVcHCbPrdXI29325
	wKnO5eb3s4PgQU1qCUR41MAh6mMf3T3QghK6lWqvkhdpagyC8WcA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4511buh9x8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 17:35:58 -0800 (PST)
Received: from twshared40462.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 01:35:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4B375186AA841; Mon, 24 Feb 2025 17:35:51 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-ioctl: fix leaked requests on mapping error
Date: Mon, 24 Feb 2025 17:35:47 -0800
Message-ID: <20250225013547.1130524-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i4tJpVBcAzlhJYyvS8Mj2Jouhp0FUcsV
X-Proofpoint-GUID: i4tJpVBcAzlhJYyvS8Mj2Jouhp0FUcsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_12,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_173600_867883_AD44AAFA 
X-CRM114-Status: GOOD (  13.20  )
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

All the callers assume nvme_map_user_request() frees the request on a
failure. This wasn't happening on invalid metadata or io_uring command
flags, so we've been leaking those requests.

Fixes: 23fd22e55b767b ("nvme: wire up fixed buffer support for nvme passt=
hrough")
Fixes: 7c2fd76048e95d ("nvme: fix metadata handling in nvme-passthrough")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Without this patch, here's a nasty trick to lock up a queue's hctx:

  for i in $(seq 1 5000); do nvme read /dev/nvme0n1 --data-size=3D4096 --=
metadata-size=3D16; done

 drivers/nvme/host/ioctl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847af..41907b4e18694 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -128,8 +128,10 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 	if (!nvme_ctrl_sgl_supported(ctrl))
 		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
 	if (has_metadata) {
-		if (!supports_metadata)
-			return -EINVAL;
+		if (!supports_metadata) {
+			ret =3D -EINVAL;
+			goto out;
+		}
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
@@ -139,8 +141,10 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 		struct iov_iter iter;
=20
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
-			return -EINVAL;
+		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+			ret =3D -EINVAL;
+			goto out;
+		}
 		ret =3D io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
--=20
2.43.5


