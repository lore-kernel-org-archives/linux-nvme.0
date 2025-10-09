Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8F0CCD183
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3aG8/v3JC9pRt8YORfw+3G1R7Z00TClPGKPOMLxyfBo=; b=EGCh4cLqhVtWhwsoF7tG80iNgQ
	0au0d6XBPGMcysICx2HKRJKiqPuqIY6vlIYnjN6pTuUJ9oonRGvzyj6ROziV4qMWM5mNm1RqN6jbJ
	J5cmIfLeQ8kSi2C4lAKtYV82EGFE8OqtzVSamniXVLnP7GHtwkx2e2cGx9HwaU+ZVHtdNsZEIHvOT
	ipK1eoWbFIbM5GcutMMg53/E4x5Dt0fBZg2vzVdr63Q7hxl+UKmbl91PTQlubxCZoLphyqztJJSC3
	WYJ4riXqebIduySaX/uCEvv3xTIoQpn4JQFJDK01fvzjJe5RjZukv2H5hhY2xzO6WRu3T88RpcaCQ
	Cjyh8ywg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu5-00000006juI-2oKm;
	Thu, 09 Oct 2025 16:54:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6tu4-00000006jtj-19MF
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Oct 2025 16:54:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3aG8/v3JC9pRt8YORfw+3G1R7Z00TClPGKPOMLxyfBo=; b=X/c5yKoY6a64QLOR1qDQu0ieY6
	8q0lEImaunQTUP3PnvKX1pMFY4hJXbCF0AGrO9ANEqnVY0w1xK547GM/+2bdhkByabfkFx49SrLFC
	nld+ImCq/gV9N0q+CA10DBTUc4z7ay/ThwUStds2ZdP1CoaLwmQkf1yVRq7Hd+tqvyHT8+6A7QLJz
	pPvbn/S3DnxlZy6/EHn1dgOjyPiaS0Z7sEj1DhbHVPEYHIvmefBqtFQTNifmAmuUX5lqCX/CsEU/8
	l+oIAsNZKQZZDKVDLe2cuutA5CtcNT6le+9vWj1SFM0LQCzR3QJP1XI2n8S1GrGTTonIW0xWhN/H0
	F4Mt5utA==;
Received: from phd-imap.ethz.ch ([129.132.80.51])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ttz-00000001Zwd-3a2v
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 16:54:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1760028316;
	bh=3aG8/v3JC9pRt8YORfw+3G1R7Z00TClPGKPOMLxyfBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mF16mAdseoSpt0WJduKB7onv/t8TBCZmYKh/lxGlqJE+n5Ofg3KB1XbKkr4NDJ+ol
	 gVuAOpRl/i/f4jiHBuqP8B3ccZM7XJUVHRlTh7ix8RSsV6NiMO5IEQgAddC5eq9zbl
	 ns8uaDZ75xs1Yi4D/87KZyYGKEBAHB1XYYuk1XphgawoZy2TblGsuiRGlDwAGWqMR1
	 HgXYPIJmXxZXetxF1aStv+wt78AhzLdeJILCevlVilAbB/7Aa1cdwtr0hNfN9mMYSc
	 iki318hRQbmmNCyGvbKXPpxp8feyg6cpEqU/TCRII0SjUvvj+MgELIz48nl001PosD
	 OweTfi+r5e6cg==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4cjG2N0kPbz9y;
	Thu,  9 Oct 2025 18:45:16 +0200 (CEST)
X-Virus-Scanned: Debian amavis at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
 by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavis, port 10024)
 with LMTP id D59zN31IPIIm; Thu,  9 Oct 2025 18:45:16 +0200 (CEST)
Received: from dumbledore.ethz.ch (dumbledore.ethz.ch [192.33.96.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by phd-mxin.ethz.ch (Postfix) with ESMTPS id 4cjG2N08Ccz7Y;
	Thu,  9 Oct 2025 18:45:16 +0200 (CEST)
Received: by dumbledore.ethz.ch (Postfix, from userid 13394)
	id 4cjG2M6vGdz9srq; Thu,  9 Oct 2025 18:45:15 +0200 (CEST)
From: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
To: linux-nvme@lists.infradead.org
Cc: =?UTF-8?q?Stephan=20M=C3=BCller?= <stephan.mueller@phys.ethz.ch>
Subject: [PATCH 2/2] Use exported configshell symbols
Date: Thu,  9 Oct 2025 18:45:04 +0200
Message-Id: <20251009164504.2212623-3-stephan.mueller@phys.ethz.ch>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
References: <20251009164504.2212623-1-stephan.mueller@phys.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_175404_149955_208AFD43 
X-CRM114-Status: UNSURE (   9.76  )
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

Replace direct invocations of configshell internals with actually
exported symbols.

Signed-off-by: Stephan Müller <stephan.mueller@phys.ethz.ch>
---
 nvmetcli | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nvmetcli b/nvmetcli
index 433e4c4..fe8a58e 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -33,9 +33,9 @@ def ngiud_set(nguid):
     return any(c in hexdigits and c != '0' for c in nguid)
 
 
-class UINode(configshell.node.ConfigNode):
+class UINode(configshell.ConfigNode):
     def __init__(self, name, parent=None, cfnode=None, shell=None):
-        configshell.node.ConfigNode.__init__(self, name, parent, shell)
+        configshell.ConfigNode.__init__(self, name, parent, shell)
         self.cfnode = cfnode
         if self.cfnode:
             if self.cfnode.attr_groups:
@@ -704,7 +704,7 @@ def clear(unused):
 
 
 def ls(unused):
-    shell = configshell.shell.ConfigShell('~/.nvmetcli')
+    shell = configshell.ConfigShell('~/.nvmetcli')
     UIRootNode(shell)
     shell.run_cmdline("ls")
     sys.exit(0)
@@ -737,7 +737,7 @@ def main():
         return
 
     try:
-        shell = configshell.shell.ConfigShell('~/.nvmetcli')
+        shell = configshell.ConfigShell('~/.nvmetcli')
         UIRootNode(shell)
     except Exception as msg:
         shell.log.error(str(msg))
-- 
2.39.5


