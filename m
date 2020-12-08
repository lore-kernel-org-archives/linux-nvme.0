Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE07C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:13:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BA823AA7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 13:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BA823AA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hZY+426LZKH6sKbaaVyD4reHr5s2+MPhQ6Iucl6Cd84=; b=0xzECtKS28RFRX5qi4kIL7BXu
	63+QNDFP9UuxlgiNbqs79vlGRwhdwCcyrO8OzxwnRNybGrno8nz7BIoC/zDwTIk+iVf7/qV6+Vkpc
	ir4MInBezywXM4tVq806+TeJAExB132wai/z1Vp3/5gHBIWy9diIYwhot6H7OlrCUmCoIsH7V7uHz
	mSZJtUZLsv5aVal6cEMmH5SDfpYGDXHJWg+qtwrCG3CQoZQQn0IL8gPiVTfIt/RHth1VoYRTGwit/
	iXI0/dERvIeS+kWtuBNeBNtxTdkukHWDRflsBAlHK3R5AiodMAB5kpvA6R2DfnNrWTFvDwBQYUc2X
	5VFRR0Juw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmcoF-0001Yq-1r; Tue, 08 Dec 2020 13:13:39 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmcoC-0001YX-Fi
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 13:13:37 +0000
Received: by mail-ed1-x541.google.com with SMTP id b2so17536253edm.3
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 05:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=4H0t76z3d9Gm8+rnlsRXMej2iqZW90QwJGGNcAOGfNQ=;
 b=JAzSmLxxgeFhhHjbJmv4czCcTVN37dDptyYJOl2vbRL3Kg0Eda4yv79sD8kMfO0W9S
 755X4aNtjn8/PDQ714OSMQWmUEpi3o2kj48M0Pau3F+eON22OEuSEQSgv+ssnT/+K6eC
 5aj7Lne6pqgTUjZ7ZbBS/DFNldcQ4aFV/HcS5eZwxiOlFpf0/ZDx99a28W3UW/PBlcL4
 +BweyvMen5WEQ6Zi/Y52ky0t+B/lP2/Sm1hV4x59IV2xMORTLdcltLMa+0e7nQqg6sg6
 wcabTKaDzHQcnkkWBuazi1q1wH8oXbHxXekHtbytDm2B0X1FmRK+IbhrMf17qT6GBY5i
 8rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4H0t76z3d9Gm8+rnlsRXMej2iqZW90QwJGGNcAOGfNQ=;
 b=YjzUWDB5B7LToNwKQvVUwVt6uN/1cSHzAl87gwCWbtN14AYoQXOhok6s2/lMW4mufH
 3R69CCtUW/7ZOuhO/j83Hnqxo7l+MWVIdQtY8LMgGfwCcIGz2PxNoRYQbOtdzdmC3C+a
 p+Nz6LhQXuaZ0vdl/6Ln5aTNNfe863iHB+6qqSvyA/iyj7YmTWOyCJSpqxQPaxDhnyCb
 1zX0d3kDZojF+Iil45vs3T/7bRMOk4pi6bJoYKo8J6Ay364R+gTFUWAeZ1pbD0y2bTiq
 WHqm9/eLgfZIa2ec96CHhkQ3Ckh9+0H/sBdsyZnN3QsP8o9uHqN+JAkSOuCQkBkBwuBH
 mcdg==
X-Gm-Message-State: AOAM531pnMK3otlFZJ/mYDLdS2DLKoM2rIcP5oxT9gVcXEMZ+nbMBX7Q
 iPTk/DrBpLNVAs3Q1orm3iBzDA==
X-Google-Smtp-Source: ABdhPJxzR3lshkmLf680nwJwf3iSrf8fXTQ9WUttlW08OFCU+GJEW3f7mGgCqOCWWXeIGq2QqC1DUQ==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr25105016eds.198.1607433214946; 
 Tue, 08 Dec 2020 05:13:34 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id u5sm16894960edp.5.2020.12.08.05.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 05:13:34 -0800 (PST)
