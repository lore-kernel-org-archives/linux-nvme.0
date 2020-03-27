Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E943C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 07:01:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D350B20705
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 07:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cNAgsJvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D350B20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=XhoITuQxLyUarZXjlVUaYvN2TKl/E0t4DJ9nBs62A7s=; b=cNA
	gsJvWyEwIouEBLFsFgz6DeAwZUdcJ9LnwPtq7gcLtjzneqjrqNRmyc8Tfvqr8I03XLDkKcJt+ZvqS
	YdnoPg6Mh59Cj/hAgB8RjXbYjxWqudHjCSsxDPztdhf4jaJEstmLRzJj+4U9GEKZx/BZojpz6ZmZn
	cKOcziG3nfTuyVIrzW2nTiCntLV4yBtH/wUlIYzDFGT4V+ZFjoaQz7qxgBvSYwaSQUdS7zrt72IRf
	DAaudV4fkdtYRUfRtC76dN1L5hKaLrjQ1bbAUSL3xTGacpZFXCDbiFHA3K1MYem95bek0nfrQwyh2
	7R5vS11ePRXEoB1laklSKdItOEIHULA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHj03-0007yC-18; Fri, 27 Mar 2020 07:01:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHj01-0007xf-0S
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 07:01:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06ECBB265;
 Fri, 27 Mar 2020 07:01:44 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmetcli: don't remove ANA Group 1 on clear
Date: Fri, 27 Mar 2020 08:01:34 +0100
Message-Id: <20200327070134.2882-1-hare@suse.de>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_000149_194006_5751DA41 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The first ANA group is maintained by the kernel so it cannot
be deleted.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmet/nvme.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 0647ddc..fdec4ff 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -845,6 +845,11 @@ class ANAGroup(CFSNode):
 
         a._setup_attrs(n, err_func)
 
+    def delete(self):
+        # ANA Group 1 is automatically created/deleted
+        if self.grpid != 1:
+            super(ANAGroup, self).delete()
+
     def dump(self):
         d = super(ANAGroup, self).dump()
         d['grpid'] = self.grpid
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
