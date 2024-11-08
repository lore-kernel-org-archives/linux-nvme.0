Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E5CD5E149
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pZAUTFIo0TrtJ+88VvBHkxSNC1hjBphWEAYPyuiqsXc=; b=wqPV7janymHNNmjTWFS+YSC0L1
	+fBYM//R31Rw7IiN8uXJCh4e3CcdL35Er8jHqowYD4539yL3Sk8dXjZHTY2IiNZ5pCsADzJjeR+HC
	w5noh2Ob9XqGToqF8UGgRpsNiobCrNUWYUvfoVfqwRIwGUgIfR7TrwyBoNpEyWmIC6U7AZUZJ/Wob
	6wM81pxZxHaV5bMTPzm9omKRFCahk6sJEVBur4CimxP+KmF7AxkCEaYa4RJWl6WkNRf+H6ARWCLHQ
	4rJLaydaaQOM6/qKfQCw5GB/ZdQN0pVyfEURdlmrku3ItTEd3x7EJ4Ejpuss2sNgr8BpyMT4Syomw
	q6AWewew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Kvw-00000009tc4-2bbK;
	Fri, 08 Nov 2024 09:05:36 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Klh-00000009rE5-0W2I
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 08:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731056098; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pZAUTFIo0TrtJ+88VvBHkxSNC1hjBphWEAYPyuiqsXc=;
	b=Z2/FFErO4eScO/SOVSRrCpAL7DHH9bXyRqLtB9PMJ2+lT+/UYR3r3Fy8V6hBXcFjvwNl8FAAJNpxbGVG3PTsVT21wT3Ezvbc0y1PuNShbxhtJP+UJxF2HYrajyKarSTfYxjCkf7auDkp/WzD3RrICIhfVvtG9+qGgou+LHy3RTk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIyjpkZ_1731056089 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 16:54:54 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/2] Introduce service-time multipath policy and document
Date: Fri,  8 Nov 2024 16:54:47 +0800
Message-ID: <20241108085449.49972-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_005502_043829_C0B73242 
X-CRM114-Status: UNSURE (   8.82  )
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

Changes from v2 to v3:
- Add more detail to message body(Christoph).
- Add a document to introduce nvme-multipath and all policies supported.

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


