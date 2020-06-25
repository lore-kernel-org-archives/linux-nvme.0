Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C26C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 15:13:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1BF20767
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmhydafI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="gZx9xpZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1BF20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hig41GVawgSHJwL+47LGejMdFdEwO8rF7ZmdeNEoaSQ=; b=mmhydafIeTZ16m3QUnZ+oXZB+
	HDMLKQOGexf9PTLdCuKsNVolMm6EKsMpGLGggi36sLsukfGSB9sR5Oim1GNkfzMIF8TdfT1fsjNDX
	xBgJeuNuan57S6SV0uh0gHVkKwMqOF+hWrFDc4spDcUT6+Ha5NdhZ+ocoKdUYr3fcYe/5jrZ9cYXG
	yesEfOKWbVpGmE2In5cq2ouyQdjYutyzseBCugm/oDJUwd+zVJl1KVX6r/jHIBlVVwzjP1JTvLNd1
	h0PDFIwc5EzJ43akXHyT0CVWWsOikvP6ZGR6qF1idIkhEUp4yN9AoIS9ccGGdkOQk0zN35zU+saV/
	6h2mxIf/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joTYx-00022A-M9; Thu, 25 Jun 2020 15:13:15 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joTYw-00021p-6C
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 15:13:14 +0000
Received: by mail-ed1-x541.google.com with SMTP id z17so4491754edr.9
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ixdzoPeHqTjtWCkjfG+wRupSHf8MX9sNzTZVFeYguNQ=;
 b=gZx9xpZ8xp2kLXzmjlge8TgWKxXJbtic7sXC//V0R/IFNIziL2ZRF0C2MNKf0FvuXb
 8S6XEn5qU6OeoWVIXvFoLLMZIi06r3YSWTbmJB/IrD4RMbKfAAkSDyTPOH7lQYqrlohl
 pr6NYaLYBxDIIZyk5sO+pyiUvj9AU7kGKdvio1pRVrkmxd24Z8EGrnfb3GzC5zH5Wlft
 wXAqQHOgXIOKHS4bufmpAfM8OcRaqcVQ3+hrbB/0D/3L6/AC/A4WY1g/BWS1rdHnH9v6
 7XCVLphiB1LvbOEAUyBk7pt4r1ndYkhKvYwKwr5uC1q4NKRU3pXBRWB/vuqVJosMtJiB
 f7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ixdzoPeHqTjtWCkjfG+wRupSHf8MX9sNzTZVFeYguNQ=;
 b=cxB3fotO7pkeYoUBEAsL28r5ddyxxbnhMDLG20brfzfUDqIoxgfXoP5AnNokK5apOw
 pRDUHmWsc/AX4o8vLyfgo4nrJ0P2F1soOGm3eGMHHTWnB11AEE1/Rdg0Oah3MbJHaMuG
 mUdHHkBrBDKkGBSwL+4Ru3r28nXWvlLJeRtg44x9Zpe/TTFqmpObGvcGEYLhGLkB6Z8W
 KgimRCU8zHJHjdjuGgQzYDn58eMiRRYDCe3lweeot4XLIEcOBRlpX9D1avuoRZUCMFJp
 1P69XXUJVTQ+5IueEBqPt+vrZ79lsFc/kKfNDu1VedasFy6/f//1ZDDKZKIbywmRc237
 iwlw==
X-Gm-Message-State: AOAM530lpW2l3X3me1VudSdvijAByqte6tpD2ozaDxJgr2AGrAzY6mKQ
 mVjMcE5PPl+438P5apaVeg3ADA==
X-Google-Smtp-Source: ABdhPJwMIRBPr3Srqb6v+nLNKSuOmvLocW13PX16x6OR7/WzTgLCBYVK6/lEIgATq6RrYUpc++hvVA==
X-Received: by 2002:a05:6402:1285:: with SMTP id
 w5mr33047361edv.73.1593097991757; 
 Thu, 25 Jun 2020 08:13:11 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id a13sm18315114edk.58.2020.06.25.08.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 08:13:10 -0700 (PDT)
