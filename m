Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75883C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:06:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1B564E68
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 14:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1B564E68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6JZWiVIsxpKLMxL9YdzDgAQW/B0SGZFx2jDx/nZB5iM=; b=YM/K6xheUu7LS8XVuulXowLyh
	XBNq0vRtGbkF02c16QZuvTHLvXknT2f3qgupDiOz3zVPbNfWOVLEDqQcCauJsoAoCAmdx4u1TVxU6
	p6R+u8lMpV1OVmikGe0l4NHLs1y/YmM+dQwAFv/4MbsQi9IHDbBZ++VOWljt0qTcue3YRX2KbGDEq
	ScS04QAVZxZWNZh6hlFtmceOyWCBFFiN0V5zswkLgieIRP9wn7zHY/Yoby/tWrbZfc0m9+BkMJDBD
	KaUMV9hcbvXEJsFZNNLTzClpX3cBzD+JoH4ZA6m+leOyH0Wij3L3thzTmUHP9X4Oc7Zdw1Sv3A4zQ
	haI0+jHPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHS8m-0053CF-Ka; Wed, 03 Mar 2021 14:06:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHS4T-0051yG-6S
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=wuizYUywzdv302dmlaapKtA6X/mb462Xj16DSqoBmgc=; b=K3ZFFSeNYLcHrsThRrXFx2AlS4
 BmOu4sKZeMdmAtwEftf5elowbQ0YHLmXMTyiccNsVkD2O3kggUrmUSuUHiRC0UoYAWn7MnuFF0a2i
 nY93Ep6/pkmVLGEahh8SLO0FmFQFoPRFpKTrDy0yMirolWNj7gc+NDFGJbGrqMvCnldiSYLID40KC
 qwuuaFooNyZpNqzL04o+5TSlXdyG5AmljdA4Bp5X9IfRQeSCzHu0GQmOsPOssl8OR/UaVB4ytp85q
 4CqorgN2U55DG7VDEOz2/A5mXC6ugMp5j18a6Bo5rNa+SLKEIAtsCR5iPmjh371+YF1bb1dpfUN8P
 HSmXZR7Q==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHRHo-002gHX-6W
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 13:11:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 98482ADFB;
 Wed,  3 Mar 2021 13:11:28 +0000 (UTC)
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
 <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
 <20210303123549.GB28477@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
Message-ID: <9655fc98-08c8-ff7d-0aaf-f29b935221d6@suse.de>
Date: Wed, 3 Mar 2021 14:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303123549.GB28477@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_131133_015123_91869AB6 
X-CRM114-Status: GOOD (  24.46  )
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

