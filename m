Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF483C6377C
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DB9613BB
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 12:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DB9613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oNrNSM69i5niCT79fyHb5QNgKI6V4ZiNsKxOM/GwdbE=; b=t9Q7sXbZDN7HSg
	gs6aKzcXislymwknGexivDfWy904UxmgZyTLv6pG51CeOzxjr0qwBU+/+cCkmYJqZ0x3H5spaVYsc
	z4JbDF5YqwCo9wl1rr4UuC1B3hvP87q/5wMFq3OobSWCKTdvyLgIaeA9ghp+jmW7KPbIprAbGwEaV
	uTc6IbGUej28oWngFNRBZRi5EhxJZTxvvuzCa0GUgRi38whrBzI6YougjCnB/QstwuEPvIvmngNmX
	4cPKED8VbVr0hfdrLeaSRMLMFIT0ra66PV3pyTvasNy7jHTTxOXENKLpLqTA4SJfM82Ryxb4r7G7c
	EoiTRqhosqyz7/wXEIcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4jA7-006Zbg-0L; Sat, 17 Jul 2021 12:11:19 +0000
Received: from vulcan.natalenko.name ([2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m4jA4-006Zb6-A9
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 12:11:18 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 2DE27B3A08A;
 Sat, 17 Jul 2021 14:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626523868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiYmFhPrslmr76pYV3BfLEoydJp7cUW1ZKuTXoytCwI=;
 b=YZujDnMBrkFpzQGzkoFW9B2bWknm9tOvyaVlFaB+Z0/FpJb/lzOjxiPxvN91gpT5iawQnm
 SOPJJ/z8NYNuUJNJbGkhCmznPHAT7GXup8QG19ekSVrgWZeqOntWJJ25P+cufOH5gu8Tne
 3NArO+yn9Q8P1XcFMoPp+BUojmikwCc=
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
Date: Sat, 17 Jul 2021 14:11:05 +0200
Message-ID: <5053297.vgnLoh5Ws3@natalenko.name>
In-Reply-To: <YPKkZJWsD84mmKuk@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <1687461.6WkTYu5mUM@natalenko.name> <YPKkZJWsD84mmKuk@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_051116_536918_D74D0EAD 
X-CRM114-Status: GOOD (  11.94  )
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

T24gc29ib3RhIDE3LiDEjWVydmVuY2UgMjAyMSAxMTozNTozMiBDRVNUIE1pbmcgTGVpIHdyb3Rl
Ogo+IE1heWJlIHlvdSBuZWVkIHRvIGNoZWNrIGlmIHRoZSBidWlsZCBpcyBPSywgSSBjYW4ndCBy
ZXByb2R1Y2UgaXQgaW4gbXkKPiBWTSwgYW5kIEJGUSBpcyBzdGlsbCBidWlsdGluOgo+IAo+IFty
b290QGt0ZXN0LTAxIH5dIyB1bmFtZSAtYQo+IExpbnV4IGt0ZXN0LTAxIDUuMTQuMC1yYzErICM1
MiBTTVAgRnJpIEp1bCAxNiAxODo1NjozNiBDU1QgMjAyMSB4ODZfNjQKPiB4ODZfNjQgeDg2XzY0
IEdOVS9MaW51eCBbcm9vdEBrdGVzdC0wMSB+XSMgY2F0Cj4gL3N5cy9ibG9jay9udm1lMG4xL3F1
ZXVlL3NjaGVkdWxlcgo+IFtub25lXSBtcS1kZWFkbGluZSBreWJlciBiZnEKCkkgZG9uJ3QgdGhp
bmsgdGhpcyBpcyBhbiBpc3N1ZSB3aXRoIHRoZSBidWlsZOKApiBCVFcsIHdpdGggYGluaXRjYWxs
X2RlYnVnYDoKCmBgYApbICAgIDAuOTAyNTU1XSBjYWxsaW5nICBiZnFfaW5pdCsweDAvMHg4YiBA
IDEKWyAgICAwLjkwMzQ0OF0gaW5pdGNhbGwgYmZxX2luaXQrMHgwLzB4OGIgcmV0dXJuZWQgLTI4
IGFmdGVyIDUwNyB1c2VjcwpgYGAKCi1FTk9TUEM/IFdoeT8gQWxzbyByZS10ZXN0ZWQgd2l0aCB0
aGUgbGF0ZXN0IGdpdCB0aXAsIHNhbWUgcmVzdWx0IDooLgoKPiA+IFNvIGZhciB0aGUgaXNzdWUg
aXMgbm90IHJlcHJvZHVjaWJsZSB3aXRoIHlvdXIgcGF0Y2ggKyA1LjEzLjIgYXMgd2VsbCBhcwo+
ID4gNS4xNC0gcmMxIChidXQgSSBkb24ndCBoYXZlIEJGUSBlaXRoZXIgd2l0aCB2NS4xNC1yYzEp
Lgo+IAo+IFlvdSBoYXZlIHRvIHZlcmlmeSBpdCB3aXRoIEJGUSBhcHBsaWVkLCA6LSkKClVuZGVy
c3RhbmRhYmxl4oCmIEJUVywgSSdtIHN0aWxsIHJ1bm5pbmcgdjUuMTMuMiB3aXRoIHlvdXIgcGF0
Y2ggYXBwbGllZCBhbmQgZG8gCm5vdCBzZWUgdGhlIGlzc3VlLgoKLS0gCk9sZWtzYW5kciBOYXRh
bGVua28gKHBvc3QtZmFjdHVtKQoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
