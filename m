Return-Path: <SRS0=pxZf=IH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D680C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 12:42:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D616525D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Mar 2021 12:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D616525D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IGHzbWwSwoXhvQ7RY8OAHv49YLsMSFi5fPoNwmf1nI4=; b=LRSaiFHoHQA245LCFGgAQtfj4
	ubuQb1oSS+anaCKHsOj32igX7UimRnK9//l8HL2otK+EOGnUIjwqB8agIbmpI3tbgGrbMRSuxFDUf
	ZYcjotZG7DhzssSqDQMFFuxc/Cii4wgD/akud/hqLapM29t4kqBe5n71RTP1sbtthIAHZzM/8aPSO
	9J5GsGNsI0ziyGGPA9HbReP1gkhvSrcXcAm4Hmfd2iRM8stMQfuzx6GbvUhpYL3RrEVr76RZH7Gp1
	nDnGYa+I5mMASD+q9FOycRnjnoJQ36OGm6FFq1Xbl5L3qvBzxdtoycmzOzdWaX+ymS3c4BYD5b7Tm
	Z+lZlt15w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJbh5-004TpW-Dh; Tue, 09 Mar 2021 12:42:35 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJbgw-004Tob-1Y
 for linux-nvme@lists.infradead.org; Tue, 09 Mar 2021 12:42:28 +0000
Received: by mail-wm1-x32c.google.com with SMTP id l22so1641047wme.1
 for <linux-nvme@lists.infradead.org>; Tue, 09 Mar 2021 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=yQ9Tmm2gIeDEXy/XW+0pX8KjL1wB8WvlsRUFdFPh2n4=;
 b=AQqxydTa7hr/fy+3OfSd0FUs8oA+OYYms1kHhyS6B4WaVovEwShZee+UEmzPV0ezAf
 OpHA0SAgP5/Kaiuq/53Hlwskd3/i2HlzdoaQDTiHFAAC9EwPuaE9QGufDJg1l448+uV7
 AOExI7iSEScVhuKtx+yPv2FuQy/oqvrvxAZ/Aa9M0M1tYf17+3DljC4OuWIfwRW+zCyL
 3Nh30feQK8bN1GLGfPsPguFyWPgLQYdljdIV59PBKzM2zqY7op4tYv+N7BIa1VzDEkzi
 ew7Cq6kaCsqrVtoddCTSDe+Vzb8knpReGtiAfdIAVRSmeIX3syKBKrJwPlhQsTMIYQFy
 HL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yQ9Tmm2gIeDEXy/XW+0pX8KjL1wB8WvlsRUFdFPh2n4=;
 b=V2YwPjWbkI4JOLVwLgpg+uMsjmsBpxbtIxV08Hk29PyvWrYCIZAUq8kz285x2hXusz
 Q7Fjh8gyqi5jcw3TW91J1VAV6hsZlQTiIx1wvvNTS+D30bu/geMtrkjPT9nhO59UJdZp
 Bg5MliBMU+7s6Hsu+WX+nBT7QFufY/O35lKF+QOWxylxSbTFxPx4tpoimvUM6oteRQyg
 sIFPvtOXWdMkkLf+V1kY7ZQPOWCTTKcKxS/p6ac+b3886P7sXAbpFOEK4C0ZOHN7D1X1
 vTXiqmebEkTJSDAFP7RZkZ7Jcb9KuwLP28pwILq1p8B4AJNjTSWmJQyBxj6H0AMaJUZr
 1xmw==
X-Gm-Message-State: AOAM533GelYRFswcPOBM4P3EIyGTwx4HFqCmg2sCIMX3S7w3GruzU3Uf
 6ceS8ejfUGhMTT2S91UDXo2AAA==
X-Google-Smtp-Source: ABdhPJzT5v9Q8cRmtdG3cuTjJZWrMzv00SusH5ZrPUPYuSE3lKxZ50rCN6bpW7sEfq34HrhqEEZ+ew==
X-Received: by 2002:a05:600c:198f:: with SMTP id
 t15mr3873457wmq.8.1615293744941; 
 Tue, 09 Mar 2021 04:42:24 -0800 (PST)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id v18sm21351788wrf.41.2021.03.09.04.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 04:42:23 -0800 (PST)
Date: Tue, 9 Mar 2021 13:42:23 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 kbusch@kernel.org, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210309124104.uowad6bd4vlcthmw@mpHalley.local>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <20210303091022.GA12784@lst.de>
 <20210303100212.e43jgjvuomgybmy2@mpHalley.localdomain>
 <20210309113103.GA9233@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309113103.GA9233@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210309_124226_460515_275F20BC 
X-CRM114-Status: GOOD (  19.96  )
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

