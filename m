Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50497C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:40:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFE7204EA
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A1YX61lL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="WzRE8OKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFE7204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KHVitF9zmMW9kB6uGV9LBaouGKc2jwX+ob0a53//V0E=; b=A1YX61lLNlM39P
	SNY7aEZutN4fe0TnnWjVNVOOrmCdbxJqNJz98n2Cj/EFANgc1JYWqmWFoLzIwJcDI5Ja1muvslj0V
	hMAhXK7Zzybv+CQXFwlUTl1S6U6DsCk+16dCR4kP2wDVm/7kJgMqJ7hFWS/RN+rx8t/hjbJNxLSid
	xrvX7rxnD0Y7BcHe+G7ZSEnq6L6uhE7tix8rlpbBSyiNfoFlhaL4AvZT31ti77R6S1c6xXGfcm80/
	hFq6T4Tm6hEVQqc+MjKQ07GMBTSJEHp2oMyYD3zBuNU0yxrf7kC0/eIb3dtR6iEf4QBc18RkrOlFe
	PSA5An/CPqvdYB8TmZNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLw4-0007zy-3y; Fri, 19 Jun 2020 18:40:20 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLw0-0007zG-FF
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:40:17 +0000
Received: by mail-oi1-x242.google.com with SMTP id t25so9290525oij.7
 for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2020 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VQ9K1KPsC1AxCg2WQw20A8A+1B/U0h1NofeCWjoKf/U=;
 b=WzRE8OKgYeBMsudMxocNKWuutVLmPfmen63YhDp+JhMxYN1ewqFTWrSgRlOy1xSRcG
 PpRNJShVtDbxZGPqh7Euh+tVjQZI+R3QPopi6ivmCVD3gGM0596gIFWr4sOHSmLJBSrc
 ccNj/YBdrAY7CA7SPp+HazR0xvzhjydkutT1uUB9NPAy5mp7AuvXReAxdQPSj9RnDySS
 Gt400H0FgcEzxtpmyJQwQPm24kvuWetDwWFtUZsDr0RDRJP8Bdoga/RDAjUnfSow9T22
 bJ/Oq5MAX3triPdD4uQcC/ipaHtpGuCk4iXAMNtu36SktiqDb9kFb97nndNLEBx4iDdI
 Jdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VQ9K1KPsC1AxCg2WQw20A8A+1B/U0h1NofeCWjoKf/U=;
 b=CWel4M0pTsElUUlJXABIQ6bWVeySp5JTcB9ExIpgVA6VOizdHndvBrp+5CGOiM/bZE
 h8Dat13PTkiwACGQ9SYd+ZvJJwf8IBD6iEjnbYY05tIrkgj5Xp3jcVmAO3JVCFTB86bb
 Z6BajY1d+L+0U9QLEU7T7W8f1LXTByYnFvR89JAPUSpGr/TlPjWXfHEo5kI7bAwARjAg
 Go51bhfr+gkgSXdrE88tbAqzSV8p8GTlc8ige1XHMbTQzcRBLPkExFp3c/hIiJftQoVd
 CeB6lRiQH/4WaUuUFNWvUtXaFetS+8Rz8TQT1sGXG5EvcfEHox0ar0ikNLr7t6savhbY
 M+7w==
X-Gm-Message-State: AOAM530Gwz7e04tmiW2rMBh2xFrARnRe4KQdXD9SUV3bVvjob1Ad3+Cp
 jScj876VxWo00mOBbPO4jcYJskBPOZAMQM6xPSPI4w==
X-Google-Smtp-Source: ABdhPJyk3XAOXnBaPtc4RJnRX6rjDA/CR2prnluNjPITmd68l6UCpJPgLR9HK/W4peLzN5dCG6a96aLB1MGR4HFWBGw=
X-Received: by 2002:aca:d15:: with SMTP id 21mr3930082oin.41.1592592015216;
 Fri, 19 Jun 2020 11:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
 <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
