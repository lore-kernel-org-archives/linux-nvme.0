Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792F606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=5Ftz5Ymk;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=D30ramIb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=EUWmyH0L3M1rdBOiDGe7PflzUNySgm/d4or5r8adSxw=; b=5Ftz5Ymk4DedMaL7JENHLyMNGA
	sJ5mPehOTwn6S01fePR5pn1NSILINdEZHE6V67/J+AF6bVQtnbU4lec1atioK8tXng5mWMB2yLBeh
	yOvyfp68aJQaAWMBs0Z9J7te+ErkjOXgm/xTfvhXU1muX9wJNGJpz4ODVzPPYfi3cJjLPpiMRmvbQ
	SSnXkpVp6aaRedkMup4dHnphIx/7SycT1pq36qHZYZ1Pdslq5I+BmjywOFm03ykeT7pf6mYJr/WMp
	eU3q+JWqY8LWy2xwUt6cWxr5oT2lGbMkD8Uevh+BietVHjVkRKkE7jk6a74hDICkVpef/Ye5QUsY8
	/hauiDhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hf-00000006uCn-41mu;
	Wed, 28 Oct 2026 11:57:35 +0000
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hc-00000006uAk-3lSV
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 11:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793188644; bh=EUWmyH0L3M1rdBOiDGe7PflzUNySgm/d4or5r8adSxw=;
	h=From:To:Cc:Subject:Date;
	b=D30ramIbEEL9kQRJdtPDmcp0oT+cVZ5u2KgTIX13sevS6ZbOef5KXjIRpglo4jqyr
	 KH1PBmel0CMcSikudZ7Ls4O/EiUCe4HFuz53SzOOsrKbPScrs4ewfyzU9isiXL9IMk
	 Fb0eSJaV3SFsrBe+65mzyHKW2V377xahTixabjmU=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:7875:da97:7462:bbd3])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E54BDCF4; Wed, 28 Oct 2026 19:57:20 +0800
X-QQ-mid: xmsmtpt1793188640tna7ungbm
Message-ID: <tencent_8B4F08A2DD4BB093ED7FAECFFD20272B3C07@qq.com>
X-QQ-XMAILINFO: NZRRnjJGoaJhS44706EhUqftyAdPe1qMAnqQWIHtxtjft8PNtxqNEVP4CucgYg
	 4hRKUhow7VPlmAMn7yKU9nBwrkzlc1j6SOLu/6JHN/vm6QrZMQSrSzgODx7Mx6oeHVq7DVwfrQFd
	 iH35gyI0PENb+vTshtYJ2HkmGqHamSaB+vgsAcjozmkGB1E4BMhZIvgA4QunV9bHYDF0HXSULVWu
	 QTZUKSPYiitGIZNTLfVES8Jm6fwx66rs4TqaJonCUMJTzISeeg3ASVzmlziJG43hItx95Gykj0hu
	 xO/QCL1QJhkPUWQeGKb7t+19bHqVqAOz4dy19q9Kq0dE7+OTDuOm78uo7BdIr6riR8YHIkyC644D
	 +UVD/cW+mH2lkQHzHEoOYtkAaiJ8ui+Ewl7yXM66TXP8ngAB0BOrkQmtZt7rSkr6hvlSpgEVThZJ
	 Cj2K7iOqzWWehch7toNoh5Mk9Clct+adluSUqgRdBw8flghjusT41HHDmODj8Ymvw4/sv4wSOis8
	 BWJHgRkm9y8B7Pwtztk64UtD3zEn1b+vET8PqAWTw8gfi/e3ZRVfqKRnFokz8C8/bhHUROExzU1u
	 XIsn22J6/v1oJnhXKHtijkYDATbUJcIeonGB8RWXaF5FmhPgailXIxo4HvtTPfmWLHzz5T7o36Z0
	 s0h2E/WyF8w3a4N51Krq0/5JS6bSw6d3thWRB5hqU0N4bN9PQgXxkgK0jTk3XLKooaxEZp5uENvy
	 XfANxUL1rXKRdTpxNgbfSzYeaHJ4WOCOZp9+xzHCWTi19cX26UHh3XzwWARB5oZoVSVVARhc5o7S
	 ASsBdL642qvYouDC1TM5er6S5OWMlElSk+nIi38hy/Gaxjzu5YUv5f0fHYdfiQ69PtCPfUEjEjNa
	 TbRz59S6tklGN4HQhUF8in1BT0tpk88WKyuq5yo3+eKA92Of2/go/XCo1NCosABf+L3RFH/0cm6G
	 NeKSfSe6z1BTGbLqI3XJ+Tbnaz3zttlQ0RAKYn5J1YrtFrUf0KsqmCS4MlMY2ISE9IXjBGWQoPaD
	 SnnXJJT5YIKoaN2Sd7Bo3Fb83vViSbCucb1bnwGRjolRW1GvTTWwg9fV38goKcEJTj/w1cm/NXrD
	 AqrS8q
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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
Subject: [PATCH v3 0/2] nvme-tcp: validate TLS handshake timeout parameters
Date: Wed, 28 Oct 2026 19:57:18 +0800
X-OQ-MSGID: <cover.1793188633.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_045733_478570_75664263 
X-CRM114-Status: UNSURE (   9.69  )
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

The exact v3 series was built as a complete x86-64 kernel. Both changed
objects also built with W=1 for x86-64 and i386, and the i386 objects had
no 64-bit division helper dependency.

On an x86-64 HZ=1000 KASAN/UBSAN QEMU guest, both parameters rejected -1
and 4294968 without changing the current value, accepted 0, 4294967 and
the former overflow trigger, and exercised the target listener and host
/dev/nvme-fabrics paths without a kernel diagnostic. The expected
handshake failure was -ESRCH because tlshd was deliberately not running.

A focused in-kernel completion test used an already completed completion
and a 2147484-second timeout. The wait returned 2147484000 remaining
jiffies, greater than INT_MAX, and the v3 result mapping returned success.

Changes since v2:
- clarify which documented timeout belongs to the NVMe/TCP host and
  target, as suggested by Randy Dunlap;
- add Hannes Reinecke's Reviewed-by tags to both patches;
- rebase from aaedcff90148 to nvme-7.4 commit 9afc1b71d963.

v2: https://lists.infradead.org/pipermail/linux-nvme/2026-October/066922.html
Documentation review: https://lists.infradead.org/pipermail/linux-nvme/2026-October/066933.html
Target review: https://lists.infradead.org/pipermail/linux-nvme/2026-October/066956.html
Host review: https://lists.infradead.org/pipermail/linux-nvme/2026-October/066957.html

Yingjie Wang (2):
  nvmet-tcp: validate the TLS handshake timeout
  nvme-tcp: validate the TLS handshake timeout

 .../admin-guide/kernel-parameters.txt         | 10 ++++++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 drivers/nvme/target/tcp.c                     | 26 +++++++++++---
 3 files changed, 58 insertions(+), 12 deletions(-)


base-commit: 9afc1b71d963090e2f2aa5b2f390957823ae943b
-- 
2.43.0


