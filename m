Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B314C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 14:26:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6652020786
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 14:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="acNLVLtf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Njo0oUKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6652020786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eK5qOREmOD+5Hy+i8dEXoRRdwES1wW60c5ne5Oc119Y=; b=acNLVLtfdzPyL2YT/dGF8QBjm
	3zax7QMF0xnlN/JShv7FHzIw3Q1UX3o3pLTbn/FQ8J+C90vgbkINq8BqJ6n2YBNkDjGjuh0dttBid
	C5X8n7GAE35TpAgH9aTVcSuZ1wdunZLb1nExNyxOw7v3keeqrR5gqrOX6/TUWXVAhszNQSdegqJ8D
	Ra3v+lNwJxyB4dFftn0AtnFORCBZ09VfoWYk1d0wuzxtVh8hTpZe/9nRKcPkrHNu2AButBz/B6Z+Z
	RRlPcc5tyDXVVQNPHzem0zTE472/mApPc7V2LYOSg4KcD5CVPMeH4mT55ttynA+RCsfE1c/X5a6XU
	PzyO8Jx9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlCXi-0000lU-9x; Tue, 16 Jun 2020 14:26:26 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlCO0-0004y5-5v
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 14:16:26 +0000
Received: by mail-ej1-x641.google.com with SMTP id n24so21716194ejd.0
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=6PWDuPTkrXleyY02khhPslJk/OM89kQqOYof8Xt9yHk=;
 b=Njo0oUKYpM2x8GPJ/D8RopLES3YBM9Ix48tYOprYcVt+9EfKZKDy/sDD+L+kUL1eXT
 01RzLC7T0Vyldau9ODEXV1VChCqNyjpYhYo5hVYs/63kEJnXdlnA2ZUCP3E085YpX82K
 wxLm0Q3yyOyVUKrMNMMTGbyrMD0j4H87G/8N9mlWtjljv4YUGDpzvSVS71kUeSdoLI2i
 r4rQYNoa9xihIoa04PASggkKg0n6Qlr3q9N6ubkdOVt1hgwYPU6h7cPcDYg+EbwyuMZg
 wdKIl548fehCeffn6M9HiBDKHxtusnfDMwA/YJ1NllMaerBMmk/YoNJIHxsa45kBiEIS
 7r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6PWDuPTkrXleyY02khhPslJk/OM89kQqOYof8Xt9yHk=;
 b=UHcLv6AgJcg0y3TyWReeLQq9hBw0fbxdcKlXjRahlZ8RPfcMYqGU55bw8p3YyLLvpD
 nqbllBI/0rJl9Ixx5RJ/zQ5N966hCcUysHCW/BhBMR0xkHVUDpig7NG+ZSw7QhWLFASq
 OsCWCQcc7SOFP1xlqiwP5Z0J1uXJ2GtbtYR4fib+NIpvm6xZsMdr+IirkujEagbi5k23
 xyMNQl9ethduWzGtwtAZ221Nb51qOCWjG/zPATtdAismD0eUcoqWukpu2S+uDmRJ2jKl
 dgY4nrC6vJ86dfmQJ7K7rpsJt3cLkuXFn+SkLoLU0MOPxfbTpRgItdCTeUPuvtjIM9fC
 71fA==
X-Gm-Message-State: AOAM532Ubpl3qvWEYtfsxBlaZoWo7UL92RN4sOEWQrdAFlGCli75hIm5
 44BLDeUqPCQm1aN6glUotkaO1Q==
X-Google-Smtp-Source: ABdhPJzhsm7I9PyI7ohWJAAIdecI/C9wgCHgZ2I9lCFpLr7leG+zZv2BlHmNSY9Jc1GLRrPO8EuR7w==
X-Received: by 2002:a17:906:69c3:: with SMTP id
 g3mr3152625ejs.47.1592316982230; 
 Tue, 16 Jun 2020 07:16:22 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id z38sm6863582ede.96.2020.06.16.07.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 07:16:21 -0700 (PDT)
