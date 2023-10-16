Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED18CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 08:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dZUE3Z5gEAdTYpsICV+v1ype6V/m6s1n6fA5c3g9VNo=; b=28FAOuxavJXn9N7HltXCzfm0zY
	zXo2p3LOelMcbcm2x8sIAp6FkUwGsZhHpbjomLEUzwzLPP5+nzZortUQrseIqgRULRtKDRK/l6Ya4
	HgiQGy7FoFUoG/R4/S+Jhq3Is4OVPrVxV7N+zQQQe2FoOsX561o6SDaSP+MYAEZtEi83GEzuGv9gW
	91bhYzus8PLhieB3Squm8zypHyDodKqZhwDu6n2EVkuNoneyy2EPGe3m4ZTGxRKDtIBHoz5uuMYoV
	AATrooCEltvlJ6bX2Q5XVWAxrtJQJLeDaWIHhULd5w8K+SpBEqhXu8/weLAWgLyc6BuceL596t9TH
	VuioXGYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPk-008uPR-05;
	Mon, 16 Oct 2023 08:57:28 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJPh-008uOo-29
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 08:57:27 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0B49424002A
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 10:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697446643; bh=VvG7lAdIJ52HfYW9RRUqb2VWt1HKenPkukM7Qd9aHuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=NWQPHzLRMTR8Pk9DeYLyi5vyXdcN3/zuTOUOsGu0LORvfL3DwNV/KR/7y3ixlG2TV
	 exAbr7yqfQGmG0Chov20evhIvg3PLXiKIlbDW5aS1/eYCX8Ji6kfYoQkjkBYD+wE7k
	 F4xZG+Bu58iWow4t+N3FkrL1226F0uOy09kmrzhdnvVMEpqdwp0QUE0zGwB4UtIao1
	 8cUlkBUR2AM70ppAjjZApdpBU71C3BdCDweV3/eZYBlijH04Y3FjoNdIHhejXfoyhG
	 2ZOZucDHE+uAFNV1ajbCRMw3uKJU09qEtEhXxtA7ve6gXGsEtfMxbpHthje+zx291u
	 mUpKtCPMTnhpw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S89wc6Cx8z9rxR;
	Mon, 16 Oct 2023 10:57:20 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 0/2] Remove secret-size restrictions for hashes
Date: Mon, 16 Oct 2023 08:57:13 +0000
Message-Id: <20231016085715.3068974-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_015725_841806_DEDB2053 
X-CRM114-Status: UNSURE (   7.44  )
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

This relates to the hash functions used to transform the secret.
The kernel currently restricts us to using secrets equal in size
to the transformation hash function they use.
e.g. 32 byte secrets with the SHA-256(32 byte) hash function.

This restriction is not required by the spec and means
incompatibility with more permissive implementations.

With these patches the example secret from the spec should now
be permitted with any of the following:
DHHC-1:00:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:01:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:02:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:
DHHC-1:03:ia6zGodOr4SEG0Zzaw398rpY0wqipUWj4jWjUh4HWUz6aQ2n:

Note: Secrets are still restricted to 32,48 or 64 bits.


Mark O'Donovan (2):
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 14 +++++---------
 drivers/nvme/host/auth.c   |  4 ++--
 drivers/nvme/target/auth.c |  4 ++--
 include/linux/nvme-auth.h  |  3 ++-
 4 files changed, 11 insertions(+), 14 deletions(-)

-- 
2.39.2


