Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCF606EE9B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=h2MTfwLi;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=mlp/MgZL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=/uGlgNaTZ39GNEO0DIFkGDDlYQv31NwdqtqlJEOxmcM=; b=h2MTfwLibj9B/K+I+iWvtqwbYo
	D//h/p3tc+xDZwbx+/g0jgkkyOUCpCx4hwRGHijw/Xb07BGKPOrsmYQWvTv6rLYF3hWjXEadcjs0+
	pdiCkSxOIpOftgBVgO1ivsU6IPbJ+/baahUdnEGxjzz343/QiMUYqki5E4d2tUDnN64AC5TbqOOd1
	4eOuIwquNCADuj39L7ul9BoDJ6lLnSqnY9l4Ceg32+iAz7sjH38tN9blbNyiIiJEwwyiRcHnOg2D5
	Q8SmxG7LzkdWy7OmJPzaykUr/FSTitE20BDn69jtSvMGFOFKZoiDASvxdUeNE92I0nWbo4qvdIFLZ
	PjGxGg8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQqQ-000000010SX-21Qm;
	Mon, 09 Nov 2026 14:59:38 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQQqN-000000010QC-0AXQ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 14:59:36 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jNXxR0phdz8Xrnt;
	Mon, 09 Nov 2026 22:59:23 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794236363;
	bh=TpIfpB47CwmdgGId7W2SupsJewo/qXQ10cq1sQ2P0/w=;
	h=Date:From:To:Cc:Subject;
	b=mlp/MgZLj/qKsvH/znv5+c7+5DM/vL4lrryDnmZRuIB1CP2pTyKnwCC4DnLgkWl8u
	 Gh7LoEX0owZ2ajvyDTvogqdttok2Dk8RGB2A7kN9mZUeOdL6rim0m/xhZ+JeEXOUN+
	 EOZb3vWCQqepXVbWm3IpTn9SkYN+3ZhexE8tuXlm1T/f8MZYuWq7LFOpxG6EE+7azQ
	 AvunWP5upJqO+ZBkR2hjWiLL3i4aOXZKyZj2yNCHvSyVHQTOzZvQEIyT66bLyssxF2
	 WtxiRt2w/l+EEH/rQMdslzlF1BaR6ondORd55anuHREG10z/JHk1lBqSftf9mkIiZI
	 48OBYWi8Q8tfA==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A9ExCXn067527;
	Mon, 9 Nov 2026 22:59:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 9 Nov 2026 22:59:14 +0800 (CST)
X-Zmail-TransId: 2af96af1dfc28e3-656bc
X-Mailer: Zmail v1.0
Message-ID: <20261109225914306SSjwaKCesNqNUj53kLV1R@zte.com.cn>
Date: Mon, 9 Nov 2026 22:59:14 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <hare@suse.de>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZTogdXNlIHRoZSBwYXJzZWQgb2Zmc2V0IGZvciBESC1DSEFQIHNlY3JldHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A9ExCXn067527
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 09 Nov 2026 22:59:23 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF1DFCB.000/4jNXxR0phdz8Xrnt
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_065935_400382_4382197C 
X-CRM114-Status: GOOD (  11.92  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Both the host and the target parse a DH-HMAC-CHAP secret with
sscanf("DHHC-1:%hhd:...") and then skip a hardcoded ten characters to
reach the key.  The prefix is only nine characters when the hash
identifier is one digit, so a short but accepted secret makes the key
pointer point past the end of the string and the follow-up strlen() read
past the allocation.

Patch 1 changes the host-side parser to record the offset of the key with
%n and use it instead of the constant.

Patch 2 makes the same change on the target side and stores the offset
with each configured secret, so nvmet_setup_auth() no longer adds the
constant to the stored string.

The two patches touch different trees (common/host and target) and are
independent.  Both carry Fixes: and Cc: stable.

Testing: both apply to next-20261105 (`ddfe51b0a0f5`), pass checkpatch.pl
--strict with 0 errors/0 warnings/0 checks, and the affected files build
under W=1.

Both were also reproduced on a KASAN kernel (7.3.0-next-20261030,
CONFIG_NVME_HOST_AUTH/TARGET_AUTH): a 9-byte "DHHC-1:1:" secret written
through the host sysfs attribute, and a target host entry configured with
the same key, both made nvme_auth_extract_key() read one byte past the
10-byte allocation (KASAN slab-out-of-bounds in strlen/strrchr). With the
two patches the same boots produce no KASAN report.

Shao Mingyin (2):
  nvme-auth: use the parsed offset for the DH-CHAP key
  nvmet-auth: store the DH-CHAP key offset instead of hardcoding it

 drivers/nvme/common/auth.c  |  6 ++++--
 drivers/nvme/target/auth.c  | 17 ++++++++++++-----
 drivers/nvme/target/nvmet.h |  2 ++
 3 files changed, 18 insertions(+), 7 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

