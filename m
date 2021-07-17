Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10206C636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8633611C1
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8633611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Mi5dGu6/fDr2RWFG1ws/8j7HCrAwS/BE8Um7nNWk32g=; b=nRaPm99ZEd3Zr0
	oJQtk4yNsU81gXLApyPcCYoi6bOfdzxL+08g61ZAyXycSvgGUurl4giwdlReivezbpYzOp3sjxbyH
	R+mztyfTa1KtJLkj6lfU+WhdzGUix4FtDsOMHkm1hMbiuWhvcoKkta4RUQoryf5hk+NQqcw8b6lCU
	ybs8jsRCxXGfC9Xgdn66gXcAA/R9q345DCse0Jxmz757lktrJXYusMxGTa3a7b9kCJjAZb6bjWjJ3
	294xUOLrgZ1sbYHDgcqp0r6VaK7Z6e82hps75xQwHpRxY0gPJBs5D7PYf31d0m6JO+MlPO1SGywVZ
	h3rlT8NikZs1kjr+gNkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4jXM-006bcI-DF; Sat, 17 Jul 2021 12:35:20 +0000
Received: from vulcan.natalenko.name ([2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m4jXJ-006bbw-DK
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 12:35:19 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id DB435B3A141;
 Sat, 17 Jul 2021 14:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626525316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwPW8ZBvYJ1j6+zanxZpBpf+XE4okDGSxJ4O6NxNGC4=;
 b=OgUN6xJYnj2LxCuxDio9SMp9DICiOTdRp2n7hAcLY2ZuQERSVY9LN892F+OClOEZO1Jiqz
 TW4GliCHxiv9WwwKctKqqFOL8A0bE+g4tBLkrnwBVs2CW7H4MnUl+6h7qlKN52v3IspiVW
 qzCa3bBmWlkrI3uUXnBzhCkXhusGrLg=
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
Date: Sat, 17 Jul 2021 14:35:14 +0200
Message-ID: <3383530.3bVf3B8HMu@natalenko.name>
In-Reply-To: <8988303.mDXGIdCtx8@natalenko.name>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <5053297.vgnLoh5Ws3@natalenko.name> <8988303.mDXGIdCtx8@natalenko.name>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_053517_646102_7F4B0A02 
X-CRM114-Status: GOOD (  15.17  )
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

T24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDoxOTo1OSBDRVNUIE9sZWtzYW5kciBOYXRh
bGVua28gd3JvdGU6Cj4gT24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxNDoxMTowNSBDRVNU
IE9sZWtzYW5kciBOYXRhbGVua28gd3JvdGU6Cj4gPiBPbiBzb2JvdGEgMTcuIMSNZXJ2ZW5jZSAy
MDIxIDExOjM1OjMyIENFU1QgTWluZyBMZWkgd3JvdGU6Cj4gPiA+IE1heWJlIHlvdSBuZWVkIHRv
IGNoZWNrIGlmIHRoZSBidWlsZCBpcyBPSywgSSBjYW4ndCByZXByb2R1Y2UgaXQgaW4gbXkKPiA+
ID4gVk0sIGFuZCBCRlEgaXMgc3RpbGwgYnVpbHRpbjoKPiA+ID4gCj4gPiA+IFtyb290QGt0ZXN0
LTAxIH5dIyB1bmFtZSAtYQo+ID4gPiBMaW51eCBrdGVzdC0wMSA1LjE0LjAtcmMxKyAjNTIgU01Q
IEZyaSBKdWwgMTYgMTg6NTY6MzYgQ1NUIDIwMjEgeDg2XzY0Cj4gPiA+IHg4Nl82NCB4ODZfNjQg
R05VL0xpbnV4IFtyb290QGt0ZXN0LTAxIH5dIyBjYXQKPiA+ID4gL3N5cy9ibG9jay9udm1lMG4x
L3F1ZXVlL3NjaGVkdWxlcgo+ID4gPiBbbm9uZV0gbXEtZGVhZGxpbmUga3liZXIgYmZxCj4gPiAK
PiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhbiBpc3N1ZSB3aXRoIHRoZSBidWlsZOKApiBCVFcs
IHdpdGggYGluaXRjYWxsX2RlYnVnYDoKPiA+IAo+ID4gYGBgCj4gPiBbICAgIDAuOTAyNTU1XSBj
YWxsaW5nICBiZnFfaW5pdCsweDAvMHg4YiBAIDEKPiA+IFsgICAgMC45MDM0NDhdIGluaXRjYWxs
IGJmcV9pbml0KzB4MC8weDhiIHJldHVybmVkIC0yOCBhZnRlciA1MDcgdXNlY3MKPiA+IGBgYAo+
ID4gCj4gPiAtRU5PU1BDPyBXaHk/IEFsc28gcmUtdGVzdGVkIHdpdGggdGhlIGxhdGVzdCBnaXQg
dGlwLCBzYW1lIHJlc3VsdCA6KC4KPiAKPiBPSywgb25lIGV4dHJhIHByX2luZm8sIGFuZCBJIHNl
ZSB0aGlzOgo+IAo+IGBgYAo+IFsgICAgMC44NzExODBdIGJsa2NnX3BvbGljeV9yZWdpc3Rlcjog
QkxLQ0dfTUFYX1BPTFMgdG9vIHNtYWxsCj4gWyAgICAwLjg3MTYxMl0gYmxrY2dfcG9saWN5X3Jl
Z2lzdGVyOiAtMjgKPiBgYGAKPiAKPiBXaGF0IGRvZXMgaXQgbWVhbiBwbGVhc2UgOik/IFRoZSB2
YWx1ZSBzZWVtcyB0byBiZSBoYXJkLWNvZGVkOgo+IAo+IGBgYAo+IGluY2x1ZGUvbGludXgvYmxr
ZGV2LmgKPiA2MDojZGVmaW5lIEJMS0NHX01BWF9QT0xTICAgICAgICAgICAgICAgNQo+IGBgYAoK
T0ssIGFmdGVyIGluY3JlYXNpbmcgdGhpcyB0byA2IEkndmUgZ290IG15IEJGUSBiYWNrLiBQbGVh
c2Ugc2VlIFsxXS4KClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDIx
MDcxNzEyMzMyOC45NDU4MTAtMS1vbGVrc2FuZHJAbmF0YWxlbmtvLm5hbWUvCgotLSAKT2xla3Nh
bmRyIE5hdGFsZW5rbyAocG9zdC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
