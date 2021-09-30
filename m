Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F427C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 16:21:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C63AF613CE
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 16:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C63AF613CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wHqgFOr1KKSOY9KRxwZqEf1MilVfUWFAHjmeALRQT2A=; b=wGZWLYe74yy3jSDsxITCn206DD
	IEswby76jjpo4UAIqojXlBCe24032r7rX9KyPLe6D6dnnzivZYiieVC1vKZwLC/UWwwuYl9gFnbeF
	YeSjf9a09tpkxq/46v9sYKOEX8Ipd1p0npPlykZbZ5/4CvOaRxF9Abp1tPw34A/D/esdNAcXHra0W
	nMvBr86JEWqyQ7in9zYJBv+sN+VBkOyRhzpnQ49o1DgcDONdioCQkcB1ahIuYFcAF/xIyv5w/JfRb
	rqt1/v+gNafO4gc+tmGjiOJzvR4CBZ77numI6dpTWKu20I1z1gfH5emPXkBVz5WVfu5IEAzvUB974
	AK4ggQLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVyn7-00FCv4-Se; Thu, 30 Sep 2021 16:20:13 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVyn3-00FCsv-GT
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 16:20:11 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 me5-20020a17090b17c500b0019af76b7bb4so7153444pjb.2
 for <linux-nvme@lists.infradead.org>; Thu, 30 Sep 2021 09:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yG1/o+/DnMH77sK/4dZhI1SBFsLkmeMylzKyExyvyVo=;
 b=mZ7nUC2sURSmL3c6AXI6xKr+EUq/du15q+H2PiK8fgcrJZUXDgEVPmxEzspo5xfos9
 vS4EnhY6dZIZOCcnQpmyJiGfFLNDblLgGMzW2e2Cy3JH7sjgAPBmnfMzsUfsWGucfdgV
 PjH3qD3yssN73sXf5MtIIK4Y+j9JIgTHXF4nGahDPgzAeLJ5D6zoU+s3EWI+nBsiYw3k
 8b4OHx8WPznXe83YlpsJLbZduVht/KE3CQYwtsm/BgFEgDKBa6ko+hrS/hTODmBjsith
 si2oxzEO5caaXnanV6hVkrN2yh3GOq9mWzKlB8p7Zd7d8ojXZpKSbQIdIK8EPY/MQqj7
 brWQ==
X-Gm-Message-State: AOAM530VwgBVOdLLtuwaxCdNe5U9IPh2yxCJWXq+e1d/SffOymrOF10n
 7IcTFwx4iwjulKRxL/ogE9U=
X-Google-Smtp-Source: ABdhPJzaCOnFZETcMKaHwCPxzFz713M2S082LglpsjtX0j5t65Ek+coBFDcqzxklnkgshMeKu30lrQ==
X-Received: by 2002:a17:90b:104d:: with SMTP id
 gq13mr14201836pjb.101.1633018808562; 
 Thu, 30 Sep 2021 09:20:08 -0700 (PDT)
Received: from [10.254.204.66] (50-242-106-94-static.hfc.comcastbusiness.net.
 [50.242.106.94])
 by smtp.gmail.com with ESMTPSA id t15sm3663221pgi.80.2021.09.30.09.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Sep 2021 09:20:07 -0700 (PDT)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "msnitzer@redhat.com" <msnitzer@redhat.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "roland@purestorage.com" <roland@purestorage.com>,
 "mpatocka@redhat.com" <mpatocka@redhat.com>, "hare@suse.de" <hare@suse.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "rwheeler@redhat.com" <rwheeler@redhat.com>, "hch@lst.de" <hch@lst.de>,
 "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
 "zach.brown@ni.com" <zach.brown@ni.com>, "osandov@fb.com" <osandov@fb.com>,
 Adam Manzanares <a.manzanares@samsung.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Vincent Fu <vincent.fu@samsung.com>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
Date: Thu, 30 Sep 2021 09:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_092009_611734_7FAF35F7 
X-CRM114-Status: GOOD (  14.69  )
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

T24gOS8yOC8yMSAxMjoxMyBQTSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBTaW5jZSB3ZSBh
cmUgbm90IGdvaW5nIHRvIGJlIGFibGUgdG8gdGFsayBhYm91dCB0aGlzIGF0IExTRi9NTSwgYSBm
ZXcgb2YKPiB1cyB0aG91Z2h0IGFib3V0IGhvbGRpbmcgYSBkZWRpY2F0ZWQgdmlydHVhbCBkaXNj
dXNzaW9uIGFib3V0IENvcHkKPiBPZmZsb2FkLiBJIGJlbGlldmUgd2UgY2FuIHVzZSBDaGFpdGFu
eWEncyB0aHJlYWQgYXMgYSBzdGFydC4gR2l2ZW4gdGhlCj4gY3VycmVudCBzdGF0ZSBvZiB0aGUg
Y3VycmVudCBwYXRjaGVzLCBJIHdvdWxkIHByb3Bvc2UgdGhhdCB3ZSBmb2N1cyBvbgo+IHRoZSBu
ZXh0IHN0ZXAgdG8gZ2V0IHRoZSBtaW5pbWFsIHBhdGNoc2V0IHRoYXQgY2FuIGdvIHVwc3RyZWFt
IHNvIHRoYXQKPiB3ZSBjYW4gYnVpbGQgZnJvbSB0aGVyZS4KPiAKPiBCZWZvcmUgd2UgdHJ5IHRv
IGZpbmQgYSBkYXRlIGFuZCBhIHRpbWUgdGhhdCBmaXRzIG1vc3Qgb2YgdXMsIHdobyB3b3VsZAo+
IGJlIGludGVyZXN0ZWQgaW4gcGFydGljaXBhdGluZz8KCkdpdmVuIHRoZSB0ZWNobmljYWwgY29t
cGxleGl0eSBvZiB0aGlzIHRvcGljIGFuZCBhbHNvIHRoYXQgdGhlIHBlb3BsZSB3aG8gYXJlCmlu
dGVyZXN0ZWQgbGl2ZSBpbiBtdWx0aXBsZSB0aW1lIHpvbmVzLCBJIHByZWZlciBlbWFpbCB0byBk
aXNjdXNzIHRoZSB0ZWNobmljYWwKYXNwZWN0cyBvZiB0aGlzIHdvcmsuIE15IGF0dGVtcHQgdG8g
c3VtbWFyaXplIGhvdyB0byBpbXBsZW1lbnQgY29weSBvZmZsb2FkaW5nCmlzIGF2YWlsYWJsZSBo
ZXJlOiBodHRwczovL2dpdGh1Yi5jb20vYnZhbmFzc2NoZS9saW51eC1rZXJuZWwtY29weS1vZmZs
b2FkLgpGZWVkYmFjayBvbiB0aGlzIHRleHQgaXMgd2VsY29tZS4KClRoYW5rcywKCkJhcnQuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
