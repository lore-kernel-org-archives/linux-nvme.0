Return-Path: <SRS0=WUld=4Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A94CC10DCE
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 01:11:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE949206CC
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 01:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iy/QMvtw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MqmrYCkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE949206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F7AP2339X1WpRfmOuUKzLSZ3qX1cvvxNBKTmluuXLfk=; b=iy/QMvtwIlgiCA/makrRlDxGq
	qxUMQu1i0ShJovbCx74z9lQm+12rklvhwq6ei8qtoMnEfSTWQv+nkUyGm4CEs45Vj/dn5sYPcbQ7c
	nRJIRK75oePrabbz/4JK81c/r8XsM3zwjj/hifgm9pzrBofXqv93wXFYLW10saRRBDsi8s5lLbP8i
	rKFagmKdTq1jqyB1rrbLrOpkEUOPijzZs9j/sNY7Q/E4O6aOfgFRZwnoE+gEMBwVLCWT7cx0C8UB/
	PyJ89j3hIOeapKyBFvYzGxowSAgazESrKpv4hdcyWtPF8AEZCRM47Hy46XbXAH37/QXFR8mRtiI5g
	bk1WUNGTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jAO02-0001gf-J8; Sat, 07 Mar 2020 01:11:30 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jAO00-0001fu-IX
 for linux-nvme@lists.infradead.org; Sat, 07 Mar 2020 01:11:30 +0000
Received: by mail-pg1-x542.google.com with SMTP id m5so1879275pgg.0
 for <linux-nvme@lists.infradead.org>; Fri, 06 Mar 2020 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xR/EgSHwGDB4T1sVM5DqONJ7ouoXda/fvpttc7t5GKA=;
 b=MqmrYCkZ8Y6KNZFl8fx5qXtwQq6woZYNszXHQIpk6tVc+545JShFqQbiALYTsdSphm
 qVDyURWKS4av+k3SfmbQlS163th++tbjxAIZh41lU+wx1CJEjzu1o5fQ50hkRFzX0mep
 s+2HRxd8OAs6JkV5X1JWJdTxfxJxKvaOIpceQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xR/EgSHwGDB4T1sVM5DqONJ7ouoXda/fvpttc7t5GKA=;
 b=BeQeUdIIvg88az+r1IxHNWm/1KlsQzYigVYPGpgfsIGN+Zw9kLFw41YZDGBQZDRjWP
 R3Ryb519BLrunRIDW0k37dxB3YMcgEkOi7ylT3rHSn4hzpIbdFn0R1mvkEXWGZFPjzcq
 PMecy7jSkiKGFJJ4rCaDx6mEapb7ZXtM4k0JE8QDchUzyK929zhsu17qiau/LCchJM3H
 K6CISH1UtD8dvyPzhjxQV5n4Zs8NHk5LFbDqKmtBhSIROqtzvvSB0KNSCV1o2Hdvec31
 avmYcttPnjjanPA3/U1bIGa40yJD6CAEmdlnzf6PWxMHx/SR72CYhhGkIs89MT8Jxrfa
 608g==
X-Gm-Message-State: ANhLgQ0wJ3GrJat/6eBLSz8wb1El2jVhADH8aZbft8cEIM0+Ea6zHZvI
 eIVlrEamzhUedKDvP7CSnnayE79/yHYdeyAND+c/Q7j7Irh8RlEM6YtyWwCqvPflsL2EcNyUmKM
 usVNAgfZgzjIA7qLPmlduxAGwRuvMdd0jmC9bOiy1B3Xmw8NYd1ox1PgZEm4NeG+lWPUPd3B8j7
 lUahROtw==
X-Google-Smtp-Source: ADFU+vuxcBNJe1tCUGl/FWEkyYaeTNE8A/cYGO8i7elLdr0f6ty2B9n9z0mnaU88g+QyULM91eCOeA==
X-Received: by 2002:aa7:8bd1:: with SMTP id s17mr751688pfd.225.1583543486994; 
 Fri, 06 Mar 2020 17:11:26 -0800 (PST)
Received: from [10.230.0.17] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id a19sm10370549pjs.22.2020.03.06.17.11.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 17:11:26 -0800 (PST)
Subject: Re: [PATCH 2/3] nvme/fcloop: short-circuit LS requests if no
 association is present
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200306130440.16864-3-hare@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <ac19a0a7-0028-488d-71f1-f11764d1b261@broadcom.com>
Date: Fri, 6 Mar 2020 17:11:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306130440.16864-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200306_171128_609364_04B4DBDC 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy82LzIwMjAgNTowNCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IElmIG5vIGFzc29j
aWF0aW9uIG9yIHRhcmdldHBvcnQgaXMgcHJlc2VudCBzaGlmdGluZyBMUyBwcm9jZXNzaW5nCj4g
dG8gYSB3b3JrcXVldWUgaXMgYSBiYWQgaWRlYSBhcyB0aGUgdGFyZ2V0cG9ydCBpdHNlbGYgaXMg
YWJvdXQKPiB0byBiZSByZW1vdmVkLCBhbmQgd2Ugd291bGQgZGVhZGxvY2sgd2l0aCB0YXJnZXRw
b3J0IGRlbGV0aW9uLgo+IFNvIGluc3RlYWQgcmV0dXJuIGFuIGVycm9yIGRpcmVjdGx5IGFuZCB0
cmVhdCBpdCBhcyBhIHNlbmQgZXJyb3IsCj4gYXZvaWRpbmcgdGhlIGRlYWRsb2NrLgpTbyBJIGRv
bid0IHF1aXRlIGFncmVlIG9uIHRoZSB0YXJnZXRwb3J0IHN0YXRlbWVudCwgZXNwZWNpYWxseSBy
ZWxhdGl2ZSAKdG8gYm90aCB0aGUgaDJ0IGFuZCB0MmggcGF0aHMuCgpSZXR1cm5pbmcgZXJyb3Ig
Y2VydGFpbmx5IHdvcmtzLCBidXQgaXQgYXZvaWRzIHRoZSBhc3luY2hyb25vdXMgCmNvbXBsZXRp
b24gcGF0aCB3aGljaCBpcyBmYXIgbW9yZSBjb21tb24uIEl0IG9ubHkgdGVzdHMgdGhlIAppbW1l
ZGlhdGUtcmV0dXJuLWVycm9yIGNvZGUgY2FzZS7CoMKgIFdoZW4gdGhyb3dpbmcgaXQgdG8gYSB3
b3JrIHF1ZXVlLCAKaXQnbGwgYmUgYSB3b3JrIHF1ZXVlIHNwZWNpZmljIHRvIHRoZSBwb3J0IGlu
aXRpYXRpbmcgdGhlIHJlcXVlc3QgLSBzbyAKaXQgc2hvdWxkbid0IGJlIHRvdWNoaW5nIHRoZSBv
dGhlciBzaWRlIHdoaWNoIGlzIG5vbi1leGlzdGVudC4KCnNvIHdoYXQgeW91IGhhdmUgZmluZSwg
YnV0IGknbSBub3Qgc3VyZSBpdCdzIHdoYXQgc2hvdWxkIGJlIGhlcmUuCgotLSBqYW1lcwoKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
