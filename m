Return-Path: <SRS0=EhmY=HP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D9C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 08:43:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AE564E52
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 08:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE564E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NOjiTxXJWX2zWHkV7flM3NgcPiMf2bHj+nsQw7o9zUU=; b=g86NsxOZOAJlp/P3Ycw5+go8/
	vbxYPtETg6DEZfQbNyznDRuIrDZYfbgQyeVMO6Ao6I6OpuHy7DvzegNjfDqRIE16SUNrToPnth4SV
	pNKWMQy29miA1wxGo4W8pnCTHYEtagMwlmWiMmVBY3QL1QTkXSSMLlv7eudIv1TjLa5btI6ss8QRO
	QeYGGXkkEfPqwUUK9YDUheSrwZqQRlXp20BTNCyKNz5t6+h8ojJIJDncqm7fxvsNjP1nj3BIm058W
	XJk+HGroxzNYZGFkXQ8du9Ie73oLZE0i64Hokfv2k0FEQp8Ftz+4PD8KluAnw7LET2hFI2YNv0pOX
	TGL2Bx9Hg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAqVw-00059s-P0; Sat, 13 Feb 2021 08:42:52 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAqVt-00059P-Rq
 for linux-nvme@lists.infradead.org; Sat, 13 Feb 2021 08:42:50 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5F7D1AC32;
 Sat, 13 Feb 2021 08:42:47 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210212181738.79274-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3f183393-cc1e-3d03-3074-40c18f3cb9cc@suse.de>
Date: Sat, 13 Feb 2021 09:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212181738.79274-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210213_034250_044789_22CF4821 
X-CRM114-Status: GOOD (  18.94  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xMi8yMSA3OjE3IFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IGJsa19tcV90YWdfdG9f
cnEoKSB3aWxsIGFsd2F5cyByZXR1cm4gYSByZXF1ZXN0IGlmIHRoZSBjb21tYW5kX2lkIGlzCj4g
aW4gdGhlIHZhbGlkIHJhbmdlLiBDaGVjayBpZiB0aGUgcmVxdWVzdCBoYXMgYmVlbiBzdGFydGVk
LiBJZiB3ZQo+IGJsaW5kbHkgcHJvY2VzcyB0aGUgcmVxdWVzdCB3ZSBtaWdodCBkb3VibGUgY29t
cGxldGUgYSByZXF1ZXN0IHdoaWNoCj4gY2FuIGJlIGZhdGFsLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPiAtLS0KPiAKPiBUaGlzIHBhdGNoIGlz
IGFnYWluc3QgbnZtZS01LjEyLgo+IAo+IFRoZXJlIGlzIG9uZSBibGtfbXFfdGFnX3RvX3JxKCkg
aW4gbnZtZV90Y3BfcmVjdl9kZGdzdCgpIHdoaWNoIEkKPiBkaWRuJ3QgdXBkYXRlIGFzIEkgYW0g
bm90IHN1cmUgaWYgaXQncyBhbHNvIG5lZWRlZC4KPiAKSSBndWVzcyBpdCBpczsgdGhpcyBwYXRj
aCBpcyBlc3NlbnRpYWxseSBhIHByb3RlY3Rpb24gYWdhaW5zdCBpbnZhbGlkIApmcmFtZXMsIGFu
ZCBhcyBzdWNoIGFmZmVjdHMgYWxsIHBsYWNlcy4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
