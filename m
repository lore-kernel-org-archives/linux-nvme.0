Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF8ECDB483
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oHPRNRXaBXnP0hKN6x717ORPsdbjv/XJtSjT888Zphg=; b=FUYyO3zdHoE7iS0Hqq1DiaE1MU
	9XhjMAU2E+/uuyuWRssyoZAap+tzKHNbt0DZFYD99zbdswvlEz4q+Au/v+GKO6Pu7qzIvIB09l7bj
	7KVyiSHiLytyNiAeaQYq/g1MHGnFFVF2/EJ9Ejra1AmUtpeQUgb3zIoDolksWSJQwCvhZYzBqtIMM
	14zRTAw2xi1tpya9YpcBLZn958cYDfMAppmm+Eb52i54gZqf2qHDnGCdh4Pnary24KyC6TIbArflq
	O97LtkxCE+PtAxj0vtiyb+UmEy5pjQz//5vV/1GU14yMYMYOvNE7FUmZA+EP0e1K/NTXd2Yx86yW0
	euIapX/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qshhM-00C89U-1A;
	Tue, 17 Oct 2023 10:53:16 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qshhJ-00C87k-0z
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 10:53:14 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 956AD24002A
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 12:53:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697539987; bh=MLzZUl/+BHQHydxEN9HgZzS0VH6NylU05183B2OuUXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=eV44l1Vxi5z6Z7TNlLCHy0v74F8mtYkWDKBQm0hXL8vbaH6kQHGsB2ILpTU4GHIRu
	 OsAAHLuzKAnJcW/YsjnuxmwLrJqBeZn0HruXVTKYXrNq4S15Mpza6bxkH+sSIANjmW
	 PeKpDCWemL53SUCWZQWmZpwDF2kDy+/uo9IQ3tJheqdR1nuDWfCpVtz7SK7a74U+/U
	 YGyL5NURq8y3xxzRqjgGBqtY4dbni/vLzF+7+nqlFu1S0fA6tJoY1OL8BA7w3Stp1K
	 SUfW2vQwBBhwbXyUd5YcEpu1Sv+Il0OqNUEP9YP2hwK+GpuMqWOai5iJ7kbBHnVzhk
	 dCPjJKfiq9bMA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S8rRh5V1hz6tv5;
	Tue, 17 Oct 2023 12:53:04 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v4 0/3] Remove secret-size restrictions for hashes
Date: Tue, 17 Oct 2023 10:52:48 +0000
Message-Id: <20231017105251.3274652-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_035313_485931_0F015C9C 
X-CRM114-Status: UNSURE (   7.97  )
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

v1:
- Initial submission

v2:
- Added transformed_len as member of struct nvme_dhchap_key

v3:
- Return a struct nvme_dhchap_key from nvme_auth_transform_key()

v4:
- added helper to caclulate key struct size using struct_size()
- Break up lines which were too long
- Replace ternary operator with if
- Add missing ERR_CAST()

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 66 ++++++++++++++++++++++----------------
 drivers/nvme/host/auth.c   | 30 ++++++++---------
 drivers/nvme/target/auth.c | 31 ++++++++++--------
 include/linux/nvme-auth.h  |  7 ++--
 4 files changed, 75 insertions(+), 59 deletions(-)

-- 
2.39.2


