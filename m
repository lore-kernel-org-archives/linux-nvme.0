Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:20:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995966113E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 995966113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZrfEzXPe0YPs9v+Z94fSFSkx0HOrMDg9UYgCpcMR0so=; b=IH7F7SOqFapeng
	ee7ui7hXcuc/ZB6MHynbgmy5KVG+Q6GO6E1FRg63mAVP86OpI/FwAkF8kbDGxpnhO2nnDuRq2/+6x
	Wznh37zG/3geKCi5CbipORhwvG2k9nwzS31Vf2b6H6u6DtpXqpr4Ht+z2iis6GoEy7nRZl/a2r3C0
	ou3LI2EcI07un+ZgUG562B/+OrXjtswmHD9nsUMf9PkTBZqEww+wSpS4SvOk5Wj/vT7QF+rwXty3Y
	2JxV32c3p1jH1aTZbjvmnpdFxWnOJ256mUXymEIbqi5Eaedo0KIMiJpEOkGwCtcrxJJvXZP+8QagH
	25SocxogObrTe+knQ2fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ1nl-004G6L-81; Tue, 14 Sep 2021 06:20:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ1ni-004G5U-Jx
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:20:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5A7FD67357; Tue, 14 Sep 2021 08:20:08 +0200 (CEST)
Date: Tue, 14 Sep 2021 08:20:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: koulihong <koulihong@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe <axboe@kernel.dk>,
 kbusch <kbusch@kernel.org>, sagi <sagi@grimberg.me>,
 linux-block <linux-block@vger.kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] block: nvme: fix the NULL ptr bug in
 bio_integrity_verify_fn
Message-ID: <20210914062008.GA27421@lst.de>
References: <20210913061303.GA4324@lst.de>
 <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad51e8bf2bf04e9f9b1ff9ab36718935@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_232014_856872_1511BF49 
X-CRM114-Status: GOOD (  13.41  )
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

T24gVHVlLCBTZXAgMTQsIDIwMjEgYXQgMDY6MTU6MTlBTSArMDAwMCwga291bGlob25nIHdyb3Rl
Ogo+IElmIHdlIG1vdmUgdGhlIHRoZSBjb25kaXRpb25hbCBqdWRnbWVudCB0byBibGtfaW50ZWdy
aXR5X3VucmVnaXN0ZXIsIHdlIHNob3VsZCBkbyBzb21lCj4gY2xlYW51cCB3b3JrIGluIG1kIGFu
ZCBudm1lIG1vZHVsZXMuICBJIHdpbGwKPiBzZW5kIHRoZSB2MyBwYXRjaGVzIHR3byB3ZWVrcyBs
YXRlci4gSeKAmW0gb24gYQo+IGhvbGlkYXksIEkgaGF2ZSB0b3cgd2Vla3Mgb2ZmLgoKSWYgeW91
J3JlIGZpbmUgd2l0aCBpdCBJJ2xsIHRha2Ugb3ZlciB0aGUgc2VyaWVzIHNvIHRoYXQgd2UgY2Fu
IGdldAppdCBxdWV1ZWQgdXAuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==