T24gMy8zLzIxIDE6MzUgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwgTWFy
IDAzLCAyMDIxIGF0IDAxOjAxOjUwUE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+
IEFkZGluZyBCTEtfTVFfUkVRX05PV0FJVCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwcmVwIHBhdGNo
LCB0b2dldGhlciB3aXRoCj4+PiByZWR1Y2luZyB0aGUgbnVtYmVyIG9mIHJlc2VydmVkIHRhZ3Mu
Cj4+Pgo+PiBPa2F5Lgo+PiBCdXQgd2h5IHdvdWxkIHdlIG5lZWQgdG8gcmVkdWNlIHRoZSBudW1i
ZXIgb2YgdGFncz8gSXQncyBub3QgdGhhdCB3ZSdyZQo+PiBjaGFuZ2luZyBhbnl0aGluZyB3aXRo
IHRoZSBhbGxvY2F0aW9uLCB3ZSdyZSBqdXN0IGd1YXJhbnRlZWQgdG8gZmFpbCBpZgo+PiBmb3Ig
c29tZSByZWFzb24gdGhlIHN0YWNrIG1lc3NlcyB1cC4KPiAKPiBCZWNhdXNlIHdlIGNvdWxkIG90
aGVyd2lzZSBzdGlsbCBoYXZlIHRvIGtlZXAgYWxpdmUgcmVxdWVzdHMsIG9yIG9uZSBrZWVwCj4g
YSBsaXZlIGFuZCBvbmUgY29ubmVjdCByZXF1ZXN0cyBhbGxvY2F0ZWQgYXQgdGhlIHNhbWUgdGlt
ZS4KPiAKQnV0IHRoYXQncyB3aGF0IHdlIGhhdmUgdG9kYXkuClNvIHlvdSdyZSBzYXlpbmcgdGhh
dCB3ZSBzaG91bGQgaGF2ZSBvbmx5IF8xXyByZXNlcnZlZCByZXF1ZXN0LCBpZQplaXRoZXIgY29u
bmVjdCBfb3JfIGtlZXAtYWxpdmU/ClN1cmUgd2UgY2FuIGRvIHRoYXQ7IEkgaGFkIGJlZW4gYSBi
aXQgaGVzaXRhbnQgdG8gZG8gdGhhdCBzZWVpbmcgdGhhdCBpdApoYWQgYmVlbiB0aGF0IHdheSBz
aW5jZSB0aGUgYmVnaW5uaW5nLgoKQnV0IGlmIHlvdSBzYXkgLi4uCgo+Pgo+Pj4gQWxzbyB3aHkg
ZG8gd2Ugc3RpbGwgbmVlZCB0aGUgZXh0cmEgdGVzdF9hbmRfc2V0X2JpdCB3aXRoIHRoZQo+Pj4g
Tk9XQUlUIGFsbG9jYXRpb24/Cj4+Pgo+PiBUaGlzIGlzIGVzc2VudGlhbGx5IGEgc2FmZWd1YXJk
OyB0aGVyZSBpcyBub3RoaW5nIGluIHRoZSBjdXJyZW50IGNvZGUKPj4gdGVsbGluZyB1cyBpZiBh
IEtBVE8gY29tbWFuZCBpcyBpbiBmbGlnaHQgb3Igbm90Lgo+PiBBbmQgSSByZWFsbHkgZG8gaGF0
ZSBkb2luZyBwb2ludGxlc3Mgd29yayAobGlrZSBhbGxvY2F0aW5nKSBjb21tYW5kcyBpZgo+PiB3
ZSBkb24ndCBuZWVkIHRvLgo+Pgo+PiBQbHVzIGl0J2xsIGRpZmZlcmVudGlhdGUgYmV0d2VlbiBs
ZWdpdCBjYWxsZXJzIG9mCj4+IG52bWVfc3RhcnRfa2VlcF9hbGl2ZSgpICh3aGljaCBjYW4gYmUg
Y2FsbGVkIGF0IGFueSB0aW1lLCBhbmQgaGVuY2UKPj4gbWlnaHQgYmUgYWRkaW5nIHRoZSBrYV93
b3JrIGVsZW1lbnQganVzdCBhZnRlciB0aGUgcHJldmlvdXMgb25lIGhhZAo+PiBzdWJtaXR0ZWQg
dGhlIEtBVE8gY29tbWFuZCksIGFuZCByZWFsIGZhaWx1cmVzIGxpa2UgZmFpbGluZyB0byBhbGxv
Y2F0ZQo+PiB0aGUgS0FUTyBjb21tYW5kIGl0c2VsZiwgd2hpY2ggcG9pbnRzIHRvIGEgcmVhbCBp
c3N1ZSBpbiB0aGUgc3RhY2sgYXMKPj4gbm9ybWFsbHkgdGhlcmUgc2hvdWxkIGJlIGVub3VnaCBy
ZXNlcnZlZCBjb21tYW5kcy4KPiAKPiBZb3UgY2FuIGRpc3Rpbmd1aXNoIHRoZW0gYnkgdGhlIGVy
cm9yIGNvZGUgZnJvbSBibGtfbXFfYWxsb2NfcmVxdWVzdC4KPiAKVHJ1ZS4gV2lsbCBiZSBkcm9w
cGluZyB0aGF0IHBhdGNoLCB0aGVuLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
