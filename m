Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481B5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apGns2hv2Kojna43sNpICvdsJ0mw7txl6GqDyuzbyqg=; b=aWbAGPXG5D6ldNtL5Evk6YpHKK
	scmXClsSx/EC8LnQzLLRFAx/uQxK/+atQXVtq1+4SziURaWeVIeHEK0YP0h22YHw+v4dIc+9Qw36n
	bqfFTqy11Ygq5/YnZr6WURxe6tOJoeX/Ycm3cWjr3ckfaYegNpD02HcYEVScmiazzeQB9UUb12rDN
	qqovZ8+aS+USLbjm2Hl1eIKXNkRql+yRUN1ApzfaZrrg+OwfEinjtg4hXtr8mPVQ2hLvl5E+BWaGD
	3f85WQk4nEJS8fgxO5RQdps5k7b77dAxgVQYp2DhG00AlwevSTqgEqEu3QZ8YGsbFnMG63OC0XIQJ
	++YqvDvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3PL-00Aqcu-Eq; Mon, 25 Apr 2022 18:25:59 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PD-00AqYw-2H
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:25:53 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP8qA003575
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=apGns2hv2Kojna43sNpICvdsJ0mw7txl6GqDyuzbyqg=;
 b=jDOe9AepZK9ByENGNI9IR4MSNc2bcbtw+NR4GhugdVxY0vz1vnbXIsqzS5Jg3Vtg8y4Z
 X+fraQdtugyZuvvQuiEz2x0aNHaOKq6MaNX2ttUZIFNCWNTKKehs6te4EK2zyYvb/zHw
 3YljzENVIT4aaKPgdEaZLbSiT80DgSQn3M0= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeytv0nx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:48 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:47 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 22A47E1F2A57; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 02/12] io_uring: wire up inline completion path for CQE32
Date: Mon, 25 Apr 2022 11:25:20 -0700
Message-ID: <20220425182530.2442911-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v9q7xy750SX1vIpaMcM6XeBMFIL4qJlm
X-Proofpoint-ORIG-GUID: v9q7xy750SX1vIpaMcM6XeBMFIL4qJlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112551_306984_FAC92E2C 
X-CRM114-Status: GOOD (  17.13  )
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

Rather than always use the slower locked path, wire up use of the
deferred completion path that normal CQEs can take. This reuses the
hash list node for the storage we need to hold the two 64-bit values
that must be passed back.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4c32cf987ef3..bf2b02518332 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -964,7 +964,13 @@ struct io_kiocb {
 	atomic_t			poll_refs;
 	struct io_task_work		io_task_work;
 	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
-	struct hlist_node		hash_node;
+	union {
+		struct hlist_node	hash_node;
+		struct {
+			u64		extra1;
+			u64		extra2;
+		};
+	};
 	/* internal polling, see IORING_FEAT_FAST_POLL */
 	struct async_poll		*apoll;
 	/* opcode allocated if it needs to store data for async defer */
--=20
2.30.2


