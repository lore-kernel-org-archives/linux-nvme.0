Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90035C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:36:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6941A23430
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 18:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NoSMPAX/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ikb0+wyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6941A23430
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dZEhGIQXxn4qi/rxEJ1f//ohdfAUI4bs1sRGYB7/Lc0=; b=NoSMPAX/NUYetLNNCeDV2r7dU
	2Tp2fAP+DcineRT2AZuhsnf1B6hfatejnKd/UWjb3DbzrCPZ7fcUqSs17l6dWZ+2+lUL2iYCYcIpJ
	14334uGKIMJdHz8TzZ5bY3HCVBb/5tCEF0CskfB5ZljWS26Cyr6Cw25Ftug3nDImz1uJRu1Sfnoe2
	kUJZ6EsCLzb3zsix2EBA0LYY9V7dl4nhh+Z8UHYcLh5bbak7o3kJYhu3cGlVIPtbK26aRzGtBCGuj
	eJ1jxITAqcxkffuMYYOZEE7rkGBtQLar2c6bN3TwpHMUr/0F1j9/egkb/UYGsm2B6/wW5+s092sPe
	bollNwneg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3llN-0003l6-Ny; Fri, 30 Aug 2019 18:36:45 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i3ll5-0003Yu-II
 for linux-nvme@lists.infradead.org; Fri, 30 Aug 2019 18:36:29 +0000
Received: by mail-pg1-x543.google.com with SMTP id 4so399122pgm.12
 for <linux-nvme@lists.infradead.org>; Fri, 30 Aug 2019 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=zFvchfg+nfsCoDewMw9H5TfKo6aLBXeRTQaXaNc+Pts=;
 b=Ikb0+wyUjuqA7LjN6wXC6fetcE3CYhjhVggxBoUqWIpS3f08zNmc+cwRrqE75xzKUg
 So2TGRiXjGmmNCCWM5iJKYZx51m0qm8+s6IUPUnrY8F33/4rjK144u8SHUjzsgDkiNBI
 D7CNJAba/FabcETkoXXQZ6Tum/wUwrvC8CWe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=zFvchfg+nfsCoDewMw9H5TfKo6aLBXeRTQaXaNc+Pts=;
 b=QyIpGkaZVefOQjkzwAOgy+m7r7nppAU9DQHHpp4CqwtdOpC3ZKzSUtqD56/AX3wium
 goomoxEqk6PbCPpAsrbZeGWhUi77EMMiLFvzOZMfqG0UsjfsMIhu1VAD/Qd7EG3NjE4Y
 tHRqnpQaGDD0FiRy4SINgwZq9sMcFtPSJDgMd6bxyC7j04/XNeU/zpQYRiaBiEYIgZXs
 GwgbVDLH7Qekd+l4C0GGMqm/wCN3SJbgYI/bF6qz8RdWPxzxtuggGscFH8yKgCpgapk1
 LK9kMOJ0nM/CKd3KeQILFByNpNwNn1nD/6TKNvYqFy0tZfXKBdn98/UMC0zR1tMaUDxY
 /RxA==
X-Gm-Message-State: APjAAAVhaxmUbXHRygcsiUSvilca5gxudYCh1zUlZtYRDGBJwBzt/DZ3
 KEeaf+mw8hxlcLk314t6jY0HbA==
X-Google-Smtp-Source: APXvYqz7wDu3v2tbCoIivOmmuJtFFKphufCRZ2DZv86SqQDUSFVc6anUX0NIHVQafi2EOjbtvdkhtA==
X-Received: by 2002:aa7:8a98:: with SMTP id a24mr16690672pfc.101.1567190187123; 
 Fri, 30 Aug 2019 11:36:27 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l7sm6635079pff.35.2019.08.30.11.36.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Aug 2019 11:36:26 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me> <20190822002328.GP9511@lst.de>
 <205d06ab-fedc-739d-323f-b358aff2cbfe@grimberg.me>
 <e4603511-6dae-e26d-12a9-e9fa727a8d03@grimberg.me>
 <20190826065639.GA11036@lst.de> <20190826075916.GA30396@kroah.com>
 <ac168168-fed2-2b57-493e-e88261ead73b@grimberg.me>
 <20190830055514.GC8492@lst.de>
 <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <3c58613f-9380-6887-434a-0db31136e7aa@broadcom.com>
