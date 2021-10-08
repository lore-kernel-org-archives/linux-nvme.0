Return-Path: <SRS0=1aKD=O4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33D0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 06:49:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF5C60F11
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 06:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CF5C60F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ky+RinEh6o5ln/GfG2kymNJxKTdtRZcPMDeB074rGT4=; b=CBuBHuCeKN7ZrjEf50oP/IT1Ec
	JkI6/OR+nozKQMYyV/TRc/+mhWq2QOoX1QHV/qt6WZTXa9n/np/aqBQ9XH9lU5zcyDsasERpwd7ZB
	K0U/Ahm+PK7uvM5ZYYXjfotncfpCr4glyXxDtglHEhTD77BAdssgBj2vuCayoUYU9d7lIsefJbrBt
	bFX0kSD97e5u8aR6vGeN9P1a45yUsjqnv57PolBak8kKWRslAvycQs6xhORy6zKPNztR3DfpqUbtJ
	08q/qhnYdmsAujayKScX/7vvB1NkRH8OIyp0/z23MKxCOinnWhmy4wQenzVc0UZ5iRhVZ7M2d7rwD
	dw7ytd6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYjhG-001ksy-7O; Fri, 08 Oct 2021 06:49:34 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYjhD-001kru-0c
 for linux-nvme@lists.infradead.org; Fri, 08 Oct 2021 06:49:32 +0000
Received: by mail-ot1-x341.google.com with SMTP id
 w10-20020a056830280a00b0054e4e6c85a6so1534260otu.5
 for <linux-nvme@lists.infradead.org>; Thu, 07 Oct 2021 23:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20210112.gappssmtp.com; s=20210112;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=kWdIriwExu4LlJQU964sGxqqg1QcebE7i1wdIsD6J4k=;
 b=F+pf4LO3Ma1Iz4xpY8hOLtbitkZ9Y1ZMh2/WQR5vW7L5b4Et5pUSRwwEm7QlaDDzzo
 3CF0cMPwrYUL1J2zBX3ZIQFeCbW0W7XDqfGAilKWkev/u5RJLKdP0wr8YNAZGWxruu7v
 EYZCcBGNPQ3qRSOYQMoM+XgtM9Jrz7UVm3HS7aGiXqF+cOXW7bdwdH62Oez9VVr3tvFt
 Dbr3MdPy/G3T8jqF5BXhZ31vhH9VVxGRbzfbhgWI0A2uUcUR3XHhQioA9Z38etszvG1J
 9YTr1PiA28SNtWLMWdS8tsYOugthDTnwVvgvu07jlWHuW/Zk+Xaz+bF0DpC2FVmG6pZc
 5aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kWdIriwExu4LlJQU964sGxqqg1QcebE7i1wdIsD6J4k=;
 b=s4BnK3rPOlNy+ybYsb5eLW2f9K04JJ5f79rlt4uAZkU95Fzz7gdVndN+Z+nCLUOrqv
 hQ8WGCEmDtRVrGutRy2Rb162hH5hLqZ5BPOsrn+4nG28RPyk9EhPrYYMA3LNBGxDfwMe
 7iT2LVcnvcAHTBjfQQJf1OMcGTfcPAEMlO6l4kWG4FKGAsZVVH8UcoBpVDEPyrz9uU4W
 RSEjnP4DsYaMa1aBGJmzDlzUJZ8kHBHvJoCa0HqoK2LnhmZkC/aZpWjfHDEjPxVhOLEn
 oaTrOJ+YdPJyznR11WLWpPcJM74KIgynoKlRKZJjyhPzlt3HmsDY/aEfMWjuRT9m7SLu
 wRaQ==
X-Gm-Message-State: AOAM532/eDXAJwuHT51ciWhVrb7FKkkH1CVM2wyEadAqEFBYcVNbd1uh
 ns9hyqONuwKrqE3KJZnjXZcUuA==
