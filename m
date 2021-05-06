Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF89C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 08:43:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BE361166
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 08:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BE361166
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bV00Jxq7X/hUkt342Bb76GR2kNl4T9e62PEAhfn+YLY=; b=A53G1UwVqTtKQqN0yKnSfc67G
	BUc7UfbW7L23ag9dYxv/MM3yYIg5uHhNyH2S7w7qfcPfq3nNOkAYGPhfQfTL7jSqC+8Rm5mUjP/Fd
	t8GzQwfDKwsuQXhSFSClBoym/1OJUs8yIPJvhjKVS8QeO2YenqO7eH+LekY2J5d+cW9bpykiyGTuR
	DxGCFaUR10PUn+8/+bVwWeLVCzmIq2DPw/6kUaWwYt1ygl0KvszDeXMVUw6iaacZNV1X/NEnrbKNJ
	Fdlp4qxMN1OPaFN0oeRUruo9UND5ndrqbRPBQUg4mWULDMYUnuum4CDko1+R1HxolMh48J6pvz9my
	RuDynOWaQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leZb9-003hy5-5X; Thu, 06 May 2021 08:43:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leZb6-003hxt-K8
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 08:43:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=E90xwvmVuTL/QSs6JnJHIlYqpTIyS6UulAZVjZRPZqY=; b=F8YcW7il4Y6I5k6jXsjEFsMz+Y
 Dys9FKIC0IONpx0sH1Hk4K1FkPJy4H5wdhqCT501UEtq4AhYOrweKMuYWxJCZbQbeSEVOOuGzcHLd
 esHbSL3O6wkhv1HZFQuubxXPqT4HYbUhqQkO0pBLNzUliM3XoFj3w7xg20KnFyRGeaKPOG9GH9AmT
 5ZOzZsU6CL53PVPVZ1FiKDCcjgpVXsnMGaYjUhopgbppV7Glins4CvmDuE5QHZCtSMeIVMoqfnEc+
 jRWe+RwipxHdxKnppAx+BNcphs9OJ5x/OiPNHMaiPEasTya9wV12v8W3Y4zkLiZw2elGkTP5hJoqA
 ppVPgP2A==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leZb3-005sYM-U6
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 08:43:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 866FDAC47;
 Thu,  6 May 2021 08:43:00 +0000 (UTC)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
Date: Thu, 6 May 2021 10:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210506074341.GC14615@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_014302_140847_8DF10FE2 
X-CRM114-Status: GOOD (  19.86  )
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

T24gNS82LzIxIDk6NDMgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFR1ZSwgTWF5
IDA0LCAyMDIxIGF0IDEyOjU0OjE0UE0gLTA3MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFll
cywgSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnQgQ2hyaXN0b3BoLiBUaGlz
IGFkZHJlc3NlcyBhbgo+PiBpc3N1ZSB3aXRoIG1kcmFpZCB3aGVyZSBob3QgdW5wbHVnK3JlcGx1
ZyBkb2VzIG5vdCByZXN0b3JlIHRoZSBkZXZpY2UgdG8KPj4gdGhlIHJhaWQgZ3JvdXAgKHBjaSBh
bmQgZmFicmljcyBhbGlrZSksIHdoZXJlIGJlZm9yZSBtdWx0aXBhdGggdGhpcyB1c2VkCj4+IHRv
IHdvcmsuCj4+Cj4+IHF1ZXVlX2lmX25vX3BhdGggaXMgYSBkbS1tdWx0aXBhdGggZmVhdHVyZSBz
byBJJ20gbm90IGVudGlyZWx5IGNsZWFyCj4+IHdoYXQgaXMgdGhlIGNvbmNlcm4/IG1kcmFpZCBv
biBudm1lIChwY2kvZmFicmljcykgdXNlZCB0byB3b3JrIGEgY2VydGFpbgo+PiB3YXksIHdpdGgg
dGhlIGludHJvZHVjdGlvbiBvZiBudm1lLW1wYXRoIHRoZSBiZWhhdmlvciB3YXMgYnJva2VuIChh
cyBmYXIKPj4gYXMgSSB1bmRlcnN0YW5kIGZyb20gSGFubmVzKS4KPiAKPiBBRkFJSyB0aGF0IHNw
ZWNpZmljIG1kcmFpZCBiZWhhdmlvciBpcyBhbHNvIGZpeGVkIGJ5IHRoZSB1ZXZlbnQgcGF0Y2gK
PiBoZSBzZW50Lgo+IApJdCBpcyBtb3N0IGVtcGhhdGljYWxseSBfTk9UXy4KClRoZXNlIHR3byBw
YXRjaGVzIGFyZSBjb21wbGVtZW50YXJ5LgoKVG8gcmVwaHJhc2U6IHdpdGggdGhlIGN1cnJlbnQg
YmVoYXZpb3VyIE1EIGlzIGNvbXBsZXRlbHkgaG9zZWQgb25jZSBvbmUKTlZNZS1vRiBkZXZpY2Ug
Z2V0IHJlbW92ZWQgYWZ0ZXIgY3RybF9sb3NzX3RtbyBraWNrcyBpbi4KCkFuZCBfbm90aGluZ18g
d2lsbCBmaXggdGhhdCBleGNlcHQgYSBzeXN0ZW0gcmVib290LgoKX1RoYXRfIGlzIHRoZSBpc3N1
ZSB0aGlzIHBhdGNoIGZpeGVzLgoKVGhlIG90aGVyIHBhdGNoIGZvciBzZW5kaW5nIHRoZSB1ZXZl
bnQgaXMganVzdCB0byB0ZWxsIE1EIHRoYXQgcmVjb3ZlcnkKY2FuIHN0YXJ0LiBCdXQgcmVjb3Zl
cnkgX2Nhbm5vdF8gc3RhcnQgd2l0aG91dCB0aGlzIHBhdGNoLgoKPiAKPiBJIHJlYWxseSBkbyBu
b3QgdGhpbmsgd2Ugc2hvdWxkIGNoYW5nZSB0aGUgbXBhdGggYmVoYXZpb3JzIHllYXJzIGFmdGVy
Cj4gZmlyc3QgYWRkaW5nIGl0Lgo+IAoKQnV0IG9ubHkgYmVjYXVzZSBuby1vbmUgZXZlciB0ZXN0
ZWQgTUQgb24gbnZtZS1tdWx0aXBhdGguCkl0IGhhcyBiZWVuIGJyb2tlbiBzaW5jZSBkYXkgMS4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJuZWwg
U3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3
NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBOw7xy
bmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
