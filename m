Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC73C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A41A221E3
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQZmicxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A41A221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=duY4k3zyy66zX2sYJDNT4VlhI0pqlb5yXo522RpW8II=; b=cQZmicxdAS6oaEWI9kXpXwyQg
	uFluVp1tMQFYNnJAbp89JrHMo7wj3wKfS+Tq6WRNhijC5fbNyC+0XXv77QZMdoCSBnp+93DdNFXt6
	N6d2KFY7NeBUoimYI3lKSh0BbW7n5We0tN3UE81/gyAXIqfp3LgjDQHQvtKrQYN9h/2zy+IY04p6D
	sMtpfGO3/2J214c6jUkbhVtECVUdUtx1IXdKEloEOKwSFV7uHd1dnjBfTqFOEY4XDvlhFdik9D06o
	Uz+HETqdwtb/Fca9/iQCUiCsjKFLjQgkiX9Ei813icGnZQtxdFXp4P0QkdWWrklLcxOO6c+HxDrp3
	6tJsqNUNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3mEm-0005Q5-SU; Thu, 06 Aug 2020 20:11:40 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3mEl-0005PP-Ag
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 20:11:40 +0000
Received: by mail-pj1-f68.google.com with SMTP id t6so7258756pjr.0
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 13:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eoZmty2GiK8lToQ/RFOjDHzbYQ3omD4gJiq4MtExz08=;
 b=sPk4wFwDdXOM25t4CSuPKtjG0ZIwc+PQZMN8tmZUSiOkDt1WauXDyz+omO3XaBl9JF
 oVNVI29lSFRqlHFvpL5oeCu6K8D80Gw/yjqPM2PwLnhalkiUzzxJDq2oawjJvt/igmX0
 gDgnmBkUOrbipD+B0q+vXj4IcWQQa5aMyVy7mHH239F3jm30PZO4rv3JfsH1ZMTZYTA7
 1eXpHYep6CqgFLHhd8TyzvzSJBs65Du3BRjI04EVCoko2VVtgD0xETVg43SvmlChKSGE
 x37Wbgk5Xhq0+taJbNGromHrKOrMVK50/hZqdbu5dSdvNGZaMahshSGi3wSV8gv1grWM
 De0g==
X-Gm-Message-State: AOAM530ZXA0JJLUbTSRCtIRYAuVXspHdWz8EdGSX7O1UP/TAh1fiIf/d
 B9FI15k6rkB/fylJ4xI6CHQ=
X-Google-Smtp-Source: ABdhPJwtheUCElk0R+azfVgXj+UnF/odwCgUCVEyLq0ZdTrxT+EieNtW3rH7vp0lHdA5QaBPdEEPHg==
X-Received: by 2002:a17:90a:fd81:: with SMTP id
 cx1mr10110038pjb.90.1596744698179; 
 Thu, 06 Aug 2020 13:11:38 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id k23sm7893778pgb.92.2020.08.06.13.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 13:11:37 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <f2d0d1cb-f4d5-4b47-4b76-ba7d5198c74d@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ba89a0c9-1e99-25fd-e691-6e35c6ba4b6e@grimberg.me>
