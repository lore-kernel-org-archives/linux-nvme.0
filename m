Return-Path: <SRS0=k3Et=EK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B3C2D0A3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:46:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB74F20780
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TOpvyOWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB74F20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ESapiHyAG3eUBTKyW/DKMVirab/4a03UlwkrTbKkDKE=; b=TOpvyOWrM5lbHnOzNr+/Y0CYZ
	PvXdlYvXtcJoo9anHPrOuUYXWKIEFouGoPKvRZucmAYw+RC+JESaUkxsMZfRxVKpiqVfqyAzsZDaw
	y2foiZBl6EET5qKOmDHWdLqCAP5XOvXTbHpOCZWYGYFMeVexW+gxEedHb6E2ppOZBTvWb+aWNm3bc
	xhs3ZJMdeIneMBEnLMz3hSNc3qSqcUFUYzZKZN0bJusFe24VOVypd04zoM0+5Bydi7WOhwiNfvG6S
	X5Zj4R8qdudWh3SvL8IxC2/Qe3zF0ghT8ecKZr31YYUKDnM/dPSp0yYspq3EoZSY6gFmYeAK/gP2W
	r1E2S50VA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaK38-0005vW-8j; Wed, 04 Nov 2020 14:46:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaK33-0005tM-Qn
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 14:46:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9CC31AC54;
 Wed,  4 Nov 2020 14:46:04 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
To: "hch@lst.de" <hch@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de> <20201104142908.GA7941@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <01c72262-1839-05cc-ba9a-94b260511a7c@suse.de>
Date: Wed, 4 Nov 2020 15:46:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201104142908.GA7941@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_094606_058441_C3457F88 
X-CRM114-Status: GOOD (  18.27  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvNC8yMCAzOjI5IFBNLCBoY2hAbHN0LmRlIHdyb3RlOgo+IE9uIFdlZCwgTm92IDA0LCAy
MDIwIGF0IDAzOjI2OjQ2UE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gSSBoYXJk
bHkgZGFyZSB0byBtZW50aW9uIGJzZyBoZXJlOyBidXQgdGhlIGlzIHByZXR0eSBzaW1pbGFyIHRv
IHdoYXQgaXQgc2V0Cj4+IG91dCB0byBkbyAuLi4KPiAKPiBFeGNlcHQgdGhhdDoKPiAKPiAgIGEp
IHdlIGNyZWF0ZWQgYSBjb21wbGV0ZSBtZXNzIHdpdGggYnNnIGJ5IG92ZXJsb2FkaW5nIHRoZSBz
Y3NpIGlvY3Rscwo+ICAgICAgd2l0aCBzb21lIG9mIHRoZSB0cmFuc3BvcnQgc3R1ZmYuCj4gICBi
KSBic2cgd291bGQgbm90IHdvcmsgd2l0aCBleGlzdGluZyB0b29scy4gIEEgY2hhcmFjdGVyIGRl
dmljZSB0aGF0Cj4gICAgICBhY2NlcHRzIHRoZSBzYW1lIGlvY3RsIHdpbGwganVzdCB3b3JrLgo+
IAouLi4gYXMgd291bGQgYSBic2cgZGV2aWNlIHdoaWNoIGNvdWxkIGFjY2VwdCBzYWlkIGlvY3Rs
IC4uLgoKUGx1cyBpdCBmZWVscyBhIGJpdCB3ZWlyZCwgaGF2aW5nIGEgZ2VuZXJpYyBjb21tYW5k
IHBhc3N0aHJvdWdoIApjaGFyYWN0ZXIgZGV2aWNlIHdoaWNoIGlzIHRoZW4gYXZvaWRlZCBpbiBm
YXZvdXIgb2YgYSBwcm90b2NvbC1zcGVjaWZpYyAKY29tbWFuZCBwYXNzdGhyb3VnaCBkZXZpY2Uu
CldoaWNoIHdlIGhhZCBiZWVuIGFyZ3VpbmcgZm9yIHllYXJzIHdpdGggSUhWcyBmb3IgX25vdF8g
ZG9pbmcgaXQuClNvIHdoYXQgaXMgZGlmZmVyZW50IGhlcmU/CgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0
ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBG
ZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
