Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3080606A33E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fjNnsfGR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eN6LWnipXuoEexdXCVhAwlc1F+53Q7OMUS9FkrpAFjA=; b=fjNnsfGROLYdvKypEi5DfCX4ag
	J1jtMgb4Dn9JgjoV9rHH8nQu31mAl9jDqZTap25NTT/FP3nXFA10ueOAMxCRq38uyKGTqyQ586TZj
	D2iuhAMroJMWAWOwO5SGz0f59UCcSnzN12o2cpLyD2viuUwJvyuPN0jo9Ei+oNySZRq6p5VJWTDD3
	LB6/piVCRnefuon4J3mc/jQzFR3A/XPpNVoMnEuX34toqqL1LVWyHEbgqFlPRLr9DVP3ZldFmxCdm
	07/sExkD0Gyq2QqfjLjBXafXOhis+CMPt+s6pTAiIaRZGa83PNdx0Psw8xCf5wL/oPiBw4wFMlq2+
	MOCPKkIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLQe-0000000ClaG-3D0q;
	Fri, 06 Nov 2026 15:00:32 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLQb-0000000ClZ5-3ByX
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 15:00:31 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jLj5k6Pkgz52Rpb;
	Fri, 06 Nov 2026 23:00:10 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A6F0Anw036321;
	Fri, 6 Nov 2026 23:00:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:00:13 +0800 (CST)
X-Zmail-TransId: 2afa6aedeb7dd90-76d47
X-Mailer: Zmail v1.0
Message-ID: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
Date: Fri, 6 Nov 2026 23:00:13 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvMl0gbnZtZXQ6IGZpeCBzdGFsZSBsb2cgcGFnZSBkYXRhIGFuZCBhIFpOUyBJZGVudGlmeSBlcnJvcg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A6F0Anw036321
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 06 Nov 2026 23:00:10 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDEB7A.002/4jLj5k6Pkgz52Rpb
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_070029_964655_8869986F 
X-CRM114-Status: UNSURE (   8.29  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -4.2 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is v2 of the two-patch series.  Patch 1 now follows Christoph's
suggestion to zero the whole transfer buffer instead of only the unused
tail, and both commit messages are shorter.

Patch 1 zeroes the entire Get Log Page transfer buffer before filling
it, so a host that requests more bytes than the fixed structure no
longer receives stale kernel memory.  The Error log also clamps its
ring walk to the requested length instead of relying on a zeroed tail.
Patch 2 returns the namespace lookup error for a ZNS Identify on a
missing namespace instead of overwriting it with a successful copy.

The two patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Changes in v2:
 - 1/2: zero the whole transfer length first instead of only the unused
   tail, as suggested by Christoph.
 - 1/2: shorten the commit message.
 - 2/2: shorten the commit message; no code change.

Link: https://lore.kernel.org/all/20261105215753914RuQA4AVkFtXzpBkieEscY@zte.com.cn/

Testing: the uninitialized tail was made visible with page_poison=1
(CONFIG_PAGE_POISONING).  On the unpatched kernel a 4096-byte Supported
Log Pages request returned 0xaa in bytes 1024..4095 (10/10); with patch 1
the tail is zero (0/10).  The other log-page changes and the error-log
ring clamp are not runtime-tested.  Patch 2 is unchanged from v1, where
Identify CNS 05h/CSI 02h for a missing NSID returned Invalid Namespace
after the fix.

Shao Mingyin (2):
  nvmet: zero the entire Get Log Page transfer buffer
  nvmet: zns: return the namespace lookup error for Identify

 drivers/nvme/target/admin-cmd.c | 51 ++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/pr.c        |  6 +++++
 drivers/nvme/target/zns.c       |  3 +--
 3 files changed, 47 insertions(+), 13 deletions(-)

---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

