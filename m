Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1A3C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:29:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B532255F
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B532255F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TBbO/mXEqDON92eWBEIzyJwlVSLOMjyO6mWfFefxBaI=; b=G+8/Ply4AV3jt4Sxt86dOD5lR
	M3kC6Hy3qJv/FjMuiJ7yfjYChduqkkkNzCAZbsQ2aWXSyE+pgp3XVv/dDAw4KYLchcRQx/hqv3ymm
	T5xoapr4Kd3hK5KRW0UUn3G2O7Zz+rmGuePczP+HMtVlbtu/P/4026T5T+aj9wNNPVWFkJoiq6NUC
	Wed0GxElP1a8GruPVJdZkKU0U8KsPrF4aGoUyeV53IuWvRei3cq229BALdH4nA+QqeGXCuIrdBlJj
	eWtlOgvSLM0VhEbfULALJAzm3v/ZiEzuXeUMcYWRMFGU2V2gLeStSf8TlPaK/lK+BV6hZX0hm0Mjr
	ah4SrSOYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrdj-0004gI-LC; Mon, 11 Jan 2021 07:29:23 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyrdg-0004fA-9I
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:29:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 015F6AB3E;
 Mon, 11 Jan 2021 07:29:19 +0000 (UTC)
Subject: Re: [PATCH v7 01/16] cgroup: Added cgroup_get_from_id
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-2-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0a1453c2-9f8a-0818-1678-78e1775a773b@suse.de>
Date: Mon, 11 Jan 2021 08:29:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-2-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_022920_472626_18DB1210 
X-CRM114-Status: GOOD (  21.21  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gQWRkZWQgYSBuZXcgZnVuY3Rp
b24gY2dyb3VwX2dldF9mcm9tX2lkICB0byByZXRyaWV2ZSB0aGUgY2dyb3VwCj4gYXNzb2NpYXRl
ZCB3aXRoIGNncm91cCBpZC4KPiBFeHBvcnRlZCB0aGUgc2FtZSBhcyB0aGlzIGNhbiBiZSB1c2Vk
IGJ5IGJsay1jZ29ydXAuYwo+IAo+IEFkZGVkIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIG9mIGNncm91
cF9nZXRfZnJvbV9pZCBpbiBjZ29ydXAuaAo+IAo+IFRoaXMgcGF0Y2ggYWxzbyBleHBvcnRlZCB0
aGUgZnVuY3Rpb24gY2dyb3VwX2dldF9lX2Nzcwo+IGFzIHRoaXMgaXMgZ2V0dGluZyB1c2VkIGlu
IGJsay1jZ3JvdXAuaAo+IAo+IFNpZ25lZC1vZmYtYnk6IE11bmVlbmRyYSA8bXVuZWVuZHJhLmt1
bWFyQGJyb2FkY29tLmNvbT4KPiAKPiAtLS0KPiB2NzoKPiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBO
byBjaGFuZ2UKPiAKPiB2NToKPiByZW5hbWVkIHRoZSBmdW5jdGlvbiBjZ3JvdXBfZ2V0X2Zyb21f
a2VybmZzX2lkIHRvCj4gY2dyb3VwX2dldF9mcm9tX2lkCj4gCj4gdjQ6Cj4gTm8gY2hhbmdlCj4g
Cj4gdjM6Cj4gRXhwb3J0ZWQgdGhlIGNncm91cF9nZXRfZV9jc3MKPiAKPiB2MjoKPiBOZXcgcGF0
Y2gKPiAtLS0KPiAgIGluY2x1ZGUvbGludXgvY2dyb3VwLmggfCAgNiArKysrKysKPiAgIGtlcm5l
bC9jZ3JvdXAvY2dyb3VwLmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
