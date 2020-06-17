Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A90C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:11:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32CF5206D8
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EhEIVTNn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="uVOKQE2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CF5206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LPJdxwOlsd5DAI/nFf5vDBJcFfuDhzIrwYzDm8Vx0ao=; b=EhEIVTNnxYEociOR+ZDWTLy60
	YrVD0vZD+2HFVBUmlSNwQWgUcRIQhDTvDjSkmzP01fe32D1WF5Gb/LTBPNzUAxFZnVQegSrf6beHs
	Q9T5s1PACXFQTmDgbJnubhcd8lNWjogoF/BoGFq9XxbNobIXXdKJVyOiJLGEU1FGdJqQYl/dMUoXZ
	tyUpG4zSdYlpGvUCfwFUFaz6UByJoIVPMQdDwOU2fDaqOVBRgucRpLtpn1r/1+ceCoc87Hs4H8BFW
	gpUPBfUsnu0gBG/91KT8JXdknN2Z+SyHy+XZoXcoGFRqzuV3gjMmJw7hVjBUL6UvrOnA2Sepdjmq0
	XHvZ2ERVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlSEe-0007PB-Or; Wed, 17 Jun 2020 07:11:48 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlSEb-0007NT-Bf
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 07:11:47 +0000
Received: by mail-ed1-x544.google.com with SMTP id x25so1085535edr.8
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pYDu7NzJFTaw/qkTdsHc1B1cH/HpMiatHX8C+3KmX+8=;
 b=uVOKQE2tDej7783TVrO/Dx793zKHVkEsahMrT6AfzNHU6WKyIcuflN+Mw2rhBiTN4S
 UrgsSo/Z/ErdQsMNI+dHCHn+7koFVOjoXnWoSJlJR15hKXpY3wcthr00TKLeJBqkN0bI
 pLqEWdMoJkoBpRlUJ62Sh2KE1YHA4cMH1VVnYH1X/ravRAV5PfGQRittIOFwj0CVpNdx
 un86KKth0lrw39cyL4PpFT+50ivM64JabMk0vF832Gir8MFYkSY+sns+0qbxqIarBqDT
 03Id368pjP212VXE6MkyOCrcIX9ZyHZBjj8LhKaxdJRHGRbphzFrq7aFSD9dSOoCqC1w
 0bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pYDu7NzJFTaw/qkTdsHc1B1cH/HpMiatHX8C+3KmX+8=;
 b=ag8cO0MLKWfzWFsE30o5pLiYuFw5RGw+GQX3IrGqrFpEp4vPF5wW218tIogSbJGlW/
 KOO0DFbX9hIdHghTerJtVY1KqsvGa/rb7QxeHR1BuLu/fmP0uAFvFNCCjsNEzzsSKlug
 e7/Yr3Puls2V/lyHMcHFeCTj2TQOiq2E9ACcLqUVuv57Pomsju4fgf5ZVW5OaHK1xMD3
 x+vppZYCkW/tPQqcc6IqWSP6r0JsFYI0ICHKQzE0v49iZ64qtOoWjSimaoRHGkm89pV5
 3CjTBZWXfHkWNyqByb9K6DBddpqu6agTUerMdV1MuQhzoBWTniV5i6NVHwSxvHoSRXj5
 H72w==
X-Gm-Message-State: AOAM533wCoEgyJHUClcx1/RL9eZpehReWVWgotXNuQnP4goPAl61eutB
 kiUYT4ShDBypdt0su9nQfIJPkg==
X-Google-Smtp-Source: ABdhPJx5VtsFOzKLe9ZD2xuVU1SGyhfugJeICyLDHqhQJj7HM76CFYQAKlLK1WsBv0cKQzo99/7aJQ==
X-Received: by 2002:a50:98c1:: with SMTP id j59mr6242459edb.120.1592377902586; 
 Wed, 17 Jun 2020 00:11:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id p13sm11483607edx.69.2020.06.17.00.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:11:41 -0700 (PDT)
