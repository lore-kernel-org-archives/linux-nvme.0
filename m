Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08556C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF3AD2071A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 16:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EstlMzJX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="n2a6eLWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3AD2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9I7ANtDkMZwP/se6Am4KAICPi3USQawi0gJaVu8keTs=; b=EstlMzJXI125CvkmKJhb6Q6IU
	jyO93IizsVZttuj7KXMa7zYis5fZmuFlFgiX5tg8awArtH2H2ZfXqUYaNnWRZl2uFu6MQ19PI1S2r
	Wop3xGlbyYhwwZFwXHniF0DLORZ7MynRXuwubKCe08MiS1RNTAS7ubejT8T0rkanw16REGq5kVp14
	cvVULc8Js6B4K4rAHmAhsctVCqjxF4nXuzIzPd74Ykzs9f43VugYSwG7MRdydE9al5Zfx5zDlVbRi
	B2OrXHzLQB+DIhwjQP5NQ7rfeK6I2wI3KXUom7piFX0JBKuW2LTbEq2M4T3xLv4RPo52D2TP1MFTq
	NR7fAdHoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlEDn-0006l2-Gq; Tue, 16 Jun 2020 16:13:59 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlEDk-0006ju-Re
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 16:13:58 +0000
Received: by mail-ej1-x642.google.com with SMTP id w16so21598334ejj.5
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=bXcqhpFhMhk8ZY77KeGqnjs+Bytviss9YJw9YsVxTJs=;
 b=n2a6eLWR3NoMSw+HpzxNmzS9zLNPjd338tmR6hrKmRQtkz5V1gNKYZyAbjyjv3o3xX
 +6L3HLzvqWXweOkIeDhWyX4VHoQPUVFFnhLbSLIAoCnqIm0G5wghhljvFqdZB57IFaSH
 hadU/xYGKEyXrN3C9XrRMT5fsRxbW78j1Epq24w8xeO5vuDmf75Nedevt/zI5lePxfCE
 wdfkpYJBMEKn0K1vlowTEOUTTWK/Q1EdHIj1QIJhBalSXjAYRS1Rlu34Twig2G2XLUUk
 ua1LL5Q/OyFwipQ+Ggl/+WR6O6dX9HgNtA2mmiHIblsNPK48VgOFM2q5THXsQo410KVR
 41JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bXcqhpFhMhk8ZY77KeGqnjs+Bytviss9YJw9YsVxTJs=;
 b=MXKoq5uZkoYBFrDnpmkObwnQ08o3quh7QKPaIf4fYMhvHYhEiY4EtbON+VPqsmfE/+
 I/JbWixe2Pnkr1khHj0/ZYgS2ilPE95+eKcRJ/UTSV9zijTLUv01Fu+j7vqDgKYOHbzR
 szsOSGYY267s2MRvVmV+MaD2YtJXzUrhgqBXWKcvv+JRVkmuLzMJYQ/v9+SCT3Md7UT1
 yeDCLNzbALw17j+AmzU0fQvtHzi9SwDT7uNyzrKiO7ttoniEbW6CDxEPSqiJQRaWWcuB
 i9iAnxLS/htAaksUcc0hIn/N3TjqyMQhw1ZQHLNutPJyDBQBFfOw2579fwG4bK2FIr0M
 rG8Q==
X-Gm-Message-State: AOAM531Lz4Qk3JSOeLnWE2cwrlJJJfh6A8T6JCLLV/DGdDWrVN/JUovu
 GuvKrdq5eC4zDbtUHB0eWa4YDA==
X-Google-Smtp-Source: ABdhPJzKupq0vpkrwjE8NxyCitWzJPu8lVhXR8vDNa7MHrIVP+xXxWO84QoS1vbEwJCIUoMmtziZMQ==
X-Received: by 2002:a17:906:5418:: with SMTP id
 q24mr3483880ejo.266.1592324035322; 
 Tue, 16 Jun 2020 09:13:55 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id s14sm11378495ejd.111.2020.06.16.09.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 09:13:54 -0700 (PDT)
Date: Tue, 16 Jun 2020 18:13:54 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616161354.q3p2vy2go6tszs67@mpHalley.localdomain>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <20200616154812.GA521206@dhcp-10-100-145-180.wdl.wdc.com>
 <20200616155526.wxjoufhhxkwet5ya@MacBook-Pro.localdomain>
 <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200616160712.GB521206@dhcp-10-100-145-180.wdl.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_091356_895405_EF95BAF1 
