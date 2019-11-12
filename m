Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0890DC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 15:08:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6DD2067B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQb9JsnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6DD2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sQmg3T4O7JMnROdUQb164eBfXVu+H6JQBem1yhmDQPk=; b=gQb9JsnOsbIlAX
	WbJZNbIpmhn/z18LEcyHjxFRbzns4N1j68FxoTaWD6zkOqoUHgEm+kNKTaaoXn33qUjXU8xRWnUdC
	srACYwlQwBb8Sl8UtE01se/qq3eYPufAe5bBF7OQpUBHs1KL5ZU9vbVNt9Up/j1vnH7jqNjCwK3Ns
	jm6AmtK5yVLCZNv8r0X/F+V0kbjkEVN1acdk3uFn2d+x+8+ijxbqhLaJVfT5xAktOlZAK+/SoZ9q2
	+5rKrwPRfcuFstsbhrUJZogYT7G5snzB4BEd+Q5q2/NI+lSEEFt40wlXgEcicmwpAOhDsVwE7t1je
	W/2a+16E17HyPSg0PgRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUXml-0007nf-UT; Tue, 12 Nov 2019 15:08:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUXmh-0007n4-PX
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 15:08:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9140D68BE1; Tue, 12 Nov 2019 16:08:45 +0100 (CET)
Date: Tue, 12 Nov 2019 16:08:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values
 for each sensor
Message-ID: <20191112150845.GA12550@lst.de>
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <20191111165306.GA19814@lst.de>
 <CAC5umyi97UJZzk+4soD+th0BZ71WfnOqnTWWuTYKyo6aWTdLXA@mail.gmail.com>
 <20191112142127.GA11580@lst.de>
 <CAC5umygX=uBQsWV8O=9NL3HeVNo_iMcq7BE-vA-wpQtyU5iV3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAC5umygX=uBQsWV8O=9NL3HeVNo_iMcq7BE-vA-wpQtyU5iV3Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_070849_492719_72B131E9 
X-CRM114-Status: UNSURE (   8.19  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgMTI6MDA6MjJBTSArMDkwMCwgQWtpbm9idSBNaXRhIHdy
b3RlOgo+IDIwMTnlubQxMeaciDEy5pelKOeBqykgMjM6MjEgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+Ogo+ID4KPiA+IE9uIFR1ZSwgTm92IDEyLCAyMDE5IGF0IDExOjE5OjQ2UE0gKzA5
MDAsIEFraW5vYnUgTWl0YSB3cm90ZToKPiA+ID4gT0suIEknbGwgYWRkIHR3byBtYWNyb3MuCj4g
PiA+Cj4gPiA+ICNkZWZpbmUgTUlMTElDRUxTSVVTX1RPX0tFTFZJTih0KSAoKHQpIC8gMTAwMCAr
IDI3MykKPiA+ID4gI2RlZmluZSBLRUxWSU5fVE9fTUlMTElDRUxTSVVTKHQpICgoKHQpIC0gMjcz
KSAqIDEwMDApCj4gPgo+ID4gQ2FuIHlvdSBhZGQgdGhlbSB0byBsaW51eC90aGVybWFsLmggdGhh
dCBhbHJlYWR5IGhhcyBzaW1pbGFyCj4gPiBoZWxwZXJzPwo+IAo+IFNob3VsZCB3ZSBhZGQgYSBu
ZXcgbGludXgvdGVtcGVyYXR1cmUuaCBzbyB0aGF0IGFueSBvdGhlciBkcml2ZXJzIG9yCj4gc3Vi
c3lzdGVtcyAoaW5jbHVkaW5nIHRoZXJtYWwuaCBhbmQgaHdtb24uaCkgY2FuIHVzZSB0aGVzZSBt
YWNyb3M/CgpGaW5lIHdpdGggbWUuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
