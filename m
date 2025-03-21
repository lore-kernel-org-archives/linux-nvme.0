Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4AC35FFF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xzhwCZqMOq5fF3CHp7zUvXSFe+72miiIEWGPuixnRxY=; b=VUJJZ8KMBkJq9dtAyGIa2oTlNs
	dB6CReEP5VI/T2CkksgTTt4/yePSFpsYLZ+o5+o4RU4sTcm6jWehqwNA/JBAs9BUlrvNsqEKHUK2T
	m58wnkIe3RpCCsB2bPiH/UZheCgJ9IGdcBTlrPG7t8/xDiZCdguf+xhmpjDJWyO6FUo/K3gI9ZlW3
	GoiDWOYw8egdEDUGcUi32ji3yKUufmBx5xly6yC0SzcU+vYp1HID4XDPYbKJQPDnF9uaNgSd7SP15
	A1S9S2bz+pThLS5RegLrZdskTG/jdsq0ZrKrGVR+/xSSJ75uCRKicyv5tzKclk5sosC8geC9k1Inr
	2IIXTtnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tva61-0000000EbHq-2EDr;
	Fri, 21 Mar 2025 10:59:25 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tva5z-0000000EbH9-0xwO
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 10:59:24 +0000
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	by smtp-out2.suse.de (Postfix) with ESMTP id 907CA1F78F;
	Fri, 21 Mar 2025 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742554759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xzhwCZqMOq5fF3CHp7zUvXSFe+72miiIEWGPuixnRxY=;
	b=gkQAivH8V1TDDsXn1sFHa97n/IEzoP6EHBvqISTHjyj1SiZN6CnluLIUyx9NUba6e2n2Nv
	STQ88BKIYrs57H5xRNFgAA53QeT5wcdxS6t4Q3h++vRZFnjlAVhNF37qCGIaUIQXPi7h8Z
	ZwbEZKICbB7ffHhavg6/BizkaPkKWhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742554759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xzhwCZqMOq5fF3CHp7zUvXSFe+72miiIEWGPuixnRxY=;
	b=XnUc3MpR2XMWFDfOo0Yx2pL4XhRkDnxOnxpt4RlBN2702dj3mKSRc/5gsfAF99z4v2y/J1
	TSYVTjwlLBgBRnAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742554758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xzhwCZqMOq5fF3CHp7zUvXSFe+72miiIEWGPuixnRxY=;
	b=17ZZnkyRsbKXF8dy20jTktYl/OTBPlX2S1VrZRmUwTlAx6Rh8b0vvryOkNFShVXpgyJ3Um
	V+erF7+GMUK9go7Qjoetht+VVPeM93oXEUxTipO65dV4xFCuxnruKCTr5Kj/DnYl/tD2Lz
	nIPYVo19WoMPjZFcCnXuuzNQbloacWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742554758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xzhwCZqMOq5fF3CHp7zUvXSFe+72miiIEWGPuixnRxY=;
	b=eWS3IFLZlveZgzMgCMnX2BxZ/2eOFVsrAtkWYBvEJCemLThvHSWJNG/9bL5zeH4x86UCPD
	844JQhX75rrKGuDA==
From: Michal Suchanek <msuchanek@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] When kmodpy is not available call kmod binary directly
Date: Fri, 21 Mar 2025 11:59:10 +0100
Message-ID: <20250321105915.8971-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.72 / 50.00];
	BAYES_HAM(-2.92)[99.67%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kitsune.suse.cz:helo,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250321_035923_413655_E19403C4 
X-CRM114-Status: UNSURE (   8.68  )
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

kmodpy is an unmaintained project. Python is not really good at
backwards compatibility. With the upstream project not keeping up with
python churn using the library is a maintenance burden.

nvmet does not use the python library in any substantial way, it only
loads a module once. This can be easily accomplished without any library
using the modprobe tool directly.
---
 nvmet/nvme.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 59efdb5b7c1b..397f103abcdb 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -256,9 +256,20 @@ class Root(CFSNode):
             # Try the ctypes library included with the libkmod itself.
             try:
                 import kmod
-                kmod.Kmod().modprobe(modname)
-            except Exception as e:
-                pass
+
+                try:
+                    kmod.Kmod().modprobe(modname)
+                except Exception as e:
+                    pass
+            except ImportError:
+                # Try the binary specified in /proc
+                try:
+                    kmod = None
+                    with open('/proc/sys/kernel/modprobe', 'r') as f:
+                        kmod = f.read().rstrip()
+                    os.system(kmod + ' ' + modname)
+                except Exception as e:
+                    pass
 
     def _list_subsystems(self):
         self._check_self()
-- 
2.47.1


