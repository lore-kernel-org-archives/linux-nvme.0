Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F43C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:12:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EDD61261
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EDD61261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cvQdg50XpWBcJxUVHyuh3hJkJH/ajaZacTNA7mpGoqI=; b=CHTDjCnqe6KoqTOe7NfIFChyS
	1bSIsytmdU+7SqULnpeKbY2oHmbSPwU0yyZoSXpdBlvEWZRjropzuWj2pWTcr6qC40BZgsqwlYrWU
	MombK6GmMT1UF6wAD6YJRY3vGvnL+l/Dz+KYlsp/v24b+RCU22fV4uEoO4xWuwjbg1OqELBaLsB4E
	/aBTWsDOwFMKCiB4XeutWPl7OrPSOA0nh84/6UunlNLlt57nsRGIl/hsQMm+wKJK1IbrISBLdgmvJ
	qc4MCa7yfL5RlsUQ9ts1nH4bjCEffTiI/t2M7t0v7xvE8y2SIrqWr/5ugzoowtA0LVtjxLVEsEDZY
	IldIaX/hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGvx-001nVs-1e; Mon, 24 May 2021 20:12:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkjC4-0041h8-QO
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:10:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=a6ZAhxnlslJAzzx7sKAzPpcSbekXBLAV3/YPtrS6OLY=; b=dtb34hMGSW2HXaYZtTQ+rf0zph
 wrNotvWSRRyP93YhO7v2I2mNSRCybz5r99cLeKTyUa/pBDLw576DFlMKsC1AmT0BLBkdYUVA4Y+CO
 Li6TW555Cpa4Ul82QJgCS6TKG96ESxOgPnBOYkFznn/qABdXjtweV0hlVJ/kYnuf6lGgsVpbUsjXE
 a7tCSj52u6FnE5CJWTAiEjjfIg27oPqyxYVDfoJ//91PvLAx8mZGrHd6qo68fcU/M8o+hp/pSlu39
 yESCmiAcjhtorcayMqo3oJpd3NH6kC8wjPBSjH2RDg6GKvFqmvNVKASDaA6NbNN8n2lUU/Q+es4iD
 DZFx20gw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkjC2-000MpT-11
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:10:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621757436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6ZAhxnlslJAzzx7sKAzPpcSbekXBLAV3/YPtrS6OLY=;
 b=D1NxWkYmjMQpRiSLlKY8Sja0G/IpCIx6G/gcHzmCMSOHVzwjfIe5W+xcM9lcW/dMxuvn6J
 GX9L8uskVnxXEmhBzlzW/erIxAktXG6bzgw2aEH1RbZTk0dusDk3QXHn4Y/CDQ3r1VNe4S
 ZEYuEFIXysdiuYaC/dwFArCRQpU9tfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621757436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6ZAhxnlslJAzzx7sKAzPpcSbekXBLAV3/YPtrS6OLY=;
 b=er1d+U01C9aUpwZ6Y7V+oivz26INFThTuDK5a2cmXuzpBgQNZaStW/8o6Izga5eq8QPu/J
 kmLlzNehZilQrADA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6FA31AB6D;
 Sun, 23 May 2021 08:10:36 +0000 (UTC)
Subject: Re: [PATCH 13/26] dm: convert to blk_alloc_disk/blk_cleanup_disk
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
 <20210521055116.1053587-14-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <de3b0976-1299-17d8-240a-2ecd8b9fbc2d@suse.de>
Date: Sun, 23 May 2021 10:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-14-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_011038_380376_6C8E5D19 
X-CRM114-Status: GOOD (  21.86  )
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

