Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878FC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:54:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756FB61400
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756FB61400
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FT/g14GFtkKk6hDa1HN8Fk3vl/FdzZpIYXK82FMvfhU=; b=NbbP8SThXPBSC4mab+qBsg2cJ
	sBQ1ckSygX8hZgNVUSTdoPI7/G/X78gHNsSSzfIY7eZoGz4KdcicFwwwszRHy3BKOFmRzXAUTJBFD
	WK5cnHpWPLeL9yTgZs9Hb3C7UFffUNpz03yycD6W02iZ20jWdP0DRe20O2fLcdVW6/VLa9pZ7NRbl
	8uv+eFIWx7QFzz1xB2LPN4UB3S2VGW1BHduJv1zd/oXTEj2BJHas/ywXFa4v4DqmUG7YiwdVi18rV
	0oJvoG11mXVeVaLEIkypGObrVZTM7+wpIhO8lGAT2gSEAMWqf+CXdFauXDf1i/WlK26z+yBdKVErU
	sB0WZDtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGeO-001kfJ-Fa; Mon, 24 May 2021 19:54:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkisU-003zy9-0W
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 07:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=rtcf9ZiJF1IicCei97k4vd7l0YRihd30WBKbwux84M4=; b=MAwyRHeyJ9gFIPcPzXPcRMyXNi
 XDrLL2yV8nAtBOhUMVQ+YEt8L7pLwOiFNphmc7Tvpw82txg+4nZqXuaxez3ARvCrI4riJvCfOa2KX
 NuDZ8zgqTVcLCVDLFYNy/gYlOafU96tfbSb6DOcDzQbM4CoGK9ELXfvOnfR9j4Yyy9aBU0IYR+Zw+
 wvwg2nX1bRVG5x+m8HxDgzQ2wTDcCE8bXryIK7y226yMSKFYqpGtEn9qCqNA+lqSqgoZl2LYe5YuN
 f+7CobokyZxtkVlFKe2GcEokc7nq7sX4cKeK7xIBCz0rKd0sOcHvd18Szsonfq9sABR8e8DCmV3I9
 gFVaXSHQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkisR-000MEU-AQ
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 07:50:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621756222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtcf9ZiJF1IicCei97k4vd7l0YRihd30WBKbwux84M4=;
 b=sDbup0LhTBVHGpz4adi/u9XdLzA13ekDEdXgxK9JTz65LsDQGYPd4xWjRqYkioRnOW/TOG
 y0y4tfuPJpajRbISMilITQkj9VMNY6CsP+Zp+46w/KM4N8qcPDSfKAfcwYgu3mpQLZYAFs
 0/Bgldk/F4i87UepxqbODGRCcEF4CaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621756222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rtcf9ZiJF1IicCei97k4vd7l0YRihd30WBKbwux84M4=;
 b=kOlysilQUJZsrmpkQr7FjCNiP2AQ2cbGvZ04UUaccOBxYXhvwxwj2ZazA3svipGin3vDRL
 r6fw5krBLS5sGYDg==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id D9C31AC86;
 Sun, 23 May 2021 07:50:21 +0000 (UTC)
Subject: Re: [PATCH 03/26] block: automatically enable GENHD_FL_EXT_DEVT
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
 <20210521055116.1053587-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e437ca9e-b4e7-b50d-8cbc-e5304c1cab50@suse.de>
Date: Sun, 23 May 2021 09:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-4-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_005023_672881_9210846E 
X-CRM114-Status: GOOD (  15.57  )
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

T24gNS8yMS8yMSA3OjUwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBBdXRvbWF0aWNh
bGx5IHNldCB0aGUgR0VOSERfRkxfRVhUX0RFVlQgZmxhZyBmb3IgYWxsIGRpc2tzIGFsbG9jYXRl
ZAo+IHdpdGhvdXQgYW4gZXhwbGljaXQgbnVtYmVyIG9mIG1pbm9ycy4gIFRoaXMgaXMgd2hhdCBh
bGwgbmV3IGJsb2NrCj4gZHJpdmVycyBzaG91bGQgZG8sIHNvIG1ha2Ugc3VyZSBpdCBpcyB0aGUg
ZGVmYXVsdCB3aXRob3V0IGJvaWxlcnBsYXRlCj4gY29kZS4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiAtLS0KPiAgIGJsb2NrL2dlbmhkLmMgICAg
ICAgICAgICAgICAgICAgIHwgMiArLQo+ICAgYmxvY2svcGFydGl0aW9ucy9jb3JlLmMgICAgICAg
ICAgfCA0IC0tLS0KPiAgIGRyaXZlcnMvYmxvY2svbjY0Y2FydC5jICAgICAgICAgIHwgMiArLQo+
ICAgZHJpdmVycy9saWdodG52bS9jb3JlLmMgICAgICAgICAgfCAxIC0KPiAgIGRyaXZlcnMvbWVt
c3RpY2svY29yZS9tc19ibG9jay5jIHwgMSAtCj4gICBkcml2ZXJzL252ZGltbS9ibGsuYyAgICAg
ICAgICAgICB8IDEgLQo+ICAgZHJpdmVycy9udmRpbW0vYnR0LmMgICAgICAgICAgICAgfCAxIC0K
PiAgIGRyaXZlcnMvbnZkaW1tL3BtZW0uYyAgICAgICAgICAgIHwgMSAtCj4gICBkcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgICAgICAgICB8IDEgLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlw
YXRoLmMgICAgfCAxIC0KPiAgIDEwIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5k
ZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAg
ICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21i
SCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJn
KSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