Date: Thu, 6 Aug 2020 13:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f2d0d1cb-f4d5-4b47-4b76-ba7d5198c74d@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_161139_379407_0432AE47 
X-CRM114-Status: GOOD (  17.41  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEBAIC0xOTQ2LDYgKzE5NDcsMjIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfY21faGFuZGxl
cihzdHJ1Y3QgCj4+IHJkbWFfY21faWQgKmNtX2lkLAo+PiDCoMKgwqDCoMKgIHJldHVybiAwOwo+
PiDCoCB9Cj4+ICtzdGF0aWMgdm9pZCBudm1lX3JkbWFfY29tcGxldGVfdGltZWRfb3V0KHN0cnVj
dCByZXF1ZXN0ICpycSkKPj4gK3sKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX3JlcXVlc3Qg
KnJlcSA9IGJsa19tcV9ycV90b19wZHUocnEpOwo+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JkbWFf
cXVldWUgKnF1ZXVlID0gcmVxLT5xdWV1ZTsKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9yZG1hX2N0
cmwgKmN0cmwgPSBxdWV1ZS0+Y3RybDsKPj4gKwo+PiArwqDCoMKgIC8qIGZlbmNlIG90aGVyIGNv
bnRleHRzIHRoYXQgbWF5IGNvbXBsZXRlIHRoZSBjb21tYW5kICovCj4+ICvCoMKgwqAgZmx1c2hf
d29yaygmY3RybC0+ZXJyX3dvcmspID4gK8KgwqDCoCBudm1lX3JkbWFfc3RvcF9xdWV1ZShxdWV1
ZSk7Cj4+ICvCoMKgwqAgaWYgKGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpCj4+ICvCoMKg
wqDCoMKgwqDCoCByZXR1cm47Cj4+ICvCoMKgwqAgbnZtZV9yZXEocnEpLT5mbGFncyB8PSBOVk1F
X1JFUV9DQU5DRUxMRUQ7Cj4+ICvCoMKgwqAgbnZtZV9yZXEocnEpLT5zdGF0dXMgPSBOVk1FX1ND
X0hPU1RfQUJPUlRFRF9DTUQ7Cj4+ICvCoMKgwqAgYmxrX21xX2NvbXBsZXRlX3JlcXVlc3QocnEp
Owo+IAo+IAo+IElmIGtlZXBfYWxpdmUgdGltZXMgb3V0LCBpcyBpcyBwb3NzaWJsZSB3ZSB0cnkg
YW5kCj4gYmxrX21xX2ZyZWVfcmVxdWVzdCgpIHR3aWNlIGZvciBzYW1lIHJlcXVlc3QuCj4gCj4g
YmxrX21xX2NvbXBsZXRlX3JlcXVlc3QKPiAgwqBudm1lX3JkbWFfY29tcGxldGVfcnEKPiAgwqAg
YmxrX21xX2VuZF9yZXF1ZXN0Cj4gIMKgwqAgX19ibGtfbXFfZW5kX3JlcXVlc3QKPiAgwqDCoMKg
IHJxLT5lbmRfaW8ocnEsIGVycm9yKSAtIG52bWVfa2VlcF9hbGl2ZV9lbmRfaW8KPiAgwqDCoMKg
wqAgYmxrX21xX2ZyZWVfcmVxdWVzdAo+ICDCoMKgwqDCoMKgIF9fYmxrX21xX2ZyZWVfcmVxdWVz
dAo+ICDCoMKgwqDCoMKgwqDCoCBycS0+bXFfaGN0eCA9IE5VTEw7Cj4gLgo+IC4KPiAuCj4gcmV0
dXJuIEJMS19FSF9ET05FIHRvIGJsa19tcV9ycV90aW1lZF9vdXQKPiAKPiBBbmQgdGhlbiBiZWZv
cmUgcmV0dXJuaW5nIGZyb20gYmxrX21xX2NoZWNrX2V4cGlyZWQKPiBiYWNrIGRvd24KPiAKPiBy
cS0+ZW5kX2lvKHJxLCAwKQo+ICDCoG52bWVfa2VlcF9hbGl2ZV9lbmRfaW8KPiAgwqAgYmxrX21x
X2ZyZWVfcmVxdWVzdAo+ICDCoMKgIGF0b21pY19kZWMoJmhjdHgtPm5yX2FjdGl2ZSkKPiAKPiBz
aW5jZSBycS0+bXFfaGN0eCBpcyBub3cgTlVMTCwgY3Jhc2ggaW4gYmxrX21xX2ZyZWVfcmVxdWVz
dAoKQnV0IHRoZSBrZWVwIGFsaXZlIHJlcXVlc3QgaXMgbm90IGEgZmx1c2ggcmVxdWVzdC4uLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