T24gNS8yMS8yMSA3OjUxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBDb252ZXJ0IHRo
ZSBkbSBkcml2ZXIgdG8gdXNlIHRoZSBibGtfYWxsb2NfZGlzayBhbmQgYmxrX2NsZWFudXBfZGlz
awo+IGhlbHBlcnMgdG8gc2ltcGxpZnkgZ2VuZGlzayBhbmQgcmVxdWVzdF9xdWV1ZSBhbGxvY2F0
aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+
IC0tLQo+ICAgZHJpdmVycy9tZC9kbS5jIHwgMTYgKysrKysrKy0tLS0tLS0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZC9kbS5jIGIvZHJpdmVycy9tZC9kbS5jCj4gaW5kZXggY2EyYWVkZDhlZTdk
Li4zYzdjMmQyNTcwMTggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tZC9kbS5jCj4gKysrIGIvZHJp
dmVycy9tZC9kbS5jCj4gQEAgLTE4MDEsMTMgKzE4MDEsMTMgQEAgc3RhdGljIHZvaWQgY2xlYW51
cF9tYXBwZWRfZGV2aWNlKHN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCkKPiAgIAkJbWQtPmRpc2st
PnByaXZhdGVfZGF0YSA9IE5VTEw7Cj4gICAJCXNwaW5fdW5sb2NrKCZfbWlub3JfbG9jayk7Cj4g
ICAJCWRlbF9nZW5kaXNrKG1kLT5kaXNrKTsKPiAtCQlwdXRfZGlzayhtZC0+ZGlzayk7Cj4gICAJ
fQo+ICAgCj4gLQlpZiAobWQtPnF1ZXVlKSB7Cj4gKwlpZiAobWQtPnF1ZXVlKQo+ICAgCQlkbV9x
dWV1ZV9kZXN0cm95X2tleXNsb3RfbWFuYWdlcihtZC0+cXVldWUpOwo+IC0JCWJsa19jbGVhbnVw
X3F1ZXVlKG1kLT5xdWV1ZSk7Cj4gLQl9Cj4gKwo+ICsJaWYgKG1kLT5kaXNrKQo+ICsJCWJsa19j
bGVhbnVwX2Rpc2sobWQtPmRpc2spOwo+ICAgCj4gICAJY2xlYW51cF9zcmN1X3N0cnVjdCgmbWQt
PmlvX2JhcnJpZXIpOwo+ICAgCgpDYW4ndCB0aGVzZSBjb25kaXRpb25hbHMgYmUgbWVyZ2VkIGlu
dG8gYSBzaW5nbGUgJ2lmIChtZC0+ZGlzayknPwpFZyBsaWtlOgoKCWlmIChtZC0+ZGlzaykgewoJ
CXNwaW5fbG9jaygmX21pbm9yX2xvY2spOwoJCW1kLT5kaXNrLT5wcml2YXRlX2RhdGEgPSBOVUxM
OwoJCXNwaW5fdW5sb2NrKCZfbWlub3JfbG9jayk7CgkJZGVsX2dlbmRpc2sobWQtPmRpc2spOwoJ
CWRtX3F1ZXVlX2Rlc3Ryb3lfa2V5c2xvdF9tYW5hZ2VyKG1kLT5xdWV1ZSk7CgkJYmxrX2NsZWFu
dXBfZGlzayhtZC0+cXVldWUpOwoJfQoKV2UncmUgbm93IGFsd2F5cyBhbGxvY2F0aW5nICdtZC0+
ZGlzaycgYW5kICdtZC0+cXVldWUnIHRvZ2V0aGVyLApzbyBob3cgY2FuIHdlIGVuZCB1cCBpbiBh
IHNpdHVhdGlvbiB3aGVyZSBvbmUgaXMgc2V0IHdpdGhvdXQgdGhlIG90aGVyPwoKPiBAQCAtMTg2
OSwxMyArMTg2OSwxMCBAQCBzdGF0aWMgc3RydWN0IG1hcHBlZF9kZXZpY2UgKmFsbG9jX2Rldihp
bnQgbWlub3IpCj4gICAJICogZXN0YWJsaXNoZWQuIElmIHJlcXVlc3QtYmFzZWQgdGFibGUgaXMg
bG9hZGVkOiBibGstbXEgd2lsbAo+ICAgCSAqIG92ZXJyaWRlIGFjY29yZGluZ2x5Lgo+ICAgCSAq
Lwo+IC0JbWQtPnF1ZXVlID0gYmxrX2FsbG9jX3F1ZXVlKG51bWFfbm9kZV9pZCk7Cj4gLQlpZiAo
IW1kLT5xdWV1ZSkKPiAtCQlnb3RvIGJhZDsKPiAtCj4gLQltZC0+ZGlzayA9IGFsbG9jX2Rpc2tf
bm9kZSgxLCBtZC0+bnVtYV9ub2RlX2lkKTsKPiArCW1kLT5kaXNrID0gYmxrX2FsbG9jX2Rpc2so
bWQtPm51bWFfbm9kZV9pZCk7Cj4gICAJaWYgKCFtZC0+ZGlzaykKPiAgIAkJZ290byBiYWQ7Cj4g
KwltZC0+cXVldWUgPSBtZC0+ZGlzay0+cXVldWU7Cj4gICAKPiAgIAlpbml0X3dhaXRxdWV1ZV9o
ZWFkKCZtZC0+d2FpdCk7Cj4gICAJSU5JVF9XT1JLKCZtZC0+d29yaywgZG1fd3Ffd29yayk7Cj4g
QEAgLTE4ODgsNiArMTg4NSw3IEBAIHN0YXRpYyBzdHJ1Y3QgbWFwcGVkX2RldmljZSAqYWxsb2Nf
ZGV2KGludCBtaW5vcikKPiAgIAo+ICAgCW1kLT5kaXNrLT5tYWpvciA9IF9tYWpvcjsKPiAgIAlt
ZC0+ZGlzay0+Zmlyc3RfbWlub3IgPSBtaW5vcjsKPiArCW1kLT5kaXNrLT5taW5vcnMgPSAxOwo+
ICAgCW1kLT5kaXNrLT5mb3BzID0gJmRtX2Jsa19kb3BzOwo+ICAgCW1kLT5kaXNrLT5xdWV1ZSA9
IG1kLT5xdWV1ZTsKPiAgIAltZC0+ZGlzay0+cHJpdmF0ZV9kYXRhID0gbWQ7Cj4gCkNoZWVycywK
Ckhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0
ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0
c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
