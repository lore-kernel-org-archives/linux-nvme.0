Return-Path: <SRS0=Kbn9=FH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA20C64E7B
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 08:41:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC52921D91
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Dec 2020 08:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC52921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=boldwhite24.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Subject:To:From:Date:Message-ID:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nHGB3LfKqC/Tw3qC4m3x0Yh8Sk7RkOUog9NfyF0KW14=; b=FOSVmR7ihRsTTTfIUKZXUVR+h1
	LecRyfEaON16tpdxodzLukKWpn4KFcWAjlVIgk+MtZhH82umlx4wnzmq3XI/QpXwMDqCwZ9WpDYjE
	j4TKsl3dLcorr6MhpLPlY4lziWly5MuSGKLr/K8LvGgpdZ1mEo1igH0QacVZm0CqEmBAXpYKntDSo
	89wqBQ1l1r7FuK03bQSC8HB6sJBnk+/Da4f4pwUwhgXdJnig9+1QWZw5R7enmsIs1qn7p/0/VrVnq
	Ir8bB5dKnIbK9ZsRW7+V+6J9QCJdvRhYIlPNcqrk+ZZ5oyvuIOR4W2CaxNWnwqeqWZp0irhV2kfeh
	2PXBGHWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkkB3-0005Xp-5j; Thu, 03 Dec 2020 08:41:25 +0000
Received: from mail.boldwhite24.com ([80.211.42.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkkAx-0005Wq-B9
 for linux-nvme@lists.infradead.org; Thu, 03 Dec 2020 08:41:20 +0000
Received: by mail.boldwhite24.com (Postfix, from userid 1001)
 id E2CE9A2D47; Thu,  3 Dec 2020 08:40:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=boldwhite24.com;
 s=mail; t=1606984855;
 bh=hS3ibs4caZkahrzgcMN2TAJo2B2H5Muwb2NidDYlIzQ=;
 h=Date:From:To:Subject:From;
 b=nznUMbPMlDZU6U1TCMIkF8rsxNX3TIl27jJ3ojw/Ug/Fqu9x/q3QtUc23ZrGeO7Zy
 gDJDKwLzyOy4uX61fJv7Zz8i7X3MtpuQxFpHAvrFNo3fIBWVpEO4X4Xj9auf5/eHG0
 snK65kAmh6+5mJS05kZRiOEWi42htbpi8FwC5TQg8bgPeJAhKLw5IttOvEISKE5jHl
 qM4WwnizvYbl3V+HhaeSO7Vulb+/UJbiuiuqfdsJItot1V7QBay0JdScEtgjqbxiLh
 SOUpZyndvVe4jeBkEzJ2GzGTriHr3sGNKhZMhjWOn227ZCNYAJFevuVcEpa0gTgGVe
 ZaRv52fjCYsuA==
Received: by mail.boldwhite24.com for <linux-nvme@lists.infradead.org>;
 Thu,  3 Dec 2020 08:40:11 GMT
Message-ID: <20201203074501-0.1.2m.amc8.0.db1knajyls@boldwhite24.com>
Date: Thu,  3 Dec 2020 08:40:11 GMT
From: =?UTF-8?Q?"Diego_S=C3=A1nchez"?= <diego.sanchez@boldwhite24.com>
To: <linux-nvme@lists.infradead.org>
Subject: Disinfection
X-Mailer: mail.boldwhite24.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_034119_502902_4B6007C5 
X-CRM114-Status: UNSURE (   1.64  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

R29vZCBtb3JuaW5nLAoKbG9va2luZyBmb3IgY29tcGFuaWVzIGludGVyZXN0ZWQgaW4gcmFpc2lu
ZyBhZGRpdGlvbmFsIGNhcGl0YWwgYnkgZGl2ZXJzaWZ5aW5nIHRoZWlyIG9mZmVyIGluIHNvYXBz
LCBsaXF1aWRzIGFuZCBnZWxzIGZvciBoYW5kIGRpc2luZmVjdGlvbiBhbmQgY29zbWV0aWNzIGZv
ciBib2R5IGFuZCBoYWlyIGNhcmUuCgpUaGUgZGlzdHJpYnV0aW9uIG9mIGlubm92YXRpdmUgcHJv
ZHVjdHMgY29ycmVzcG9uZGluZyB0byB0aGUgY3VycmVudCBwcmVmZXJlbmNlcyBvZiBjdXN0b21l
cnMgaW4gdGhlIGZpZWxkIG9mIGh5Z2llbmUgYW5kIHByZXZlbnRpdmUgaGVhbHRoY2FyZSBhbGxv
d3Mgb3VyIHBhcnRuZXJzIHRvIGdhaW4gbmV3IG1hcmtldHMgYW5kIGFjaGlldmUgYmV0dGVyIGVj
b25vbWljIHJlc3VsdHMuCgpJbiBhZGRpdGlvbiB0byBwcm9kdWN0cyB3aXRoIGJhY3RlcmljaWRh
bCBhY3Rpb24sIG91ciByYW5nZSBpbmNsdWRlcyBzaG93ZXIgZ2Vscywgc2hhbXBvb3MgYW5kIGhh
aXIgY29uZGl0aW9uZXJzLCBhcyB3ZWxsIGFzIGVmZmljaWVudCwgY29uY2VudHJhdGVkIGRldGVy
Z2VudHMuCgpUaGUgdmVyc2F0aWxpdHkgKHN1aXRhYmxlIGZvciBhbGwgc2tpbiB0eXBlcykgY29t
YmluZWQgd2l0aCBhbiBhZmZvcmRhYmxlIHByaWNlIG1lYW5zIHRoYXQgY3VzdG9tZXJzIG1ha2Ug
YW4gaW5mb3JtZWQgY2hvaWNlIG9mIGEgcHJvZHVjdCBhbW9uZyBvdGhlcnMgYXZhaWxhYmxlIG9u
IHRoZSBtYXJrZXQuCgpBcmUgeW91IGludGVyZXN0ZWQgaW4gY29vcGVyYXRpb24/CgpEaWVnbyBT
w6FuY2hlegoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
