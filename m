Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E4BC33C9E
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 10:18:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346E62073A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9WxN/yU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="EDnLJIr1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346E62073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P0r9tWfCh+zIOb6mqOwCsbgmOEPtao7ak3ywJtPQWAA=; b=W9WxN/yUkDZ9TFNhLGxosgd4M
	7HJnxLBj6WwBHPJYxn3SR3Dk2/Y7dVkWa4sCbGntYMDX4lMRXHPvhrpfs7zPUjtCAZeIBBY8wcHAL
	W8z8ji/jx6gnqpeYJU0Db59soN9CNUKjGfKFE8EWob/9iv0FrkUKppgxOzZZyEpSK+dm7506Ou9Sr
	0Rs8DcDikwAlDyFmVNABcdsPTQs07oap1VV2VlXLYTT/PT/aYEiwFG0Mm7jC6AjGh1/sQzip+g1dB
	8jyoFLpuROo0YG1eLZfxhRizAzVo1RFnIJ9eg9+FpegUcwja5cAeO+fL5YukuPgmH9Dvt9Q84ytFG
	bvU+qSScA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ip8Ph-0000Pv-Je; Wed, 08 Jan 2020 10:18:09 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ip8Pe-0000OP-FP
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 10:18:08 +0000
Received: by mail-lj1-x241.google.com with SMTP id j1so2753749lja.2
 for <linux-nvme@lists.infradead.org>; Wed, 08 Jan 2020 02:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=xKXl8mES0mj219S7GiqAgh2w0+y6gtLh3SMd5LwoB2w=;
 b=EDnLJIr1hw5V3+k4YlmnhWxmnQgzORCuxNgnWc/PF3iJS2BrzhooA1Ms4qf0rpqqEa
 DAaMhr79XAz7dhgrAPr6l8R1scHIGJvjPrDhEZub4HXKW7acxGnY8peAqLOZ0opcx5+h
 d9cL5q78Z8EqcMY8wy0D/XkfUE4Z4/T4LU+S68mm2cBAaqDVS1Qa6h4eEKi9fMPjj1Uk
 ADnUeNR3j/Y+e/TDpivRiMbMFx0CWCS38J1s5EobOHBk4iq/hX27hHMVq5rD2phlaCv3
 cGtf3mAn0OxKkL/9chgNJPHji+mZta8QWOPc30epJ/5giT2W3hlEV+JRWTCQ50Ume2lj
 z6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xKXl8mES0mj219S7GiqAgh2w0+y6gtLh3SMd5LwoB2w=;
 b=FyLGVWPSZ+opAeSBUVntGxKHUxyYnGcPgNufYLSs+yApDUnOHz/W7ieefMhoDELTN/
 7UxWcgY3CzA6W+zgYqBPQD67Ium72RzxMTTl9v2LWV/7/Y71acl4vB3AS2xBTPofE2lw
 IKBRhnCHKqpq40ysu+OooNeKvkHToJr1TVaopSOf6WaDajT9MlfzaP6ObLN6eCHws5S4
 iZ7AvfXN637MSWl+D92YWQRXSKC7NxV5DBefMZEynhwjknR3oBoAfCzKJyiT9TqwpE41
 GbrfkUNScpnhLB5fyQjRUY20MwnhhpStQiK8SB8fro7cbhcW0AOcUYW5cbUNINDNElId
 lx6Q==
X-Gm-Message-State: APjAAAXah0scBx0xD6DOwGOxnQQWtvjxCyPjHnCSxZb8aL25/YuJ+Vu+
 0eGJ28QYIlb4HUq3J/dshSf+xA==
X-Google-Smtp-Source: APXvYqxkrQcJp1PRSIjXq1IfBZjXHOW7grwryb0mwHMQOGl3j6AuqxM80gYItsKZXFTgXF0ueCxUyw==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr2396280ljk.15.1578478681198; 
 Wed, 08 Jan 2020 02:18:01 -0800 (PST)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id q13sm1157778ljj.63.2020.01.08.02.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 02:18:00 -0800 (PST)
