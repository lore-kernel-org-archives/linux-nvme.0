Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC10C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:54:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E75206DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E75206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UKExSvetHH1NnvzPyOcM6fkGg8E+nRXvrq6HQMZDgHw=; b=Wz31g8aBLjNSUul6GJlgC/y8R
	gAkIZBheUKJsdiqK5MSh5G5W7qBTt9W+bj/M9ZcQ16EDXlu6y5tOLd/xoWdTmU2W4FGl8k+t6GxRi
	Kon+kbifD58bY/T1//Ce2Iu5185nlf5ZpeBnFEvYnlpyy8XUCfVrNSJsqByAU9DEHjjpiuALQaPjt
	UMjfizcypwWZjGc4Qx3/4RE2p7uNu1FlBvM5Cxm3CKYpA+HDtzhkKT9cg1WIfAyPnh3dDI9ovxDpI
	2tnCWA6oRZEU2Orm7dHD/5CsRIboXeFFQ2vcFHXPPKfPdPy2wPqkkQdhSjcZH9k6Wr3Hn+q8oAETo
	BN5U1Seuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdRO-0000G4-Hm; Tue, 08 Dec 2020 13:54:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdRM-0000Fc-30
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 13:54:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9A33F6736F; Tue,  8 Dec 2020 14:54:01 +0100 (CET)
Date: Tue, 8 Dec 2020 14:54:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gopal Tiwari <gtiwari@redhat.com>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Message-ID: <20201208135401.GA1238@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
 <20201207140428.GA31159@lst.de>
 <989787074.23631599.1607434099327.JavaMail.zimbra@redhat.com>
 <20201208132951.GA847@lst.de>
 <1239878028.23633387.1607434514444.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1239878028.23633387.1607434514444.JavaMail.zimbra@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_085404_266030_0E16C110 
X-CRM114-Status: UNSURE (   9.29  )
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBEZWMgMDgsIDIwMjAgYXQgMDg6MzU6MTRBTSAtMDUwMCwgR29wYWwgVGl3YXJpIHdy
b3RlOgo+IFRoZXNlIGFyZSB0d28gZGlmZmVyZW50IGRldmljZXMuIE9ubHkgb25lIG9mIHRoZSB0
d28gTlZNRSBkZXZpY2VzIGlzIHNlZW4uIFRoZSBvdGhlciBkZXZpY2UgaXMgcmVqZWN0ZWQgIGR1
ZSB0byDigJxEdXBsaWNhdGUgY250bGlk4oCdLiAKClNvIHR3byBjYXJkIHdpdGggb25lIGNvbnRy
b2xsZXIgZWFjaCwgYW5kIGJvdGggaGF2ZSB0aGUgc2FtZSBzdWJucW4uCk9rLiAgSSBndWVzcyB0
aGUgcXVpcmsgaXMgZXhhY3RseSByaWdodCBpbiB0aGlzIGNhc2UsIGFsdGhvdWdoIEkgd291bGQK
bm90IGhhdmUgZXhwZWN0ZWQgdGhpcyBidWcgZnJvbSBhbiBlbnRlcnByaXNlIGRyaXZlIGZyb20g
YSBzb21ld2hhdApyZXB1dGFibGUgdmVuZG9yLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
