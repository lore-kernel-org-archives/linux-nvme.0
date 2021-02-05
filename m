Return-Path: <SRS0=OXBW=HH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F3C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:56:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8182364FC2
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Feb 2021 09:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8182364FC2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W6RdvKpf7sXkEU6yfi4KZsIk3OREJInAiSdhLusSc3E=; b=FrodV6GYNW25XM4o679VWN2GSa
	E86/IaapYuSW2/m3sjPLMPGsw8ZIab506pS7BFaoy0xDq2maDUZAo+uSTZzGFLQDjTUtn1JChw+K6
	neYndrJteh/CfbO2S1ENhePdjsDDImKgY9Lq25yneK490tMGJUS8lWYuoWk9KhADXX3gJ4A/Sa2Ps
	7n4xLPXIwSEgX5zlJbJR1lSh9LsQCrCPpZXKEZ4Wc0kM9vEbwuJNtIRifq7MrwNteGlhr5+m5Nk7X
	S0hy+c6T8o+TT1PQmP2eL12YhMuHas1ztNkQL/YDNGUqz/zF51FskpIy5cESfodiDVUUR1l3P3MPq
	vpG27/oA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7xr0-0006M1-Gc; Fri, 05 Feb 2021 09:56:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7xqx-0006LZ-0t
 for linux-nvme@lists.infradead.org; Fri, 05 Feb 2021 09:56:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 95CD3ACBA;
 Fri,  5 Feb 2021 09:56:37 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvmetcli: fixup ana groupid setting for namespaces
Date: Fri,  5 Feb 2021 10:56:36 +0100
Message-Id: <20210205095636.65151-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210205_045639_177852_FC4B1169 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The ANA group of a namespace is displayed, but can't be set.
So add a new attribute group 'ana' to the namespace such that
it can be set via 'set ana grpid'.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 nvmet/nvme.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 83fd75b..d170204 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -567,7 +567,7 @@ class Namespace(CFSNode):
             if nsid < 1 or nsid > self.MAX_NSID:
                 raise CFSError("NSID must be 1 to %d" % self.MAX_NSID)
 
-        self.attr_groups = ['device']
+        self.attr_groups = ['device', 'ana']
         self._subsystem = subsystem
         self._nsid = nsid
         self._path = "%s/namespaces/%d" % (self.subsystem.path, self.nsid)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
