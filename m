Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2939606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oma+BlFu;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=AQZUTSR9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3ZcL7uhOHB9dAVkO4/B4l0rz1bHfG+oST9Ecj6KhW6o=; b=oma+BlFuaMocUuv1JUldIr5DU4
	dtwXN5Bz1HPj2Dzd0Fs5qqA++nceFS4Nwa+LmZsHjZfD5chwL/YKFlsWWxF3AB80eura196bxLoTA
	Y6jSjoqOlljP8s25NGW1fUCL2a2aemalWW4Vx3BnwcnksNC+dSnA/3Fp6J05vbUwQ/X0qfoPdrGKn
	aN2Uz36iuWI69GGAQilIyxD4jiU4Gm7FFA3Z0btrpjens7XfQFDICrzOvdrlLl+xrQxzTeMatFzTG
	lo+M9t8mclRFZe44rztaLycP1vHmR8bAMNTIpL20nVUpKA/9P9cwBWTJBzmvkTpe8t6YIxRTfBNuJ
	j1avtUxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRH-00000009fwe-0PuM;
	Thu, 29 Oct 2026 15:53:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRD-00000009fuM-1qaB
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:13 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCcfBN2668822
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=3ZcL7uhOHB9dAVkO4/B4l0rz1bHfG+oST9Ecj
	6KhW6o=; b=AQZUTSR9d4xXa2YUBKTJNj9qWZ9N6/nTFUmk4qrhVpS9ldpqSV46q
	egS4UrrLttHDRqnbOR7nrZZQ9X+zpeNfb40+v838tWi527VSDnJnLmkDg8jmc06n
	Gcl+EcwaNOqbWMozSr9DDepM6DfHkCNWy+co0jaMf5yjdkJHRjh4ivjuF//W9ZvR
	56nDlK6S8b8VaYjbr5XoLtmUzMdaPUkqWreh/3VTgdvSPd0+RPM3ZyDmZirAIRxQ
	XOL3Vk59ts+2r47Jjmn44MgXQeUZnkPveQBQ/wEVVPwmjiiXkrJEpgH3cEp+QLHr
	0BdXvPKbMwYkhLR56b79kcxqFy5PyGtCg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnpd-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:10 -0700 (PDT)
Received: from twshared36767.32.frc3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:07 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 758442E22CEAD; Thu, 29 Oct 2026 08:52:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes
 Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 07/19] nvmet-tcp: let the accept work come to an end
Date: Thu, 29 Oct 2026 08:52:40 -0700
Message-ID: <20261029155252.2332266-8-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX5syQs8TamKGn
 T2CcuXbmGCAmqOzEbFuC4EzCnW+WCPpu7/2gc5X7iyS7gUZUGOroS3L2/OENxhf0cila5Vv9d/B
 RVa+vhRGVIp4GEtgK54L74GtFEBzkDQ=
X-Proofpoint-GUID: inAwwW_oqX_p9Mg9HehlMUZ0ZfPAffT8
X-Proofpoint-ORIG-GUID: inAwwW_oqX_p9Mg9HehlMUZ0ZfPAffT8
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36be7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6f_Js7kaMIyz5LlK:21 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=maIFttP_AAAA:8
 a=Ikd4Dj_1AAAA:8 a=VwQbUJbxAAAA:8 a=kaggLGEg1OjrjjH46csA:9
 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX+YNrzmXyT7RY
 ejrwqvfIt7XxvGBRviDvRSaixK5i+akpIqJwJPA99zPwgViDk2mCMXtTmg2xxlmerHAulwI7Bpj
 PkcNM0d/jXTZKCNQkgj8066JvoFOvXhU0/1GHc4JB+g9T4jMh0oTWlX6j3SwBdVC5UTIrje1gfa
 f6uufoqgdC9QLJdYWaeb8cAGHj7Y4hgqcrfGNvc1aTTqm8syBx3MxLX3bygKr8frYN4fxnDHWh4
 d82rkit7Mzt0GTiZk9k1EnjrW/s7GCVulctctxI5oUv1MU4D+48/7+kicdAa0whufBdOR6Ycxxf
 sOIE+gVSqdHa849/0RiGuTBUL9ytH3FdwIEhI1txJzOlpuJ+QqrlridjzjFU0kpV62Z0EgRiYvt
 mhUqpcxRgeW0OroxWzAxJvHv1L+UxUgSOP5qobIdpz67NampbTusKox2tEeGwSQzir+dUU5lcJX
 6FDs6sOiDOIS93btpPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085311_484781_BF741D7D 
X-CRM114-Status: GOOD (  15.08  )
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

nvmet_tcp_accept_work() loops until there's nothing left to accept, and
anyone opening and closing connections fast enough keeps it running
indefinitely, since tearing down a dead connection takes long enough for
more to arrive. Whoever flushes nvmet_wq waits for it: removing any
other port of the target does in nvmet_port_release(), and so does
unloading the rdma and fc modules.

Accept a bounded number of connections per run and requeue the work. A
flush doesn't wait for work queued behind it.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/tcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 158e422851a4b..5105317cc61e3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -102,6 +102,7 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
+#define NVMET_TCP_ACCEPT_BUDGET		16
=20
 enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA_PDU,
@@ -2073,9 +2074,9 @@ static void nvmet_tcp_accept_work(struct work_struc=
t *w)
 	struct nvmet_tcp_port *port =3D
 		container_of(w, struct nvmet_tcp_port, accept_work);
 	struct socket *newsock;
-	int ret;
+	int ret, i;
=20
-	while (true) {
+	for (i =3D 0; i < NVMET_TCP_ACCEPT_BUDGET; i++) {
 		ret =3D kernel_accept(port->sock, &newsock, O_NONBLOCK);
 		if (ret < 0) {
 			if (ret !=3D -EAGAIN)
@@ -2084,6 +2085,9 @@ static void nvmet_tcp_accept_work(struct work_struc=
t *w)
 		}
 		nvmet_tcp_alloc_queue(port, newsock);
 	}
+
+	/* There may be more. Come to an end for those who flush nvmet_wq. */
+	queue_work(nvmet_wq, &port->accept_work);
 }
=20
 static void nvmet_tcp_listen_data_ready(struct sock *sk)
--=20
2.52.0


