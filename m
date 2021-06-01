Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5BDC4708F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 19:14:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4191060FEE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 19:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4191060FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=leO5fEX4xdy0xBzsOkm/TArS2u8syJgXQSUYVUHo9ZY=; b=tf6kJLsLxTIl8X
	USUIt+snbtWtBrLF+DUTbxhBvJjlR1fAIg/keLpri8k0i/dhPz2QRQoAs42Vbi/ZYppDWFq7isHQc
	DHUYMRxb7Rng8qMDTLrcBI3oNhFjfgcfPtmi388qFeZ726Ddo6dDnnGsMOWhtLZtALidtA/oSUNEs
	NiwZ/vqdSvt4IUcOPxPJj35NsyCtJgtegHakxndZ+kfYd9EmZ1NUR1zm31+b9QDsGLWD5VsCJAlae
	3GmHk6NI2tdDOvwWX2jFLEJET/fX4PQH8U3UlfuBd8Q5NOleB3B3RDqF7TNw723oMCUwZPjwellul
	lysq4zU5rxN0zZ+r4riQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo9qS-000YSB-S0; Tue, 01 Jun 2021 19:14:32 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo9qP-000YGt-Nh
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 19:14:30 +0000
IronPort-SDR: TAVjaSgBEaoTLopBl/SQUIHrWMYf6prF52oQknrtLv64bLkGFsSBv15qO6n6EXCpP82aknHqsC
 MGcABdGa9IqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="183299342"
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; d="scan'208";a="183299342"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 12:12:28 -0700
IronPort-SDR: a7nJDfUrrNCtxryWVWxPKxtLZuR3c5Yo2mPV5ZYeZiUOzpHV/j8cBILxQpNBaz8r1B++T+R3t6
 6aZw2JcaFUYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,240,1616482800"; d="scan'208";a="399433138"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga003.jf.intel.com with ESMTP; 01 Jun 2021 12:12:27 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com
 [10.54.75.174])
 by linux.intel.com (Postfix) with ESMTP id 033C4580427;
 Tue,  1 Jun 2021 12:12:27 -0700 (PDT)
Message-ID: <108f45a7c73d3ae571ee518c33dc793f36c1ffd2.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
From: "David E. Box" <david.e.box@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>, Mario Limonciello
 <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Sagi
 Grimberg <sagi@grimberg.me>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org, 
 Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com, prike.liang@amd.com, 
 Shyjumon N <shyjumon.n@intel.com>, Jon Derrick <jonathan.derrick@intel.com>
Date: Tue, 01 Jun 2021 12:12:26 -0700
In-Reply-To: <20210531064655.GA1417@lst.de>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
 <20210531064655.GA1417@lst.de>
Organization: David E. Box
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_121429_805388_87333E2D 
X-CRM114-Status: GOOD (  18.29  )
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

T24gTW9uLCAyMDIxLTA1LTMxIGF0IDA4OjQ2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToKPiBPbiBGcmksIE1heSAyOCwgMjAyMSBhdCAxMTowMjozNEFNIC0wNTAwLCBNYXJpbyBMaW1v
bmNpZWxsbyB3cm90ZToKPiA+IFRoZSBkb2N1bWVudGF0aW9uIGFyb3VuZCB0aGUgU3RvcmFnZUQz
RW5hYmxlIHByb3BlcnR5IGhpbnRzIHRoYXQgaXQKPiA+IHNob3VsZCBiZSBtYWRlIG9uIHRoZSBQ
Q0kgZGV2aWNlLsKgIFRoaXMgaXMgd2hlcmUgbmV3ZXIgQU1EIHN5c3RlbXMKPiA+IHNldAo+ID4g
dGhlIHByb3BlcnR5IGFuZCBpdCdzIHJlcXVpcmVkIGZvciBTMGkzIHN1cHBvcnQuCj4gPiAKPiA+
IFNvIHJhdGhlciB0aGFuIGxvb2sgZm9yIG5vZGVzIG9mIHRoZSByb290IHBvcnQgb25seSBwcmVz
ZW50IG9uCj4gPiBJbnRlbAo+ID4gc3lzdGVtcywgc3dpdGNoIHRvIHRoZSBjb21wYW5pb24gQUNQ
SSBkZXZpY2UgZm9yIGFsbCBzeXN0ZW1zLgo+ID4gRGF2aWQgQm94IGZyb20gSW50ZWwgaW5kaWNh
dGVkIHRoaXMgc2hvdWxkIHdvcmsgb24gSW50ZWwgYXMgd2VsbC4KPiAKPiBJIHRoaW5rIHdlIG5l
ZWQgdG8gd2FpdCBmb3IgdGhlIGNvbmZpcm1hdGlvbiBmcm9tIERhdmlkLgoKSSd2ZSB0ZXN0ZWQg
b25lIGNvbmZpZ3VyYXRpb24gcmVtb3RlbHkgYWxyZWFkeSBhbmQgaXQgd29ya3MuIEkndmUgZ290
Cm9uZSBtb3JlIHRvIHRlc3QuIEknbGwga25vdyBieSB0b21vcnJvdy4KCkRhdmlkCgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
