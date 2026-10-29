Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A782606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l9Rf/hT2;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=UADt3muu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XGCMQd77xENabqk9Vdt/zox/IqimV/2pzbst+qz7Td0=; b=l9Rf/hT2oeQMNCSOItAG1Q2DSy
	kkBYMlhU0AwnVHgaxJ+sXMmB1xUuInsUjlbeUjxO6cnk7qxwKzbCuqKin9cVuZe00Nvc8EZUTmK5W
	P8L+moCBKk3VkwOGFT0vgKlHs5gxWVwS9XLqN3RVY49h7yHf4pOcwVPyfpjtETN1nlO/QpB+o71tN
	YevxUfnHmyTPjab1ZdBhvduAqte/lyGaRPY+bdKRUyS+RCQwCYT4xwwIh2DE37yNgN+KacxnhQdst
	zHdPhViOKojT2JW0DLDQMYEtkeCHEMSzF8yBtCSlmJqNvOKrWyzAohfSWYOly7xdTNXnBEnCHFawO
	3lcZ64rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRZ-00000009gYk-0J6o;
	Thu, 29 Oct 2026 15:53:33 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSRS-00000009gG7-1HOC
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 15:53:29 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69TCe3Pm2479599
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=XGCMQd77xENabqk9Vdt/zox/IqimV/2pzbst+
	qz7Td0=; b=UADt3muuEQNgI9FBG923XUzJ23byrGCWYxluZNV7kbCKHLgMHPs4c
	fqXRZqQifGA43Pn90jr8CCFBwib8SYDy+W4k6yLxrJ+MvcIZM9DjSqWUGvsKBpWC
	col83Oh76+XXT3OJtHzn0KUjWCIL3CVflaO1cy4fG6xvXfEd9owk1dxn03RL3K4N
	8ApCeXQvGZWD1bqCzkSfTr0t7XRx1nEeXYGNJYkCVLi9q3rJ3G46rwmWbnIWgT+9
	sYuL/kAUYmjXABOwjFKKnxIelPMy+71YK9AUowO8tMy2gS0pUptUdnyUwhiOligD
	uWRK7CCcHUqOeWsHdmrJkI2yA/a4zMv4g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4hm5yr9mav-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 08:53:24 -0700 (PDT)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 29 Oct 2026 15:53:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CC7AE2E22CEBF; Thu, 29 Oct 2026 08:52:58 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, Chris Mason <mason@kernel.org>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 12/19] nvmet-rdma: disconnect only established queues
Date: Thu, 29 Oct 2026 08:52:45 -0700
Message-ID: <20261029155252.2332266-13-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029155252.2332266-1-kbusch@meta.com>
References: <20261029155252.2332266-1-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=S8NMU4sP c=1 sm=1 tr=0 ts=6ae36bf4 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=noPYQ3j_lezN9luSq70A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfXx64qkuxk7iXo
 8/I8e+xRroiZaDpEiVNkEUkzaks+MlaX0MoNougecroO8zdkcUaCkVhXQCoi9cZDfyZYsWMmsz/
 sek/xPFDy1LeVbXg628ty0cCxFsdqr8=
X-Proofpoint-ORIG-GUID: y-VoPzbrEzsyW-pF_5OidExh9rz8ztyM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2MSBTYWx0ZWRfX3EcbRfA05cyx
 Ubn394JRA+Sru7nO4SWTa5hJEKe+9qAvFRJDMpYF7+g9pJv3NehXOz51z6OezictLdQ/51XV2Z5
 dvj4crDCMA/mNRI7rZN/i8IfF3PGDo79FfT87KIpnDumsB8TPqD7rvYsdh2YmyQ81RqqvJSrzCk
 HdX19LJ+/jxelC+FpNrQY+KEVZH99xkkmAgpcha5t/U5e05uT1MTK9BFtAY6x8qpRobZirIa7Pl
 aQyekko5Yj2KHk8FWwDxLQaXpWShb9O+clGa8Rfrv7KZd651oVrRCyptUKRmK1jM75zpw47cnhf
 kqfytZTG+M5Uxx9HdmsJU8l7jnCV/020Nbvcd97t/eYW/737sxD1opq1MmlR9sKUkdeZoho19dV
 uH6DRjKNNJbei+qGAu34UeMjnGTvXE8vrDHYyeIJp118NkzJwDJe5K/yJtfAAleAlOn+3Sws8kJ
 WlDL2hCO29oGmiXXk0w==
