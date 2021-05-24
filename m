Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAF3C2B9F7
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 23:04:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D486140B
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 23:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D486140B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZgosEy6WFKIcDiouOEQh8tUuCtJ3jhBIPA9i8DfU8Cw=; b=Uu3owIS9DWfGpHeSduopHMG2y
	L7DtQmLgwZdjyrz47O+nzc8fDIv02XRcTr0mwjDGxE8dF8AUHxu2V+ppea8xWpPl1CVy+wGyIME0R
	wOjH0+yoFmvuPOuBa2FyNs3LZTdhXYS0EltHevqFS5elx6pWjN2U91RzyF+fm4IESyP0EBkfnWfzD
	0WUnIc6vy05cG4LjeLH3lNkILbGexpJpjH0qaxgljKvb0RkASmL+2QT1Qn4dY+jJ3ccQ/LjZJbice
	1w0PB7susV4mtWAwNyLJDIk2sjsp9zuTKw5ooofemLJ+gSx7GtKcHkN3aruMNYMTBRbQy53ER5GG2
	mUu9UO4sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llJcN-002GSi-4s; Mon, 24 May 2021 23:04:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll5vp-000lki-Vw
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 08:27:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621844838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1F35rBDncf+ODcVO5jTKQ+c6J+Bpaijj4tb+WLiO1U=;
 b=hWbnJCzrn8D8sq7QiamSboM/nv6TN+2iWleusnloao35oVE4OyeDX0eKAMzya8OGGThQFh
 zl1nxRchNuFxstuajSgFtmryku8O1hRGBIRcM0SbrM2Dt3hLAz/KodIIf9vgrdWDs21AJk
 09tFtAADDGOyfSpK1oh2IZudvgHfbuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621844838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1F35rBDncf+ODcVO5jTKQ+c6J+Bpaijj4tb+WLiO1U=;
 b=/Ey/RBTrd/apAViE3Xd9DP0Lfre1LBpPPlJZl5IzG70TmMypTfoLUolyItvUQoIO9R6YkJ
 B6psOuCyZCUW50Cw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CBD6EAB6D;
 Mon, 24 May 2021 08:27:17 +0000 (UTC)
Subject: Re: [PATCH 14/26] md: convert to blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-m68k@lists.linux-m68k.org,
 linux-xtensa@linux-xtensa.org, drbd-dev@lists.linbit.com,
 linuxppc-dev@lists.ozlabs.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-15-hch@lst.de>
 <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
 <20210524072642.GF23890@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <1360c598-44a9-e0c5-dd81-695cb1ec8ccf@suse.de>
Date: Mon, 24 May 2021 10:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210524072642.GF23890@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_012726_344931_0BF3E4F7 
X-CRM114-Status: GOOD (  13.51  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

T24gNS8yNC8yMSA5OjI2IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBTdW4sIE1h
eSAyMywgMjAyMSBhdCAxMDoxMjo0OUFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
PiArCWJsa19zZXRfc3RhY2tpbmdfbGltaXRzKCZtZGRldi0+cXVldWUtPmxpbWl0cyk7Cj4+PiAg
ICAJYmxrX3F1ZXVlX3dyaXRlX2NhY2hlKG1kZGV2LT5xdWV1ZSwgdHJ1ZSwgdHJ1ZSk7Cj4+PiAg
ICAJLyogQWxsb3cgZXh0ZW5kZWQgcGFydGl0aW9ucy4gIFRoaXMgbWFrZXMgdGhlCj4+PiAgICAJ
ICogJ21kcCcgZGV2aWNlIHJlZHVuZGFudCwgYnV0IHdlIGNhbid0IHJlYWxseQo+Pj4KPj4gV291
bGRuJ3QgaXQgbWFrZSBzZW5zZSB0byBpbnRyb2R1Y2UgYSBoZWxwZXIgJ2Jsa19xdWV1ZV9mcm9t
X2Rpc2soKScgb3IKPj4gc29tZXN1Y2ggdG8gYXZvaWQgaGF2aW5nIHRvIGtlZXAgYW4gZXhwbGlj
aXQgJ3F1ZXVlJyBwb2ludGVyPwo+IAo+IE15IHJvdWdodCBwbGFuIGlzIHRoYXQgYSBmZXcgc2Vy
aWVzIGZyb20gbm93IGJpbyBiYXNlZCBkcml2ZXJzIHdpbGwKPiBuZXZlciBkaXJlY3RseSBkZWFs
IHdpdGggdGhlIHJlcXVlc3RfcXVldWUgYXQgYWxsLgo+IApHbyBmb3IgaXQuCgpSZXZpZXdlZC1i
eTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRy
LiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0
CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMg
Njg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxp
eCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
