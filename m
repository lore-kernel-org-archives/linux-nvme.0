Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA28C433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:56:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229D564E4A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 08:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229D564E4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LbDxuHn0iA43C30jo+5PymxeWqfYCAcpaNRJ6I5D5n0=; b=ZLd38dd9kAkdflgWG3cv2OFUs
	ZlJX79tccUVTfGu+5eACMAhJaoXFGveQz03Tc2Z7t9j51wHyPAIzFwatB08x3D9LboKf4VQyoJkX1
	z7SykyxLhRVcxQjfKs8m8eqyQxnFK7rzGzkFHFDDcD6V94RVH53rMnp9mVWR1QUWq91dqrBb+2cNx
	w9MntxrNGWBd6qXVBlsmZl5wB1J5RrROBxmcM4hO5TrVzsKSPoVHNTV1GrVcRVTCBUDGSmEdHHucD
	XSh8Fl/cQkntD7VTwUYFgq29e2/Snydfdjp8aw4I4S80Oj4XZnqkIVDf/+7/QyCtjt6zddw82nixX
	UUaIysEuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHjmd-008Bv1-IP; Thu, 04 Mar 2021 08:56:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHjmR-008BtY-KF
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 08:56:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 013C2AB8C;
 Thu,  4 Mar 2021 08:56:23 +0000 (UTC)
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
 <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
 <20210303123549.GB28477@lst.de>
 <9655fc98-08c8-ff7d-0aaf-f29b935221d6@suse.de>
 <9ea53e09-2ab5-733a-7f1d-fd2404794149@suse.de>
 <20210304080241.GA12617@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f9796913-1499-b2b8-73b4-5a68cf126ecc@suse.de>
Date: Thu, 4 Mar 2021 09:56:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210304080241.GA12617@lst.de>
Content-Language: en-US
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

T24gMy80LzIxIDk6MDIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFdlZCwgTWFy
IDAzLCAyMDIxIGF0IDAzOjIzOjEyUE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4g
QWN0dWFsbHksIGhhdmluZyB0aG91Z2h0IGEgYml0IG1vcmUsIEknbSBub3Qgc3VyZSBpZiB3ZSBz
aG91bGQgY2hhbmdlCj4+IHRoYXQuIENoYW5naW5nIHRoZSBudW1iZXIgb2YgcmVzZXJ2ZWQgY29t
bWFuZHMgX3dpbGxfIGhhdmUgYW4gaW1wYWN0IG9uCj4+IGVycm9yIHJlY292ZXJ5LCB1cCB0byB0
aGUgcG9pbnQgdGhhdCB3ZSBjYW5ub3QgaXNzdWUgYSAnY29ubmVjdCcgY29tbWFuZAo+PiBpZiBh
IGtlZXAtYWxpdmUgY29tbWFuZCBpcyBzdGlsbCBydW5uaW5nLgo+PiBXaGljaCBtZWFucyB3ZSBt
aWdodCBiZSBzZWVpbmcgc3B1cmlvdXMgY29ubmVjdGlvbiBmYWlsdXJlcyBkdXJpbmcKPj4gcmVj
b3ZlcnksIHNvbWV0aGluZyB3aGljaCBJJ2QgYmUgdmVyeSBjYXV0aW91cyBhYm91dC4KPiAKPiBX
ZSBhbHdheXMgZG8gYSBibGtfbXFfdGFnc2V0X2J1c3lfaXRlciB0aGF0IGNhbmNlbHMgYWxsIHJl
cXVlc3RzIGJlZm9yZQo+IHJlY29ubmVjdGluZy4KPiAKUmlnaHQ7IGFuZCBhcyB3ZSdyZSBub3cg
ZmFpbGluZyBhbGxvY2F0aW9ucyB3ZSBzaG91bGQgYmUgZ29vZC4KTGV0J3Mgc2VlIHdoZXRoZXIg
aXQgaG9sZHMgdXAgZHVyaW5nIHRlc3RpbmcuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
