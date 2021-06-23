Return-Path: <SRS0=xKei=LR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71853C4743C
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:33:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376176112D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jun 2021 14:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376176112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pFVwfBjda0u28Lm25O/2wTYWV/XWgquOJ6X7jHF9Ld4=; b=fgr2dR6o0YuUl1
	WFlgDx0N9CmMelckl/eQ+7aC5SgWir1y72vUxBpRaRfH9aCq64cdiTXnsllKfqhGUZNmeLzxWwZFB
	NH/+0ZtqIiP45jE+rIb+sVguAPjNXHzfZa1w67Zxp6AUDNMw9UXnhaNYkiWX9dH29xEpryuQGvGEx
	j23BVhOCn/ApoojwJVlqwtIZnIKv2AO3kjrDUVn3MSJaakhhky1bQo1wTIxoDR3bLfGL01K1xCfpP
	MHkwtP5iToMET8JTP6ptEAghYgajm+FPa9NNGa9uKohhrQhk5OyUcBGQdm6Iuz/Z6PIuhLQPI6IdD
	T5KtiO3dM9ogaru49ZpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lw3w2-00B0UL-ES; Wed, 23 Jun 2021 14:32:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lw3vz-00B0TK-He
 for linux-nvme@lists.infradead.org; Wed, 23 Jun 2021 14:32:56 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 39C271FD65;
 Wed, 23 Jun 2021 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624458774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KXBuMRJQmWQg2hDDWYpzfIM2PMXQ0orhV3xfYNT2pw0=;
 b=bJSun9i0eGZXC8a2LdY56Gr88zzGFjg5ztrHAEjv8Xub1RA8Mpds6eToDIAJSZN5drgjed
 wE6cwcvrC5e02xbvtJljkL+WfePKinCs7jU+QowwvhUnqAx2BbGOJtXRZp40jbJK9nzGwM
 DFZK5RzN1uVDG05hxKMPhPzVCLl9r2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624458774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KXBuMRJQmWQg2hDDWYpzfIM2PMXQ0orhV3xfYNT2pw0=;
 b=M24+vuNZeQQDfRCaSApKX8LBPW5uiUTSr5uqwji1XSPXZ/pqxaBAWECjKjmZJlBbam0Xmh
 C4sO0ywDa2cl2VCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0A41BA3BC3;
 Wed, 23 Jun 2021 14:32:53 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3BBFE5170875; Wed, 23 Jun 2021 16:32:53 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
Date: Wed, 23 Jun 2021 16:32:48 +0200
Message-Id: <20210623143250.82445-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210623_073255_780732_842214E6 
X-CRM114-Status: UNSURE (   7.22  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

commit f25f8ef70ce2 ("nvme-fc: short-circuit reconnect retries")
allowed the fc transport to honour the DNR bit during reconnect
retries, allowing to speed up error recovery.
These patches implement the same logic for RDMA and TCP.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme-tcp: short-circuit reconnect retries
  nvme-rdma: short-circuit reconnect retries

 drivers/nvme/host/rdma.c | 23 ++++++++++++++++-------
 drivers/nvme/host/tcp.c  | 22 ++++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
