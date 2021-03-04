Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7B5C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:30:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D2F64F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D2F64F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XnHNhvHQcNupXR6qUudUNPlYfvrS+bSKP7DDIgmlmFo=; b=Xf+IUql0xEmXNQ889yMWgZexn
	ge3zt9Tj06gOnYAB/bts/sD0RhOhNfJc3BmOgb03LApwvr46m1Cc/02jiNgYYSIDlDI4maovsQriX
	MswaRnIOlISUachwX/MiGwrgH9mQWjg0rNZZv+yYdzQZMwUou0rAtbR71bBPLdqBIM8M+UFVwtTMd
	3WY7TOLbXpK1/luYxgJ7TsjZT0kVZzugvV2NDcQdii6J/GCH4O+D1LgtxB81H9QsaUV3fCz7M09tw
	YrVWH1uegDtxtEtfu8GmVFLU47r8lVbobCLCGqnhc8nUT0lXzjhYwCR/KuItWKupC/3a4GNmyr8hR
	zuRWbJwtA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn7r-008cDP-4Q; Thu, 04 Mar 2021 12:30:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn56-008bho-AW
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:27:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CA48CAE42;
 Thu,  4 Mar 2021 12:27:51 +0000 (UTC)
Subject: Re: [PATCH v8 03/16] nvme: Added a newsysfs attribute appid_store
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-4-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <86e604e5-3dc9-4a6b-a34d-6a91cdfc5d0a@suse.de>
Date: Thu, 4 Mar 2021 13:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-4-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBBZGRlZCBhIG5ldyBzeXNmcyBh
dHRyaWJ1dGUgYXBwaWRfc3RvcmUgdW5kZXIKPiAvc3lzL2NsYXNzL2ZjL2ZjX3VkZXZfZGV2aWNl
LyoKPiAKPiBXaXRoIHRoaXMgbmV3IGludGVyZmFjZSB0aGUgdXNlciBjYW4gc2V0IHRoZSBhcHBs
aWNhdGlvbiBpZGVudGZpZXIKPiBpbiAgdGhlIGJsa2NnIGFzc29jaXRlZCB3aXRoIGNncm91cCBp
ZC4KPiAKPiBPbmNlIHRoZSBhcHBsaWNhdGlvbiBpZGVudGlmZXIgaGFzIHNldCB3aXRoIHRoaXMg
aW50ZXJmYWNlIGl0IGFsbG93cwo+IGlkZW50aWZpY2F0aW9uIG9mIHRyYWZmaWMgc291cmNlcyBh
dCBhbiBpbmRpdmlkdWFsIGNncm91cCBiYXNlZAo+IEFwcGxpY2F0aW9ucyAoZXg6dmlydHVhbCBt
YWNoaW5lIChWTSkpbGV2ZWwgaW4gYm90aCBob3N0IGFuZAo+IGZhYnJpYyBpbmZyYXN0cnVjdHVy
ZShGQykuCj4gCj4gQmVsb3cgaXMgdGhlIGludGVyZmFjZSBwcm92aWRlZCB0byBzZXQgdGhlIGFw
cF9pZAo+IAo+IGVjaG8gIjxjZ3JvdXBpZD46PGFwcGlkPiIgPj4gL3N5cy9jbGFzcy9mYy9mY191
ZGV2X2RldmljZS9hcHBpZF9zdG9yZQo+IGVjaG8gIjQ1N0U6MTAwMDAwMTA5YjUyMWQyNyIgPj4g
L3N5cy9jbGFzcy9mYy9mY191ZGV2X2RldmljZS9hcHBpZF9zdG9yZQo+IAo+IFNpZ25lZC1vZmYt
Ynk6IE11bmVlbmRyYSA8bXVuZWVuZHJhLmt1bWFyQGJyb2FkY29tLmNvbT4KPiAKPiAtLS0KPiB2
ODoKPiBObyBjaGFuZ2UKPiAKPiB2NzoKPiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBObyBjaGFuZ2UK
PiAKPiB2NToKPiBSZXBsYWNlZCBBUFBJRF9MRU4gd2l0aCBGQ19BUFBJRF9MRU4KPiAKPiB2NDoK
PiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBSZXBsYWNlZCBibGtjZ19zZXRfYXBwX2lkZW50aWZpZXIg
ZnVuY3Rpb24gd2l0aCBibGtjZ19zZXRfZmNfYXBwaWQKPiAKPiB2MjoKPiBOZXcgUGF0Y2gKPiAt
LS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAg
ICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
