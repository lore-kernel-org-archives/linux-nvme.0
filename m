Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF12CC6B34
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=119VP403nfjkeLiaufYaFI0/9KsUBZ0Gua38E5Mm05E=; b=bfvnCXUa1wDiQul9TXWJZeHcEE
	IKmlF+rCFfDThLEnMCaBVk0RhuWp1BgAumqoJwnwoS5LuOuckqmwjWqWykzKzMIuYPtTO+9x1CJI3
	PWPi2dBLNoKb9oV7JK1X3zBEIZeATEYNsryFcVqXtHwNxiNg0Cxbpo6//dlVx99hYTj4mPC7CzGPN
	2scrmJKBQ1FSb1lKUwLBtQP0yCPg2uIg/lVRvTeRpujy40tF5EDOcrIvp7WM7Zg8G/JeQUL/2DOjS
	K3k2vHhlC7QJY+aNHDPW+7y/iMHOY4E5DaqRBJIoSv4fr2BzQZ0zIQEXRivCy/I9GbrMk7WELYaRN
	hlusvIYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKt2-000000009kR-0KyF;
	Thu, 15 Oct 2026 12:48:44 +0000
Received: from vtj.irix.systems ([82.76.27.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHKsx-000000009iH-1MU1
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 12:48:41 +0000
Received: from MAILGW-DELL.dell.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 26C5421A1C;
	Thu, 15 Oct 2026 15:48:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=sig1; bh=119VP403nfjkeLiaufYaFI0/9KsUBZ0Gua38E5Mm05E=; b=
	BzH7eYkXjCFc4c5oLd/j6K177GIQzrCQ0jrESb230ZSvqYebzkKcflw1O6EkaJ59
	LZiFNAigjVV4zc37uzh1q4HjzDuEBPUVlcFeepEBMTREDKDmMSHPISbRlKM31Hwb
	57eAB/pIVF6lGX/gA8kEd+YpWug1n0i+VMbWrz09Qk6G/GSBuQX3ytTFFNJWgnb7
	JUqUaqyALvXjpY98iCfxHihlGbEsjysH3522lEijrRhML6hhwGR6av8OEfV4M8Y6
	5xBCyze4DiUusBKgB8Uv1wutPr+d+ur+HGNot+9qv7DdU1GT+8J1mEsWtylD+xOk
	kc8IPZeUx8AMwW23pkVMrg==
Received: from VTJ-MX.corp.irix.systems (unknown [10.57.36.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id CA5C8219E3;
	Thu, 15 Oct 2026 15:48:23 +0300 (EEST)
Received: from [10.89.11.73] (10.57.8.14) by VTJ-MX.corp.irix.systems
 (2a02:2f04:1:9c24::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 15:48:23 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: Andrei-Alexandru Bleortu <me@andrei-z.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] nvme-rdma: post the command capsule inline when it fits
Date: Thu, 15 Oct 2026 15:48:22 +0300
Message-ID: <20261015124823.2962700-1-me@andrei-z.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.57.8.14]
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_054839_607740_A6758115 
X-CRM114-Status: GOOD (  14.29  )
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

The host posts each 64-byte command capsule by reference, so the HCA
reads it from host memory before it sends the command. This patch
asks for inline data at QP creation and posts capsules that carry no
in-capsule data with IB_SEND_INLINE. The commit message has the
details and the measurements.

The target is left alone. For a read it posts the response capsule in
the same WR chain as the data RDMA Write. In the measured runs, inlining
the response alone made no measurable difference, and inlining both
capsules was about the same as inlining the command alone.

It builds with W=1 on nvme-7.4 without new warnings. I tested it in a
QEMU guest with rdma_rxe on a dummy netdev and nvmet-rdma looped back
to a file-backed namespace. 16 MiB of O_DIRECT writes and reads at
4 KiB and 128 KiB compared equal. The QP got 80 bytes of inline data.
4371 capsules went inline and 4098 by reference, mostly 4 KiB writes,
which carry in-capsule data. With rxe changed to refuse inline data,
QP creation fell back and the data still compared equal. The guest ran
a 7.3-rc4 based kernel. Its drivers/nvme/host/rdma.c is the same as
nvme-7.4's except for one later fix, 909307cea08a ("nvme-rdma: don't
complete a request after a bogus remote invalidation").

I wrote this patch with an LLM coding assistant (Claude Code), which
also drafted the commit message and ran the build and the VM test.

Andrei-Alexandru Bleortu (1):
  nvme-rdma: post the command capsule inline when it fits

 drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)


base-commit: bbca7c312ab25efd0024eb87545c51a76ab2ea39
-- 
2.56.0



