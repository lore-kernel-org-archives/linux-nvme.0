Return-Path: <SRS0=yzsN=CB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C08AC433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:09:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AED02072D
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2020 09:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gNtSiB7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AED02072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Kc0Nwbfqc4jgqwwKtcYSgGeDnCALgOk3vMb61YNPcB0=; b=gNtSiB7l6WfWviCbbAbLRxMFR
	s0Bbve98ijmMtDeq2s834j3uucGAeY/ST+SawxJXj2SFaHTCylpbF/WUEqNohm8cW9TJFr6H7+852
	OBjziuJvWty+T4144U0ymQn4lfHqZ0ypI1PM8tH69EkgwwUh+jeg9mTW/WlIe6N+TH8JIM/UoQfVH
	F0sImUwa3AIWpk7iRvSDKLdFvAPL51PTmkz2rxAMR6RyblrHjKgtehhaTw7KhHRdjyZ6FkELS4Kyj
	HGs+Bqflpg0U3Qf19rIOBFDzXcs19GoHrQG4R/NfoWIOa8nxUnk+j+3Bgv8rvmBOalgxyyYCeRNfp
	FXT03aqqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9m0G-0007xS-5D; Sun, 23 Aug 2020 09:09:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9m0A-0007wY-0S
 for linux-nvme@lists.infradead.org; Sun, 23 Aug 2020 09:09:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9836468AFE; Sun, 23 Aug 2020 11:09:15 +0200 (CEST)
Date: Sun, 23 Aug 2020 11:09:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?55Sw?= <xianting_tian@126.com>
Subject: Re: [PATCH 2/2] block: fix locking for struct block_device size
 updates
Message-ID: <20200823090915.GA2764@lst.de>
References: <20200821085600.2395666-1-hch@lst.de>
 <20200821085600.2395666-3-hch@lst.de>
 <4df016bc-570c-d166-47dd-36a9f21fad13@suse.de>
 <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <133efc8b.1649.17410784734.Coremail.xianting_tian@126.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200823_050922_165725_56D0476D 
X-CRM114-Status: UNSURE (   9.44  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Jan Hoeppner <hoeppner@linux.ibm.com>, Justin Sanders <justin@coraid.com>,
 Josef Bacik <josef@toxicpanda.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Hannes Reinecke <hare@suse.de>,
 "nbd@other.debian.org" <nbd@other.debian.org>, Christoph Hellwig <hch@lst.de>,
 Stefan Haberland <sth@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgMDY6MDI6MzJQTSArMDgwMCwg55SwIHdyb3RlOgo+IHRo
YW5rcyBIZWxsd2lnIGZvciB5b3VyIGtpbmRseSByZXBseSBhbmQgeW91ciBmaXggYW5kIGFkZCBy
ZXBvcnQgYnkgbWUgOikKCkkgZm91bmQgYW4gaXNzdWUgd2l0aCB0aGUgcGF0Y2gsIGFuZCB3aWxs
IHNlbmQgYSBuZXcgdmVyc2lvbiBpbiBhIGJpdC4KSWYgdGhpcyB3b3JrcyBmb3IgeW91ciByZXBy
b2R1Y2VyLCBjYW4geW91IGFkZCBhIFRlc3RlZC1ieTogdGFnPwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
