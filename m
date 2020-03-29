Return-Path: <SRS0=sr50=5O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219EC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 11:39:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFBA9206DB
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Mar 2020 11:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CAKYS2K9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rsc-tech-ru.20150623.gappssmtp.com header.i=@rsc-tech-ru.20150623.gappssmtp.com header.b="bUUGg6ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBA9206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rsc-tech.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rmmQAfbPeRMgoqz3c1jMFNjiNSDMvi5/Mp8iKBpjY9c=; b=CAKYS2K9M7gPTb
	GB3eWkl7ldA94jJ5z48KLzGdIpIRo2PC2rlKKnXAiI6M274iL1oLXPl5BeUI6mtJCrCK9Ds16POl0
	yNvBbakhb1/sJH7FoFbEilZJJAy4COCXE61KIBds/fLDpXol0xd+StRxsng902H4pEyJFVAOo51OJ
	HKnZZTCmKuHzgXLm7QE28PmzqDXSPaKBhHysJ1TpxyhipwnyjMuxoKIZGKM0soqO1qVTRK+5OfgFY
	TDL71vTlrBAyf9UbaGIWUjgOgMXfJZTSz2a2uCbficBY5XgBgGp48fjjJN/nVTDMuCucWMPDMpJkT
	Oy3FA7l9meYwCA+rjwkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIWHX-0003Yb-51; Sun, 29 Mar 2020 11:39:11 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIWHT-0003Y3-Iz
 for linux-nvme@lists.infradead.org; Sun, 29 Mar 2020 11:39:09 +0000
Received: by mail-lf1-x135.google.com with SMTP id c5so11548803lfp.5
 for <linux-nvme@lists.infradead.org>; Sun, 29 Mar 2020 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rsc-tech-ru.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zrBozJY9WESSiQPnAMptLWSYZOt0BAd+w9GyK86if5Y=;
 b=bUUGg6ka4WGAOr/JQaPWk9m6ESfWaXFAdf6siDkK50ORFFhcpKkMpeA/emS8kYVwwy
 kVsQ1Wptis7mOC8q07oF3/y+nAqzO3OuR8lzwn36ILP3o9qrUXV3pDl9FLqNkQmO9EfH
 8XULQ07kcqT2u9pVZp8e0CGZDppgzTUHTSEuehlUmWvig5cxbagRc37ancAY/Mut9DuQ
 uqyD/0fnMeNcoFB+0zasVJDYbbBb4S8NLApQCgQ4MdCOcq0j8yjMn8OMlLfnjlKsl3bq
 6e1RebAgxQXyUSF7ntPSQnPvp3Au8t7x9vNZs0x5Xe8REo98v7oWxnccJlHW63CL/mW+
 Ofmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zrBozJY9WESSiQPnAMptLWSYZOt0BAd+w9GyK86if5Y=;
 b=tF8PthbRP4KVSmrfftE6p7R9WsRZXv/wArXAr+LUXVGYP8BfJVaLFLK5ruiaClLcBi
 aktDCMk95Gke4hYvChGc9mzznlbAr0nMFtSrrAScQpQoRlb1aUXJ72wEa22riqZGy/t4
 o+sPkRmW6e8aZcuRkj2VcCCfgPrC0xEZbp0ESexxSGYikljk6pRqr5sfvk9qhT/1Hafi
 y4gVjAMKSS5IHvKhFPYbiMstD91a11uzvQa513l+4WNFGD9UhyXc+S3szLwqrJSl1L0w
 OsKPAXuk3TERsatrJaFV/uJZXqT5Gs5eGM83KHvAvjm1XgeH6TLSQdFk85tRGIzP5HuL
 V7KQ==
X-Gm-Message-State: AGi0PuZuycEAX1Lq9+/Miq8BsvLRarpbsHEBG9kNWuyaRQx3mvRThMuP
 qjDxCdwnohvEoJtUHh7Y5diJX1GpIzrxihCA3NSpuQ==
X-Google-Smtp-Source: APiQypJCafTyuNS5VnkOlmqqMCxqNXEIyvFXgESV8DvvTvm4jeHeGuI0Ff2hW3KM6icC37CGhca7rC1pr0c2r0+XP8g=
X-Received: by 2002:a19:c210:: with SMTP id l16mr2976161lfc.85.1585481943328; 
 Sun, 29 Mar 2020 04:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <CABY-YC7eHFjb-TpKf2ioPJNhZ8RccYsrR-oU=wmt26z9AUNebg@mail.gmail.com>
 <a7da72d0-ed3f-ab5c-a72b-1b0518436a2e@grimberg.me>
 <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
