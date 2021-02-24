Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27559C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 17:10:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5EE64F03
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5EE64F03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eojj30deI628Y2vox9mj2ejSOd0csARphoDs2QHIumk=; b=dexqj1KjSbMDdvMU0CihMALpD
	Esb4OQJLCEhQ0KTPoAx0HRYFkDmANz0ergMmfWsvdqUJ0JoCLvisWkRV3ZjvKgGvDKrGzlF56tMyY
	jPbIVO23RkREXT4922g8kKLc76wMi2Fr/KD3K91MAgq8V2wPpk7NajJFJkHW9XXsMQDRN2XGaKeos
	jTA0Ojf9DTwwusSqzp14WEB25lx2zgG2XZ/wUgedoivkGCTl+fBWKWqH4Ert/6A6Wh/JMlbSig3bG
	zjmjSk8HFu4/AoTR7xnO/zDRGpxccqv9gyLBn/SEcCgAls1ax1DBFNTUt4dEyI+4hbC+PNhY7a10d
	zeuqEDXWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lExgO-0000Cv-OY; Wed, 24 Feb 2021 17:10:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lExgM-0000Bx-AA
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 17:10:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4BEF9ADDB;
 Wed, 24 Feb 2021 17:10:35 +0000 (UTC)
Subject: Re: [PATCH 0/2] nvme: fix regression with MD RAID
To: Christoph Hellwig <hch@lst.de>
References: <20210223115922.104369-1-hare@suse.de>
 <20210224162534.GC9780@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ee9a6a42-a2b9-7076-a78d-6af9f6ecf4dc@suse.de>
Date: Wed, 24 Feb 2021 18:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224162534.GC9780@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_121038_465815_5127C977 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNC8yMSA1OjI1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBJIGRvbid0IHNl
ZSBhbnkgcmVncmVzc2lvbiBoZXJlLCBldmVuIGlmIHRoZSBuZXcgZmVhdHVyZXMgc291bmQgdXNl
ZnVsLgo+IApIYXZlIHlvdSBldmVyIHRyaWVkIE1EIFJBSUQgb24gbnZtZS1vZj8KV2l0aG91dCB0
aGlzIHBhdGNoIE1EIFJBSUQgd2lsbCBfc3RvcF8gSS9PIHVudGlsIHRoZSBjb250cm9sbGVyIHJl
Y29ubmVjdHMuCklmIGl0IGRvZXMuIElmIGl0IGRvZXNuJ3QsIHRoZSBjb250cm9sbGVyIGdldHMg
cmVtb3ZlZCAoc28gYWZ0ZXIgc29tZSAKMzAwIHNlY29uZHMpLCBhbmQgTUQgUkFJRCB3aWxsIGdl
dCBhbiBJL08gZXJyb3IsIGZpbmFsbHkuCkJ1dCB0aGVuIHlvdSByZWNvbm5lY3QgdGhlIGZhaWxl
ZCBwYXRoLCBhbmQgeW91IGVuZCB1cCB3aXRoIGEgCl9kaWZmZXJlbnRfIG52bWUgbmFtZXNwYWNl
IGRldmljZS4KUmVxdWlyaW5nIHlvdSB0byBkbyBtYW51YWwgaGFuZGhvbGRpbmcgZ2V0IHRoZSBN
RCBSQUlEIGludG8gc2hhcGUgYWdhaW4uCgpXaXRoIHRoaXMgcGF0Y2ggaXQgJ2p1c3Qgd29ya3Mn
IHdpdGhvdXQgYW55IGludGVyYWN0aW9uLgoKT25lIG1pZ2h0IGFyZ3VlIGlmIHRoYXQgY29uc3Rp
dHV0ZXMgYSByZWdyZXNzaW9uIChhcyBpdCdzIGJlZW4gdGhlIApiZWhhdmlvdXIgc2luY2UgZGF5
IDEpLCBidXQgaXQgY2VydGFpbmx5IGlzIGltcGFpcmVkIGZ1bmN0aW9uYWxpdHkgYXMgCmNvbXBh
cmVkIHRvIG90aGVyIGRyaXZlcnMvc3Vic3lzdGVtcyBsaWtlIFNDU0kuCkFuZCB3ZSBjYW4ndCBo
YXZlIHRoYXQsIGNhbiB3ZT8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNr
ZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2Fy
ZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
