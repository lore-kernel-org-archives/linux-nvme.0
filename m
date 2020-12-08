Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623CFC4361B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 12:22:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022C523A5B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 12:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022C523A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MhUomKrIzzgvqwCHARRbxzFEc9V4/Q13igCQabCdsUY=; b=wWL9S/L5ELr5Yu3dowBTshLq3
	AooQC3OoXpex38XrxrNnOj42HU9QKDT4d9/aHBEimYNhU4SY7FumGFBb8i8r2xL/HxJ3dZFOCMAWL
	cALFvmV59P7DPEdprtUL1kPh9ca9mK3lVFWHlXAnkfsv0sHE8wBMcnXFbzDZvP31cHEpjaFk9OWHB
	A2BmzEunKklvUTuTLUEcsPhdncgM+X6QqhfC1bXbm+bCn7J8Q6uWhFjh4xBOpUTNNiBtgNi3P9l5b
	nn+hCGFBTlRJkVl76aZrcpJ34IM9xJW7qII0g/+KDRPKelxwFYrSmzLLRms84QXNfO6eTrlIT7q+I
	CgYso4Ssg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmc17-00046o-62; Tue, 08 Dec 2020 12:22:53 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmc15-000467-24
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 12:22:51 +0000
Received: by mail-ed1-x541.google.com with SMTP id p22so5304752edu.11
 for <linux-nvme@lists.infradead.org>; Tue, 08 Dec 2020 04:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mimyofEa+0whU409Dhp0a+YV5b97sukKj8gfG9Rbmic=;
 b=O0MKn6nsnZaleEs/kNELsIh8dmH/kUILor5blbkmcjPeH/9Ep6OyKVm0KhMgD3NGd3
 jiS2xaM6anmzo4ZJoxWWeypRd3TPX9i1pbDK1fn7CHS4MoXi73uI9bkKwiK46bx0/aYj
 QiUgUp9GM2g/V0rTnnXbSt39JqhI5CnWjpjP7roaLEcLPuRXAYMc/oC98jZUIwDawmI9
 TuWYO0e8QQghyUuybvSDRbNtqa5oVqU+WzjvfKefSY9LEdJhMLfaBcg69YT58rpPi73N
 6QDuFT3wPIMhu+1PtBLD6TPuURzIfM/B6NmbuJq0Jt0I9O+0ZRmUCz9xhCfcsFBDaruc
 p2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mimyofEa+0whU409Dhp0a+YV5b97sukKj8gfG9Rbmic=;
 b=WycMx7mJ6pmvYbZqs5hA8TtYpmPkKzz+j3j+toLBm6f3s3sOnahaZGP20R/0+/CWT9
 /9HXZ7KwbEiBuY0B9aRpGEv0EBvn6S8MHRnrggIbIXt+b0vBuuXcW1zt+4/UycdO3Oie
 Dk1qghZmmLpDds/VR46HMB+qKEI7k3reb1EqYzIJfuMQQs7UscofeJ4W7qxNcdX5yah6
 9h5z0p27gnvl3C9IOatsDTe/sfqVwn3MUh2KYT+yzOI5d+VA4+plArH0mMXC76qpmMAF
 QUkDGTw2kk0Ki2JbOzv1mtobJC798YcHAt6xSMWn9rwTB+xe8+ZtacZER8JWQFquHM8A
 ruAg==
X-Gm-Message-State: AOAM532HYdbarEt+d2ipNIFMNMTVZKdnArP3hqe2LL8ijBT9ciRvYv9D
 y15HkXh7sSQIVGfT+Y555ZOmzQ==
X-Google-Smtp-Source: ABdhPJwDxIoRMy+9VbYFQ3igoSIhbhtPBIxA8vjX9L86uM4LXFP5Wttpcb3/4YB/UuHFCIPdaYrkmA==
X-Received: by 2002:a50:ccdb:: with SMTP id b27mr18839271edj.20.1607430169696; 
 Tue, 08 Dec 2020 04:22:49 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id x15sm16783915edj.91.2020.12.08.04.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 04:22:49 -0800 (PST)
Date: Tue, 8 Dec 2020 13:22:48 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [RFC PATCH v2 0/2] add simple copy support
Message-ID: <20201208122248.utv7pqthmmn6uwv6@mpHalley>
References: <CGME20201204094719epcas5p23b3c41223897de3840f92ae3c229cda5@epcas5p2.samsung.com>
 <20201204094659.12732-1-selvakuma.s1@samsung.com>
 <20201207141123.GC31159@lst.de>
 <01fe46ac-16a5-d4db-f23d-07a03d3935f3@suse.de>
 <20201207192453.vc6clbdhz73hzs7l@mpHalley>
 <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35988951265391511EBC8C6E9BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_072251_143533_54766796 
X-CRM114-Status: GOOD (  14.01  )
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

T24gMDguMTIuMjAyMCAwODo0MCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOgo+T24gMDcvMTIv
MjAyMCAyMDoyNywgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4gR29vZCBwb2ludC4gV2UgY2Fu
IHNoYXJlIHNvbWUgcGVyZm9ybWFuY2UgZGF0YSBvbiBob3cgU2ltcGxlIENvcHkgc2NhbGVzCj4+
IGluIHRlcm1zIG9mIGJ3IC8gbGF0ZW5jeSBhbmQgdGhlIENQVSB1c2FnZS4gRG8geW91IGhhdmUg
YW55dGhpbmcgZWxzZSBpbgo+PiBtaW5kPwo+Pgo+Cj5XaXRoIGFuIGVtdWxhdGlvbiBpbiB0aGUg
a2VybmVsLCB3ZSBjb3VsZCBtYWtlIHRoZSB1c2QgImJhY2tlbmQiCj5pbXBsZW1lbnRhdGlvbiBj
b25maWd1cmFibGUuIFNvIGlmIHRoZSBlbXVsYXRpb24gaXMgZmFzdGVyLCB1c2VycyBjYW4gc2Vs
ZWN0Cj50aGUgZW11bGF0aW9uLCBpZiB0aGUgZGV2aWNlIGlzIGZhc3RlciB0aGVuIHRoZSBkZXZp
Y2UuCj4KPktpbmQgb2Ygd2hhdCB0aGUgY3J5cHRvIGFuZCByYWlkIGNvZGUgZG8gYXMgd2VsbC4K
Ckdvb2QgaWRlYS4gQXJlIHlvdSB0aGlua2luZyBvZiBhIHN5c2ZzIGVudHJ5IHRvIHNlbGVjdCB0
aGUgYmFja2VuZD8KPgo+SSdtIHJlYWxseSBpbnRlcmVzdGVkIGluIHRoaXMgd29yaywgYXMgQlRS
RlMgcmVsb2NhdGlvbi9iYWxhbmNlIHdpbGwgaGF2ZQo+cG90ZW50aWFsIGJlbmVmaXRzLCBidXQg
d2UgbmVlZCB0byBnZXQgaXQgcmlnaHQuCgpBZ3JlZS4gV2Ugd2lsbCBwb3N0IGEgVjMgd2l0aCBl
bXVsYXRpb24gYW5kIGFkZHJlc3Npbmcgb3RoZXIgY29tbWVudHMuCldlIGNhbiB0YWtlIGl0IGZy
b20gdGhlcmUuIElmIHlvdSBoYXZlIGNvbW1lbnRzIG9uIFYyLCBwbGVhc2Ugc2VuZCB0aGVtCm91
ciB3YXkgYW5kIHdlIHdpbGwgdGFrZSB0aGVtIGluLgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
