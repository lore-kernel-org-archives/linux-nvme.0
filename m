Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888DBC47082
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:59:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36BC36115B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BC36115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UWUIdG3MPHq4YD4oBqtJOuF2bVBez/6S9Tb5QAQxiKA=; b=hSyZfAbd46PVbAa2wczTWvnBZ/
	ONg1R528QqAXHtDn8QkxXRhEOoyScPbz9qwgL7/VQN/wEcAvrb1nSm7Y7HcU1BBbG/jmfibRlzZWC
	w70t9oCN6usByPQRU6iuFQqYGHoTdqOghGSzWM2rAYGK5V+dKcJCbnwy3lQz13hLajDMIvTpv3w5x
	shczUhZ0LX7QxpnWxQtPDRP+M7UduyBnjkJgz1xpQYlMlde45c5r/TzuBI8NGOwcxwhk7rADvSbJ2
	Yb+xvLO5fYvKGELOJHqq5Wf+alUv+tPrBwOclCzL2o8M+rnEZqi0MOhRrBfmH4ZwTcQsR1PPM61jt
	NmhTULzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqC2D-002l8E-OO; Mon, 07 Jun 2021 09:59:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBpq-002h3S-So
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:46:23 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 306511FDA5;
 Mon,  7 Jun 2021 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623059175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhWkdwysKHHdK24cjDSrvsSOuDYSyaVn/xSMrHWbSt4=;
 b=Kj/gaCLQYcHeGptj22kXyM4Tgat/5rLzJ58oAEzACxR/ZayYbxZ0fZbSqmqxvV4yFLFCzr
 uGHGhUXo1YRb8Muh6cGtLobLJsPcZzkGPaZoi33YNCH214EdVzgQpXZAaqSOGuspE5Vnuw
 pIoEDhNW4OkrSs0z/JbJQngcUmBEQHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623059175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhWkdwysKHHdK24cjDSrvsSOuDYSyaVn/xSMrHWbSt4=;
 b=YjweCssd7r9t9We9AlJAlUXT4L8d9ekREMDnz+5TJfeoz2y1kesOL/KOYt/cvYIRnGNn0F
 knWSu/g4H3szY2DA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 0A152118DD;
 Mon,  7 Jun 2021 09:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623059175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhWkdwysKHHdK24cjDSrvsSOuDYSyaVn/xSMrHWbSt4=;
 b=Kj/gaCLQYcHeGptj22kXyM4Tgat/5rLzJ58oAEzACxR/ZayYbxZ0fZbSqmqxvV4yFLFCzr
 uGHGhUXo1YRb8Muh6cGtLobLJsPcZzkGPaZoi33YNCH214EdVzgQpXZAaqSOGuspE5Vnuw
 pIoEDhNW4OkrSs0z/JbJQngcUmBEQHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623059175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mhWkdwysKHHdK24cjDSrvsSOuDYSyaVn/xSMrHWbSt4=;
 b=YjweCssd7r9t9We9AlJAlUXT4L8d9ekREMDnz+5TJfeoz2y1kesOL/KOYt/cvYIRnGNn0F
 knWSu/g4H3szY2DA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id WEWcAefqvWD0HAAALh3uQQ
 (envelope-from <hare@suse.de>); Mon, 07 Jun 2021 09:46:15 +0000
Subject: Re: [PATCH] nvme-multipath: call del_gendisk() in
 nvme_mpath_check_last_path()
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210531070914.102439-1-hare@suse.de>
 <20210603072244.GA4687@lst.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <afb8bb95-0b53-0dcf-89cb-7d96c91c2189@suse.de>
Date: Mon, 7 Jun 2021 11:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210603072244.GA4687@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_024619_126437_7CD77854 
X-CRM114-Status: GOOD (  16.58  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8zLzIxIDk6MjIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiArdm9pZCBudm1l
X21wYXRoX2NoZWNrX2xhc3RfcGF0aChzdHJ1Y3QgbnZtZV9ucyAqbnMpCj4+ICB7Cj4+ICsJc3Ry
dWN0IG52bWVfbnNfaGVhZCAqaGVhZCA9IG5zLT5oZWFkOwo+PiArCj4+ICAJaWYgKCFoZWFkLT5k
aXNrKQo+PiAgCQlyZXR1cm47Cj4+IC0JaWYgKGhlYWQtPmRpc2stPmZsYWdzICYgR0VOSERfRkxf
VVApIHsKPj4gKwo+PiArCWlmIChsaXN0X2VtcHR5KCZoZWFkLT5saXN0KSAmJiBoZWFkLT5kaXNr
LT5mbGFncyAmIEdFTkhEX0ZMX1VQKSB7Cj4gCj4gUGxlYXNlIGFkZCB0aGUgYnJhY2VzIGFyb3Vu
ZCB0aGUgIiYiLgo+IApPay4KCj4+ICAJCW52bWVfY2Rldl9kZWwoJmhlYWQtPmNkZXYsICZoZWFk
LT5jZGV2X2RldmljZSk7Cj4+ICAJCWRlbF9nZW5kaXNrKGhlYWQtPmRpc2spOwo+PiAgCX0KPj4g
K30KPiAKPiBBbHNvIGl0IHNlZW1zIGxpa2Ugd2UgY2FuIGp1c3QgcGFzcyB0aGUgaGVhZCBoZXJl
LCBubyBuZWVkIGZvciBucy4KPiAKT2suCgo+PiAtCWlmIChoZWFkLT5kaXNrICYmIGxpc3RfZW1w
dHkoJmhlYWQtPmxpc3QpKQo+PiAtCQlrYmxvY2tkX3NjaGVkdWxlX3dvcmsoJmhlYWQtPnJlcXVl
dWVfd29yayk7Cj4gCj4gRGlkIHRoaXMgZ2V0IGxvc3QgaW4gdGhlIG5ldyB2ZXJzaW9uPwo+IApJ
IGhhZCByZW1vdmVkIGl0IGFzIGl0J2xsIGJlIGNhbGxlZCBmcm9tIG52bWVfbXBhdGhfcmVtb3Zl
X2Rpc2soKQphbnl3YXksIGJ1dCBzZWVpbmcgdGhhdCB0aGUgcmVmY291bnQgbWlnaHQgaW5kdWNl
IGEgZGlmZmVyZW50IGxpZmV0aW1lCkknbGwgYmUgcmUtYWRkaW5nIGl0LgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hp
dGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4g
SW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
