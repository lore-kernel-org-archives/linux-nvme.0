Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E7C5517B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84EE922250
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMF3Za7x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT8djA4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84EE922250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cqAi+WwppMFcIvbnbaUYAk2vOe0ZrJxadLdnHbg3jFs=; b=hMF3Za7xYrPRl4d0N/dy1D0pS
	KtY8SO2BYg3VX6Tc8b/QcWIs9dVyoCDHFpIUbCseoBhVUWMITw99VgjfZv60cyZuV0mRh5WnXGkc/
	OMZ9cuOwdDjHPc/OJBLjpSAKHj1M3JP6khT+TUubinjOEW1B+46thjuZzVBiVNkl3WM93ZCJ43kUy
	zOsC6PsiZHy8dp2ORE70C/eg6ZJGs5BKbjEB1fBjxJPqACHzV01gV9XIOLSCUWyZuC4bYwIOLtkQT
	82sdu1trz5mcNTb2eO3L1vEYRhOlQIskHZiwa0CLcyi+dN9WA3FDqnreFxkxa+ctlyvrCaCkP7TAb
	8w4vAwdMQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUs1G-0003X5-50; Tue, 20 Oct 2020 13:49:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUs1D-0003Ve-GJ
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 13:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603201778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSHBV+RhMPICPivmMhzJc3c+xygfJXcloRWwOn6EEBY=;
 b=fT8djA4G70jnAQJ5dALbVHXgU7LNenFGNxeXD6EhaF1gJ7Ctr6wcoiU3Hwed8RxmLhcoA1
 drk8BvN5814l2IVsWXDKe2LoXnkYeBzeXWFCajySNSq3EpR8EH5nvWrTnfYWrrDzomJSWR
 q+mHY9sVNdKw6jlv4YZTiX3KoYmtWYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-CzncL7ruOHWtpkUOMqnF3g-1; Tue, 20 Oct 2020 09:49:35 -0400
X-MC-Unique: CzncL7ruOHWtpkUOMqnF3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21CFD1019627;
 Tue, 20 Oct 2020 13:49:34 +0000 (UTC)
Received: from localhost.redhat.com (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9856E6EF40;
 Tue, 20 Oct 2020 13:49:32 +0000 (UTC)
From: Han Han <hhan@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] spec: Fix the sub-include dir name to nvme
Date: Tue, 20 Oct 2020 21:49:21 +0800
Message-Id: <20201020134921.270042-3-hhan@redhat.com>
In-Reply-To: <20201020134921.270042-1-hhan@redhat.com>
References: <20201020134921.270042-1-hhan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_094939_602247_B72548C4 
X-CRM114-Status: GOOD (  12.64  )
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

It will fix the error of "libnvme/ dir is not found":
$ rpmbuild -ba ~/rpmbuild/SPECS/libnvme.spec
...
error: Directory not found:
/home/hhan/rpmbuild/BUILDROOT/libnvme-0.1-0.x86_64/usr/include/libnvme

Signed-off-by: Han Han <hhan@redhat.com>
---
 libnvme.spec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libnvme.spec b/libnvme.spec
index 80d66e9..9708084 100644
--- a/libnvme.spec
+++ b/libnvme.spec
@@ -39,7 +39,7 @@ for Linux-native nvme device maangement.
 
 %files devel
 %defattr(-,root,root)
-%attr(-,root,root) %{_includedir}/libnvme/
+%attr(-,root,root) %{_includedir}/nvme/
 %attr(0644,root,root) %{_includedir}/libnvme.h
 %attr(0755,root,root) %{_libdir}/libnvme.so
 %attr(0644,root,root) %{_libdir}/libnvme.a
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
