Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E20EC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DqR3+6slpixhWh4ZHGVcP6uKtjnqXJdu0TiKbRrlzt4=; b=3A+yr53qUURYMrAWX8xVgpodNt
	2CaVbbqIFHDTvtwRGZZdxkbYT7uaBBDYiwFtkX2vx8h4tJ27I3Fa9IRrCbiL0OvhpdU4VxRBma+WO
	CihV0EoOLwI5VXl50OoJyyfFjdCKuXHcKQ4nOKeGFhKMR2bbje6kHHsgnPgQ79xPuIgJVuaD3uQH9
	bn45GalIFsd79N3PWZ634Tz5hahNgo1msAVy9Br/NSLWzbgiuAPXMrGC00afamto28DldHQHrssGX
	dyQLqWbKYFWZjNyTqJnndL4Yhxx1vt6qC5m/OfNwpisgtPn5dmC1oyo5uE896RR498oUvSQ70P2mL
	M0mAnaJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmuo-000000017y1-3uFg;
	Wed, 21 Feb 2024 13:45:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmum-000000017vf-1MpS
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 13:45:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7FD8661508;
	Wed, 21 Feb 2024 13:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFCFC43330;
	Wed, 21 Feb 2024 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708523135;
	bh=aeFRmDbYQ8dPzg4bgbVbGPMHInRjxo98+1PIL2OZUWU=;
	h=From:To:Cc:Subject:Date:From;
	b=nvZcxjE3hZQCvOjEp5os68iv4ZylJs1IKjPkXKbLIVhUJJOb8rdiA3L1tMk6xwjQ+
	 fQ0gE8zp6fMq24xPDApUQwUP97ZYz3Wse4Vs59t/2lTFldxIYux1s5gBGYV/R8SCBB
	 0mafKjrnmV1h6u3OsRvmCg71XU7rmbErwNcu7CtCrwPVh6dn+TUaI0HK4AWSk7amGV
	 k8E4MenAyYGcsiN42tzMdBIFxCsLKnxR4im8Vi1ricUnZefqSW0kj4zy2hQ4+FoBcC
	 p2uA9LW7EscqxJDet7oH21O7NQKKf81Pxa0CkSMYj+8NsIrLRKHSBcHkDR9y0XltF1
	 ODAsAIe1Re+xw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-fabrics: typo in nvmf_parse_key()
Date: Wed, 21 Feb 2024 14:45:30 +0100
Message-Id: <20240221134530.142842-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_054536_437065_1005BFB0 
X-CRM114-Status: GOOD (  11.44  )
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

From: Hannes Reinecke <hare@suse.de>

Of course we should use the key if there is no error ...

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..ab5ac219b70a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -637,7 +637,7 @@ static struct key *nvmf_parse_key(int key_id)
 	}
 
 	key = key_lookup(key_id);
-	if (!IS_ERR(key))
+	if (IS_ERR(key))
 		pr_err("key id %08x not found\n", key_id);
 	else
 		pr_debug("Using key id %08x\n", key_id);
-- 
2.35.3


