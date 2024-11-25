Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2233BE66893
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fBZ+Q4OinVCZLbi/Fs1yDEuKDoABwP1z9nZ0bGGdhTk=; b=qr9zJTJPVsgSXywsBJ+qvI0CT5
	SUQ72t1MCzd8pYEGPCyTq0TIkNO7K5H2BTpJ0SelO4pdyfhe2QfeSe+Hig8Zrb204jgbQf6uTyDMA
	5HSkYhX+7BQr9Y38ML7u2KrcxBsBlTfh8yzVwVXCE48LUKWBRlRPFBcKTK1b/7LKNk6f83ZEMdCdc
	eiaFnUiEe7aUDwTYfnCT7/vpLsKEzcGFyTV0FwdYkMf/XT1urnizMWhFEKHWE4madtSiMaS7gEDpR
	2OlGVEPsMKN/bwkWPExQmeFbYgE8UYsfcjhBs22uljjQg3VMbt7X3OetwH9Xy8XblJtWGeLD+7CrJ
	sgKcWRfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWUh-00000007mWm-0cEE;
	Mon, 25 Nov 2024 10:39:03 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWUe-00000007mV7-0T4K
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 10:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732531136; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fBZ+Q4OinVCZLbi/Fs1yDEuKDoABwP1z9nZ0bGGdhTk=;
	b=erHEd4Hqrk1fHwVUcNEQuPBd6RZGeIOP5pVQ60wixBsqlYL6Sh95lw4KPFn0XOlPeBOPZu5mfed6b8a4s2qYjEBJwD83Zh4bBawlkd1KjvOD67s+IyyZvWwnvQfRj3RrWnhddUPDVuW/fMKGCz+yhvZbJthkSRy434I7BIFajw8=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WKACHRf_1732531128 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 18:38:54 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 0/2] Introduce service-time multipath policy and document 
Date: Mon, 25 Nov 2024 18:38:46 +0800
Message-ID: <20241125103848.67212-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_023900_339658_0F321645 
X-CRM114-Status: UNSURE (   8.31  )
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
  This patchset introduce a new multipath policy, service-time, and also
add a new document to introduce nvme-multipath and all policies supported.

Chnages from v3 to v4:
- Change local varibles to s64 (Chaitanya).

Changes from v2 to v3:
- Add more detail to message body(Christoph).
- Add a document to introduce nvme-multipath and all policies supported
in a separate patch.

Changes from v1 to v2:
- Use atomic64_t to replace atomic_t (Keith).

Guixin Liu (2):
  nvme-multipath: introduce service-time iopolicy
  docs, nvme: add a nvme-multipath document

 Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c         | 53 ++++++++++++++++-
 drivers/nvme/host/nvme.h              |  3 +
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme/nvme-multipath.rst

-- 
2.43.0


