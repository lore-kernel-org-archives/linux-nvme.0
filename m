Return-Path: <SRS0=dgXS=5F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F268FC4332B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEC820724
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2020 20:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FvHs+76P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS2/6+vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEC820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DRmAMPl+C+MVV3Kb4TI9vGruqsDExKicaB1iTKh4Vl8=; b=FvHs+76PM4LUHs
	9H7qccY/knNnXMo6ML6Ep/R9e7a9UumxHOxJtVr/Qv6u6lQjxrI9MNWpa/M4tX9Nut1+UwzapcUGa
	HsKLxvdbZbG6gepIgq8JVUvQ7ec4S+gMwHy8I+RU0+hkoMLvXCYVYYQYvM7ke/kwSWd97MRhxig1B
	B+GWc+5hiFukx02lohY9arGEMQLUg/J9R3znr3z9mQL+RqxupV9T5EMrJuXstqiChz4qWY6pWmTpf
	ofO8lXi4deTkFQIvDmYoKG90L0Nt7R9UCN+ZfBVrKuX1wlYTo7RyqPyudy7b3/qXBVT4a9tCfNI91
	MfVFkEp8EznXXVYHzTww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jFOTd-0008Uj-Af; Fri, 20 Mar 2020 20:42:45 +0000
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jFOSx-0007u5-HM
 for linux-nvme@lists.infradead.org; Fri, 20 Mar 2020 20:42:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584736922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHTFdewOSa6ExpsiH20++OYTIzKUgfFmPBm33jtmMiM=;
 b=CS2/6+vlWpgZGGwj9kUFiLa+iNoZSB1rxAdhLpi+NRv7n2R0MEeH7bPNfd27gDIPg0ECNT
 eRttKfXJsJGQmT+O5d2sYTtElIgBcCQWEGGxdsjfee026rPpDcnoTthA8kizIMeUGWgW9Q
 fGocYHQtFxBVBZ44XGf7FDdw7vmT1tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-ly9CsD0uPxWsINsrEUh8Jw-1; Fri, 20 Mar 2020 16:39:51 -0400
X-MC-Unique: ly9CsD0uPxWsINsrEUh8Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF2C800D4E
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:50 +0000 (UTC)
Received: from sulaco.redhat.com (unknown [10.3.128.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7211290817
 for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2020 20:39:50 +0000 (UTC)
From: Tony Asleson <tasleson@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/6] nvme.py: Explicit close is redundant
Date: Fri, 20 Mar 2020 15:39:43 -0500
Message-Id: <20200320203946.37338-4-tasleson@redhat.com>
In-Reply-To: <20200320203946.37338-1-tasleson@redhat.com>
References: <20200320203946.37338-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200320_134203_655903_B9799191 
X-CRM114-Status: UNSURE (   9.60  )
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

One of the benefits of using 'with' statement for open files is the
close is going to be called regardless of what happens.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 nvmet/nvme.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/nvmet/nvme.py b/nvmet/nvme.py
index 0647ddc..55c3930 100644
--- a/nvmet/nvme.py
+++ b/nvmet/nvme.py
@@ -302,7 +302,6 @@ class Root(CFSNode):
             f.write("\n")
             f.flush()
             os.fsync(f.fileno())
-            f.close()
 
         os.rename(savefile + ".temp", savefile)
 
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
