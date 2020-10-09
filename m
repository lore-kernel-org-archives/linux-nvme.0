Return-Path: <SRS0=D38N=DQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2379AC43457
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 13:57:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A20222B9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2020 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kaknm9LV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A20222B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wcRhUZwCPRCdqSY4PmO42U2SCkHg1HhApdMbXqSR9FA=; b=Kaknm9LVKCpRge3T9Eg4E2gF8
	O9dvMFoTHIZF2zVwJYxKRZN2puxMnrzjdpZ98tlAqndIsv008dS0iJhG84EsyYVw8DMLegwuPA2Ut
	M6SOB7ToiznVwkwV4NKjkJV0foR9TUujK/YESYS2PsRAj2J3JrelP36CUYNHhvIeF2wiOz+LFgXKU
	B22lpJ4pWRo+7Fxh5Uh1uyT6JkhyiUe0S3s0W/XO2GxzgNddeLJ1QlHxF+XkCwy6m0/6NU770XLdI
	bi17H7CPMVCSqm0dWlm5cVcoq+L2FF+wJwLcPnTh8jMfLmnOzqj1pd/Z0W6iOExwyqCabLeRzVRPZ
	k/IUMHzfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQstW-0006SC-Di; Fri, 09 Oct 2020 13:57:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQstU-0006Qi-9c
 for linux-nvme@lists.infradead.org; Fri, 09 Oct 2020 13:57:13 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 007CFACF5
 for <linux-nvme@lists.infradead.org>; Fri,  9 Oct 2020 13:57:09 +0000 (UTC)
Subject: Re: [PATCH 3/7] nvme-fcloop: use IDA for port ids
To: linux-nvme@lists.infradead.org
References: <20200922121501.32851-1-hare@suse.de>
 <20200922121501.32851-4-hare@suse.de>
 <d0a614ff-c8b5-22fd-07f9-712a0259d760@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <38dcf65b-d05d-24f5-8fce-cc4739af3a8e@suse.de>
Date: Fri, 9 Oct 2020 15:57:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d0a614ff-c8b5-22fd-07f9-712a0259d760@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201009_095712_451707_49CC042A 
X-CRM114-Status: GOOD (  21.82  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNS8yMCA3OjMzIFBNLCBKYW1lcyBTbWFydCB3cm90ZToKPiBPbiA5LzIyLzIwMjAgNTox
NCBBTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBVc2UgYW4gSURBIHRvIHJlZ2lzdGVyIHBv
cnQgSURzIHRvIGF2b2lkIGR1cGxpY2F0ZSBwb3J0IElEcy4gSXQKPj4gYWxzbyB3aWxsIGdlbmVy
YXRlIGEgdW5pcXVlIHBvcnQgSUQgaWYgbm9uZSBpcyBzcGVjaWZpZWQuCj4gCj4gSSdkIHByZWZl
ciBhIGxpdHRsZSBtb3JlIGRlc2NyaXB0aW9uIGFzIEkgZGlkbid0IHBpY2sgdXAgd2hhdCB0aGlz
IAo+IGFjdHVhbGx5IGRpZCBmcm9tIHRoZSBjb21tZW50LsKgIE1lYW5pbmc6IEFkZCBhdXRvLWFk
ZHJlc3MgYXNzaWdubWVudCBpZiAKPiBvbmUgaXNuJ3Qgc3BlY2lmaWVkLiBVc2UgYW4gaWRhIGZv
ciBhbGxvY2F0aW9uIGZvciB1bmlxdWVuZXNzLiBVc2UgCj4gdXNlci1zdXBwbGllZCBhZGRyZXNz
ZXMgYXMgbG9uZyBhcyBub3QgaW4gdXNlIGFuZCB3aXRoaW4gcmFuZ2Ugc3VwcG9ydGVkIAo+IGZv
ciBpZGEuCj4gCgpPay4KCj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9udm1lL3RhcmdldC9mY2xvb3AuYyB8IDUxIAo+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+PiDCoCAxIGZp
bGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZmNsb29wLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0
L2ZjbG9vcC5jCj4+IGluZGV4IDA4MmFhNGRlZTQwNi4uZTU2ZjMyM2ZhN2Q0IDEwMDY0NAo+PiAt
LS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2ZjbG9vcC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90
YXJnZXQvZmNsb29wLmMKPj4gQEAgLTEyLDYgKzEyLDcgQEAKPj4gwqAgI2luY2x1ZGUgPGxpbnV4
L252bWUtZmMtZHJpdmVyLmg+Cj4+IMKgICNpbmNsdWRlIDxsaW51eC9udm1lLWZjLmg+Cj4+ICsj
ZGVmaW5lIEZDTE9PUF9NQVhfQUxfUEEgMHhFRgo+IAo+IFRoaXMgaXMgb2RkIC0gbm8gcmVhc29u
IHRvIGJyaW5nIGluIEFMUEEncyBhbmQgYXJiIGxvb3AuwqDCoCBQbGVhc2UgcmVuYW1lIAo+IGl0
IHRvIHN0YXRlIGl0J3MgdGhlIG1heCBhZGRyZXNzIHZhbHVlIGFsbG93ZWQuwqAgSSdkIHByZWZl
ciBpZiB0aGlzIHdhcyAKPiBhIDI0IGJpdCB2YWx1ZSwgYnV0IHRoYXQgd29uJ3QgbWF0dGVyIG11
Y2ggYW5kIDI1NSBpcyBmaW5lLgo+IApIZWhlOyB5ZWFoLCBwdWxsaW5nIGluIEFMUEEgZXRjIGlz
IHByb2JhYmx5IG5vdCBuZWNlc3NhcnkuCkJ1dCBJIHdhbnRlZCB0byByZXN0cmljdCB0aGluZ3Mg
dG8gbGVzcyB0aGFuIDI1NSB0byBnZXQgYWxpZ25tZW50IHdpdGggCnJlYWwgUHRQIFBvcnQgSURz
LgoKSSdsbCBiZSByZXNlbmRpbmcgdGhlIHBhdGNoc2V0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUz
IDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVs
aXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
