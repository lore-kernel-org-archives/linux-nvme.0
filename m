Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD2FC4167D
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ImLzo4Z+gpfHhCqP6y5Z2hiix0lT9/GXA9a6s1oQrLg=; b=Eejy/f1Aw+qUDL34OHmmjWdA7j
	mnodBd0Hd2aOWGEfTtpbjrkGozuTPh5Seq+bU0E53qWzHOgLbNs/DFst0hPxr+UO0dQ5wluuLm9XE
	uyK7Fv3chHEPjA9ABSP64tWoqnoVcwkc3PJQMgBtiU1Htrdb+lEB9fR3WTPqaLjtJzwSf9ec4n/Uf
	HkiTETz3XpA8UGBFRz8kNLhcJDm8Aw94gRZSFBmQnSLy9ILc8dv9L+zWhWapO8GMi5hqVk7UAovmY
	jb9FvRqNXMMiO0l4ngLH4TBxIKfzubDmeQWNQqU2lYkO/ImpRgQdJZumLF4fbmT+v9QO+y61F7IgA
	v76r6xvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntTRl-007wao-Ry; Tue, 24 May 2022 12:15:33 +0000
Received: from [2001:4bb8:18c:7298:91b6:63de:2998:b8b2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntTRj-007waP-Sy; Tue, 24 May 2022 12:15:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org
Subject: cleanup blk_execute_rq* v2
Date: Tue, 24 May 2022 14:15:27 +0200
Message-Id: <20220524121530.943123-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Jens,

this series cleans up the blk_execute_rq* helpers.  It simplifies the
plugging mess a bit, fixes the sparse __bitwise warnings and simplifies
the blk_execute_rq_nowait API a bit.

Changes since v1:
 - rebased to the current Linus tree with the nvme driver changes
   merged
 - fixed a trailing whitespace and odd formatting
 - fixed a mising semicolon in ufs

