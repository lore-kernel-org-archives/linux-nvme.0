Return-Path: <SRS0=k3Et=EK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCFCC2D0A3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:27:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAB0206E3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2020 14:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d90ARs0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAB0206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0cG4YMLucqIbBdbNy+uBtCZS4FgInhC3nnAho29iMCk=; b=d90ARs0ei8AXvbP68ST2nByUz
	gTb7yNkpBCHXb5jGP0/fuRkffGUVjEaG0zEoX9Op6EJAA89cECmDeBCY+tc5QoRrpmhNm/LmY4eRn
	kw5Uqv9WdMp0uk7lAlgnOIWzRAPOgMEpBrkPR/ROhjxYxC4pCw6VmIy32bDHYAcCZ8w46AV3Vcq07
	uovKTctSiLs15b1KdboWhIBTzWRdrqItB0EuWNYqeU8KqKz/862RMikgKqoQBxyvfZ2MFLyZQYgG2
	gTBRLDr9yXoubTzq74NUz9HYdpLTxpshwITBLLjmY5/eySKk7TWRTrlsoMMYED29Rm06w68hh5ply
	EzZF1zHkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaJkV-0002xP-KQ; Wed, 04 Nov 2020 14:26:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaJkQ-0002wl-HA
 for linux-nvme@lists.infradead.org; Wed, 04 Nov 2020 14:26:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 13DBFAD5D;
 Wed,  4 Nov 2020 14:26:47 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
To: "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de>
Date: Wed, 4 Nov 2020 15:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102185851.GA21349@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201104_092650_688374_811F3A2E 
X-CRM114-Status: GOOD (  21.71  )
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
 Javier Gonzalez <javier.gonz@samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMi8yMCA3OjU4IFBNLCBoY2hAbHN0LmRlIHdyb3RlOgo+IE9uIE1vbiwgTm92IDAyLCAy
MDIwIGF0IDEwOjMzOjU1QU0gLTA4MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBJIGNhbiBzZWUg
dGhpcyBnb2luZyBvbmUgb2YgdHdvIHdheXM6Cj4+Cj4+ICAgYSkgU2V0IHVwIHRoZSBleGlzdGlu
ZyBjb250cm9sbGVyIGNoYXJhY3RlciBkZXZpY2Ugd2l0aCBhIGdlbmVyaWMKPj4gICAgICBkaXNr
LWxlc3MgcmVxdWVzdF9xdWV1ZSB0byB0aGUgSU8gcXVldWVzIGFjY2VwdGluZyBJTyBjb21tYW5k
cyB0bwo+PiAgICAgIGFyYml0cmFyeSBOU0lEcy4KPj4KPj4gICBiKSBFYWNoIG5hbWVzcGFjZSB0
aGF0IGNhbid0IGJlIHN1cHBvcnRlZCBnZXRzIHRoZWlyIG93biBjaGFyYWN0ZXIKPj4gICAgICBk
ZXZpY2UuCj4+Cj4+IEknbSBsZWFuaW5nIHRvd2FyZCBvcHRpb24gImEiLiBXaGlsZSBpdCBkb2Vz
bid0IGNyZWF0ZSBoYW5kbGVzIHRvIHVuaXF1ZQo+PiBuYW1lc3BhY2VzLCBpdCBoYXMgbW9yZSBy
ZXNpbGllbmNlIHRvIHBvdGVudGlhbGx5IGZ1dHVyZSBjaGFuZ2VzLiBBbmQgSQo+PiByZWNhbGwg
dGhlIHRhcmdldCBzaWRlIGhhZCBhIHBvdGVudGlhbCB1c2UgZm9yIHRoYXQsIHRvby4KPiAKPiBU
aGUgcHJvYmxlbSB3aXRoIGEpIGlzIHRoYXQgaXQgY2FuJ3QgYmUgdXNlZCB0byBnaXZlIHVzZXJz
IG9yIGdyb3Vwcwo+IGFjY2VzcyB0byBqdXN0IG9uZSBuYW1lc3BhY2VzLCBzbyBpdCBjYXVzZXMg
YSByZWFsIGFjY2VzcyBjb250cm9sCj4gbmlnaHRtYXJlLiAgVGhlIHByb2JsZW0gd2l0aCBiKSBp
cyB0aGF0IG5vdyBhcHBsaWNhdGlvbnMgd2lsbCBicmVhawo+IHdoZW4gd2UgYWRkIHN1cHBvcnQg
Zm9yIG5ldyBjb21tYW5kIHNldHMgb3IgZmVhdHVyZXMuICBJIHRoaW5rCj4gCj4gICAgYykgRWFj
aCBuYW1lc3BhY2UgZ2V0cyBpdHMgb3duIGNoYXJhY3RlciBkZXZpY2UsIHBlcmlvZC4KPiAKPiBp
cyB0aGUgb25seSBzZW5zaWJsZSBvcHRpb24uCj4gCkkgaGFyZGx5IGRhcmUgdG8gbWVudGlvbiBi
c2cgaGVyZTsgYnV0IHRoZSBpcyBwcmV0dHkgc2ltaWxhciB0byB3aGF0IGl0IApzZXQgb3V0IHRv
IGRvIC4uLgoKT3IgeWV0IGFub3RoZXIgaW50ZXJmYWNlPwoKQ2hlZXJzLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUz
IDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVs
aXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
