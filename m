Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A81ACCD18D
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXzoFqKUEN4tLK6F2WqpMdlYdPjnIt69vljbsOVRGv4=; b=h9hByEVR5Go7Q8KxjrXs2vWpv2
	TpdG+ClA/hJGqKMgpnwMiQnrOzzjHq/L0EH7NV3MxlKbqZrxpynvvXn34nA2qMOBkz2XhIDi1kPNp
	rILiJjKO8iSL9w3yqazwjjG8JsGVGsc7ekBkgniSY/cTGyZnY4KZJY6jQnApvPkkIHSesWdswcXra
	VDc6Vyw0L0F9BJNBT1kVV9Gm9ceJBPogA3aMHkxC4Pq9hmCbiMPEgaFkN8SMNCQoPr7AHiMIu3pYf
	m4ZGXV3omyu+RFObQBfCsZJCsZDYRA70O69LFvd5jmW+D1MJfxCePlXexq4PwhHC1QVm3X9aZH43B
	S+jV+duw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu5-00000006ju3-0592;
	Thu, 09 Oct 2025 16:54:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu3-00000006jte-0SZu
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Oct 2025 16:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BXzoFqKUEN4tLK6F2WqpMdlYdPjnIt69vljbsOVRGv4=; b=ZNu6tSkLiaVmKO7I188V+ur5Lw
	4EXPEHFjm/SFwU+OWOu0Nm/9Cdr3zuHSwRBbq8HkyiJTo/bsxQKJkwhq1ZW5X0rz6CNoSRNkrRjb3
	1f5qHM+94HlG5s6ej1GOb7U1sGuD9nEIgrm9ftPS89qocxpkmbw2O2Yl70GboanWbBtsaQBrvsg03
	d5GMdcr1MXXhKrPDl94pEBhgNfYAwiUXSgU5SlPx5gMGGuQVJ9v4zs6E+8Q6wZo3NFfENZ8u8AzHj
	FlwGy93d1caP2cz9BOp9pLpgpYMIVlPw8u5pDYl2XH2EUl4c40V9RU3FE3C4e9yhKwrAhAspba+/L
	21Dqrerg==;
Received: from phd-imap.ethz.ch ([129.132.80.51])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ttz-00000001Zwb-3ity
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 16:54:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1760028315;
	bh=BXzoFqKUEN4tLK6F2WqpMdlYdPjnIt69vljbsOVRGv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPQjIgd9KSrV/MdXNPSNxWmd+cgt9EbQYwZR65uRjxcZBGeOW1TBRbtKpSscmUj75
	 hxBKqAdIN+F8Wus0kpO+ptR7G2Nrm9FW2doQ62a3NChWSrZ2iRAPP+57Vs6XgdJBoF
	 /GUwRpEaJQL/Z80lveNL0WjLlBIKQpb6KQOwqVhdYxCOwISoPsedIuceX9fJeFjPiA
	 MAfQLusyYNS4Umrc4M7PwLEQZRY1H7O2eJrdHjqlTy1z2XRezf2ML8z2eOLkdItwvz
	 Uc2aecL/EOAHFrD3E3ovvYpa2DAaIh6yi6VZAyqPw8w2cP66oEDnSmoHd5gP3/LZEV
	 Y95cPGlVTJqOg==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4cjG2M2YSKz9S;
	Thu,  9 Oct 2025 18:45:15 +0200 (CEST)
X-Virus-Scanned: Debian amavis at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
 by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavis, port 10024)
 with LMTP id 8lFDdQs06lTl; Thu,  9 Oct 2025 18:45:15 +0200 (CEST)
Received: from dumbledore.ethz.ch (dumbledore.ethz.ch [192.33.96.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by phd-mxin.ethz.ch (Postfix) with ESMTPS id 4cjG2M1knCz7Y;
	Thu,  9 Oct 2025 18:45:15 +0200 (CEST)
Received: by dumbledore.ethz.ch (Postfix, from userid 13394)
	id 4cjG2M1HDwz9srq; Thu,  9 Oct 2025 18:45:15 +0200 (CEST)
From: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
To: linux-nvme@lists.infradead.org
Cc: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
Subject: [PATCH 1/2] Use preferred module name
Date: Thu,  9 Oct 2025 18:45:03 +0200
Message-Id: <20251009164504.2212623-2-stephan.mueller@phys.ethz.ch>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
References: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_175404_112014_A1D25591 
X-CRM114-Status: GOOD (  11.73  )
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

The configshell-fb module is now called configshell. From v2.0.0
onwards the preferred way is to import the module as configshell.

Signed-off-by: Stephan Müller <stephan.mueller@phys.ethz.ch>
---
 nvmetcli | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvmetcli b/nvmetcli
index d949891..433e4c4 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -22,7 +22,7 @@ from __future__ import print_function
 
 import os
 import sys
-import configshell_fb as configshell
+import configshell
 import nvmet as nvme
 import errno
 from string import hexdigits
-- 
2.39.5


