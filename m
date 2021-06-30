Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C54C11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 19:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008A961474
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 19:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008A961474
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhllSXofRXURJoZVDF+bGJCQwt/XYqww7/9fzh1PXVw=; b=hJHo2Il9Lf64zKcIreNjNhuq9S
	MdezjSFxosD1dfZrBSl7beeOxqQO5IgHMIWB/j7SACDx+gCdWJ54Y9l8bzQJxzo4kEcVJWsCFVtoF
	RBFN003dYHorWhTQA4u20FxiYbjMcZPixgdotUisy7mLH8ZMcMm4tbaj6dHIOsvagYGP8s6KvTISz
	WXFdaO5SYCjkZABigCWe+BPLAXPdF3zbPveSmDyRAMGyWobzEiUGVpBunAMU0MFt+GEsqs+LXHXvJ
	QvvHV1PKpJgeeXzXV4wKI2ZnJ02ALbTfGmC8Wf2i8iIIyEXCd9VdDQkLHXdWqx9IUUZrPMxlGa5mk
	I5nqq73w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lygAW-00F9TL-CO; Wed, 30 Jun 2021 19:46:44 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lygAT-00F9RF-Du
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 19:46:42 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D05231FEED;
 Wed, 30 Jun 2021 19:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625082397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
 b=aS08WQOpPfT/HM02tdg+pYFp6j21Lx64JgCaLR91Vyhdzpfu0JT1DZVvY2BAITNdpkQDEU
 6GCY9wGy2ZHXo74NwqDn36XCLKLQgVE9a+k9BwsZMQYstsLhWopDL3OEG3r0NbYf8GFPxG
 bSRE7KJJUmsidokNf/tvxhcgdBFuMic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625082397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
 b=TGY8ltgnR+psVd40iGsbS7vZeHXvNWUnRrN3rgHgw+eagngCNhrIzmXP917bZNXYvKwYmB
 MYlvLieXu6ubcICA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A977D118DD;
 Wed, 30 Jun 2021 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625082397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
 b=aS08WQOpPfT/HM02tdg+pYFp6j21Lx64JgCaLR91Vyhdzpfu0JT1DZVvY2BAITNdpkQDEU
 6GCY9wGy2ZHXo74NwqDn36XCLKLQgVE9a+k9BwsZMQYstsLhWopDL3OEG3r0NbYf8GFPxG
 bSRE7KJJUmsidokNf/tvxhcgdBFuMic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625082397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/sOrVdN96EFG02Nt1Orskqd1mwnvmf43ZLsBmFEb7uA=;
 b=TGY8ltgnR+psVd40iGsbS7vZeHXvNWUnRrN3rgHgw+eagngCNhrIzmXP917bZNXYvKwYmB
 MYlvLieXu6ubcICA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id hFsnJhzK3GA1QwAALh3uQQ
 (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 19:46:36 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
 John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de> <YNwug8n7qGL5uXfo@T590>
 <c1de513a-5477-9d1d-0ddc-24e9166cc717@suse.de> <YNw/DcxIIMeg/2VK@T590>
 <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <89081624-fedd-aa94-1ba2-9a137708a1f1@suse.de>
Date: Wed, 30 Jun 2021 21:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <e106f9c4-35c3-b2da-cdd8-3c4dff8234d6@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_124641_650059_71835E4B 
X-CRM114-Status: GOOD (  18.50  )
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

T24gNi8zMC8yMSA4OjU5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+Pj4+PiBTaG91bGRu
J3Qgd2UgcmF0aGVyIG1vZGlmeSB0aGUgdGFnc2V0IHRvIG9ubHkgcmVmZXIgdG8gdGhlIGN1cnJl
bnQgCj4+Pj4+IG9ubGluZQo+Pj4+PiBDUFVzIF9vbmx5XywgdGhlcmVieSBuZXZlciBzdWJtaXQg
YSBjb25uZWN0IHJlcXVlc3QgZm9yIGhjdHggd2l0aCBvbmx5Cj4+Pj4+IG9mZmxpbmUgQ1BVcz8K
Pj4+Pgo+Pj4+IFRoZW4geW91IG1heSBzZXR1cCB2ZXJ5IGxlc3MgaW8gcXVldWVzLCBhbmQgcGVy
Zm9ybWFuY2UgbWF5IHN1ZmZlciBldmVuCj4+Pj4gdGhvdWdoIGxvdHMgb2YgQ1BVcyBiZWNvbWUg
b25saW5lIGxhdGVyLgo+Pj4+IDsKPj4+IE9ubHkgaWYgd2Ugc3RheSB3aXRoIHRoZSByZWR1Y2Vk
IG51bWJlciBvZiBJL08gcXVldWVzLiBXaGljaCBpcyBub3QgCj4+PiB3aGF0IEknbQo+Pj4gcHJv
cG9zaW5nOyBJJ2QgcmF0aGVyIHByZWZlciB0byBjb25uZWN0IGFuZCBkaXNjb25uZWN0IHF1ZXVl
cyBmcm9tIAo+Pj4gdGhlIGNwdQo+Pj4gaG90cGx1ZyBoYW5kbGVyLiBGb3Igc3RhcnRlcnMgd2Ug
Y291bGQgZXZlbiB0cmlnZ2VyIGEgcmVzZXQgb25jZSB0aGUgCj4+PiBmaXJzdAo+Pj4gY3B1IHdp
dGhpbiBhIGhjdHggaXMgb25saW5lZC4KPj4KPj4gWWVhaCwgdGhhdCBuZWVkIG9uZSBiaWcvY29t
cGxpY2F0ZWQgcGF0Y2hzZXQsIGJ1dCBub3Qgc2VlIGFueSBhZHZhbnRhZ2VzCj4+IG92ZXIgdGhp
cyBzaW1wbGUgYXBwcm9hY2guCj4gCj4gSSB0ZW5kIHRvIGFncmVlIHdpdGggTWluZyBoZXJlLgoK
QWN0dWFsbHksIERhbmllbCBhbmQgbWUgY2FtZSB0byBhIHNsaWdodGx5IGRpZmZlcmVudCBpZGVh
OiB1c2UgY3B1IApob3RwbHVnIG5vdGlmaWVyLgpUaGluZyBpcywgYmxrLW1xIGFscmVhZHkgaGFz
IGNwdSBob3RwbHVnIG5vdGlmaWVyLCB3aGljaCBzaG91bGQgZW5zdXJlIAp0aGF0IG5vIEkvTyBp
cyBwZW5kaW5nIGR1cmluZyBjcHUgaG90cGx1Zy4KSWYgd2Ugbm93IGFkZCBhIG52bWUgY3B1IGhv
dHBsdWcgbm90aWZpZXIgd2hpY2ggZXNzZW50aWFsbHkga2lja3Mgb2ZmIGEgCnJlc2V0IG9uY2Ug
YWxsIGNwdSBpbiBhIGhjdHggYXJlIG9mZmxpbmUgdGhlIHJlc2V0IGxvZ2ljIHdpbGwgcmVhcnJh
bmdlIAp0aGUgcXVldWVzIHRvIG1hdGNoIHRoZSBjdXJyZW50IGNwdSBsYXlvdXQuCkFuZCB3aGVu
IHRoZSBjcHVzIGFyZSBnZXR0aW5nIG9ubGluZWQgd2UnbGwgZG8gYW5vdGhlciByZXNldC4KCkRh
bmllbCBpcyBjdXJyZW50bHkgcHJlcGFyaW5nIGEgcGF0Y2g7IGxldCdzIHNlZSBob3cgaXQgZ29l
cy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
