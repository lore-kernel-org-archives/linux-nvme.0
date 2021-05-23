Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC39C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:55:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC7D61400
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC7D61400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h6QJitKDxbKt5Dg5HTlZ8ifhls/KHxupSiWDYYdfwMI=; b=hpUZACJPvbbvJlR0sZGgA2DY2
	eIb+bglX6GVwWkivQzfKdT0z2I4JxhM/w6RByEbPrxh+pJlSAg9j4DU7XTmyFFKQ0qhxCQtcNlyLm
	cyPW5xK6MGVGz02rWmLjoTe7U8mYQWcki240zHD7njW/bp4IHsbZaCjErrvdO5k6S3nxqGV3nIhnV
	o7f8BgGQYhhXlXs0oYCtYE40lZzD3dO1rpJw9aDXBdeRV3d3cGkHaPCTrfqc24PH2PMxK4ZgKkfLT
	G3vBKEzcMt/Y7zMbTVeYYLkUuEANBJQ/3NWosx+tBKbpcOu3VHdBkZdS98fbNUJAIh2VcSMCkyDK7
	begBsK+FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGfh-001l2i-CL; Mon, 24 May 2021 19:55:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkiw6-0040Cl-Ei
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 07:54:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=R/MSb7WB4yg0xY//iJ4g4o9OrazLUgapaBmCSPU09/w=; b=agrL8Cznzd+PKD+ngDNZ530leM
 B8FKFRVdy+nPs6yt2pKsr3bb5O3D8e7x5BCg2328VUoOWThqVFF20SOa1lPQ9UIDMITBgbZiJSdCa
 YyCQrdJY44tEUCpkGi5CLFfYS2QrHzAyup6a8w+r/05FUBeOVQwwu44jntwZyZMVqE35uGiyzmN2W
 pVI0fy8Y29/trz3Y2GYmv4IxAzKvXZw48mly8nRQOF0zW+W5Db+LsQmnrQ4U5GCyr35qD1YSXUdWm
 LO8qNT7EdU052kHZvx1NyI2ozsBmvtu56zE9lbVHXs7iSuqdoUx3bmGIXTKYK2S9v4pyJx1CFSz6o
 FqK2fR8g==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkiw3-000MIW-OL
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 07:54:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621756446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/MSb7WB4yg0xY//iJ4g4o9OrazLUgapaBmCSPU09/w=;
 b=FC/3WRGmbKLV9khHIpTe9yyXvRUN7xxss53zAKWt+qPq7bC39y/+TOpVowgKFbkdqtgN39
 wIZQxHHjp89jEnloHEengHgD8PZOwsgYN9EAyuhMu7q7ZSb7lghFKiZG3iD2USft6npSCy
 eNVry1lTEz7fFddLBqOGiCa8FzH8fGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621756446;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/MSb7WB4yg0xY//iJ4g4o9OrazLUgapaBmCSPU09/w=;
 b=uBPd4XPXbURZPUEYY7Ti50Vf8xHvPCvMBcQoB+74ddrgR7/RrWEsplxLKlp80m4Ht7bEh7
 40Kbf475wc2SC2DA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 31E2BAB6D;
 Sun, 23 May 2021 07:54:06 +0000 (UTC)
Subject: Re: [PATCH 04/26] block: add a flag to make put_disk on partially
 initalized disks safer
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jim Paris <jim@jtan.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>,
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4526cf9d-1735-9517-c5c6-1d851d15d0ab@suse.de>
Date: Sun, 23 May 2021 09:54:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-5-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_005407_965238_7F156784 
X-CRM114-Status: GOOD (  16.67  )
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

T24gNS8yMS8yMSA3OjUwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBBZGQgYSBmbGFn
IHRvIGluZGljYXRlIHRoYXQgX19kZXZpY2VfYWRkX2Rpc2sgZGlkIGdyYWIgYSBxdWV1ZSByZWZl
cmVuY2UKPiBzbyB0aGF0IGRpc2tfcmVsZWFzZSBvbmx5IGRyb3BzIGl0IGlmIHdlIGFjdHVhbGx5
IGhhZCBpdC4gIFRoaXMgc29ydAo+IG91dCBvbmUgb2YgdGhlIG1ham9yIHBpdGZhbHMgd2l0aCBw
YXJ0aWFsbHkgaW5pdGlhbGl6ZWQgZ2VuZGlzayB0aGF0CiAgICAgICAgICAgICAgICAgICAgICAg
IHBpdGZhbGxzCgo+IGEgbG90IG9mIGRyaXZlcnMgZGlkIGdldCB3cm9uZyBvciBzdGlsbCBkby4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0K
PiAgIGJsb2NrL2dlbmhkLmMgICAgICAgICB8IDcgKysrKystLQo+ICAgaW5jbHVkZS9saW51eC9n
ZW5oZC5oIHwgMSArCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
