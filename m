Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B593C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:17:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035462177B
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 08:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dxNBCcla"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035462177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G3iMHX/QT+nh1Ur6REiUjutZbzkFFqAu648Bp5MpDvA=; b=dxNBCclaD4TyHfKMlLjwhV/g9
	ZXVhw90q3G6nhEPhLcZAo2k1PvDf/82rfQW7ZDFuwFZ7bz8X3TlVyJU8zMufnKtEC8RSJleZXl2EC
	BariuwFZF+PmhkDsKZ1/4XLFKN1gSFuJm3/9h3eM7cFaJwVgty7P3kwwv7QcOHAuijwuHIRG6Pkgb
	uQfl2xE7HFc3SOpCNvURz0Tc/RmhRZNqMWZOFQeBNLQwqGynF2d1MpXox6/BU0uho61qhrOVCtGaz
	YHd1dcB/omLQeTc5Wc8G6TtZA0JM3OAYBtb/2SF/QIiuyWE/xs78wkVB7iVZSgIR/kG8RJc/Q++Gq
	/X80ZA8ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Ebi-0006GT-ND; Wed, 05 Aug 2020 08:17:06 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Ebg-0006FM-Qy
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 08:17:05 +0000
Received: by mail-pl1-f194.google.com with SMTP id k13so17006847plk.13
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZymIFpzwwvC1wRwnRoyjsvm/ivvBg3lTo3ydNXOvYV0=;
 b=FpxU3Vanxxeq1903AOqo4+bASN0RutzPXFEuYV1ayOoX//dKtvnUkgrmHfkDrtBy3D
 NYxGDK7DwtJi+AVIyE/GHVI1jxDRnCaeoby4FEVuk2HQldPI1+kaHx2D/yNbvin7vFW7
 jxWoVcR5ZWTFxOyxvlfxuLSudeizA7Y3oXmOvWnSESCQVxZ7m4KshMcWeVbZA4CLAAlf
 WXvqJ+FO8qhB7rpVPDazoyPgSZX8qAcDVdI8iioR4PoZ//X68RMxAE0SUZcHlkV3FTgV
 g969f1yhEBG9U7wAutn7XkMkgruQ2ZNJNm56h/tCA2Einym2GZikx7QO8XYiae1twshX
 czag==
X-Gm-Message-State: AOAM5339DLk0JUu+4a+7kTg7QKRgtHNuaqyejFrvodLRtn2/Ev8y1cgW
 rhxPVl8xvkGp4BuMzcb6bFA=
X-Google-Smtp-Source: ABdhPJxRCJBQFeyAfQGVGikcLfOBl/x2OPOZKEWBe7WYSgY7/izUy7+exIVmW2UhLaJPQ0XngEnKTw==
X-Received: by 2002:a17:90b:1493:: with SMTP id
 js19mr1815993pjb.223.1596615423068; 
 Wed, 05 Aug 2020 01:17:03 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e1a8:cb16:c589:8b34?
 ([2601:647:4802:9070:e1a8:cb16:c589:8b34])
 by smtp.gmail.com with ESMTPSA id u26sm2064159pgo.71.2020.08.05.01.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 01:17:02 -0700 (PDT)
Subject: Re: [PATCH 5/6] nvme-rdma: fix timeout handler
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
References: <20200803065852.69987-1-sagi@grimberg.me>
 <20200803065852.69987-6-sagi@grimberg.me>
 <a918db0b-0979-c39f-aefa-e53de249beeb@huawei.com>
 <a05974ca-45cf-8baf-3f68-8c5e8e5ec5a1@grimberg.me>
 <d0b6e574-eee1-02db-e27d-e9c88e5b0c80@huawei.com>
 <938aa34b-b4db-f8ca-2478-0b48954899ea@grimberg.me>
 <85b3a7e5-5769-c1b2-eff5-318671c6850f@huawei.com>
 <7250e072-c0f8-430e-3afe-d0837efe14ad@grimberg.me>
 <7a05ff5c-9ad6-786a-b1a6-9556d520f436@huawei.com>
 <ae787cff-f1a3-b464-f471-18b3d736c381@grimberg.me>
 <537c387f-61e2-77f4-a7ee-55689270bdfd@huawei.com>
 <77794f62-2d4a-d2c9-f474-4ddbb361a308@grimberg.me>
 <60ced5bb-3169-d9fc-4505-6032107d45a3@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ccc941a4-171f-b01b-851a-35079a483255@grimberg.me>
Date: Wed, 5 Aug 2020 01:17:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <60ced5bb-3169-d9fc-4505-6032107d45a3@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_041704_906960_48C11FEA 
X-CRM114-Status: GOOD (  20.74  )
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

