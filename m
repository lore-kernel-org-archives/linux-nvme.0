Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85B606A33A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ow+TunC/;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=fjY6u7l3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=eV5gvD8g6rP63zZKtoi/003rCWCBtrbvCHoBYlTmejE=; b=ow+TunC/GcFnp6SpHJB+NPyuGX
	/I2ZWKFoKjdAjPQuttCQXk8OuKCBb+0LnidO1pEkXGPNh1918vxGfrrDpwGyslBCZNtwoEOvznQLV
	Uc97foGjOKtKSSP+TkDbBZWqHSwNduCQarzx3c+QQDikiS83Tnyck71MNcFXU2neW6EPQ3Xs4e1Qk
	JUFNSYB8n3UhFQZu1qQ9671zKcluzGD0kOLl+hn0H16IueQMRRl5I0I/aXWmiQyeZTJL7ZQc+Tpjo
	PwBlHa/L2ZzepQef+kMh3MSJ3lIgxasIWG/nEBLDwl52zK+JpU77aoYmhhRpOB9NFAh6i5OeAIWPO
	iSnoNHCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXo-0000000GWzH-3vKm;
	Sat, 14 Nov 2026 17:28:04 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSHXm-0000000GWxu-12ix
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 17:28:04 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRh0V0fS7z5BNRx;
	Sun, 15 Nov 2026 01:27:54 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794677274;
	bh=3egreJUevVK+tZ7LxFQa1g7uHV/m0ZzjKpKiKJVETok=;
	h=Date:From:To:Cc:Subject;
	b=fjY6u7l3VyaRkw2WjylKDLfTvi5evyTig9RZ08g5XXBKVqhHYVGkpWyGpHVxmvJiX
	 WQ9HJZGZB7NS3qZGV478zaRJiTGpfMaF1vc7E0UUFRHgtfZembXZBe9Q2ME3WxsQQx
	 SGWSR+U/buDmwwb8ZU9MUa/ic0PLxQet8QzWtt31YEgJRvVYMLr8r72/LbcWXx4Fep
	 mx3bjj0mAaf/6UrMkPMeAIAYaCWAu7ROWvLmGrKv4A+vciVbKhJZNiNi6cH8Cvh+PM
	 j3DYE8En5DYbKFTYthtRk7CK41nqS6BPotbQhXLIq8tJt6EulG+S+VOk7EeEmDydod
	 WqMAjdSpvcI2g==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6AEHRmi0016753;
	Sun, 15 Nov 2026 01:27:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 01:27:51 +0800 (CST)
X-Zmail-TransId: 2af96af89a17ee7-57e90
X-Mailer: Zmail v1.0
Message-ID: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
Date: Sun, 15 Nov 2026 01:27:51 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gbnZtZTogdmFsaWRhdGUgYW5kIGRlY29kZSBjb250cm9sbGVyIHN1cHBsaWVkIHZhbHVlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6AEHRmi0016753
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 01:27:54 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF89A1A.000/4jRh0V0fS7z5BNRx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_092802_662701_326D37AC 
X-CRM114-Status: GOOD (  12.22  )
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

This series adds missing validation and endian decoding for values that
come from a controller, a backing controller or a user request.

Patch 1 rejects an invalid ZASL from the controller.  nvme_set_max_append()
shifts 1 by zasl + 3; a value of 29 or more shifts a 32-bit value by 32 or
more, and the old code also used a signed int for the shift.

Patch 2 maps the user data buffer whenever the ioctl length is non-zero,
not only when the user address is non-zero.  With addr 0 and a non-zero
length the command was submitted without a data buffer, and the target
rejected it with an invalid SGL status instead of the host rejecting the
user buffer.

Patch 3 rejects an Identify Namespace from a passthrough backing
controller whose nlbaf does not fit the 64-entry LBA format table.  The
old loop cleared fields past the table and returned an inconsistent
Identify structure.

Patch 4 decodes the FDP Get Features result as the little-endian dword
the controller returns, instead of passing a four-byte structure to the
u32 result pointer and reading it in host byte order.

Patch 5 bounds the reservation report retry loop.  A target that keeps
changing the registrant count made the ioctl loop forever, allocating a
full status buffer on every iteration.

The five patches are independent and can be applied in any order.  All
carry Fixes: and Cc: stable.

Testing: all apply to next-20261105, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and zns.c, ioctl.c, passthru.c, core.c
and pr.c build with the corresponding options under W=1.  Each patch's
--- notes describe its QEMU/TCG A/B test with a test-only target hook;
no hardware was used.

Shao Mingyin (5):
  nvme: zns: reject an out-of-range zone append size limit
  nvme: map passthrough data when the length is nonzero
  nvmet: validate the LBA format count of a passthrough namespace
  nvme: decode the FDP Get Features result as a dword
  nvme: bound the reservation report retry loop

 drivers/nvme/host/core.c       |  6 +++---
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/pr.c         |  4 +++-
 drivers/nvme/host/zns.c        | 11 ++++++++---
 drivers/nvme/target/passthru.c |  5 +++++
 5 files changed, 20 insertions(+), 8 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b

