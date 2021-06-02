Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77177C4708F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 22:52:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24C09613E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 22:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C09613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bJmJc80Hhy3Ju8TLvaoewF4sd/VM3tVzPwClkXE0jqM=; b=1vAYnL6AZn50Qg
	GCBlo6NbcW76/WjkpNOtfdw4cnt/TzOH0WebBQH67f4Gov8N3dc+d8KEXXS2S5rQbReunDxNnG8fb
	dzFI93UedZLAqe5gdU3PXguVlF+5/KgGKDi/OBWSJ+FqXOhILSyfbn7tJJvwyR1HIswmUpPWlBKaI
	3mjepmcG/IkNXLcm0Stw/b/HrcJruN2y1ikxJ53GskuSN4C5kyD/UtFc66tZFJd5aqOzSdpc3JVC9
	U/2ABRqlPcCYsj7Jtwv6exeEzH1dV0sGhFyobQZqXFZDGNyX99xg5U5dhxspX8jZoSXFhqcywEqMR
	JSmENv8Rt2APlZt50vJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loZiD-006Q4J-I5; Wed, 02 Jun 2021 22:51:45 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loZiB-006Q0h-8R
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 22:51:44 +0000
IronPort-SDR: hpIzKORZAZZkvqGY6IDB9Y0DnTnM8tbEq5HYjWXx3ocIoPHHGtbb1W9VqeaRpdpR696AGTcR1t
 ZgfTwdvi4zqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="184285173"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="184285173"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 15:49:38 -0700
IronPort-SDR: rNhRJ2xo3kwM6tir1AvW30tn821t94TXT/k67tvk6iBd4TKBBjiPLnOAEMSE//6PnvqJPmLXi/
 hNpA4scfFnuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="438573895"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga007.jf.intel.com with ESMTP; 02 Jun 2021 15:49:38 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.54.75.174])
 by linux.intel.com (Postfix) with ESMTP id 792825805A1;
 Wed,  2 Jun 2021 15:49:38 -0700 (PDT)
Message-ID: <7ff9423dc806f1354e51dbb69dea9b70dd8c6eea.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
From: "David E. Box" <david.e.box@linux.intel.com>
To: "Limonciello, Mario" <mario.limonciello@amd.com>, Christoph Hellwig
 <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
 "rrangel@chromium.org" <rrangel@chromium.org>, "Shyam-sundar.S-k@amd.com"
 <Shyam-sundar.S-k@amd.com>,  "Alexander.Deucher@amd.com"
 <Alexander.Deucher@amd.com>, "prike.liang@amd.com" <prike.liang@amd.com>, 
 "Derrick, Jonathan" <jonathan.derrick@intel.com>, "N, Shyjumon"
 <shyjumon.n@intel.com>
Date: Wed, 02 Jun 2021 15:49:38 -0700
In-Reply-To: <474a58bf-dcc9-48a8-c5ce-fb79f2b76a79@amd.com>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
 <20210531064655.GA1417@lst.de>
 <PH0PR11MB4853EBD21B8D89AC8138308F9E3E9@PH0PR11MB4853.namprd11.prod.outlook.com>
 <474a58bf-dcc9-48a8-c5ce-fb79f2b76a79@amd.com>