Cj4+IEhvdyBpcyBpdCBub3Qgc2FmZT8gd2hlbiBmbHVzaF93b3JrIHJldHVybnMsIHRoZSB3b3Jr
IGlzIGd1YXJhbnRlZWQKPj4gdG8gaGF2ZSBmaW5pc2hlZCBleGVjdXRpb24sIGFuZCB3ZSBvbmx5
IGRvIHRoYXQgZm9yIHN0YXRlcwo+PiBSRVNFVFRJTkcvQ09OTkVDVElORyB3aGljaCBtZWFucyB0
aGF0IGl0IGVpdGhlciBoYXMgYWxyZWFkeSBzdGFydGVkCj4+IG9yIGFscmVhZHkgZmluaXNoZWQu
Cj4gCj4gVGhvdWdoIHRoZSBzdGF0ZSBpcyBOVk1FX0NUUkxfUkVTRVRUSU5HLCBidXQgaXQgZG9l
cyBub3QgbWVhbiB0aGUgd29yawo+IGlzIGFscmVhZHkgcXVldWVkKHN0YXJ0ZWQpIG9yIGZpbmlz
aGVkLiBUaGVyZSBpcyBhIGhvbGUgYmV0d2VlbiBDaGFuZ2UgCj4gc3RhdGUKPiBhbmQgcXVldWUg
d29yay4KPiAKPiBMaWtlIHRoaXM6Cj4gc3RhdGljIHZvaWQgbnZtZV9yZG1hX2Vycm9yX3JlY292
ZXJ5KHN0cnVjdCBudm1lX3JkbWFfY3RybCAqY3RybCkKPiB7Cj4gIMKgwqDCoCBpZiAoIW52bWVf
Y2hhbmdlX2N0cmxfc3RhdGUoJmN0cmwtPmN0cmwsIE5WTUVfQ1RSTF9SRVNFVFRJTkcpKQo+ICDC
oMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiBtYXkgaW50ZXJydXB0IGJ5IGhhcmQgaW50ZXJydXB0LCBhbmQgdGhlbiB0aW1lb3V0IHByb2dy
ZXNzIGZsdXNoIHdvcmsKPiBhdCB0aGlzIHRpbWUuIFRodXMgZXJyb3IgcmVjb3ZlcnkgYW5kIG52
bWVfcmRtYV9jb21wbGV0ZV90aW1lZF9vdXQgbWF5Cj4gY29uY3VycmVudCB0byBzdG9wIHF1ZXVl
LiB3aWxsIGNhdXNlOiBlcnJvciByZWNvdmVyeSBtYXkgY2FuY2VsIHJlcXVlc3QKPiBvciBudm1l
X3JkbWFfY29tcGxldGVfdGltZWRfb3V0IG1heSBjb21wbGV0ZSByZXF1ZXN0LCBidXQgdGhlIHF1
ZXVlIG1heQo+IG5vdCBiZSBzdG9wZWQuIFRodXMgd2lsbCBjYXVzZSBhYm5vcm1hbC4KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICDCoMKgwqAgcXVldWVfd29yayhudm1lX3Jl
c2V0X3dxLCAmY3RybC0+ZXJyX3dvcmspOwo+IH0KPiAKPiBBbm90aGVyLCBhbHRob3VnaCB0aGUg
cHJvYmFiaWxpdHkgb2Ygb2NjdXJyZW5jZSBpcyB2ZXJ5IGxvdywgcmVzZXQgd29yawo+IGFuZCBu
dm1lX3JkbWFfY29tcGxldGVfdGltZWRfb3V0IG1heSBhbHNvIGNvbmN1cnJlbnQgdG8gc3RvcCBx
dWV1ZSwgbWF5Cj4gYWxzbyBjYXVzZSBhYm5vcm1hbC4KCkkgc2VlIHlvdXIgcG9pbnQuCgpXZSBj
YW4gc2VyaWFsaXplIGN0cmwgdGVhcmRvd24gd2l0aCBhIGxvY2sgKHNpbWlsYXIgdG8KZGV2LT5z
aHV0ZG93bl9sb2NrIHRoYXQgd2UgaGF2ZSBpbiBwY2kpLgoKU29tZXRoaW5nIGxpa2U6Ci0tCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9y
ZG1hLmMKaW5kZXggOTZmYTMxODVkMTIzLi44YzhmNzQ5MmNhYjQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3JkbWEuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKQEAgLTEx
NjgsMTEgKzExNjgsMTMgQEAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX2Vycm9yX3JlY292ZXJ5X3dv
cmsoc3RydWN0IAp3b3JrX3N0cnVjdCAqd29yaykKICAgICAgICAgc3RydWN0IG52bWVfcmRtYV9j
dHJsICpjdHJsID0gY29udGFpbmVyX29mKHdvcmssCiAgICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgbnZtZV9yZG1hX2N0cmwsIGVycl93b3JrKTsKCisgICAgICAgbXV0ZXhfbG9jaygmY3Ry
bC0+c2h1dGRvd25fbG9jayk7CiAgICAgICAgIG52bWVfc3RvcF9rZWVwX2FsaXZlKCZjdHJsLT5j
dHJsKTsKICAgICAgICAgbnZtZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhjdHJsLCBmYWxzZSk7
CiAgICAgICAgIG52bWVfc3RhcnRfcXVldWVzKCZjdHJsLT5jdHJsKTsKICAgICAgICAgbnZtZV9y
ZG1hX3RlYXJkb3duX2FkbWluX3F1ZXVlKGN0cmwsIGZhbHNlKTsKICAgICAgICAgYmxrX21xX3Vu
cXVpZXNjZV9xdWV1ZShjdHJsLT5jdHJsLmFkbWluX3EpOworICAgICAgIG11dGV4X3VubG9jaygm
Y3RybC0+c2h1dGRvd25fbG9jayk7CgogICAgICAgICBpZiAoIW52bWVfY2hhbmdlX2N0cmxfc3Rh
dGUoJmN0cmwtPmN0cmwsIE5WTUVfQ1RSTF9DT05ORUNUSU5HKSkgewogICAgICAgICAgICAgICAg
IC8qIHN0YXRlIGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlmIHdlIHN0YXJ0ZWQgY3RybCBkZWxldGUg
Ki8KQEAgLTE5NjQsNyArMTk2Niw5IEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9jb21wbGV0ZV90
aW1lZF9vdXQoc3RydWN0IApyZXF1ZXN0ICpycSkKCiAgICAgICAgIC8qIGZlbmNlIG90aGVyIGNv
bnRleHRzIHRoYXQgbWF5IGNvbXBsZXRlIHRoZSBjb21tYW5kICovCiAgICAgICAgIGZsdXNoX3dv
cmsoJmN0cmwtPmVycl93b3JrKTsKKyAgICAgICBtdXRleF9sb2NrKCZjdHJsLT5zaHV0ZG93bl9s
b2NrKTsKICAgICAgICAgbnZtZV9yZG1hX3N0b3BfcXVldWUocXVldWUpOworICAgICAgIG11dGV4
X3VubG9jaygmY3RybC0+c2h1dGRvd25fbG9jayk7CiAgICAgICAgIGlmIChibGtfbXFfcmVxdWVz
dF9jb21wbGV0ZWQocnEpKQogICAgICAgICAgICAgICAgIHJldHVybjsKICAgICAgICAgbnZtZV9y
ZXEocnEpLT5mbGFncyB8PSBOVk1FX1JFUV9DQU5DRUxMRUQ7CkBAIC0yMjI2LDYgKzIyMzAsNyBA
QCBzdGF0aWMgdm9pZCBudm1lX3JkbWFfc2h1dGRvd25fY3RybChzdHJ1Y3QgCm52bWVfcmRtYV9j
dHJsICpjdHJsLCBib29sIHNodXRkb3duKQogICAgICAgICBjYW5jZWxfd29ya19zeW5jKCZjdHJs
LT5lcnJfd29yayk7CiAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY3RybC0+cmVj
b25uZWN0X3dvcmspOwoKKyAgICAgICBtdXRleF9sb2NrKCZjdHJsLT5zaHV0ZG93bl9sb2NrKTsK
ICAgICAgICAgbnZtZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhjdHJsLCBzaHV0ZG93bik7CiAg
ICAgICAgIGJsa19tcV9xdWllc2NlX3F1ZXVlKGN0cmwtPmN0cmwuYWRtaW5fcSk7CiAgICAgICAg
IGlmIChzaHV0ZG93bikKQEAgLTIyMzMsNiArMjIzOCw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcmRt
YV9zaHV0ZG93bl9jdHJsKHN0cnVjdCAKbnZtZV9yZG1hX2N0cmwgKmN0cmwsIGJvb2wgc2h1dGRv
d24pCiAgICAgICAgIGVsc2UKICAgICAgICAgICAgICAgICBudm1lX2Rpc2FibGVfY3RybCgmY3Ry
bC0+Y3RybCk7CiAgICAgICAgIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZShjdHJsLCBz
aHV0ZG93bik7CisgICAgICAgbXV0ZXhfdW5sb2NrKCZjdHJsLT5zaHV0ZG93bl9sb2NrKTsKICB9
CgogIHN0YXRpYyB2b2lkIG52bWVfcmRtYV9kZWxldGVfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpj
dHJsKQotLQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
