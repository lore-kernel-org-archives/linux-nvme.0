Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3BC433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:20:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CE065253
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 21:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CE065253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fxVhy0fbDMr80kfU7L3peRMcBIxNv1lJPWyjPRRE+Fc=; b=gxlHqdNUwP5Uvo3S/H9aLlf91
	n9bW/ee8ong7fe0YaxpgJp5tV6jpumx11Vj0eSB56W9v3Y2g2m4PxrB2Kf/574+cK141fn8qROl+1
	6OJMDorlbM73Zwx5KtGU5aj2zAmwKdm7C40hj8YXlzVDu5iEnYTXTDjUY0Fe0ZISlvhgNjIE0qH7d
	FvYRDYU3HCumQPbNbHeoS1OUUnZ6xdxIhZ8U4F/Rqm/r70s+Aenukmfv/Ts06ODAYoH9PUkqXfe/a
	086apaX7e4LaGdjzENhajIc6TwZLoHkERXeN9w7oYmqAD4yaqKvmfx/OkTlFuUlUmapbCZaMusido
	1ZYVByzKg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJjmL-005RYc-84; Tue, 09 Mar 2021 21:20:33 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJjkc-005RIp-3Q
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 21:18:49 +0000
Received: by mail-wm1-x32d.google.com with SMTP id n22so3898416wmc.2
 for <linux-nvme@lists.infradead.org>; Tue, 09 Mar 2021 13:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=7puXEMns6yXED5Cipm23w3KOcm4gDxuggjUf51KLHTQ=;
 b=rGAqJWN9ilfYM1SO4qMWZvE+nNSI2R3JWDSKJRx3sysE+fH3oYybOnt8JLV6Ezqw1M
 B8jHfc+RhhSCAMgQxg5rXp/XTfM+fNJwhCwleKiIHT/0j+ljl3ZnwC33QNqW9RGwR60y
 ck2AaySaaA1/eRQffqYC328eC80Zm6hy84w9KhxjirzetfWccZv8DRoTo1JLZPuZb4WC
 Oe1ik7YkK0VMwKBzdH1BMC8cWGuA77Lenjyc4ZhTAUCXL0cXkcGEIJ570BAhCLbd7N1D
 GXQ1c/n1VifRYApW96OJM0v37tUv9rmaP/c/PKgwFlAbyw2Tud8GvIZUdPzoGGd461cv
 wPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=7puXEMns6yXED5Cipm23w3KOcm4gDxuggjUf51KLHTQ=;
 b=AvjcF1k4H+hRCdRffYlEA3CW7pwRLWDoaAItQaFvSIlcMj8mOkncv5PRCM7OC3BOtL
 1NUucsTJskxllHSHcyzqeoyQneWRb5hzo30IY8PIQgonpXy/sKzh7RGW35sWOKDnXrBr
 njANMkVijX4zBJHK+9UDUvgsw5+9/S4tFxGmeqtCAh9KyMXiRSxOJ0n4QCrUC5sZox7O
 C3uwNHgQNsWsvcgJ7P36Ht+wuTM+yacI8zl+yil+NOiIspgTfaUfCFCT2R/Gj34tXBgt
 rdrXK23jahzSnUAAlX4hOLEH4nFoXJnpvJt5OBcL8d6fFCeXHHpa5NMC34qJHPqkOS6O
 kmdg==
X-Gm-Message-State: AOAM533XVpmkNXHKXNpoTg2HRO/1yoJ69Rps/KheKIPA+7AmEFBxSrK2
 kMBZXz9ka5ZP2ClOyWtSpL9Hgw==
X-Google-Smtp-Source: ABdhPJzuqIW0djcZgigY2I6784lju5FS2TCbP5AKmg3fcGMn6h8S4K++dO5zXnoTPxnQIPOPqBQDRg==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr6141029wmh.5.1615324722703;
 Tue, 09 Mar 2021 13:18:42 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id p6sm25289599wru.2.2021.03.09.13.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 13:18:42 -0800 (PST)
Date: Tue, 9 Mar 2021 22:18:41 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309211841.tl5pq75iihilil5o@mpHalley.localdomain>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
 <20210309113103.GA9233@lst.de>
 <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
 <20210309150531.GA15052@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309150531.GA15052@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_211847_077208_13B225D6 
X-CRM114-Status: GOOD (  13.04  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDkuMDMuMjAyMSAxNjowNSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUdWUsIE1h
ciAwOSwgMjAyMSBhdCAwMTo0MjoyM1BNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
Pj4gLSBudm1lX2NkZXZfZm9wcyBpbXBsZW1lbnRzIGZpbGUgb3BlcmF0aW9ucyB0aGF0IGRpcmVj
dGx5IG9uIGEgbnZtZV9ucywKPj4+ICAgc28gdGhleSBhcmUgcGF0aCBzcGVjaWZpYwo+Pgo+PiBU
aGlzIGlzIGNvcnJlY3QuCj4+Cj4+PiAtIHdlIGFsbG93IG9wZW5pbmcgdGhlbSBldmVuIGZvciBh
IGhpZGRlbiBjb250cm9sbGVyCj4+Cj4+IFRoaXMgaXMgYWxzbyBjb3JyZWN0Lgo+Pgo+Pj4gLSB0
aGVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgY2hhciBkZXZpY2Ugbm9kZSBmb3IgbnNfaGVhZCBh
dCBhbGwuCj4+Cj4+IEFsc28gY29ycmVjdC4KPj4KPj4gV2UgdHJpZWQgdG8ga2VlcCBpdCBzaW1w
bGUgaW4gdGhlIGZpcnN0IGl0ZXJhdGlvbi4gQW0gSSB1bmRlcnN0YW5kaW5nCj4+IHRoYXQgeW91
IHNlZSBuZWNlc3NhcnkgdG8gaGF2ZSBwZXIgbnNfaGVhZCBjaGFyIGRldmljZXM/Cj4KPlRoYXQg
d291bGQgYmUgbXkgdW5kZXJzdGFuZGluZyBvZiAibXVsdGlwYXRoIHN1cHBvcnQiIGZvciB0aGlz
IGNoYXJhY3Rlcgo+ZGV2aWNlLCB5ZXMuICBFc3BlY2lhbGx5IGFzIGhpZGluZyB0aGUgaW5kaXZp
ZHVhbCBjaGFyIGRldmljZXMgZm9yIHRoZQo+aGlkZGVuIGNvbnRyb2xsZXJzIG9uY2UgdGhleSBh
cmUgaW5pdGlhbGx5IGV4cG9zZWQgd291bGQgYmUgYW4gQUJJIGJyZWFrLgoKT2suIFdpbGwgbG9v
ayBpbnRvIGl0IGZvciB0aGUgbmV4dCBpdGVyYXRpb24uCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==
