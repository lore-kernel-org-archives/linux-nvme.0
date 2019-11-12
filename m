Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85768C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 16:26:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA5120679
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cn+4OjrF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA5120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=No2M0NnO8ZZ48o/wDWnWbPTaCq7kvokp7/5813cxNHg=; b=cn+4OjrFPbsGeI
	IfylTDJfRzGwpYbPiF4WI0peP6umJuu0RtuCkS+RfDRrA69ystSAYYNVMOwvKObfZMKaW+PWoz/Ib
	cnqfKrFZ6bOVIPWX/8NA2+sNtPzaThncanWcq1ycWz4QMlWLJhXq8ykK7HCx8jakAYgS3Vit2Tnxs
	pzvUDW3SyD+Eg8bR1MHggICc3NQAXB+tDvnSsnujroK0bZWZoBkPbZVb5+TTFVKAV1IxVV8mNAnlv
	AMGnPr8i0b554N+74wnTeLtnAv/6hxsNAA/CbA43PB10Bg1ugqXVoT6XyA2j3yr9B2/NGHCzhkedZ
	BQFocEdK43ok3OkXMvKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUYzV-0002mR-W6; Tue, 12 Nov 2019 16:26:05 +0000
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUYzS-0002lc-LS
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 16:26:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 810B5B281;
 Tue, 12 Nov 2019 16:25:59 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
To: Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com> <20191111204446.GA26028@lst.de>
 <CY4PR21MB0741004E62F9C50B8EF7DA9ECE770@CY4PR21MB0741.namprd21.prod.outlook.com>
 <20191112023920.GD15079@ming.t460p>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <8198fd99-6b47-7594-ba1c-4a15ffe25269@suse.de>
