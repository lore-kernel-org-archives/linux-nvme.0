Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B1CC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:25:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F64207D8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XLOhe8Gg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mOqFNUsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F64207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DSxvsyXLIL5F+MCGrDZO5x1vMsjKQwwmJdZfHgsjPos=; b=XLOhe8GgObn/yeGCDkxnPy9ks
	SsBxopah1u+NN/wMuPwXzE+1DcFTee+Vco2KkshHabbVpsoD62u/+IWFx8eZfqv8tU9eBO1L0mFXw
	dnNco0eGmFV3h7rlkAcvp3Yd7ub9s6QnjIsAAsn9o0Oe5DQoVu5eMDkwY7xLmt9wHg/zgKMHxEwdj
	S2Gbk9w8hFH3JGuhYnioBJwiydRlsRbJw0zETtbfyQ8Pkur6Fs71bDM/O4G9QLMoKuuiUeCaGNXKa
	esD28u4iL+rdZHAW7pR6avd+XtKgrSg8yQWaHvaMxhSMlo32WSJQNzqThIj7sLA/5Gg0T9NMhwigh
	3bi5iJFZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonPi-0004t3-VQ; Fri, 26 Jun 2020 12:25:03 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jon54-00032o-An
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 12:03:44 +0000
Received: by mail-ed1-x541.google.com with SMTP id d15so6694851edm.10
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fGJN00+oSs5u74cinEnWXytzJqtOzHTgYYmqXopZTb8=;
 b=mOqFNUsyhTWNshKxsHdT4zr3toXZGKzfZVlq8LeuRbD1PLu52ZWTAptL85XBbNSnaL
 WBafXfN8pWShB9WJ0heViTx9XVTsEGQCcw11pY1cKusCgoFh3TS+qbaLSj6VroktC7FC
 iTd8RDRcx20GoaL764vMekZkVlJPQOT25r2aAwSgPZLq1wvQmNCCRL1HPjJFNfnrbvx1
 CyOx6K33PZI/+ro3kwudu0HSw9jW5vDEfEOsBhnK1cZJ/549w6ZsWxAdw7uaZK53U/C/
 Br7W5n4QkTEBiL4qKvvOHgnnBS4yJEhYRT+z2i348mGf3DO9+6tv0zDmUHRawGNZOlZt
 bWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fGJN00+oSs5u74cinEnWXytzJqtOzHTgYYmqXopZTb8=;
 b=XsJOpZ/8WHDl5hKujkfT22pHRe4DZWmBbpVT/6fJO0iawkg0YBc86ch/rFafcKEInq
 e3Ksj5e/rDueLFZeZpg79A7UPz1X8Ji/QFY7PGgO9prZ4bfTJfnDaIJNvVdApv2C7vhO
 W1EZMg51wVMf+w/R1won/BAfAVVXzO4iIA5Aanh26j3Bt3z4bQRL54Th52f9h3UYsfKg
 z+CzJ2IhUZ8WlSQx0qZW+sDEdfcm5iNzWB2jeNy2A4vIAwbziMSWuD+9fIcVbfrGKlYk
 Muh5LQO6ZmrCOXdG7OFQogMbC+cn7g235lgFnxL9Cl5BcRuJ4LMAAHN3fMGvtyJm3DPm
 SVnw==
X-Gm-Message-State: AOAM533Aub8fjPVtQRROzTb550ef8B2u36PeH8EfrLklLrHdM/Rma300
 lr1vRHxPJBc8Pt31wlD6xL7RhNLMO7k=
X-Google-Smtp-Source: ABdhPJyGscUstxDAe5xUnqJJ/piEgiYlLdTbyUbPNQMyRWwv4oQGF9SY3WdjZuKlHYHup47cypauoQ==
X-Received: by 2002:a05:6402:22f0:: with SMTP id
 dn16mr28524979edb.83.1593114814126; 
 Thu, 25 Jun 2020 12:53:34 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id lj18sm9744723ejb.43.2020.06.25.12.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 12:53:33 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
 <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