Organization: David E. Box
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_155143_335200_3CE4AB86 
X-CRM114-Status: GOOD (  24.60  )
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
Reply-To: david.e.box@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgTWFyaW8sCgpUaGUgcGF0Y2ggd29ya3MgZm9yIHN5c3RlbXMgdGhhdCB3b3JrZWQgb24gdGhl
IGN1cnJlbnQgaW1wbGVtZW50YXRpb24uClRoYW5rcy4KClJldmlld2VkLWJ5OiBEYXZpZCBFLiBC
b3ggPGRhdmlkLmUuYm94QGxpbnV4LmludGVsLmNvbT4KCk9uIFR1ZSwgMjAyMS0wNi0wMSBhdCAx
MDoxNSAtMDUwMCwgTGltb25jaWVsbG8sIE1hcmlvIHdyb3RlOgo+ID4gCj4gPiBJIHRoaW5rIHdl
IG5lZWQgdG8gd2FpdCBmb3IgdGhlIGNvbmZpcm1hdGlvbiBmcm9tIERhdmlkLsKgIFRoaXMgbG9v
a3MKPiA+IGdvb2QsIGJ1dCBJJ2QgbGlrZSB0byBzZWUgdGVzdGluZy7CoCBJIGFsc28gd29uZGVy
IGhvdyBtYW55IG9mIHRoZQo+ID4gc2ltcGxlIHN1c3BlbmQgcXVpcmtzIHdlIGNhbiBkcm9wIHdp
dGggdGhpcy4KPiAKPiBEYXZpZCwgZG8geW91IHRoaW5rIHlvdSBjYW4gZ2V0IHRoaXMgc29vbmlz
aCBvciBhcmUgeW91IHNpbWlsYXJseSAKPiBibG9ja2VkIGxpa2UgU2h5anVtb24gYnkgcmVtb3Rl
IHdvcmsgcmVzdHJpY3Rpb25zP8KgIEFzIHRoaXMgaXMgY2F1c2luZyAKPiBzZWUgdGhpcyBzZXJp
ZXMgbGFuZCBmb3IgNS4xNC7CoCBJZiB5b3UgY2FuJ3QgZ2V0IHRvIGl0IGluIHRpbWUsIEkgd291
bGQKPiBwcmVmZXIgdGhhdCB3ZSBzd2l0Y2ggdGhpcyBwYXRjaCBiYWNrIHRvIGhvdyBpdCB3YXMg
Y29uc2VydmF0aXZlbHkgZG9uZQo+IGluIHYxIGZvciA1LjE0IChhbmQgcmVkbyAyLzIgb24gdG9w
IG9mIHRoYXQpOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyMTA1Mjcx
MTM3NTEuR0IxNzI2NkBsc3QuZGUvVC8jdAo+IAo+IGFuZCBsZXQgeW91IGdldCBiYWNrIHRvIHRo
ZSBsaXN0IHdoZW4geW91IGNhbiB0byBvcHRpbWl6ZSBpdCAibGF0ZXIiLgo+IAo+ID4gCj4gPiBT
aHlqdW1vbiBhbmQgSm9uLCBjYW4geW91IHJldGVzdHMgdGhlIHBsYXRmb3JtcyBxdWlya2VkIGlu
Cj4gPiAxZmFlMzdhY2NmYzUgKCJudm1lL3BjaTogQWRkIHNsZWVwIHF1aXJrIGZvciBTYW1zdW5n
IGFuZCBUb3NoaWJhCj4gPiBkcml2ZXMiKSB3aXRoIHRoaXMgZml4Pwo+ID4gCj4gPiBTaHlqdW1v
bj4+IFllcywgSSBkbyBhZ3JlZSB3ZSBuZWVkIHRvIHRlc3QgdGhpcyBhbHNvLiBIb3dldmVyIHRo
ZQo+ID4gYm9hcmRzIHdoZXJlIHdoaWNoIEkgaGFkIHRoZXNlIGlzc3VlcyBhcmUgbm90IGluIG15
IHJlbW90ZSBhY2Nlc3Mgbm93Cj4gPiAoYXMgdGhlIHdvcmsgZnJlcXVlbmN5IG9uIHRoaXMgYm9h
cmRzIGFyZSBsZXNzIGFuZCBhbHNvIGR1ZSB0byBDb3ZpZAo+ID4gc2l0dWF0aW9uKSwKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJdCBtaWdodMKg
IHRha2Ugc29tZSB0aW1lIGZvciBtZSB0byB0ZXN0LiBJCj4gPiB3aWxsIHVwZGF0ZSBhcyBzb29u
IGFzIEkgY2FuLgo+ID4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
