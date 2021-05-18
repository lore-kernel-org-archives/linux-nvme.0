Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A6AC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:10:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7947E611EE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7947E611EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r8d6y5A4qEgUtaxIIauOMXx9KxB+V+Sx0GctCs6K0YA=; b=Kl2oEiSY5sJbSdMCzfr1xhYxZ
	UI3STsjerI0eICuJOsWyn1thMHFx71UTiAMNueubM3EiETPTGHmDMLyfs9501os4IH2oDfO8PJdoU
	UvNWUjJ5zmdOQydPPz1f+y/+DtW+6Rluo41Lk+DpxuwuI/OOR9NAyF+lE/X8LuUsru12GESQp4YGK
	7k1c0B50ibqr713jjbLmDJVrwfi4X2/nGOHZgXiXBidErzDSotx88HzyC95XxfHWOVJraUcL+yRZZ
	qrt4CnxCOhbTDIpdor6V6XB6BSpmyxPOfJl/M3fNetlJgkbQ/Sc6Uhs65/MSKnTlXalMzw8rDcYVl
	NHXvzdXOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj4AM-001ZG8-CW; Tue, 18 May 2021 18:10:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4AE-001ZEv-PM
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 18:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=R8Vbgn7v81Fn/UXX1E4+CrNe6MMVzj4L68eDBoPJ70s=; b=CPLhbvzbMe4DK8puu3/iIjgXtQ
 DjILVYpQY+qa+ptNra4NbyROlXDi785gacZ5WxE0EhqJlGTisaChqMaIJGCjlqPQBTAN+EXzSJbu6
 +MXCKdfucIm/ftWjZV66nmZR7IDn3aeOz2Ceqa2Xxx54R1he/18NY6F42MNs/K/403ssykz7whISS
 /qn+DXzpjQMrMTM8H9jstkAlx/6QI+fNDiqfZSG6GghnZvvuTQCb8okqhPt8nK5wdkf/Tu5MzhAur
 XsKwtQwCSNgKRiXvMEcxHCJtZ+aAbSUcl8UrPwnNUE5qGUW3lac+GAbUJpPYRAmKN12BoRvAh+9FK
 3jPbN4tg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj4AB-00Ers8-KB
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 18:09:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5584AB23C;
 Tue, 18 May 2021 18:09:47 +0000 (UTC)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
 <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <b7f6c507-d2a4-4231-737e-04e1c8a3df9e@suse.de>
Date: Tue, 18 May 2021 20:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_110951_845064_39BE2EF8 
X-CRM114-Status: GOOD (  12.76  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xOC8yMSA4OjAwIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+IGIvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPj4+PiBpbmRleCAwNTUxNzk2NTE3ZTYuLmVjYzk5YmQ1ZjhhZCAxMDA2
NDQKPj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+Pj4gQEAgLTEwMCw4ICsxMDAsMTEgQEAgdm9p
ZCBudm1lX2tpY2tfcmVxdWV1ZV9saXN0cyhzdHJ1Y3QgbnZtZV9jdHJsCj4+Pj4gKmN0cmwpCj4+
Pj4gwqDCoMKgwqDCoCBkb3duX3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+Pj4+IMKg
wqDCoMKgwqAgbGlzdF9mb3JfZWFjaF9lbnRyeShucywgJmN0cmwtPm5hbWVzcGFjZXMsIGxpc3Qp
IHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5oZWFkLT5kaXNrKQo+Pj4+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGtibG9ja2Rfc2NoZWR1bGVfd29yaygmbnMtPmhlYWQtPnJlcXVldWVf
d29yayk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghbnMtPmhlYWQtPmRpc2spCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGtibG9j
a2Rfc2NoZWR1bGVfd29yaygmbnMtPmhlYWQtPnJlcXVldWVfd29yayk7Cj4+Pj4gK8KgwqDCoMKg
wqDCoMKgIGlmIChjdHJsLT5zdGF0ZSA9PSBOVk1FX0NUUkxfTElWRSkKPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkaXNrX3VldmVudChucy0+aGVhZC0+ZGlzaywgS09CSl9DSEFOR0UpOwo+
Pj4+IMKgwqDCoMKgwqAgfQo+Pj4KPj4+IEkgYXNrZWQgdGhpcyBvbiB2MSwgaXMgdGhpcyBvbmx5
IG5lZWRlZCBmb3IgbXBhdGggZGV2aWNlcz8KPj4KPj4gWWVzOyB3ZSBuZWVkIHRvIHNlbmQgdGhl
IEtPQkpfQ0hBTkdFIGV2ZW50IG9uIHRoZSBtcGF0aCBkZXZpY2UgYXMgaXQncwo+PiBub3QgYmFj
a2VkIGJ5IGhhcmR3YXJlLiBUaGUgb25seSBub24tbXVsdGlwYXRoZWQgZGV2aWNlcyBJJ3ZlIHNl
ZW4gc28KPj4gZmFyIGFyZSBQQ0kgZGV2aWNlcyB3aGVyZSBldmVudHMgYXJlIGdlbmVyYXRlZCBi
eSB0aGUgUENJIGRldmljZSBpdHNlbGYuCj4gCj4gQW5kIGZvciBmYWJyaWNzPwoKTm8gZXZlbnRz
IHdoYXRzb2V2ZXIuCkhlbmNlIHRoaXMgcGF0Y2guCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3Vz
ZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIs
IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=
