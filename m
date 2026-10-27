Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349460A260E
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OUI76B7d;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Ed9vJqa5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=lxV7GHFbCpH33c+sUjwQ4RqgTOdSUkKKj20dfYYLSeQ=; b=OUI76B7dlcacnuXE7aLtqaFQQd
	2lC9DnNUfnLAlseKoL7kYDxnpNYQJb3qkn3Ih+AH7TZD8eLxAXGRa+7YKMqEw+elxl+HrTaOCKntX
	AlYtWwtpcCVUM827pPKIXYaA+F27iQ8wbgMpoCSpIfHrmfmhFVAhJvhJkWO4FCtnF/QTUOxNWjoGy
	ZpvbaHGd0O7VF/z/tzFZ1Md5W9sgga+Qp980SIAkPy2GGN19sFIq9IWFz4MVCR3SIHLDs3StW0D6Y
	oq29/irrGRjfpsBMWFErWnRyjieWC3MZTjOurhdEEbge3MYvswFUa81P68z/99BOFriCC+OYwLOvr
	rk7SNLuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb9-00000004B1q-1hIm;
	Tue, 27 Oct 2026 09:36:03 +0000
Received: from out203-205-221-235.mail.qq.com ([203.205.221.235])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb6-00000004AzL-4AmC
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 09:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793093755; bh=lxV7GHFbCpH33c+sUjwQ4RqgTOdSUkKKj20dfYYLSeQ=;
	h=From:To:Cc:Subject:Date;
	b=Ed9vJqa5zQnRxbX3kekbRhcbMFoWo4vMZyP/2pKVMuaVLN1w74aqJFysB3NcMDSZr
	 CZ/5Rn9htsKOkhKxKaDgh0tfA5O76NMmeTwyfiW0Ax7WantZYFbOdb1Ly/t7jXCITp
	 r56UPEqe5Rkn5/KLYc2ti4GhbjCizNEHLzOggOZg=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 8F4896E6; Tue, 27 Oct 2026 17:35:52 +0800
X-QQ-mid: xmsmtpt1793093752trufkse1y
Message-ID: <tencent_4FCBC113A5FF944F82A007AB2D4F06A2EF07@qq.com>
X-QQ-XMAILINFO: ODafEzNm5ExjYYe6KoXUxWHyIWa19hvUZ2cc+4pA+ZCfPqGBZtNIidvd7N1+qo
	 8Wk48bSNRy0Kj3ymxLhg8feigJiBunUBYH9xVBhFJE2TAHPiaKUp6Wgp1FC8MZW/l2ttur6LVJ3A
	 hlGw2CRLtUgaQMDLOixDlYLipBvAKj4kBBcK9mYPiroqYk4lsd80wrhXkmshcVP7B165u2bnlHhH
	 V7UoAcV/idtgD3Psb/QKZmjf7FkicC6CQBBYUYjgtOcBs+ZSgM29eR4ll+cJQJfENWLWwUHG1pE/
	 zw7m3m5z7C3M9uMTO1/vYgSJM3iUbeOnW8Jn39Z73T9hem9X6ukBNq3GqxyNRx9+kIvMBrqjBerX
	 T68DM11wXyup0JBMb48A6s7sgmdCSmJTdv/KKdcMMiSL0VgBeP54TBEqeftbTRXoc1ebMf+e4k5u
	 VrWWV5yDIqrxS8u2GjnGVAiC8Y4bBoB0bmZeoX0L254jFTMEr++DZzC59F/qtyna6CgiXIw9IBvL
	 T395I7woPbM84TXSzWQ3sjJXOusVmlVTAuwhWLPFIhZABbJQDUZOOTf9KH+epSqOUisszVbppyRX
	 q/c0lRdMJr1yW/yvShcLCTgXRvRZNC7sG0Y4NrMG+RyRWUpYo9algr4h30zvjQg/Lrrc9khdwH+k
	 yl2FzoyR9HZs6jycLl1UCVNeaAWLBZwD1Aux0+BpjARc3q0ipsPDk7888jE9R/NgkjVLHayRPUyF
	 r92Hgfcalv5rDGgiOR5/Hh4oRS+p3ofHgO1iYtw5I9d5A9bvTBTWpYb7Kekrb4axAbPtlYjilr2k
	 IOEMOjfpUje6lsAzoIvJoZquvSqeBbhLUQfTVoYZtX87QVMFgZGAnUJdXtWGwOJjBu0YLC6TpRdh
	 vI15umGcnDaB6AgjLeUh4yr7496FKQ6zh4TmGt7FS2PujqSoZik1WJ7vPsePhuovZ61YL4t+tCVX
	 EO6QxY1HQo4T5s/mR25oFx6kco9n1qKHMgDreuWFBbl7Cy0fjZOUZP05uessp/RdpgeEJM4S/bYr
	 pkYmshwqQ1ic1IrIIKfrpCOX0m6iDepDGiQNtihxjV9DXdOMc6owgu4VkzNHM=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] nvme-tcp: validate TLS handshake timeout parameters
Date: Tue, 27 Oct 2026 17:35:50 +0800
X-OQ-MSGID: <20261027093552.3934437-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_023601_344873_C82ABC72 
X-CRM114-Status: UNSURE (   9.02  )
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

The NVMe/TCP host and target each expose a writable
tls_handshake_timeout parameter. Both parameters are signed integers, and
both paths multiply their value by MSEC_PER_SEC and HZ before converting
the results to unsigned timeout types. Large positive and negative values
can therefore give the handshake agent and the kernel different, unintended
timeouts.

On an HZ=1000 kernel, setting the parameter to 2147484 produced a signed
integer overflow in a real target TLS connection. A real host connection
through /dev/nvme-fabrics produced overflows at both host conversion sites.

Make each parameter unsigned and reject values that do not fit both the
handshake agent's millisecond field and a safe jiffies delay. Read the
parameter once per handshake so a concurrent update cannot give the two
timeout mechanisms different values. The patches are otherwise independent.

The exact series was tested on an x86-64 HZ=1000 KASAN/UBSAN kernel. Both
parameters rejected -1 and 4294968 without changing the current value,
accepted 4294967 and the former overflow trigger, and exercised the target
listener and host /dev/nvme-fabrics paths without a UBSAN, KASAN, warning,
BUG, or oops. The expected handshake failure was -ESRCH because tlshd was
deliberately not running.

Both changed objects also built with W=1 for x86-64 and i386. The i386
objects had no __divdi3 or __udivdi3 dependency. Arithmetic boundary checks
covered HZ values 100, 250, 300, 1000, and 1024.

AI-assisted analysis was used to trace the timeout arithmetic and prepare the
initial changes. I reviewed the final diff and the test evidence above.

Yingjie Wang (2):
  nvmet-tcp: validate the TLS handshake timeout
  nvme-tcp: validate the TLS handshake timeout

 drivers/nvme/host/tcp.c   | 25 +++++++++++++++++++++----
 drivers/nvme/target/tcp.c | 26 ++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)


base-commit: aaedcff9014876387504a8b92d227766cb95015c
-- 
2.43.0


