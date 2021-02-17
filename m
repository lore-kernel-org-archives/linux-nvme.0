Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7CC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D608364DDA
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D608364DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m+w/9aq8K0xx800LsPygcZ5qmYn/Afa6Gp+CIBPzcOQ=; b=0vycvBhCURzIe2QpEfFlDldBHh
	JaK4VOtlR6qMVl9IJtSnM74Q7EYLDdvYx7pp9mwtijt4OuH1nSNuwLIpf/lQYKIDMjdj83kOeB4B6
	9rgSHo/0HXoZt/QriOXAwpH0ZAU9nZ+qiZ9WJPIwj23ReosXAdz26InwiO9zo183U327sosaxaTmv
	iT4TgNTdt76YBK+o2uwg8SKe6ocVNWUZv2oa6Lpi5gBccE8brVnimb3ZfTi51PLVrVfDFgLOJzqNN
	uiZqiu12j6vtXqTAxp2e+A1DYWw9EfgPdRJv2bCFpnaloLfS3e20C9E/JYaDhQ7/cWWy3PePwno/P
	JyhTjxoQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAQT-0007UT-1A; Wed, 17 Feb 2021 00:10:41 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQP-0007U8-P5
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520637; x=1645056637;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NDcs6HLM0TUFEMZRQ6anG+iCCaWzqGNBrcd6afjX22U=;
 b=Rjgjz/99KxpRz5LCsmny/th+CNKzcU0qZgJVkFHXMNP2fGATLFPg/7rK
 DcsVIyIWPyK3dFn7O2l7z3Pj5mLqwyOSJ29e8MFyWXbU30MxL/yiybAF/
 7T1gMksLLlm+C0Zc+wwSWCbGF/8Jsv/bSMiTB1dLJSArj2WMG3++Ggcgq
 wG6rLPF9KLfMroLRGd0lQ1+mYqygT4KmcCGZF3qtn4TXMBYHscqQU+Ynt
 kgO7QD1j+221qDQHd6Ld2vHvN7WuDd58xUzRxNZQXEb3sE7KxK7x9KEgT
 s13QpHmPOPMg24tv/N3L77Pb2Rii43IRa6UF2HgmgwP0QjawVJXpfm/7t A==;
IronPort-SDR: /XcPAXsP3l1y8CcmjFNNrRefeNitBMep81t53XproURMr4BX41pAi4RuAhvw/gFdq/ElbovXDf
 cAp7Qz3CdAOR7nA8Yp2rwiEDz5RuswyQVNuzR0CdfSUyAXuGYDcqCydzb+19/6QJjvNC/KIEQx
 x0ScmiL65Pl3dfvh41iahVe/0RYB+YCKIrQsagR8ebRJexGIUDDkcRXILd15TN83/jJWqk8N46
 Np+/vonhq8fvWIVw87LWfpoumpo12sMnkXhE0HH/Yt7jdlIjI8AYDkVsC5BS+dFKobh49S/9Ex
 gQY=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="270629540"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:10:35 +0800
IronPort-SDR: QHR0Fy8d94gruxeuY8C1OBybKmIJrGsqNE7uoceyypIV7j+93zwhLDwLz0nT+2wF8OCkV8aA4l
 VZ+zWeCjdCh6cyqclLa0X0Gp4buCPiufqKy32kJYvnhZsyClBAQvSspxPiMgPIwZ3LIUC+MYkJ
 Q3S4MWHQ0hJdUxTvDwaJ6CPlllKZN5suLcGXJUjCeaqARCeDvB1+qyJgYA3PjX9AyC3KdVR3pP
 6BMlS3DpjJ2GCkG54Gchu4QSNO3+KDk97n/alH1W8nX8qxS+sFdXxx8AaohuPKmHNXYJ+pmayc
 oeccW+YkhU+7ACN7VFX9JDLX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:52:20 -0800
IronPort-SDR: 0VFfFPNi9eSyiLUX7yovIlvIziB7tCS9HmCdLIAL9evh2vNAI5MdJHXeC7N/jdslNCB6b1QHIC
 edQOEzGhMr+mxJ7ZyWJiYURei7dkMUERRjihxQ6eq9S8h0sSVcc2dxvAkREcdMZtjffGuHoOsH
 qN1TYiINE7iEi6LDreWSJarNfwCy9CUZI0VQrDLD0bShp25zBhAfguaC+71DthKqn+4miUK37x
 pV2AeNC+MENQ7dzL4pwTSHV64NA0AWUkNgB19sw7Ctj57tO2BqoulIfHtbKBS22l8Wb2GMgRQ3
 qzI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:10:36 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 00/14] nvme: few cleanups and small improvements
Date: Tue, 16 Feb 2021 16:10:18 -0800
Message-Id: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191038_115362_679CC1D7 
X-CRM114-Status: UNSURE (   9.87  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
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
ZW50YXRpb24uCgotY2sKCkNoYWl0YW55YSBLdWxrYXJuaSAoMTQpOgogIG52bWUtY29yZTogcmVt
b3ZlIGR1cGxpY2F0ZSBrZnJlZSBpbiBpbml0IGlkZW50aWZ5CiAgbnZtZS1jb3JlOiBkb24ndCB1
c2Ugc3dpdGNoIGZvciBvbmx5IG9uZSBjYXNlIHVzZQogIG52bWUtY29yZTogdXNlIHJpZ2h0IHR5
cGUgZm9yIEFSUkFZX1NJWkUgY2hlY2sKICBudm1lLWNvcmU6IGZpeCB0aGUgdHlwZSBmb3Igc2h1
dGRvd25fdGltZW91dAogIG52bWUtY29yZTogYWRkIGhlbHBlciB0byBpbml0IGN0cmwgdHJhbnNw
b3J0IGF0dHIKICBudm1lLWNvcmU6IGFkZCBoZWxwZXIgdG8gaW5pdCBzaHV0ZG93biB0aW1lb3V0
CiAgbnZtZS1jb3JlOiBhZGQgaGVscGVyIHRvIGluaXQgY3RybCBzdWJzeXMgcXVpcmsKICBudm1l
LWNvcmU6IG1vdmUgdXRpbCBxdWlyayBhdCB0aGUgdG9wIG9mIHRoZSBmaWxlCiAgbnZtZS1jb3Jl
OiBtYXJrIG52bWVfc2V0dXBfcGFzc3N0aHJ1KCkgaW5saW5lCiAgbnZtZS1jb3JlOiByZW1vdmUg
b25lIGxpbmVyIHdyYXBwZXJzIGZvciBzdHJlYW1zCiAgbnZtZS1jb3JlOiB1c2UgbGlrZWx5IGlu
IG52bWVfaW5pdF9yZXF1ZXN0KCkKICBudm1lLWNvcmU6IGRvbid0IGNoZWNrIG52bWVfcmVxIGZs
YWdzIGZvciBuZXcgcmVxCiAgbnZtZS1mYzogZml4IHRoZSBmdW5jdGlvbiBkb2N1bWVudGF0aW9u
IGNvbW1lbnQKICBudm1ldC1mYzogdXBkYXRlIGZ1bmN0aW9uIGRvY3VtZW50YXRpb24KCiBkcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAzMzMgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tCiBkcml2ZXJzL252bWUvaG9zdC9mYy5jICAgfCAgIDIgKy0KIGRyaXZlcnMvbnZt
ZS90YXJnZXQvZmMuYyB8ICAgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDE3MiBpbnNlcnRpb25zKCsp
LCAxNjQgZGVsZXRpb25zKC0pCgotLSAKMi4yMi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
