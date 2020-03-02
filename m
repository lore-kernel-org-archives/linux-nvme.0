Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE03C3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 19:46:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE3424673
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 19:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WgdZASPg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPDnF1bT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE3424673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vMZbsG9TGQp8PJ5suCFadASnz1Q/h7yPlOBzDlr7c3E=; b=WgdZASPgZGC5+W
	blUPBp4lMXWlimtS6bH7CA/ui1j3EYuoHwTLir120Chpv61DGQarHMuXRrHE5+YCAOSDGK8rrgSsP
	3aApCrWQHAYg8Qq+GwSBzW56OuZaNDb9i0CZEVhwkhCpbP7SEAccYrW0cI2wA5duj/QB6eBxrUTqP
	DWxLQzJN0rGfUPTuO21Kv8MDEDXsYAJnNFFvwhkfpJU/fKG78XgXnIuFa7qlDfN0fcHL74U6jw4Cc
	OHzC4ydDrFW91pACX53FPLg6qAaFb3UNbgtQs6M/NjwVKZjIc+PQH81Kqb4TOGWZVS3sRu0W1flIL
	hxD6dZPWjNLLpVY9dQ3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8r1I-0000WP-DN; Mon, 02 Mar 2020 19:46:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8r1C-0000On-KF
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 19:46:23 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A96820866;
 Mon,  2 Mar 2020 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583178381;
 bh=tUPMHJWeiYo82/ayF4Ew4F7rF6Ot+oTRIF6p9ngGnts=;
 h=From:To:Cc:Subject:Date:From;
 b=LPDnF1bTyoNv8PAd841MeTO+tyyTfll4vtRIh1s8t6jz75Bqahc5hqm3Nt+wKxA1q
 nbsypXsN6WuC/VCnPIAPRJ7PFpxyCTh0y6xMoNC90tAKjOmr8ZtbN1LQlymAbUhf1o
 ODQdnOHo0Mh/miuBmaMZm29VBD1ap+DUIlvUpmzA=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 0/2] nvme-pci: Simpler completions
Date: Mon,  2 Mar 2020 11:46:14 -0800
Message-Id: <20200302194616.2432-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_114622_706032_1471EAF1 
X-CRM114-Status: UNSURE (   6.11  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This actually demostrates a modest performance increase, and that's
always nice.

The first patch prepares for cq doorbell ringing without the start/end
check, the second one is the real work.

Keith Busch (2):
  nvme-pci: Remove tag from process cq
  nvme-pci: Remove two-pass completions

 drivers/nvme/host/pci.c | 48 ++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
