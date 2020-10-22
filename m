Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241C4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 10:06:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBE0223BF
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cp2kDF53";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="nb58Ogku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBE0223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pqa7CXAfOp9R6QgD8Xri0RMZLkSnVVzR40FYcDaDWwM=; b=Cp2kDF53bzU281D+0+kfUjDP+
	H1Rnw2U2+fwtIGSI7iKqLbIJzNspzmU/IvdEOVDT677fx6yth7ZOeGLbKrg6aqeIA+V1wb/Ll3uEq
	Zr4xH72ccQwxTowjMr4plpam6DYuIMDhO0jy6paYSaGnba/kgc+l7hZDk7XVhoPpKEUlL4LVYy9z4
	H0G3kAk1vGX24/1hos/wu9nalLKTti+vWKclLomsHidUAMuOZz0qwf8ylnUp2g8mLZ2UU1dCh1Rjh
	85Au05BRIIFoaIqVrLBfOlyuatew72yYe3/e6FUOxuFeq0RkCIOBe/e3cnse+pGPU9EKOqfsQPYoS
	DhBxseqOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVXTr-000127-B9; Thu, 22 Oct 2020 10:05:59 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVXTn-0000zj-C2
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 10:05:56 +0000
Received: by mail-pg1-x544.google.com with SMTP id h6so649667pgk.4
 for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2020 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9SsBXZDSBj98gvytWEkQs58O58kWQRuE5OR0cysVKT0=;
 b=nb58Ogkumh/AWmt0Eft/7kqaafJ5Nn0Z2Chfc/EMjB37sp2/kmu3f+0LWvZdByzpvq
 GjggOSLsJZfnMczsPb9JvNQBWhL0YlsQjBUwCfCCh2iKGlODFhGESK4PoUXZ++1TWjm2
 Y4GJ78oYUDsW7nR4IeYgbpVzep5aTnjXCKt0Oa6MSo+vjXR+xxdga7bunLNoXQI3yM7L
 lnqP4Xdgi+udE6dm1PIKmwocnTaxNEBQiwxWRW+p9F13vucfQ5WEYFEjTB5Jfyq5OLnu
 fSmIgNSBeHgihvnBt82yYYoX066iqtj5GNs1t7gRDD5ax//Y73JD7dUhXUkd2nZ0BPrg
 ZqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9SsBXZDSBj98gvytWEkQs58O58kWQRuE5OR0cysVKT0=;
 b=GBKPrtKo5/lrF6SrhnzdMZoyoiKq/ce/hIcENYF4gkAVSaCszjC9SSlk3OkmsZ2/N6
 VBeStZ9PD0wARAhi8Ye+JT0b8m5any5MePOsuozv10WCE5Z2PnCSI8M2dPksxiXZ0Mfu
 0AdvQvbf2eaT/0NyOyY2EOj2ShCf7eherUR/SIjtEcYkDKLEwRJBDnP+0orwPllz7Q/e
 XjEc1+5GqZq5oyl1wbnjEjbVFbLkw7RdwOkxUNmXASuD1B678tMhIYJ8vUvowvrH3eSC
 uEIISDXzX6+vhnXkMvqkjtAUsj1ZUoqR2K2Pm1Sc+CiWOnbyOxhn/ACzICZ0vZO+LDaU
 jqfg==
X-Gm-Message-State: AOAM532B6NQuszIDSf5wnQk0HD1h7fUQtVZAOXqn3JnUakxhiapIvwyN
 SwzwtqWu4rO0mpolHc4cKqHLmg==
X-Google-Smtp-Source: ABdhPJwRlAi2VPOFTRdwX0uwoS4bE4j+P41/Sc7/DDSmnv5tg2me6pfLreH3Gkh3MIukMQQZI9G05w==
X-Received: by 2002:a63:ed15:: with SMTP id d21mr1669802pgi.348.1603361150372; 
 Thu, 22 Oct 2020 03:05:50 -0700 (PDT)
Received: from [10.2.24.220] ([61.120.150.77])
 by smtp.gmail.com with ESMTPSA id f7sm1672861pfd.111.2020.10.22.03.05.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 22 Oct 2020 03:05:49 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] nvme-rdma: handle nvme completion data
 length
To: Chao Leng <lengchao@huawei.com>
References: <20201022083850.1334880-1-pizhenwei@bytedance.com>
 <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
From: zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <1c78dbe5-47a4-1590-e064-681cba5fb01d@bytedance.com>
Date: Thu, 22 Oct 2020 18:05:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <04a97f73-ba13-a4b5-3ea4-fc438391507e@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_060555_501572_3CA551EE 
X-CRM114-Status: GOOD (  21.57  )
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org,
 Yibo Zhu <zhuyibo@bytedance.com>, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvMjIvMjAgNTo1NSBQTSwgQ2hhbyBMZW5nIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjAvMTAv
