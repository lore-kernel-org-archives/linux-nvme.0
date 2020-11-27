Return-Path: <SRS0=q43r=FB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FB8C2D0E4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 09:13:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D53221F7
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2020 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHBfUOY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D53221F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=t8GMEKjLr7tMHfQeh9jcjh9haHA16HvD0NoR956a/+s=; b=fHBfUOY0wACgiBX8hR6+t/yZb
	NWR54WaML/0zZRWM9uiN6eBGSAuOkH3J4j7X/nhP6dyjDn/LYMZDN2fVpwcc/ZwATmmBa5GKCbs1p
	vOldDANjNMjFB5r49MCVi1LhcBodsUSao9/bIHnh6KMHdr9Q+PV+8GbL3e8Os98KJgkWFkqU7y11+
	j1EzhXyBmLpKODS/IV0k5u3UY0m1dBYtMYbSLccu54JiJ0EMHbjZY3SPwHphjAWqE7q1inkQEytp6
	5tFx3R/fNZ/nXV4NKAmm8ZPnkxVJn9MLQ15SXBcGu4kdpg6g3ZqqnMSkpLSTd3FMuSweW3NHzmIb1
	jytruQOcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiZoG-0005YL-6B; Fri, 27 Nov 2020 09:12:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiZoC-0005S2-H4
 for linux-nvme@lists.infradead.org; Fri, 27 Nov 2020 09:12:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A88ECAC0C;
 Fri, 27 Nov 2020 09:12:48 +0000 (UTC)
Subject: Re: [PATCH v11] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
 <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
 <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
 <3c71869dd01d46ac8c47780ccbfab043@kioxia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b590dcbb-798d-0e69-c8ba-f864dcc7e101@suse.de>
Date: Fri, 27 Nov 2020 10:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <3c71869dd01d46ac8c47780ccbfab043@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201127_041252_813462_220FD053 
X-CRM114-Status: GOOD (  16.95  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "Ewan D. Milne" <emilne@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjYvMjAgMTo1OCBQTSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4+PiBMb29rcyBnb29k
LiBJdCBtaWdodCBiZSBiZXR0ZXIgdG8gYWRkIGZhc3RfaW9fZmFpbF90bW8gdG8KPj4+IG52bWVf
ZGV2X2F0dHJzIHNvIHRoYXQgaXQgY2FuIGJlIHZpZXdlZCBhbmQgbW9kaWZpZWQgZHluYW1pY2Fs
bHkuCj4+Cj4+IEkgdGhvdWdodCBpdCB3YXMgYWRkZWQsIEkgcmVjYWxsIGFza2luZyB0aGlzIGlu
IHRoZSBwYXN0Li4uCj4gCj4gRG8gd2Ugd2FudCBmYXN0X2lvX2ZhaWxfdG1vIHRvIGJlIG9ubHkg
dmlzaWJsZSBvciBtb2RpZmllZCBkeW5hbWljYWxseSB0b28/Cj4gCkknZCByYXRoZXIgYmUgYWJs
ZSB0byBtb2RpZnkgaXQuIEZvciBGQyBhdXRvY29ubmVjdCB3ZSB0eXBpY2FsbHkgcnVuIAp3aXRo
b3V0IGFueSBjb25maWd1cmF0aW9uLCBhbmQgaGVuY2Ugd2UgbmVlZCB0byBiZSBhYmxlIHRvIG1v
ZGlmeSBpdCBvbiAKdGhlIGZseS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
