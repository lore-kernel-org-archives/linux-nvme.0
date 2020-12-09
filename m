Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A611C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 09:17:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B686238EB
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B686238EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4shGNGfEZrswQ6JWOL4gnXi71XeQOokDvqNVRz45TnE=; b=ZRXd1sY9ev+pxsYFO12p4Noxc
	ZiSpskf1KEU6IXkjGtNPm2kMVZAH2duyRLLUxXfHH+mgXZRLF1G109bljKT7kpHOgCeL2XLuASKVm
	iTLVfySOGlDr42ZZe0jBIkalqIIO3k3VaYnC5DsJ2hFMlQwuU4/a3mepcrCQupcr1a8OlKwAY/hsh
	xZ2vS9u6JF3jXK1sLH4/kwa8uEM1u4/5GGxNDULKiOq5W1vLx7kdrIUg++MmjHLa/6z73OWWTz3f/
	DSRzKz0tFAPrjxEBoO7II2n6wtat8DFn0sR5abiC4544NmWn2Ynh4F1Dea/LMX7VkREQ3LcW1TSJv
	KEmKliwNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmvaw-0001EQ-2x; Wed, 09 Dec 2020 09:17:10 +0000
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmvau-0001E2-Bb
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 09:17:09 +0000
Received: by mail-ej1-x643.google.com with SMTP id n26so1057340eju.6
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 01:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=rhhiMX6lpyZpBTo++Wq1vgh3A63oG1sQxoZyJsc1aQg=;
 b=P8oh5+/uu8rb5ugbhTx6O474H6hkBIwZA2qWENj5ag15EIY80CWadHdfGxQnhTAuMR
 kbNk5JfBb6loUdVGVyaPVhWtBQ1NjpEdFVcn9tYOFB+qOgEbDjlfscYtu/qIoCbb5Chz
 7CiywHUQ67e3O04cgul518A1o0MfGZcqFpTZZnlXt5erd32JVIX/kIoOcJ7E6df5xpPw
 s6IYn+e1e1RXF/Z/qwRHiSnu9S2JvHXZspsCFFn7MliNwtnecrsJyM+LopbOJALx3N8D
 G9qQkXTWUv6aPxfla3mKnk96yIxMBMESNCDYDoAhR8RSGIVe6yWfam74imuEnHfJJPwT
 XFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=rhhiMX6lpyZpBTo++Wq1vgh3A63oG1sQxoZyJsc1aQg=;
 b=k8dagzmWZ5qn3QqdLyS7H52e9hGJLFY4xkkV23BCTdPEONsW9aBEHqOvfichYq+Kb3
 PnQwOAvA1AOaubBLV+7cF+VSRjQZ6biSFZv2Z0TEHuAJxYcsT+SzVJmhPrIhnvJLqM4C
 /5if6mHy5Bmy2RZU0fcGaQBv5nJVy0EZw6etZvKXTwuBVkbZvtfadqRZQqSic2/So3NV
 HDbITJB9gy+JE/Gt8RhlSPhEtRtoSa3373bp7dvRvTjpLIsBcVEC3/oGUf+7tqiA9+FL
 lvBWGbPW4v9iq9IlI30Tzj8M9KFQpg4Qnb4Orv5Nt8pHHK7ORMEwRIeFuAoATTEsmmGZ
 v32w==
X-Gm-Message-State: AOAM533fpX1ofbQXalfPvVpSxz8twNQWnfhNXqASN8RTS+HubR3gdW7v
 z982zxifBVhWSQ2zUsnuhkvtxA==
X-Google-Smtp-Source: ABdhPJxbBbOAPum4JxhLDvVO8oH4bCpyUFUBf6xuJ19RfGwEp+yksU2UBrKm/QCGpkEPA7yZYkCfcA==
X-Received: by 2002:a17:906:a857:: with SMTP id
 dx23mr1242029ejb.189.1607505427041; 
 Wed, 09 Dec 2020 01:17:07 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id j20sm874968ejy.124.2020.12.09.01.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 01:17:06 -0800 (PST)
Date: Wed, 9 Dec 2020 10:17:05 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201209091705.brzbbqedavtxvhms@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
 <20201207192453.vc6clbdhz73hzs7l@mpHalley>
 <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201208122248.utv7pqthmmn6uwv6@mpHalley>
 <SN4PR0401MB35983464199FB173FB0C29479BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201208131333.xoxincxcnh7iz33z@mpHalley>
 <SN4PR0401MB3598226CD4A32F65320A47379BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598226CD4A32F65320A47379BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_041708_413865_E8AE6ABF 
X-CRM114-Status: GOOD (  18.63  )
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