T24gMDkuMDMuMjAyMSAxMjozMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBXZWQsIE1h
ciAwMywgMjAyMSBhdCAxMTowMjoxMkFNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
Pj4gSWdub3Jpbmcgc29tZSBvZiB0aGUgZGVwcmVjYXRlZCBoaXN0b3JpYyBtaXN0YWtlcyBJIHRo
aW5rIHRoZSBwb2xpY3kKPj4+IHNob3VsZCBiZToKPj4+Cj4+PiAtIGFkbWluIGNvbW1hbmRzIHRo
YXQgb2Z0ZW4gYXJlIGNvbnRyb2xsZXIgc3BlY2lmaWMgc2hvdWxkIHVzdWFsbHkKPj4+ICAgZ28g
dG8gYSBjb250cm9sbGVyLXNwZWNpZmljIGRldmljZSwgdGhlIGV4aXN0aW5nIC9kZXYvbnZtZVgK
Pj4+ICAgZGV2aWNlcwo+Pj4gLSBJL08gY29tbWFuZHMgYW5kIGFkbWluIGNvbW1hbmQgdGhhdCBk
byBzcGVjaWZpYyBhIG5zaWQgc2hvdWxkIGdvCj4+PiAgIHRocm91Z2ggYSBwZXItbmFtZXNwYWNl
IG5vZGUgdGhhdCBpcyBtdWx0aXBhdGggYXdhcmUgYW5kIG5vdAo+Pj4gICBjb250cm9sbGVyIHNw
ZWNpZmljCj4+Cj4+IFNvdW5kcyBnb29kLgo+Pgo+PiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biByZS1yb3V0ZXMgSU9DVExzIHRvIHRoZSBjaGFyIGRldmljZSB0aHJvdWdoCj4+IHRoZSBleGlz
dGluZyBiZGV2IElPQ1RMcywgc28gSSBiZWxpZXZlIHdlIGZvbGxvdyB0aGlzIHBvbGljeSBhbHJl
YWR5LiBXZQo+PiBiYXNpY2FsbHkgZGVmYXVsdCB0byBjdXJyZW50IGJlaGF2aW9yLgo+Pgo+PiBB
bmQgSSBhc3N1bWUgdGhhdCBmb3IgbGVnYWN5LCBuYW1lc3BhY2UgSU9DVExzIHRvIHRoZSBjb250
cm9sbGVyIHdpbGwKPj4gc3RpbGwgYmUgcm91dGVkIHRvIHRoZSBuYW1lc3BhY2UgKGFzc3VtaW5n
IGEgc2luZ2xlIG5hbWVzcGFjZSkuCj4+Cj4+PiBXaGljaCBhbHNvIG1ha2VzIG1lIHdvbmRlciBh
Ym91dCBwYXRjaCAyIGluIHRoZSBzZXJpZXMgdGhhdCBzZWVtcwo+Pj4gc29tZXdoYXQgZGFuZ2Vy
b3VzLiAgIENhbiB3ZSBjbGVhcmx5IHN0YXRlIHRoZSBwb2xpY3kgaW1wbGVtZW50ZWQ/Cj4+Cj4+
IFBhdGNoIDIgaXMgdGhlIG9uZSB0aGF0IGV4cG9zZXMgdGhlIGV4aXN0aW5nIGxvZ2ljIGZvciBt
dWx0aXBhdGguIEhvdyBkbwo+PiB5b3UgdGhpbmsgd2Ugc2hvdWxkIGRvIGl0IGluc3RlYWQ/Cj4K
PlNvIHRyeWluZyB0byBmb2xsb3cgdGhlIGNvZGU6Cj4KPiAtIG52bWVfY2Rldl9mb3BzIGltcGxl
bWVudHMgZmlsZSBvcGVyYXRpb25zIHRoYXQgZGlyZWN0bHkgb24gYSBudm1lX25zLAo+ICAgc28g
dGhleSBhcmUgcGF0aCBzcGVjaWZpYwoKVGhpcyBpcyBjb3JyZWN0LgoKPiAtIHdlIGFsbG93IG9w
ZW5pbmcgdGhlbSBldmVuIGZvciBhIGhpZGRlbiBjb250cm9sbGVyCgpUaGlzIGlzIGFsc28gY29y
cmVjdC4KCj4gLSB0aGVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGEgY2hhciBkZXZpY2Ugbm9kZSBm
b3IgbnNfaGVhZCBhdCBhbGwuCgpBbHNvIGNvcnJlY3QuCgpXZSB0cmllZCB0byBrZWVwIGl0IHNp
bXBsZSBpbiB0aGUgZmlyc3QgaXRlcmF0aW9uLiBBbSBJIHVuZGVyc3RhbmRpbmcKdGhhdCB5b3Ug
c2VlIG5lY2Vzc2FyeSB0byBoYXZlIHBlciBuc19oZWFkIGNoYXIgZGV2aWNlcz8KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
