Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E60C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 12:48:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA02422250
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 12:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kob59Vs0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDQ1cUEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA02422250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ia/ly74/q85KH2JQ/Iu8Oxd+6ZeuxTESMy48VVDITV0=; b=kob59Vs0UmnbWrtA8IWyRAa0TG
	JyqH0J7j4XhHJqvY0jistH5qbE5+pN2sTPRIywHPNjzZtmHn+lWW0cGI5rgrT6onYBL6+xHxSQKra
	VAr9GqwWsMzIBW5x3Uql/TByGg9v7OovNQ80OcHl0uhVdELEjczNVqGUgA5AZ31w3tnz38K32Sxl4
	Wf9p2d5a/SlHDza+gSxTd4aM90B0V3XZc/qcerVlz4khIviAGYukLrHzwwGd8GUa5Az8fU3XhWwfy
	XXlopbGLKT+sc/qFeQeT6bEo3O/f1qp0JuSt2M8prN93YEczLZFdVxC8d46+0RyZ1yDVRc3yNGGbM
	G28dQ6bA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUr3P-0004qy-7U; Tue, 20 Oct 2020 12:47:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUr2h-0004Up-Ga
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 12:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603198021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=egZs/qcpoMu+zDmwfXuj/88im59HE0TkmYDMMGqJry0=;
 b=VDQ1cUEy1vNERThUyqm6FPO2AXiMuhiTF7sGVWi2lZCfMHCZWvF8caRXy+wlaYkaOjiKfG
 DHzF1GXiM9C3XOSsZk1i8lZIDIa4fGfbYcBM8cynlJb7LQhnzlmW36JfMD2AXoqRTaZC3Q
 txzd0jWSrXyP0Okws3EJya83PVTD2Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-a1WQ-4huNqKiMeIMsiGi_w-1; Tue, 20 Oct 2020 08:45:42 -0400
X-MC-Unique: a1WQ-4huNqKiMeIMsiGi_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61BF1879517;
 Tue, 20 Oct 2020 12:45:41 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDCE75C1C2;
 Tue, 20 Oct 2020 12:45:39 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH libnvme] examples: Add src/ into the include and library path
Date: Tue, 20 Oct 2020 20:45:31 +0800
Message-Id: <20201020124531.238269-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_084708_011554_0D38BC09 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: kbusch@kernel.org, Han Han <hhan@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

That will fix the compiling errors like:
     CC telemetry-listen
telemetry-listen.c:21:10: fatal error: libnvme.h: No such file or directory
   21 | #include <libnvme.h>
      |          ^~~~~~~~~~~

Signed-off-by: Han Han <hhan@redhat.com>
---
 examples/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/Makefile b/examples/Makefile
index be867a7..24f8574 100644
--- a/examples/Makefile
+++ b/examples/Makefile
@@ -1,5 +1,5 @@
 CFLAGS ?= -g -O2
-override CFLAGS += -Wall -D_GNU_SOURCE
+override CFLAGS += -Wall -D_GNU_SOURCE -I ../src -L ../src
 
 include ../Makefile.quiet
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