In-Reply-To: <e4f3f68d-a4a7-e799-c3b8-1d600e3888b5@mellanox.com>
From: Anton Brekhov <anton.brekhov@rsc-tech.ru>
Date: Sun, 29 Mar 2020 14:38:52 +0300
Message-ID: <CABY-YC4jSOZJW2zEx5dS9BRj8+ipNF5aF_0cgkuDo9oaLbhvew@mail.gmail.com>
Subject: Re: NVMe Over Fabrics Disconnect Kernel error
To: Max Gurtovoy <maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200329_043907_689470_D45EC0BA 
X-CRM114-Status: GOOD (  13.09  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Konstantin Ponomarev <k.ponomarev@rsc-tech.ru>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TWF4LApUaGlzIGVycm9yIHdlJ3ZlIG9idGFpbmVkIHdoaWxlIHVzaW5nIHRoZSBsYXRlc3QgcmVs
ZWFzZSBvZiBudm1lLWNsaToKW3Jvb3RAczAycDAwNSB+XSMgbnZtZSB2ZXJzaW9uCm52bWUgdmVy
c2lvbiAxLjEwLjEKCk9yIHRoZXJlIHdlcmUgc29tZSBtYWpvciBjaGFuZ2VzIGFmdGVyIGxhdGVz
dCByZWxlYXNlPwpUaGFua3MuCgrQstGBLCAyOSDQvNCw0YAuIDIwMjAg0LMuINCyIDExOjUxLCBN
YXggR3VydG92b3kgPG1heGdAbWVsbGFub3guY29tPjoKPgo+Cj4gT24gMy8yOS8yMDIwIDc6MTQg
QU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gPgo+ID4+IEdyZWV0aW5ncyEKPiA+Pgo+ID4+IFdl
J3JlIHVzaW5nIG52bWUtY2xpIHRlY2hub2xvZ3kgd2l0aCBaRlMgYW5kIEx1c3RyZSBGaWxlc3lz
dGVtIG9uIHRvcAo+ID4+IG9mIGl0Lgo+ID4+IEJ1dCB3ZSBjb25zdGFudGx5IGNvbWUgYWNyb3Nz
IGEga2VybmVsIGVycm9yIHdoaWxlIGRpc2Nvbm5lY3RpbmcKPiA+PiByZW1vdGUgZGlza3MgZnJv
bSBzd2l0Y2hlZCBvZmYgbm9kZXM6Cj4gPj4gYGBgCj4gPj4gWyAgKzAsMDAwMDg5XSBJTkZPOiB0
YXNrIGt3b3JrZXIvdTU5MzowOjgyMjkzIGJsb2NrZWQgZm9yIG1vcmUgdGhhbgo+ID4+IDEyMCBz
ZWNvbmRzLgo+ID4+IFsgICswLDAwMTk1OV0gImVjaG8gMCA+IC9wcm9jL3N5cy9rZXJuZWwvaHVu
Z190YXNrX3RpbWVvdXRfc2VjcyIKPiA+PiBkaXNhYmxlcyB0aGlzIG1lc3NhZ2UuCj4gPj4gWyAg
KzAsMDAxOTQxXSBrd29ya2VyL3U1OTM6MCAgRCBmZmZmOTBlODQ5M2ZlMmEwICAgICAwIDgyMjkz
ICAgICAgMgo+ID4+IDB4MDAwMDAwODAKPiA+PiBbICArMCwwMDAwMzFdIFdvcmtxdWV1ZTogbnZt
ZS1kZWxldGUtd3EgbnZtZV9kZWxldGVfY3RybF93b3JrCj4gPj4gW252bWVfY29yZV0KPiA+PiBb
ICArMCwwMDAwMDNdIENhbGwgVHJhY2U6Cj4gPj4gWyAgKzAsMDAwMDA4XSAgWzxmZmZmZmZmZjgx
NzdmMjI5Pl0gc2NoZWR1bGUrMHgyOS8weDcwCj4gPj4gWyAgKzAsMDAwMDEwXSAgWzxmZmZmZmZm
ZjgxMzU4ZTg1Pl0gYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0KzB4NzUvMHhlMAo+ID4+IFsgICsw
LDAwMDAwN10gIFs8ZmZmZmZmZmY4MTBjNjFjMD5dID8gd2FrZV91cF9hdG9taWNfdCsweDMwLzB4
MzAKPiA+PiBbICArMCwwMDAwMDZdICBbPGZmZmZmZmZmODEzNTljYjQ+XSBibGtfZnJlZXplX3F1
ZXVlKzB4MjQvMHg1MAo+ID4+IFsgICswLDAwMDAwOV0gIFs8ZmZmZmZmZmY4MTM0ZTBlZj5dIGJs
a19jbGVhbnVwX3F1ZXVlKzB4N2YvMHgxYjAKPiA+PiBbICArMCwwMDAwMTJdICBbPGZmZmZmZmZm
YzAzMTE1OGU+XSBudm1lX25zX3JlbW92ZSsweDhlLzB4YjAgW252bWVfY29yZV0KPiA+PiBbICAr
MCwwMDAwMTFdICBbPGZmZmZmZmZmYzAzMTE3NGI+XSBudm1lX3JlbW92ZV9uYW1lc3BhY2VzKzB4
YWIvMHhmMAo+ID4+IFtudm1lX2NvcmVdCj4gPj4gWyAgKzAsMDAwMDEyXSAgWzxmZmZmZmZmZmMw
MzExN2UyPl0gbnZtZV9kZWxldGVfY3RybF93b3JrKzB4NTIvMHg4MAo+ID4+IFtudm1lX2NvcmVd
Cj4gPj4gWyAgKzAsMDAwMDA4XSAgWzxmZmZmZmZmZjgxMGJkMGZmPl0gcHJvY2Vzc19vbmVfd29y
aysweDE3Zi8weDQ0MAo+ID4+IFsgICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTBiZTM2OD5dIHdv
cmtlcl90aHJlYWQrMHgyNzgvMHgzYzAKPiA+PiBbICArMCwwMDAwMDZdICBbPGZmZmZmZmZmODEw
YmUwZjA+XSA/IG1hbmFnZV93b3JrZXJzLmlzcmEuMjYrMHgyYTAvMHgyYTAKPiA+PiBbICArMCww
MDAwMDVdICBbPGZmZmZmZmZmODEwYzUwZDE+XSBrdGhyZWFkKzB4ZDEvMHhlMAo+ID4+IFsgICsw
LDAwMDAwNl0gIFs8ZmZmZmZmZmY4MTBjNTAwMD5dID8gaW5zZXJ0X2t0aHJlYWRfd29yaysweDQw
LzB4NDAKPiA+PiBbICArMCwwMDAwMDZdICBbPGZmZmZmZmZmODE3OGNkMWQ+XSByZXRfZnJvbV9m
b3JrX25vc3BlY19iZWdpbisweDcvMHgyMQo+ID4+IFsgICswLDAwMDAwNl0gIFs8ZmZmZmZmZmY4
MTBjNTAwMD5dID8gaW5zZXJ0X2t0aHJlYWRfd29yaysweDQwLzB4NDAKPiA+PiBgYGAKPiA+PiBO
b2RlcyBjaGFyYWN0ZXJpc3RpY3M6Cj4gPj4gW3Jvb3RAczAycDAwNSB+XSMgdW5hbWUgLXNybQo+
ID4+IExpbnV4IDMuMTAuMC0xMDYyLjEuMS5lbDcueDg2XzY0IHg4Nl82NAo+ID4+IFtyb290QHMw
MnAwMDUgfl0jIGNhdCAvZXRjL3JlZGhhdC1yZWxlYXNlCj4gPj4gQ2VudE9TIExpbnV4IHJlbGVh
c2UgNy43LjE5MDggKENvcmUpCj4gPj4KPiA+PiBXaGVyZSdyZSB1c2luZyBudm1ldF9yZG1hLgo+
ID4+IElzIHRoZXJlIGFueSB3b3JrYXJvdW5kIGZvciBzdWNoIGVycm9yPwo+ID4KPiA+IEl0IHNl
ZW1zIGxpa2UgcXVldWUgZnJlZXplIGlzIHN0dWNrLiBDYW4geW91IHNoYXJlIG1vcmUgb2YgdGhl
Cj4gPiB0cmFjZSBzbyB3ZSBjYW4gc2VlIHdoYXQgZWxzZSBpcyBibG9ja2luZz8gSWYgbm90LCB3
aGVuCj4gPiBpdCByZXByb2R1Y2VzIHJ1biBlY2hvIHQgPiAvcHJvYy9zeXNycS10cmlnZ2VyIGFu
ZCBzaGFyZSB0aGUKPiA+IGxvZy4KPgo+IEFudG9uLAo+Cj4gQ2FuIHlvdSByZXBybyB0aGlzIHdp
dGggbGF0ZXN0IG52bWUgYnJhbmNoID8gb3Igb25seSBpbmJveCBDZW50b3M3LjcgPwo+Cj4KPiA+
Cj4gPiBUaGFua3MuCj4gPgo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiA+IGxpbnV4LW52bWUgbWFpbGluZyBsaXN0Cj4gPiBsaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKPiA+IGh0dHBzOi8vZXVyMDMuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMuaW5mcmFkZWFkLm9yZyUyRm1haWxt
YW4lMkZsaXN0aW5mbyUyRmxpbnV4LW52bWUmYW1wO2RhdGE9MDIlN0MwMSU3Q21heGclNDBtZWxs
YW5veC5jb20lN0NiOGEyY2NmNjA5YmU0ZTc3YzA5YTA4ZDdkMzk3YmUwZiU3Q2E2NTI5NzFjN2Qy
ZTRkOWJhNmE0ZDE0OTI1NmY0NjFiJTdDMCU3QzAlN0M2MzcyMTA1MjA5ODU2ODY2ODgmYW1wO3Nk
YXRhPTlpWVJXUnAyTHRJVmVmZGZlJTJCTjR2cWoyV01MVEpDQnlQdmJ6cnlhaUE3NCUzRCZhbXA7
cmVzZXJ2ZWQ9MAo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