X-Proofpoint-GUID: y-VoPzbrEzsyW-pF_5OidExh9rz8ztyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_04,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_085326_525482_1F54094B 
X-CRM114-Status: GOOD (  17.90  )
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

From: Chris Mason <mason@kernel.org>

Over iWARP, rdma_disconnect() sleeps in iw_cm_disconnect() until the
ESTABLISHED event of the connection has been handled, and iw_cm handles
all events of all connections one at a time on iw_cm_wq.
nvmet_rdma_destroy_port_queues(), nvmet_rdma_remove_one() and
nvmet_rdma_delete_ctrl() walk the queue list with
nvmet_rdma_queue_mutex held and call rdma_disconnect() for each, while
nvmet_rdma_cm_handler() takes the same mutex. If the walk sleeps on a
queue whose ESTABLISHED is queued behind another queue's event, both
are stuck and iWARP connection handling is dead until reboot. A peer
sets that up by connecting in a loop, or over siw by asking for MPA
peer-to-peer mode and then staying silent, which delays ESTABLISHED
indefinitely.

Only call rdma_disconnect() for a queue in NVMET_RDMA_Q_LIVE, which the
handler sets when it gets ESTABLISHED. A queue that never got there is
left to the release work: ib_drain_qp() moves the QP to the error
state, which ends the connection, and rdma_destroy_id() tells the peer.
Over IB and RoCE the skipped call did nothing more than that.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in d=
evice removal")
Fixes: fcf73a804c7d ("nvmet-rdma: fix use-after-free when a port is remov=
ed")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/rdma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fb20ba1b84e7f..fc0c85076cee4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1694,7 +1694,7 @@ static void nvmet_rdma_queue_established(struct nvm=
et_rdma_queue *queue)
=20
 static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue=
)
 {
-	bool disconnect =3D false;
+	bool disconnect =3D false, live =3D false;
 	unsigned long flags;
=20
 	pr_debug("cm_id=3D %p queue->state=3D %d\n", queue->cm_id, queue->state=
);
@@ -1713,6 +1713,7 @@ static void __nvmet_rdma_queue_disconnect(struct nv=
met_rdma_queue *queue)
 		}
 		fallthrough;
 	case NVMET_RDMA_Q_LIVE:
+		live =3D queue->state =3D=3D NVMET_RDMA_Q_LIVE;
 		queue->state =3D NVMET_RDMA_Q_DISCONNECTING;
 		disconnect =3D true;
 		break;
@@ -1722,7 +1723,17 @@ static void __nvmet_rdma_queue_disconnect(struct n=
vmet_rdma_queue *queue)
 	spin_unlock_irqrestore(&queue->state_lock, flags);
=20
 	if (disconnect) {
-		rdma_disconnect(queue->cm_id);
+		/*
+		 * Over iWARP rdma_disconnect() sleeps until the CM has handled
+		 * the ESTABLISHED event of this connection. The CM handles the
+		 * events of all connections one at a time, and our handler
+		 * takes nvmet_rdma_queue_mutex, which callers of this function
+		 * hold. So a queue that has not seen the event is left to the
+		 * release work: ib_drain_qp() moves the queue pair to the error
+		 * state, which ends the connection.
+		 */
+		if (live)
+			rdma_disconnect(queue->cm_id);
 		queue_work(nvmet_wq, &queue->release_work);
 	}
 }
--=20
2.52.0


