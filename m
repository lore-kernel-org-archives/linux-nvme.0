Return-Path: <SRS0=Iqha=GV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF92AC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:25:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8883022CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jan 2021 18:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8883022CA1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/f7sxun2WUzPXqkpzlDgoRVJlDSc/7AGk4hYdvULayk=; b=b1oeVDgcLtlUpfXAbhpSYSDV2
	Fl0k0DvKfqCdWcZyaVU5JAY79Cdy00Ao4kPaPBzIJkIa7w9x4p6XczNBRrafZp0iShRTm8dcUZjus
	+AoBcRf30Vj24vaNIBUScZ8+/KWTdMlA6hn4Ea/JryGysGqLI1H6GYXddzZdAzq/jx/vJcSepi8z1
	m7YGY/rwLKY0BCb5kVFh/RygQPcLtrQxuKTYZRK/LK/2Id5aCKdOhted9CEp9SlpXUlCzrUaGIfbc
	69kgGA0w47gUceGLRm4slybN18K7i1EUFTsQTdTXj115y7jJrTnGsrY/pO2TaxkbHhpACWDiIwlu3
	+71XqvL5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1ZDM-0008PQ-Ip; Mon, 18 Jan 2021 18:25:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1ZDJ-0008Oy-Pm
 for linux-nvme@lists.infradead.org; Mon, 18 Jan 2021 18:25:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A2DE96736F; Mon, 18 Jan 2021 19:25:15 +0100 (CET)
Date: Mon, 18 Jan 2021 19:25:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Message-ID: <20210118182515.GC11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
 <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_132517_958944_82E5BB9E 
X-CRM114-Status: GOOD (  12.34  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVHVlLCBKYW4gMTIsIDIwMjEgYXQgMDc6NTI6MjdBTSArMDAwMCwgRGFtaWVuIExlIE1vYWwg
d3JvdGU6Cj4gPiAKPiA+IEkgZG8gbm90IHVuZGVyc3RhbmQgdGhlIGxvZ2ljIGhlcmUsIGdpdmVu
IHRoYXQgTlZNZSBkb2VzIG5vdCBoYXZlCj4gPiBjb252ZW50aW9uYWwgem9uZXMuCj4gCj4gNTEy
ZSBTQVMgJiBTQVRBIFNNUiBkcml2ZXMgKDUxMkIgbG9naWNhbCwgNEsgcGh5c2ljYWwpIGFyZSBh
IGJpZyB0aGluZywgYW5kIGZvcgo+IHRoZXNlLCBhbGwgd3JpdGVzIGluIHNlcXVlbnRpYWwgem9u
ZXMgbXVzdCBiZSA0SyBhbGlnbmVkLiBTbyBJIHN1Z2dlc3RlZCB0bwo+IENoYWl0YW55YSB0byBz
aW1wbHkgdXNlIHRoZSBwaHlzaWNhbCBibG9jayBzaXplIGFzIHRoZSBMQkEgc2l6ZSBmb3IgdGhl
IHRhcmdldAo+IHRvIGF2b2lkIHdlaXJkIElPIGVycm9ycyB0aGF0IHdvdWxkIG5vdCBtYWtlIHNl
bnNlIGluIFpOUy9OVk1lIHdvcmxkIChlLmcuIDUxMkIKPiBhbGlnbmVkIHdyaXRlIHJlcXVlc3Rz
IGZhaWxpbmcpLgoKQnV0IGluIE5WTWUgdGhlIHBoeXNpY2FsIGJsb2NrIHNpemUgZXhwb3NlcyB0
aGUgYXRvbWljIHdyaXRlIHVuaXQsIHdoaWNoCmNvdWxkIGJlIHdheSB0b28gbGFyZ2UuICDQhmYg
d2Ugd2FudCB0byBkbyB0aGlzIGNsZWFubHkgd2UgbmVlZCB0byBleHBvc2UKYSBtaW5pbXVtIHNl
cXVlbnRpYWwgem9uZSB3cml0ZSBhbGlnbm1lbnQgdmFsdWUgaW4gdGhlIGJsb2NrIGxheWVyLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
