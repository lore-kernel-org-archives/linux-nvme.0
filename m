Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242B960F92
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 08:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 242B960F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M4Swm+1qs+HPNwUkcPT+2LrrReS/mUnWHFteCZHyZmc=; b=sjGoMPc3Hw1gGT5O6mKjgpQYVp
	YXU0qDSm1FnkqlMGYHxKtZOfHu5y+Mvef0q5/4Tg3ZZL/7th+qjhyTtzikwXHS/8n4ThuMmklAs/r
	NuYYKQe2696fgsxCovH0Gc5eLiaIL3kNUKP9WZAy8TRz3/L/1mk7cnc86Aw3Osr/I9b4T9FNMBwPP
	DDOfDmDVjazrs33niPUUTLgfzzTCGbFdX5qppSgvfx+Mr8DQVEfGUgAMLGpq5svZ6y+ki2a7LaoZd
	u2/eNp0qWQ2getq5xEZ4BwSXqVKdmJ/QoOhh5j58NFsHUhfSD6udCxS/rqIW7IEu57AioJFq+sD/r
	sdd1C9Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNAAm-000G3U-AZ; Mon, 06 Sep 2021 08:40:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNAAj-000G2S-ES
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 08:40:10 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9F2220FB;
 Mon,  6 Sep 2021 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630917606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xepuq2g1UzpFTzC0FV5yi43ZLpLb8aMqI7nbH2laTl8=;
 b=enIQailCj0QG3GmZKHJQ/HdvNX+3DVhiYocJMKVxVVrW4wCw0yUhEluAEBZCYToEalVE9u
 8y5tr6BKNQn1dolhvVjPE/kVMcZDquknnPmWSqwjlMM3wOmFTldLyiIDX79ZddBj0qlOiY
 kCOvsRWtpkzxN4VIOIAraIWj0HMqnv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630917606;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xepuq2g1UzpFTzC0FV5yi43ZLpLb8aMqI7nbH2laTl8=;
 b=xarIDKwLIHfLikmp7p97wQPLMuG55G1Eqt1tNGzIk/RW6STFT3eabuFmtKE25RDjDEGAdc
 MvsEUQ1VlhGFzqBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7A14113299;
 Mon,  6 Sep 2021 08:40:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id RFIaHObTNWEycQAAGKfGzw
 (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 08:40:06 +0000
Subject: Re: [PATCH v2] nvme: avoid race in shutdown namespace removal
To: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>
References: <20210902092002.67614-1-dwagner@suse.de>
 <YTXKwOvCtJOHnhpu@infradead.org>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d63a15af-63a7-3fa0-1559-4518dee3a99a@suse.de>
Date: Mon, 6 Sep 2021 10:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YTXKwOvCtJOHnhpu@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_014009_707808_016DF339 
X-CRM114-Status: GOOD (  16.97  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS82LzIxIDEwOjAxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUaHUsIFNl
cCAwMiwgMjAyMSBhdCAxMToyMDowMkFNICswMjAwLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+PiBX
aGVuIHdlIHJlbW92ZSB0aGUgc2libGluZ3MgZW50cnksIHdlIHVwZGF0ZSBucy0+aGVhZC0+bGlz
dCwgaGVuY2Ugd2UKPj4gY2FuJ3Qgc2VwYXJhdGUgdGhlIHJlbW92YWwgYW5kIHRlc3QgZm9yIGJl
aW5nIGVtcHR5LiBUaGV5IGhhdmUgdG8gYmUKPj4gaW4gdGhlIHNhbWUgY3JpdGljYWwgc2VjdGlv
biB0byBhdm9pZCBhIHJhY2UuCj4+Cj4+IFRvIGF2b2lkIGJyZWFraW5nIHRoZSByZWZjb3VudGlu
ZyBpbWJhbGFuY2UgYWdhaW4sIGFkZCBhIGxpc3QgZW1wdHkKPj4gY2hlY2sgdG8gbnZtZV9maW5k
X25zX2hlYWQuCj4gCj4gSGFubmVzLCBjYW4geW91IGxvb2sgb3ZlciB0aGlzIGFuZCBydW4geW91
ciB0ZXN0cyBvbiBpdD8KPiAKSSdtIGF0IGl0LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApT
VVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1l
bmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
