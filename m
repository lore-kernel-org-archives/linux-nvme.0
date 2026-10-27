Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204560A5BC5
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1zPaDb0O;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KwZ5IHJL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=8L6AijwD1kXrBelg4PmoHNd6X0P3sJl4dvEdB5ZF1LM=; b=1zPaDb0O0QiybV3gUET5GG7qwH
	5NWBVMx2EKNaBKc6ueGgsVb2snG+EJXOISgjcz6SrhvPJ0autzzGh6NTuLM/G3jXLHFSB31SWcx1V
	CLswk8wxfzZuy2XH7rl4CRnazGpRw55ufjHLiJKrmALXrLa7DHhhu/SLO+W4b6VS8mGURLtmg8jK8
	bvLww79EDcAX179mBrE57xAAYGcVGw51CaYtiKuQsBBIH9Ih7DsG9TVr0CCQnUpyUCQL1FHh2ny1C
	e+T0DK43tUWO/wq4Mv+wzVrw3H9kOGPWWjUduvt5ARYMpEDAiq2OP3Te6JztdZ3WYkMgoLgQrUYs8
	Xmvt0Frw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg3h-00000004ael-1O8o;
	Tue, 27 Oct 2026 12:13:41 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg3c-00000004aXD-30kT
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 12:13:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793103212; bh=8L6AijwD1kXrBelg4PmoHNd6X0P3sJl4dvEdB5ZF1LM=;
	h=From:To:Cc:Subject:Date;
	b=KwZ5IHJLPfcttnI0o55svwYVJkZIHsd8LQAMGAqvn+0Xa3wUr69EcSGi0T2g+6v1y
	 ytCfjSjC5yHN5mpun1t5d/2m07y1xgrm7MchjCE1rNi006RKq7XdBDUKbLRAMJE/93
	 YHF09h4/Vv/fVXFFeeEeaWHIzoK5NK73AgP7HsMs=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 35D23E21; Tue, 27 Oct 2026 20:13:29 +0800
X-QQ-mid: xmsmtpt1793103209tx283cz3o
Message-ID: <tencent_3DEBF2FC84E9BFE7733228DEEAC31383A805@qq.com>
X-QQ-XMAILINFO: MrK54zaStYC/ZjACrlrxL+/8DoggdIeedUooH/w6x8b7wD1xUgjgjhMIYNjG/M
	 pglJ2ltlBo+EkjilQ6obgNFWlNgeg7C7pok22LXAFoP7cj/WLYSIVOBBiWO1ZWcZqBL0LrRRZ9+X
	 mF0aPE1bcO0st2cC2UvACncHpR0KP6iKD/uy4fo5aR8WmOBF5PBf7wai7f96IypdVNb3lkfNt4HG
	 VEXqQ4r1Zx5wbUsEG/zIvegnjyxmerGyI1WzwcE0KfD35eZfw0AP2ggn29dDwMtsd6eMgBdPWvoy
	 8hbw8kANaLAvS64pNe0NXOkuBlqDMYy3+9wErpssPlb0ppeTJ56be829H2csadyqe698dz5yhwEN
	 z/wlN1urs1LiEfPfx+fxe3lm+LRPJg4ridDLvzoYOiNAvs9UmrZz9iCkwow0xPzyDecI4FRpgY0M
	 /k7RSpEfSg05FhuhR6x5gS0KRN7aPPX5LRArIO1te9ajSaSnEqguq7zf059nQoQb/ksSzg+qp2Mh
	 cv5RGElDFICdO3S/cqdPUQgnCgM1kvxzK220c1zkTzWfxLRFP2N3eAlCdOFrspCRJAldXKnO9djH
	 9e2UerkHHdTIvmTl7j1H3R7E2YSGzwdysSItr6/et/gvSl/+F33l5g6oxY+xKsjoSVbem9Akv2Oi
	 MJyr+cTFGZ+JtmePtnMPAthRJWWcJHnFHn11BJZHq7oTpTItNibr3DHboxilzpf2CHjPew+cpJiE
	 bjix+CvmQB9hKqEQ4amHV5bazZ7rcMkHDpNOdGQaiH61zU0KB8E819LO7ANA1kT33VxRg/17P5m5
	 V8lFwj+umzx1QtEwevdRjwHKDzrBxwaK8+UtmcLASu5IDo4zexpbGl5onX/bHJb967vvlzADIadF
	 cby4JBnbS8olgZgxNic/r4sabIH6K4Yp1laqvOEigWfjcE/OHly7VibgUnQTdHL/86n4O2TvXBGv
	 fWvFhkKjxLG1ms3ohzXhYzxqtSz1Capnt1zS1Il0HExdDvbtU2paWrQBsa7uZRAsu/+DLERbGmP3
	 qbk+cIxvyXJ+u3lq6FjzAMPyEPeMOPxKbu9ZfH4z8ijnS6Si+fQiCOrlU37VIvXUh54CCfMAGn1p
	 LfgVwlgbwtNI6VCl9P+Ax6zd60lg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] nvme-tcp: validate TLS handshake timeout parameters
Date: Tue, 27 Oct 2026 20:13:27 +0800
X-OQ-MSGID: <cover.1793103202.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_051337_168881_A8ED8E73 
X-CRM114-Status: UNSURE (   9.86  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NVMe/TCP host and target expose writable tls_handshake_timeout
parameters as signed integers. Both paths multiply the value by
MSEC_PER_SEC and HZ before converting the results to unsigned timeout
types. Large positive and negative values can therefore give the
handshake agent and the kernel different, unintended timeouts.

On an HZ=1000 kernel, setting the parameter to 2147484 overflows both
multiplications. On the target, an accepted pending request can queue the
timeout work on the next timer-wheel advance while the handshake agent
was given about 24.9 days. On the host, schedule_timeout() can report a
wrong timeout value with a stack dump and fail the handshake immediately.

Make each parameter unsigned and reject values that do not fit both the
handshake agent's millisecond field and a safe jiffies delay. Read the
parameter once per handshake so the two timeout mechanisms use the same
value. Also keep the host completion-wait result in a long: a successful
wait can return more than INT_MAX remaining jiffies for an accepted
timeout.

The exact series was built as a complete x86-64 kernel. Both changed
objects also built with W=1 for x86-64 and i386, and the i386 objects had
no 64-bit division helper dependency.

On an x86-64 HZ=1000 KASAN/UBSAN QEMU guest, both parameters rejected -1
and 4294968 without changing the current value, accepted 0, 4294967 and
the former overflow trigger, and exercised the target listener and host
/dev/nvme-fabrics paths without a kernel diagnostic. The expected
handshake failure was -ESRCH because tlshd was deliberately not running.

A focused in-kernel completion test used an already completed completion
and a 2147484-second timeout. The wait returned 2147484000 remaining
jiffies, greater than INT_MAX, and the v2 result mapping returned success.

Changes since v1:
- keep the host completion-wait result in a long;
- document the accepted range of both kernel parameters;
- add focused validation of the large positive completion result.

v1: https://lists.infradead.org/pipermail/linux-nvme/2026-October/066911.html

Yingjie Wang (2):
  nvmet-tcp: validate the TLS handshake timeout
  nvme-tcp: validate the TLS handshake timeout

 .../admin-guide/kernel-parameters.txt         | 10 ++++++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 drivers/nvme/target/tcp.c                     | 26 +++++++++++---
 3 files changed, 58 insertions(+), 12 deletions(-)


base-commit: aaedcff9014876387504a8b92d227766cb95015c
-- 
2.43.0


