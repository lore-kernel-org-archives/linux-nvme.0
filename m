Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7017BC2B9F7
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:03:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219806139A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219806139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5ftFi2PdOzxPhx5o0XU4DcufnDHJiBtBGZ9DalPc/Tw=; b=5FTQyW0/u4nGymLWHWr48m+Ofr
	FqFFv530G9t4vcc7i+V3Mh0SX9AgU6niDMuEniLiu0satBLlQmWaxYjhXWa8hA15GrJUZdmQs/myG
	t9NFLSYLriN28MWkv0r38fF1rA+UuCOAZkZAdYEnlBQIBOxo1MfpHqOumIg1clsu5Iq+CJ3viSoDv
	CNjIw4LYGrlW1Gk1b370zurHo9NhzfTVAgdi5U6C/BOLIAdBM/WO7ojzs7VNWGviYlb/2m3B+AC/D
	xAc13plMmEaFZ/14OL9+7IhMofog9j4hOc3QfvhHnQEnwxj2A6MJbjOk4EGNjAa5P7hgVvcJ/D4X+
	zb5jtC2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmc98-00Fc14-Ua; Fri, 28 May 2021 13:03:27 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmbqC-00FTm5-Va
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 12:43:54 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83ED7218B0;
 Fri, 28 May 2021 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622205831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9149hCgfbgoOSRiZegk8lB/vSzOp0MQZkv6jiH0Plw=;
 b=ODCx2CkGHdfINdzSRdKAW5OI7cYyaUoWdu8QkEX7F7IK4J7fTbqKE5ZyDZFfbRvbEHF2jV
 4m0YUq6/bW3prYp1A2x/SdIOTtjIZfweurmJqQx1aKawMi6DdpNiXEEJqJ8pw4/0C/Hs0l
 NZQqcp/uMJj7n1EgXJa+Re9I77so714=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622205831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9149hCgfbgoOSRiZegk8lB/vSzOp0MQZkv6jiH0Plw=;
 b=h+0kGL7+sh5bdN7sRbT8rPI2I7p55aNv8ABwbRA2+CxD8I79XopWQ1ryKtZt/cduxUSe/M
 EHyDxFuRLNWygPDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 464AF11A98;
 Fri, 28 May 2021 12:43:51 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 0PF5EIflsGCfMAAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 12:43:51 +0000
Subject: Re: [RFC PATCH v6 14/27] qed: Add NVMeTCP Offload IO Level FW
 Initializations
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-15-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <7591803b-63b5-5e40-d4fe-4cc0b9ce9c10@suse.de>
Date: Fri, 28 May 2021 14:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-15-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_054353_221320_02F027CD 
X-CRM114-Status: GOOD (  15.20  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyB0aGUgTlZNZVRDUCBGVyBpbml0aWFsaXphdGlvbnMgd2hpY2ggaXMgdXNlZAo+IHRvIGlu
aXRpYWxpemUgdGhlIElPIGxldmVsIGNvbmZpZ3VyYXRpb24gaW50byBhIHBlciBJTyBIVwo+IHJl
c291cmNlICgidGFzayIpIGFzIHBhcnQgb2YgdGhlIElPIHBhdGggZmxvdy4KPiAKPiBUaGlzIGlu
Y2x1ZGVzOgo+IC0gV3JpdGUgSU8gRlcgaW5pdGlhbGl6YXRpb24KPiAtIFJlYWQgSU8gRlcgaW5p
dGlhbGl6YXRpb24uCj4gLSBJQy1SZXEgYW5kIElDLVJlc3AgRlcgZXhjaGFuZ2UuCj4gLSBGVyBD
bGVhbnVwIGZsb3cgKEZsdXNoIElPKS4KPiAKPiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1
c3NraWtoQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8
cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxv
a3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGlu
QG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8bWthbGRlcm9u
QG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVs
bC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvTWFrZWZpbGUg
ICAgICB8ICAgNSArLQo+ICBkcml2ZXJzL25ldC9ldGhlcm5ldC9xbG9naWMvcWVkL3FlZF9udm1l
dGNwLmMgfCAgIDcgKy0KPiAgLi4uL3Fsb2dpYy9xZWQvcWVkX252bWV0Y3BfZndfZnVuY3MuYyAg
ICAgICAgIHwgMzc5ICsrKysrKysrKysrKysrKysrKwo+ICAuLi4vcWxvZ2ljL3FlZC9xZWRfbnZt
ZXRjcF9md19mdW5jcy5oICAgICAgICAgfCAgNDMgKysKPiAgaW5jbHVkZS9saW51eC9xZWQvbnZt
ZXRjcF9jb21tb24uaCAgICAgICAgICAgIHwgICAxICsKPiAgaW5jbHVkZS9saW51eC9xZWQvcWVk
X252bWV0Y3BfaWYuaCAgICAgICAgICAgIHwgIDIwICsKPiAgNiBmaWxlcyBjaGFuZ2VkLCA0NTMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9xZWQvcWVkX252bWV0Y3BfZndfZnVuY3MuYwo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvcWxvZ2ljL3FlZC9xZWRfbnZtZXRj
cF9md19mdW5jcy5oCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkx
MSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCA5MDQwOSBO
w7xybmJlcmcKR0Y6IEYuIEltZW5kw7ZyZmZlciwgSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