Date: Thu, 25 Jun 2020 21:53:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
Content-Language: en-US
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUvMDYvMjAyMCAyMS4zOSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBPbiAyNS4wNi4y
MDIwIDE2OjQ4LCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+PiBPbiAyNS8wNi8yMDIwIDE1LjA0
LCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+Pj4gT24gMjUvMDYvMjAyMCAxNC4yMSwgSmF2aWVy
IEdvbnrDoWxleiB3cm90ZToKPj4+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29u
ekBzYW1zdW5nLmNvbT4KPj4+Pgo+Pj4+IFRoaXMgcGF0Y2hzZXQgZXh0ZW5kcyB6b25lZCBkZXZp
Y2UgZnVuY3Rpb25hbGl0eSBvbiB0b3Agb2YgdGhlIAo+Pj4+IGV4aXN0aW5nCj4+Pj4gdjMgWk5T
IHBhdGNoc2V0IHRoYXQgS2VpdGggc2VudCBsYXN0IHdlZWsuCj4+Pj4KPj4+PiBQYXRjaGVzIDEt
NSBhcmUgem9uZWQgYmxvY2sgaW50ZXJmYWNlIGFuZCBJT0NUTCBhZGRpdGlvbnMgdG8gZXhwb3Nl
IAo+Pj4+IFpOUwo+Pj4+IHZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlz
IHRoZSBhZGRpdGlvbiBvZiBhIG5ldyB6b25lCj4+Pj4gbWFuYWdlbWVudCBJT0NUTCB0aGF0IGFs
bG93cyB0byBleHRlbmQgem9uZSBtYW5hZ2VtZW50IGNvbW1hbmRzIHdpdGgKPj4+PiBmbGFncy4g
SSByZWNhbGwgYSBjb252ZXJzYXRpb24gaW4gdGhlIG1haWxpbmcgbGlzdCBmcm9tIGVhcmx5IHRo
aXMgCj4+Pj4geWVhcgo+Pj4+IHdoZXJlIGEgc2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQg
YnkgTWF0aWFzLCBidXQgbmV2ZXIgbWFkZSBpdAo+Pj4+IHVwc3RyZWFtLiBXZSBleHRlbmRlZCB0
aGUgSU9DVEwgaGVyZSB0byBhbGlnbiB3aXRoIHRoZSBjb21tZW50cyBpbiAKPj4+PiB0aGF0Cj4+
Pj4gdGhyZWFkLiBIZXJlLCB3ZSBhcmUgaGFwcHkgdG8gZ2V0IHNpZ24tb2ZmcyBieSBhbnlvbmUg
dGhhdCBjb250cmlidXRlZAo+Pj4+IHRvIHRoZSB0aHJlYWQgLSBqdXN0IGNvbW1lbnQgaGVyZSBv
ciBvbiB0aGUgcGF0Y2guCj4+Pgo+Pj4gVGhlIG9yaWdpbmFsIHBhdGNoc2V0IGlzIGF2YWlsYWJs
ZSBoZXJlOiAKPj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzYvMjEvNDE5Cj4+Pgo+Pj4g
V2Ugd2FudGVkIHRvIHdhaXQgcG9zdGluZyBvdXIgdXBkYXRlZCBwYXRjaGVzIHVudGlsIHRoZSBi
YXNlIHBhdGNoZXMgCj4+PiB3ZXJlIHVwc3RyZWFtLiBJIGd1ZXNzIHRoZSBjYXQgaXMgb3V0IG9m
IHRoZSBiYWcuIDopCj4+Pgo+Pj4gRm9yIHRoZSBvcGVuL2ZpbmlzaC9yZXNldCBwYXRjaCwgeW91
J2xsIHdhbnQgdG8gdGFrZSBhIGxvb2sgYXQgdGhlIAo+Pj4gb3JpZ2luYWwgcGF0Y2hzZXQsIGFu
ZCBhcHBseSB0aGUgZmVlZGJhY2sgZnJvbSB0aGF0IHRocmVhZCB0byB5b3VyIAo+Pj4gcGF0Y2gu
IFBsZWFzZSBhbHNvIGNvbnNpZGVyIHRoZSB1c2VycyBvZiB0aGVzZSBvcGVyYXRpb25zLCBlLmcu
LCBkbSwgCj4+PiBzY3NpLCBudWxsX2JsaywgZXRjLiBUaGUgb3JpZ2luYWwgcGF0Y2hzZXQgaGFz
IHBhdGNoZXMgZm9yIHRoYXQuCj4+Pgo+PiBQbGVhc2UgZGlzcmVnYXJkIHRoZSBhYm92ZSAtIEkg
Zm9yZ290IHRoYXQgdGhlIG9yaWdpbmFsIHBhdGNoc2V0IAo+PiBhY3R1YWxseSB3ZW50IHVwc3Ry
ZWFtLgo+Pgo+PiBZb3UncmUgcmlnaHQgdGhhdCB3ZSBkaXNjdXNzZWQgKEkgYXQgbGVhc3QgZGlz
Y3Vzc2VkIGl0IGludGVybmFsbHkgCj4+IHdpdGggRGFtaWVuLCBidXQgSSBjYW4ndCBmaW5kIHRo
ZSBtYWlsKSBoYXZpbmcgb25lIG1nbXQgaXNzdWluZyB0aGUgCj4+IGNvbW1hbmRzLiBXZSBkaWRu
J3QgZ28gYWhlYWQgYW5kIGFkZGVkIGl0IGF0IHRoYXQgcG9pbnQgZHVlIHRvIFpOUyAKPj4gc3Rp
bGwgYmVpbmcgaW4gYSBmbHVmZnkgc3RhdGUuCj4+Cj4KPiBEb2VzIHRoZSBwcm9wb3NlZCBJT0NU
TCBhbGlnbiB3aXRoIHRoZSB1c2UgY2FzZXMgeW91IGhhdmUgaW4gbWluZD8gSSdtCj4gaGFwcHkg
dG8gdGFrZSBpdCBpbiBhIGRpZmZlcmVudCBzZXJpZXMgaWYgeW91IHdhbnQgdG8gYWRkIHBhdGNo
ZXMgdG8gaXQKPiBmb3Igb3RoZXIgZHJpdmVycyAoc2NzaSwgbnVsbF9ibGssIGV0Yy4pLgoKSSB0
aGluayB0aGUgaW9jdGwgbWFrZXMgc2Vuc2UuIEkgd2FudGVkIHRvIGhhdmUgaXQgbGlrZSB0aGF0
IG9yaWdpbmFsbHkuIApJJ20gc3RpbGwgdGhpbmtpbmcgdGhyb3VnaCBpZiBpdCBjb3ZlcnMgdGhl
IHNob3J0LXRlcm0gY2FzZXMgZm9yIHRoZSAKdXBjb21pbmcgVFBzLgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
