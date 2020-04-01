Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B9C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 18:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA89206F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 18:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YZtTL1wv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TPZ3OFaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA89206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XGICbLY+dmcnSi2v592aUo3FpHb0VsXgYh2XeY99kB0=; b=YZtTL1wvodjfM+mdJUeDAz9pbD
	T76561GmkT1/aAawVdTLstNiwDtMqIDvk2ZYBeOEY1M02+SwToPYIrNtiHHfNVpCB6xQZ6zGWtN7T
	4oo3dMRgbT08t7oHGS688qUhGJfb+zaRENmGqeZTZoGgnKEaXeUmVe6KRkUFyyQNGqdmig0iHaSep
	JJaf3nmnisDUURN9b4x67NypSTcrDk6jcklO7GOA4lhD+mp4VLzAugoJ8vYURtkHXEXhRRajHY12/
	sHHBBmUz4v8cpMTViCG1llTOJnpz3By6xf5mG45r/4c35fB7f+E/dwPwxyc8TLHcU7XQ6/lH2H0O9
	keeoLRwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJiZG-0006gv-5Y; Wed, 01 Apr 2020 18:58:26 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJiZD-0006gR-Gn
 for linux-nvme@lists.infradead.org; Wed, 01 Apr 2020 18:58:24 +0000
Received: by mail-wr1-x434.google.com with SMTP id 31so1373455wrs.3
 for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2020 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=to:cc:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=7QpTw3OwIV/6dNyKIqLkCho4ks1COWTvDgQf4WCBwCc=;
 b=TPZ3OFajM+pXtn8XZCmpdByrx1drlbb8+fVBWnRWKXa+Qi7UyVShUjK9R4elEwVCvz
 MOzbLALc4kbCghxrmo6DOQcF5Pw73vgkNYDvMQlAGJF/RMDq36tV4Z9e2Mi6QdcjRqnE
 YWGZIdp2iSi3UNUuKXWsAKemNSdiqzVUDY1ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=7QpTw3OwIV/6dNyKIqLkCho4ks1COWTvDgQf4WCBwCc=;
 b=K9/q90LqWBsMefhArvEndhu8RKHzKPZ5K3JgHBFQI1S32gtL9O6nhOhIiVe6ukv0ci
 Yt0n+c2kzgBdcinG7Jh8CnVOIyiwPjcWFlkWhc/aCcYHRzwyboHcO3DHKRgM8tDBSIyW
 bQ9VgrvQ8MKNiLxqI9PGaN4TN4UN1iD+987941Mpa6p0KfnXErge87lDDXNEwcSC1KjC
 K/WVoPb9UjXkmu12qRFO/BOxM5fK5i6doBhsEN2veWe9pgmdu0BJb67yHUgVeZnB5okC
 sHl2WTMKGZ5Gf6lZ8aQ8ckuCdwjHmCR+WhalV5ECPAv54tq6Ae1MXPAzwWLZppaX+y0H
 gQVw==
X-Gm-Message-State: AGi0PuZxgNUh6Y0MsQSqQhikMYTHXX/G2ls0HRT4LyG6iGZsd+ayUgAK
 V6UK5UZFojAxnD8geu7I/DtsRQ==
X-Google-Smtp-Source: APiQypLBdIDumxC3WEWgfrISA9tno34C5UdojsYqZNJAOzwdYoNfFq0WPOol9RuPtQgFoiPtm7WlyQ==
X-Received: by 2002:a5d:6303:: with SMTP id i3mr4925918wru.1.1585767501741;
 Wed, 01 Apr 2020 11:58:21 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h26sm3646520wmb.19.2020.04.01.11.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2020 11:58:21 -0700 (PDT)
To: linux-nvme <linux-nvme@lists.infradead.org>
From: James Smart <james.smart@broadcom.com>
Subject: [REVERT] nvme_fc: add module to ops template to allow module
Message-ID: <db0e6c75-ac72-26b7-4791-9ad9969c12ec@broadcom.com>
Date: Wed, 1 Apr 2020 11:58:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_115823_559942_F1044A93 
X-CRM114-Status: UNSURE (   9.88  )
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
Cc: Sasha Levin <sashal@kernel.org>,
 Himanshu Madhani <himanshu.madhani@oracle.com>, Arun Easi <aeasi@marvell.com>,
 James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

KG5vdCBxdWl0ZSBzdXJlIGhvdyB0byByZXF1ZXN0IHRoaXMpCgpQbGVhc2UgcmV2ZXJ0IGNvbW1p
dMKgIDg2M2ZiYWU5MjljNyBudm1lX2ZjOiBhZGQgbW9kdWxlIHRvIG9wcyB0ZW1wbGF0ZSAKdG8g
YWxsb3cgbW9kdWxlwqAgcmVmZXJlbmNlcwoKVGhpcyBpcyBibG9ja2luZyBsbGRkIGRyaXZlciBy
ZW1vdmFsIGZyb20gdW5kZXIgbnZtZS1mYyB3aGVuZXZlciB0aGVyZSAKaXMgYSBudm1lIGNvbnRy
b2xsZXIgYXR0YWNoZWQgdmlhIHRoZSBkcml2ZXIuIFRoZSBkcml2ZXIgbW9kdWxlIGRldGFjaCAK
cm91dGluZSBjYW4ndCBiZSBjYWxsZWQsIHRodXMgdGhlcmUncyBubyB3YXkgc3RhcnQgdGhlIGNv
bnRyb2xsZXIgCmRlbGV0ZXMvcG9ydCByZW1vdmFscyBzbyB0aGUgZHJpdmVyIGNhbiB1bmxvYWQu
wqAgU2hvdWxkIGhhdmUgYmVlbiAKb2J2aW91cyBmcm9tIHRoZSBnZXQgZ28gdGhhdCB0aGlzIHdh
cyBhIGJhZCBpZGVhLCBidXQuLi4uIG5vdCBzZWVpbmcgdGhlIApmb3Jlc3QgZm9yIHRoZSB0cmVl
cy4KClJldmVydGluZyB0aGlzIGRvZXMgbWVhbiBJIGRvbid0IGtub3cgaG93IHRvIHNvbHZlIGEg
Ym9vdGVkLWZyb20gZGV2aWNlIAp3aGVyZSB0aGUgZHJpdmVyIHdhbnRzIHRvIHVubG9hZCBhbmQg
KHJlKWxvYWQsIGJ1dCB0aGUgbG9hZCBtYXkgYmUgCmJsb2NrZWQgYXMgc3dhcC9mcyBhY2Nlc3Mg
bWF5IGJlIG5lZWRlZCB0byBhY2Nlc3MgdGhlIG5ldyBtb2R1bGUgdG8gCmxvYWQuIFN1Z2dlc3Rp
b25zIHdlbGNvbWUuCgotLSBqYW1lcwoKU2FzaGE6IFRoaXMgd2FzIHVwc3RyZWFtIGFzIG9mIDUu
NSBhbmQgSSBiZWxpZXZlIHdlbnQgaW50byA1LjQvNC4xNC80LjE5CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdAps
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
