Return-Path: <SRS0=16Sh=3M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00614C2D0DB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 15:34:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1124676
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jan 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RIB+V/Zm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FQ9TOthF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1124676
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YVq0F89n9hVgVeFy9QPrdHP+dMbwmLfKNJBYr9aVGrA=; b=RIB+V/ZmY2SExdWKneW+gU6U6
	9mXbAcamqsi4SKMsv0LhcfFJoVX0UCsuGmOs3Mu8/movk3ugzbGTLPhYLBLCIm7kcOFEK4JMH3yY1
	bgU1H8p6PJ+m80jzzkkaOoOJYyqsyudRdEDTFn6Wrijr2owiw0F5GW9Q0SX1euUaSUCc21NNI7Ybp
	lYo//+dJoVDviI2ZSd4qMq5IFmH8yKu/FeVBBVF+E4lHyuPn2R6JsXPo0LR1f+rP97L57BA+nkkTy
	n5E87Oixx3PZQxoOwAD2nR1JMkJ51WXA7yMM2vA5EtQAWLMCcU36cF5j0Z5SUPADQ1p6U5DS/HHGM
	5YTDs+hfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iueUx-0002pS-9X; Thu, 23 Jan 2020 15:34:23 +0000
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iueUu-0002od-G8
 for linux-nvme@lists.infradead.org; Thu, 23 Jan 2020 15:34:21 +0000
Received: by mail-pj1-x1041.google.com with SMTP id r67so1368965pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jan 2020 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=FCVllF7R2wc+ZZjKODFZ0Rf6MGNHOkY4EcD/Mw8AeLk=;
 b=FQ9TOthFwwThXRqveQEP8/tu8iRI99/5pY6YH9bqOjprxT/cvHx8p8RGPtUYmweeNt
 X4KlIjB8kpX8UbtMQSsvcgq9CaWxYXhvcuvUy7u8BQR6mOISxF3451boD+g8GXBxNoqf
 VXKpXjrLmMTd6x+u11bSUK/vHe0XzaFERdbUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FCVllF7R2wc+ZZjKODFZ0Rf6MGNHOkY4EcD/Mw8AeLk=;
 b=RJYTtjXdCwdCe+6G/T5S0/IyrQXQEcpb3MvGIA23FBxrrnSS7poiKaJY9xmv5vTBmH
 A73vCuiwLyQAOyQS9r/XNwgo1O2El811s7zikZZ3U9ISoO7SOjmC46b4Cep4xeeCxSbz
 ZaU7tOeF9l+pRJLX/xKIGWsED1QQXQLIc2yeA2Z8ZLURYbRtZXWtNuFRUv7C+aTOYAo1
 8epZ9GYXNCc6iIZP7rl1Q1CVdNn+jubykIgVxIwiSUk5Zdg1a5sldIF2swX+00QguXH1
 ne3Y7QfIuiLqE2UAkz3BATJnEViF3+beWGKBY6WtBPfT9VdWf0ftE7rMY5AgkEWtCIfO
 WJ9w==
X-Gm-Message-State: APjAAAUbKFJO3BiSKdDLPdojl638im6FM0TyPw5bp0nsEtcdMFKQ7wsG
 2VOUnBVDtbgh31TM27GJIuvSbA==
X-Google-Smtp-Source: APXvYqw3vyyuolTjjHQ8SMMNLLF6rz4h3YFhbYtbD1V9On+0oh/mSIUOFAZswa4YGeNTFH4ZMEIf3w==
X-Received: by 2002:a17:902:7d86:: with SMTP id
 a6mr17183720plm.212.1579793659009; 
 Thu, 23 Jan 2020 07:34:19 -0800 (PST)
Received: from [192.168.1.237] (ip68-5-146-102.oc.oc.cox.net. [68.5.146.102])
 by smtp.gmail.com with ESMTPSA id
 d26sm3309103pgv.66.2020.01.23.07.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 07:34:18 -0800 (PST)
Subject: Re: [PATCH 07/16] nvme-rdma: Add metadata/T10-PI support
To: Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com
References: <20191202144812.147686-1-maxg@mellanox.com>
 <20191202144812.147686-9-maxg@mellanox.com>
 <522e0efe-5907-b28d-ef90-4ceca0fb3103@broadcom.com>
 <07d7772c-7ec5-d29f-ae84-c177321145ae@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <095f5943-5a5f-36ca-a8ee-0c8a9a02cc52@broadcom.com>
