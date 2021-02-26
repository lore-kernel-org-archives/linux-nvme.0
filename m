Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F7C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:24:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AED664F3D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AED664F3D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=STtg/kQEx+2iutLIKMtAjiyWJAfMwYOtNDOXnCF6QGg=; b=TVBDijzMWL4zU1A9EfUaiu2vU
	6y0NgwJzR/OIPwXKgqOcdaq9+ONKCAe0MlrIrNu9h95sF4PZzDJBHuLD8HlrWiInl+VxRM8p+nniv
	Z6qqM8XceQVohz2UBCvSobA9Kn+rsXgeGjDY0jgdor/UqhetTVhqvKOUXyS0xwRMBmTZ15jBl72uQ
	DzM/UnHfbJAZGuIAzf5l2nX12QOQVLK32tIof4HPWhJl5LANpwg/Xhfwe7ycaI1hKYvhZbdrG3+cP
	Q/WKT4ELoP4d2a4iFG44+7pP9PZdrp5P/mj/qDUaDkGzQ2VRy0bFrlUW4jJretXPuClWaMbg7wNdI
	v8p8UUN+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFZMh-0004EP-DX; Fri, 26 Feb 2021 09:24:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFZMe-0004Dw-5v
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 09:24:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D8372AC6E;
 Fri, 26 Feb 2021 09:24:46 +0000 (UTC)
Subject: Re: [PATCH 1/4] nvme: simplify error logic in nvme_validate_ns()
To: Daniel Wagner <dwagner@suse.de>
References: <20210226071728.106923-1-hare@suse.de>
 <20210226071728.106923-2-hare@suse.de>
 <20210226091001.jywzp35yjpr6ng4d@beryllium.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7f70f597-17aa-dd09-cb02-fed3172749bb@suse.de>
Date: Fri, 26 Feb 2021 10:24:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226091001.jywzp35yjpr6ng4d@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_042448_433587_5935C6E3 
X-CRM114-Status: GOOD (  21.17  )
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
Cc: Keith Busch <kbusch@kernel.org>, Keith Busch <keith.busch@wdc.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNi8yMSAxMDoxMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBIaSBIYW5uZXMsCj4g
Cj4gT24gRnJpLCBGZWIgMjYsIDIwMjEgYXQgMDg6MTc6MjVBTSArMDEwMCwgSGFubmVzIFJlaW5l
Y2tlIHdyb3RlOgo+PiBAQCAtNDA0NSw3ICs0MDQ1LDcgQEAgc3RhdGljIHZvaWQgbnZtZV92YWxp
ZGF0ZV9ucyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBudm1lX25zX2lkcyAqaWRzKQo+PiAg
IAlpZiAocmV0KQo+PiAgIAkJZ290byBvdXQ7Cj4+ICAgCj4+IC0JcmV0ID0gLUVOT0RFVjsKPj4g
KwlyZXQgPSBOVk1FX1NDX0lOVkFMSURfTlMgfCBOVk1FX1NDX0ROUjsKPj4gICAJaWYgKCFudm1l
X25zX2lkc19lcXVhbCgmbnMtPmhlYWQtPmlkcywgaWRzKSkgewo+PiAgIAkJZGV2X2Vycihucy0+
Y3RybC0+ZGV2aWNlLAo+PiAgIAkJCSJpZGVudGlmaWVycyBjaGFuZ2VkIGZvciBuc2lkICVkXG4i
LCBucy0+aGVhZC0+bnNfaWQpOwo+PiBAQCAtNDA2Myw3ICs0MDYzLDcgQEAgc3RhdGljIHZvaWQg
bnZtZV92YWxpZGF0ZV9ucyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBudm1lX25zX2lkcyAq
aWRzKQo+PiAgIAkgKgo+PiAgIAkgKiBUT0RPOiB3ZSBzaG91bGQgcHJvYmFibHkgc2NoZWR1bGUg
YSBkZWxheWVkIHJldHJ5IGhlcmUuCj4+ICAgCSAqLwo+PiAtCWlmIChyZXQgJiYgcmV0ICE9IC1F
Tk9NRU0gJiYgIShyZXQgPiAwICYmICEocmV0ICYgTlZNRV9TQ19ETlIpKSkKPj4gKwlpZiAocmV0
ID4gMCAmJiAocmV0ICYgTlZNRV9TQ19ETlIpKQo+PiAgIAkJbnZtZV9uc19yZW1vdmUobnMpOwo+
IAo+IEkgdGhpbmsgQ2hhbydzIGNvbW1lbnQgc3RpbGwgaG9sZHMsIG52bWVfdXBkYXRlX25zX2lu
Zm8oKSBjYW4gcmV0dXJuCj4gLUVJTlZBTCwgLUlFTyBvciAtRU5PREVWLiBEb24ndCB3ZSBoYXZl
IHRvIHJlbW92ZSB0aGUgTlMgaW4gdGhlc2UKPiBjYXNlcz8KPiAKSSB0aG91Z2h0IEkgaGFkIGZp
eGVkIHVwIGFsbCBpbnN0YW5jZXMgd2hlcmUgd2UgY2FuIHJldHVybiAtRU5PREVWOyBhbmQgCmFs
bCBvdGhlcnMgYXJlIGluZGVlZCB0cmFuc3BvcnQgb3IgdHJhbnNpZW50IGVycm9yIHdoaWNoIHNo
b3VsZCBub3QgCnJlc3VsdCBpbiBhIG5hbWVzcGFjZSByZW1vdmFsLgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
