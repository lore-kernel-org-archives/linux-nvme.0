Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E618AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B458A2082F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mL4qrsj2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="xC8Lmh7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B458A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L3+Jv7x5J/Juzx0tatbSQhsaLO7KemqZ+/1iVEXZVIg=; b=mL4qrsj2Goc7shDUQDtJYyYZt
	zOujU+GeHvksd9NZAvkqXTwVaPS7EaHHAAG9n08RHZpKC+W7ta/kiHmTncUPhBNaQ3RwaeDvNkP5g
	zV3mxhmSRQ+Sy3cC11vwtzOkAwgSv7bDBRx7GpKIC3pzrVvhru+9oa5GlpVmmt6oCyzKuXb5KTRF4
	wy8GLTD5ZuxSqzG2qXVyW3Q7ZpGBK90xNdRQ2xu6DrMqlaaivu/CAM7ykyGoT6Kg2ZUz2fEufPm1c
	Q90TbPa2VQot27idqU4pqcMEoXNQgLztGxA5933mCDyPanXKzvU1pXfEq5jV1Es5RbcEVbChqbXAL
	3+uuL88yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlSaj-00078S-2D; Wed, 17 Jun 2020 07:34:37 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlSaf-00077s-Ts
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 07:34:35 +0000
Received: by mail-ej1-x644.google.com with SMTP id f7so1213106ejq.6
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 00:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=0dhH/VXyy0ISpjwzTNRZXOZQID4Ea+00PzZYc8ZmdJM=;
 b=xC8Lmh7dh+zvNB8HexJfGodQpW9e4A29s+xJQjZ3bzP0f67D1QVx92/OjD3zkt8eOv
 dpxJ99UmZni3GMTHoDArYKthJHLMD/ucJzix6RO3Ru3ydByk9mAOZ/4Lf5LiaGWjOBXx
 G10nRX5AVI95JOA1vFPOfiL5rQgJBsUYzECAoUdaJipLh6yEVPhsgr7pWnQl2rxT/vvp
 iJBO2uhOWNuNH0UD2gm33fCAI78jKiwvKSqzqf1J6BwLudL5fm33b7aGOwSLLGznNwfS
 tUZOVb3Kpv/2d8m2uoiuJX2Apz0lfiEkNENT/dfOosWdHLOJxJ4BUNIK5y55wMLRY6tv
 D8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=0dhH/VXyy0ISpjwzTNRZXOZQID4Ea+00PzZYc8ZmdJM=;
 b=ZKdGdpyJzYYTcR2XkcsbHOtmPiHhGrag5mwJWfOxwtXid317EOrjoV2XNlUZY/tQ9C
 ZppuqpojUMu4+VbGil+mX2WA9Uwi7IongYAG/9hIXl3/BV9roKihpdxYLV4isg9pJLF0
 BAWgJNSzTrsBKSeDeT3u0Uk9M1zoOpXkLY0VS6bQprQHgPmtpFdlnUMPL3qeZaT6Fb49
 xq42suRVDy3AV8Sy6yAL3Mw4vQXwxf1eUon8Mv4paP5qT3pU9khKCqoFv12VZ55JHJ0f
 87qayl2vsfODf8ogWZUq5/57tzVmEuYlwDQdiCN2ONbpjELtOg73rx/CJuC2xMvAiAKd
 OVOg==
X-Gm-Message-State: AOAM530f5yoLhjmjNSadZwdqZUceQdtIo5I1LcEdFKTUfRq0mKFCwCdw
 gS1sdxJqP+pGBTf4vnOwAzPN5Q==
X-Google-Smtp-Source: ABdhPJye0PUF5hLF7M8Q9UGm5EJmqESbm3d5n0laKC9jEj8n14C5uR8RkOQBDJPMHNRJeyUCwVPCkg==
X-Received: by 2002:a17:906:7c56:: with SMTP id
 g22mr6213967ejp.507.1592379271743; 
 Wed, 17 Jun 2020 00:34:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id o4sm11469968edt.15.2020.06.17.00.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:34:30 -0700 (PDT)