Date: Tue, 12 Nov 2019 17:25:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191112023920.GD15079@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_082602_998965_C94A88C1 
X-CRM114-Status: GOOD (  21.60  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTIvMTkgMzozOSBBTSwgTWluZyBMZWkgd3JvdGU6Cj4gT24gVHVlLCBOb3YgMTIsIDIw
MTkgYXQgMTI6MzM6NTBBTSArMDAwMCwgTG9uZyBMaSB3cm90ZToKPj4+IEZyb206IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+Pj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAx
OSAxMjo0NSBQTQo+Pj4gVG86IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgo+Pj4gQ2M6
IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPjsgSmVucwo+Pj4gQXhib2UgPGF4Ym9lQGZiLmNvbT47IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAbHN0LmRlPjsgU2FnaSBHcmltYmVyZwo+Pj4gPHNhZ2lAZ3JpbWJlcmcubWU+OyBMb25n
IExpIDxsb25nbGlAbWljcm9zb2Z0LmNvbT4KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBu
dm1lLXBjaTogcG9sbCBJTyBhZnRlciBiYXRjaCBzdWJtaXNzaW9uIGZvciBtdWx0aS0KPj4+IG1h
cHBpbmcgcXVldWUKPj4+Cj4+PiBPbiBGcmksIE5vdiAwOCwgMjAxOSBhdCAxMTo1NTowOEFNICsw
ODAwLCBNaW5nIExlaSB3cm90ZToKPj4+PiBmOWRkZTE4N2ZhOTIoIm52bWUtcGNpOiByZW1vdmUg
Y3EgY2hlY2sgYWZ0ZXIgc3VibWlzc2lvbiIpIHJlbW92ZXMgY3EKPj4+PiBjaGVjayBhZnRlciBz
dWJtaXNzaW9uLCB0aGlzIGNoYW5nZSBhY3R1YWxseSBjYXVzZXMgcGVyZm9ybWFuY2UKPj4+PiBy
ZWdyZXNzaW9uIG9uIHNvbWUgTlZNZSBkcml2ZSBpbiB3aGljaCBzaW5nbGUgbnZtZXEgaGFuZGxl
cyByZXF1ZXN0cwo+Pj4+IG9yaWdpbmF0ZWQgZnJvbSBtb3JlIHRoYW4gb25lIGJsay1tcSBzdyBx
dWV1ZXMoY2FsbCBpdCBtdWx0aS1tYXBwaW5nCj4+Pj4gcXVldWUpLgo+Pj4KPj4+PiBGb2xsb3dz
IHRlc3QgcmVzdWx0IGRvbmUgb24gQXp1cmUgTDgwc3YyIGd1ZXN0IHdpdGggTlZNZSBkcml2ZSgK
Pj4+PiBNaWNyb3NvZnQgQ29ycG9yYXRpb24gRGV2aWNlIGIxMTEpLiBUaGlzIGd1ZXN0IGhhcyA4
MCBDUFVzIGFuZCAxMCBudW1hCj4+Pj4gbm9kZXMsIGFuZCBlYWNoIE5WTWUgZHJpdmUgc3VwcG9y
dHMgOCBodyBxdWV1ZXMuCj4+Pgo+Pj4gSGF2ZSB5b3UgYWN0dWFsbHkgc2VlbiB0aGlzIG9uIGEg
cmVhbCBudm1lIGRyaXZlIGFzIHdlbGw/Cj4+Pgo+Pj4gTm90ZSB0aGF0IGl0IGlzIGtpbmRhIHNp
bGx5IHRvIGxpbWl0IHF1ZXVlcyBsaWtlIHRoYXQgaW4gVk1zLCBzbyBJIHJlYWxseSBkb24ndCB0
aGluawo+Pj4gd2Ugc2hvdWxkIG9wdGltaXplIHRoZSBkcml2ZXIgZm9yIHRoaXMgcGFydGljdWxh
ciBjYXNlLgo+Pgo+PiBJIHRlc3RlZCBvbiBhbiBBenVyZSBMODBzX3YyIFZNIHdpdGggbmV3ZXIg
U2Ftc3VuZyBQOTgzIE5WTWUgU1NEICh3aXRoIDMyIGhhcmR3YXJlIHF1ZXVlcykuIFRlc3RzIGFs
c28gc2hvd2VkIHNvZnQgbG9ja3VwIHdoZW4gMzIgcXVldWVzIGFyZSBzaGFyZWQgYnkgODAgQ1BV
cy4gCj4+Cj4gCj4gQlRXLCBkbyB5b3Ugc2VlIGlmIHRoaXMgc2ltcGxlIGNoYW5nZSBtYWtlcyBh
IGRpZmZlcmVuY2U/Cj4gCj4+IFRoZSBpc3N1ZSB3aWxsIGxpa2VseSBzaG93IHVwIGlmIHRoZSBu
dW1iZXIgb2YgTlZNZSBoYXJkd2FyZSBxdWV1ZXMgaXMgbGVzcyB0aGFuIHRoZSBudW1iZXIgb2Yg
Q1BVcy4gSSB0aGluayB0aGlzIG1heSBiZSBhIGxpa2VseSBjb25maWd1cmF0aW9uIG9uIGEgdmVy
eSBsYXJnZSBzeXN0ZW0uIChlLmcuIHRoZSBsYXJnZXN0IFZNIG9uIEF6dXJlIGhhcyA0MTYgY29y
ZXMpCj4+Cj4gCj4gJ3RoZSBudW1iZXIgb2YgTlZNZSBoYXJkd2FyZSBxdWV1ZXMnIGFib3ZlIHNo
b3VsZCBiZSB0aGUgbnVtYmVyIG9mIHNpbmdsZSBOVk1lIGRyaXZlLgo+IEkgYmVsaWV2ZSAzMiBo
dyBxdWV1ZXMgaXMgY29tbW9uLCBhbHNvIHBvbGwgcXVldWVzIG1heSB0YWtlIHNldmVyYWwgZnJv
bSB0aGUgdG90YWwgMzIuCj4gV2hlbiBpbnRlcnJ1cHQgaGFuZGxpbmcgb24gc2luZ2xlIENQVSBj
b3JlIGNhbid0IGNhdGNoIHVwIHdpdGggTlZNZSdzIElPIGhhbmRsaW5nLAo+IHNvZnQgbG9ja3Vw
IGNvdWxkIGJlIHRyaWdnZXJlZC4gT2YgY291cnNlLCB0aGVyZSBhcmUgbG90IGtpbmRzIG9mIHN1
cHBvcnRlZCBwcm9jZXNzb3JzCj4gYnkgTGludXguCj4gCkJ1dCB0aGVuIHdlIHNob3VsZCByYXRo
ZXIgd29yayBvbiBlbGltaW5hdGluZyB0aGUgc29mdCBsb2NrdXAgaXRzZWxmLgpTd2l0Y2hpbmcg
dG8gcG9sbGluZyBmb3IgY29tcGxldGlvbnMgb24gdGhlIHNhbWUgQ1BVIGlzbid0IGdvaW5nIHRv
CmhlbHA7IHlvdSBqdXN0IHN0YWxsIGFsbCBvdGhlciBOVk1lJ3Mgd2hpY2ggbWlnaHQgYmUgd2Fp
dGluZyBmb3IKaW50ZXJydXB0cyBhcnJpdmluZyBvbiB0aGlzIENQVS4KKE5pdHBpY2s6IHdoYXQg
ZG9lcyBoYXBwZW4gd2l0aCB0aGUgaW50ZXJydXB0IGlmIHdlIGhhdmUgYSBtYXNrIG9mCnNldmVy
YWwgQ1BVcz8gV2lsbCB0aGUgaW50ZXJydXB0IGRlbGl2ZXJlZCB0byBvbmUgQ1BVPwpUbyBhbGwg
aW4gdGhlIG1hc2s/IEFuZCBpZiB0aGF0LCBob3cgZG8gdGhlIG90aGVyIENQVSBjb3JlcyBub3Rp
Y2UgdGhhdApvbmUgaXMgd29ya2luZyBvbiB0aGF0IGludGVycnVwdD8gUXVlc3Rpb25zIC4uLikK
CkNhbid0IHdlIGltcGxlbWVudCBibGtfcG9sbD8gT3IgbWF5YmUgZXZlbiB0aHJlYWRlZCBpbnRl
cnJ1cHRzPwoKPiBBbHNvIHdoZW4gKG5yX252bWVfZHJpdmVzICogbnJfbnZtZV9od19xdWV1ZXMp
ID4gbnJfY3B1X2NvcmVzLCBvbmUgc2FtZSBDUFUKPiBjYW4gYmUgYXNzaWduZWQgdG8gaGFuZGxl
IG1vcmUgdGhhbiAxIG52bWUgSU8gcXVldWUgaW50ZXJydXB0IGZyb20gZGlmZmVyZW50Cj4gTlZN
ZSBkcml2ZSwgdGhlIHNpdHVhdGlvbiBiZWNvbWVzIHdvcnNlLgo+IApUaGF0IGlzIGFyZ3VhYmx5
IGJhZDsgZXNwZWNpYWxseSBzbyBhcyB3ZSdyZSBkb2luZyBhdXRvbWF0aWMgaW50ZXJydXB0CmFm
ZmluaXR5LgoKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgIFRlYW1sZWFkIFN0b3JhZ2Ug
JiBOZXR3b3JraW5nCmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQw
NTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4g
NSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAyNDcxNjUgKEFHIE3DvG5jaGVuKSwgR0Y6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
