Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7F606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iXBMYVXW;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=mw/CRyeS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bPhAjwLrZqQMq+hHyRcLffsFNtJOw02gP1csuX15Nbc=; b=iXBMYVXW7IqvP6LZMfgrrcG1iG
	d5TIvJTC1AP2b/A1B+JAqEXEdjQBxA8CPwyjn9z4sNCBwWd+DUEQKZqes8RJnohyfA83SG3otscij
	TA2eJMOCg3cOR0nmCaG6T5CJ1j8m9146JEW/VzVRS26OQ7EzNIAMnLOmrO5xRBR6ngRLrwESKfVdJ
	3gOsduSJAuAPO7qNxxMrVoivK4w73hEqSOra2Hiw1OAGX4bAA9zPNoOR5CZYhrLICWbHec00kBuKx
	h53zl/vuDLKgD1pNQFy+fNvVyBZS6PKwE+8AcRaNGprG4ixyTeyqBQ+aIs98HsDXDWulV3i4Sk/pX
	Op4ZFrCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRK-00000009g1G-0HYS;
	Thu, 29 Oct 2026 15:53:18 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRF-00000009fvl-3YC8
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:15 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TCdNgp2670384
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=bPhAjwLrZqQMq+hHyRcLffsFNtJOw02gP1csu
	X15Nbc=; b=mw/CRyeSEyyNDppQdyoE++qpyUM9ec9B5vqOlLw+nKUJ2vLxB8HQp
	RcvcW/XTPSHhcrS7K7oNromzV14CkjuYYCocplJawPkI7yNijJhjNRvW5Y5lPGOH
	JwnHwcfFzA3tFrRX2iDSoPXssQ0H+mP3fLq6FHCO3kM2vwDj8zDgMgyW57VIhr/+
	nIdNPJsg2qrsdvxTiXQBJVcSabTaa5pJZcyxl+8vUwc63o0zOBi1Ig36dMTIvQqD
	t/w4mKgRnE82diXvy7MLSX0RxN0CR9C1CrVBmWT0q6m137HZjV2LnVyBV25yYlkE
	F3oYIMYHEO2VL49EL3MU/5t/tcAtO4riw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hm28qjnp5-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:13 -0700 (PDT)
Received: from twshared30277.33.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:12 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EDFC62E22CEB1; Thu, 29 Oct 2026 08:52:56 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke
	<hare@kernel.org>
Subject: [PATCH 08/19] nvme-tcp: start error recovery when a send fails
Date: Thu, 29 Oct 2026 08:52:41 -0700
Message-ID: <20261029155252.2332266-9-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfX3+5QQCZVLvPB
 QwS66bw6/zEmUwSJy/q1BTiez8rDh+KOHnqt9V+srODPWF/w1kWfSBzi9XufIzs8+tKq95BwNZb
 K/1YD3PMmzL24BjJf6RzmNYayXg5/wc=
X-Proofpoint-GUID: 92noGQZFJnPaCdtEkYJ4K1GCLbbgSDAw
X-Proofpoint-ORIG-GUID: 92noGQZFJnPaCdtEkYJ4K1GCLbbgSDAw
X-Authority-Analysis: v=2.4 cv=NudE4MdJ c=1 sm=1 tr=0 ts=6ae36be9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=maIFttP_AAAA:8 a=VwQbUJbxAAAA:8
 a=0DUUQeXdsZC2MOM7yMoA:9 a=qR24C9TJY6iBuJVj_x8Y:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MiBTYWx0ZWRfXyxMB7LSEdK0W
 TMnuGk3OpP0Z6ErTPEwRWDSA268+pg2L9FMk/J892usIo+dzav+iZgKUAigpCT+bVUPGM7ksK5h
 I5U3Zgk5OLBeMweh4mmd+TktNvAPFnPIoYZ+WxLTYxjFFfz6ECBPZhar2FULt5Wag5kANZgf2BX
 kNs8iQ4Lj1wwpAqqbJxVaRD3+gACP4Gpm4UW4GwLIsgxrl0EnTRA8n2/6sewbnxEd1GNP9fFZtv
 glX83k+RbSVtBEfFfcEt2B65vh7QbnbNVg2zTj5cgGKNYLQ71dcrOJaSPSXuiTuuQfvSo81g6Tz
 3pdZ0GBcIWdavgvmQkSjDoooIHQhvjfRv7MiMvH3MwmCCb4giTkUV444epwBlAgbrFS3K/d5s2a
 b19RwoNbOrl0C2DzPrYk//RJ9iK/Wc0xuOiXJDcq4GFafytXxkBlBMvSEalLUXQwLZuPHJlxH+Q
 jm9HN5RqI1ehxM733Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085313_897290_8C1E4CE3 
X-CRM114-Status: GOOD (  13.84  )
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

When the target closes a connection, nvme_tcp_state_change() calls
nvme_tcp_error_recovery(), which does nothing unless the controller is
live. While connecting that's fine for the queue being set up, its
Connect fails and the attempt with it. But if an already connected queue
is closed at the end of the attempt, nothing fails, the notification is
lost and the controller goes live on a dead socket. Every request on
that queue then fails with "failed to send request -32" and is retried,
forever with native multipathing, and if it's the admin queue the first
keep-alive fails too. Nothing but a manual reset recovers it. The Linux
target closes its connections at exactly that moment after a fatal
error.

Start error recovery when a request can't be sent, as nvme-rdma does.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Cc: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bc46e5f3eaa79..9e15311e7d9cc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1437,6 +1437,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue =
*queue)
 			"failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		/* The close may have come when nobody could act on it */
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);
--=20
2.52.0


