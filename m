Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7773C2D0E4
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 17:12:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BA92238E6
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 17:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MN7rybXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA92238E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=54G944qBpwWdkRxFFmVcE9OzL0kus4cTqYhkMQGtCqw=; b=MN7rybXraXeVjOC7XbuRWZPKA
	jN0ujybAkMyX0CIwDKnqvkhTEi19wXnVD6WiO2Kar79JHiKvUl1KCuGNsvLLPY/Bdb1TVHjxsJPSq
	1nULTI/Ww/kSUL2aHzlgHrGLGOU9x2o4l2dH/it4MYueA1w2aRJbPbmq8tCW+dFeKWAC4ANvJRC1d
	ggKUsUP2dHpVAnqxeBuf7P/NblM/4iPU1EaVoe/6A9uNkPAATlqBMCbo4NP67qNAL/Hcv9EmfX2Zw
	XPP8uwdsL2vNpLWb2TYmp1jLCgNp9U7L3Ema4/vDqAF3A4h9fL/Nbcn5s3/bN5OzoV8FqiMegG6+5
	aqw6yfR+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kf4XB-0001Zz-Bq; Tue, 17 Nov 2020 17:12:49 +0000
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kf4X9-0001ZL-1T
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 17:12:48 +0000
IronPort-SDR: z7xfLjpFw51Y+E3Ox8bFplG3o1woVo915+ZW61cqQyfv3ezmDWBcyYi26NFY8Xhl+UWHdNqFh6
 KSTZD28kTn6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171065930"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="171065930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 09:12:43 -0800
IronPort-SDR: IHOwjAmUMsd4UZFjW00s6bZvC7Aon7pE/Cj00tYK9Xh35qWvcdJJfQH0q11vQghKQq7d/WGUOz
 2eR3v2DlkECg==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="533887557"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.212.68.42])
 ([10.212.68.42])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2020 09:12:42 -0800
Subject: Re: nvme: subsystem handle not released on hot removal under raid1
 configuration and multipath enabled
To: Keith Busch <kbusch@kernel.org>
References: <fa9e6605-9d6e-0bde-749c-8987f68320a5@intel.com>
 <20201117153246.GE2715864@dhcp-10-100-145-180.wdc.com>
From: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <347471ff-69b7-955f-bf6b-6781931ea302@intel.com>
Date: Tue, 17 Nov 2020 09:12:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117153246.GE2715864@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201117_121247_233588_2A0A771A 
X-CRM114-Status: GOOD (  18.48  )
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
Cc: "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgS2VpdGgsClRoYW5rIHlvdSBzbyBtdWNoIGZvciBnZXR0aW5nIGJhY2sgb24gdGhpcyA6KQoK
T24gMTEvMTcvMjAyMCA3OjMyIEFNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBNb24sIE5vdiAx
NiwgMjAyMCBhdCAwNDowNjo1NFBNIC0wODAwLCBSYWphc2hla2FyLCBSZXZhbnRoIHdyb3RlOgo+
PiBJIGd1ZXNzIHRoaXMgaXMgYmVjYXVzZSB0aGUgbWQtcmFpZDEgZHJpdmVyIGlzIHN0aWxsIGhv
bGRpbmcgYSByZWZlcmVuY2UgdG8gdGhlIG52bWUgZHJpdmVyIChrcmVmIGNvdW50IGlzIDIgaW4g
dGhlIG52bWUgcmVtb3ZhbCBwYXRoKS4KPj4gSXMgdGhpcyBhIGJ1ZyBpbiBudm1lIG11bHRpcGF0
aD8gQmVjYXVzZSBpdCB3b3JrcyBmaW5lIHdpdGggbXVsdGlwYXRoIG9mZi4KPj4gUGxlYXNlIGxl
dCBtZSBrbm93IGlmIG1vcmUgaW5mb3JtYXRpb24gaXMgcmVxdWlyZWQgOikKPiBDb3JyZWN0LCB0
aGUgbWQgcmFpZCBpcyBob2xkaW5nIGEgcmVmZXJlbmNlLiBJdCdzIG5vdCByZWFsbHkgYSBidWcs
IGJ1dAo+IG90aGVycyBoYXZlIGNvbW1lbnRlZCB0aGF0IHRoaXMgYmVoYXZpb3IgaXNuJ3QgbmVj
ZXNzYXJpbHkgZGVzaXJhYmxlLgo+Cj4gSSBwb3N0ZWQgYW4gUkZDIGFib3V0IHRoaXMgaXNzdWUg
aGVyZToKPgo+ICAgaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52
bWUvMjAyMC1TZXB0ZW1iZXIvMDE5ODczLmh0bWwKVGhlIHBhdGNoIHN1Z2dlc3RlZCBpbiB0aGUg
dGhyZWFkIHNlZW1zIHRvIGZpeCB0aGUgaXNzdWUuCj4KPiBUaGUgZGlzY3Vzc2lvbiBldm9sdmVk
IGEgYml0IHNpbmNlIHRoZW4sIGJ1dCBoYXNuJ3QgaGFkIG11Y2ggYWN0aXZpdHkKPiByZWNlbnRs
eS4gSSdtIGhvcGluZyB0byBnZXQgYmFjayBvbiB0aGF0IGNvbnZlcnNhdGlvbiBzb29uLgpJdCdz
IGludGVyZXN0aW5nIHRoYXQgdGhlIHRocmVhZCBlbmRlZCBhYnJ1cHRseS7CoCBBcmUgdGhlcmUg
YW55IHBsYW5zIHRvIG1vdmUgZm9yd2FyZCB3aXRoIHRoaXMgUkZDLi4uPwoKVGhhbmtzIQpSZXZh
bnRoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
