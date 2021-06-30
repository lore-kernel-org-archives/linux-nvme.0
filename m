Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FAFC11F65
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:18:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC55861D05
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 08:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC55861D05
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyvyP3iHewArj47XXzezfU6V9xZzVULnpQjO1PrfAFU=; b=fZVS6ByzPP5wAwziig2cDlCQlL
	xaCfFR5JsAMAVKvwWgcQgWyawVnGkyD76M66nNf5KQHK+RSlTFwqiYaVaQ2+wFjOtnt0yWE5clgNf
	MvvvkH7MIp19Wz0aNvzce/yMWKr/TKh1oTOWqjZWGmE39z5YpbuAdk2UdgiYSoe4M9w+OYU/uOLUQ
	wvxpUuVhS9erIZSw07Fri8xHYrORUOJzApp6HwMfQjymkn8OtjldtWS/zMtLzMt8xcgnKXGpPD1fp
	7HJLGLhxkadR0a4H1ajGG+tBtZEKzZwJHRJIIlNdlDDllygpJZe2dEORvFhsVvpMcaTLDeIOWZH1I
	lW+qrqxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyVQg-00DF72-Oo; Wed, 30 Jun 2021 08:18:42 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyVQd-00DF6A-As
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 08:18:40 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D246521BB7;
 Wed, 30 Jun 2021 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625041117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j881EgBeUdzzLtvUgX5P3ldvrD0iac03ldM+zcI/hNw=;
 b=lG3wbKJjtnZ46qZH4lSd9C8PW51D73t0LrTF8jK8ym909cgYEYBPcfYCYZk2x/Su504mbo
 6HJWdSpwhs5pfcnHTJ36vohVHY/1lJphRCzGFMjbiKbqQDI4TaN+/B2BgAYiuoSDL+sMI8
 WfTfk6SR+AtIQumJp+PA7QwL7bf80jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625041117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j881EgBeUdzzLtvUgX5P3ldvrD0iac03ldM+zcI/hNw=;
 b=mn7PCl0AZJyqPGzSB67HTZ77nlZB45OYRLs9nt703VRDlHd5cHqSRnGr6PCOg+Ab59G5ui
 tJZmv8wgu0QgCLDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A8AF711906;
 Wed, 30 Jun 2021 08:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625041117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j881EgBeUdzzLtvUgX5P3ldvrD0iac03ldM+zcI/hNw=;
 b=lG3wbKJjtnZ46qZH4lSd9C8PW51D73t0LrTF8jK8ym909cgYEYBPcfYCYZk2x/Su504mbo
 6HJWdSpwhs5pfcnHTJ36vohVHY/1lJphRCzGFMjbiKbqQDI4TaN+/B2BgAYiuoSDL+sMI8
 WfTfk6SR+AtIQumJp+PA7QwL7bf80jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625041117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j881EgBeUdzzLtvUgX5P3ldvrD0iac03ldM+zcI/hNw=;
 b=mn7PCl0AZJyqPGzSB67HTZ77nlZB45OYRLs9nt703VRDlHd5cHqSRnGr6PCOg+Ab59G5ui
 tJZmv8wgu0QgCLDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id zHyUKN0o3GCfOgAALh3uQQ
 (envelope-from <hare@suse.de>); Wed, 30 Jun 2021 08:18:37 +0000
Subject: Re: [PATCH 0/2] blk-mq: fix blk_mq_alloc_request_hctx
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, John Garry <john.garry@huawei.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5f304121-38ce-034b-2d17-93d136c77fe6@suse.de>
Date: Wed, 30 Jun 2021 10:18:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210629074951.1981284-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_011839_568867_9264291C 
X-CRM114-Status: GOOD (  25.00  )
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

