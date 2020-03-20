Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C45C4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E0A20775
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wc2bKmEF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAzy8zOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E0A20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lu/QLJ+VNUU4HIJ3/n35T1vAKlJ7ogIC8mmoL954Gq4=; b=Wc2bKmEFJOl0Ga
	bBqRDq3hreFfrCfD6sIvsfbRQXw5JSntOFZgdYeNvCK2l2oO/IBTAjPpBo7IKoH3jjvATpG6vUBUQ
	027uJkkp63HiHOzy57+DI+n7sB1qM90cI2sO48Eey+btkx22qGTjwOmUE1UymMEGt3D1uL/Qys5HA
	I4502lXGq/lZuYGziY3svAxEj9UYuTcduN/04RvL+KzRKZPCwQt/ppH1VIOiDGo3UU/C+65k/HS8X
	KWg3l6jayYM/Ofsyo10RC1ut1G6VwKiDlZAku2fw93v52+Lnkv1OVTuWKMdLDobY2SQaRHYB+Qyxj
	UfFrUkknil8DVUiT9okQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFOTJ-0008Ci-6w; Fri, 20 Mar 2020 20:42:25 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFOSe-0007RH-9t
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 20:41:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584736903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uK+Bi0rLGkqGmx7yn6Q0n8W2vaLN9LcnyaifdD/2VHY=;
 b=IAzy8zORHdde6yFY1l3B4fSPhC4Ja8advSwLYMSRcPQpH/BpAtB9OVdmUQp64BhRhELX/w
 +yAXqfzJFDLpEyy/SibYONnHizWtYviPAqDFmpfoItfV1Zy3DmMod7MjafHTIqR0K30YC/
 4cC0jrnW7NKMMZwczjKJRZSyJ1UDywo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-PvKnoN9jMwWycyN62IxOEA-1; Fri, 20 Mar 2020 16:39:53 -0400
X-MC-Unique: PvKnoN9jMwWycyN62IxOEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6353C107ACC4
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:52 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2BFD912A3
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:51 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 5/6] nvme.py: Make modprobe work for kmod lib too
Date: Fri, 20 Mar 2020 15:39:45 -0500
Message-Id: <20200320203946.37338-6-tasleson@redhat.com>
In-Reply-To: <20200320203946.37338-1-tasleson@redhat.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_134144_414711_87E6E688 
X-CRM114-Status: UNSURE (   9.42  )
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
