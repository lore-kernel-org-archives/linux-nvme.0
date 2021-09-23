Return-Path: <SRS0=+tAy=ON=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E83C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 06:12:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08D66115A
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Sep 2021 06:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C08D66115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9AlFjTQaUmg67q/QKQVxN57vDED71grwi6YwQZN6lDE=; b=dzbLOyJE20N2uSC3Agyn9hkTNH
	9zJBL2+qLK4DEj5l+/ksIMiF15Ybwhb7ijEDK7mMdTWKCSAo6LTlQGhGjjFu5sbsFaQTBDuDeNPao
	GvqlrA/Jw4ij73EThZMHmQ7uPH03VQX5LZuit4tBssF0hsuP/SZcj03nZqPf/srsv6pgdrOXJ2+us
	iEExzeQYzMbYB+Sd/qjPljA9ZFxk6reB7Voi5kgb9UkgtBS/e/dRPExg3yxMg247fv5xpgrRO/Dha
	Z1U+kr79WB/+di0POZfg6cBh/zgxtGq/F7TEfBaxH6I9NyFltC/CBLz01B7Q3injniQ/o/suUULZ3
	qMpB/KfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTHxg-00ALPc-IR; Thu, 23 Sep 2021 06:12:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTHxc-00ALOk-Kq
 for linux-nvme@lists.infradead.org; Thu, 23 Sep 2021 06:11:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCB3C2230E;
 Thu, 23 Sep 2021 06:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632377512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbJuPRZmoaHIp4Wn23J9ul5BBd2u13Mi7Phno1JbmYQ=;
 b=eJmmqcNkWQDxgxugi7lOQNcCzTK5/3ZP0b8FNdJ8yUthd7z+NtG2o8NKB1AIoWApfJRTby
 MMVYOMQJO9DlyANdIrFhLzS5ROc6acswM1xsnKNV1KBTMopjBUud6/hq/AqSmgKIrhIVtl
 jRQTVNvUHoZEg5O2Oi2+H7fAk3A6Z+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632377512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbJuPRZmoaHIp4Wn23J9ul5BBd2u13Mi7Phno1JbmYQ=;
 b=9L7r4ur3/bJvqPsu6yttPamU5H1G6d4TFrIjf5TBwFfsCbVUw+txggpo/7wv3ouBO7/lAt
 2562WfdOZ/X8lcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9625D13DB5;
 Thu, 23 Sep 2021 06:11:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jyLrIqgaTGF1VwAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 23 Sep 2021 06:11:52 +0000
Subject: Re: [PATCH 6/7] nvme: Add connect option 'discovery'
To: James Smart <jsmart2021@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20210922063525.143045-1-hare@suse.de>
 <20210922063525.143045-7-hare@suse.de>
 <f38f89f9-90c7-40ca-3d62-1491cb36be19@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ef0ae47e-148a-d814-6e4a-40f2bfb4c020@suse.de>