X-CRM114-Status: GOOD (  13.10  )
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
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
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

T24gMTYuMDYuMjAyMCAwOTowNywgS2VpdGggQnVzY2ggd3JvdGU6Cj5PbiBUdWUsIEp1biAxNiwg
MjAyMCBhdCAwNTo1NToyNlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiBPbiAx
Ni4wNi4yMDIwIDA4OjQ4LCBLZWl0aCBCdXNjaCB3cm90ZToKPj4gPiBPbiBUdWUsIEp1biAxNiwg
MjAyMCBhdCAwNTowMjoxN1BNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiA+ID4g
VGhpcyBkZXBlbmRzIHZlcnkgbXVjaCBvbiBob3cgdGhlIEZTIC8gYXBwbGljYXRpb24gaXMgbWFu
YWdpbmcKPj4gPiA+IHN0cmlwcGluZy4gQXQgdGhlIG1vbWVudCBvdXIgbWFpbiB1c2UgY2FzZSBp
cyBlbmFibGluZyB1c2VyLXNwYWNlCj4+ID4gPiBhcHBsaWNhdGlvbnMgc3VibWl0dGluZyBJL09z
IHRvIHJhdyBaTlMgZGV2aWNlcyB0aHJvdWdoIHRoZSBrZXJuZWwuCj4+ID4gPgo+PiA+ID4gQ2Fu
IHdlIGVuYWJsZSB0aGlzIHVzZSBjYXNlIHRvIHN0YXJ0IHdpdGg/Cj4+ID4KPj4gPiBJIHRoaW5r
IHRoaXMgYWxyZWFkeSBwcm92aWRlcyB0aGF0LiBZb3UgY2FuIHNldCB0aGUgbnNpZCB2YWx1ZSB0
bwo+PiA+IHdoYXRldmVyIHlvdSB3YW50IGluIHRoZSBwYXNzdGhyb3VnaCBpbnRlcmZhY2UsIHNv
IGEgbmFtZXNwYWNlIGJsb2NrCj4+ID4gZGV2aWNlIGlzIG5vdCByZXF1aXJlZCB0byBpc3N1ZSBJ
L08gdG8gYSBaTlMgbmFtZXNwYWNlIGZyb20gdXNlciBzcGFjZS4KPj4KPj4gTW1tbW0uIFByb2Js
ZW0gbm93IGlzIHRoYXQgdGhlIGNoZWNrIG9uIHRoZSBudm1lIGRyaXZlciBwcmV2ZW50cyB0aGUg
Wk5TCj4+IG5hbWVzcGFjZSBmcm9tIGJlaW5nIGluaXRpYWxpemVkLiBBbSBJIG1pc3Npbmcgc29t
ZXRoaW5nPwo+Cj5IbSwgb2theSwgaXQgbWF5IG5vdCB3b3JrIGZvciB5b3UuIFdlIG5lZWQgdGhl
IGRyaXZlciB0byBjcmVhdGUgYXQgbGVhc3QKPm9uZSBuYW1lc3BhY2Ugc28gdGhhdCB3ZSBoYXZl
IHRhZ3MgYW5kIHJlcXVlc3RfcXVldWUuIElmIHlvdSBoYXZlIHRoYXQsCj55b3UgY2FuIGlzc3Vl
IElPIHRvIGFueSBvdGhlciBhdHRhY2hlZCBuYW1lc3BhY2UgdGhyb3VnaCB0aGUgcGFzc3Rocm91
Z2gKPmludGVyZmFjZSwgYnV0IHdlIGNhbid0IGFzc3VtZSB0aGVyZSBpcyBhbiBhdmFpbGFibGUg
bmFtZXNwYWNlLgoKVGhhdCBtYWtlcyBzZW5zZSBmb3Igbm93LgoKVGhlIG5leHQgc3RlcCBmb3Ig
dXMgaXMgdG8gZW5hYmxlIGEgcGFzc3Rocm91Z2ggb24gdXJpbmcsIG1ha2luZyBzdXJlCnRoYXQg
SS9PcyBkbyBub3Qgc3BsaXQuCgpEb2VzIHRoaXMgbWFrZSBzZW5zZSB0byB5b3U/CgpUaGFua3Ms
CkphdmllcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