MjIgMTY6MzgsIHpoZW53ZWkgcGkgd3JvdGU6Cj4+IEhpdCBhIGtlcm5lbCB3YXJuaW5nOgo+PiBy
ZWZjb3VudF90OiB1bmRlcmZsb3c7IHVzZS1hZnRlci1mcmVlLgo+PiBXQVJOSU5HOiBDUFU6IDAg
UElEOiAwIGF0IGxpYi9yZWZjb3VudC5jOjI4Cj4+Cj4+IFJJUDogMDAxMDpyZWZjb3VudF93YXJu
X3NhdHVyYXRlKzB4ZDkvMHhlMAo+PiBDYWxsIFRyYWNlOgo+PiDCoCA8SVJRPgo+PiDCoCBudm1l
X3JkbWFfcmVjdl9kb25lKzB4ZjMvMHgyODAgW252bWVfcmRtYV0KPj4gwqAgX19pYl9wcm9jZXNz
X2NxKzB4NzYvMHgxNTAgW2liX2NvcmVdCj4+IMKgIC4uLgo+Pgo+PiBUaGUgcmVhc29uIGlzIHRo
YXQgYSB6ZXJvIGJ5dGVzIG1lc3NhZ2UgcmVjZWl2ZWQgZnJvbSB0YXJnZXQsIGFuZCB0aGUKPj4g
aG9zdCBzaWRlIGNvbnRpbnVlcyB0byBwcm9jZXNzIHdpdGhvdXQgbGVuZ3RoIGNoZWNraW5nLCB0
aGVuIHRoZQo+PiBwcmV2aW91cyBDUUUgaXMgcHJvY2Vzc2VkIHR3aWNlLgo+Pgo+PiBIYW5kbGUg
ZGF0YSBsZW5ndGgsIGlnbm9yZSB6ZXJvIGJ5dGVzIG1lc3NhZ2UsIGFuZCB0cnkgdG8gcmVjb3Zl
cnkgZm9yCj4+IGNvcnJ1cHRlZCBDUUUgY2FzZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogemhlbndl
aSBwaSA8cGl6aGVud2VpQGJ5dGVkYW5jZS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUv
aG9zdC9yZG1hLmMgfCAxMSArKysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIv
ZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+IGluZGV4IDllMzc4ZDBhMGMwMS4uOWY1MTEyMDQw
ZDQzIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPj4gKysrIGIvZHJp
dmVycy9udm1lL2hvc3QvcmRtYS5jCj4+IEBAIC0xNzY3LDYgKzE3NjcsMTcgQEAgc3RhdGljIHZv
aWQgbnZtZV9yZG1hX3JlY3ZfZG9uZShzdHJ1Y3QgaWJfY3EgCj4+ICpjcSwgc3RydWN0IGliX3dj
ICp3YykKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPj4gwqDCoMKgwqDCoCB9Cj4+ICvC
oMKgwqAgaWYgKHVubGlrZWx5KCF3Yy0+Ynl0ZV9sZW4pKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCAv
KiB6ZXJvIGJ5dGVzIG1lc3NhZ2UgY291bGQgYmUgaWdub3JlZCAqLwo+PiArwqDCoMKgwqDCoMKg
wqAgcmV0dXJuOwo+PiArwqDCoMKgIH0gZWxzZSBpZiAodW5saWtlbHkod2MtPmJ5dGVfbGVuIDwg
bGVuKSkgewo+PiArwqDCoMKgwqDCoMKgwqAgLyogQ29ycnVwdGVkIGNvbXBsZXRpb24sIHRyeSB0
byByZWNvdnJ5ICovCj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKHF1ZXVlLT5jdHJsLT5jdHJs
LmRldmljZSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlVuZXhwZWN0ZWQgbnZtZSBjb21w
bGV0aW9uIGxlbmd0aCglZClcbiIsIHdjLT5ieXRlX2xlbik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBu
dm1lX3JkbWFfZXJyb3JfcmVjb3ZlcnkocXVldWUtPmN0cmwpOwo+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOwo+PiArwqDCoMKgIH0KPiAhd2MtPmJ5dGVfbGVuIGFuZCB3Yy0+Ynl0ZV9sZW4gPCBs
ZW4gbWF5IGJlIHRoZSBzYW1lIHR5cGUgb2YgYW5vbWFseS4KPiBXaHkgZG8gZGlmZmVyZW50IGVy
cm9yIGhhbmRsaW5nPwo+IEluIHdoaWNoIHNjZW5hcmlvIHplcm8gYnl0ZXMgbWVzc2FnZSByZWNl
aXZlZCBmcm9tIHRhcmdldD8gZmF1bHQgaW5qZWN0IAo+IHRlc3Qgb3Igbm9ybWFsIHRlc3QvcnVu
PwoKWmVybyBieXRlcyBtZXNzYWdlIGNvdWxkIGJlIHVzZWQgYXMgdHJhbnNwb3J0IGxheWVyIGtl
ZXAgYWxpdmUgbWVjaGFuaXNtIAooSSdzIGFsc28gZGV2ZWxvcGluZyB0YXJnZXQgc2lkZSB0cmFu
c3BvcnQgbGF5ZXIga2VlcCBhbGl2ZSBub3cuIFRvIApyZWNsYWltIHJlc291cmNlLCB0YXJnZXQg
c2lkZSBuZWVkcyB0byBjbG9zZSBkZWFkIGNvbm5lY3Rpb25zIGV2ZW4ga2F0byAKaXMgc2V0IGFz
IDApLgoKPj4gKwo+PiDCoMKgwqDCoMKgIGliX2RtYV9zeW5jX3NpbmdsZV9mb3JfY3B1KGliZGV2
LCBxZS0+ZG1hLCBsZW4sIERNQV9GUk9NX0RFVklDRSk7Cj4+IMKgwqDCoMKgwqAgLyoKPj4gwqDC
oMKgwqDCoMKgICogQUVOIHJlcXVlc3RzIGFyZSBzcGVjaWFsIGFzIHRoZXkgZG9uJ3QgdGltZSBv
dXQgYW5kIGNhbgo+PgoKLS0gCnpoZW53ZWkgcGkKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
