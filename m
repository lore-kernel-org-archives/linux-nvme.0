Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E30C4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6qJFbH1ce0svJGhI+F+YdfAD7zuT3blJAtU4TfY3srU=; b=mGZL/GnOgI//sJgLtYEUap+9i3
	Q51L277fAquiPLCx9RSL4FXBCRihsFi1/IIvjoeWAcxzP6fD2tYMUTAnmY3JhzBNUyHJdhNZuv+bO
	NhCy9Xe2jD0CQapwvsOUh8fB48qvJILrgGYTVETUp8w2zVXT6L6oQpysHS+y55NLJGql0nnlCgVmo
	luO4z/0p6EiOsJnXNoB2PRQVf0p27rqBSz+SR2gkNPjclcXREaOSWh2uQNTnHUlX/F5OoExNa0Ini
	0ca0U4qJf3ex3x8H5SE8jNvq33Y5ibPUylYtJgfBITMFBVc5CpgxtBr1XzEQ2pAENV0rNewMJMVMu
	TT+Z/4GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSR-0000000Btrn-3ngH;
	Wed, 07 Feb 2024 21:27:51 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSO-0000000BtpT-3Cdp
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6qJFbH1ce0svJGhI+F+YdfAD7zuT3blJAtU4TfY3srU=; b=MyDFkKX8+vuv3aP66RPk0QKWib
	Dy2YLgArwJj/LdmZIj9Bb0UsoEc0Yjr97euUBAiLaW6RfJ6EkxDJ/pv+CG2VT/kApxOBfID346kUw
	5/TpENp/bJ2bYXFrgsjzn13YdzKgatfJj4MbnAztAy847csptYmFj3EHP2iINnVDyp8ObqJkIyMdl
	Dhq5UA6SgDQlEo/Xay93D4CZ+bQwS34b318C2Z5FRGhZicA9rRnnbcakCG5JqxKrMlhzbzFHwMZDB
	N9RiMDxpuAeMTKQoDqfM8GN2G/1fZXESZm1sSA/pScINrgGmIPA3vCkcqwct7yCwIPRVHU1BnAXe5
	w9n6zavA==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpSL-0000000D8N0-1DSJ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:27:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8B2EFCE1B1D;
	Wed,  7 Feb 2024 21:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA575C433C7;
	Wed,  7 Feb 2024 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341259;
	bh=vxyIEZwKCT6rz43a/AYtVYVP8Bndf5FuZkBUysk32bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB2ngZyRCWiNLUBaucNS5J/bTKiBOKxOKXM+4Rvh2yBpaHABNq/xRHCxYT7sUiAs+
	 6OuoBJcIsJbDzuhTK3mC6aPLk7UxcjkZGdGKyUFd6TZUOeiVHoxzgFJMaVvEvG+gTF
	 kv73ghESdGX5rNhQZaCA7Px/BjJb84bVQA4jD1zsfE1TyA34QiNyIvBGuF7IhP0zyj
	 L9E0SxuJc2yAHzhqNsFaraa51Ep40D2F86jgR8d1tH5QI8/Emrg8v6hMlVnTEQKfmV
	 76QGMAz1hDKd2nAz9t5xQiB3JDT1ZC31FqWJ6JCCaPp8aASfxVqjL130ALObkyZrZN
	 ULOsyyfPoJ36Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 4/7] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:27:28 -0500
Message-ID: <20240207212732.4627-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212745_899640_1D639EA0 
X-CRM114-Status: UNSURE (   9.58  )
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 47c5dd66c1840524572dcdd956f4af2bdb6fbdff ]

The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
exit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index be9e97657557..d40bd57537ba 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1817,6 +1817,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


