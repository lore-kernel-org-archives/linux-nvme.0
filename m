Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E098FC636C9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:20:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81EA861183
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EA861183
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V4sDIObv+49y38I5Kfh1W+P43/2ykDeHAGWS0yF0tfc=; b=mxy0/zJkQL7OYg
	jHbmDaDvn/MtOEPvSG9CSZdg+PfvIhUQ+RSiIgfhcoS+O737wQHJ2UQez5vsbaPeRJItTCvbdLHtG
	w1/v6TMYXQab7Bg3GNa62qDLZLLTkiIm3b520XDrIrKG0LpeDGxaCELz7YHq7+HwX7CCE+iiv5MWS
	KnJAwiaanYh8R/vw34VR0KGXUg2+YLw4zNE4+B8VQOZTlJp9pm2LBRSF2GsE2MrhtjaUplTf3nwwi
	M3WOYKWSi9UICNCWNRVAlUMcrx19uAI6M3kXeo1ZLgCFk2ACShhLL+P69eTxfrGHSrE6W0qy6efPc
	44w8i50fmEPcAaZbaLHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4jId-006aZj-6m; Sat, 17 Jul 2021 12:20:07 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4jIZ-006aYZ-P3
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 12:20:05 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 6924EB3A0CD;
 Sat, 17 Jul 2021 14:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626524401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gcD4BlYO0MJODsDv5lWH6aB5PZKfy3UHMX4EeHIRze0=;
 b=UKdaankAPr0jcxwYSuFajzao+2C+/kY0QI+E6w340ovOHUIsN1phoIGsFcMj9LIFiZOpM2
 +/dLezd7sR5sIby7C34UAOCtGj9Y1wmx+8vTOlWE2cyeaaKQiOyiGU2sRcv/a+z2KYX183
 +5HO5bMs8da6m8YE4NcwQWxmw40YKVo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Sat, 17 Jul 2021 14:19:59 +0200
Message-ID: <8988303.mDXGIdCtx8@natalenko.name>
In-Reply-To: <5053297.vgnLoh5Ws3@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name> <YPKkZJWsD84mmKuk@T590>
 <5053297.vgnLoh5Ws3@natalenko.name>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_052004_009119_ED5F04AC 
X-CRM114-Status: GOOD (  12.32  )
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

T24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDoxMTowNSBDRVNUIE9sZWtzYW5kciBOYXRh
bGVua28gd3JvdGU6Cj4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxMTozNTozMiBDRVNU
IE1pbmcgTGVpIHdyb3RlOgo+ID4gTWF5YmUgeW91IG5lZWQgdG8gY2hlY2sgaWYgdGhlIGJ1aWxk
IGlzIE9LLCBJIGNhbid0IHJlcHJvZHVjZSBpdCBpbiBteQo+ID4gVk0sIGFuZCBCRlEgaXMgc3Rp
bGwgYnVpbHRpbjoKPiA+IAo+ID4gW3Jvb3RAa3Rlc3QtMDEgfl0jIHVuYW1lIC1hCj4gPiBMaW51
eCBrdGVzdC0wMSA1LjE0LjAtcmMxKyAjNTIgU01QIEZyaSBKdWwgMTYgMTg6NTY6MzYgQ1NUIDIw
MjEgeDg2XzY0Cj4gPiB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eCBbcm9vdEBrdGVzdC0wMSB+XSMg
Y2F0Cj4gPiAvc3lzL2Jsb2NrL252bWUwbjEvcXVldWUvc2NoZWR1bGVyCj4gPiBbbm9uZV0gbXEt
ZGVhZGxpbmUga3liZXIgYmZxCj4gCj4gSSBkb24ndCB0aGluayB0aGlzIGlzIGFuIGlzc3VlIHdp
dGggdGhlIGJ1aWxk4oCmIEJUVywgd2l0aCBgaW5pdGNhbGxfZGVidWdgOgo+IAo+IGBgYAo+IFsg
ICAgMC45MDI1NTVdIGNhbGxpbmcgIGJmcV9pbml0KzB4MC8weDhiIEAgMQo+IFsgICAgMC45MDM0
NDhdIGluaXRjYWxsIGJmcV9pbml0KzB4MC8weDhiIHJldHVybmVkIC0yOCBhZnRlciA1MDcgdXNl
Y3MKPiBgYGAKPiAKPiAtRU5PU1BDPyBXaHk/IEFsc28gcmUtdGVzdGVkIHdpdGggdGhlIGxhdGVz
dCBnaXQgdGlwLCBzYW1lIHJlc3VsdCA6KC4KCk9LLCBvbmUgZXh0cmEgcHJfaW5mbywgYW5kIEkg
c2VlIHRoaXM6CgpgYGAKWyAgICAwLjg3MTE4MF0gYmxrY2dfcG9saWN5X3JlZ2lzdGVyOiBCTEtD
R19NQVhfUE9MUyB0b28gc21hbGwKWyAgICAwLjg3MTYxMl0gYmxrY2dfcG9saWN5X3JlZ2lzdGVy
OiAtMjgKYGBgCgpXaGF0IGRvZXMgaXQgbWVhbiBwbGVhc2UgOik/IFRoZSB2YWx1ZSBzZWVtcyB0
byBiZSBoYXJkLWNvZGVkOgoKYGBgCmluY2x1ZGUvbGludXgvYmxrZGV2LmgKNjA6I2RlZmluZSBC
TEtDR19NQVhfUE9MUyAgICAgICAgICAgICAgIDUKYGBgCgotLSAKT2xla3NhbmRyIE5hdGFsZW5r
byAocG9zdC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
