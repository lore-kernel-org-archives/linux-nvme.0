Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D4EC11D3D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 17:33:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7C0246A2
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 17:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YoP3j6Vl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7C0246A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xPif2CqM3HUqfNGX5SMR0uRtmVZwD3vtam3DdU1ptyA=; b=YoP3j6Vlxx2k0K
	dGfJNmufN3lQntXsTafCc4szlY3i6i4TK91e1iYvee6y/FjPAPH1YOxrnsJnGs1zbFYQvVNe4SgK1
	vt6IOjW6TknQzB0S3HAIkWVU71mNVcoSZmhf4Zrs/z/8fcOuIcDWqbLeQxa4vp5gSVacoTUFN01ye
	1HE1C+6DypPA/jzezRxGVAE6qGrVtSxl5R9nwqVolae/itrTlo8g3Zy6sCHV8slCBh+WKLMm3ELwi
	W6HLSUMygevnvzYsBJahBVgt+8siAA/dM9qIR1j2caiRjbzdNHlGe8nI+PfGZHI1UQLqNx6q5e9Gy
	eaz4V5XAmnJFF7JIwEVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7N2i-0004GQ-44; Thu, 27 Feb 2020 17:33:48 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7N2e-0004FR-4S
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 17:33:45 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1j7N2U-0003wS-Ev; Thu, 27 Feb 2020 10:33:35 -0700
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20200220203652.26734-1-logang@deltatee.com>
 <20200220203652.26734-8-logang@deltatee.com>
 <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cc305c27-6974-929f-e90a-510312b9b964@deltatee.com>
Date: Thu, 27 Feb 2020 10:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <becbf34c-e22e-3c48-41df-f23fee2da658@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 7/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200227_093344_170796_2BF31556 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhhbmtzIGZvciB0aGUgUmV2aWV3IQoKT24gMjAyMC0wMi0yNiA0OjI4IHAubS4sIFNhZ2kgR3Jp
bWJlcmcgd3JvdGU6Cj4gVGhpcyBsb29rcyBxdWVzdGlvbmFibGUuLi4gVGhlcmUgYXJlIHRvbnMg
b2YgZmVhdHVyZXMgdGhhdCBkb2Vzbid0Cj4gbWFrZSBzZW5zZSBoZXJlIGxpa2UgaG1iLCB0ZW1w
ZXJhdHVyZSBzdHVmZiwgaXJxIHN0dWZmLCB0aW1lc3RhbXBzLAo+IHJlc2VydmF0aW9ucyBldGMu
Li4gcGFzc2luZy10aHJvdWdoIHRoZXNlIHdpbGwgaGF2ZSBjb25mdXNpbmcKPiBzZW1hbnRpY3Mu
LiBNYXliZSB3aGl0ZS1saXN0IHdoYXQgYWN0dWFsbHkgbWFrZXMgc2Vuc2UgdG8gcGFzc3RocnU/
CgpZZXMsIEkgYWdyZWUgYSB3aGl0ZS1saXN0IGhlcmUgcHJvYmFibHkgbWFrZXMgc2Vuc2UuIEkn
bGwgdHJ5IHRvIGNvbWUgdXAKd2l0aCBhIGxpc3Qgb2YgZmVhdHVyZXMgdG8gc3RhcnQgdGhhdCB3
aGl0ZWxpc3QsIHRob3VnaCBteSBsaXN0IG1pZ2h0IGJlCmEgYml0IGRpZmZlcmVudCBmcm9tIHlv
dXJzOiBJIGRvbid0IHNlZSB3aHkgdGVtcGVyYXR1cmUgb3IgdGltZXN0YW1wcwpjYW4ndCBiZSBw
YXNzZWQgdGhyb3VnaC4KCkFsc28gbm90ZTogQ2hyaXN0b3BoIHdhcyBhZHZvY2F0aW5nIGFnYWlu
c3QgdGhlIHdoaXRlbGlzdCBmb3IgdGhlCmNvbW1hbmRzLCB0aG91Z2gsIEkgYWdyZWUgd2l0aCB5
b3UgdGhhdCBpdCBpcyB0aGUgbW9zdCBzZW5zaWJsZSBhcHByb2FjaC4KCj4+ICvCoMKgwqDCoMKg
wqDCoCBicmVhazsKPj4gK8KgwqDCoCBjYXNlIG52bWVfYWRtaW5faWRlbnRpZnk6Cj4+ICvCoMKg
wqDCoMKgwqDCoCBzd2l0Y2ggKHJlcS0+Y21kLT5pZGVudGlmeS5jbnMpIHsKPj4gK8KgwqDCoMKg
wqDCoMKgIGNhc2UgTlZNRV9JRF9DTlNfQ1RSTDoKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVxLT5leGVjdXRlID0gbnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWQ7Cj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlcS0+cC5lbmRfcmVxID0gbnZtZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRf
Y3RybDsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5WTUVfU0NfU1VDQ0VTUzsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgTlZNRV9JRF9DTlNfTlM6Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJlcS0+ZXhlY3V0ZSA9IG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kOwo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPnAuZW5kX3JlcSA9IG52bWV0X3Bhc3N0aHJ1X292
ZXJyaWRlX2lkX25zOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlZNRV9TQ19T
VUNDRVNTOwo+IAo+IEFyZW4ndCB5b3UgbWlzc2luZyBOVk1FX0lEX0NOU19OU19ERVNDX0xJU1Q/
IGFuZAo+IE5WTUVfSURfQ05TX05TX0FDVElWRV9MSVNUPwoKV2VsbCBubywgc2VlaW5nIHRoZXkg
Y2FuIGJlIHBhc3NlZCB0aHJvdWdoIHRoZSBkZWZhdWx0IHBhdGguLi4uIEJ1dCBpbgp0aGUgbGln
aHQgb2YgdGhlIGNvbW1lbnQgYmVsb3csIHllcy4KCj4+ICvCoMKgwqDCoMKgwqDCoCBkZWZhdWx0
Ogo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gbnZtZXRfc2V0dXBfcGFzc3RocnVf
Y29tbWFuZChyZXEpOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+IAo+IEFsc28gaGVyZSwgYWxsIHRo
ZSBuYW1lc3BhY2UgbWFuYWdlbWVudCBzdHVmZiBoYXMgcXVlc3Rpb25hYmxlCj4gc2VtYW50aWNz
IGluIG15IG1pbmQuLi4KClllcywgSSBhZ3JlZSB3aXRoIHRoYXQuIEknbGwgbWFrZSB0aGUgY2hh
bmdlIGluIHRoZSBuZXh0IHJldmlzaW9uLgoKTG9nYW4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
