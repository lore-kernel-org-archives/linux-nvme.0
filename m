Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0289CC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D098610CC
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D098610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hlRnH+EWbXWPwSV+5Vad9tIV2Ks4mWWNIt28yrgBvkg=; b=dhoIG7WfEh26XAVP8BUJK9tes
	Gfc6VF30/kQCMNKjieNIwBCnUlBLIcmyjHpo/AFQDwf7gc1yOqhhnk6Iw3jXY5i50WhRR2S3Wm4Wc
	UWuVbuZKeu1IvmU6ZApoNso9Sr0Snsqhdhp5A4ewSvyUTpI6j4eAw+q6gIJ1oEAdQNAHaDRRhyYRd
	EO3dJ1+COmj2fJmnv2rF5Ebx4bULI3ZFAGyriQH+gKaKGG0Iy/sigG9ezgp/nSmvmhlrYBKfOg+3m
	CGCvxRgc83vnDQAD0T0I1stk54wkESmCPXyeOif4PnrTDtG8hlv4oZ3+zLIBOK3efPS785xnpAXz+
	osVG+EApg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQ7r-007LZF-KM; Thu, 08 Apr 2021 08:34:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQ7m-007LXO-29
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:34:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D8D7B01E;
 Thu,  8 Apr 2021 08:34:49 +0000 (UTC)
Subject: Re: [PATCH v9 01/13] cgroup: Added cgroup_get_from_id
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-2-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2e6ceb94-0620-2097-35de-57d8bf3a9f20@suse.de>
Date: Thu, 8 Apr 2021 10:26:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-2-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_093450_310391_1277CA21 
X-CRM114-Status: GOOD (  16.42  )
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

T24gNC83LzIxIDE6MDYgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBBZGRlZCBhIG5ldyBmdW5jdGlv
biBjZ3JvdXBfZ2V0X2Zyb21faWQgIHRvIHJldHJpZXZlIHRoZSBjZ3JvdXAKPiBhc3NvY2lhdGVk
IHdpdGggY2dyb3VwIGlkLgo+IEV4cG9ydGVkIHRoZSBzYW1lIGFzIHRoaXMgY2FuIGJlIHVzZWQg
YnkgYmxrLWNnb3J1cC5jCj4gCj4gQWRkZWQgZnVuY3Rpb24gZGVjbGFyYXRpb24gb2YgY2dyb3Vw
X2dldF9mcm9tX2lkIGluIGNnb3J1cC5oCj4gCj4gVGhpcyBwYXRjaCBhbHNvIGV4cG9ydGVkIHRo
ZSBmdW5jdGlvbiBjZ3JvdXBfZ2V0X2VfY3NzCj4gYXMgdGhpcyBpcyBnZXR0aW5nIHVzZWQgaW4g
YmxrLWNncm91cC5oCj4gCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE11bmVlbmRyYSA8bXVuZWVuZHJhLmt1bWFyQGJyb2Fk
Y29tLmNvbT4KPiAKPiAtLS0KPiB2OToKPiBBZGRyZXNzZWQgdGhlIGlzc3VlcyByZXBvcnRlZCBi
eSBrZXJuZWwgdGVzdCByb2JvdAo+IAo+IHY4Ogo+IE5vIGNoYW5nZQo+IAo+IHY3Ogo+IE5vIGNo
YW5nZQo+IAo+IHY2Ogo+IE5vIGNoYW5nZQo+IAo+IHY1Ogo+IHJlbmFtZWQgdGhlIGZ1bmN0aW9u
IGNncm91cF9nZXRfZnJvbV9rZXJuZnNfaWQgdG8KPiBjZ3JvdXBfZ2V0X2Zyb21faWQKPiAKPiB2
NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBFeHBvcnRlZCB0aGUgY2dyb3VwX2dldF9lX2Nzcwo+
IAo+IHYyOgo+IE5ldyBwYXRjaAo+IC0tLQo+ICAgaW5jbHVkZS9saW51eC9jZ3JvdXAuaCB8ICA2
ICsrKysrKwo+ICAga2VybmVsL2Nncm91cC9jZ3JvdXAuYyB8IDI2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykKPiBSZXZpZXdl
ZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