Subject: Re: [PATCH 5/6] block: add zone attr. to zone mgmt IOCTL struct
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-nvme@lists.infradead.org
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-6-javier@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9ac40166-5731-692a-d476-0da9aad2a9aa@lightnvm.io>
Date: Thu, 25 Jun 2020 17:13:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-6-javier@javigon.com>
Content-Language: en-US
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
Cc: axboe@kernel.dk, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUvMDYvMjAyMCAxNC4yMSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBGcm9tOiBKYXZp
ZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPgo+IEFkZCB6b25lIGF0dHJp
YnV0ZXMgZmllbGQgdG8gdGhlIGJsa196b25lIHN0cnVjdHVyZS4gVXNlIFpOUyBhdHRyaWJ1dGVz
Cj4gYXMgYmFzZSBmb3Igem9uZWQgYmxvY2sgZGV2aWNlcyBpbiBnZW5lcmFsLgo+Cj4gU2lnbmVk
LW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogU2VsdmFLdW1hciBTIDxzZWx2YWt1bWEuczFAc2Ftc3VuZy5jb20+Cj4gU2ln
bmVkLW9mZi1ieTogS2FuY2hhbiBKb3NoaSA8am9zaGkua0BzYW1zdW5nLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBOaXRlc2ggU2hldHR5IDxuai5zaGV0dHlAc2Ftc3VuZy5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL252bWUvaG9zdC96bnMuYyAgICAgICB8ICAxICsKPiAgIGluY2x1ZGUvdWFwaS9saW51
eC9ibGt6b25lZC5oIHwgMTMgKysrKysrKysrKysrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1l
L2hvc3Qvem5zLmMgYi9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+IGluZGV4IDI1OGQwMzYxMGNj
MC4uN2Q4MzgxZmU3NjY1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPiBAQCAtMTk1LDYgKzE5NSw3IEBAIHN0YXRp
YyBpbnQgbnZtZV96b25lX3BhcnNlX2VudHJ5KHN0cnVjdCBudm1lX25zICpucywKPiAgIAl6b25l
LmNhcGFjaXR5ID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUoZW50cnktPnpjYXAp
KTsKPiAgIAl6b25lLnN0YXJ0ID0gbnZtZV9sYmFfdG9fc2VjdChucywgbGU2NF90b19jcHUoZW50
cnktPnpzbGJhKSk7Cj4gICAJem9uZS53cCA9IG52bWVfbGJhX3RvX3NlY3QobnMsIGxlNjRfdG9f
Y3B1KGVudHJ5LT53cCkpOwo+ICsJem9uZS5hdHRyID0gZW50cnktPnphOwo+ICAgCj4gICAJcmV0
dXJuIGNiKCZ6b25lLCBpZHgsIGRhdGEpOwo+ICAgfQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vh
cGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCj4gaW5k
ZXggMGM0OWE0YjJjZTVkLi4yZTQzYTAwZTM0MjUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS91YXBp
L2xpbnV4L2Jsa3pvbmVkLmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+
IEBAIC04Miw2ICs4MiwxNiBAQCBlbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyB7Cj4gICAJQkxL
X1pPTkVfUkVQX0NBUEFDSVRZCT0gKDEgPDwgMCksCj4gICB9Owo+ICAgCj4gKy8qKgo+ICsgKiBa
b25lIEF0dHJpYnV0ZXMKPiArICovCj4gK2VudW0gYmxrX3pvbmVfYXR0ciB7Cj4gKwlCTEtfWk9O
RV9BVFRSX1pGQwk9IDEgPDwgMCwKPiArCUJMS19aT05FX0FUVFJfRlpSCT0gMSA8PCAxLAo+ICsJ
QkxLX1pPTkVfQVRUUl9SWlIJPSAxIDw8IDIsCgpUaGUgUlpSIGJpdCBpcyBlcXVpdmFsZW50IHRv
IHRoZSBSRVNFVCBiaXQgYWNjZXNzaWJsZSB0aHJvdWdoIHRoZSByZXNldCAKYnl0ZSBpbiBzdHJ1
Y3QgYmxrX3pvbmUuCgpaRkMgaXMgdGllZCB0byBab25lIEFjdGl2ZSBFeGN1cnNpb25zLCBhcyB0
aGVyZSBpcyBubyBzdXBwb3J0IGluIHRoZSAKa2VybmVsIHpvbmUgbW9kZWwgZm9yIHRoYXQuIFRo
aXMgc2hvdWxkIHByb2JhYmx5IG5vdCBiZSBhZGRlZCB1bnRpbCAKdGhlcmUgaXMgZ2VuZXJpYyBz
dXBwb3J0LgoKRGFtaWVuLCBjb3VsZCB3ZSBvdmVybG9hZCB0aGUgc3RydWN0IGJsa196aW5lIHJl
c2V0IHZhcmlhYmxlIGZvciBGWlI/IEkgCmRvbid0IGJlbGlldmUgd2UgY2FuIGR1ZSB0byBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5LiBJcyB0aGF0IHlvdXIgCnVuZGVyc3RhbmRpbmcgYXMgd2VsbD8K
Cj4gKwlCTEtfWk9ORV9BVFRSX1pERVYJPSAxIDw8IDcsCgpUaGVyZSBpcyBub3QgY3VycmVudGx5
IGFuIGVxdWl2YWxlbnQgZm9yIHpvbmUgZGVzY3JpcHRvciBleHRlbnNpb25zIGluIApaQUMvWkJD
LiBUaGUgYWRkaXRpb24gb2YgdGhpcyBmaWVsZCBzaG91bGQgcHJvYmFibHkgYmUgaW4gYSBwYXRj
aCB0aGF0IAphZGRzIGdlbmVyaWMgc3VwcG9ydCBmb3Igem9uZSBkZXNjcmlwdG9yIGV4dGVuc2lv
bnMuCgo+ICt9Owo+ICsKPiAgIC8qKgo+ICAgICogc3RydWN0IGJsa196b25lIC0gWm9uZSBkZXNj
cmlwdG9yIGZvciBCTEtSRVBPUlRaT05FIGlvY3RsLgo+ICAgICoKPiBAQCAtMTA4LDcgKzExOCw4
IEBAIHN0cnVjdCBibGtfem9uZSB7Cj4gICAJX191OAljb25kOwkJLyogWm9uZSBjb25kaXRpb24g
Ki8KPiAgIAlfX3U4CW5vbl9zZXE7CS8qIE5vbi1zZXF1ZW50aWFsIHdyaXRlIHJlc291cmNlcyBh
Y3RpdmUgKi8KPiAgIAlfX3U4CXJlc2V0OwkJLyogUmVzZXQgd3JpdGUgcG9pbnRlciByZWNvbW1l
bmRlZCAqLwo+IC0JX191OAlyZXN2WzRdOwo+ICsJX191OAlhdHRyOwkJLyogWm9uZSBhdHRyaWJ1
dGVzICovCj4gKwlfX3U4CXJlc3ZbM107Cj4gICAJX191NjQJY2FwYWNpdHk7CS8qIFpvbmUgY2Fw
YWNpdHkgaW4gbnVtYmVyIG9mIHNlY3RvcnMgKi8KPiAgIAlfX3U4CXJlc2VydmVkWzI0XTsKPiAg
IH07CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