In-Reply-To: <61101beb-de48-7556-160f-cfd45bf72868@lightnvm.io>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Fri, 19 Jun 2020 11:40:04 -0700
Message-ID: <CAJbgVnXodOZg_UAe0s5qu_t8rKu9KU=zt4qhfDpnNi0NBvbLKg@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_114016_517533_A05FFC85 
X-CRM114-Status: GOOD (  16.91  )
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
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhdCBtYWtlcyBzZW5zZS4gV2UgYXJlIGdlbmVyYWxseSBwYXlpbmcgYSBoaWdoIHByaWNlIGZv
cgppbXBsZW1lbnRpbmcgaW4tb3JkZXIgaW50ZXJmYWNlcyBvdmVyIG91dC1vZi1vcmRlciBjb21t
dW5pY2F0aW9uCmNoYW5uZWxzIChlLmcuIFRDUCBidWZmZXJzKSBhbmQgYXBwZW5kKCkgc2VlbXMg
dG8gYmUgYSBtdWNoIG1vcmUKbGlnaHR3ZWlnaHQgc29sdXRpb24uCgpPbiBGcmksIEp1biAxOSwg
MjAyMCBhdCAxMToyNSBBTSBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdodG52bS5pbz4gd3JvdGU6
Cj4KPiBPbiAxOS8wNi8yMDIwIDIwLjE3LCBIZWluZXIgTGl0eiB3cm90ZToKPiA+PiBPbiBGcmks
IEp1biAxOSwgMjAyMCBhdCAxMTowODoyNkFNIC0wNzAwLCBIZWluZXIgTGl0eiB3cm90ZToKPiA+
Pj4gSGkgTWF0aWFzLAo+ID4+PiBubywgSSBhbSByYXRoZXIgc2F5aW5nIHRoYXQgdGhlIExpbnV4
IGtlcm5lbCBoYXMgYSBkZWZpY2l0IG9yIGF0IGxlYXN0Cj4gPj4+IGlzIG5vdCBhIGdvb2QgZml0
IGZvciBaTlMgYmVjYXVzZSBpdCBjYW5ub3QgZW5mb3JjZSBpbi1vcmRlciBkZWxpdmVyeS4KPiA+
PiBGWUksIHRoZSBudm1lIHByb3RvY29sIGNhbid0IGV2ZW4gZW5mb3JjZSBpbi1vcmRlciBkZWxp
dmVyeSwgc28gY2FsbGluZwo+ID4+IG91dCBsaW51eCBmb3IgdGhpcyBpcyBhIG1vb3QgcG9pbnQu
Cj4gPiBIb3cgZG9lcyBpdCB3b3JrIGluIFNQREsgdGhlbj8gSSBoYWQgdW5kZXJzdG9vZCB0aGF0
IFNQREsgc3VwcG9ydGVkCj4gPiBRRD4xIGZvciBaTlMgZGV2aWNlcy4KPiBJdCBkb2Vzbid0LiBP
dXQgb2Ygb3JkZXIgZGVsaXZlcnkgaXMgbm90IGd1YXJhbnRlZWQgaW4gTlZNZS4KPiA+IEkgYW0g
bm90IHNheWluZyB0aGF0IExpbnV4IGlzIHRoZSBvbmx5IHByb2JsZW0uIFRoZSBmYWN0IHJlbWFp
bnMgdGhhdAo+ID4gb3V0IG9mIG9yZGVyIGRlbGl2ZXJ5IGlzIG5vdCBhIGdvb2QgZml0IGZvciBh
biBpbnRlcmZhY2UgdGhhdCByZXF1aXJlcwo+ID4gc2VxdWVudGlhbCB3cml0ZXMuCj4KPiBUaGF0
IHdoeSB6b25lIGFwcGVuZCB3YXMgaW50cm9kdWNlZCBpbiBaTlMuIEl0IHJlbW92ZXMgdGhpcyBj
b25zdHJhaW50LAo+IGFuZCBtYWtlcyBpdCBzdWNoIHRoYXQgYW55IHByb2Nlc3MgKG9yIGhvc3Qp
IGNhbiB3cml0ZSB0byBhIHNwZWNpZmljCj4gem9uZS4gSXQncyBuZWF0ISBUaGF0IGlzIHdoeSB0
aGUgY29tbWFuZCB3YXMgaW50cm9kdWNlZC4KPgo+IEl0IGlzIG5vdCBvbmx5IExpbnV4IHNwZWNp
ZmljIC0gaXQgYXBwbGllcyB0byBldmVyeW9uZSB0aGF0IHdhbnRzIHRvIHVzZQo+IGl0LiBJdCBp
cyBzb2x2aW5nIGEgZnVuZGFtZW50YWwgZGlzdHJpYnV0ZWQgc3lzdGVtIHByb2JsZW0sIGFzIGl0
Cj4gcmVtb3ZlcyB0aGUgbmVlZCBmb3IgZmluZS1ncmFpbmVkIGNvb3JkaW5hdGluZyBiZXR3ZWVu
IHByb2Nlc3Mgb3IgaG9zdC4KPiBJdCBhbGxvd3MgdGhlIFNTRCB0byBjb29yZGluYXRlIGRhdGEg
cGxhY2VtZW50LCB3aGljaCBoaXN0b3JpY2FsbHkgaGFzCj4gYmVlbiBkb25lIGJ5IHRoZSBob3N0
LiBJdCBpcyBhd2Vzb21lIQo+Cj4gPgo+ID4+PiBUaGUgcmVxdWlyZW1lbnQgb2Ygc2VxdWVudGlh
bCB3cml0ZXMgYmFzaWNhbGx5IGltcG9zZXMgdGhpcwo+ID4+PiByZXF1aXJlbWVudC4gQXBwZW5k
IGVzc2VudGlhbGx5IGEgTGludXggc3BlY2lmaWMgZml4IG9uIHRoZSBaTlMgbGV2ZWwKPiA+Pj4g
YW5kIHRoYXQgZW5mb3JjaW5nIG9yZGVyaW5nIHdvdWxkIGJlIGEgY2xlYW5lciB3YXkgdG8gZW5h
YmxlIFFEPjEuCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
