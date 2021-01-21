Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB531C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:26:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AA423975
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AA423975
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:From:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=97f8sXc7FxA3gZqk3wBNpBHxqeRrznzZRKXpN4I6SOs=; b=uDkbQN83IYEars
	K+Q69jV3SwtvEa3PId6mS5oKnCFxGBORJAk9VttVJTfkTdYbS2YmaNrVXkaRVlqYuHzoUC6/DPcXR
	vw9UCrFVCzV0mIMK7VrychUcbcEfVfXANHvQ0bsWojBBdOme9TkUyq80f/WVLF26f3d9MpwuSzFUt
	XFGcMvdEdydsX35gVtXvu19pLA/pxKtDX/6QX9ZhLAU50Lmzs4LBVeVvBeGfxJ3phUhrW9SrJdSLZ
	xQbz3DLY9JxBNJyzmX3Cg2M3yl+kPdZMPeJW/L3N8zOtRhgaZL9/5htUiZpHihu0Hfzbj2qd+bnJ/
	eMsvce8eRjTS8A0pSzbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VHj-0003Sv-Mt; Thu, 21 Jan 2021 08:25:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VHh-0003SJ-Ga
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:25:42 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 56BF9AAAE;
 Thu, 21 Jan 2021 08:25:40 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: kernel oops after nvme_set_queue_count()
Message-ID: <d5f00c36-2981-0a0c-7a6d-b4ab2c8d139e@suse.de>
Date: Thu, 21 Jan 2021 09:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_032541_702506_677367BC 
X-CRM114-Status: GOOD (  17.87  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgYWxsLAoKYSBjdXN0b21lciBvZiBvdXJzIHJhbiBpbnRvIHRoaXMgb29wczoKCls0NDE1Ny45
MTg5NjJdIG52bWUgbnZtZTU6IEkvTyAyMiBRSUQgMCB0aW1lb3V0Cls0NDE2My4zNDc0NjddIG52
bWUgbnZtZTU6IENvdWxkIG5vdCBzZXQgcXVldWUgY291bnQgKDg4MCkKWzQ0MTYzLjM0NzU1MV0g
bnZtZSBudm1lNTogU3VjY2Vzc2Z1bGx5IHJlY29ubmVjdGVkICg2IGF0dGVtcHRzKQpbNDQxNjgu
NDE0OTc3XSBCVUc6IHVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IApm
ZmZmODg4ZTI2MWU3ODA4Cls0NDE2OC40MTQ5ODhdIElQOiAweGZmZmY4ODhlMjYxZTc4MDgKWzQ0
MTY4LjQxNDk5NF0gUEdEIDk4YzJhZTA2NyBQNEQgOThjMmFlMDY3IFBVRCBmNTc5MzcwNjMgUE1E
IAo4MDAwMDAwZjY2MDAwMWUzCgpJdCdzIHJlbGF0ZWQgdG8gdGhpcyBjb2RlIHNuaXBwZXQgaW4g
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCgoJLyoKCSAqIERlZ3JhZGVkIGNvbnRyb2xsZXJzIG1p
Z2h0IHJldHVybiBhbiBlcnJvciB3aGVuIHNldHRpbmcgdGhlIHF1ZXVlCgkgKiBjb3VudC4gIFdl
IHN0aWxsIHdhbnQgdG8gYmUgYWJsZSB0byBicmluZyB0aGVtIG9ubGluZSBhbmQgb2ZmZXIKCSAq
IGFjY2VzcyB0byB0aGUgYWRtaW4gcXVldWUsIGFzIHRoYXQgbWlnaHQgYmUgb25seSB3YXkgdG8g
Zml4IHRoZW0gdXAuCgkgKi8KCWlmIChzdGF0dXMgPiAwKSB7CgkJZGV2X2VycihjdHJsLT5kZXZp
Y2UsICJDb3VsZCBub3Qgc2V0IHF1ZXVlIGNvdW50ICglZClcbiIsIHN0YXR1cyk7CgkJKmNvdW50
ID0gMDsKCgpjYXVzaW5nIG52bWVfc2V0X3F1ZXVlX2NvdW50KCkgX25vdF8gdG8gcmV0dXJuIGFu
IGVycm9yLCBidXQgcmF0aGVyIGxldCAKdGhlIHJlY29ubmVjdCBjb21wbGV0ZS4KT2YgY291cnNl
LCBhcyB0aGlzIGZhaWx1cmUgaXMgZHVlIHRvIGEgdGltZW91dCAoY2YgdGhlIHN0YXR1cyBjb2Rl
OyA4ODAKaXMgTlZNRV9TQ19IT1NUX1BBVEhfRVJST1IpLCB0aGUgYWRtaW4gcXVldWUgaGFzIGJl
ZW4gdG9ybiBkb3duIGJ5IHRoZSAKdHJhbnNwb3J0LCBjYXVzaW5nIHRoaXMgY3Jhc2guCgpTbywg
cXVlc3Rpb246IF93aHlfIGRvIHdlIGlnbm9yZSB0aGUgc3RhdHVzPwoKRm9yIGZhYnJpY3MgSSBj
b21wbGV0ZWx5IGZhaWwgdG8gc2VlIHRoZSByZWFzb24gaGVyZTsgZXZlbiBfaWZfIGl0IAp3b3Jr
ZWQgd2Ugd291bGQgZW5kIHVwIHdpdGggYSBjb25uZWN0aW9uIGZvciB3aGljaCBqdXN0IHRoZSBh
ZG1pbiBxdWV1ZSAKaXMgb3BlcmFibGUsIHRoZSBzdGF0ZSBpcyBMSVZFLCBhbmQgYWxsIGluZm9y
bWF0aW9uIHdlIGNvdWxkIGdsYW5jZSAKd291bGQgaW5kaWNhdGUgdGhhdCB0aGUgY29ubmVjdGlv
biBpcyBwZXJmZWN0bHkgaGVhbHRoeS4KSXQganVzdCBkb2Vzbid0IGhhdmUgYW55IEkvTyBxdWV1
ZXMuCldoaWNoIHdpbGwgbGVhZCB0byBzb21lIHZlcnkgY29uZnVzZWQgY3VzdG9tZXJzIGFuZCBz
b21lIHZlcnkgdW5oYXBweSAKc3VwcG9ydCBmb2xrcyB0cnlpbmcgdG8gZmlndXJlIG91dCB3aGF0
IGhhcyBoYXBwZW5lZC4KCkNhbiB3ZSBqdXN0IGtpbGwgdGhpcyBzdGF0ZW1lbnQgYW5kIGFsd2F5
cyByZXR1cm4gYW4gZXJyb3I/CkluIGFsbCBvdGhlciBjYXNlcyB3ZSBhcmUgcXVpdGUgdHJpZ2dl
ci1oYXBweSB3aXRoIGNvbnRyb2xsZXIgcmVzZXQ7IHdoeSAKbm90IGhlcmU/CgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
