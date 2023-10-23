Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D66C25B41
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z40SyYvGLYKyXDNKbsBhnEqwiclPjo8D1fWa8Ktd7Ak=; b=x8JeiTWXihIsT/7vzVgfxwfgdU
	9HkIVDKI4SZ8h5A87de3uFrZhLYODQg1t+TNdCULor2OLi/StyxhaMVs9cKTFx4weIagxxkjDuAQz
	ZbS02TJAr384JFLuInN6gmYLno/OwVvOOyfXrPAdeklWGv23XmCobDNOq2vjvohfyPnEZZYlDTfdj
	atbU1YyiPyR3Y5bIeTE93gGxciHVMbE3NV0MKPuOYeBTb1sbuaWTg/SE0OqcYw2OmZKsF3Jh3BlmY
	kvK1Qndb8GrUnIBN7/iBS/7R6APJ4fTwhpQQ3noZeqPeDqV9klzPl4A96nWJzO/Yub+ay/qmxDQ6K
	VwuMhnxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTn-007Udx-3C;
	Mon, 23 Oct 2023 14:00:27 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTh-007Ub6-29
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 14:00:23 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id CCAEF24002B
	for <linux-nvme@lists.infradead.org>; Mon, 23 Oct 2023 16:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698069617; bh=zwCuyhVmMr+6W+Jc6uApqtn4VjGeJRlPp4FvHh/J5fE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=U/K/JPNl04rAE19qY8DvRu5Br7MpMde5s1OJ5R3sxavfVW42n8At+nCx1j0iD0fVi
	 4U/tn30rzk8OhC4sFUHEZWy+ZeeSauqtA7ctggg+9PFW+eH1uBLVI4fig4z0cubJTg
	 niTI3XC2IfEO/WNXa5JmQyVLwe0Vtz/xe8NNNqDxSBctzymKUBeCZsbSjz05lano9w
	 JpyHLkwzH2gs5Kn/0U6DAkzdQy4T4Rs75CHO1YUGZk2FuhbXJ2uF43iZf+Kr/XjWn2
	 Rrr5q6Z712DILTvX2X8BmXz9Q9Uwcocj4B/M18P9FoDqPiA2bdO3P1xRzh/C5o8LX2
	 L003NwS1i8arQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SDcJw3V66z6tsB;
	Mon, 23 Oct 2023 16:00:16 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 3/3] nvme-auth: always set valid seq_num in dhchap reply
Date: Mon, 23 Oct 2023 14:00:03 +0000
Message-Id: <20231023140003.58019-4-shiftee@posteo.net>
In-Reply-To: <20231023140003.58019-1-shiftee@posteo.net>
References: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_070021_869044_E618D04E 
X-CRM114-Status: GOOD (  10.71  )
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

Currently a seqnum of zero is sent during uni-directional
authentication. The zero value is reserved for the secure channel
feature which is not yet implemented.

Relevant extract from the spec:
The value 0h is used to indicate that bidirectional authentication
is not performed, but a challenge value C2 is carried in order to
generate a pre-shared key (PSK) for subsequent establishment of a
secure channel

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>

---
v1: used incorrect prefix nvme-tcp
v2: added spec extract to commit message

 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 8558a02865ac..7f6b2e99a78c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -316,15 +316,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
-		chap->s2 = nvme_auth_get_seqnum();
 		memcpy(data->rval + chap->hash_len, chap->c2,
 		       chap->hash_len);
 		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
 			__func__, chap->qid, (int)chap->hash_len, chap->c2);
 	} else {
 		memset(chap->c2, 0, chap->hash_len);
-		chap->s2 = 0;
 	}
+	chap->s2 = nvme_auth_get_seqnum();
 	data->seqnum = cpu_to_le32(chap->s2);
 	if (chap->host_key_len) {
 		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
-- 
2.39.2


