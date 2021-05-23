Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3DC2B9F8
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:14:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228B26140A
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 20:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228B26140A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5aKbO6ZzHH1TjfsBPaOK+9pPsRLJ5FlMUuxGApIYc68=; b=wXlXOa8MPZIbXQjG4KY9hTVg1
	urR0QsgfSoEvX6lSf5EQpwEZw2wBhCAENzDTfCU/Q+2QCrfISSk7aiRO7JDMQKLj9h+mKIcL9GyBs
	oi9CG9eJYx/irgTR3XXIacb7gMFSDVAFFZNN5xO5aFb1tLovs38rGKXBhSFCDTY3/rhur8DelYyTk
	5jMwsnaDv4SihRSiStSL8waU93VlZ+5i2Aupg695cRk0mmfx8d77ZB4t8l/jS7S3pv3cUX47GmSnJ
	Q6dFB8dLMfLnUgwapmQH9RNdxj2gMVzDO4DQKM9xqKw3HcW6EKClIg6LUOGYCP+FfgOZtoDtQ/ypF
	IwCnsDeuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGyP-001ntm-EC; Mon, 24 May 2021 20:14:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkjEF-0041vK-8X
 for linux-nvme@desiato.infradead.org; Sun, 23 May 2021 08:12:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=+QPb9JWvY5Mv2CQaqhfS/CQ9rp49Qt1b0dGLtKqWAHI=; b=G213sSjXK2v1f3XuCvlewvmjlS
 tvE9lRhNkYF2vV8kCrudEjmNASB0t2B5+b3mK3amaTPPP4evl0fWcKQvhzMrjB023q+JDetILa114
 rBDZG+wpaxNebFxrA6NDuZZ/FJ7KWFu6q4Xuq82UFX04k1WNpqfjlxpC4xP/UomqlC4C2oznamqFR
 YAPgyNKhgZQQVq2WZzFW5anOzOfmj62K/T0gY+Cl6nqO1jZSSk1qd7WD+/m21+yl21hdxe1xV7GPz
 f68MjmNQ+7yWA/UB/fAw11o/eS8If6a6EiMOgcYEFVeOIjIS/oi83OggMRlnzTY/xg1A2BSluldK8
 YtRTOr0A==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkjEC-000MuK-GM
 for linux-nvme@lists.infradead.org; Sun, 23 May 2021 08:12:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621757571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QPb9JWvY5Mv2CQaqhfS/CQ9rp49Qt1b0dGLtKqWAHI=;
 b=bmLKYtBm8+NBy0rlZh5vgGqGnuUZQLXD5BUZHEsC9KLWeRov/Kd6myZf3F/3Hji8xMjQ4e
 XjNGXj+P/iVCSJDfUijcHK/6GnQs8Q24V+00sjOXcvV369Y7JMbEdHVZbnUo2wP5SwFvtR
 NE9Ud+kiuo+RtjyO7YO79/Vtotp8i1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621757571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+QPb9JWvY5Mv2CQaqhfS/CQ9rp49Qt1b0dGLtKqWAHI=;
 b=TpSTAzMPXkVgQoDLdk+dThL13YkgxTUpmMsPvWCAi0674zr0yAyJez4vAZgVjbOQTqHQTY
 aFmfGWmflFT7I3Ag==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 009B9AC3A;
 Sun, 23 May 2021 08:12:51 +0000 (UTC)
Subject: Re: [PATCH 14/26] md: convert to blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
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
 Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-m68k@lists.linux-m68k.org, linux-xtensa@linux-xtensa.org,
 drbd-dev@lists.linbit.com, linuxppc-dev@lists.ozlabs.org,
 linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-15-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e65de9e6-337c-3e41-b5c2-d033ff236582@suse.de>