X-Google-Smtp-Source: ABdhPJy5QnapeLgcGWJ6jvzl+N+Y+bCEojADkeyAUGfRJJj/bp34o8DSnXn50k5+/PJLlpeQWlsNqw==
X-Received: by 2002:a9d:7681:: with SMTP id j1mr7204557otl.367.1633675769488; 
 Thu, 07 Oct 2021 23:49:29 -0700 (PDT)
Received: from localhost (96.44.142.75.adsl.inet-telecom.org. [96.44.142.75])
 by smtp.gmail.com with ESMTPSA id
 k9sm364371otr.66.2021.10.07.23.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 23:49:29 -0700 (PDT)
From: "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?=
 <javier.gonz@samsung.com>
Date: Fri, 8 Oct 2021 08:49:25 +0200
To: Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Message-ID: <20211008064925.oyjxbmngghr2yovr@mpHalley.local>
References: <BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com>
 <PH0PR04MB74161CD0BD15882BBD8838AB9B529@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CGME20210928191342eucas1p23448dcd51b23495fa67cdc017e77435c@eucas1p2.samsung.com>
 <20210928191340.dcoj7qrclpudtjbo@mpHalley.domain_not_set.invalid>
 <c2d0dff9-ad6d-c32b-f439-00b7ee955d69@acm.org>
 <20211006100523.7xrr3qpwtby3bw3a@mpHalley.domain_not_set.invalid>
 <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fbe69cc0-36ea-c096-d247-f201bad979f4@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211007_234931_125703_D7CB0FFC 
X-CRM114-Status: GOOD (  10.59  )
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

T24gMDYuMTAuMjAyMSAxMDozMywgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+T24gMTAvNi8yMSAz
OjA1IEFNLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PkkgYWdyZWUgdGhhdCB0aGUgdG9waWMg
aXMgY29tcGxleC4gSG93ZXZlciwgd2UgaGF2ZSBub3QgYmVlbiBhYmxlIHRvCj4+ZmluZCBhIGNs
ZWFyIHBhdGggZm9yd2FyZCBpbiB0aGUgbWFpbGluZyBsaXN0Lgo+Cj5IbW0gLi4uIHJlYWxseT8g
QXQgbGVhc3QgTWFydGluIFBldGVyc2VuIGFuZCBJIGNvbnNpZGVyIGRldmljZSBtYXBwZXIgCj5z
dXBwb3J0IGVzc2VudGlhbC4gSG93IGFib3V0IHN0YXJ0aW5nIGZyb20gTWlrdWxhcycgcGF0Y2gg
c2VyaWVzIHRoYXQgCj5zdXBwb3J0cyB0aGUgZGV2aWNlIG1hcHBlcj8gU2VlIGFsc28gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2FscGluZS5MUkguMi4wMi4yMTA4MTcxNjMwMTIwLjMwMzYz
QGZpbGUwMS5pbnRyYW5ldC5wcm9kLmludC5yZHUyLnJlZGhhdC5jb20vCgpUaGFua3MgZm9yIHRo
ZSBwb2ludGVycy4gV2UgYXJlIGxvb2tpbmcgaW50byBNaWt1bGFzJyBwYXRjaCAtIEkgYWdyZWUK
dGhhdCBpdCBpcyBhIGdvb2Qgc3RhcnQuCgo+PldoYXQgZG8geW91IHRoaW5rIGFib3V0IGpvaW5p
bmcgdGhlIGNhbGwgdG8gdGFsayB2ZXJ5IHNwZWNpZmljIG5leHQKPj5zdGVwcyB0byBnZXQgYSBw
YXRjaHNldCB0aGF0IHdlIGNhbiBzdGFydCByZXZpZXdpbmcgaW4gZGV0YWlsLgo+Cj5JIGNhbiBk
byB0aGF0LgoKVGhhbmtzLiBJIHdpbGwgd2FpdCB1bnRpbCBDaGFpdGFueWEncyByZXBseSBvbiBo
aXMgcXVlc3Rpb25zLiBXZSB3aWxsCnN0YXJ0IHN1Z2dlc3Rpbmcgc29tZSBkYXRlcyB0aGVuLgoK
VGhhbmtzLApKYXZpZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