T24gNi8yOS8yMSA5OjQ5IEFNLCBNaW5nIExlaSB3cm90ZToKPiBIaSwKPiAKPiBibGtfbXFfYWxs
b2NfcmVxdWVzdF9oY3R4KCkgaXMgdXNlZCBieSBOVk1lIGZjL3JkbWEvdGNwL2xvb3AgdG8gY29u
bmVjdAo+IGlvIHF1ZXVlLiBBbHNvIHRoZSBzdyBjdHggaXMgY2hvc2VuIGFzIHRoZSAxc3Qgb25s
aW5lIGNwdSBpbiBoY3R4LT5jcHVtYXNrLgo+IEhvd2V2ZXIsIGFsbCBjcHVzIGluIGhjdHgtPmNw
dW1hc2sgbWF5IGJlIG9mZmxpbmUuCj4gCj4gVGhpcyB1c2FnZSBtb2RlbCBpc24ndCB3ZWxsIHN1
cHBvcnRlZCBieSBibGstbXEgd2hpY2ggc3VwcG9zZXMgYWxsb2NhdG9yIGlzCj4gYWx3YXlzIGRv
bmUgb24gb25lIG9ubGluZSBDUFUgaW4gaGN0eC0+Y3B1bWFzay4gVGhpcyBhc3N1bXB0aW9uIGlz
Cj4gcmVsYXRlZCB3aXRoIG1hbmFnZWQgaXJxLCB3aGljaCBhbHNvIHJlcXVpcmVzIGJsay1tcSB0
byBkcmFpbiBpbmZsaWdodAo+IHJlcXVlc3QgaW4gdGhpcyBoY3R4IHdoZW4gdGhlIGxhc3QgY3B1
IGluIGhjdHgtPmNwdW1hc2sgaXMgZ29pbmcgdG8KPiBvZmZsaW5lLgo+IAo+IEhvd2V2ZXIsIE5W
TWUgZmMvcmRtYS90Y3AvbG9vcCBkb24ndCB1c2UgbWFuYWdlZCBpcnEsIHNvIHdlIHNob3VsZCBh
bGxvdwo+IHRoZW0gdG8gYXNrIGZvciByZXF1ZXN0IGFsbG9jYXRpb24gd2hlbiB0aGUgc3BlY2lm
aWVkIGhjdHggaXMgaW5hY3RpdmUKPiAoYWxsIGNwdXMgaW4gaGN0eC0+Y3B1bWFzayBhcmUgb2Zm
bGluZSkuCj4gCj4gRml4IGJsa19tcV9hbGxvY19yZXF1ZXN0X2hjdHgoKSBieSBhZGRpbmcvcGFz
c2luZyBmbGFnIG9mCj4gQkxLX01RX0ZfTk9UX1VTRV9NQU5BR0VEX0lSUS4KPiAKPiAKPiBNaW5n
IExlaSAoMik6Cj4gICAgYmxrLW1xOiBub3QgZGVhY3RpdmF0ZSBoY3R4IGlmIHRoZSBkZXZpY2Ug
ZG9lc24ndCB1c2UgbWFuYWdlZCBpcnEKPiAgICBudm1lOiBwYXNzIEJMS19NUV9GX05PVF9VU0Vf
TUFOQUdFRF9JUlEgZm9yIGZjL3JkbWEvdGNwL2xvb3AKPiAKPiAgIGJsb2NrL2Jsay1tcS5jICAg
ICAgICAgICAgIHwgNiArKysrKy0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgICAgIHwgMyAr
Ky0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyAgIHwgMyArKy0KPiAgIGRyaXZlcnMvbnZt
ZS9ob3N0L3RjcC5jICAgIHwgMyArKy0KPiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jIHwg
MyArKy0KPiAgIGluY2x1ZGUvbGludXgvYmxrLW1xLmggICAgIHwgMSArCj4gICA2IGZpbGVzIGNo
YW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gQ2M6IFNhZ2kgR3Jp
bWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gQ2M6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3Vz
ZS4gdGhlZGU+Cj4gQ2M6IFdlbiBYaW9uZyA8d2VueGlvbmdAdXMuaWJtLmNvbT4KPiBDYzogSm9o
biBHYXJyeSA8am9obi5nYXJyeUBodWF3ZWkuY29tPgo+IAo+IApJIGhhdmUgbXkgbWlzZ2l2aW5n
cyBhYm91dCB0aGlzIHBhdGNoc2V0LgpUbyBteSB1bmRlcnN0YW5kaW5nLCBvbmx5IENQVXMgcHJl
c2VudCBpbiB0aGUgaGN0eCBjcHVtYXNrIGFyZSBlbGlnaWJsZSAKdG8gc3VibWl0IEkvTyB0byB0
aGF0IGhjdHguCkNvbnNlcXVlbnRseSBpZiBhbGwgY3B1cyBpbiB0aGF0IG1hc2sgYXJlIG9mZmxp
bmUsIHdoZXJlIGlzIHRoZSBwb2ludCBvZiAKZXZlbiB0cmFuc21pdHRpbmcgYSAnY29ubmVjdCcg
cmVxdWVzdD8KU2hvdWxkbid0IHdlIHJhdGhlciBtb2RpZnkgdGhlIHRhZ3NldCB0byBvbmx5IHJl
ZmVyIHRvIHRoZSBjdXJyZW50IApvbmxpbmUgQ1BVcyBfb25seV8sIHRoZXJlYnkgbmV2ZXIgc3Vi
bWl0IGEgY29ubmVjdCByZXF1ZXN0IGZvciBoY3R4IHdpdGggCm9ubHkgb2ZmbGluZSBDUFVzPwoK
Q2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtl
cm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBH
ZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
