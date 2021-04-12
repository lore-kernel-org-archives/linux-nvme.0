Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C67C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:26:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E68611F0
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 09:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E68611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eEeC6eQK/Vhv4acs/tzltjEeK3cHGOpDwwaSNHelZGg=; b=f0kt5F/jxySDgUsEFLw3oVW2K
	OkdiVdvkFdfEWG9cpAtJGHuom0z2o1ylFmrFIcH3aLqDQdq7cFemiyUJq6Mg7vpgHxKqwyacpt5JM
	wLn3hGH5rRAPES6OvUiMOhHE7BtNEfl2cTU8ujZ52NcCzIGcILQ7CCV+iuThsA7Pa1bQCrn8CI6yZ
	Ik9wpGsvd6iuSlE1zGCCDVqcfZAACbt9g4UfvfRyYLOeocDnG4PzgH7Sh1J/hb03Y5BSknHX06+ow
	2y6H1KbhBZ+H0OH88VRBcR9rrqnxr8RBgnPHV7tOjUabYgfHY/ED+9HLz1o+9agk9P4kcBKM4XwxR
	YFw+f3DJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVspu-006Gqi-Aj; Mon, 12 Apr 2021 09:26:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVspp-006GqY-Bx
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 09:26:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Zq6SzHAm3RCM5GyicGRVZyYMAiAaSoDTa2/IPNgAZCg=; b=nlsHPjma1CBT9n2jeawQ2+CEkL
 fEAsVmytz6204RcKBMTvMz982o8c7coP8Buzl1ZD1QW6LFsptNVwoBjliSFtDMaKL8hFTNWVN9Rhd
 I2cZ+4XCcIx4p4iPTjQpcnAvkIuekj/5OYdv2UsyLEwS9XM2w5VGYzRXFv8Zx0Ljn9iAjhikaZnnI
 b0awkuCRUQPk+LWBgA+0oGVjdph9nsEiPb9V0QgUkeIbCZsX+XEl7U3g2mXRI6HOVMnDjXUn/StET
 PIpvXTv/s6XK3ENFpNV1jTXCnwwGI6fEskmW1wdAZT2N5OpvPwySFIGVTfA+8H3AW8CTcKA/NXhrH
 8LhcQIZg==;
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVspm-0063PW-LX
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 09:26:19 +0000
Received: by mail-ed1-x52a.google.com with SMTP id f8so14203681edd.11
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 02:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Zq6SzHAm3RCM5GyicGRVZyYMAiAaSoDTa2/IPNgAZCg=;
 b=VJEJli/YmKEoboEU7bmA8IIevz4AciNwN+egJpzaLtpzWsNrc308boHUAwIBZpimhd
 PgB1niK4vagyyiT/oNdzxez8AqAuMEY0NlkZM/dN055NoIBR8f1HNSPG7/ngraOmM7KX
 4syMnjdAWJ1ueinRj1Vyt+ZsmbzuPW3I0+Tf2yHfbn0BHUUp3aSDztMIv8+Zn3TmtciV
 oe35ll/7IB7M6V5lSq+OV2oKwySi/QoyViKCrdsZ9uPvD6dRNWYmEcS0JuA+XG88aMas
 7x5ZuwlvbqwbiGnE6JvprSRZwnfHWG0lwm2f8K7fiXNnqhCFeeTRpjXbY77gn/3fM1yZ
 9cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Zq6SzHAm3RCM5GyicGRVZyYMAiAaSoDTa2/IPNgAZCg=;
 b=CGhWHDDpl3xZCmAHOgjgIs4XGBVtSa5BMc98QyLIdQnsSCZRZBpnu5H4mDoq0fIOza
 MyOT9kDKjGk4kVJwEFfJ6tpRdbxu7oPdQG01BR61MFYgMUxWs9fz+kzkZMA2wW9CsFsx
 /jU0JQxrQcS1UVfM0Ye00uq5POR9LAmwaQv3dvrxTNmHmd6Y+FlVEOLMFVVwXznqEdww
 yfmCxPQKRurtk0+1jglnXwJUXFBmDgxs6I07UIwLvYKkbDKln05K/HW5TL3QzsUTqbYA
 o6IHF6hVaMUB/11ReeLgbx+27jqbSPwgjbUvwinAIYGsXq6bUSaydqw5osUYdn9nsrAA
 +qtw==
