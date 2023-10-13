Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1F8CDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6cVklUBJ2GX15heOtwqXFzln+u/hJujOwwMqeS1EpW0=; b=fTGqZ0xvWbyl5YqBAwpcDv+AoQ
	NQZCRYr2gHrz3yamcGabe/lnO4LHYAIG2wc/1b7U4NXZGQOUMmD8HprDKdzR518de/hL7nB5qtOjH
	6f4sD/hQw19nPr2ufRBO6UBLNOz2I3UxCRoc4LTE5t6WdbK623pIrlzT9Zu6xYUgQL+ySi/yAn9vi
	b5G+nzYAil4Cc8n35j4ovMbz7zGYZIg9ap0vW88AIN+fYaJkiL6y5kvqb9fN7Z/zlGZK7OLFHjtFs
	zTWsmTvzxQqjPk/iGm/kHXccgZNawqW6ogRFYwUNeX4O7/FFsS+roHbNgteOC+ujP0EP9vJheDWNw
	ekR64oDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmT-004Dxg-0X;
	Fri, 13 Oct 2023 20:29:09 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrOmP-004DwK-2H
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 20:29:08 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 72408240103
	for <linux-nvme@lists.infradead.org>; Fri, 13 Oct 2023 22:28:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697228940; bh=FLYT+SprL3ZRgczhwxNKHQ8OrNt4PO3mwxSQn6FYQbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=Q7Pe40hp5FNGfHARAXmJsGr3hwu8JJ3M/AsIzihxJAXARRekFKF+L6wBBvkz2Ys59
	 Hv55F9ep4IEhP4bnwc2RpJ4On8J0Y2O3jMgXTssyfRsJXI1fYXcPMHdHkMKjqg6hhe
	 i7vNUu/V0U8PnNhusGORAyHH+VAmEqHsyXvhGr072uVJ8LwH7EeeOS6tYdNwoTjs+I
	 wImE3ULHxOolecYCRAeR4l1lj1EecLdDPNy9GMPDoTZG14R4453A1raSkRUiPw8ysx
	 C18duc/Y10AK/LsYR36fOJRWtcqSfPQuZL7RKMgrpizuVlZ8LBGCImX99is0MC7RJv
	 JRXo9FME9b5nw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S6dPz2MPJz9rxF;
	Fri, 13 Oct 2023 22:28:55 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 0/2] Remove secret-size restrictions for hashes
Date: Fri, 13 Oct 2023 20:28:25 +0000
Message-Id: <20231013202827.2262708-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_132905_911676_0F936F6E 
X-CRM114-Status: UNSURE (   6.72  )
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

 drivers/nvme/common/auth.c |  8 --------
 drivers/nvme/host/auth.c   | 11 ++++++++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.39.2


