Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56422C5519F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 03:52:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C764120665
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 03:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CEj/vWpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C764120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=beChwu4e1+laOBcrNDGokx8Abd0ss1FJ3tEvc1y3MdQ=; b=CEj/vWpOnzpSgX4bAGm9nLRpq
	7Fhjwl0bak1Xn2M9IVJiadccl4htJcHjdDLT9i35pcv/ECM0UA0P+sWSYfv9su0WL/VZuKOD9AMNL
	hdt+jqv7Esu8D6R7PnYsNIyXt3/LCjzv8TDdR2rGt/KUo/Lk9L1+vhPLqChj2l48ypjmWLt4f1amt
	BOGOQt6g5Kw6bL5K0kAWkDffsmchR2kg3/QmjJ9Djhfu25khG3VXqyArRI5iYWahcX9N2kN7CW4fx
	3lBcfbGHRQIGqnyaoCxjyWrTfhs4fbsiO/d/8r+2Di3PtoN4QhF5XqxuE0ymJ8U4OMQrXXKfXSTVP
	WUBebNQqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khlqd-0001fb-MD; Wed, 25 Nov 2020 03:52:03 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khlqb-0001fI-Mi
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 03:52:02 +0000
Received: by mail-pf1-f194.google.com with SMTP id b63so1039729pfg.12
 for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2020 19:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tlpeFccO61PHmaoj4C/v9kz1BkfpGnKKt2JvzBnDucE=;
 b=WrOEsJqQZmeZ/GRmtAtRFGCt+CukZj56HpEZIY1y5xy/zStJrN5hLc9ihAwXbaV8xP
 3Zl5W1Db1ehgGdvVPuo8iB/Po2d/XYFdGk0IYbg+LOIcO570yIjMd/ciw+SVdwbhlg6I
 aA5LDQ7sVtuZXatGdfUQ+yiEofTgPH5NduYVVYR7XvioIuyXSn8SlnXzI5u7Mv1GwQlN
 EwyktL5C3Fc7Enijis5S6jSH6m3tqg4+AR3gfcK+idFQARq+oSCS8VWc7bYuUlVdGrnD
 GdjEq9/ewDu0TCsF6eQl8iRDPz9kbnzILqih7RwGVr1WLZviFf8vnxdmvt3lIEIkpLD1
 jNlg==
X-Gm-Message-State: AOAM530nw76SFnQYX6awpbu6AlvNLaow9EpNae/i/67x4HDabdmJs0oG
 DIEm0geolk6PoHC20LJvVpm8/kW7sdM=
X-Google-Smtp-Source: ABdhPJzA9E/CY/Ne+7xWSh6gmlvZsy/MRl0y8R/CJPsqUXxmY8a379Fgf3AESt/9gUhcKdPPn3onQg==
X-Received: by 2002:a05:6a00:22c9:b029:198:15b2:bbd3 with SMTP id
 f9-20020a056a0022c9b029019815b2bbd3mr600168pfj.64.1606276320092; 
 Tue, 24 Nov 2020 19:52:00 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net.
 [73.241.217.19])
 by smtp.gmail.com with ESMTPSA id l17sm693137pjy.29.2020.11.24.19.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2020 19:51:59 -0800 (PST)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To: Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
 <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
Date: Tue, 24 Nov 2020 19:51:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_225201_906661_BEB0B8A2 
X-CRM114-Status: GOOD (  17.99  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjQvMjAgNjowNCBBTSwgWWkgWmhhbmcgd3JvdGU6Cj4gRG8geW91IG1lYW4gc29tZXRo
aW5nIGxpa2UgdGhpcywgY291bGQgeW91IGFkZCBtb3JlIGRldGFpbCBoZXJlLCB0aGFua3MuCj4g
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWVvZi1tcC9yYyBiL3Rlc3RzL252bWVvZi1tcC9yYwo+
IGluZGV4IGQ3YTdjODcuLmFmNzAwZDkgMTAwNzU1Cj4gLS0tIGEvdGVzdHMvbnZtZW9mLW1wL3Jj
Cj4gKysrIGIvdGVzdHMvbnZtZW9mLW1wL3JjCj4gQEAgLTE2LDkgKzE2LDkgQEAgZ3JvdXBfcmVx
dWlyZXMoKSB7Cj4gCj4gwqDCoMKgwqDCoMKgwqAgIyBTaW5jZSB0aGUgbnZtZW9mLW1wIHRlc3Rz
IGFyZSBiYXNlZCBvbiB0aGUgZG0tbXBhdGggZHJpdmVyLCB0aGVzZQo+IMKgwqDCoMKgwqDCoMKg
ICMgdGVzdHMgYXJlIGluY29tcGF0aWJsZSB3aXRoIHRoZSBOVk1FX01VTFRJUEFUSCBrZXJuZWwK
PiBjb25maWd1cmF0aW9uCj4gLcKgwqDCoMKgwqDCoCAjIG9wdGlvbi4KPiAtwqDCoMKgwqDCoMKg
IGlmIF9oYXZlX2tlcm5lbF9vcHRpb24gTlZNRV9NVUxUSVBBVEg7IHRoZW4KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBTS0lQX1JFQVNPTj0iQ09ORklHX05WTUVfTVVMVElQQVRIIGhh
cyBiZWVuIHNldCBpbiAuY29uZmlnIgo+ICvCoMKgwqDCoMKgwqAgIyBvcHRpb24gYW5kIG52bWVf
Y29yZTogbXVsdGlwYXRoIHNldCB3aXRoIFkuCj4gK8KgwqDCoMKgwqDCoCBpZiBfaGF2ZV9rZXJu
ZWxfb3B0aW9uIE5WTUVfTVVMVElQQVRIICYmCj4gX2hhdmVfbW9kdWxlX3BhcmFtX3ZhbHVlIG52
bWVfY29yZSBtdWx0aXBhdGggWTsgdGhlbgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFNLSVBfUkVBU09OPSJDT05GSUdfTlZNRV9NVUxUSVBBVEggaGFzIGJlZW4gc2V0IGluCj4gLmNv
bmZpZyBhbmQgbnZtZV9jb3JlOiBtdWx0aXBhdGggc2hvdWxkIGJlIHNldCB3aXRoIE4iCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybgo+IMKgwqDCoMKgwqDCoMKgIGZpCgpJ
IG1heSBoYXZlIHNlbnQgeW91IGluIHRoZSB3cm9uZyBkaXJlY3Rpb24uIFRoaXMgaXMgd2hhdCBJ
IG1lYW50OgoKCWlmIF9oYXZlX2tlcm5lbF9vcHRpb24gTlZNRV9NVUxUSVBBVEggJiYKCSAgICBf
aGF2ZV9tb2R1bGVfcGFyYW1fdmFsdWUgbnZtZV9jb3JlIG11bHRpcGF0aCBZOyB0aGVuCgkgICAg
U0tJUF9SRUFTT049IkNPTkZJR19OVk1FX01VTFRJUEFUSCBoYXMgYmVlbiBzZXQgaW4gLmNvbmZp
ZyBhbmQKbXVsdGlwYXRoaW5nIGhhcyBiZWVuIGVuYWJsZWQgaW4gdGhlIG52bWVfY29yZSBrZXJu
ZWwgbW9kdWxlIgoJICAgIHJldHVybgoJZmkKClRoYW5rcywKCkJhcnQuCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlz
dApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