Date: Tue, 16 Jun 2020 16:16:20 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_071624_295303_7D0F3F64 
X-CRM114-Status: GOOD (  16.75  )
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
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYuMDYuMjAyMCAxMjozNSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzE2
IDIxOjI0LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAxNi4wNi4yMDIwIDE0OjA2LCBN
YXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+Pj4gT24gMTYvMDYvMjAyMCAxNC4wMCwgSmF2aWVyIEdv
bnrDoWxleiB3cm90ZToKPj4+PiBPbiAxNi4wNi4yMDIwIDEzOjE4LCBNYXRpYXMgQmrDuHJsaW5n
IHdyb3RlOgo+Pj4+PiBPbiAxNi8wNi8yMDIwIDEyLjQxLCBKYXZpZXIgR29uesOhbGV6IHdyb3Rl
Ogo+Pj4+Pj4gT24gMTYuMDYuMjAyMCAwODozNCwgS2VpdGggQnVzY2ggd3JvdGU6Cj4+Pj4+Pj4g
QWRkIHN1cHBvcnQgZm9yIE5WTSBFeHByZXNzIFpvbmVkIE5hbWVzcGFjZXMgKFpOUykgQ29tbWFu
ZCBTZXQgZGVmaW5lZAo+Pj4+Pj4+IGluIE5WTSBFeHByZXNzIFRQNDA1My4gWm9uZWQgbmFtZXNw
YWNlcyBhcmUgZGlzY292ZXJlZCBiYXNlZCBvbiB0aGVpcgo+Pj4+Pj4+IENvbW1hbmQgU2V0IElk
ZW50aWZpZXIgcmVwb3J0ZWQgaW4gdGhlIG5hbWVzcGFjZXMgTmFtZXNwYWNlCj4+Pj4+Pj4gSWRl
bnRpZmljYXRpb24gRGVzY3JpcHRvciBsaXN0LiBBIHN1Y2Nlc3NmdWxseSBkaXNjb3ZlcmVkIFpv
bmVkCj4+Pj4+Pj4gTmFtZXNwYWNlIHdpbGwgYmUgcmVnaXN0ZXJlZCB3aXRoIHRoZSBibG9jayBs
YXllciBhcyBhIGhvc3QgbWFuYWdlZAo+Pj4+Pj4+IHpvbmVkIGJsb2NrIGRldmljZSB3aXRoIFpv
bmUgQXBwZW5kIGNvbW1hbmQgc3VwcG9ydC4gQSBuYW1lc3BhY2UgdGhhdAo+Pj4+Pj4+IGRvZXMg
bm90IHN1cHBvcnQgYXBwZW5kIGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4KPj4+Pj4+
Cj4+Pj4+PiBXaHkgYXJlIHdlIGVuZm9yY2luZyB0aGUgYXBwZW5kIGNvbW1hbmQ/IEFwcGVuZCBp
cyBvcHRpb25hbCBvbiB0aGUKPj4+Pj4+IGN1cnJlbnQgWk5TIHNwZWNpZmljYXRpb24sIHNvIHdl
IHNob3VsZCBub3QgbWFrZSB0aGlzIG1hbmRhdG9yeSBpbiB0aGUKPj4+Pj4+IGltcGxlbWVudGF0
aW9uLiBTZWUgc3BlY2lmaWNzIGJlbG93Lgo+Pj4+Cj4+Pj4+Cj4+Pj4+IFRoZXJlIGlzIGFscmVh
ZHkgZ2VuZXJhbCBzdXBwb3J0IGluIHRoZSBrZXJuZWwgZm9yIHRoZSB6b25lIGFwcGVuZAo+Pj4+
PiBjb21tYW5kLiBGZWVsIGZyZWUgdG8gc3VibWl0IHBhdGNoZXMgdG8gZW11bGF0ZSB0aGUgc3Vw
cG9ydC4gSXQgaXMKPj4+Pj4gb3V0c2lkZSB0aGUgc2NvcGUgb2YgdGhpcyBwYXRjaHNldC4KPj4+
Pj4KPj4+Pgo+Pj4+IEl0IGlzIGZpbmUgdGhhdCB0aGUga2VybmVsIHN1cHBvcnRzIGFwcGVuZCwg
YnV0IHRoZSBaTlMgc3BlY2lmaWNhdGlvbgo+Pj4+IGRvZXMgbm90IGltcG9zZSB0aGUgaW1wbGVt
ZW50YXRpb24gZm9yIGFwcGVuZCwgc28gdGhlIGRyaXZlciBzaG91bGQgbm90Cj4+Pj4gZG8gdGhh
dCBlaXRoZXIuCj4+Pj4KPj4+PiBaTlMgU1NEcyB0aGF0IGNob29zZSB0byBsZWF2ZSBhcHBlbmQg
YXMgYSBub24taW1wbGVtZW50ZWQgb3B0aW9uYWwKPj4+PiBjb21tYW5kIHNob3VsZCBub3QgcmVs
eSBvbiBlbXVsYXRlZCBTVyBzdXBwb3J0LCBzcGVjaWFsbHkgd2hlbgo+Pj4+IHRyYWRpdGlvbmFs
IHdyaXRlcyB3b3JrIHZlcnkgZmluZSBmb3IgYSBsYXJnZSBwYXJ0IG9mIGN1cnJlbnQgWk5TIHVz
ZQo+Pj4+IGNhc2VzLgo+Pj4+Cj4+Pj4gUGxlYXNlLCByZW1vdmUgdGhpcyB2aXJ0dWFsIGNvbnN0
cmFpbnQuCj4+Pgo+Pj4gVGhlIFpvbmUgQXBwZW5kIGNvbW1hbmQgaXMgbWFuZGF0b3J5IGZvciB6
b25lZCBibG9jayBkZXZpY2VzLiBQbGVhc2UKPj4+IHNlZSBodHRwczovL2x3bi5uZXQvQXJ0aWNs
ZXMvODE4NzA5LyBmb3IgdGhlIGJhY2tncm91bmQuCj4+Cj4+IEkgZG8gbm90IHNlZSBhbnl3aGVy
ZSBpbiB0aGUgYmxvY2sgbGF5ZXIgdGhhdCBhcHBlbmQgaXMgbWFuZGF0b3J5IGZvcgo+PiB6b25l
ZCBkZXZpY2VzLiBBcHBlbmQgaXMgZW11bGF0ZWQgb24gWkJDLCBidXQgYmV5b25kIHRoYXQgdGhl
cmUgaXMgbm8KPj4gbWFuZGF0b3J5IGJpdHMuIFBsZWFzZSBleHBsYWluLgo+Cj5UaGlzIGlzIHRv
IGFsbG93IGEgc2luZ2xlIHdyaXRlIElPIHBhdGggZm9yIGFsbCB0eXBlcyBvZiB6b25lZCBibG9j
ayBkZXZpY2UgZm9yCj5oaWdoZXIgbGF5ZXJzLCBlLmcgZmlsZSBzeXN0ZW1zLiBUaGUgb24tZ29p
bmcgcmUtd29yayBvZiBidHJmcyB6b25lIHN1cHBvcnQgZm9yCj5pbnN0YW5jZSBub3cgcmVsaWVz
IDEwMCUgb24gem9uZSBhcHBlbmQgYmVpbmcgc3VwcG9ydGVkLiBUaGF0IHNpZ25pZmljYW50bHkK
PnNpbXBsaWZpZXMgdGhlIGZpbGUgc3lzdGVtIHN1cHBvcnQgYW5kIG1vcmUgaW1wb3J0YW50bHkg
cmVtb3ZlIHRoZSBuZWVkIGZvcgo+bG9ja2luZyBhcm91bmQgYmxvY2sgYWxsb2NhdGlvbiBhbmQg
QklPIGlzc3VpbmcsIGFsbG93aW5nIHRvIHByZXNlcnZlIGEgZnVsbHkKPmFzeW5jaHJvbm91cyB3
cml0ZSBwYXRoIHRoYXQgY2FuIGluY2x1ZGUgd29ya3F1ZXVlcyBmb3IgZWZmaWNpZW50IENQVSB1
c2FnZSBvZgo+dGhpbmdzIGxpa2UgZW5jcnlwdGlvbiBhbmQgY29tcHJlc3Npb24uIFdpdGhvdXQg
em9uZSBhcHBlbmQsIGZpbGUgc3lzdGVtIHdvdWxkCj5laXRoZXIgKDEpIGhhdmUgdG8gcmVqZWN0
IHRoZXNlIGRyaXZlcyB0aGF0IGRvIG5vdCBzdXBwb3J0IHpvbmUgYXBwZW5kLCBvciAoMikKPmlt
cGxlbWVudCAyIGRpZmZlcmVudCB3cml0ZSBJTyBwYXRoIChzbG93ZXIgcmVndWxhciB3cml0ZSBh
bmQgem9uZSBhcHBlbmQpLiBOb25lCj5vZiB0aGVzZSBvcHRpb25zIGFyZSBpZGVhbCwgdG8gc2F5
IHRoZSBsZWFzdC4KPgo+U28gdGhlIGFwcHJvYWNoIGlzOiBtYW5kYXRlIHpvbmUgYXBwZW5kIHN1
cHBvcnQgZm9yIFpOUyBkZXZpY2VzLiBUbyBhbGxvdyBvdGhlcgo+Wk5TIGRyaXZlcywgYW4gZW11
bGF0aW9uIHNpbWlsYXIgdG8gU0NTSSBjYW4gYmUgaW1wbGVtZW50ZWQsIHdpdGggdGhhdCBlbXVs
YXRpb24KPmlkZWFsbHkgY29tYmluZWQgdG8gd29yayBmb3IgYm90aCB0eXBlcyBvZiBkcml2ZXMg
aWYgcG9zc2libGUuCgpFbmZvcmNpbmcgUUQ9MSBiZWNvbWVzIGEgcHJvYmxlbSBvbiBkZXZpY2Vz
IHdpdGggbGFyZ2Ugem9uZXMuIEluCmEgWk5TIGRldmljZSB0aGF0IGhhcyBzbWFsbGVyIHpvbmVz
IHRoaXMgc2hvdWxkIG5vdCBiZSBhIHByb2JsZW0uCgpXb3VsZCB5b3UgYWdyZWUgdGhhdCBpdCBp
cyBwb3NzaWJsZSB0byBoYXZlIGEgd3JpdGUgcGF0aCB0aGF0IHJlbGllcyBvbgpRRD0xLCB3aGVy
ZSB0aGUgRlMgLyBhcHBsaWNhdGlvbiBoYXMgdGhlIHJlc3BvbnNpYmlsaXR5IGZvciBlbmZvcmNp
bmcKdGhpcz8gRG93biB0aGUgcm9hZCB0aGlzIFFEIGNhbiBiZSBpbmNyZWFzZWQgaWYgdGhlIGRl
dmljZSBpcyBhYmxlIHRvCmJ1ZmZlciB0aGUgd3JpdGVzLgoKSSB3b3VsZCBiZSBPSyB3aXRoIHNv
bWUgRlMgaW1wbGVtZW50YXRpb25zIHRvIHJlbHkgb24gYXBwZW5kIGFuZCBpbXBvc2UKdGhlIGNv
bnN0cmFpbnQgdGhhdCBhcHBlbmQgaGFzIHRvIGJlIHN1cHBvcnRlZCAoYW5kIGl0IHdvdWxkIGJl
IG91ciBqb2IKdG8gY2hhbmdlIHRoYXQpLCBidXQgSSB3b3VsZCBsaWtlIHRvIGF2b2lkIHRoZSBk
cml2ZXIgcmVqZWN0aW5nCmluaXRpYWxpemluZyB0aGUgZGV2aWNlIGJlY2F1c2UgY3VycmVudCBG
UyBpbXBsZW1lbnRhdGlvbnMgaGF2ZQppbXBsZW1lbnRlZCB0aGlzIGxvZ2ljLgoKV2UgY2FuIGFn
cmVlIHRoYXQgYSBudW1iZXIgb2YgaW5pdGlhbCBjdXN0b21lcnMgd2lsbCB1c2UgdGhlc2UgZGV2
aWNlcwpyYXcsIHVzaW5nIHRoZSBpbi1rZXJuZWwgSS9PIHBhdGgsIGJ1dCB3aXRob3V0IGEgRlMg
b24gdG9wLgoKVGhvdWdodHM/Cgo+IGFuZCBub3RlIHRoYXQKPnRoaXMgZW11bGF0aW9uIHdvdWxk
IHJlcXVpcmUgdGhlIGRyaXZlIHRvIGJlIG9wZXJhdGVkIHdpdGggbXEtZGVhZGxpbmUgdG8gZW5h
YmxlCj56b25lIHdyaXRlIGxvY2tpbmcgZm9yIHByZXNlcnZpbmcgd3JpdGUgY29tbWFuZCBvcmRl
ci4gV2hpbGUgb24gYSBIREQgdGhlCj5wZXJmb3JtYW5jZSBwZW5hbHR5IGlzIG1pbmltYWwsIGl0
IHdpbGwgbGlrZWx5IGJlIHNpZ25pZmljYW50IG9uIGEgU1NELgoKRXhhY3RseSBteSBjb25jZXJu
LiBJIGRvIG5vdCB3YW50IFpOUyBTU0RzIHRvIGJlIGltcGFjdGVkIGJ5IHRoaXMgdHlwZQpvZiBk
ZXNpZ24gZGVjaXNpb24gYXQgdGhlIGRyaXZlciBsZXZlbC4KClRoYW5rcywKSmF2aWVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1h
aWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
