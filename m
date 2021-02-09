Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB96C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A80464EAA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A80464EAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QVmoVfJyv5Uy076ZCcwCmE39T40iP3H4NrJJPI6+3cc=; b=YK1gYC0YsBZmfV66biCANPDKL
	tl4yol+zNOYU/GQDOarnQuDzdx62qclu6TarJfuD0m4Bd3jQLpRadyh7jIlC3c+FyzpVouSSZEXyR
	KdEeor+fEMCQlL7W2CjmY3h13cGh5pBxfXEoKEIrn0++Yf7UJW/elNh+bRR07Q4aOTd+Lg1eDu6i7
	dt9VLMTaoDQbYy6eu+oGq3+2X8IfbmW5+kw5m4xwvS6SMHDkafAEerEAdAeyKcil0R9Sjm8QLlbIx
	rFCzoDPVqc+wSTpllmmakRkYbViE+oaxEpLeoliq0CkWEAFeqLY37aslLtwPdP1L3IzI8ya3/KhP9
	cnd5utPPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KL5-00037X-00; Tue, 09 Feb 2021 04:09:23 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKj-0002x8-T3
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843741; x=1644379741;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZMFIjq/D8g27gEw+tEHJS6OWJntYoNbVSk5eHeJjEsQ=;
 b=Ej1cubzm1OU6BDAh2DGVTCb7PO56Gf6hj4lx2se6e/SbdgW4p4cVMCNk
 P4+Aq/BSXBtG4oDf5X5dI/QvsM2YjXYPPozvYGGydY3MUvR9chXw928lj
 akF/rvVpf/kqJEo7eHVFiujfSkDj+4JAIKWGrFywom/DmLyRHPuUGb5sO
 0kRElYhbe17L9PjJYhypEUuCkz3MwSssrh73DUUtWvzfKPJiFdcc6mbEI
 gVcpPH3cIv8nK/doeWeo0dhIaJ1iOvqMmjkZMKCrVn09+3hTGn2zRP0Nm
 vWTOcCw3cVqdZKBsJSP5Rj7JQZHV+flKf+Jl9a8JTIjbBO4QcUXsD4eUD Q==;
IronPort-SDR: Y4XtmH3HBfpi40AsNpfb+JTwWxT8jTMCVF5HLnjPvYBLKv4HyLvpFAx0vsKKcIF6rOC6EHrBkQ
 nDtR4KuwgJNhY+Q4og53TqCvVXzHoYiKNA1/k0QeUr5t5/lR8EGHwiop6RtwNLESN9eIEUIDda
 b05HZWXdv4Co0ggW2s5omX0+9nXAoenpJXIQ/svCkdiaR/qfyXQkzsmGIK2s9KYwUaSAjWhsHF
 MeWJ8xOq2evEkB7YhH6WrhC4Dhd/ItxCd3NmvSXDxzuYn5yRZ3L+s13o7gXnBgfiSv17ZUhsJG
 yq8=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970525"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:09:01 +0800
IronPort-SDR: TbpWVzJdqCteYyOQWplwZB9bQKdU7X4Nq4B+61KB+ibpD6m2jDvgEieMUoTM1StuyYKKwO5cKw
 jQR3d1pKgjMqdJ0UA+UXLNFRRR4RqfvYO74KYMKJ9Qf34htpMfZKPoQmXnmlw4zAA9O2tkQCUC
 nLMNV5aJ8EKCYP1oCfzyesoW6zxrQtt1k0SzYFWoUdUdhfWHoP/hGng3b9CrZZCTywhPghE897
 TjQ8QzawonjaMUvGMj4gIMrOvO+msQ9TyiLsHezmIkR54apIilCApr1K0slQEm2pVjebaJSQxi
 4P81CBH/7knKhB0euT/bBF4Z
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:54 -0800
IronPort-SDR: LjSiiM0wwHVyxDLko70jSBoya5qIuPhPNtnKOH/mUIQwe0g8sixGK8kKtDy/M2Qk6Jr7xJo+u0
 IlyGjVKN2jMgtnooyQbHHKgig2MNhOHa3jtqFfET2YgORKE8DcOP346ojZRVU5Gd/J4hqE4X1h
 fV/sq2Bq4rE6KgO2SPzzUtOHUbu+r8J6qLFQHP1IfthV6nXD+X7oloHk0lVGl2oYo+wPp/gtAl
 7HGzBY/m2o+g4E4FivxTU+/XezwKSYM8TVk2SBRXQDJx5f2GRr4ggo6sJsngLBjF+EA5nfOr0V
 FwY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:09:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 09/11] nvme-loop: rename variable to get rid of the warn
Date: Mon,  8 Feb 2021 20:08:41 -0800
Message-Id: <20210209040843.45572-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230902_314155_EFE439D0 
X-CRM114-Status: GOOD (  13.17  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

UmVuYW1lIHRoZSBudm1lX2xvb3BfaW5pdF9yZXF1ZXN0KCkgbnVtYV9ub2RlIHBhcmFtZXRlciB0
bwpod19xdWV1ZV9udW1hX25vZGUgc28gdGhhdCB3ZSBjYW4gZ2V0IHJpZCBvZiB0aGUgZm9sbG93
aW5nIHdhcm5pbmcgOi0KCmRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jOiBJbiBmdW5jdGlvbiDi
gJhudm1lX2xvb3BfaW5pdF9yZXF1ZXN04oCZOgpkcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYzoy
MDU6MTY6IHdhcm5pbmc6IGRlY2xhcmF0aW9uIG9mIOKAmG51bWFfbm9kZeKAmSBzaGFkb3dzIGEg
Z2xvYmFsIGRlY2xhcmF0aW9uIFstV3NoYWRvd10KICAgdW5zaWduZWQgaW50IG51bWFfbm9kZSkK
ClNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdk
Yy5jb20+Ci0tLQogZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L252bWUvdGFyZ2V0L2xvb3AuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jCmluZGV4IGNi
NmY4NjU3MmIyNC4uODhkMDY1NmFkNGE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0
L2xvb3AuYworKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2xvb3AuYwpAQCAtMjAyLDcgKzIwMiw3
IEBAIHN0YXRpYyBpbnQgbnZtZV9sb29wX2luaXRfaW9kKHN0cnVjdCBudm1lX2xvb3BfY3RybCAq
Y3RybCwKIAogc3RhdGljIGludCBudm1lX2xvb3BfaW5pdF9yZXF1ZXN0KHN0cnVjdCBibGtfbXFf
dGFnX3NldCAqc2V0LAogCQlzdHJ1Y3QgcmVxdWVzdCAqcmVxLCB1bnNpZ25lZCBpbnQgaGN0eF9p
ZHgsCi0JCXVuc2lnbmVkIGludCBudW1hX25vZGUpCisJCXVuc2lnbmVkIGludCBod19xdWV1ZV9u
dW1hX25vZGUpCiB7CiAJc3RydWN0IG52bWVfbG9vcF9jdHJsICpjdHJsID0gc2V0LT5kcml2ZXJf
ZGF0YTsKIAotLSAKMi4yMi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
