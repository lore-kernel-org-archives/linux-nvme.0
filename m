Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E55C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:06:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B56206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NGfd40rq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbLi3jnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B56206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0EUW58eV3b2o38gT3o3BVWGfcl6esRzScKYDnuqebt4=; b=NGfd40rq/REIL6jP0CC6b7RAK
	ssKaURHikbGAsTuy2GYuFjwqj2ek+O8MlhJ6rl+qPqEThqObwXI2uBREBmI+goFkPWW8hexbv5g4R
	BbMGjPYskhjfEPcBbtP3cAnwpPceyFbVEj0gt2fGqV+9Q479Ja8CnMKHyrxMrPo+rFpFA2RCRLhPD
	whlWJgmmBJlEFWW/CY/lleFbTprwDWu9dvXZxTvMj3yWLJABhHXenXGyla0Im3G0IGYUN0F8f1Jbc
	4WOm8TEO1WzKdcSZGVcjDMQ1stseC/HHNs1DqdLAcOp/15y7gCwb50zcyrkIrULZphY6w6tbj86gt
	tgWpzwYXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khYxc-0002bl-Hw; Tue, 24 Nov 2020 14:06:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khYxZ-0002bD-Mr
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 14:06:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606226781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eBO0SmdWfHJMWvxPw/zFAYNKqN9n70rfpX1FzfBSls=;
 b=KbLi3jnO4JohZPaHmRpcaDfh2Hl2qU7hTeZP7RvmpW5C5PZbWbi1NGqnDDQTeffY4e67U0
 JylPG6jhOTqXeB5/d/zRBDSjWWHZ6sr0RgkFk3e5fuiF1PNOEUCS3eUfi6dRMq2PXebv5i
 M6bEpfu5BFJd5/npngZecZuiID6e+IY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-Ms0u1oPmMgWE_clDbbFA-Q-1; Tue, 24 Nov 2020 09:06:17 -0500
X-MC-Unique: Ms0u1oPmMgWE_clDbbFA-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1AC0B8105;
 Tue, 24 Nov 2020 14:06:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B4BC60864;
 Tue, 24 Nov 2020 14:06:13 +0000 (UTC)
Subject: Re: [PATCH blktests 3/5] tests/nvmeof-mp/012: fix the schedulers list
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-4-yi.zhang@redhat.com>
 <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7da7adbc-1831-a4e3-805c-a72649893309@redhat.com>
