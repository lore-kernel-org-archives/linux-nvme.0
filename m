Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F095C982FF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jxWRejUtIeE3d2ZGmdL1cYpY91i/eT87f2tDvql+EHA=; b=0a65mBekV9CLgjVEd5v5noLqKU
	fp53+6FvrdSMNPMieenUdhLxM3yGOuac7tL3+iNNlM1wjMye3b17Ma7qeJlu44vyKM5cvtcIEvSdP
	nCPLMYGyqmiX9xmc1rRM/8mSheqT2QOACSDD1Cm8L7INFdmS9bVA0F5tvCu5sqUCdJGO7LTg/Qc42
	4Y5mx/2RVSg3vrAOHTb730/SfFDLtBYhaOP/WRw7OHOJ86M8yludLPVt4RCvDiUfh/ybxJqN3/3jO
	F2ExRgOuXPxMmrZ6M54NtGszyR9UEp4Of3cqE5TtI3trwaE5nzbfg5KSZTaBylnlCkDbusInALUDS
	3ha1Nnxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gS-00000005Y87-3mX1;
	Tue, 22 Sep 2026 13:37:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90gR-00000005Y7G-30lF
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:37:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 245F84058F;
	Tue, 22 Sep 2026 13:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F431F0089B;
	Tue, 22 Sep 2026 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790084239;
	bh=jxWRejUtIeE3d2ZGmdL1cYpY91i/eT87f2tDvql+EHA=;
	h=From:To:Cc:Subject:Date;
	b=VNNfRyc5joEAXYeJwbqwjw8L9JBBgRwf2wQP05yrmtvU298gSro14zLmqdx3drB0x
	 5XZSPbtziOxuaJ1vhSUNJVbTleJC5AXH/R3W7i8cAL731a6/HgBns9c1AjhKO5cZaC
	 W3NdS01r440A3V3Swu54hu2XmBDn9c6vo+XTUfDiNE5wlvSo5PSrOczx5MEgpexT9q
	 aGkIaeE3k34jI2YwIHt20d0kmgVj6PbvoyFsLIGfWcr1HH151iZkJZNp1wOZvY8wUK
	 rrnS3zKI/SYtMHLrG6Gb1WmQvSmbnKqIKRu/k+q+7wpXnjqv0d7j2s7V7AaV093z6O
	 3Q9cf7FtWp0iQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/2] nvme,tls: minimal handling for TLS records
Date: Tue, 22 Sep 2026 15:37:06 +0200
Message-ID: <20260922133708.84522-1-hare@kernel.org>
X-Mailer: git-send-email 2.51.0
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

Hi all,

TLS 1.3 can send additional TLS records while the connection is established,
and typically one would evaluate these records with passing in a control message
buffer for recvmsg(). But nvme-tcp is using the read_sock() interface which
does not allow for handling of control messages.
So as the lazy way out I opted for resetting the queue on any non-data TLS records
as this would be the default action anyway for most non-data TLS records.
But turns out that this does not work as planned, as the TLS records are evaluated
(and errors generated) before ->read_sock() is called, so nvme-tcp would receive
the error but not start error recovery.

This patchset is the minimal fix to handle it, start error recovery when a non-data
TLS record is received and also return a distinct error code from tls to indicate
the situation.

The 'real' fix will of course involve actually reading the control message and take
action based on the type, but that is a rather involved operation which will be addressed
later. So for now this simple fix should be sufficient.

Martin Belanger (2):
  nvme-tcp: start error recovery when read_sock fails
  tls: return a distinct error for control records from read_sock

 drivers/nvme/host/tcp.c | 18 +++++++++++++++++-
 net/tls/tls_sw.c        |  4 ++--
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.51.0


