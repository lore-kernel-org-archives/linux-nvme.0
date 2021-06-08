Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FBC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 17:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACAD6136D
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 17:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACAD6136D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w98m6o8o3os6WsjTihUzsUPT7U6u87rH2AItBi1JiUI=; b=Ll99YKQfvW40pnwJ+7Czj+OQi+
	OlyKYqx/khsdt0pPmiwiWQjrQSZUwE4nfopDE6/Z9kMCfclrCDhadYJlcSfAVsArj1muVZta1yGH6
	zxrdEtdMkhJDJqyDP5OPNH9XTTf/nIC8wgRgeEzQc+tu0UUg3pNGybMNsBnE+IfNBisKO4hFxX/Ek
	o4tiI0IAVZNMowO03pMNfi/oIyvKplgUzYIwpak67ziaI2ONVxtCywC/hsIxrbQP5cBV4/8/f9+8y
	hvUp3+FJ6Zn19zNuMD3mqr4l0vgKc+rM/nSjsxxm4nGvrKfpNU/rGL7xPV7UUjAhH3Aiqg1YKcg+h
	F3CCyriw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqflp-009mBz-NR; Tue, 08 Jun 2021 17:44:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqflm-009mBC-Tw
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 17:44:08 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EFC31FD2A;
 Tue,  8 Jun 2021 17:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623174245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/W+ciaxSZxrnPs/R0W8VEKwH2hcdLk0OY7cGD5Z4MY=;
 b=Ivd0gwMgoXpyhoR1dYZf6ifu84nCKB2qTX82Zvg+og5D8kwqsDwLmpbf6CUr+y/3HI/T1x
 wpj/kWZS6wpqHkaNRKmeg7jtPhjRm68Rhpntel4VmH67yxKeQrW2Gr40SyLU4jlZaDazzP
 ZRanVSwNvjL7GUPrja4nhcT9cUCa21Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623174245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/W+ciaxSZxrnPs/R0W8VEKwH2hcdLk0OY7cGD5Z4MY=;
 b=LPaeJSCANqNPPLS6VFm5/qoIWNDbwxWpsAVOqF345LRgh8xAGgiun94V3Acqcs1H82tStF
 sLNgq2LUl1zLCTDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id EA665118DD;
 Tue,  8 Jun 2021 17:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623174245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/W+ciaxSZxrnPs/R0W8VEKwH2hcdLk0OY7cGD5Z4MY=;
 b=Ivd0gwMgoXpyhoR1dYZf6ifu84nCKB2qTX82Zvg+og5D8kwqsDwLmpbf6CUr+y/3HI/T1x
 wpj/kWZS6wpqHkaNRKmeg7jtPhjRm68Rhpntel4VmH67yxKeQrW2Gr40SyLU4jlZaDazzP
 ZRanVSwNvjL7GUPrja4nhcT9cUCa21Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623174245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/W+ciaxSZxrnPs/R0W8VEKwH2hcdLk0OY7cGD5Z4MY=;
 b=LPaeJSCANqNPPLS6VFm5/qoIWNDbwxWpsAVOqF345LRgh8xAGgiun94V3Acqcs1H82tStF
 sLNgq2LUl1zLCTDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id lkUuN2Ssv2CeeQAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 08 Jun 2021 17:44:04 +0000
Subject: Re: [PATCHv5] nvme: allow to re-attach namespaces after all paths are
 down
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210607133435.138525-1-hare@suse.de>
 <20210608164247.GA12430@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <02a8ca3c-3f6d-7f1d-0afd-655ab1b78f9a@suse.de>
Date: Tue, 8 Jun 2021 19:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608164247.GA12430@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_104407_141483_E0DB7FB3 
X-CRM114-Status: GOOD (  19.82  )
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

T24gNi84LzIxIDY6NDIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IFdoaWxlIEkgZG8g
bGlrZSB0aGUgbG9vaywgSSBkb24ndCBzZWUgaG93IHRoaXMgY291bGQgYWN0dWFsbHkgd29yazoK
PiAKPj4gICAJfSBlbHNlIHsKPj4gICAJCXJldCA9IC1FSU5WQUw7Cj4+IC0JCWlmICghaXNfc2hh
cmVkIHx8ICFoZWFkLT5zaGFyZWQpIHsKPj4gKwkJLyoKPj4gKwkJICogSWYgbXVsdGlwYXRoIGlz
IGVuYWJsZWQgd2UgbWlnaHQgaGl0IGFuIG5zIGhlYWQgd2l0aCBubwo+PiArCQkgKiBwYXRocywg
YnV0IHRoYXQgZG9lc24ndCBpbmRpY2F0ZSBpdCdzIGEgc2hhcmVkIG5hbWVzcGFjZS4KPj4gKwkJ
ICovCj4+ICsJCWlmICghbGlzdF9lbXB0eSgmaGVhZC0+bGlzdCkgJiYgKCFpc19zaGFyZWQgfHwg
IWhlYWQtPnNoYXJlZCkpIHsKPj4gICAJCQlkZXZfZXJyKGN0cmwtPmRldmljZSwKPj4gICAJCQkJ
IkR1cGxpY2F0ZSB1bnNoYXJlZCBuYW1lc3BhY2UgJWRcbiIsIG5zaWQpOwo+PiAgIAkJCWdvdG8g
b3V0X3B1dF9uc19oZWFkOwo+IAo+IFdoZW4gd2UgZ2V0IGhlcmUgd2l0aCBhbiBleGlzdGluZyBu
c19oZWFkIHdpdGggbm8gbmFtZXNwYWNlcyBhdHRhY2hlZAo+IHRvIGl0LCB3ZSBjYW4gYXNzdW1l
IGl0IG9uY2UgaGFkIG5hbWVzcGFjZXMgYXR0YWNoZWQgdG8gaXQuICBCZWNhdXNlCj4gb2YgdGhh
dCBOVk1FX05TSEVBRF9ESVNLX0xJVkUgd2lsbCBiZSBzZXQsIGFuZCB3ZSdsbCBuZXZlciBhZGQg
dGhlCj4gZGlzayBmb3IgaXQgYWdhaW4uICBFdmVuIGlmIHdlIGRpZCBhZGQgdGhlIGRpc2sgYWdh
aW4gd2hhdCBwcmV2ZW50cwo+IGFkZGluZyBhIGRpc2sgYW5kIHJlbW92aW5nIG9uZSBmcm9tIHJh
Y2luZyB3aXRoIGVhY2ggb3RoZXI/Cj4gCkhtbS4gSSB0aG91Z2h0IGl0IHdhcyByZXNvbHZlZCBi
eSByZWZjb3VudCBtYWdpYy4KV2lsbCBoYXZlIGEgY2xvc2VyIGxvb2sgdG8gY2hlY2sgd2hhdCBu
ZWVkcyB0byBiZSBkb25lLgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
