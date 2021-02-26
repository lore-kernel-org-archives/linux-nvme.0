Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87077C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:00:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12B5064DBD
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 07:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B5064DBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8XSPhEvWREE9tAMEAjv4kkFbosXVXwvbS1Fy19FLNks=; b=s5sIkSG7QpnKaqStrUowX5UV4
	Qdkjw7ijmMPB3/x5/owgsRLH35oWIdG0fFwPJtt4W9aV1xypCFF5bBlAra2Tp6RTUVlbO7Zw2k5SH
	7XuxfnjfiSWjt13B05g3XKQ6UFiaZ/WD6KJXcQl9zgJRB8bquFcBrJJISX11qGu9/tcfOT47p13gv
	07e4xu+N+y8sndoHnEHD4v064QNtfo60vfmwdZLcY0qHxWcl6MnFBwNGWxKtkmJo+MjvwXyHh3dY2
	KhYgnnTHGWEtAQGNMFItOKPGKC7vO7Ooovb+Ewn7l2i1Zdw9z5vsfXEgidECCqu1OVJISl3LSsGnw
	D9sptjDbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFX6l-0003vO-PV; Fri, 26 Feb 2021 07:00:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFX6i-0003uq-SG
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 07:00:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 47A87AAAE;
 Fri, 26 Feb 2021 07:00:10 +0000 (UTC)
Subject: Re: [PATCH 5/6] nvme: return NVME_SC_ABORT_QUEUE for cancelled
 commands
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-6-hare@suse.de>
 <fd89fa3f-0c25-1cd0-a47d-06fca59469b7@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <94ba840f-afc4-0e88-db79-1f7b29baaba7@suse.de>
Date: Fri, 26 Feb 2021 08:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <fd89fa3f-0c25-1cd0-a47d-06fca59469b7@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_020013_029502_2CF261D2 
X-CRM114-Status: GOOD (  21.54  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNi8yMSAxOjU5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS8yLzI1
IDE4OjU1LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEEgcmVxdWVzdCB3aWxsIGJlIGNhbmNl
bGxlZCB3aGVuIGEgcXVldWUgaXMgZGVsZXRlZCwgc28gd2Ugc2hvdWxkCj4+IGJlIHJldHVybmlu
ZyBhIHN0YXR1cyBvZiBOVk1FX1NDX0FCT1JUX1FVRVVFLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYyB8IDIgKy0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvZmMuY8KgwqAgfCA5ICsr
KysrKy0tLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCAwNGRjODVlMDgxMGMuLjYyNDUzMWE2YjdjNiAx
MDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtMzc5LDcgKzM3OSw3IEBAIGJvb2wgbnZtZV9jYW5jZWxf
cmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCB2b2lkIAo+PiAqZGF0YSwgYm9vbCByZXNlcnZl
ZCkKPj4gwqDCoMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3RfY29tcGxldGVkKHJlcSkpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsKPj4gLcKgwqDCoCBudm1lX3JlcShyZXEpLT5z
dGF0dXMgPSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ7Cj4+ICvCoMKgwqAgbnZtZV9yZXEocmVx
KS0+c3RhdHVzID0gTlZNRV9TQ19BQk9SVF9RVUVVRTsKPiBVc2UgTlZNRV9TQ19BQk9SVF9RVUVV
RSBpbnN0ZWFkIG9mIE5WTUVfU0NfSE9TVF9BQk9SVEVEX0NNRCBpcyBub3QgYSAKPiBnb29kIGlk
ZWEuCj4gTlZNRV9TQ19IT1NUX0FCT1JURURfQ01EIGlzIGEgaG9zdCBwYXRoIHJlbGF0ZWQgZXJy
b3IsIE5vdyB1c2VkIHRvIGNoZWNrIAo+IGlmIG5lZWQgZmFpbCBvdmVyIHJldHJ5IGJ5IG11bHRp
cGF0aC4KCllvdSBhcmUgY29ycmVjdDsgdGhpcyBwYXRjaCB3aWxsIGJlIGRyb3BwZWQgZm9yIHRo
ZSBuZXh0IGl0ZXJhdGlvbi4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