Date: Tue, 24 Nov 2020 22:06:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <241aba9c-b57b-e81a-63b9-d79a3178d946@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_090621_817077_5D5974AB 
X-CRM114-Status: GOOD (  18.29  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8yNC8yMCAxMToyOCBBTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDExLzIz
LzIwIDU6MDQgUE0sIFlpIFpoYW5nIHdyb3RlOgo+PiBUaGVyZSBpcyBubyBjZmcgc2NoZWR1bGVy
IGFuZCBuZXcgYWRkZWQga3liZXIgc2NoZWR1bGVyIGluIGxhc3Rlc3Qga2VybmVsLAo+ICAgICAg
ICAgICAgICAgIF5eXgo+ICAgICAgICAgICAgICAgIGNmcT8KVGhhbmtzLgo+PiBzbyBnZXQgdGhl
IHNjaGVkdWxlciBmcm9tIHN5c2ZzCj4gWyAuLi4gXQo+Cj4+ICAgCSMgTG9hZCBhbGwgSS9PIHNj
aGVkdWxlciBrZXJuZWwgbW9kdWxlcwo+PiAgIAlmb3IgbSBpbiAiL2xpYi9tb2R1bGVzLyQodW5h
bWUgLXIpL2tlcm5lbC9ibG9jay8iKi5rbzsgZG8KPj4gQEAgLTE3LDE1ICsxNywxNyBAQCB0ZXN0
X2lvX3NjaGVkdWxlcnMoKSB7Cj4+ICAgCWZvciBtcSBpbiB5IG47IGRvCj4+ICAgCQl1c2VfYmxr
X21xICR7bXF9IHx8IHJldHVybiAkPwo+PiAgIAkJZGV2PSQoZ2V0X2JkZXYgMCkgfHwgcmV0dXJu
ICQ/Cj4+IC0JCWZvciBzY2hlZCBpbiBub29wIGRlYWRsaW5lIGJmcSBjZnE7IGRvCj4+IC0JCQlz
ZXRfc2NoZWR1bGVyICIkKGJhc2VuYW1lICIkKHJlYWRsaW5rIC1mICIke2Rldn0iKSIpIiAkc2No
ZWQgXAo+PiArCQlkbT0kKGJhc2VuYW1lICIkKHJlYWRsaW5rIC1mICIke2Rldn0iKSIpIHx8IHJl
dHVybiAkPwo+PiArCQlzY2hlZHM9JChzZWQgJ3MvW11bXS8vZycgL3N5cy9ibG9jay8iJGRtIi9x
dWV1ZS9zY2hlZHVsZXIpIHx8IHJldHVybiAkPwo+PiArCQlmb3Igc2NoZWQgaW4gJHNjaGVkczsg
ZG8KPj4gKwkJCXNldF9zY2hlZHVsZXIgIiRkbSIgIiRzY2hlZCIgXAo+IFNpbWlsYXIgY29kZSBv
Y2N1cnMgaW4gdGVzdHMvc3JwLzAxMi4gUGxlYXNlIGludHJvZHVjZSBhIGZ1bmN0aW9uIGZvcgo+
IHJldHJpZXZpbmcgdGhlIHNjaGVkdWxlciBsaXN0IGFuZCBhbHNvIHVwZGF0ZSB0ZXN0cy9zcnAv
MDEyLgpPSywgd2lsbCBhZGQgYmVsb3cgZnVuY3Rpb24gYW5kIHVwZGF0ZSBib3RoIG52bWVvZi1t
cC8wMTIgYW5kIHNycC8wMTIKCmRpZmYgLS1naXQgYS9jb21tb24vbXVsdGlwYXRoLW92ZXItcmRt
YSBiL2NvbW1vbi9tdWx0aXBhdGgtb3Zlci1yZG1hCmluZGV4IGQwZmVjNmYuLmQxNTZhMTIgMTAw
NjQ0Ci0tLSBhL2NvbW1vbi9tdWx0aXBhdGgtb3Zlci1yZG1hCisrKyBiL2NvbW1vbi9tdWx0aXBh
dGgtb3Zlci1yZG1hCkBAIC0zMjYsNiArMzI2LDE4IEBAIHNldF9zY2hlZHVsZXIoKSB7CiDCoMKg
wqDCoMKgwqDCoCBmaQogwqB9CgorIyBHZXQgYmxvY2sgZGV2IHNjaGVkdWxlciBsaXN0CitnZXRf
c2NoZWR1bGVyX2xpc3QoKSB7CivCoMKgwqDCoMKgwqAgbG9jYWwgYj0kMSBwCivCoMKgwqDCoMKg
wqAgcD0vc3lzL2Jsb2NrLyIkYiIvcXVldWUvc2NoZWR1bGVyCivCoMKgwqDCoMKgwqAgaWYgWyAt
ZSAiJHAiIF07IHRoZW4KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzPSQoc2Vk
ICdzL1tdW10vL2cnIC9zeXMvYmxvY2svIiRiIi9xdWV1ZS9zY2hlZHVsZXIpCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVjaG8gIiRzY2hlZHMiCivCoMKgwqDCoMKgwqAgZWxzZQorwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMQorwqDCoMKgwqDCoMKgIGZpCit9CisK
Cj4gVGhhbmtzLAo+Cj4gQmFydC4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4gTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKPiBMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