Date: Thu, 23 Jan 2020 07:34:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <07d7772c-7ec5-d29f-ae84-c177321145ae@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200123_073420_537692_0E2904C2 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, shlomin@mellanox.com, oren@mellanox.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzIzLzIwMjAgMTo1OSBBTSwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Cj4gT24gMS8yMi8y
MDIwIDExOjU3IFBNLCBKYW1lcyBTbWFydCB3cm90ZToKPj4gT24gYSBwZXItaW8gYmFzaXMsIHRo
ZXJlIG5lZWRzIHRvIGJlIHNwZWNpZmljIGRlc2NyaXB0aW9ucyBvZiB0aGUgRElGIAo+PiBpbmZv
cm1hdGlvbiB0byBwcm9ncmFtIHRoZSBwb3J0IGhhcmR3YXJlLsKgIFRoaW5ncyBzdWNoIGFzIGJs
b2NrIHNpemUsIAo+PiB0eXBlLCBhbmQgc28uIEkgc2VlIHRoaXMgcm91dGluZSB1c2luZyBhIG1p
eCBvZiB0aGUgYmlvIHRoYXQgaXMgCj4+IGFzc29jaWF0ZWQgd2l0aCB0aGUgb3JpZ2luYWwgcmVx
dWVzdCBhcyB3ZWxsIGFzIHRoZSBuYW1lc3BhY2UgcG9pbnRlciAKPj4gdG8gZ2V0IHRoaXMgaW5m
by4gwqDCoCBUbyBtZSB0aGUgcmVhY2hpbmcgaW50byB0aGUgYmlvLCBhcyB3ZWxsIGFzIHRoZSAK
Pj4gbG9jYXRpbmcgb2YgdGhlIG5zIHN0cnVjdHVyZXMgYXJlIHJlYWNoaW5nIGludG8gdGhlIG90
aGVyIGxheWVycyB0b28gCj4+IG11Y2guCj4+Cj4+IFdvdWxkbid0IHdlIGJlIGJldHRlciBvZmYg
d2l0aCB3aXRoIHRoZSBjb3JlIGxheWVyIGRvaW5nIGFsbCB0aGUgCj4+IHJlYWNoaW5nIGFuZCBz
ZXR0aW5nIHVwIGEgcGkgc3RydWN0dXJlIGluIHRoZSBudm1lX3JlcXVlc3Qgd2l0aCB0aGlzIAo+
PiBpbmZvcm1hdGlvbiA/wqDCoCByZXBsYWNlIGhhc19waSB3aXRoIHRoaXMgcGkgc3RydWN0IGFu
ZCAKPj4gIm52bWVfcmVxKHJxKS0+cGkucGlfdHlwZSA9PSAwIiBpcyBlcXVpdmFsZW50IHRvIGhh
c19waSA/IElmIHdlIAo+PiBkaWRuJ3Qgd2FudCB0byByZXBsaWNhdGUgdGhlIFBJIGluZm8sIHRo
ZW4gbnZtZV9yZXF1ZXN0IGNhbiBzaW1wbHkgCj4+IGFkZCBhIHBvaW50ZXIgdG8gdGhlIG5zLCBh
bmQgdGhlIG5zIGNhbiBiZSBsb29rZWQgYXQgZXhwbGljaXRseSB0byAKPj4gZ2F0aGVyIHRoZSBh
dHRyaWJ1dGVzLgo+Pgo+PiBUaG91Z2h0cyA/Cj4+Cj4gTlZNZSBuYW1lc3BhY2UgaXMgdXNlZCBi
eSBSRE1BL1RDUC9GQyB0cmFuc3BvcnQgZHJpdmVycyBpbiBlYWNoIAo+IHF1ZXVlX3JxIGltcGxl
bWVudGF0aW9uLiBXZSBjYW4gcGFzcyBpdCBpbnN0ZWFkIG9mIHJlYWNoaW5nIGl0IGZyb20gCj4g
dGhlIHJxLCBpZiB0aGlzIGxvb2tzIGJldHRlci4KCj8/IHRoZXJlIGhhc24ndCBiZWVuIGFueSBy
ZWFzb24gdG8gbG9vayBhdCB0aGUgbmFtZXNwYWNlIGJ5IHRoZSAKdHJhbnNwb3J0cyB0byBkYXRl
LgoKQnV0IHllcywgSSBtdWNoIHByZWZlciBwYXNzaW5nIHRoZSBucyBhbmQgdXNpbmcgaXQgZm9y
IHRoZSBkaWYgaW5mby7CoCAKVGhpcyByZW1vdmVzIHdoYXQgSSBkaWRuJ3QgbGlrZSAtIGVuY29k
aW5nIHRoZSByZWxhdGlvbnNoaXAgb2YgaG93IHRvIApnZXQgZnJvbSB0aGUgcnEgdG8gbnMgaW4g
ZWFjaCB0cmFuc3BvcnQuCgo+Cj4gTlZNZSBQSSBhdHRyaWJ1dGVzIChlLmfCoCByZWZ0YWcvY2hl
Y2tfZmxhZ3MvYWN0aW9uX2ZsYWdzKSBhcmUgYWxsIHNldCAKPiBpbiB0aGUgY29yZSBsYXllci4K
Cj4KPiBQSSBhdHRyaWJ1dGVzIGZvciBjb25maWd1cmluZyB0aGUgSFcgb2YgZWFjaCB0cmFuc3Bv
cnQgc2hvdWxkIGJlIGRvbmUgCj4gaW4gdGhlIHRyYW5zcG9ydCBkcml2ZXIuCj4KCmFncmVlZC4K
Ci0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