X-Gm-Message-State: AOAM5326ZW+FNT668TFe50liqbyciI10zB2/z79HZmat/Zz7WcomjSrO
 /qcy/AciuZW76TiWUxD+Mtl2WMw31XBHiw==
X-Google-Smtp-Source: ABdhPJzeI6cNp7Qa3gKMGM8vTCwxQig0Bi7cmjH52gDYxJ4v1s0F1fux5V53xrPGrst6uuPbstpNzw==
X-Received: by 2002:a05:6402:506:: with SMTP id
 m6mr27494810edv.157.1618219575833; 
 Mon, 12 Apr 2021 02:26:15 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id n13sm1689950ejx.27.2021.04.12.02.26.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Apr 2021 02:26:15 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Message-ID: <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
Date: Mon, 12 Apr 2021 11:26:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_022618_730652_908D415E 
X-CRM114-Status: GOOD (  19.57  )
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

T24gMTIvMDQvMjAyMSAxMS4yMSwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPiBPbiAxMi8wNC8y
MDIxIDEwLjEyLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gTGlnaHRudm0gd2FzIGFuIGlu
bm92YXRpdmUgaWRlYSB0byBleHBvc2UgbW9yZSBsb3ctbGV2ZWwgY29udHJvbCBvdmVyIAo+PiBT
U0RzLgo+PiBCdXQgaXQgZmFpbGVkIHRvIGdldCBwcm9wZXJseSBzdGFuZGFyZGl6ZWQgYW5kIHJl
bWFpbnMgYSBub24tc3RhbmRhcml6ZWQKPj4gZXh0ZW5zaW9uIHRvIE5WTWUgdGhhdCByZXF1aXJl
cyB2ZW5kb3Igc3BlY2lmaWMgcXVpcmtzIGZvciBhIGZldyBub3cgCj4+IG1vc3RseQo+PiBvYnNv
bGV0ZSBTU0QgZGV2aWNlcy7CoCBUaGUgc3RhbmRhcmRpemVkIFpOUyBjb21tYW5kIHNldCBmb3Ig
TlZNZSBoYXMgCj4+IHRha2UKPj4gb3ZlciBhIGxvdCBvZiB0aGUgYXBwcm9hY2hlcyBhbmQgYWxs
b3dzIGZvciBmdWxseSBzdGFuZGFyZGl6ZWQgCj4+IG9wZXJhdGlvbi4KPj4KPj4gUmVtb3ZlIHRo
ZSBMaW51eCBjb2RlIHRvIHN1cHBvcnQgb3BlbiBjaGFubmVsIFNTRHMgYXMgdGhlIGZldyBwcm9k
dWN0aW9uCj4+IGRlcGxveW1lbnRzIG9mIHRoZSBhYm92ZSBtZW50aW9uZWQgU1NEcyBhcmUgdXNp
bmcgdXNlcnNwYWNlIGRyaXZlciAKPj4gc3RhY2tzCj4+IGluc3RlYWQgb2YgdGhlIGZhaXJseSBs
aW1pdGVkIExpbnV4IHN1cHBvcnQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxs
d2lnIDxoY2hAbHN0LmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9saWdodG52bS9LY29uZmlnIHwg
NCArKystCj4+IMKgIGRyaXZlcnMvbGlnaHRudm0vY29yZS5jwqAgfCAyICsrCj4+IMKgIDIgZmls
ZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2xpZ2h0bnZtL0tjb25maWcgYi9kcml2ZXJzL2xpZ2h0bnZtL0tjb25maWcK
Pj4gaW5kZXggNGMyY2UyMTBjMTIzN2QuLjA0Y2FhMGYyZDQ0NWM3IDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2xpZ2h0bnZtL0tjb25maWcKPj4gKysrIGIvZHJpdmVycy9saWdodG52bS9LY29uZmln
Cj4+IEBAIC00LDcgKzQsNyBAQAo+PiDCoCAjCj4+IMKgIMKgIG1lbnVjb25maWcgTlZNCj4+IC3C
oMKgwqAgYm9vbCAiT3Blbi1DaGFubmVsIFNTRCB0YXJnZXQgc3VwcG9ydCIKPj4gK8KgwqDCoCBi
b29sICJPcGVuLUNoYW5uZWwgU1NEIHRhcmdldCBzdXBwb3J0IChERVBSRUNBVEVEKSIKPj4gwqDC
oMKgwqDCoCBkZXBlbmRzIG9uIEJMT0NLCj4+IMKgwqDCoMKgwqAgaGVscAo+PiDCoMKgwqDCoMKg
wqDCoCBTYXkgWSBoZXJlIHRvIGdldCB0byBlbmFibGUgT3Blbi1jaGFubmVsIFNTRHMuCj4+IEBA
IC0xNSw2ICsxNSw4IEBAIG1lbnVjb25maWcgTlZNCj4+IMKgwqDCoMKgwqDCoMKgIElmIHlvdSBz
YXkgTiwgYWxsIG9wdGlvbnMgaW4gdGhpcyBzdWJtZW51IHdpbGwgYmUgc2tpcHBlZCBhbmQgCj4+
IGRpc2FibGVkCj4+IMKgwqDCoMKgwqDCoMKgIG9ubHkgZG8gdGhpcyBpZiB5b3Uga25vdyB3aGF0
IHlvdSBhcmUgZG9pbmcuCj4+IMKgICvCoMKgwqDCoMKgIFRoaXMgY29kZSBpcyBkZXByZWNhdGVk
IGFuZCB3aWxsIGJlIHJlbW92ZWQgaW4gTGludXggNS4xNS4KPj4gKwo+PiDCoCBpZiBOVk0KPj4g
wqAgwqAgY29uZmlnIE5WTV9QQkxLCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2xpZ2h0bnZtL2Nv
cmUuYyBiL2RyaXZlcnMvbGlnaHRudm0vY29yZS5jCj4+IGluZGV4IDI4ZGRjYWE1MzU4YjE0Li40
Mzk0ZjQ3YzgxMjk2YSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9saWdodG52bS9jb3JlLmMKPj4g
KysrIGIvZHJpdmVycy9saWdodG52bS9jb3JlLmMKPj4gQEAgLTExNzQsNiArMTE3NCw4IEBAIGlu
dCBudm1fcmVnaXN0ZXIoc3RydWN0IG52bV9kZXYgKmRldikKPj4gwqAgewo+PiDCoMKgwqDCoMKg
IGludCByZXQsIGV4cF9wb29sX3NpemU7Cj4+IMKgICvCoMKgwqAgcHJfd2Fybl9vbmNlKCJsaWdo
dG52bSBzdXBwb3J0IGlzIGRlcHJlY2F0ZWQgYW5kIHdpbGwgYmUgCj4+IHJlbW92ZWQgaW4gTGlu
dXggNS4xNS5cbiIpOwo+PiArCj4+IMKgwqDCoMKgwqAgaWYgKCFkZXYtPnEgfHwgIWRldi0+b3Bz
KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBrcmVmX3B1dCgmZGV2LT5yZWYsIG52bV9mcmVlKTsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Cj4gVGhhbmtzLCBDaHJpc3Rv
cGguCj4KPiBJJ2xsIHNlbmQgaXQgdG8gSmVucyB3aXRoIHRvZGF5J3MgbGlnaHRudm0gUFIuCgpK
YXZpZXIsIGNhbiBJIGFkZCB5b3VyIHJldmlld2VkLWJ5PwoKVGhhbmsgeW91LgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
