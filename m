Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA135C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:05:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC146140A
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC146140A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ewA5/EVNj7DpXuhPW4OfQgQjOKFbRoNT8Qpdi9FNaWI=; b=rQqmWMopV8ffRcWRdylXRrFMQ
	sX/U/VkFPPnqrJdVUstlYvqWOj5oQeqbYiOxxt6rQ7GCuM0jfhxQ04jQoqCmCJv1YZ/pf9xnfkmvj
	hM3POzMWgV5orzLzFFkiCAnGnRG24UyfUf+VL0JpSfoiCf3LoJTpKLrUKpFWNVHIYiJHlb1D1MwuL
	K+9Pe8xfkZJzLdhV9aV/yc56TBlDlh4wtzVLlOb5ExqrP2i8jLKovXa/wKNz6mwAMTPotT3JtJx+3
	3HaSK7rRiltGyTmPiIFn3DBKD01/aDB7HvITS0q6NR9V4BpyP+TO5sBy0O8oc1IjqMr7NyZJzzxrl
	vrQopVQhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGp7-001mc1-CF; Mon, 24 May 2021 20:05:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkj2x-0040rT-9m
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:02:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=dQcMiRwWPAv5WvyB96FHXfbWmipHEObf8DbZE1kuJz0=; b=rk59547Z0kX0eaeQs0W0sOfwZR
 QLGpMYHyHBxAGG+imny7MCKt6cRZwxru/tFZ2CMVzTerbKyqGZj8u+h9J3Q18QaQQVDHDXYnWwU8B
 KLLWRrH9jrzT5krUYKt5bzDm/HrKPPp+TEs6gyDQWIINBtEvx2iEw8yo6m2KjIOZFus7aCfbX3uKC
 rewPi0RA7fW6zTcqCWI7qJ+i/bNtUl7egSLCQAD5/6K0byVnuMkt+eKvxP15foKDuGYD4nV0o1VPx
 hbecig4d36CQkCYi1c1IldCL7+5OGIgumboJEgDIX/ybI2pbq9CiOj+dQt4RUjLbKA+pAuQNpT+AL
 zrf4zI0w==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkj2u-000MZ5-QN
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:01:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621756871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQcMiRwWPAv5WvyB96FHXfbWmipHEObf8DbZE1kuJz0=;
 b=YsNBTEtY9zUxIRB0nUCYFE0p4Phyu9JIogvxQ6dQp1JmxSsh6383URErsOOjvKUrWdjG3i
 G4WR5KIID9YfhoyqFncNw5BCBg4OUx0j3IL7e2LyT9hva2QjzxoHd5fG/CjvbfsLxkv0Kl
 OdHSHAyubg/VQopYp4fidcOC44h0b7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621756871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQcMiRwWPAv5WvyB96FHXfbWmipHEObf8DbZE1kuJz0=;
 b=xr4HC9LhCyK7b72CQ19QM/IvZBzWs7uhLBP4TCi+BAuVEojUA0LNKTWF+60+IbZ98/p90X
 c54NH1ujLvjQm6AA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5B95FAC8B;
 Sun, 23 May 2021 08:01:11 +0000 (UTC)
Subject: Re: [PATCH 09/26] rsxx: convert to blk_alloc_disk/blk_cleanup_disk
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
 <20210521055116.1053587-10-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <989097c8-0716-abbb-3cf1-907eeb221fb5@suse.de>
Date: Sun, 23 May 2021 10:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-10-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_010113_023662_CA24B574 
X-CRM114-Status: GOOD (  14.58  )
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

T24gNS8yMS8yMSA3OjUwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDb252ZXJ0IHRo
ZSByc3h4IGRyaXZlciB0byB1c2UgdGhlIGJsa19hbGxvY19kaXNrIGFuZCBibGtfY2xlYW51cF9k
aXNrCj4gaGVscGVycyB0byBzaW1wbGlmeSBnZW5kaXNrIGFuZCByZXF1ZXN0X3F1ZXVlIGFsbG9j
YXRpb24uCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+
Cj4gLS0tCj4gICBkcml2ZXJzL2Jsb2NrL3JzeHgvZGV2LmMgICAgICAgfCAzOSArKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICBkcml2ZXJzL2Jsb2NrL3JzeHgvcnN4eF9wcml2
LmggfCAgMSAtCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDI1IGRlbGV0
aW9ucygtKQo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNo
ZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJu
ZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2Vz
Y2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
