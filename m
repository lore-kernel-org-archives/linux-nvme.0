Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6B6C71153
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ka7/OAgDdM04A+GLENs/YFF97W0uzlCUC8pP2nUfIg=; b=YXUdH7otLncwjbHToKp6LnoWcX
	GHcNn+HsKN39a62BgfG78TvRyCWNb6msf2wbyKkH0oxP79ukwEb1YKj1QM4EYxVDGuYruSYi0jDCn
	93T6SwvTLWdXCS48yQygY88pqspk/cdUPC26p1vFilIMR7n8w3DPUji9TtJsST4ht0T7XtjlUS2R7
	7AnqI498SVBrLHc7sODA+LDaKGSaPW/hScJgZA15pBxCCs5ThzMPMegKQDKpITADOP/vUAV7E9iqQ
	sl5ON674hqmlDmuI8Zwi0PSxVfT7mji7EOLnMdrJa6RwZjoVL9aIRHOkb9qQTnkAEaZVusYtfxABw
	Z2F2Glvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qajno-00AJHM-03;
	Mon, 28 Aug 2023 21:29:40 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qajnk-00AJGR-17
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 21:29:37 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 76EEC240027
	for <linux-nvme@lists.infradead.org>; Mon, 28 Aug 2023 23:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1693258170; bh=oX19WLmDzJGw2VdFB3Bf4BwXWfJaVgu5ZIFFVXxUlTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=SlQ4B4fgSny27gPHDTID9Nroxoh9u6MBBBkyw6V33LpcBjNc3xinIYbfuwrfhj6Ff
	 mdcbRtKsfIe7Nk+AzvKtZsbYZhk5Nen5RSenDwxDXvbec5uZ/uAoAojeQt+35Xb2LQ
	 9cRHiCN4J1nt9i5Lj/dE7hqAB+rFJzqiJBi8h9QsRZC4E8YWxJouW3RDAEItwZyLCK
	 CcXzDnFVnukwHPtMfRhfYvj18AgQcthte+raKcV2Ul6X+6bi55qC0cjrrVBB+YEKRf
	 3OxGB0UCjYLAl/eRw6Jsf063HnoEOq9XELldi58eNbAqyNJhurPF/Mb+EqcGl0EuQN
	 62BBR/YFjzsDg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4RZNx46vF6z9s4m;
	Mon, 28 Aug 2023 23:29:28 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 2/2] nvme-tcp: always set valid seq_num in dhchap reply
Date: Mon, 28 Aug 2023 21:20:33 +0000
Message-Id: <20230828212033.3244512-2-shiftee@posteo.net>
In-Reply-To: <20230828212033.3244512-1-shiftee@posteo.net>
References: <20230828212033.3244512-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_142936_545825_D91991F6 
X-CRM114-Status: UNSURE (   9.66  )
X-CRM114-Notice: Please train this message.
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

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/host/auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 49f8c46bddf1..bf32a43fe5df 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -314,15 +314,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	if (ctrl->ctrl_key) {
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


