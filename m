Return-Path: <SRS0=5HbI=KR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86528C2B9F2
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 09:49:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AC4B61151
	for <linux-nvme@archiver.kernel.org>; Sat, 22 May 2021 09:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC4B61151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOhBJu6+m/8+lnmITZjsKC/gt+L72LgD84+GmM6czxY=; b=cnuaIK/5WkUUFhIFA6umSxkNuI
	Mp0XqPWVVxQWmiRQB6IQfNxPBMfnjtmWGEcVEoGmhxDGHbRJER98TnzB165gVOtVkmjucO/eucVVF
	3Yu5Pwj+diX+6U9vshPeZdJS1506ziGCjvXV4zOyQXLKDMFnW0VzUeIu+gR+kUOzKlNZ2zXNOkEw6
	8Q2hgRIbsPXrHuN2DwIO8YCtE4n8MMcXlPE5sS9Xc8FhhsYiyF4Lh3pesX/BPnMeyLvhyHRcCdyvB
	QthAVBHFpYtRJOENytziUyFbThlWp03uN1iXdmhT7w8AnQQyqI2kUCheWvaNIduk9dBExG7AAwmBQ
	CUP/0BoQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkOFo-002Ehl-Eg; Sat, 22 May 2021 09:49:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkOFg-002EhO-Up
 for linux-nvme@desiato.infradead.org; Sat, 22 May 2021 09:49:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=Nm/FrfepCxlEBIbddk6TsflLiOjzOfwKmZ4Ikliq+Pg=; b=Bmic3r7LEFpkbvi07DBQMdNcba
 PF2CBu0WxlA/1o68nLVPCCqbpmVg7SWH//kSmCz/IqxLzIP+KdF6KjrDcpDIOtEAvl8AMBsusT+90
 R+HCogKiQ53uUpA6/qGhd26XZC1CBUbZzcAS/WRKeZVCOURLGt6qiQU24hw4pmkFcWuQagFkSXF2y
 d9hwoRUNeqL+mh9TWvcr4dI3qIgxw5Aa65cJ7VaZuE6tOkwsvfmll3l0Az/bDr3bopOI80Ifpg4HH
 gnFtglyV3ZzP0Nkg9c03bX6aLrvNfODOWDHu1d4oYGD59eksu/2DGYPLmIAIA2JIbMbzihH5S5eYB
 5lqgl3Cw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkOFd-0004Ew-90
 for linux-nvme@lists.infradead.org; Sat, 22 May 2021 09:48:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621676930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm/FrfepCxlEBIbddk6TsflLiOjzOfwKmZ4Ikliq+Pg=;
 b=D0cKkMVXmpRHDVIBZ92FZl7isI0T/uMhXkAsL+bcV1l+YMnd80CzOVn8kBdry8D9FJsDQR
 ERjKFH1RhXHsJhsENi/XlL8lRfRlMUiy/Gy7Y89rTR9gd+pak24h2WNm6SCyIf7FDoY5AO
 TS2z85bOL/5hD26J8vW99lHhBK2dDso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621676930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nm/FrfepCxlEBIbddk6TsflLiOjzOfwKmZ4Ikliq+Pg=;
 b=BNDkkHPa9M1YcTLscH7Va000abUwXVwLd/kfouE7itLw2lfm0+vO1rvs9XgnH+3qaCwME8
 quw8KmySXRFKgsCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8D5DBABC1;
 Sat, 22 May 2021 09:48:50 +0000 (UTC)
Subject: Re: [PATCH] nvme/fc: Short-circuit reconnect retries
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, James Smart
 <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20210521082300.146648-1-hare@suse.de>
 <4348b2a1-0861-0020-e873-0680812c4849@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <53719187-1b2b-adcf-85f8-0237c8093d15@suse.de>
Date: Sat, 22 May 2021 11:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4348b2a1-0861-0020-e873-0680812c4849@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210522_024857_508289_14BE9C61 
X-CRM114-Status: GOOD (  13.01  )
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

T24gNS8yMS8yMSAxMDoxNyBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gwqDCoMKgwqDC
oCBpZiAocmVjb24gJiYgbnZtZl9zaG91bGRfcmVjb25uZWN0KCZjdHJsLT5jdHJsKSkgewo+PiBA
QCAtMzI4NiwxMiArMzI5MCwxNyBAQCBudm1lX2ZjX3JlY29ubmVjdF9vcl9kZWxldGUoc3RydWN0
IAo+PiBudm1lX2ZjX2N0cmwgKmN0cmwsIGludCBzdGF0dXMpCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBxdWV1ZV9kZWxheWVkX3dvcmsobnZtZV93cSwgJmN0cmwtPmNvbm5lY3Rfd29yaywgcmVjb25f
ZGVsYXkpOwo+PiDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocG9y
dHB0ci0+cG9ydF9zdGF0ZSA9PSBGQ19PQkpTVEFURV9PTkxJTkUpCj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGRldl93YXJuKGN0cmwtPmN0cmwuZGV2aWNlLAo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICJOVk1FLUZDeyVkfTogTWF4IHJlY29ubmVjdCBhdHRlbXB0cyAoJWQp
ICIKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicmVhY2hlZC5cbiIsCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3RybC0+Y251bSwgY3RybC0+Y3RybC5ucl9y
ZWNvbm5lY3RzKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGVsc2UKPj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChwb3J0cHRyLT5wb3J0X3N0YXRlID09IEZDX09CSlNUQVRFX09OTElORSkgewo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzID4gMCAmJiAoc3RhdHVzICYgTlZNRV9TQ19ETlIp
KQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGN0cmwtPmN0cmwu
ZGV2aWNlLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiTlZN
RS1GQ3slZH06IHJlY29ubmVjdCBmYWlsdXJlXG4iLAo+IAo+IE1heWJlIHdvcnRoIHRvIHByaW50
IHRoZSBzdGF0dXMgaGVyZT8KPiAKPiBPdGhlcndpc2UgbG9va3MgZ29vZCwKPiBSZXZpZXdlZC1i
eTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KCk5vIG5lZWQsIGFzIGl0J3MgYWxy
ZWFkeSBwcmludGVkIGJ5IHRoZSBwcmV2aW91cyBtZXNzYWdlIHNvbWUgbGluZXMgCmFib3ZlIHRo
aXMgY29kZSA6LSkKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAg
ICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1
dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
