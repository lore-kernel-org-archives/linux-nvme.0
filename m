Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1E8C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C8264DF2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 02:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C8264DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AL6mMB+k6XtoHnOu9JaP32mUoI87kMxZ7XaQmfWLEBg=; b=s39kMAIUCg04ofOP6kLHN5r/Jr
	aIsGXjDJ33dcXxLwsQa4tPyXLcVZPX5A1ssrHdwTaTyxgLdOo5DLKyo9hLeDXt63gxtQ+bZpwb+Ac
	O95tpwSP3NVxqgCaj+06EKBqoAXYLkvNK4f6UixK/DNaWaEuVBd2QRu1G15apTvWZxsQb80VGKQaC
	DTxvJ6QD1KtsK+T1FX+RSmpbouaiU1/a/HGog7PXeYrm8tY2jduWjYrKN6R1zsm0ZNYGaO6puPgm7
	9X1CiLPWcfjvHzWkN0JSYHm3DAHxIGc1heH8G1U5ZhKXUs6ItEph/uj3Kj9nW5CKM66yCLdb6tsIY
	CiOH3ARA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGXx2-0004O9-Iy; Mon, 01 Mar 2021 02:06:24 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGXwv-0004Nh-VR
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 02:06:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614564378; x=1646100378;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xE+IQP3R7Vccua+R2+i5aJCb9USbTk8KxdqxBfG0TCs=;
 b=IXdYYhcXEjmaNLIojUT3OEKjBlpmHsoy/VrnEWCtqYnHY2m9eXdOQQ3H
 iz9DVhIhbdM/5rJ8wIn1MOQSZv7GXJ8KjJBK0Eh96asOpDqpa+prs2cNd
 8bTIbLOCcjmI0GWBWyVpcXAEWPEl+NOFpwBP++5Yggd/4biCieB9RLINC
 x73DyqJ/JMGdmmnc7gk4fNrASvVGbkqHeK17zvJwuIKQcFx07Of1DPJ3x
 CWfwtQz5hiBsN1LA/seISHFNdybBBz5DFC/IH4jhH1phW55wKm4fB2gJE
 kOwUyti+tX4ouceSPSfdtjNqYxVKJThJlPXLT1K12Wu/lZJ2DOpORhKkb A==;
IronPort-SDR: V0VMFnxGkwLYaZpEUDbbSMd95NyPj5pgm9XhdTavJa9VwmHQwW5Us7MxOZWyqgzN2EZLCKhQTE
 noBngwGp3FLRnjuetvReQO2lnyne2aZ0Nj7c0eviPYG0dtLh5HpdSnlf055L2csLEsF0sbM9YA
 UPW28DYoix8dU3yC7g6+AaGPTGknBSjiRAyZ5DE6UW4EIiOeVoJGTkmTm0tycuDElhuwPWnKHe
 /O3nsKT3Hxxdjc3JBoziMc+6FA1NXelm/lndtT5uExTuy7JtU0aFvCFxDHWzjlnUZIQAQpKqMa
 seg=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; d="scan'208";a="162191577"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 10:06:14 +0800
IronPort-SDR: Rbjz1HUZJNR755Y6bUFK+UmpP2g/xxRK/MJS+8oyz2BcII1SbTBEcQTlJsaRMzFOJbbP26FO/t
 lHTBvaly6ilpDGMBFrIzTHQW/EsFqXxzVjoKhVRtsiLFBfcbxyjzlJlKoFAGYwZ0aW2Xzj6g4D
 djWz/xl6cXyrG+SBDt88mO52ATuxVZdc3JabwEVvffzMOx8vRlhzggQ7VskTuGiajkw67H8NgO
 DCyHNLpbKM9bfXaeDp5jhLeEkBBQkkq16Ptai4xS6uaTgX0uJQ67lbL5NPQAtyys3Fzlb1garX
 xFE72voHwdYd7k9nmQBi9W8e
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2021 17:49:22 -0800
IronPort-SDR: wOxRR/Otv5wruR7u7SWy7190RJ+sYfPL3G0qSMUUREzzrHg5puLroo0n1zXYoqcivKtxInxdfm
 4xMTC0+9SUnWYjqU1TOhjuuFTuNpl9wJ9tJeX7ffR6BkIrp8H73mXpDczJbpfYeVMTxRlDtCDy
 5TFF/3zbD5bPj5A92N4kge8HtpVWeoSVT4JzIn0U6i44kLFdeLTc4QJr9PPu77FfHqflOQqCqk
 kdZhsfVp4FwyWquOOIJAOi6IzdZNGFX3KjL8VtFM6Ze4JFCUlLErpKVNiOjhKR+kZnF30pNwsC
 +1s=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Feb 2021 18:06:14 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/8] nvme: few cleanups and small improvements
