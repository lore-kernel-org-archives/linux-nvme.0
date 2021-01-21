Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:41:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4692523788
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4692523788
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9+YKTOeHo/bkC5CIHE+t13AGTRn48F7a4KNcl+KRwEE=; b=g9n0QEaQT+ebvjw/RgiFSAsgt
	IiIx3iiIME+AGxO177VrWJRToxJCkZZeDaosdQQhoraidvNjetLOHKSs/2M+lOCTOjBxmK2mdh2w7
	+oer++asGoXoA7PDqCGjqmxBxIZO+DNos0uaiapMY2MU8ZfQazd47E5ISktTrRFDqQZ/2PjCJ21Uz
	cRk5Pa8fbwusi6gix9slOl5fSC4l0mCNpupmLvdA+iHyM29sZUG0vjOR8WzXDUepQ8EFcXCdsPuJp
	QQ5zrGZR/kKT9e2J1lHWxk6muwOitOQAixYLe3gSAifvvLgV/gKC7FZP6CvwyIJHSxKIAscYlqb4f
	DD1CCDiUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VWc-0006QM-4G; Thu, 21 Jan 2021 08:41:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VWY-0006Pk-Te
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 08:41:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7E4E067373; Thu, 21 Jan 2021 09:40:59 +0100 (CET)
Date: Thu, 21 Jan 2021 09:40:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 1/5] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210121084059.GA25963@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121070330.19701-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_034103_076418_6C3586B1 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVGh1LCBKYW4gMjEsIDIwMjEgYXQgMDM6MDM6MjZQTSArMDgwMCwgQ2hhbyBMZW5nIHdyb3Rl
Ogo+IG52bWUgZHJpdmVycyBuZWVkIHRvIHNldCB0aGUgc3RhdGUgb2YgcmVxdWVzdCB0byBNUV9S
UV9DT01QTEVURSB3aGVuCj4gZGlyZWN0bHkgY29tcGxldGUgcmVxdWVzdCBpbiBxdWV1ZV9ycS4K
PiBTbyBhZGQgYmxrX21xX3NldF9yZXF1ZXN0X2NvbXBsZXRlLgoKU28gSSdtIG5vdCBoYXBweSB3
aXRoIHRoaXMgaGVscGVyLiAgSXQgc2hvdWxkIGF0IGxlYXN0OgoKIGEpIGJlIG5hbWVkIGFuZCBk
b2N1bWVudGVkIHRvIG9ubHkgYXBwbHkgZm9yIHRoZSAtPnF1ZXVlX3JxIGZh0ZZsdXJlIGNhc2UK
IGIpIGNoZWNrIHRoYXQgdGhlIHJlcXVlc3QgaXMgaW4gTVFfUlFfSURMRSBzdGF0ZQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
