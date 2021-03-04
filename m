Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1BBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E43C64EFE
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E43C64EFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZTY3hsvUbR7q/LzNMDhvZRULroqsYulZMAiNITKhxKQ=; b=agw6RjM8nd8Bdzd+O5bvMUSr2
	gb5dwuvgVL7Zy09FP4nx7oVFAegkUOZsbgrWTFcVuhRWi0Os3qRWXAnWkrC8enGwkiOQbx2sITyG+
	zZ/IgiIhgQjY3v3bvZynZSSPXlyGXhE2BF5XzTSjtHRxLXSX2CWRuZs+DMNMewjMWyb0E/Osb52Um
	NCTRBs7dpKqaCzBAqoMKSEYa62PLko7bFI7vzro6HoswYyiFWS7CqbBpH7f4LeumgO4u3cBzwEUz+
	Vo6uly/lMcgEXQP9kIV+9owDO34ZurvNQQEAZq2AnEgrJtsUK17BAq5kPwP0+ZrUsctT77ZtmqKZn
	sJ9yIfZRA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHjXh-0089Yh-DO; Thu, 04 Mar 2021 08:41:09 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHi0n-007zrz-FP
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 07:03:08 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1FB85AC1F;
 Thu,  4 Mar 2021 07:03:05 +0000 (UTC)
Subject: Re: [PATCH 3/3] nvme: allocate the keep alive request using
 BLK_MQ_REQ_NOWAIT
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3fa418ac-e727-710a-bb0f-274038f90579@suse.de>
Date: Thu, 4 Mar 2021 08:03:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303125304.1200789-4-hch@lst.de>
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

T24gMy8zLzIxIDE6NTMgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFRvIGF2b2lkIGFu
IGVycm9yIHJlY292ZXJ5IGRlYWRsb2NrIHdoZXJlIHRoZSBrZWVwIGFsaXZlIHdvcmsgaXMgd2Fp
dGluZwo+IGZvciBhIHJlcXVlc3QgYW5kIHRodXMgY2FuJ3QgYmUgZmx1c2hlZCB0byBtYWtlIHBy
b2dyZXNzIGZvciB0ZWFyaW5nIGRvd24KPiB0aGUgY29udHJvbGxlci4gIEFsc28gcHJpbnQgdGhl
IGVycm9yIGNvZGUgcmV0dXJuZWQgZnJvbQo+IGJsa19tcV9hbGxvY19yZXF1ZXN0IHRvIGhlbHAg
ZGVidWdnaW5nIGFueSBmdXR1cmUgaXNzdWVzIGluIHRoaXMgY29kZS4KPiAKPiBCYXNlZCBvbiBh
biBlYXJsaWVyIHBhdGNoIGZyb20gSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+Lgo+IAo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICAg
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBpbmRleCBiZGViM2Zl
YWU2MTg5OS4uOGE0YTlmZTk2Y2RmODMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4gQEAgLTEyNDEsMTAgKzEy
NDEsMTAgQEAgc3RhdGljIHZvaWQgbnZtZV9rZWVwX2FsaXZlX3dvcmsoc3RydWN0IHdvcmtfc3Ry
dWN0ICp3b3JrKQo+ICAgCX0KPiAgIAo+ICAgCXJxID0gbnZtZV9hbGxvY19yZXF1ZXN0KGN0cmwt
PmFkbWluX3EsICZjdHJsLT5rYV9jbWQsCj4gLQkJCQlCTEtfTVFfUkVRX1JFU0VSVkVEKTsKPiAr
CQkJCUJMS19NUV9SRVFfUkVTRVJWRUQgfCBCTEtfTVFfUkVRX05PV0FJVCk7Cj4gICAJaWYgKElT
X0VSUihycSkpIHsKPiAgIAkJLyogYWxsb2NhdGlvbiBmYWlsdXJlLCByZXNldCB0aGUgY29udHJv
bGxlciAqLwo+IC0JCWRldl9lcnIoY3RybC0+ZGV2aWNlLCAia2VlcC1hbGl2ZSBmYWlsZWRcbiIp
Owo+ICsJCWRldl9lcnIoY3RybC0+ZGV2aWNlLCAia2VlcC1hbGl2ZSBmYWlsZWQ6ICVsZFxuIiwg
UFRSX0VSUihycSkpOwo+ICAgCQludm1lX3Jlc2V0X2N0cmwoY3RybCk7Cj4gICAJCXJldHVybjsK
PiAgIAl9Cj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNo
ZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
