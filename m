Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E5DCDB484
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Rw5yrnw5vfwiQI7TlmbzXdImcMob6nX5Hn71Zy5uSAQ=; b=tAJRSfba79Gnox9WvDJurt0Pj7
	pOJp37cJcVEkfwkI6ROtc1tmcuk7x3X5ywXaaddY6eNJW+yWllWrEO5oqQMXQMs/0dwH9HNCvG929
	ev3MghTVEV6OnPfdu/rE8Rw4NWr8Pqtvf4D+1Jy+9cOkrSPPo2E9d/S6ZeythV+Dne9zYtgu0N1kf
	FIebc66GSHjRZo2ZuYCZ6lxkEqDSmyFa81NoyMmTTUCxwSYOSS3r7qdwzxHQf8x/5sWtNhszv1j8G
	+bnI3XWEPF6CeyWCL9E7Q3b4bBY/trTkfL2tpeCrdmfVvoNMQBvEubtWKj+cwGcG8kyQnqcByVyMo
	n2IAXoPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsnZd-00Cssk-1X;
	Tue, 17 Oct 2023 17:09:41 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsnZb-00Csqw-0Y
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 17:09:40 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 4EBD0240027
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 19:09:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697562576; bh=rlnHe0oU2ussQlwYxHpMoHyDbTunIDkyFCYAe1fYEf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=amnelQWDhpzqm4QS6Cc0ixV2zH5qDtADR7lfBvwPcUUtHfohhw0OIXJ35dk9WtMlm
	 NqIUI/cz7tnrTTAn/U7lnhKgCeTN08vVc+6KMkY+BLYWaUcV74ZuaZvV5RBESxV7a1
	 mJ5K93oJc1pSaMVGToHuq0iKeFFiauJ+LGwiKbiFOkX101kmOrCZnsW62eAGnFo/ra
	 TCNrMSVrYwbtpjYTUoovLFzgVtC/6ps1w+bV7vPcKk9iR+YOyI3z2CnkxXnG2itMDt
	 9QWCFerkmN843m8F9rwu016tCK4rPU+mbxbxAXOSy1F5S3dctkcVDrIHUwhOQ7fBvR
	 CmMM10vD5djig==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S90p52DsNz9rxS;
	Tue, 17 Oct 2023 19:09:33 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v5 0/3] Remove secret-size restrictions for hashes
Date: Tue, 17 Oct 2023 17:09:16 +0000
Message-Id: <20231017170919.30358-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_100939_357137_0E43302B 
X-CRM114-Status: UNSURE (   8.27  )
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

v5:
- Removed newly redundant check found by kernel test robot

Mark O'Donovan (3):
  nvme-auth: alloc nvme_dhchap_key as single buffer
  nvme-auth: use transformed key size to create resp
  nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/auth.c | 68 ++++++++++++++++++++++----------------
 drivers/nvme/host/auth.c   | 30 ++++++++---------
 drivers/nvme/target/auth.c | 31 +++++++++--------
 include/linux/nvme-auth.h  |  7 ++--
 4 files changed, 76 insertions(+), 60 deletions(-)

-- 
2.39.2