Date: Thu, 23 Sep 2021 08:11:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f38f89f9-90c7-40ca-3d62-1491cb36be19@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_231156_886635_C823E85C 
X-CRM114-Status: GOOD (  25.51  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8yMi8yMSA2OjU5IFBNLCBKYW1lcyBTbWFydCB3cm90ZToKPiBPbiA5LzIxLzIwMjEgMTE6
MzUgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gQWRkIGEgY29ubmVjdCBvcHRpb24gJ2Rp
c2NvdmVyeScgdG8gc3BlY2lmeSB0aGF0IHRoZSBjb25uZWN0aW9uCj4+IHNob3VsZCBiZSBtYWRl
IHRvIGEgZGlzY292ZXJ5IGNvbnRyb2xsZXIsIG5vdCBhIG5vcm1hbCBJL08gY29udHJvbGxlci4K
Pj4gV2l0aCBkaXNjb3ZlcnkgY29udHJvbGxlcnMgc3VwcG9ydGluZyB1bmlxdWUgc3Vic3lzdGVt
IE5RTnMgd2UKPj4gY2Fubm90IGVhc2lseSBkaXN0aW5ndWlzaCBieSB0aGUgc3Vic3lzdGVtIE5R
TiBpZiB0aGlzIHNob3VsZCBiZQo+PiBhIGRpc2NvdmVyeSBjb25uZWN0aW9uLCBidXQgd2UgbmVl
ZCB0aGlzIGluZm9ybWF0aW9uIHRvIGJsYW5rIG91dAo+PiBvcHRpb25zIG5vdCBzdXBwb3J0ZWQg
YnkgZGlzY292ZXJ5IGNvbnRyb2xsZXJzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVp
bmVja2UgPGhhcmVAc3VzZS5kZT4KPj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmPCoMKg
wqAgfCA3ICsrKysrKysKPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jIHwgNiArKysr
Ky0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oIHwgMSArCj4+IMKgIDMgZmlsZXMg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+
IGluZGV4IDFlZDFiN2JlMjgxMi4uYWQwMWUyNzc4Y2I2IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IEBA
IC0yNzE1LDYgKzI3MTUsMTMgQEAgc3RhdGljIGludCBudm1lX2luaXRfc3Vic3lzdGVtKHN0cnVj
dCBudm1lX2N0cmwgCj4+ICpjdHJsLCBzdHJ1Y3QgbnZtZV9pZF9jdHJsICppZCkKPj4gwqDCoMKg
wqDCoCBlbHNlCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdWJzeXMtPnN1YnR5cGUgPSBOVk1FX05R
Tl9OVk1FOwo+PiArwqDCoMKgIGlmIChudm1lX2Rpc2NvdmVyeV9jdHJsKGN0cmwpICYmIHN1YnN5
cy0+c3VidHlwZSAhPSBOVk1FX05RTl9ESVNDKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBkZXZfZXJy
KGN0cmwtPmRldmljZSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIlN1YnN5c3RlbSAlcyBp
cyBub3QgYSBkaXNjb3ZlcnkgY29udHJvbGxlciIsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN1YnN5cy0+c3VibnFuKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGtmcmVlKHN1YnN5cyk7Cj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAg
c3Vic3lzLT5hd3VwZiA9IGxlMTZfdG9fY3B1KGlkLT5hd3VwZik7Cj4+IMKgICNpZmRlZiBDT05G
SUdfTlZNRV9NVUxUSVBBVEgKPj4gwqDCoMKgwqDCoCBzdWJzeXMtPmlvcG9saWN5ID0gTlZNRV9J
T1BPTElDWV9OVU1BOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5j
IGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+IGluZGV4IDY2OGM2YmI3YTU2Ny4uYzVh
MmI3MWM1MjY4IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMKPj4g
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+IEBAIC01NDgsNiArNTQ4LDcgQEAg
c3RhdGljIGNvbnN0IG1hdGNoX3RhYmxlX3Qgb3B0X3Rva2VucyA9IHsKPj4gwqDCoMKgwqDCoCB7
IE5WTUZfT1BUX05SX1BPTExfUVVFVUVTLMKgwqDCoCAibnJfcG9sbF9xdWV1ZXM9JWQiwqDCoMKg
IH0sCj4+IMKgwqDCoMKgwqAgeyBOVk1GX09QVF9UT1MswqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
dG9zPSVkIsKgwqDCoMKgwqDCoMKgIH0sCj4+IMKgwqDCoMKgwqAgeyBOVk1GX09QVF9GQUlMX0ZB
U1RfVE1PLMKgwqDCoCAiZmFzdF9pb19mYWlsX3Rtbz0lZCLCoMKgwqAgfSwKPj4gK8KgwqDCoCB7
IE5WTUZfT1BUX0RJU0NPVkVSWSzCoMKgwqDCoMKgwqDCoCAiZGlzY292ZXJ5IsKgwqDCoMKgwqDC
oMKgIH0sCj4+IMKgwqDCoMKgwqAgeyBOVk1GX09QVF9FUlIswqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBOVUxMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+IMKgIH07Cj4+IEBAIC04MjMsNiArODI0
LDkgQEAgc3RhdGljIGludCBudm1mX3BhcnNlX29wdGlvbnMoc3RydWN0IAo+PiBudm1mX2N0cmxf
b3B0aW9ucyAqb3B0cywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBvcHRzLT50b3MgPSB0b2tlbjsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgYnJlYWs7Cj4+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIE5WTUZfT1BUX0RJU0NP
VkVSWToKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3B0cy0+ZGlzY292ZXJ5X25xbiA9IHRy
dWU7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZGVmYXVsdDoKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigidW5rbm93
biBwYXJhbWV0ZXIgb3IgbWlzc2luZyB2YWx1ZSAnJXMnIGluIGN0cmwgCj4+IGNyZWF0aW9uIHJl
cXVlc3RcbiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcCk7Cj4+IEBA
IC05NDksNyArOTUzLDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZl9mcmVlX29wdGlvbnMpOwo+
PiDCoCAjZGVmaW5lIE5WTUZfQUxMT1dFRF9PUFRTwqDCoMKgIChOVk1GX09QVF9RVUVVRV9TSVpF
IHwgCj4+IE5WTUZfT1BUX05SX0lPX1FVRVVFUyB8IFwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5WTUZfT1BUX0tBVE8gfCBOVk1GX09QVF9IT1NUTlFOIHwgXAo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlZNRl9PUFRfSE9TVF9JRCB8IE5W
TUZfT1BUX0RVUF9DT05ORUNUIHxcCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBOVk1GX09QVF9ESVNBQkxFX1NRRkxPVyB8XAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTlZNRl9PUFRfRElTQUJMRV9TUUZMT1cgfCBOVk1GX09QVF9ESVNDT1ZFUlkgfFwK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5WTUZfT1BUX0ZBSUxfRkFT
VF9UTU8pCj4+IMKgIHN0YXRpYyBzdHJ1Y3QgbnZtZV9jdHJsICoKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaCBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaAo+
PiBpbmRleCBhMTQ2Y2I5MDM4NjkuLmI2MWI2NjZlMTBlYyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvZmFicmljcy5oCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3Mu
aAo+PiBAQCAtNjcsNiArNjcsNyBAQCBlbnVtIHsKPj4gwqDCoMKgwqDCoCBOVk1GX09QVF9UT1PC
oMKgwqDCoMKgwqDCoCA9IDEgPDwgMTksCj4+IMKgwqDCoMKgwqAgTlZNRl9PUFRfRkFJTF9GQVNU
X1RNT8KgwqDCoCA9IDEgPDwgMjAsCj4+IMKgwqDCoMKgwqAgTlZNRl9PUFRfSE9TVF9JRkFDRcKg
wqDCoCA9IDEgPDwgMjEsCj4+ICvCoMKgwqAgTlZNRl9PUFRfRElTQ09WRVJZwqDCoMKgID0gMSA8
PCAyMiwKPj4gwqAgfTsKPj4gwqAgLyoqCj4+Cj4gCj4gCj4gSSB0aGluayB5b3UgbmVlZCB0byBi
ZSBwYXRjaGluZyBfX252bWVfZmluZF9nZXRfc3Vic3lzdGVtKCksIHdoaWNoIGxvb2tzIAo+IGZv
ciBzdWJzeXN0ZW0gbmFtZSBhbmQgb3B0cyBvdXQgKGFsbG93aW5nIG11bHRpcGxlIGNvbm5lY3Rz
IHRvIGRpc2NvdmVyeSAKPiBzdWJzeXN0ZW1zKSBpZiBkaXNjb3ZlcnkgY29udHJvbGxlciBucW4u
Cj4gCj4gZS5nLiB0aGUgbG9vcCBtYXRjaGluZyBzdWJzeXMgbmFtZSAoYXNzdW1pbmcgZGlzY292
ZXJ5IGN0bHIgbm93IGhhcyBhIAo+IHVuaXF1ZSBuYW1lKSBjb250aW51ZXMgaWYgc3Vic3lzLT5z
dWJ0eXBlIGlzIE5WTUVfTlFOX0RJU0MKPiAKQWguIFlvdSBzcG90dGVkIGl0LgoKVGhhdCBpcyBh
Y3R1YWxseSBieSBkZXNpZ24uCgpUaGUgc29sZSByZWFzb24gKGZyb20gbXkgcGVyc3BlY3RpdmUp
IGZvciB0aGlzIGNvbmRpdGlvbiBpcyBwcmVjaXNlbHkgCmJlY2F1c2Ugd2UgY2Fubm90IGN1cnJl
bnRseSBpZGVudGlmeSBkaXNjb3Zlcnkgc3Vic3lzdGVtcy4gU28gd2UgbmVlZCB0byAKY3JlYXRl
IGluZGl2aWR1YWwgZGlzY292ZXJ5IHN1YnN5c3RlbXMgZm9yIGVhY2ggY29udHJvbGxlci4KQnV0
IHdpdGggdGhpcyBwYXRjaCB3ZSBjYW4sIHNvIHdlIF9jYW5fIGZpZ3VyZSBvdXQgaWYgdHdvIGNv
bnRyb2xsZXJzIAphcmUgYXR0YWNoZWQgdG8gdGhlIHNhbWUgZGlzY292ZXJ5IHN1YnN5c3RlbS4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