Date: Fri, 30 Aug 2019 11:36:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4555a281-3cbc-0890-ce85-385c06ca912b@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190830_113627_859739_9049D70C 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8zMC8yMDE5IDExOjA4IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Cj4+Pj4gWWVzIHdl
IGRvLCB1c2Vyc3BhY2Ugc2hvdWxkIHVzZSBpdCB0byBvcmRlciBldmVudHMuwqAgRG9lcyB1ZGV2
IG5vdAo+Pj4+IGhhbmRsZSB0aGF0IHByb3Blcmx5IHRvZGF5Pwo+Pj4KPj4+IFRoZSBwcm9ibGVt
IGlzIG5vdCBvcmRlcmluZyBvZiBldmVudHMsIGl0cyByZWFsbHkgYWJvdXQgdGhlIGZhY3QgdGhh
dAo+Pj4gdGhlIGNoYXJkZXYgY2FuIGJlIHJlbW92ZWQgYW5kIHJlYWxsb2NhdGVkIGZvciBhIGRp
ZmZlcmVudCBjb250cm9sbGVyCj4+PiAoY291bGQgYmUgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBk
aXNjb3ZlcnkgY29udHJvbGxlcikgYnkgdGhlIHRpbWUKPj4+IHRoYXQgdXNlcnNwYWNlIGhhbmRs
ZXMgdGhlIGV2ZW50Lgo+Pgo+PiBUaGUgc2FtZSBpcyBnZW5lcmFsbHkgdHJ1ZSBmb3IgbG90IG9m
IGtlcm5lbCBkZXZpY2VzLsKgIFdlIGNvdWxkIHJlZHVjZQo+PiB0aGUgY2hhbmNlIGJ5IHVzaW5n
IHRoZSBpZHIgY3ljbGljIGFsbG9jYXRvci4KPgo+IFdlbGwsIGl0IHdhcyByYWlzZWQgYnkgSGFu
bmVzIGFuZCBKYW1lcywgc28gSSdsbCBhc2sgdGhlbSByZXNwb25kIGhlcmUKPiBiZWNhdXNlIEkg
ZG9uJ3QgbWluZCBoYXZpbmcgaXQgdGhpcyB3YXkuIEkgcGVyc29uYWxseSB0aGluayB0aGF0IHRo
aXMKPiBpcyBhIGJldHRlciBhcHByb2FjaCB0aGFuIGhhdmluZyBhIGN5Y2xpYyBpZHIgYWxsb2Nh
dG9yLiBJbiBnZW5lcmFsLCBJCj4gZG9uJ3QgbmVjZXNzYXJpbHkgdGhpbmsgdGhhdCB0aGlzIGlz
IGEgZ29vZCBpZGVhIHRvIGhhdmUgY3ljbGljCj4gY29udHJvbGxlciBlbnVtZXJhdGlvbnMgaWYg
d2UgZG9uJ3QgYWJzb2x1dGVseSBoYXZlIHRvLi4uCgpXZSBoaXQgaXQgcmlnaHQgYW5kIGxlZnQg
d2l0aG91dCB0aGUgY3ljbGljIGFsbG9jYXRvciwgYnV0IHRoYXQgd29uJ3QgCm5lY2Vzc2FyaWx5
IHJlbW92ZSBpdC4KClBlcmhhcHMgd2Ugc2hvdWxkIGhhdmUgaGFkIGEgdW5pcXVlIHRva2VuIGFz
c2lnbmVkIHRvIHRoZSBjb250cm9sbGVyLCAKYW5kIGhhdmUgdGhlIGV2ZW50IHBhc3MgdGhlIG5h
bWUgYW5kIHRoZSB0b2tlbi7CoCBUaGUgY2xpIHdvdWxkIHRoZW4sIGlmIAp0aGUgdG9rZW4gaXMg
cHJlc2VudCwgdmFsaWRhdGUgaXQgdmlhIGFuIGlvY3RsIGJlZm9yZSBwcm9jZWVkaW5nIHdpdGgg
Cm90aGVyIGlvY3Rscy4KCldoZXJlIGFsbCB0aGUgY29ubmVjdGlvbiBhcmd1bWVudHMgd2VyZSBh
ZGRlZCB3ZSBkdWUgdG8gdGhlIHJldXNlIGlzc3VlIAphbmQgdGhlbiBzb2x2aW5nIHRoZSBxdWVz
dGlvbiBvZiBob3cgdG8gdmVyaWZ5IGFuZC9vciBsb29rdXAgdGhlIGRlc2lyZWQgCmNvbnRyb2xs
ZXIsIGJ5IHVzaW5nIHRoZSBzaG90Z3VuIGFwcHJvYWNoIHJhdGhlciB0aGFuIGJlaW5nIHZlcnkg
CnBvaW50ZWQsIHdoaWNoIGlzIHdoYXQgdGhlIG5hbWUvdG9rZW4gd291bGQgZG8uCgotLSBqYW1l
cwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
