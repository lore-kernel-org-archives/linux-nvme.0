Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B1C388F9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C9722249
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zUlkSI7e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGvFVTl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C9722249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EQ7lMtkzTlXIlMbD+nsoJhWdhGv9V4Wm6QouUs1y9E4=; b=zUlkSI7ewjjqbLGSke9RtNFJR
	B6XJ6G7zQXZPhS8ONA2InGPuhFvpa1eP5JzSMu1s21sk2jtjI0begFWics8SHslaq60i/wxduZ4JW
	IRmMafeykbmNFfcfcuICcJQEaaWnMngRNHLuFLHwMiaid4QgNpkWRUmab5cFBGmr2CmXc2OA2Mj10
	ViH/er9Yq6TZvAyY2ntwViXywDt6ntS6Ua1MIQJFGGH4+aM9TX+2PppM1pQtdTbvd+FVV0XqMTSpS
	XOLJ3a+3UVx2i3blrIWFoeMET15N+emD1mbS+Cp7Dt6V7iADqyN8O7pCsdEdVaTviygUcggER4NgQ
	My9pM/iYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUs1C-0003VZ-TJ; Tue, 20 Oct 2020 13:49:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUs1A-0003V4-IY
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 13:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603201776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nAXV1Ru5rRo0D90vUO3BXwE0Hv31i/M7x5FNx1tPnk=;
 b=hGvFVTl482fUk9rxxJVaDjUuichVxlI0GVcs8T1E0DDdfQzhq63RVmkUPZijXzrolBzctc
 uySn6t0mtHer+Raq9vQcQTZK3iaNR5a81yKNfCHeOwXQBewVkvHojqD4wSX9pSd/Wv5+PB
 79MYnXKznx/y2Ae+KmuZJnZuHboltoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-QvmM_jcSMH-t7XunPUYvVg-1; Tue, 20 Oct 2020 09:49:33 -0400
X-MC-Unique: QvmM_jcSMH-t7XunPUYvVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 198CE101962D;
 Tue, 20 Oct 2020 13:49:32 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B73976EF40;
 Tue, 20 Oct 2020 13:49:30 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] spec: Use the correct url of libnvme
Date: Tue, 20 Oct 2020 21:49:20 +0800
Message-Id: <20201020134921.270042-2-hhan@redhat.com>
In-Reply-To: <20201020134921.270042-1-hhan@redhat.com>
References: <20201020134921.270042-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_094936_667796_4673E06D 
X-CRM114-Status: GOOD (  11.94  )
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

Signed-off-by: Han Han <hhan@redhat.com>
---
 libnvme.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libnvme.spec b/libnvme.spec
index f3407d8..80d66e9 100644
--- a/libnvme.spec
+++ b/libnvme.spec
@@ -5,7 +5,7 @@ Summary: Linux-native nvme device management library
 License: LGPLv2+
 Source: %{name}-%{version}.tar.gz
 BuildRoot: %{_tmppath}/%{name}-root
-URL: http://github.com/linux-nvme/nvme-cli
+URL: http://github.com/linux-nvme/libnvme
 BuildRequires: gcc
 
 %description
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
