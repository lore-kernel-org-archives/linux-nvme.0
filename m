Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87262C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:31:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52998235F7
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 11:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BEWrlz4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52998235F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IFFxy1PWfdfOIQSoO2cjyNjfe/RqBlcPsQAcVucRVwU=; b=BEWrlz4tX2kmIOUwubYY9u5GW
	ygdP0WS/Dv4UOb9vPaP9bc+pEIZwDYmdfkPKA8zVj6WwHo6dxi42g6Of738+D+JzWWO2g0ct3cG1K
	mI3yce4JHQxGNgycWq0ob3AkW/WnDvEprUNqYDzog31+vlFi79QH7IilEz8Wfl1fbHHNMlVsDifQR
	vyCRgypCFeO+INL+zPGtM1/bUUrqJJCzQMiQk0gShA5KZW4OkDLSEmkOfmIgahcjLoDHmEo9Ej/zr
	8Reun9eyLDquTrYXjWNmkWsLR2NuqebvTqwtF7WBJNCdTM0ZWwTdYW2VSaaTd8wdcM7f9z/PclT0y
	4jL3MV0xQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jps0X-0001VU-3T; Mon, 29 Jun 2020 11:31:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jps0S-0001UM-Py
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 11:31:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2D4F96736F; Mon, 29 Jun 2020 13:31:16 +0200 (CEST)
Date: Mon, 29 Jun 2020 13:31:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 1/1] nvme: initialize CMB only if supported
Message-ID: <20200629113116.GA11056@lst.de>
References: <20200629093853.6078-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629093853.6078-1-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: sagi@grimberg.me, israelr@mellanox.com, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, logang@deltatee.com, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTI6Mzg6NTNQTSArMDMwMCwgTWF4IEd1cnRvdm95IHdy
b3RlOgo+IEFjY29yZGluZyB0byB0aGUgTlZNZSBzcGVjaWZpY2F0aW9uIHJldmlzaW9uIDEuNCAo
Q01CUyk6Cj4gIklmIHNldCB0byDigJgx4oCZLCB0aGlzIGJpdCBpbmRpY2F0ZXMgdGhhdCB0aGUg
Y29udHJvbGxlciBzdXBwb3J0cyB0aGUKPiBDb250cm9sbGVyIE1lbW9yeSBCdWZmZXIsIGFuZCB0
aGF0IGFkZHJlc3NlcyBzdXBwbGllZCBieSB0aGUgaG9zdCBhcmUKPiBwZXJtaXR0ZWQgdG8gcmVm
ZXJlbmNlIHRoZSBDb250cm9sbGVyIE1lbW9yeSBCdWZmZXIgb25seSBpZiB0aGUgaG9zdCBoYXMK
PiBlbmFibGVkIHRoZSBDb250cm9sbGVyIE1lbW9yeSBCdWZmZXLigJlzIGNvbnRyb2xsZXIgbWVt
b3J5IHNwYWNlLiBJZiB0aGUKPiBjb250cm9sbGVyIHN1cHBvcnRzIHRoZSBDb250cm9sbGVyIE1l
bW9yeSBCdWZmZXIsIHRoaXMgYml0IHNoYWxsIGJlIHNldAo+IHRvIOKAmDHigJkuIgo+IAo+IEFs
c28sIHdoaWxlIHdlJ3JlIGhlcmUsIGFkZCBtb3JlIG1hY3JvIGRlZmluaXRpb25zIHJlbGF0ZWQg
dG8gQ01CCj4gcmVnaXN0ZXJzIGFkZGVkIHRvIHJldmlzaW9uIDEuNCBvZiB0aGUgc3BlYy4KClBs
ZWFzZSByZWFkIG15IGNvbW1lbnQgb24gdGhlIHByZXZpb3VzIHBhdGNoIHRoYXQgdHJpZWQgdGhp
cyBhYm91dCBhCndlZWsgb3IgdHdvIGFnby4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
