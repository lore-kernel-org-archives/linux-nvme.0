Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F5CC12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:45:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9024A613BB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9024A613BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=99D+UZt/z7ldgQz1gfmEV0B6xNIqiJi0mI15/WW5ydA=; b=t9hY8GzrDK0QV/
	6cmhMx5pLs2GRK+bEgwHIiSCuaQTMFVxANYLe3H4F+8bqjyJJB6FUCjA5EaYk0hjgrLnWap43es/Z
	WWLN6cElwflrPtqbx8vDWUdUfyeyvMvOxbOgfewspyZdF9XzNbWYhbBk2ckz+hq29Rdk5DxNJXl5l
	xQifWyBRl4Ihuet50NcUfoF3LRFjH/eRV+C/h+PHhWqynjViePQSPr+YI9eRspIDIyngCGNLBQcik
	U+rIim/sMgG4YAomvL29Pfpi17ZKbhoeRpOg2snxeHdRgM/5G+/PlZ6mHHi1lUQ3MtYl93BRcA9px
	fnxCjjuXjdnPO+dvEtbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4IX1-003ZaH-PK; Fri, 16 Jul 2021 07:45:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4IWy-003ZZi-P7
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 07:45:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C84867373; Fri, 16 Jul 2021 09:45:04 +0200 (CEST)
Date: Fri, 16 Jul 2021 09:45:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shai Malin <malin1024@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Shai Malin <smalin@marvell.com>,
 Ariel Elior <aelior@marvell.com>,
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
Subject: Re: [PATCH v4 01/20] nvme-tcp-offload: Add nvme-tcp-offload -
 NVMeTCP HW offload ULP
Message-ID: <20210716074503.GC14800@lst.de>
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-2-pkushwaha@marvell.com> <20210701133424.GB18548@lst.de>
 <CAKKgK4wN49NX+pDff5eFbebeTWBi4aMK9CVMmq4jixgtXHRmQA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKKgK4wN49NX+pDff5eFbebeTWBi4aMK9CVMmq4jixgtXHRmQA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_004509_012420_2D7F5CA4 
X-CRM114-Status: GOOD (  20.07  )
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

T24gTW9uLCBKdWwgMDUsIDIwMjEgYXQgMDY6MDk6NThQTSArMDMwMCwgU2hhaSBNYWxpbiB3cm90
ZToKPiA+ID4gK3N0YXRpYyB2b2lkIF9fZXhpdCBudm1lX3RjcF9vZmxkX2NsZWFudXBfbW9kdWxl
KHZvaWQpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIG52bWZfdW5yZWdpc3Rlcl90cmFuc3BvcnQoJm52
bWVfdGNwX29mbGRfdHJhbnNwb3J0KTsKPiA+ID4gK30KPiA+Cj4gPiBMb29raW5nIGF0IHRoZSBm
aW5hbCByZXN1bHQgdGhpcyBkb2Vzbid0IGRvIG11Y2guICBBc3N1bWluZyB3ZSB3YW50Cj4gPiB0
byBzdXBwb3J0IHRoZXNlIGtpbmRzIG9mIHdoYWNreSBvZmZsb2FkcyAod2hpY2ggSSdkIHJhdGhl
ciBub3QgZG8pLAo+ID4gdGhlIHByb3BlciB3YXkgd291bGQgYmUgdG8gYWxsb3cgcmVnaXN0ZXJp
bmcgbXVsdGlwbGUgdHJhbnNwb3J0X29wcwo+ID4gc3RydWN0dXJlcyBmb3IgYSBnaXZlbiBuYW1l
IHJhdGhlciBhZGRpbmcgYW4gaW5kaXJlY3Rpb24gdGhhdCBkdXBsaWNhdGVzCj4gPiBhIHdob2xl
IGxvdCBvZiBjb2RlLgo+IAo+IEluIHRoYXQgY2FzZSwgd291bGQgeW91IHByZWZlciB0aGF0IHdl
IGludm9rZSB0aGUgdGNwLW9mZmxvYWQgZnJvbQo+IHdpdGhpbiB0aGUgdGNwIGZsb3c/Cj4gU2hv
dWxkIGl0IGJlIHdpdGggdGhlIHNhbWUgdHJhbnNwb3J0IG5hbWUgKOKAnHRjcOKAnSkgb3Igd2l0
aCBhIGRpZmZlcmVudAo+IHRyYW5zcG9ydCBuYW1lICjigJx0Y3Bfb2ZmbG9hZOKAnSk/Cj4gCj4g
QWxzbywgd291bGQgeW91IHByZWZlciB0aGF0IHdlIHJlZ2lzdGVyIHRoZSBvZmZsb2FkIGRldmlj
ZSBkcml2ZXIKPiBkaXJlY3RseSB0byBibGtfbXEgbGF5ZXIgb3IgdGhyb3VnaCB0aGUgdGNwLW9m
ZmxvYWQgbGF5ZXI/CgpBcyBzYWlkLCB3ZSBzaG91bGQgYWxsb3cgdGhlIGRpZmZlcmVudCBvZmZs
b2FkIGRyaXZlcnMgcmVnaXN0ZXIKYXMgdGUgb2ZmbG9hZCB0cmFuc3BvcnQgYW5kIGp1c3QgaXRl
cmF0ZSB0aHJvdWdoIHRoZSBtdWx0aXBsZSBpbnN0YW5jZXMKb2YgdGhlIHRyYW5zcG9ydCB1bnRp
bCB3ZSBmaW5kIGEgbWF0Y2ggaW5zdGVhZCBvZiBkdXBsaWNhdGluZyB0aGUKcmVnaXN0cmF0aW9u
IGluZnJhc3RydWN0dXJlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