Date: Tue, 8 Dec 2020 14:13:33 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201208131333.xoxincxcnh7iz33z@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
 <20201207192453.vc6clbdhz73hzs7l@mpHalley>
 <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201208122248.utv7pqthmmn6uwv6@mpHalley>
 <SN4PR0401MB35983464199FB173FB0C29479BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35983464199FB173FB0C29479BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_081336_979782_E9B27874 
X-CRM114-Status: GOOD (  17.10  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 Mikulas Patocka <mpatocka@redhat.com>, Hannes Reinecke <hare@suse.de>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDguMTIuMjAyMCAxMjozNywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+T24gMDgvMTIv
MjAyMCAxMzoyMiwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4gR29vZCBpZGVhLiBBcmUgeW91
IHRoaW5raW5nIG9mIGEgc3lzZnMgZW50cnkgdG8gc2VsZWN0IHRoZSBiYWNrZW5kPwo+Cj5Ob3Qg
c3VyZSBvbiB0aGlzIG9uZSwgaW5pdGlhbGx5IEkgdGhvdWdodCBvZiBhIHN5c2ZzIGZpbGUsIGJ1
dCB0aGVuCj5ob3cgd291bGQgeW91IGRvIGl0LiBPbmUgImdsb2JhbCIgc3lzZnMgZW50cnkgaXMg
cHJvYmFibHkgYSBiYWQgaWRlYS4KPkhhdmluZyBvbmUgcGVyIGJsb2NrIGRldmljZSB0byBzZWxl
Y3QgbmF0aXZlIHZzIGVtdWxhdGlvbiBtYXliZT8gQW5kCj5hIGdvb2Qgd2F5IHRvIGJlbmNobWFy
ay4KCkkgd2FzIHRoaW5raW5nIGEgcGVyIGJsb2NrIGRldmljZSB0byB0YXJnZXQgdGhlIHVzZSBj
YXNlIHdoZXJlIGEgY2VydGFpbgppbXBsZW1lbnRhdGlvbiAvIHdvcmtsb2FkIGlzIGJldHRlciBv
bmUgd2F5IG9yIHRoZSBvdGhlci4KCj4KPlRoZSBvdGhlciBpZGVhIHdvdWxkIGJlIGEgYmVuY2ht
YXJrIGxvb3Agb24gYm9vdCBsaWtlIHRoZSByYWlkIGxpYnJhcnkKPmRvZXMuCj4KPlRoZW4gb24g
dGhlIG90aGVyIGhhbmQsIHRoZXJlIG1pZ2h0IGJlIHdvcmtsb2FkcyB0aGF0IHJ1biBmYXN0ZXIg
d2l0aAo+dGhlIGVtdWxhdGlvbiBhbmQgc29tZSB0aGF0IHJ1biBmYXN0ZXIgd2l0aCB0aGUgaGFy
ZHdhcmUgYWNjZWxlcmF0aW9uLgo+Cj5JIHRoaW5rIHRoZXNlIHBvaW50cyBhcmUgdGhlIHJlYXNv
biB0aGUgbGFzdCBhdHRlbXB0cyBnb3Qgc3R1Y2suCgpZZXMuIEkgYmVsaWV2ZSB0aGF0IGFueSBi
ZW5jaG1hcmsgd2UgcnVuIHdvdWxkIGJlIGJpYXNlZCBpbiBhIGNlcnRhaW4Kd2F5LiBJZiB3ZSBj
YW4gbW92ZSBmb3J3YXJkIHdpdGggYSBzeXNmcyBlbnRyeSBhbmQgZGVmYXVsdCB0byBsZWdhY3kK
cGF0aCwgd2Ugd291bGQgbm90IGFsdGVyIGN1cnJlbnQgYmVoYXZpb3IgYW5kIGVuYWJsZSBOVk1l
IGNvcHkgb2ZmbG9hZAooZm9yIG5vdykgZm9yIHRob3NlIHRoYXQgd2FudCB0byB1c2UgaXQuIFdl
IGNhbiB0aGVuIGJ1aWxkIG9uIHRvcCBvZiBpdC4KCkRvZXMgdGhpcyBzb3VuZCBsaWtlIGEgcmVh
c29uYWJsZSBhcHByb2FjaD8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
