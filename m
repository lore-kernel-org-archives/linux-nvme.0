Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A3FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 16:36:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93881239EE
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 16:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93881239EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Voe5U0m/PEP8SzP/YfcGGgA8z5T1um9P9/UDePtacmU=; b=LYY0lSEYbUeVgpDuYZNixJVWJ
	pP9NNxG8cZdOYUtC8X9skZ5fFSjSCoS5JUrWZIC5weQup/gURzwqMX66fl8aZ2U6KFMwRc/vWSCNb
	pxXjHq1y7wiLs7ljSGTieU/IJ6q4IRZS50uSEK+KXAqAyF2qePu4spAVyDsKwTSpxLEONaPD5FBub
	OFvznDJbtoofCAtmX223Lw14i9frWXRboGH3FhnjKR7wknoTb1ZFM8S5bkZmptUG55Cn9WaOtWJZh
	6m0Kto0vs4yF8ylKy8kqrF6iJP16iDHQVNxiH5WHK3dZGreJLWX37ja8DIm7/oKDUDcAlQkVnbWm2
	cCVOeee6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2zPW-0006lX-5Z; Fri, 22 Jan 2021 16:35:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2zPS-0006k8-Tp
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 16:35:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1F95AAF55;
 Fri, 22 Jan 2021 16:35:39 +0000 (UTC)
Subject: Re: [PATCH] nvme: do not ignore nvme status in nvme_set_queue_count()
To: Keith Busch <kbusch@kernel.org>
References: <20210121095021.22807-1-hare@suse.de>
 <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f374b032-cd26-4552-b613-228449f4971d@suse.de>
Date: Fri, 22 Jan 2021 17:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210121201459.GA1727271@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210122_113543_100582_74333214 
X-CRM114-Status: GOOD (  22.47  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yMS8yMSA5OjE0IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUaHUsIEphbiAyMSwg
MjAyMSBhdCAxMDo1MDoyMUFNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IElmIHRo
ZSBjYWxsIHRvIG52bWVfc2V0X3F1ZXVlX2NvdW50KCkgZmFpbHMgd2l0aCBhIHN0YXR1cyB3ZSBz
aG91bGQKPj4gbm90IGlnbm9yZSBpdCBidXQgcmF0aGVyIHBhc3MgaXQgb24gdG8gdGhlIGNhbGxl
ci4KPj4gSXQncyB0aGVuIHVwIHRvIHRoZSB0cmFuc3BvcnQgdG8gZGVjaWRlIHdoZXRoZXIgdG8g
aWdub3JlIGl0Cj4+IChsaWtlIFBDSSBkb2VzKSBvciB0byByZXNldCB0aGUgY29ubmVjdGlvbiAo
YXMgd291bGQgYmUgYXBwcm9wcmlhdGUKPj4gZm9yIGZhYnJpY3MpLgo+IAo+IEluc3RlYWQgb2Yg
Y2hlY2tpbmcgdGhlIGVycm9yLCB3b3VsZG4ndCBjaGVja2luZyB0aGUgbnVtYmVyIG9mIGNyZWF0
ZWQKPiBxdWV1ZXMgYmUgc3VmZmljaWVudD8gV2hhdCBoYW5kbGluZyBkaWZmZXJlbmNlIGRvIHlv
dSBleHBlY3QgdG8gb2NjdXIKPiBiZXR3ZWVuIGdldHRpbmcgYSBzdWNjZXNzIHdpdGggMCBxdWV1
ZXMsIHZzIGdldHRpbmcgYW4gZXJyb3I/Cj4gClRoZSBkaWZmZXJlbmNlIGlzIHRoYXQgYW4gZXJy
b3Igd2lsbCAocmUtKXN0YXJ0IHJlY292ZXJ5LCAwIHF1ZXVlcyB3b24ndC4KQnV0IHRoZSBwcm9i
bGVtIGhlcmUgaXMgdGhhdCBudm1lX3NldF9xdWV1ZV9jb3VudCgpIGlzIGJlaW5nIGNhbGxlZCAK
ZHVyaW5nIHJlY29ubmVjdGlvbiwgaWUgZHVyaW5nIHRoZSByZWNvdmVyeSBwcm9jZXNzIGl0c2Vs
Zi4KQW5kIHRoaXMgY29tbWFuZCBpcyByZXR1cm5lZCB3aXRoIGEgdGltZW91dCwgd2hpY2ggaW4g
YW55IG90aGVyIGNhc2UgaXMgCmJlaW5nIHRyZWF0ZWQgYXMgYSBmYXRhbCBlcnJvci4gUGx1cyB3
ZSBoYXZlIGJlZW4gc2VuZGluZyB0aGlzIGNvbW1hbmQgCm9uIHRoZSBhZG1pbiBxdWV1ZSwgc28g
YSB0aW1lb3V0IG9uIHRoZSBhZG1pbiBxdWV1ZSBwcmV0dHkgbXVjaCBfaXNfICBhIApmYXRhbCBl
cnJvci4gU28gd2Ugc2hvdWxkIGJlIHRlcm1pbmF0aW5nIHRoZSBjdXJyZW50IHJlY292ZXJ5IGFu
ZCAKcmVjb25uZWN0LiBOb25lIG9mIHRoYXQgd2lsbCBoYXBwZW4gaWYgd2UgcmV0dXJuICcwJyBx
dWV1ZXMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJu
YmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
