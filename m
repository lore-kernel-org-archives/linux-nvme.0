Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0546D111BF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iFjoxITOk9DQKIVx1Zs+Qd+cPFRFt4z42sqFBUA8XDc=; b=WQHgCFBPxhBmBtERJLXe1rptu4
	LciYU5K2HxLlpXgNWVFpmFfavRoDcaOBK4SLq+dsNAeiq2+Vr4cp317NvY53Tq10QS9Nae2hVYYki
	sRCaez8a3OKflte74y1YUEuGL3GC6fr4mdjtBzgUmVPIiiyY8oYKjTdNK6x6cSQbeRklWqBs5ca4G
	D7DHNH0oUe+rguJMg4qUk5ztCnrcr9tjISjDnq7PeVmJEZWiR+Uq0iDx143cjMErKeXrcrUpsYp9+
	1nH1kJbFTmcx73w+tBASGT662BZWB4zW//IMXvwkzAal1JS2QjYtv7G9D1B+y5+SKSGtGC4WFWzrS
	Ha9sXQyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7sso-0000000D2gm-25SX;
	Mon, 04 Nov 2024 08:56:22 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ss6-0000000D2P3-2ywV
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710534; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=iFjoxITOk9DQKIVx1Zs+Qd+cPFRFt4z42sqFBUA8XDc=;
	b=fv3kaApj0Wtq9QyHgpOMUNf6voeN4gK11LptlKF9fumZ+UOAbvwbA0pFQ5541AZokqDqt7W9uzDZVmJHLzp3uzf8OjZ3s4ioN7cPetIqSHU9/JjGp6DkMXUbWFeI8yBb9kaQ+m7ogj1Z6obqIYAPvC3AVoUyB01+MT99RGm6f2U=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIdoI.b_1730710524 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:55:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RFC 0/3] set nvme ns's vwc respectively
Date: Mon,  4 Nov 2024 16:54:59 +0800
Message-ID: <20241104085524.118221-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005538_922754_5AC802A4 
X-CRM114-Status: UNSURE (   8.63  )
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

Hi,
  These patches are supporting separate vwc attr for each namespace.

  I found that the number 2 and 3 patch are conflict with Matias Bjørling's
patch which implement to supporting rotational device, this is the first
time this happend to me, I dont know how to handle this, so there is a "RFC"
tag in tittle, waiting for the solution.

Guixin Liu (3):
  nvme: check ns's volatile write cache not present
  nvme: query independent identify ns by default
  nvmet: report ns's vwc not present

 drivers/nvme/host/core.c        | 11 +++++-----
 drivers/nvme/target/admin-cmd.c | 36 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  1 +
 3 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.43.0


