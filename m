Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB900EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 07:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VeH+hGutQQmkuSAsRj95cvB4ezBjrV0jhE6p40YOdgY=; b=Ihl2eY4JUy5g2t7LEUHCkKQl5K
	hfALT/itNzin+vn9XZGjd9wyrDmwoiPEhsGTgA9r8GJkACDKYw5j8uFfNRnXnLjgEy6JqAz9tfVIm
	tnsjWLU5YaZBfoHGwgd759lC65KO52Y29Go9FgxMHjLvwZI1jGPiMgQ4eiMwkLCZi9F9wUx8mbptS
	bjE0V/nNUCJsTla9jP0o2skNomMiF+7+g5HhLSRKhcIBBPgiAPVurnYCnUc2A67rgg/wLyTyqYqlK
	wlH/ASmXQKQObasXkdTKDfRmrE2D40OIBROJJk8KUhtdQpIb5ZMSl+CqJAGu3zf4klZ+tX7SoYGQy
	oxgeAWwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Kxf-00AfzK-1H;
	Wed, 14 Jun 2023 07:30:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Jtf-00APgo-2A
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 06:22:25 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 786951FDE2;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686723740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VeH+hGutQQmkuSAsRj95cvB4ezBjrV0jhE6p40YOdgY=;
	b=EdzlDfGZb0DMOBwVMnSGmBAp72mhRRnCK9bKg/zDC39qPcqpF9wBlNorRHK9bMPCCh+9FL
	Ot7Ed0h7nGOaQmVHZEHjgmZXzLLMxQGIY8/HDbZz3ElFT/+q5BmNGnEzg9YAP22Bs7y9FT
	KldfeXRL1Ek9y40x6Zm9iEdVSKk+l4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686723740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VeH+hGutQQmkuSAsRj95cvB4ezBjrV0jhE6p40YOdgY=;
	b=VCobKp1PeBQkVjWYQKmSKO+jLgRSvoYi29V1kBqIEA0ZvC7yW68LrGp2wDGnAhtcdsJ/rr
	vZBR6GOZUGYGpLDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 5D8752C142;
	Wed, 14 Jun 2023 06:22:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 45EC651C4DD7; Wed, 14 Jun 2023 08:22:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/4] net/tls: fixes for NVMe-over-TLS
Date: Wed, 14 Jun 2023 08:22:08 +0200
Message-Id: <20230614062212.73288-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_232223_878539_79892496 
X-CRM114-Status: GOOD (  11.99  )
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

Hi all,

here are some small fixes to get NVMe-over-TLS up and running.
The first thre are just minor modifications to have MSG_EOR handled
for TLS (and adding a test for it), but the last implements the
->read_sock() callback for tls_sw and I guess could do with some
reviews.
It does work with my NVMe-TLS test harness, but what do I know :-)

As usual, comments and reviews are welcome.

Changes to the original submission:
- Add a testcase for MSG_EOR handling

Changes to v2:
- Bail out on conflicting message flags
- Rework flag handling

Changes to v3:
- Return -EINVAL on conflicting flags
- Rebase on top of net-next

Hannes Reinecke (4):
  net/tls: handle MSG_EOR for tls_sw TX flow
  net/tls: handle MSG_EOR for tls_device TX flow
  selftests/net/tls: add test for MSG_EOR
  net/tls: implement ->read_sock()

 net/tls/tls.h                     |  2 +
 net/tls/tls_device.c              | 25 ++++++++--
 net/tls/tls_main.c                |  2 +
 net/tls/tls_sw.c                  | 78 ++++++++++++++++++++++++++++++-
 tools/testing/selftests/net/tls.c | 11 +++++
 5 files changed, 111 insertions(+), 7 deletions(-)

-- 
2.35.3


