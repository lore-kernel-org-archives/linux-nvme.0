Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD26D6EBEE
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=h9dlh/dlXWYjD0iKsgjj+OCoBD9g1O8SOVDyFDLWnhQ=; b=yFISgUKPBebHBh
	4bZ+FXrTuiuGAbr/C816YvMKV3HF4rculu0ijd9cja0VvcMt6eYekh1FcYvSLPHYGuPCK5SzlAXbK
	/JOSrYInWWcyqjSfY1PHCzoVeVcz6nGk3hoYnivnrVNTTWOvjaaf50RN9SkKx+tvESK9/yb3EAOQ+
	YX91WYz8wwodxczehQd/qTOZLFtW6+5zTk3pBNIgIKNgzS6zriURpRJHTrS/v5MnpCTIe0CQIo45g
	XLz/ZoNUPL68uqoZbg0cV/ZiLNkBwIXVuwJMbz2ZZTBl7NKyegEl8Rge+II3o4dmNWHR/YgTCi7k9
	1d7xxaqLRIAZreAoeQEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIf-0000000HKcO-2YzH;
	Fri, 29 Nov 2024 09:28:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGxIc-0000000HKba-1K1c
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 09:28:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8BD81A43DC0;
	Fri, 29 Nov 2024 09:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF19C4CECF;
	Fri, 29 Nov 2024 09:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732872508;
	bh=v3qXPXvUm4LeQfu0uk/hjbFzCdAxPDZNggDNSWyJChw=;
	h=From:Subject:Date:To:Cc:From;
	b=I2g3PDC305GsSRmhpnTZo6vv48DvZk7qOnlvBNbmmJv396pHJKo3/Vo3SI5RA2XQo
	 xNZoNneMO5TuZLP8vYTi5wVzg41t5xrZugwE9CJihQV383hcSKDfCuJASbdy6DTLUN
	 9A1LdYz1XHCdPIP2scuGSvR2kbVHZ3oah1yk5DazN9tvH7r0Y+x8gGCFoMa3VZzVrM
	 jjeIhvs5b/kcMnlmWUYOhsL6OGS+vFBdzcthjLiOhfhK9CyOWsdhghCPs3KgkSAlJL
	 tekny0gpgE9rVR+5j+a84hhx4bg8ixUn3fmsC1kmxvW80kF/wGj7VCRfnQ6ZmucD8t
	 /jIlc4cDZrVkg==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v3 0/3] nvme-fc: fix race with connectivity loss and
 nvme_fc_create_association
Date: Fri, 29 Nov 2024 10:28:22 +0100
Message-Id: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADaJSWcC/4WOwQ6CMBBEf4X07JJtUbSe+A/DodAFGqE1W0SN4
 d+tHLx6fJmZl3mLSOwoinP2FkyLiy74BMUuE+1gfE/gbGKhUO0lKg1+mQi6FlJoR4I2TDCGOIN
 uUkEX5Qm1EWl9Y+rcczNf6sQdp+Y8MJmfD0sppcZyf8ylPB1KkGAfpvfEVbxHyi19RYOLc+DX9
 nBRX93/M4sChEODVhZHUgZNdSX2NOaBe1Gv6/oB5BfWC/gAAAA=
X-Change-ID: 20241029-nvme-fc-handle-com-lost-9b241936809a
To: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_012830_446712_041F1464 
X-CRM114-Status: GOOD (  11.86  )
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

After a long hard stare at the keep alive machinery I am convienced we
need to trigger a reset when nvme_keep_alive_end_io is called with status
!= 0. There is a lengthy explanation in patch #3.

I've also tested this version with blktests and some manual tests. Though
it's not that easy to get into exact sequence reported by Paul.

Daniel

previous cover letter:

We got a bug report that a controller was stuck in the connected state
after an association dropped.

It turns out that nvme_fc_create_association can succeed even though some
operation do fail. This is on purpose to handle the degraded controller
case, where the admin queue is up and running but not the io queues. In
this case the controller will still reach the LIVE state.

Unfortunatly, this will also ignore full connectivity loss for fabric
controllers. Let's address this by not filtering out all errors in
nvme_set_queue_count.

---
Changes in v3:
- collected reviewed tags
- added nvme_ctrl_reset to keep alive end io handler
- Link to v2: https://lore.kernel.org/r/20241029-nvme-fc-handle-com-lost-v2-0-5b0d137e2a0a@kernel.org

Changes in v2:
- handle connection lost in nvme_set_queue_count directly
- collected reviewed tags
- Link to v1: https://lore.kernel.org/r/20240611190647.11856-1-dwagner@suse.de

---
Daniel Wagner (3):
      nvme-fc: go straight to connecting state when initializing
      nvme: trigger reset when keep alive fails
      nvme: handle connectivity loss in nvme_set_queue_count

 drivers/nvme/host/core.c | 13 ++++++++++++-
 drivers/nvme/host/fc.c   |  3 +--
 2 files changed, 13 insertions(+), 3 deletions(-)
---
base-commit: 029cc98dec2eadb5d0978b5fea9ae6c427f2a020
change-id: 20241029-nvme-fc-handle-com-lost-9b241936809a

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


