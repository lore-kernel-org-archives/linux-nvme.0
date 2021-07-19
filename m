Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13983C12002
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDF66108B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 09:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDF66108B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=vk66+6F9mNRCk1B+6lCv+d8WnegqJ7N2zw3Ums2D/nE=; b=XLtd5K67BNdXVlJT8tctS+/HT9
	oScleZgygT/PHwO2lTiSMZJ/SKhUROjxXYIFHwYKrih2AiOI8xucj2KTMxj4iM9pYYvFKtdihcmnQ
	wd4q2mYOT/f7rDgSMKEDie6IBMUjhO6DY7Z+j87QpeMDtYNDKYeM8qqx969LLdrYwiUmrjGTOBMIO
	3ejlWDgOHebMH3KqlXBugVAy4VsrHtKL//+STfMQWUddIkVdWV1Hr16x6ydsze6hFGQEE5Qnx1B66
	B2244gBCtxBik+Qhcqx7j/BdgFRDwlZsE/F7yq6O8Wl1hG29bRW4k/KCna8nByRn2Ahxa/mjAq6ye
	APmSH19w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5Q18-0099Oo-Tm; Mon, 19 Jul 2021 09:56:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5Q16-0099OS-Ki
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 09:56:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C747201DA;
 Mon, 19 Jul 2021 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626688610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+KYZhu8MHF65CyDgaHI85CrDt1saurCBksyVHMp+A8=;
 b=jD5T8bRvtKTlaUFvNTfYd9BGX9kBnfID77sxAfQaZhVJDApYrLOHNYOnx/yeHyxShuMvxm
 RBiGqT4o57GnSuRKT/xE4eT53WIVE02wfg8Xy4wAbbSReWdlyERErabWmIL6DvyvBaceAj
 RNrruKZmcBNvx57Z6DuxAHsad47c8o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626688610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+KYZhu8MHF65CyDgaHI85CrDt1saurCBksyVHMp+A8=;
 b=8mwf2UGIcy5I4+UCBM8M4c6xQ2sW05K/yFJNE28P7Hb1Cod11q1LbozDQvILdU52fbLzSf
 YqqihxCPQET2vmCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B6F513CA7;
 Mon, 19 Jul 2021 09:56:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QIlGCmJM9WDLMwAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 09:56:50 +0000
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-12-hare@suse.de>
 <9ac44322-5c89-da94-b540-6086d2a32bc2@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 11/11] nvme: add non-standard ECDH and curve25517
 algorithms
Message-ID: <e0e02c98-8537-c853-55b6-5b829f5f1ee6@suse.de>
Date: Mon, 19 Jul 2021 11:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9ac44322-5c89-da94-b540-6086d2a32bc2@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_025652_873592_F1325E9A 
X-CRM114-Status: GOOD (  14.05  )
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

T24gNy8xOS8yMSAxMToyMyBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gVExTIDEuMyBz
cGVjaWZpZXMgRUNESCBhbmQgY3VydmUyNTUxNyBpbiBhZGRpdGlvbiB0byB0aGUgRkZESEUKPj4g
Z3JvdXBzLCBhbmQgdGhlc2UgYXJlIGFscmVhZHkgaW1wbGVtZW50ZWQgaW4gdGhlIGtlcm5lbC4K
PiAKPiBTbz8KPiAKPj4gU28gYWRkIHN1cHBvcnQgZm9yIHRoZXNlIG5vbi1zdGFuZGFyZCBncm91
cHMgZm9yIE5WTWUgaW4tYmFuZAo+PiBhdXRoZW50aWNhdGlvbiB0byB2YWxpZGF0ZSB0aGUgYXVn
bWVudGVkIGNoYWxsZW5nZSBpbXBsZW1lbnRhdGlvbi4KPiAKPiBXaHk/IHdoeSBzaG91bGQgdXNl
cnMgY29tZSB0byBleHBlY3QgY29udHJvbGxlcnMgdG8gc3VwcG9ydCBpdD8KCkhhdmluZyBFQ0RI
IGFuZCBjdXJ2ZTI1NTE3IGFsZ29yaXRobXMgKHdoaWNoIGFyZSBrbm93bi1nb29kCmltcGxlbWVu
dGF0aW9ucykgYWxsb3dzIG9uZSB0byB2YWxpZGF0ZSB0aGUgZmZkaGUgaW1wbGVtZW50YXRpb24s
IGllIHRvCmVuc3VyZSB0aGF0IHRoZSByZW1haW5kZXIgb2YgdGhlIHByb3RvY29sIHdvcmtzIGFz
IGRlc2lnbmVkLCBldmVuIGlmIHRoZQpmZmRoZSBpbXBsZW1lbnRhdGlvbiBtaWdodCBub3QuCkFu
ZCBvbmUgY291bGQgYXJndWUgdGhhdCBUTFMxLjMgc3BlY2lmaWVzIGFsbCBvZiB0aGVzZSBhbGdv
cml0aG1zLCBzbwpOVk1lIHdpdGggaXQncyBleHBsaWNpdCByZWZlcmVuY2UgdG8gVExTIHNob3Vs
ZCBkbyBzbywgdG9vLgoKQnV0IEkgZG9uJ3QgaW5zaXN0IG9uIGl0OyBpdCdzIGp1c3QgbmljZSBm
b3IgZGVidWdnaW5nLCB0aGF0J3MgYWxsLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2Uu
ZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
