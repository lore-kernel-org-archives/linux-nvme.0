Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1642FC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:35:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D525611C1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D525611C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zI3Vv/88zTzDJe101Ln22GEv4fRlYoOsPncilxWQt9I=; b=dF67CMmTQklQnSIynGcKI0eMP
	Xcl6ZHPNH1Jsocp5sUO0JBOTwhTSD8F0LAlck3ra4iDqndoe9KxJy/ZsikOAts40cTWqWjplRVLdZ
	/mU7FnLOzD2SROoXac4KlAV8PCUvNviX7nLNnSE22al2S26V1OH6w+7Q/J5WNYsr1Lo96iEJussQB
	1arMXiGTYPWTsCHCJn2SkKcZh8N8XSv4EmxHvm/ysG1ym7aiutoLpX8rXp2zYOy5v5FXSMMPGxgNO
	TO8PFRZcPzLDrhhkz0dTR3fbpgbtBy2kXjorF8Rd3kfUSIf2W5dqwW9BkcaP7lddvxbwQZ6Wzm0Vx
	eMpYeo1og==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgPiv-00Gxma-Hy; Tue, 11 May 2021 10:34:45 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgKxn-00GLSu-0U
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 05:29:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=02GRQzSvltwlHQxwDm7DQr2mEhLlc7XHGVpA3nlBwhg=; b=k/gBTnp2/0PScRL9kz0DGUcy10
 339K9hZB1YbBUVG3gcO6ox7e71bc5l1p28gqM3mNmqiCO8roaD/00KKzzs5L3rV5ftOb+D7baLv1o
 HN+aBFJg/PkNNxH5PcoSfD4xVBFD1RBC+eAAs7BdG7OqrXPEIVX7x+8HEFws7uMBBTpVvT3Io+qGO
 MVU6kQ1dSacTfqhws5BIOMjICziTLMnnLLSnnpO6YVqWw6YuZi/dQaK5Lri+P+QgQcDmx1J30VKSY
 Cjhd2wQxPPjBRgbdiGyV8AowuhSfXcPva+QRk+TDlK+lzH34zSfDIUf5wuZva+5vC8c21eWrvq87q
 E9RVXzaw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgKxi-009JgO-Ed
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 05:29:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1D7D1ADA2;
 Tue, 11 May 2021 05:29:40 +0000 (UTC)
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f20be46f-ecb7-1de8-dace-f813948a84cc@suse.de>
Date: Tue, 11 May 2021 07:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_222942_653761_5F7B82FE 
X-CRM114-Status: GOOD (  20.62  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_222942_653761_5F7B82FE': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_222942_653761_5F7B82FE 
X-CRM114-Status: GOOD (  16.82  )
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

T24gNS8xMC8yMSA1OjUzIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBNb24sIE1heSAxMCwg
MjAyMSBhdCAwNDo0OTowNlBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IEBAIC0z
NjA1LDE2ICszNjA4LDI2IEBAIHN0YXRpYyBpbnQgbnZtZV9pbml0X25zX2hlYWQoc3RydWN0IG52
bWVfbnMgKm5zLCB1bnNpZ25lZCBuc2lkLAo+PiAgIAkJaGVhZC0+c2hhcmVkID0gaXNfc2hhcmVk
Owo+PiAgIAl9IGVsc2Ugewo+PiAgIAkJcmV0ID0gLUVJTlZBTDsKPj4gLQkJaWYgKCFpc19zaGFy
ZWQgfHwgIWhlYWQtPnNoYXJlZCkgewo+PiAtCQkJZGV2X2VycihjdHJsLT5kZXZpY2UsCj4+IC0J
CQkJIkR1cGxpY2F0ZSB1bnNoYXJlZCBuYW1lc3BhY2UgJWRcbiIsIG5zaWQpOwo+PiAtCQkJZ290
byBvdXRfcHV0X25zX2hlYWQ7Cj4+IC0JCX0KPj4gLQkJaWYgKCFudm1lX25zX2lkc19lcXVhbCgm
aGVhZC0+aWRzLCBpZHMpKSB7Cj4+IC0JCQlkZXZfZXJyKGN0cmwtPmRldmljZSwKPj4gLQkJCQki
SURzIGRvbid0IG1hdGNoIGZvciBzaGFyZWQgbmFtZXNwYWNlICVkXG4iLAo+PiArCQkvKgo+PiAr
CQkgKiBJZiBtdWx0aXBhdGggaXMgZW5hYmxlZCB3ZSBtaWdodCBoaXQgYW4gbnMgaGVhZCB3aXRo
IG5vCj4+ICsJCSAqIHBhdGhzLCBidXQgdGhhdCBkb2Vzbid0IGluZGljYXRlIGl0J3MgYSBzaGFy
ZWQgbmFtZXNwYWNlLgo+PiArCQkgKi8KPj4gKwkJaWYgKCFudm1lX25zX2hlYWRfbXVsdGlwYXRo
KGhlYWQpIHx8Cj4+ICsJCSAgICAhbGlzdF9lbXB0eSgmaGVhZC0+bGlzdCkpIHsKPj4gKwkJCWlm
ICghaXNfc2hhcmVkIHx8ICFoZWFkLT5zaGFyZWQpIHsKPj4gKwkJCQlkZXZfZXJyKGN0cmwtPmRl
dmljZSwKPj4gKwkJCQkJIkR1cGxpY2F0ZSB1bnNoYXJlZCBuYW1lc3BhY2UgJWRcbiIsIG5zaWQp
Owo+PiArCQkJCWdvdG8gb3V0X3B1dF9uc19oZWFkOwo+PiArCQkJfQo+IAo+IElmIG5vdCBtdWx0
aXBhdGgsIHRoZW4gaXQgaXMgbm90IHNoYXJlZC4gVGhlIGFib3ZlIHdpbGwgZmFpbCBhdHRhY2hp
bmcKPiBzaW5nbGUtcGF0aCBuYW1lc3BhY2VzIHRvIGEga25vd24gaGVhZC4KPiAKUmlnaHQuIFdp
bGwgYmUgZml4aW5nIGl0IHVwLgoKPiBUaGUgcmVzdCBpcyBzaW1pbGFyIHRvIHNvbWV0aGluZyBJ
IHdhcyB3b3JraW5nIG9uIHRvbywgdGhvdWdoLCBzbyBJCj4gdGhpbmsgaXQncyB0aGUgcmlnaHQg
ZGlyZWN0aW9uLgo+IAo+IApBdCBsb25nIGxhc3QsIGhvcGUgaXMgb24gdGhlIGhvcml6b24gOi0p
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAg
S2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
