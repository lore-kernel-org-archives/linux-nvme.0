Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E01D606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fOAtEQpm;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=N3t2/uVM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AjS+KL2oktZWO67Px5zgca6j72giDiLVj8OXeGv9Z7Q=; b=fOAtEQpmrx5voA0SuJaFnWSzhp
	eIKamAyK+jVp2OMSHiew8eRGMttWSG3qxrLAF9roAZbodVs6fzzUhbmIiW9LTFkPy4BMS1Yh8e6g6
	qgtKQUG/V30AUhGx8N/rFahBmwFWFgYK5KzKEtQOeieGpIl/cC3kpgAZEdbzJabmsqwZxGevNbRH4
	H2PfBnVT1wiC1iGj+g0fA1Zju/37/wy954Y+bxq/Hk7b2zsNd5Apu9jcVB3M3PBPdhd3fJRims6Rv
	yCxpuE03yoaw6gAsN2OpU8goaP6+mXOANHWl+azJw+fKjPnVwMJ4FHGOfYLAtXWZWs71edpDKOvk8
	SQCYhtCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRV-00000009gQJ-1vJO;
	Thu, 29 Oct 2026 15:53:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRQ-00000009gEw-2sRJ
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:27 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TEoUvN1324344
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=AjS+KL2oktZWO67Px5zgca6j72giDiLVj8OXe
	Gv9Z7Q=; b=N3t2/uVMlEx/v6qHGWsGByQINB+/jA1B5j0SzUEMTKcqV5IxyQZte
	fpQBkN3fKmpORQPU/gYKnwEHbUMSllyoycoveMgJbYBmo5xkpHBEiJz/5FRxjoYA
	HA+0GE/GPZ2op0m+miBdgC/ApiE9fydNadHqGk8hd/xN2nZm/UTn3e62M7whI0bF
	MEbkKzH5wewTkuLW7u2CwmZkrDQZpKfJIdKsxCwjLJpQjskk23/1g4sbAAdtP105
	cSokUZFafgKynesEgZvXTaH3mguFKIVIrnJzTNvNqekW68D7l1bHwWum6KqlrzD2
	WdTzLqzOursAcrRB0EAYXXZg1djjXQxzQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm88vrjr4-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:24 -0700 (PDT)
Received: from twshared15328.03.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id C2C272E22CE7D; Thu, 29 Oct 2026 08:52:53 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes
 Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 02/19] nvmet-tcp: ask for the TLS record type on every receive
Date: Thu, 29 Oct 2026 08:52:35 -0700
Message-ID: <20261029155252.2332266-3-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX1gFVsbdWLW8+
 7PPP/zZpX5Z5Un8xc3IPjwrceGrvpUSaGzjEpi35/av2RLaw+KHKHSlSrRuOjIhFKCo1/HJrw8D
 sqrPiYnQsNTd99qbb5Pvd37vJR4ZLik=
X-Proofpoint-ORIG-GUID: ti7AvyQGqW3U9ruyFSYSEB0mCV9TKVWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX9PVLewiQhWks
 jfw965lqlqmx4U1tf6NSIKcOEcZ4SgPFAFR0KC19qSMCczY1ifXVqdz/uRxraYz6J1uQvruaf4l
 wIH+w61flFxo6ujuPmftagWPos4Zskyxwz2ojZHZVrUYs+Jzxe/M1jkPjVTSW+/lBYGeDlnanUj
 mR+dmE8KRYhtsNVzPnlLNqoz+i0b4JxtDMr6xwp/8EJ9xYYtzDY7ZzQ5alaqQaNMZnNOF63D5Cy
 sOIfxNe6VdO+6VwqY+Br9UBxiYczlQnn3zosB+N8jfw+0TtDpGC1sTpUFhLX08fjq0yetqt2CFD
 AbSuBoCQTs0jfL2zynANT1ky8Yi99yaHNJzodxFnQcXrvtgYMFdkhANIqWeHA4jfu16P9mkJHhJ
 MvgvmE7JL0IC+95mcPSO9ks8MkqVZ/p0p5G6n4cH+P2AdpFBUG3Ztd3iIU9moo0MuAgRtzoHUQm
 t32G4wxOzxH2dQ5KgaQ==
X-Proofpoint-GUID: ti7AvyQGqW3U9ruyFSYSEB0mCV9TKVWT
X-Authority-Analysis: v=2.4 cv=HKVWhYtv c=1 sm=1 tr=0 ts=6ae36bf4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=maIFttP_AAAA:8 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8
 a=qwfuxnYuW_8MUFtilVMA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085324_741220_B58F7978 
X-CRM114-Status: GOOD (  15.38  )
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

nvmet_tcp_alloc_cmd() points recv_msg.msg_control at recv_cbuf once.
The first receive that stores a record type there advances msg_control
and leaves msg_controllen at 0 for the lifetime of the command. From
then on nvmet_tcp_try_recv_data() sees the record type of that first
receive: if it was an alert, all later data is dropped as alerts and the
queue stalls, if it was data, a later alert can't be reported and
tls_sw_recvmsg() fails with -EIO.

Set up the control buffer before each receive, like the other receive
paths do.

Fixes: a1c5dd8355b1 ("nvmet-tcp: control messages for recvmsg()")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8092ce4914b62..158e422851a4b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1302,6 +1302,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tc=
p_queue *queue)
 	int len, ret;
=20
 	while (msg_data_left(&cmd->recv_msg)) {
+		if (queue->tls_pskid) {
+			/* The last receive has used it up */
+			cmd->recv_msg.msg_control =3D cmd->recv_cbuf;
+			cmd->recv_msg.msg_controllen =3D sizeof(cmd->recv_cbuf);
+		}
 		len =3D sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
 			cmd->recv_msg.msg_flags);
 		if (len <=3D 0)
--=20
2.52.0


