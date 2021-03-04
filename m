Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309FC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:25:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D664F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D664F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dyKweqEcFGyjO8jsVCXBfAaUnXE2KXj/MSCMjT6PBZ8=; b=JSv0T/iX4A9iPiB/hTFQKVdM0
	A1TcIyt/EQg5kmdw8oaZoywfIBrKWd6uTNJV75zNOkUgVxwrXmn5iUzhBHL9A/hAgF2HVq/SwVkT/
	iqP9RwUPvFDFfFOZRX051QL3hkdSvRQzdwoR4o4v9liQpk7wgaHLMVZA6ogWCsWMX8FDh5/DDMu+A
	4W4hjiWTzv2S/FKGyGSntVf/wq5oBtZ+KcLOx7JIdH6b16gQMWSaRJDJbcXsm0E7hc1dOgE3GkzN2
	npb+rgCkNwkaA9xFY/zpNDT8Jn1i1ULyjiIXAQKtNtqBoT1rXsN07Yc+rJ8b1qrlL6jbmmWQv9eF8
	q5r1KHB2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHn2g-008b80-Ay; Thu, 04 Mar 2021 12:25:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn2P-008b5F-Fw
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:25:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0C3FFAAC5;
 Thu,  4 Mar 2021 12:25:04 +0000 (UTC)
Subject: Re: [PATCH v8 01/16] cgroup: Added cgroup_get_from_id
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-2-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ca2b9250-191b-2023-56fa-e876ff0df7cd@suse.de>
Date: Thu, 4 Mar 2021 13:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-2-git-send-email-muneendra.kumar@broadcom.com>
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBBZGRlZCBhIG5ldyBmdW5jdGlv
biBjZ3JvdXBfZ2V0X2Zyb21faWQgIHRvIHJldHJpZXZlIHRoZSBjZ3JvdXAKPiBhc3NvY2lhdGVk
IHdpdGggY2dyb3VwIGlkLgo+IEV4cG9ydGVkIHRoZSBzYW1lIGFzIHRoaXMgY2FuIGJlIHVzZWQg
YnkgYmxrLWNnb3J1cC5jCj4gCj4gQWRkZWQgZnVuY3Rpb24gZGVjbGFyYXRpb24gb2YgY2dyb3Vw
X2dldF9mcm9tX2lkIGluIGNnb3J1cC5oCj4gCj4gVGhpcyBwYXRjaCBhbHNvIGV4cG9ydGVkIHRo
ZSBmdW5jdGlvbiBjZ3JvdXBfZ2V0X2VfY3NzCj4gYXMgdGhpcyBpcyBnZXR0aW5nIHVzZWQgaW4g
YmxrLWNncm91cC5oCj4gCj4gU2lnbmVkLW9mZi1ieTogTXVuZWVuZHJhIDxtdW5lZW5kcmEua3Vt
YXJAYnJvYWRjb20uY29tPgo+IAo+IC0tLQo+IHY4Ogo+IE5vIGNoYW5nZQo+IAo+IHY3Ogo+IE5v
IGNoYW5nZQo+IAo+IHY2Ogo+IE5vIGNoYW5nZQo+IAo+IHY1Ogo+IHJlbmFtZWQgdGhlIGZ1bmN0
aW9uIGNncm91cF9nZXRfZnJvbV9rZXJuZnNfaWQgdG8KPiBjZ3JvdXBfZ2V0X2Zyb21faWQKPiAK
PiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBFeHBvcnRlZCB0aGUgY2dyb3VwX2dldF9lX2Nz
cwo+IAo+IHYyOgo+IE5ldyBwYXRjaAo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC9jZ3JvdXAuaCB8
ICA2ICsrKysrKwo+ICAga2VybmVsL2Nncm91cC9jZ3JvdXAuYyB8IDI2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykKPiAKUmV2
aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
