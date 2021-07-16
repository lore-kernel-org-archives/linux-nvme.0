Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF0EC07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 12:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC9C613E3
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 12:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC9C613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5lqU/N6PfzsfW2qBKwjij22ZNHbSpL7j4dP21Ctnpc=; b=Sl7YD3mXsvLDgO
	U5jmD/rhRMC0H2nrKMocY10UqX2apWNMwnu7NrMrGZ3lLJvA6fk2t32w6yo3rvG2bKcgJl+qW4xPT
	HrqmFPTmmassuIjTdoS2pQGWxi6e98fzdELyOgd/8mpK1P205ZT9lxU49Dac1wUkkfwv6nQsM2Ya+
	7PqOh05QSUvvrDwJI0tLcydOIppcq6pQ6ikIX9WB2Pl6AvyxPdKVZ18i+sjTsZUNFMDqZmSokxUj9
	/SW3GeAVktsf/bXeEtgKo0pqCgZEkzEhwZlQ3BAmcAoPt+tQafxq/3ZYCeTRVngSnHBNc7Z5yQfVv
	iTtnDX7Zi6h3tD4SgEoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4NOI-004PDv-Oi; Fri, 16 Jul 2021 12:56:30 +0000
Received: from vulcan.natalenko.name ([2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m4NOF-004PDJ-T2
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 12:56:29 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id 2D03BB37ED7;
 Fri, 16 Jul 2021 14:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1626440184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sdNG86x5tAHY5kRYAKVl3QeUKKUSEoSK6HtMC+ianxA=;
 b=rXsqa7AbS+FmuQaz9U6i68cIAiWgJZosBiV+kq0TDBFydFZOE6o1IdwhEKGKjRnoJgMk+o
 gOly5ZBAR5BYA1SaK+xANX34NDhuxQPowQ8Gnc46GAtoNTHELTir/MH+Cx3uhfAp3Noj3b
 VopDjLK2JsofkDMHxoeK4mZ8+RGdh50=
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
Date: Fri, 16 Jul 2021 14:56:22 +0200
Message-ID: <1687461.6WkTYu5mUM@natalenko.name>
In-Reply-To: <YPFicCW90Jse4oms@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <2455133.St5lIfLNcX@natalenko.name> <YPFicCW90Jse4oms@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_055628_288256_EF478466 
X-CRM114-Status: GOOD (  11.86  )
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

T24gcMOhdGVrIDE2LiDEjWVydmVuY2UgMjAyMSAxMjo0MTo1MiBDRVNUIE1pbmcgTGVpIHdyb3Rl
Ogo+ID4gRG8gSSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGF0IHRoaXMgd2lsbCBiZSBzb21ldGhp
bmcgbGlrZToKPiA+IAo+ID4gRml4ZXM6IDI3MDVkZmIyMDkgKCJibG9jazogZml4IGRpc2NhcmQg
cmVxdWVzdCBtZXJnZSIpCj4gPiAKPiA+ID8KPiA+IAo+ID4gQmVjYXVzZSBhcyB0aGUgYmlzZWN0
aW9uIHByb2dyZXNzZXMsIEkndmUgYnVtcGVkIGludG8gdGhpcyBjb21taXQgb25seS4KPiA+IFdp
dGhvdXQgaXQgdGhlIGlzc3VlIGlzIG5vdCByZXByb2R1Y2libGUsIGF0IGxlYXN0IHNvIGZhci4K
PiAKPiBJdCBjb3VsZCBiZS4KPiAKPiBTbyBjYW4geW91IGp1c3QgdGVzdCB2NS4xNC1yYzE/CgpE
b2luZyBpdCByaWdodCBub3csIGJ1dCBJJ3ZlIGdvdCBhbm90aGVyIGlzc3VlLiBXaHkgQkZRIGlz
IG5vdCBsaXN0ZWQgaGVyZToKCmBgYAovc3lzL2NsYXNzL2Jsb2NrL252bWUwbjEvcXVldWUvc2No
ZWR1bGVyOlttcS1kZWFkbGluZV0ga3liZXIgbm9uZQovc3lzL2NsYXNzL2Jsb2NrL252bWUxbjEv
cXVldWUvc2NoZWR1bGVyOlttcS1kZWFkbGluZV0ga3liZXIgbm9uZQpgYGAKCj8KCkl0IGlzIGEg
YnVpbHQtaW4sIEZXSVc6CgpgYGAKJCBtb2RpbmZvIGJmcQpuYW1lOiAgICAgICAgICAgYmZxCmZp
bGVuYW1lOiAgICAgICAoYnVpbHRpbikKZGVzY3JpcHRpb246ICAgIE1RIEJ1ZGdldCBGYWlyIFF1
ZXVlaW5nIEkvTyBTY2hlZHVsZXIKbGljZW5zZTogICAgICAgIEdQTApmaWxlOiAgICAgICAgICAg
YmxvY2svYmZxCmF1dGhvcjogICAgICAgICBQYW9sbyBWYWxlbnRlCmFsaWFzOiAgICAgICAgICBi
ZnEtaW9zY2hlZApgYGAKClNvIGZhciB0aGUgaXNzdWUgaXMgbm90IHJlcHJvZHVjaWJsZSB3aXRo
IHlvdXIgcGF0Y2ggKyA1LjEzLjIgYXMgd2VsbCBhcyA1LjE0LQpyYzEgKGJ1dCBJIGRvbid0IGhh
dmUgQkZRIGVpdGhlciB3aXRoIHY1LjE0LXJjMSkuCgotLSAKT2xla3NhbmRyIE5hdGFsZW5rbyAo
cG9zdC1mYWN0dW0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
