Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08944C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v/FQi+PH0ky+i5bGonCwbhF5Gx2og22wYvXmkg5LDJ4=; b=pUsWMP/Be3AQYwaXEszibPzTjw
	6rxOZYHiiMkuUG6VummyBlzj7w1iErhmiDxV/9Tn+X7LNB3WbsyputwyfKji4VGvwGfvi1p6JYFXC
	1jzBnhSNkjFI6Xni+UVrNjWzSgum27eDbIi+/Bln71LYlWEREpYvzdDrG0Ie+O3aYzMBFmV0j4Amg
	GNycRbETwyqONJ2GpBuCPMyKC9mmsC2gxvKsRocMQBSp5BIM3goqTgeo9i8N5bga37RshNub0fVUW
	yDXPMUyVkzxk8tsgkFix3td9U100i/EgkQi9y8T3oMeAgG2Xg0QWDZkfZudVMhi37IEc2oyBsJIRQ
	mwIcIsOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmzWE-003xdH-S3; Fri, 06 May 2022 15:05:22 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmzWB-003xbE-Oj
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 15:05:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 79CEEB8366C;
 Fri,  6 May 2022 15:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A3CC385AA;
 Fri,  6 May 2022 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651849516;
 bh=fhDnj/gHUadlVDzinZrEMzeeuKCFomPvapKUxScb6vI=;
 h=From:To:Cc:Subject:Date:From;
 b=rOcnY6Ej2CD34II/WUkNS091v7OFyebuwqx6UDIxJd+8YzGSBX9rw9nBcF4Fq7Lra
 QMAJhPxU2LRHFzT5OL8KZ8m/9k+yPY6hmHaSflp34or4toYQ5If/ajNfPqCBzSG6zM
 GbevKLhbnrWIu96TPEnJzH3djkwNnWsnUtbZO8B9mJ+Igl6/gESqVLBMnsrr9NzVMm
 BXo79yoW+yZ+NQNhkLuidU1Ib3+SOhjrhpaT7HiAecqcHDULUA7a8R6aRmyL6Mr7g+
 3FUSaBmjw2QS4d6VDoatUWykXn+b7D70gGVI21hzfeRVVlgm8M3T5xttdmmXP9gk2L
 mQYfji4aaIMQw==
From: Nathan Chancellor <nathan@kernel.org>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] nvme: Ensure ret is always initialized in
Date: Fri,  6 May 2022 08:03:58 -0700
Message-Id: <20220506150357.2443040-1-nathan@kernel.org>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_080519_997032_DFCC57A1 
X-CRM114-Status: GOOD (  16.18  )
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

Clang warns:

  drivers/nvme/host/ioctl.c:674:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
          if (ns)
              ^~
  drivers/nvme/host/ioctl.c:677:9: note: uninitialized use occurs here
          return ret;
                 ^~~
  drivers/nvme/host/ioctl.c:674:2: note: remove the 'if' if its condition is always true
          if (ns)
          ^~~~~~~
  drivers/nvme/host/ioctl.c:672:9: note: initialize the variable 'ret' to silence this warning
          int ret;
                 ^
                  = 0
  1 error generated.

Initialize ret to zero so that it cannot be used uninitialized.

Fixes: 271ee3df5cca ("nvme: wire-up uring-cmd support for io-passthru on char-device.")
Link: https://github.com/ClangBuiltLinux/linux/issues/1630
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

Or alternatively, remove the 'if (ns)' if ns can never be NULL; I tried
going down the rabbit hole to see if that is possible but I got a little
lost :^)

 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9db88f2c15f8..3ad5285c1f96 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -669,7 +669,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
 	struct nvme_ns *ns = nvme_find_path(head);
-	int ret;
+	int ret = 0;
 
 	if (ns)
 		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);

base-commit: 002b149a51a53facaf26d7c6f2c1fe718673683c
-- 
2.36.0