Date: Wed, 17 Jun 2020 09:11:41 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617071141.rfy545k2vlzkroby@mpHalley.localdomain>
References: <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
 <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_001145_815789_7C780405 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcuMDYuMjAyMCAwNjo1NCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzE3
IDE1OjE4LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAxNy4wNi4yMDIwIDAwOjM4LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMTcgMToxMywgSmF2aWVyIEdvbnrD
oWxleiB3cm90ZToKPj4+PiBPbiAxNi4wNi4yMDIwIDA5OjA3LCBLZWl0aCBCdXNjaCB3cm90ZToK
Pj4+Pj4gT24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMDU6NTU6MjZQTSArMDIwMCwgSmF2aWVyIEdv
bnrDoWxleiB3cm90ZToKPj4+Pj4+IE9uIDE2LjA2LjIwMjAgMDg6NDgsIEtlaXRoIEJ1c2NoIHdy
b3RlOgo+Pj4+Pj4+IE9uIFR1ZSwgSnVuIDE2LCAyMDIwIGF0IDA1OjAyOjE3UE0gKzAyMDAsIEph
dmllciBHb256w6FsZXogd3JvdGU6Cj4+Pj4+Pj4+IFRoaXMgZGVwZW5kcyB2ZXJ5IG11Y2ggb24g
aG93IHRoZSBGUyAvIGFwcGxpY2F0aW9uIGlzIG1hbmFnaW5nCj4+Pj4+Pj4+IHN0cmlwcGluZy4g
QXQgdGhlIG1vbWVudCBvdXIgbWFpbiB1c2UgY2FzZSBpcyBlbmFibGluZyB1c2VyLXNwYWNlCj4+
Pj4+Pj4+IGFwcGxpY2F0aW9ucyBzdWJtaXR0aW5nIEkvT3MgdG8gcmF3IFpOUyBkZXZpY2VzIHRo
cm91Z2ggdGhlIGtlcm5lbC4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gQ2FuIHdlIGVuYWJsZSB0aGlzIHVz
ZSBjYXNlIHRvIHN0YXJ0IHdpdGg/Cj4+Pj4+Pj4KPj4+Pj4+PiBJIHRoaW5rIHRoaXMgYWxyZWFk
eSBwcm92aWRlcyB0aGF0LiBZb3UgY2FuIHNldCB0aGUgbnNpZCB2YWx1ZSB0bwo+Pj4+Pj4+IHdo
YXRldmVyIHlvdSB3YW50IGluIHRoZSBwYXNzdGhyb3VnaCBpbnRlcmZhY2UsIHNvIGEgbmFtZXNw
YWNlIGJsb2NrCj4+Pj4+Pj4gZGV2aWNlIGlzIG5vdCByZXF1aXJlZCB0byBpc3N1ZSBJL08gdG8g
YSBaTlMgbmFtZXNwYWNlIGZyb20gdXNlciBzcGFjZS4KPj4+Pj4+Cj4+Pj4+PiBNbW1tbS4gUHJv
YmxlbSBub3cgaXMgdGhhdCB0aGUgY2hlY2sgb24gdGhlIG52bWUgZHJpdmVyIHByZXZlbnRzIHRo
ZSBaTlMKPj4+Pj4+IG5hbWVzcGFjZSBmcm9tIGJlaW5nIGluaXRpYWxpemVkLiBBbSBJIG1pc3Np
bmcgc29tZXRoaW5nPwo+Pj4+Pgo+Pj4+PiBIbSwgb2theSwgaXQgbWF5IG5vdCB3b3JrIGZvciB5
b3UuIFdlIG5lZWQgdGhlIGRyaXZlciB0byBjcmVhdGUgYXQgbGVhc3QKPj4+Pj4gb25lIG5hbWVz
cGFjZSBzbyB0aGF0IHdlIGhhdmUgdGFncyBhbmQgcmVxdWVzdF9xdWV1ZS4gSWYgeW91IGhhdmUg
dGhhdCwKPj4+Pj4geW91IGNhbiBpc3N1ZSBJTyB0byBhbnkgb3RoZXIgYXR0YWNoZWQgbmFtZXNw
YWNlIHRocm91Z2ggdGhlIHBhc3N0aHJvdWdoCj4+Pj4+IGludGVyZmFjZSwgYnV0IHdlIGNhbid0
IGFzc3VtZSB0aGVyZSBpcyBhbiBhdmFpbGFibGUgbmFtZXNwYWNlLgo+Pj4+Cj4+Pj4gVGhhdCBt
YWtlcyBzZW5zZSBmb3Igbm93Lgo+Pj4+Cj4+Pj4gVGhlIG5leHQgc3RlcCBmb3IgdXMgaXMgdG8g
ZW5hYmxlIGEgcGFzc3Rocm91Z2ggb24gdXJpbmcsIG1ha2luZyBzdXJlCj4+Pj4gdGhhdCBJL09z
IGRvIG5vdCBzcGxpdC4KPj4+Cj4+PiBQYXNzdGhyb3VnaCBhcyBpbiAiYXBwbGljYXRpb24gaXNz
dWVzIGRpcmVjdGx5IE5WTWUgY29tbWFuZHMiIGxpa2UgZm9yIFNHX0lPCj4+PiB3aXRoIFNDU0kg
PyBPciBkbyB5b3UgbWVhbiByYXcgYmxvY2sgZGV2aWNlIGZpbGUgYWNjZXNzZXMgYnkgdGhlIGFw
cGxpY2F0aW9uLAo+Pj4gbWVhbmluZyB0aGF0IHRoZSBJTyBnb2VzIHRocm91Z2ggdGhlIGJsb2Nr
IElPIHN0YWNrIGFzIG9wcG9zZWQgdG8gZGlyZWN0bHkgZ29pbmcKPj4+IHRvIHRoZSBkcml2ZXIg
Pwo+Pj4KPj4+IEZvciB0aGUgbGF0dGVyIGNhc2UsIEkgZG8gbm90IHRoaW5rIGl0IGlzIHBvc3Np
YmxlIHRvIGd1YXJhbnRlZSB0aGF0IGFuIElPIHdpbGwKPj4+IG5vdCBnZXQgc3BsaXQgdW5sZXNz
IHdlIGFyZSB0YWxraW5nIGFib3V0IHNpbmdsZSBwYWdlIElPcyAoZS5nLiA0SyBvbiBYODYpLiBT
ZWUKPj4+IGEgc29tZXdoYXQgc2ltaWxhciByZXF1ZXN0IGhlcmUgYW5kIGNvbW1lbnRzIGFib3V0
IGl0Lgo+Pj4KPj4+IGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LWJsb2NrL21z
ZzU1MDc5Lmh0bWwKPj4KPj4gQXQgdGhlIG1vbWVudCB3ZSBhcmUgZG9pbmcgdGhlIGZvcm1lciwg
YnV0IGl0IGxvb2tzIGxpa2UgYSBoYWNrIHRvIG1lIHRvCj4+IGdvIGRpcmVjdGx5IHRvIHRoZSBO
Vk1lIGRyaXZlci4KPgo+VGhhdCBpcyB3aGF0IHRoZSBudm1lIGRyaXZlciBpb2N0bCgpIGlzIGZv
ciBubyA/IEFuIGFwcGxpY2F0aW9uIGNhbiBzZW5kIGFuIE5WTWUKPmNvbW1hbmQgZGlyZWN0bHkg
dG8gdGhlIGRyaXZlciB3aXRoIGl0LiBUaGF0IGlzIG5vdCBhIGhhY2ssIGJ1dCB0aGUgcmVndWxh
ciB3YXkKPm9mIGRvaW5nIHBhc3N0aHJvdWdoIGZvciBOVk1lLCBpc24ndCBpdCA/CgpXZSBoYXZl
IGVuYWJsZWQgaXQgdGhyb3VnaCB1cmluZyB0byBnZXQgYXN5bmMoKSBwYXNzdGhydSBzdWJtaXNz
aW9uLgpMb29rcyBsaWtlIGEgaGFjayBhdCB0aGUgbW9tZW50LCBidXQgd2UgbWlnaHQganVzdCBz
ZW5kIGEgUkZDIHRvIGhhdmUKc29tZXRoaW5nIGNvbmNyZXRlIHRvIGJhc2VkIHRoZSBkaXNjdXNz
aW9uIG9uLgoKPgo+PiBJIHdhcyB0aGlua2luZyB0aGF0IHdlIGNvdWxkIGVuYWJsZSB0aGUgc2Vj
b25kIHBhdGggYnkgbWFraW5nIHVzZSBvZgo+PiBjaHVua19zZWN0b3JzIGFuZCBsaW1pdCB0aGUg
SS9PIHNpemUganVzdCBhcyB0aGUgYXBwZW5kX21heF9pb19zaXplCj4+IGRvZXMuIElzIHRoaXMg
dGhlIGNvbXBsZXRlIHdyb25nIHdheSBvZiBsb29raW5nIGF0IGl0Pwo+Cj5UaGUgYmxvY2sgbGF5
ZXIgY2Fubm90IGxpbWl0IHRoZSBzaXplIG9mIGEgcGFzc3Rocm91Z2ggY29tbWFuZCBzaW5jZSB0
aGUgY29tbWFuZAo+aXMgcHJvdG9jb2wgc3BlY2lmaWMgYW5kIHRoZSBibG9jayBsYXllciBpcyBh
IHByb3RvY29sIGluZGVwZW5kZW50IGludGVyZmFjZS4KCkFncmVlLiBUaGlzIHdvcmsgZGVwZW5k
IGluIHRoZSBhcHBsaWNhdGlvbiBiZWluZyBhd2FyZSBvZiBhIG1heCBJL08gc2l6ZQphdCB0aGUg
bW9tZW50LiBEb3duIHRoZSByb2FkLCB3ZSB3aWxsIHJlbW92ZSAob3IgYXQgbGVhc3QgbGltaXQg
YSBsb3QpCnRoaXMgY29uc3RyYWludCBmb3IgWk5TIGRldmljZXMgdGhhdCBjYW4gZXZlbnR1YWxs
eSBjYWNoZSBvdXQtb2Ytb3JkZXIKSS9Pcy4KCj5TQ1NJIFNHIGRvZXMgbm90IHNwbGl0IHBhc3N0
aHJvdWdoIHJlcXVlc3RzLCBpdCBjYW5ub3QuIEZvciBwYXNzdGhyb3VnaAo+Y29tbWFuZHMsIHRo
ZSBjb21tYW5kIGJ1ZmZlciBjYW4gYmUgZG1hLW1hcHBlZCBvciBpdCBjYW5ub3QuIElmIG1hcHBp
bmcKPnN1Y2NlZWRzLCB0aGUgY29tbWFuZCBpcyBpc3N1ZWQuIElmIGl0IGNhbm5vdCwgdGhlIGNv
bW1hbmQgaXMgZmFpbGVkLiBBdCBsZWFzdCwKPnRoYXQgaXMgbXkgdW5kZXJzdGFuZGluZyBvZiBo
b3cgdGhlIHN0YWNrIGlzIHdvcmtpbmcuCgpJIGFtIG5vdCBmYW1pbGlhciB3aXRoIFNDU0kgU0cu
IFRoaXMgbG9va3MgbGlrZSBob3cgdGhlIGlvY3RsKCkgcGFzc3RocnUKd29ya3MgaW4gTlZNZSwg
YnV0IGFzIG1lbnRpb25lZCBhYm92ZSwgd2Ugd291bGQgbGlrZSB0byBlbmFibGUgYW4KYXN5bmMo
KSBwYXNzdGhydSBwYXRoLgoKVGhhbmtzLApKYXZpZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
