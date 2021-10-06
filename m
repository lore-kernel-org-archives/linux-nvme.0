Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E253C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 17:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F4860F22
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 17:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17F4860F22
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u+c4EuWQk+aoBo8HMh2I9qhNLoCwqYXmK6RwMTYIs/4=; b=Pobw7QvPgE2Em1u0uC2kzAph7J
	n0cS2Mz2VzLVqfcVE3+AoJGwyYgj5PbMkzhEusmWUox7d4OfLmj/7HlJsp6GIwS6c89gXs5iLjygl
	TcFLDEm1yxfNH6tGe8f9W/9gcnpD4rzsLb3aw40RVuUAu+2Z27P6HGtygIwytKGetbWUBJjE2Agys
	2gJ61r0orUrE3o/mJG1ylHS9MpcxmT0kZBhCokCu1wvFgNdLu5WQNFsBEQXYIlsatqW28Ia22/9i6
	0yPzTN0K3K7nccEfeZ2sQTPZj6crpUed+sy+sCSUuVxjUm5i86mZJylEb0XhApG6yjNri3cDlyotn
	SYGqJ7SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYAnS-00FD6U-V7; Wed, 06 Oct 2021 17:33:39 +0000
Received: from mail-pj1-f48.google.com ([209.85.216.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYAnQ-00FD5k-AT
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 17:33:37 +0000
Received: by mail-pj1-f48.google.com with SMTP id
 pi19-20020a17090b1e5300b0019fdd3557d3so2919965pjb.5
 for <linux-nvme@lists.infradead.org>; Wed, 06 Oct 2021 10:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b0udGD6yPXFIVJbeGvfLIzJwm0LmddvqozG4vFBfvTE=;
 b=Kd/u5f/fEVPffsdbIXVtjYvxJFzjJ+SudF1sjgoWSNeefrG/rU0u27G51AR+wP56Iu
 RlLKfmm2NrQCFX4ka2h2/txV6pJR7bRtPzry36UFCQo0C4iYGsjXAlyhiEy3d0jIB4G8
 9cUx1q+jVS443QNkYhaQWi2pJaSMQRrjabjhpm7SUCbNw3BiFGoTWei6Z3XlKkg6zIhu
 pgI+El+6Z4YbiR5FASZs/ihGTt8/HPed7Um7E8NHX5GjVdCNAPUYOLct8cHf1lTLME54
 c6M661rLJF2MQe5U1rBuXdQEgBlRUkbpM4K8+rRpFjUDnFztJGmn5Hf8QmWwSUjO52KI
 292A==
X-Gm-Message-State: AOAM530pnSYHY3ylz6tpy+hRvLQAGeFW1yvh4stLlOkvQEfLS+z1/16I
 fsO0uTUfsoi+kZei7bQRl74=
X-Google-Smtp-Source: ABdhPJww5vn0LIX4yaBzMmvw+4zhd9LR+fC9FR6Wt5P5+rHOabghLfn4cJcj1iGMZ4cyBz8ApUN3GQ==
X-Received: by 2002:a17:902:e801:b0:13f:255:9db5 with SMTP id
 u1-20020a170902e80100b0013f02559db5mr1022291plg.23.1633541615361; 
 Wed, 06 Oct 2021 10:33:35 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:6ad6:c36f:fdfb:9e74])
 by smtp.gmail.com with ESMTPSA id c15sm9368288pfp.39.2021.10.06.10.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Oct 2021 10:33:34 -0700 (PDT)
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
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
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
Date: Wed, 6 Oct 2021 10:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_103336_382314_319D6D3F 
X-CRM114-Status: GOOD (  12.90  )
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

T24gMTAvNi8yMSAzOjA1IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+IEkgYWdyZWUgdGhh
dCB0aGUgdG9waWMgaXMgY29tcGxleC4gSG93ZXZlciwgd2UgaGF2ZSBub3QgYmVlbiBhYmxlIHRv
Cj4gZmluZCBhIGNsZWFyIHBhdGggZm9yd2FyZCBpbiB0aGUgbWFpbGluZyBsaXN0LgoKSG1tIC4u
LiByZWFsbHk/IEF0IGxlYXN0IE1hcnRpbiBQZXRlcnNlbiBhbmQgSSBjb25zaWRlciBkZXZpY2Ug
bWFwcGVyIApzdXBwb3J0IGVzc2VudGlhbC4gSG93IGFib3V0IHN0YXJ0aW5nIGZyb20gTWlrdWxh
cycgcGF0Y2ggc2VyaWVzIHRoYXQgCnN1cHBvcnRzIHRoZSBkZXZpY2UgbWFwcGVyPyBTZWUgYWxz
byAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FscGluZS5MUkguMi4wMi4yMTA4MTcxNjMw
MTIwLjMwMzYzQGZpbGUwMS5pbnRyYW5ldC5wcm9kLmludC5yZHUyLnJlZGhhdC5jb20vCgo+IFdo
YXQgZG8geW91IHRoaW5rIGFib3V0IGpvaW5pbmcgdGhlIGNhbGwgdG8gdGFsayB2ZXJ5IHNwZWNp
ZmljIG5leHQKPiBzdGVwcyB0byBnZXQgYSBwYXRjaHNldCB0aGF0IHdlIGNhbiBzdGFydCByZXZp
ZXdpbmcgaW4gZGV0YWlsLgoKSSBjYW4gZG8gdGhhdC4KClRoYW5rcywKCkJhcnQuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