T24gMDguMTIuMjAyMCAxMzoyNCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+T24gMDgvMTIv
MjAyMCAxNDoxMywgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4gT24gMDguMTIuMjAyMCAxMjoz
NywgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+Pj4gT24gMDgvMTIvMjAyMCAxMzoyMiwgSmF2
aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+PiBHb29kIGlkZWEuIEFyZSB5b3UgdGhpbmtpbmcgb2Yg
YSBzeXNmcyBlbnRyeSB0byBzZWxlY3QgdGhlIGJhY2tlbmQ/Cj4+Pgo+Pj4gTm90IHN1cmUgb24g
dGhpcyBvbmUsIGluaXRpYWxseSBJIHRob3VnaHQgb2YgYSBzeXNmcyBmaWxlLCBidXQgdGhlbgo+
Pj4gaG93IHdvdWxkIHlvdSBkbyBpdC4gT25lICJnbG9iYWwiIHN5c2ZzIGVudHJ5IGlzIHByb2Jh
Ymx5IGEgYmFkIGlkZWEuCj4+PiBIYXZpbmcgb25lIHBlciBibG9jayBkZXZpY2UgdG8gc2VsZWN0
IG5hdGl2ZSB2cyBlbXVsYXRpb24gbWF5YmU/IEFuZAo+Pj4gYSBnb29kIHdheSB0byBiZW5jaG1h
cmsuCj4+Cj4+IEkgd2FzIHRoaW5raW5nIGEgcGVyIGJsb2NrIGRldmljZSB0byB0YXJnZXQgdGhl
IHVzZSBjYXNlIHdoZXJlIGEgY2VydGFpbgo+PiBpbXBsZW1lbnRhdGlvbiAvIHdvcmtsb2FkIGlz
IGJldHRlciBvbmUgd2F5IG9yIHRoZSBvdGhlci4KPgo+WWVzIHNvbWV0aGluZyBhbG9uZyB0aG9z
ZSBsaW5lcy4KPgo+Pj4KPj4+IFRoZSBvdGhlciBpZGVhIHdvdWxkIGJlIGEgYmVuY2htYXJrIGxv
b3Agb24gYm9vdCBsaWtlIHRoZSByYWlkIGxpYnJhcnkKPj4+IGRvZXMuCj4+Pgo+Pj4gVGhlbiBv
biB0aGUgb3RoZXIgaGFuZCwgdGhlcmUgbWlnaHQgYmUgd29ya2xvYWRzIHRoYXQgcnVuIGZhc3Rl
ciB3aXRoCj4+PiB0aGUgZW11bGF0aW9uIGFuZCBzb21lIHRoYXQgcnVuIGZhc3RlciB3aXRoIHRo
ZSBoYXJkd2FyZSBhY2NlbGVyYXRpb24uCj4+Pgo+Pj4gSSB0aGluayB0aGVzZSBwb2ludHMgYXJl
IHRoZSByZWFzb24gdGhlIGxhc3QgYXR0ZW1wdHMgZ290IHN0dWNrLgo+Pgo+PiBZZXMuIEkgYmVs
aWV2ZSB0aGF0IGFueSBiZW5jaG1hcmsgd2UgcnVuIHdvdWxkIGJlIGJpYXNlZCBpbiBhIGNlcnRh
aW4KPj4gd2F5LiBJZiB3ZSBjYW4gbW92ZSBmb3J3YXJkIHdpdGggYSBzeXNmcyBlbnRyeSBhbmQg
ZGVmYXVsdCB0byBsZWdhY3kKPj4gcGF0aCwgd2Ugd291bGQgbm90IGFsdGVyIGN1cnJlbnQgYmVo
YXZpb3IgYW5kIGVuYWJsZSBOVk1lIGNvcHkgb2ZmbG9hZAo+PiAoZm9yIG5vdykgZm9yIHRob3Nl
IHRoYXQgd2FudCB0byB1c2UgaXQuIFdlIGNhbiB0aGVuIGJ1aWxkIG9uIHRvcCBvZiBpdC4KPj4K
Pj4gRG9lcyB0aGlzIHNvdW5kIGxpa2UgYSByZWFzb25hYmxlIGFwcHJvYWNoPwo+Pgo+Cj5ZZXMg
dGhpcyBzb3VuZHMgbGlrZSBhIHJlYXNvbmFibGUgYXBwcm9hY2ggdG8gbWUuCgpDb29sLiBXZSB3
aWxsIGFkZCB0aGlzIHRvIHRoZSBWMyB0aGVuLgoKVGhhbmtzIEpvaGFubmVzIQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