Date: Wed, 8 Jan 2020 11:17:59 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20200108101759.32gkjxakxigolail@mpHalley.local>
References: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5749820C322B40C7DBBBCA02863F0@BYAPR04MB5749.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_021806_516970_CCEA9ABB 
X-CRM114-Status: GOOD (  17.56  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Stephen Bates <sbates@raithlin.com>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "bvanassche@acm.org" <bvanassche@acm.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "frederick.knight@netapp.com" <frederick.knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Matias Bjorling <Matias.Bjorling@wdc.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 "stephen@eideticom.com" <stephen@eideticom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDcuMDEuMjAyMCAxODoxNCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+SGkgYWxsLAo+
Cj4qIEJhY2tncm91bmQgOi0KPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPkNvcHkgb2ZmbG9hZCBpcyBhIGZl
YXR1cmUgdGhhdCBhbGxvd3MgZmlsZS1zeXN0ZW1zIG9yIHN0b3JhZ2UgZGV2aWNlcwo+dG8gYmUg
aW5zdHJ1Y3RlZCB0byBjb3B5IGZpbGVzL2xvZ2ljYWwgYmxvY2tzIHdpdGhvdXQgcmVxdWlyaW5n
Cj5pbnZvbHZlbWVudCBvZiB0aGUgbG9jYWwgQ1BVLgo+Cj5XaXRoIHJlZmVyZW5jZSB0byB0aGUg
UklTQy1WIHN1bW1pdCBrZXlub3RlIFsxXSBzaW5nbGUgdGhyZWFkZWQKPnBlcmZvcm1hbmNlIGlz
IGxpbWl0aW5nIGR1ZSB0byBEZW5hcmQgc2NhbGluZyBhbmQgbXVsdGktdGhyZWFkZWQKPnBlcmZv
cm1hbmNlIGlzIHNsb3dpbmcgZG93biBkdWUgTW9vcmUncyBsYXcgbGltaXRhdGlvbnMuIFdpdGgg
dGhlIHJpc2UKPm9mIFNOSUEgQ29tcHV0YXRpb24gVGVjaG5pY2FsIFN0b3JhZ2UgV29ya2luZyBH
cm91cCAoVFdHKSBbMl0sCj5vZmZsb2FkaW5nIGNvbXB1dGF0aW9ucyB0byB0aGUgZGV2aWNlIG9y
IG92ZXIgdGhlIGZhYnJpY3MgaXMgYmVjb21pbmcKPnBvcHVsYXIgYXMgdGhlcmUgYXJlIHNldmVy
YWwgc29sdXRpb25zIGF2YWlsYWJsZSBbMl0uIE9uZSBvZiB0aGUgY29tbW9uCj5vcGVyYXRpb24g
d2hpY2ggaXMgcG9wdWxhciBpbiB0aGUga2VybmVsIGFuZCBpcyBub3QgbWVyZ2VkIHlldCBpcyBD
b3B5Cj5vZmZsb2FkIG92ZXIgdGhlIGZhYnJpY3Mgb3Igb24gdG8gdGhlIGRldmljZS4KPgo+KiBQ
cm9ibGVtIDotCj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj5UaGUgb3JpZ2luYWwgd29yayB3aGljaCBpcyBk
b25lIGJ5IE1hcnRpbiBpcyBwcmVzZW50IGhlcmUgWzNdLiBUaGUKPmxhdGVzdCB3b3JrIHdoaWNo
IGlzIHBvc3RlZCBieSBNaWt1bGFzIFs0XSBpcyBub3QgbWVyZ2VkIHlldC4gVGhlc2UgdHdvCj5h
cHByb2FjaGVzIGFyZSB0b3RhbGx5IGRpZmZlcmVudCBmcm9tIGVhY2ggb3RoZXIuIFNldmVyYWwg
c3RvcmFnZQo+dmVuZG9ycyBkaXNjb3VyYWdlIG1peGluZyBjb3B5IG9mZmxvYWQgcmVxdWVzdHMg
d2l0aCByZWd1bGFyIFJFQUQvV1JJVEUKPkkvTy4gQWxzbywgdGhlIGZhY3QgdGhhdCB0aGUgb3Bl
cmF0aW9uIGZhaWxzIGlmIGEgY29weSByZXF1ZXN0IGV2ZXIKPm5lZWRzIHRvIGJlIHNwbGl0IGFz
IGl0IHRyYXZlcnNlcyB0aGUgc3RhY2sgaXQgaGFzIHRoZSB1bmZvcnR1bmF0ZQo+c2lkZS1lZmZl
Y3Qgb2YgcHJldmVudGluZyBjb3B5IG9mZmxvYWQgZnJvbSB3b3JraW5nIGluIHByZXR0eSBtdWNo
Cj5ldmVyeSBjb21tb24gZGVwbG95bWVudCBjb25maWd1cmF0aW9uIG91dCB0aGVyZS4KPgo+KiBD
dXJyZW50IHN0YXRlIG9mIHRoZSB3b3JrIDotCj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Cj5XaXRoIFszXSBi
ZWluZyBoYXJkIHRvIGhhbmRsZSBhcmJpdHJhcnkgRE0vTUQgc3RhY2tpbmcgd2l0aG91dAo+c3Bs
aXR0aW5nIHRoZSBjb21tYW5kIGluIHR3bywgb25lIGZvciBjb3B5aW5nIElOIGFuZCBvbmUgZm9y
IGNvcHlpbmcKPk9VVC4gV2hpY2ggaXMgdGhlbiBkZW1vbnN0cmF0ZWQgYnkgdGhlIFs0XSB3aHkg
WzNdIGl0IGlzIG5vdCBhIHN1aXRhYmxlCj5jYW5kaWRhdGUuIEFsc28sIHdpdGggWzRdIHRoZXJl
IGlzIGFuIHVucmVzb2x2ZWQgcHJvYmxlbSB3aXRoIHRoZQo+dHdvLWNvbW1hbmQgYXBwcm9hY2gg
YWJvdXQgaG93IHRvIGhhbmRsZSBjaGFuZ2VzIHRvIHRoZSBETSBsYXlvdXQKPmJldHdlZW4gYW4g
SU4gYW5kIE9VVCBvcGVyYXRpb25zLgo+Cj4qIFdoeSBMaW51eCBLZXJuZWwgU3RvcmFnZSBTeXN0
ZW0gbmVlZHMgQ29weSBPZmZsb2FkIHN1cHBvcnQgbm93ID8KPi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPldp
dGggdGhlIHJpc2Ugb2YgdGhlIFNOSUEgQ29tcHV0YXRpb25hbCBTdG9yYWdlIFRXRyBhbmQgc29s
dXRpb25zIFsyXSwKPmV4aXN0aW5nIFNDU0kgWENvcHkgc3VwcG9ydCBpbiB0aGUgcHJvdG9jb2ws
IHJlY2VudCBhZHZhbmNlbWVudCBpbiB0aGUKPkxpbnV4IEtlcm5lbCBGaWxlIFN5c3RlbSBmb3Ig
Wm9uZWQgZGV2aWNlcyAoWm9uZWZzIFs1XSksIFBlZXIgdG8gUGVlcgo+RE1BIHN1cHBvcnQgaW4g
dGhlIExpbnV4IEtlcm5lbCBtYWlubHkgZm9yIE5WTWUgZGV2aWNlcyBbN10gYW5kCj5ldmVudHVh
bGx5IE5WTWUgRGV2aWNlcyBhbmQgc3Vic3lzdGVtIChOVk1lIFBDSWUvTlZNZU9GKSB3aWxsIGJl
bmVmaXQKPmZyb20gQ29weSBvZmZsb2FkIG9wZXJhdGlvbi4KPgo+V2l0aCB0aGlzIGJhY2tncm91
bmQgd2UgaGF2ZSBzaWduaWZpY2FudCBudW1iZXIgb2YgdXNlLWNhc2VzIHdoaWNoIGFyZQo+c3Ry
b25nIGNhbmRpZGF0ZXMgd2FpdGluZyBmb3Igb3V0c3RhbmRpbmcgTGludXggS2VybmVsIEJsb2Nr
IExheWVyIENvcHkKPk9mZmxvYWQgc3VwcG9ydCwgc28gdGhhdCBMaW51eCBLZXJuZWwgU3RvcmFn
ZSBzdWJzeXN0ZW0gY2FuIHRvIGFkZHJlc3MKPnByZXZpb3VzbHkgbWVudGlvbmVkIHByb2JsZW1z
IFsxXSBhbmQgYWxsb3cgZWZmaWNpZW50IG9mZmxvYWRpbmcgb2YgdGhlCj5kYXRhIHJlbGF0ZWQg
b3BlcmF0aW9ucy4gKFN1Y2ggYXMgbW92ZS9jb3B5IGV0Yy4pCj4KPkZvciByZWZlcmVuY2UgZm9s
bG93aW5nIGlzIHRoZSBsaXN0IG9mIHRoZSB1c2UtY2FzZXMvY2FuZGlkYXRlcyB3YWl0aW5nCj5m
b3IgQ29weSBPZmZsb2FkIHN1cHBvcnQgOi0KPgo+MS4gU0NTSS1hdHRhY2hlZCBzdG9yYWdlIGFy
cmF5cy4KPjIuIFN0YWNraW5nIGRyaXZlcnMgc3VwcG9ydGluZyBYQ29weSBETS9NRC4KPjMuIENv
bXB1dGF0aW9uYWwgU3RvcmFnZSBzb2x1dGlvbnMuCj43LiBGaWxlIHN5c3RlbXMgOi0gTG9jYWws
IE5GUyBhbmQgWm9uZWZzLgo+NC4gQmxvY2sgZGV2aWNlcyA6LSBEaXN0cmlidXRlZCwgbG9jYWws
IGFuZCBab25lZCBkZXZpY2VzLgo+NS4gUGVlciB0byBQZWVyIERNQSBzdXBwb3J0IHNvbHV0aW9u
cy4KPjYuIFBvdGVudGlhbGx5IE5WTWUgc3Vic3lzdGVtIGJvdGggTlZNZSBQQ0llIGFuZCBOVk1l
T0YuCj4KPiogV2hhdCB3ZSB3aWxsIGRpc2N1c3MgaW4gdGhlIHByb3Bvc2VkIHNlc3Npb24gPwo+
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KPgo+SSdkIGxpa2UgdG8gcHJvcG9zZSBhIHNlc3Npb24gdG8gZ28gb3Zl
ciB0aGlzIHRvcGljIHRvIHVuZGVyc3RhbmQgOi0KPgo+MS4gV2hhdCBhcmUgdGhlIGJsb2NrZXJz
IGZvciBDb3B5IE9mZmxvYWQgaW1wbGVtZW50YXRpb24gPwo+Mi4gRGlzY3Vzc2lvbiBhYm91dCBo
YXZpbmcgYSBmaWxlIHN5c3RlbSBpbnRlcmZhY2UuCj4zLiBEaXNjdXNzaW9uIGFib3V0IGhhdmlu
ZyByaWdodCBzeXN0ZW0gY2FsbCBmb3IgdXNlci1zcGFjZS4KPjQuIFdoYXQgaXMgdGhlIHJpZ2h0
IHdheSB0byBtb3ZlIHRoaXMgd29yayBmb3J3YXJkID8KPjUuIEhvdyBjYW4gd2UgaGVscCB0byBj
b250cmlidXRlIGFuZCBtb3ZlIHRoaXMgd29yayBmb3J3YXJkID8KPgo+KiBSZXF1aXJlZCBQYXJ0
aWNpcGFudHMgOi0KPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4KPkknZCBsaWtlIHRvIGludml0ZSBibG9jayBs
YXllciwgZGV2aWNlIGRyaXZlcnMgYW5kIGZpbGUgc3lzdGVtCj5kZXZlbG9wZXJzIHRvOi0KPgo+
MS4gU2hhcmUgdGhlaXIgb3BpbmlvbiBvbiB0aGUgdG9waWMuCj4yLiBTaGFyZSB0aGVpciBleHBl
cmllbmNlIGFuZCBhbnkgb3RoZXIgaXNzdWVzIHdpdGggWzRdLgo+My4gVW5jb3ZlciBhZGRpdGlv
bmFsIGRldGFpbHMgdGhhdCBhcmUgbWlzc2luZyBmcm9tIHRoaXMgcHJvcG9zYWwuCj4KPlJlcXVp
cmVkIGF0dGVuZGVlcyA6LQo+Cj5NYXJ0aW4gSy4gUGV0ZXJzZW4KPkplbnMgQXhib2UKPkNocmlz
dG9waCBIZWxsd2lnCj5CYXJ0IFZhbiBBc3NjaGUKPlN0ZXBoZW4gQmF0ZXMKPlphY2ggQnJvd24K
PlJvbGFuZCBEcmVpZXIKPlJpYyBXaGVlbGVyCj5Ucm9uZCBNeWtsZWJ1c3QKPk1pa2UgU25pdHpl
cgo+S2VpdGggQnVzY2gKPlNhZ2kgR3JpbWJlcmcKPkhhbm5lcyBSZWluZWNrZQo+RnJlZGVyaWNr
IEtuaWdodAo+TWlrdWxhcyBQYXRvY2thCj5NYXRpYXMgQmrDuHJsaW5nCj4KPlsxXWh0dHBzOi8v
Y29udGVudC5yaXNjdi5vcmcvd3AtY29udGVudC91cGxvYWRzLzIwMTgvMTIvQS1OZXctR29sZGVu
LUFnZS1mb3ItQ29tcHV0ZXItQXJjaGl0ZWN0dXJlLUhpc3RvcnktQ2hhbGxlbmdlcy1hbmQtT3Bw
b3J0dW5pdGllcy1EYXZpZC1QYXR0ZXJzb24tLnBkZgo+WzJdIGh0dHBzOi8vd3d3LnNuaWEub3Jn
L2NvbXB1dGF0aW9uYWwKPmh0dHBzOi8vd3d3Lm5hcGF0ZWNoLmNvbS9zdXBwb3J0L3Jlc291cmNl
cy9zb2x1dGlvbi1kZXNjcmlwdGlvbnMvbmFwYXRlY2gtc21hcnRuaWMtc29sdXRpb24tZm9yLWhh
cmR3YXJlLW9mZmxvYWQvCj4gICAgICBodHRwczovL3d3dy5laWRldGljb20uY29tL3Byb2R1Y3Rz
Lmh0bWwKPmh0dHBzOi8vd3d3LnhpbGlueC5jb20vYXBwbGljYXRpb25zL2RhdGEtY2VudGVyL2Nv
bXB1dGF0aW9uYWwtc3RvcmFnZS5odG1sCj5bM10gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L21rcC9saW51eC5naXQgeGNvcHkKPls0XSBodHRwczovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9saW51eC1ibG9jay9tc2cwMDU5OS5odG1sCj5bNV0gaHR0cHM6Ly9s
d24ubmV0L0FydGljbGVzLzc5MzU4NS8KPls2XSBodHRwczovL252bWV4cHJlc3Mub3JnL25ldy1u
dm1ldG0tc3BlY2lmaWNhdGlvbi1kZWZpbmVzLXpvbmVkLQo+bmFtZXNwYWNlcy16bnMtYXMtZ28t
dG8taW5kdXN0cnktdGVjaG5vbG9neS8KPls3XSBodHRwczovL2dpdGh1Yi5jb20vc2JhdGVzMTMw
MjcyL2xpbnV4LXAycG1lbQo+WzhdIGh0dHBzOi8va2VybmVsLmRrL2lvX3VyaW5nLnBkZgo+Cj5S
ZWdhcmRzLAo+Q2hhaXRhbnlhCgpJIHRoaW5rIHRoaXMgaXMgZ29vZCB0b3BpYyBhbmQgSSB3b3Vs
ZCBsaWtlIHRvIHBhcnRpY2lwYXRlIGluIHRoZQpkaXNjdXNzaW9uIHRvby4gSSB0aGluayB0aGF0
IExvZ2FuIEd1bnRob3JwZSB3b3VsZCBhbHNvIGJlIGludGVyZXN0ZWQKKENjKS4gQWRkaW5nIEth
bmNoYW4gdG9vLCB3aG8gaXMgYWxzbyB3b3JraW5nIG9uIHRoaXMgYW5kIGNhbiBjb250cmlidXRl
CnRvIHRoZSBkaXNjdXNzaW9uCgpXZSBkaXNjdXNzZWQgdGhpcyBpbiB0aGUgY29udGV4dCBvZiBQ
MlAgYXQgZGlmZmVyZW50IFNOSUEgZXZlbnRzIGluIHRoZQpjb250ZXh0IG9mIGNvbXB1dGF0aW9u
YWwgb2ZmbG9hZHMgYW5kIGFsc28gYXMgdGhlIGJhY2tlbmQgaW1wbGVtZW50YXRpb24KZm9yIFNp
bXBsZSBDb3B5LCB3aGljaCBpcyBjb21pbmcgaW4gTlZNZS4gRGlzY3Vzc2luZyB0aGlzIChhZ2Fp
bikgYXQKTFNGL01NIGFuZCBmaW5kaW5nIGEgd2F5IHRvIGZpbmFsbHkgZ2V0IFhDT1BZIG1lcmdl
ZCB3b3VsZCBiZSBncmVhdC4KClRoYW5rcywKSmF2aWVyCgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
