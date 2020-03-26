Return-Path: <SRS0=sW0/=5L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFBAC43331
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBE320714
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Mar 2020 18:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OskNknsB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1nbszgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBE320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lu/QLJ+VNUU4HIJ3/n35T1vAKlJ7ogIC8mmoL954Gq4=; b=OskNknsBbU+mVr
	JGWaAEAQQtBnt2fNrlzp59AC0JP9Uacs0XNtLl7MfkBEVo9GxFtwYhfSWIH2iRs94RU+In4aok3Ts
	SNTaT6nZ2nCl3ZG87tFa9hyzSy5+LpVqgBw6cO3IxW5QW1F4J/PPHlWLOU5dM3a0w2lDE1O+eASch
	erg2mM/pQuGTu2Ft3kLfP5noX648uiVZ/K2DrDM/sAjgwV4eZ3gcqC16DEKVG+yscs/MUd56XVVQ9
	AodT3knSmzScFLXXGbocPleF8MsiN0gbLARAECpM2p/X8phoKEU1fLQk54XvyUBA6I9C3ns7t1gWn
	IgWiyMIN/HkAt97OOxWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHWvJ-0006k1-5E; Thu, 26 Mar 2020 18:08:09 +0000
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHWvC-0006ev-Mb
 for linux-nvme@lists.infradead.org; Thu, 26 Mar 2020 18:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585246080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uK+Bi0rLGkqGmx7yn6Q0n8W2vaLN9LcnyaifdD/2VHY=;
 b=J1nbszgUpGUz+qP8FK4Bq5k9tyTuhsRopOwjyvBQnSJWeJMjkywW0iKVCy9Rqs6TN0x7TA
 /A8/EDBGqRX4s/usaAp32IoPK9LYfQ+XheGBPpE4UPZOfn6clFfWP1t+P4+tmM1wuunl7g
 wo9afuizMw0wtY5i7qB1Im3uuVx7zIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-j-pJMTC3PWWZtRI3BEtEDg-1; Thu, 26 Mar 2020 14:07:58 -0400
X-MC-Unique: j-pJMTC3PWWZtRI3BEtEDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8364C18AB2C5
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:56 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13BF119C69
 for <linux-nvme@lists.infradead.org>; Thu, 26 Mar 2020 18:07:55 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 5/7] nvme.py: Make modprobe work for kmod lib too
Date: Thu, 26 Mar 2020 13:07:48 -0500
Message-Id: <20200326180750.469346-6-tasleson@redhat.com>
In-Reply-To: <20200326180750.469346-1-tasleson@redhat.com>
References: <20200326180750.469346-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200326_110802_820359_8C509E60 
X-CRM114-Status: UNSURE (   9.77  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The python library 'kmod' is included with libkmod, lets try to use that
if the user isn't utilizing kmodpy.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmet/nvme.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 4817124..089bafb 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -253,7 +253,12 @@ class Root(CFSNode):
             except kmod.KmodError:
                 pass
         except ImportError:
-            pass
+            # Try the ctypes library included with the libkmod itself.
+            try:
+                import kmod
+                kmod.Kmod().modprobe(modname)
+            except Exception as e:
+                pass
 
     def _list_subsystems(self):
         self._check_self()
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