Date: Wed, 17 Jun 2020 09:34:30 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617073430.htbwj6ybkbui7jai@mpHalley.localdomain>
References: <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
 <CY4PR04MB37518F1A34F92049EE8FAF94E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617061814.7syifpwn5sqg5a4w@mpHalley.localdomain>
 <CY4PR04MB3751808DFE9AF00EF172DFCCE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617071141.rfy545k2vlzkroby@mpHalley.localdomain>
 <CY4PR04MB375134A3B37A43AD6AF07815E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375134A3B37A43AD6AF07815E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_003433_964066_EDCE02A8 
X-CRM114-Status: GOOD (  20.28  )
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

T24gMTcuMDYuMjAyMCAwNzoyOSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzE3
IDE2OjExLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAxNy4wNi4yMDIwIDA2OjU0LCBE
YW1pZW4gTGUgTW9hbCB3cm90ZToKPj4+IE9uIDIwMjAvMDYvMTcgMTU6MTgsIEphdmllciBHb256
w6FsZXogd3JvdGU6Cj4+Pj4gT24gMTcuMDYuMjAyMCAwMDozOCwgRGFtaWVuIExlIE1vYWwgd3Jv
dGU6Cj4+Pj4+IE9uIDIwMjAvMDYvMTcgMToxMywgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+
Pj4+IE9uIDE2LjA2LjIwMjAgMDk6MDcsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4+Pj4+IE9uIFR1
ZSwgSnVuIDE2LCAyMDIwIGF0IDA1OjU1OjI2UE0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3Jv
dGU6Cj4+Pj4+Pj4+IE9uIDE2LjA2LjIwMjAgMDg6NDgsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4+
Pj4+Pj4gT24gVHVlLCBKdW4gMTYsIDIwMjAgYXQgMDU6MDI6MTdQTSArMDIwMCwgSmF2aWVyIEdv
bnrDoWxleiB3cm90ZToKPj4+Pj4+Pj4+PiBUaGlzIGRlcGVuZHMgdmVyeSBtdWNoIG9uIGhvdyB0
aGUgRlMgLyBhcHBsaWNhdGlvbiBpcyBtYW5hZ2luZwo+Pj4+Pj4+Pj4+IHN0cmlwcGluZy4gQXQg
dGhlIG1vbWVudCBvdXIgbWFpbiB1c2UgY2FzZSBpcyBlbmFibGluZyB1c2VyLXNwYWNlCj4+Pj4+
Pj4+Pj4gYXBwbGljYXRpb25zIHN1Ym1pdHRpbmcgSS9PcyB0byByYXcgWk5TIGRldmljZXMgdGhy
b3VnaCB0aGUga2VybmVsLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gQ2FuIHdlIGVuYWJsZSB0aGlz
IHVzZSBjYXNlIHRvIHN0YXJ0IHdpdGg/Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSSB0aGluayB0aGlz
IGFscmVhZHkgcHJvdmlkZXMgdGhhdC4gWW91IGNhbiBzZXQgdGhlIG5zaWQgdmFsdWUgdG8KPj4+
Pj4+Pj4+IHdoYXRldmVyIHlvdSB3YW50IGluIHRoZSBwYXNzdGhyb3VnaCBpbnRlcmZhY2UsIHNv
IGEgbmFtZXNwYWNlIGJsb2NrCj4+Pj4+Pj4+PiBkZXZpY2UgaXMgbm90IHJlcXVpcmVkIHRvIGlz
c3VlIEkvTyB0byBhIFpOUyBuYW1lc3BhY2UgZnJvbSB1c2VyIHNwYWNlLgo+Pj4+Pj4+Pgo+Pj4+
Pj4+PiBNbW1tbS4gUHJvYmxlbSBub3cgaXMgdGhhdCB0aGUgY2hlY2sgb24gdGhlIG52bWUgZHJp
dmVyIHByZXZlbnRzIHRoZSBaTlMKPj4+Pj4+Pj4gbmFtZXNwYWNlIGZyb20gYmVpbmcgaW5pdGlh
bGl6ZWQuIEFtIEkgbWlzc2luZyBzb21ldGhpbmc/Cj4+Pj4+Pj4KPj4+Pj4+PiBIbSwgb2theSwg
aXQgbWF5IG5vdCB3b3JrIGZvciB5b3UuIFdlIG5lZWQgdGhlIGRyaXZlciB0byBjcmVhdGUgYXQg
bGVhc3QKPj4+Pj4+PiBvbmUgbmFtZXNwYWNlIHNvIHRoYXQgd2UgaGF2ZSB0YWdzIGFuZCByZXF1
ZXN0X3F1ZXVlLiBJZiB5b3UgaGF2ZSB0aGF0LAo+Pj4+Pj4+IHlvdSBjYW4gaXNzdWUgSU8gdG8g
YW55IG90aGVyIGF0dGFjaGVkIG5hbWVzcGFjZSB0aHJvdWdoIHRoZSBwYXNzdGhyb3VnaAo+Pj4+
Pj4+IGludGVyZmFjZSwgYnV0IHdlIGNhbid0IGFzc3VtZSB0aGVyZSBpcyBhbiBhdmFpbGFibGUg
bmFtZXNwYWNlLgo+Pj4+Pj4KPj4+Pj4+IFRoYXQgbWFrZXMgc2Vuc2UgZm9yIG5vdy4KPj4+Pj4+
Cj4+Pj4+PiBUaGUgbmV4dCBzdGVwIGZvciB1cyBpcyB0byBlbmFibGUgYSBwYXNzdGhyb3VnaCBv
biB1cmluZywgbWFraW5nIHN1cmUKPj4+Pj4+IHRoYXQgSS9PcyBkbyBub3Qgc3BsaXQuCj4+Pj4+
Cj4+Pj4+IFBhc3N0aHJvdWdoIGFzIGluICJhcHBsaWNhdGlvbiBpc3N1ZXMgZGlyZWN0bHkgTlZN
ZSBjb21tYW5kcyIgbGlrZSBmb3IgU0dfSU8KPj4+Pj4gd2l0aCBTQ1NJID8gT3IgZG8geW91IG1l
YW4gcmF3IGJsb2NrIGRldmljZSBmaWxlIGFjY2Vzc2VzIGJ5IHRoZSBhcHBsaWNhdGlvbiwKPj4+
Pj4gbWVhbmluZyB0aGF0IHRoZSBJTyBnb2VzIHRocm91Z2ggdGhlIGJsb2NrIElPIHN0YWNrIGFz
IG9wcG9zZWQgdG8gZGlyZWN0bHkgZ29pbmcKPj4+Pj4gdG8gdGhlIGRyaXZlciA/Cj4+Pj4+Cj4+
Pj4+IEZvciB0aGUgbGF0dGVyIGNhc2UsIEkgZG8gbm90IHRoaW5rIGl0IGlzIHBvc3NpYmxlIHRv
IGd1YXJhbnRlZSB0aGF0IGFuIElPIHdpbGwKPj4+Pj4gbm90IGdldCBzcGxpdCB1bmxlc3Mgd2Ug
YXJlIHRhbGtpbmcgYWJvdXQgc2luZ2xlIHBhZ2UgSU9zIChlLmcuIDRLIG9uIFg4NikuIFNlZQo+
Pj4+PiBhIHNvbWV3aGF0IHNpbWlsYXIgcmVxdWVzdCBoZXJlIGFuZCBjb21tZW50cyBhYm91dCBp
dC4KPj4+Pj4KPj4+Pj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtYmxvY2sv
bXNnNTUwNzkuaHRtbAo+Pj4+Cj4+Pj4gQXQgdGhlIG1vbWVudCB3ZSBhcmUgZG9pbmcgdGhlIGZv
cm1lciwgYnV0IGl0IGxvb2tzIGxpa2UgYSBoYWNrIHRvIG1lIHRvCj4+Pj4gZ28gZGlyZWN0bHkg
dG8gdGhlIE5WTWUgZHJpdmVyLgo+Pj4KPj4+IFRoYXQgaXMgd2hhdCB0aGUgbnZtZSBkcml2ZXIg
aW9jdGwoKSBpcyBmb3Igbm8gPyBBbiBhcHBsaWNhdGlvbiBjYW4gc2VuZCBhbiBOVk1lCj4+PiBj
b21tYW5kIGRpcmVjdGx5IHRvIHRoZSBkcml2ZXIgd2l0aCBpdC4gVGhhdCBpcyBub3QgYSBoYWNr
LCBidXQgdGhlIHJlZ3VsYXIgd2F5Cj4+PiBvZiBkb2luZyBwYXNzdGhyb3VnaCBmb3IgTlZNZSwg
aXNuJ3QgaXQgPwo+Pgo+PiBXZSBoYXZlIGVuYWJsZWQgaXQgdGhyb3VnaCB1cmluZyB0byBnZXQg
YXN5bmMoKSBwYXNzdGhydSBzdWJtaXNzaW9uLgo+PiBMb29rcyBsaWtlIGEgaGFjayBhdCB0aGUg
bW9tZW50LCBidXQgd2UgbWlnaHQganVzdCBzZW5kIGEgUkZDIHRvIGhhdmUKPj4gc29tZXRoaW5n
IGNvbmNyZXRlIHRvIGJhc2VkIHRoZSBkaXNjdXNzaW9uIG9uLgo+Cj5ZZXMsIHRoYXQgd291bGQg
Y2xhcmlmeSB0aGluZ3MuCj4KPj4+PiBJIHdhcyB0aGlua2luZyB0aGF0IHdlIGNvdWxkIGVuYWJs
ZSB0aGUgc2Vjb25kIHBhdGggYnkgbWFraW5nIHVzZSBvZgo+Pj4+IGNodW5rX3NlY3RvcnMgYW5k
IGxpbWl0IHRoZSBJL08gc2l6ZSBqdXN0IGFzIHRoZSBhcHBlbmRfbWF4X2lvX3NpemUKPj4+PiBk
b2VzLiBJcyB0aGlzIHRoZSBjb21wbGV0ZSB3cm9uZyB3YXkgb2YgbG9va2luZyBhdCBpdD8KPj4+
Cj4+PiBUaGUgYmxvY2sgbGF5ZXIgY2Fubm90IGxpbWl0IHRoZSBzaXplIG9mIGEgcGFzc3Rocm91
Z2ggY29tbWFuZCBzaW5jZSB0aGUgY29tbWFuZAo+Pj4gaXMgcHJvdG9jb2wgc3BlY2lmaWMgYW5k
IHRoZSBibG9jayBsYXllciBpcyBhIHByb3RvY29sIGluZGVwZW5kZW50IGludGVyZmFjZS4KPj4K
Pj4gQWdyZWUuIFRoaXMgd29yayBkZXBlbmQgaW4gdGhlIGFwcGxpY2F0aW9uIGJlaW5nIGF3YXJl
IG9mIGEgbWF4IEkvTyBzaXplCj4+IGF0IHRoZSBtb21lbnQuIERvd24gdGhlIHJvYWQsIHdlIHdp
bGwgcmVtb3ZlIChvciBhdCBsZWFzdCBsaW1pdCBhIGxvdCkKPj4gdGhpcyBjb25zdHJhaW50IGZv
ciBaTlMgZGV2aWNlcyB0aGF0IGNhbiBldmVudHVhbGx5IGNhY2hlIG91dC1vZi1vcmRlcgo+PiBJ
L09zLgo+Cj5JL09zIHdpdGggYSBkYXRhIGJ1ZmZlciBhbGwgbmVlZCBtYXBwaW5nIGZvciBETUEs
IG5vIG1hdHRlciB0aGUgZGV2aWNlCj5mdW5jdGlvbmFsaXRpZXMgb3IgdGhlIGNvbW1hbmQgYmVp
bmcgZXhlY3V0ZWQuIFdpdGggcGFzc3Rocm91Z2gsIEkgZG8gbm90IHRoaW5rCj5pdCBpcyBwb3Nz
aWJsZSB0byBoYXZlIHRoZSBibG9jayBsYXllciBsaW1pdCBhbnl0aGluZy4gSXQgd2lsbCBsaWtl
bHkgYWx3YXlzIGJlCj5wYXNzLW9yLWZhaWwuIFdpdGggcGFzc3Rocm91Z2gsIHRoZSBhcHBsaWNh
dGlvbiBuZWVkcyB0byB1bmRlcnN0YW5kIHdoYXQgaXQgaXMKPmRvaW5nLgoKWWVzLiBJdCBpcyBk
ZWZpbml0ZWx5IGZvciBhcHBsaWNhdGlvbnMgdGhhdCBhcmUgaW1wbGVtZW50aW5nIGRpcmVjdGx5
CnpvbmUtYXdhcmUgbG9naWMuCgo+Cj4+Cj4+PiBTQ1NJIFNHIGRvZXMgbm90IHNwbGl0IHBhc3N0
aHJvdWdoIHJlcXVlc3RzLCBpdCBjYW5ub3QuIEZvciBwYXNzdGhyb3VnaAo+Pj4gY29tbWFuZHMs
IHRoZSBjb21tYW5kIGJ1ZmZlciBjYW4gYmUgZG1hLW1hcHBlZCBvciBpdCBjYW5ub3QuIElmIG1h
cHBpbmcKPj4+IHN1Y2NlZWRzLCB0aGUgY29tbWFuZCBpcyBpc3N1ZWQuIElmIGl0IGNhbm5vdCwg
dGhlIGNvbW1hbmQgaXMgZmFpbGVkLiBBdCBsZWFzdCwKPj4+IHRoYXQgaXMgbXkgdW5kZXJzdGFu
ZGluZyBvZiBob3cgdGhlIHN0YWNrIGlzIHdvcmtpbmcuCj4+Cj4+IEkgYW0gbm90IGZhbWlsaWFy
IHdpdGggU0NTSSBTRy4gVGhpcyBsb29rcyBsaWtlIGhvdyB0aGUgaW9jdGwoKSBwYXNzdGhydQo+
PiB3b3JrcyBpbiBOVk1lLCBidXQgYXMgbWVudGlvbmVkIGFib3ZlLCB3ZSB3b3VsZCBsaWtlIHRv
IGVuYWJsZSBhbgo+PiBhc3luYygpIHBhc3N0aHJ1IHBhdGguCj4KPlRoYXQgaXMgZG9uZSB3aXRo
IGJzZyBmb3IgU0NTSSBJIGJlbGlldmUuIFlvdSBtYXkgd2FudCB0byBoYXZlIGEgbG9vayBhcm91
bmQKPnRoZXJlLiBUaGUgU0cgZHJpdmVyIHVzZWQgdG8gaGF2ZSB0aGUgd3JpdGUoKSBzeXN0ZW0g
Y2FsbCBtYXBwZWQgdG8gImlzc3VpbmcgYQo+Y29tbWFuZCIgYW5kIHJlYWQoKSBmb3IgImdldHRp
bmcgYSBjb21tYW5kIHJlc3VsdCIuIFRoYXQgd2FzIHJlbW92ZWQgaG93ZXZlci4KPkJ1dCBJIHRo
aW5rIGJzZyBoYXMgYSByZXBsYWNlbWVudCBmb3IgdGhhdCBkZWZ1bmN0IGFzeW5jIHBhc3N0aHJv
dWdoIGludGVyZmFjZS4KPk5vdCBzdXJlLiBJIGhhdmUgbm90IGxvb2tlZCBhdCB0aGF0IGZvciBh
IHdoaWxlLgo+CgpUaGFua3MgZm9yIHRoZSBwb2ludGVyOyBJIHdhcyBub3QgYXdhcmUgb2YgdGhp
cy4gV2Ugd2lsbCBsb29rIGludG8gaXQuCgpUaGFua3MgYWdhaW4gZm9yIHRoZSBoZWxwIERhbWll
biEKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