Date: Sun, 23 May 2021 10:12:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521055116.1053587-15-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210523_011252_861198_CDFC0044 
X-CRM114-Status: GOOD (  21.66  )
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
ZSBtZCBkcml2ZXIgdG8gdXNlIHRoZSBibGtfYWxsb2NfZGlzayBhbmQgYmxrX2NsZWFudXBfZGlz
awo+IGhlbHBlcnMgdG8gc2ltcGxpZnkgZ2VuZGlzayBhbmQgcmVxdWVzdF9xdWV1ZSBhbGxvY2F0
aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+
IC0tLQo+ICAgZHJpdmVycy9tZC9tZC5jIHwgMjUgKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvbWQuYyBiL2RyaXZlcnMvbWQvbWQuYwo+IGluZGV4IDQ5
Zjg5N2ZiYjg5Yi4uZDgwNmJlOGNjMjEwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbWQvbWQuYwo+
ICsrKyBiL2RyaXZlcnMvbWQvbWQuYwo+IEBAIC01NTk4LDEyICs1NTk4LDEwIEBAIHN0YXRpYyB2
b2lkIG1kX2ZyZWUoc3RydWN0IGtvYmplY3QgKmtvKQo+ICAgCWlmIChtZGRldi0+c3lzZnNfbGV2
ZWwpCj4gICAJCXN5c2ZzX3B1dChtZGRldi0+c3lzZnNfbGV2ZWwpOwo+ICAgCj4gLQlpZiAobWRk
ZXYtPmdlbmRpc2spCj4gKwlpZiAobWRkZXYtPmdlbmRpc2spIHsKPiAgIAkJZGVsX2dlbmRpc2so
bWRkZXYtPmdlbmRpc2spOwo+IC0JaWYgKG1kZGV2LT5xdWV1ZSkKPiAtCQlibGtfY2xlYW51cF9x
dWV1ZShtZGRldi0+cXVldWUpOwo+IC0JaWYgKG1kZGV2LT5nZW5kaXNrKQo+IC0JCXB1dF9kaXNr
KG1kZGV2LT5nZW5kaXNrKTsKPiArCQlibGtfY2xlYW51cF9kaXNrKG1kZGV2LT5nZW5kaXNrKTsK
PiArCX0KPiAgIAlwZXJjcHVfcmVmX2V4aXQoJm1kZGV2LT53cml0ZXNfcGVuZGluZyk7Cj4gICAK
PiAgIAliaW9zZXRfZXhpdCgmbWRkZXYtPmJpb19zZXQpOwo+IEBAIC01NzExLDIwICs1NzA5LDEz
IEBAIHN0YXRpYyBpbnQgbWRfYWxsb2MoZGV2X3QgZGV2LCBjaGFyICpuYW1lKQo+ICAgCQlnb3Rv
IGFib3J0Owo+ICAgCj4gICAJZXJyb3IgPSAtRU5PTUVNOwo+IC0JbWRkZXYtPnF1ZXVlID0gYmxr
X2FsbG9jX3F1ZXVlKE5VTUFfTk9fTk9ERSk7Cj4gLQlpZiAoIW1kZGV2LT5xdWV1ZSkKPiArCWRp
c2sgPSBibGtfYWxsb2NfZGlzayhOVU1BX05PX05PREUpOwo+ICsJaWYgKCFkaXNrKQo+ICAgCQln
b3RvIGFib3J0Owo+ICAgCj4gLQlibGtfc2V0X3N0YWNraW5nX2xpbWl0cygmbWRkZXYtPnF1ZXVl
LT5saW1pdHMpOwo+IC0KPiAtCWRpc2sgPSBhbGxvY19kaXNrKDEgPDwgc2hpZnQpOwo+IC0JaWYg
KCFkaXNrKSB7Cj4gLQkJYmxrX2NsZWFudXBfcXVldWUobWRkZXYtPnF1ZXVlKTsKPiAtCQltZGRl
di0+cXVldWUgPSBOVUxMOwo+IC0JCWdvdG8gYWJvcnQ7Cj4gLQl9Cj4gICAJZGlzay0+bWFqb3Ig
PSBNQUpPUihtZGRldi0+dW5pdCk7Cj4gICAJZGlzay0+Zmlyc3RfbWlub3IgPSB1bml0IDw8IHNo
aWZ0Owo+ICsJZGlzay0+bWlub3JzID0gMSA8PCBzaGlmdDsKPiAgIAlpZiAobmFtZSkKPiAgIAkJ
c3RyY3B5KGRpc2stPmRpc2tfbmFtZSwgbmFtZSk7Cj4gICAJZWxzZSBpZiAocGFydGl0aW9uZWQp
Cj4gQEAgLTU3MzMsNyArNTcyNCw5IEBAIHN0YXRpYyBpbnQgbWRfYWxsb2MoZGV2X3QgZGV2LCBj
aGFyICpuYW1lKQo+ICAgCQlzcHJpbnRmKGRpc2stPmRpc2tfbmFtZSwgIm1kJWQiLCB1bml0KTsK
PiAgIAlkaXNrLT5mb3BzID0gJm1kX2ZvcHM7Cj4gICAJZGlzay0+cHJpdmF0ZV9kYXRhID0gbWRk
ZXY7Cj4gLQlkaXNrLT5xdWV1ZSA9IG1kZGV2LT5xdWV1ZTsKPiArCj4gKwltZGRldi0+cXVldWUg
PSBkaXNrLT5xdWV1ZTsKPiArCWJsa19zZXRfc3RhY2tpbmdfbGltaXRzKCZtZGRldi0+cXVldWUt
PmxpbWl0cyk7Cj4gICAJYmxrX3F1ZXVlX3dyaXRlX2NhY2hlKG1kZGV2LT5xdWV1ZSwgdHJ1ZSwg
dHJ1ZSk7Cj4gICAJLyogQWxsb3cgZXh0ZW5kZWQgcGFydGl0aW9ucy4gIFRoaXMgbWFrZXMgdGhl
Cj4gICAJICogJ21kcCcgZGV2aWNlIHJlZHVuZGFudCwgYnV0IHdlIGNhbid0IHJlYWxseQo+IApX
b3VsZG4ndCBpdCBtYWtlIHNlbnNlIHRvIGludHJvZHVjZSBhIGhlbHBlciAnYmxrX3F1ZXVlX2Zy
b21fZGlzaygpJyBvciAKc29tZXN1Y2ggdG8gYXZvaWQgaGF2aW5nIHRvIGtlZXAgYW4gZXhwbGlj
aXQgJ3F1ZXVlJyBwb2ludGVyPwoKCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRl
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAz
NjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZl
cgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