Date: Sun, 28 Feb 2021 18:06:03 -0800
Message-Id: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210228_210618_241792_AFC95676 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpUaGlzIGhhcyBmZXcgY2xlYW51cHMgc3VjaCBhcyB2YXJpYWJsZSBkYXRhIHR5cGUsIHJl
bW92aW5nwqBvbmVsaW5lcgp3cmFwcGVycyBmb3Igc2luZ2xlIGNhbGxlcnMsIHJlbW92aW5nIGR1
cGxpY2F0ZSBrZnJlZSgpIGFuZCBzbWFsbAppbXByb3ZlbWVudHMgZm9yIE5WTWVPRiBQYXNzdGhy
dSBmYXN0IHBhdGggc3VjaCBhcyBsaWtlbHkgYW5ub3RhdGlvbiwKcmVtb3ZpbmcgdGhlIGV4dHJh
IGNoZWNrcywgbWFraW5nIGZ1bmN0aW9uIGlubGluZSBmb3IgaG9zdC9jb3JlLmMuCkxhc3QgY291
cGxlIG9mIHBhdGNoZXMgZml4ZXMgd2FybmluZyBmb3IgRkMgZnVuY3Rpb24gaGVhZGVyCmRvY3Vt
ZW50YXRpb24uCgotY2sKCnYxLT52MjoKCjEuIFJlbmFtZSB0aGUgbnZtZV9pbml0X2lkZW50aWZ5
KCkgdG8gbnZtZV9pbml0X2N0cmxfZmluaXNoKCksCjIuIE1vdmUgbnZtZV9pZF9jdHJsIHN0cnVj
dCBpbml0aWFsaXphdGlvbiBjb2RlIGludG8gc2VwYXJhdGUgaGVscGVyCiAgIG52bWVfaW5pdF9p
ZGVudGlmeSgpLgozLiBSZW1vdmUgdGhlIHBhdGNoZXMgdG8gYXZvaWQgZXh0cmEgY2h1cm4sIGtl
ZXAgdGhlIGZjIHBhdGNoZXMuCjQuIEtlZXAgdGhlIHNtYWxsIGltcHJvdmVtZW50cyB3aGljaCBh
cmUgbmVlZGVkIGZvciB0aGUgcGFzc3RocnUgY29kZS4KNS4gQWRkIHByIGNsZWFudXAgcGF0Y2gu
CgpDaGFpdGFueWEgS3Vsa2FybmkgKDgpOgogIG52bWUtY29yZTogcmVuYW1lIG52bWVfaW5pdF9p
ZGVudGlmeSgpCiAgbnZtZS1jb3JlOiBzcGxpdCBpbml0IGlkZW50aWZ5IGludG8gaGVscGVyCiAg
bnZtZS1jb3JlOiBtYXJrIG52bWVfc2V0dXBfcGFzc3N0aHJ1KCkgaW5saW5lCiAgbnZtZS1jb3Jl
OiB1c2UgbGlrZWx5IGluIG52bWVfaW5pdF9yZXF1ZXN0KCkKICBudm1lLWNvcmU6IGRvbid0IGNo
ZWNrIG52bWVfcmVxIGZsYWdzIGZvciBuZXcgcmVxCiAgbnZtZS1mYzogZml4IHRoZSBmdW5jdGlv
biBkb2N1bWVudGF0aW9uIGNvbW1lbnQKICBudm1ldC1mYzogdXBkYXRlIGZ1bmN0aW9uIGRvY3Vt
ZW50YXRpb24KICBudm1lLWNvcmU6IGFkZCBuZXcgbGluZSBhZnRlciB2YXJpYWJsZSBkZWNsYXRh
dGlvbgoKIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAgIHwgNzkgKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgICAgIHwgIDQgKy0K
IGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCAgIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS9ob3N0L3Bj
aS5jICAgIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyAgIHwgIDIgKy0KIGRyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jICAgIHwgIDIgKy0KIGRyaXZlcnMvbnZtZS90YXJnZXQvZmMuYyAg
IHwgIDEgKwogZHJpdmVycy9udm1lL3RhcmdldC9sb29wLmMgfCAgMiArLQogOCBmaWxlcyBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMoLSkKCi0tIAoyLjIyLjEKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
