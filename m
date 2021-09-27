Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA7EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 06:40:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C24060560
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 06:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C24060560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioTwR4HJqzYUdePOLxRJvSncCWCpRjdZPzacuW5aeWM=; b=mMRHr/UoY88pFDf9bjWWwzau5h
	Ynq6RdH1coTr0EE3Aq22Gk56pKWRCcVGwDPmiZwn5KA/CpJ3B4OKrPFYgoRJYsrXSHrqAm3bvwvs5
	AB/2MYR5/Q9CD7apE6jTUOrslZpmsNjdaiE5CEYucRTp/p04pV4FqDSHQ3O8SM2aFMquXbNygjNWR
	SSE8ASUVKKIkyRE8KhS+scvupvk3WkyMCwuPA3HK1WB8QSZX6ddvPaXl3H8xKB4mr/+OEYMttKRk6
	JwepPFhWjvFBwZepPnDYMSFmVs8Sz6s6qiV9QVmXcQ/tdZtrBi8JIos43srlWlHCS5LM6W47j+kZT
	2axhsVIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUkJ8-001hoB-TP; Mon, 27 Sep 2021 06:40:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUkJ5-001hkd-Ah
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 06:40:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41D8F220B2;
 Mon, 27 Sep 2021 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632724802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSbN6FT5GDXO6s1ucVQcIB6CRNYR1F7G1C4KYr5aP2o=;
 b=q9rMAdtIdNVtfRhzPFevxuj9gFctBlwjtJL3di4yER3wFlTBqksV4o0pxKp8pmkbNx2iMs
 6YEZrYnjxis6awZ2CCN36Wdl2aJn2KCok9GHoIMSgkD3S10SW6yS5AIinlRzuzMTylajpj
 REf9clt5Qu8+u/qiQqzJhTRTXKI892Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632724802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tSbN6FT5GDXO6s1ucVQcIB6CRNYR1F7G1C4KYr5aP2o=;
 b=XB9E3sFoOFi+oTqnTZ9qu4Xbfzqkus341gUKTGT/VkyhvTizZ3s4TQyqvXCjqk6Gtu6xGE
 RcBvQD68or+sXFDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19B6113481;
 Mon, 27 Sep 2021 06:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tjMtBUJnUWG8GQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 27 Sep 2021 06:40:02 +0000
Subject: Re: [PATCH 10/12] nvmet: Implement basic In-Band Authentication
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-11-hare@suse.de>
 <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c7739610-6d0b-7740-c339-b35ca5ae34e2@suse.de>
Date: Mon, 27 Sep 2021 08:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <79742bd7-a41c-0abc-e7de-8d222b146d02@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_234007_553097_E9F2601B 
X-CRM114-Status: GOOD (  25.17  )
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

T24gOS8yNy8yMSAxMjo1MSBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gK3ZvaWQgbnZt
ZXRfZXhlY3V0ZV9hdXRoX3NlbmQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQo+PiArewo+PiArwqDC
oMKgIHN0cnVjdCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsKPj4gK8KgwqDCoCBz
dHJ1Y3QgbnZtZl9hdXRoX2RoY2hhcF9zdWNjZXNzMl9kYXRhICpkYXRhOwo+PiArwqDCoMKgIHZv
aWQgKmQ7Cj4+ICvCoMKgwqAgdTMyIHRsOwo+PiArwqDCoMKgIHUxNiBzdGF0dXMgPSAwOwo+PiAr
Cj4+ICvCoMKgwqAgaWYgKHJlcS0+Y21kLT5hdXRoX3NlbmQuc2VjcCAhPSAKPj4gTlZNRV9BVVRI
X0RIQ0hBUF9QUk9UT0NPTF9JREVOVElGSUVSKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdGF0dXMg
PSBOVk1FX1NDX0lOVkFMSURfRklFTEQgfCBOVk1FX1NDX0ROUjsKPj4gK8KgwqDCoMKgwqDCoMKg
IHJlcS0+ZXJyb3JfbG9jID0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0b2Yoc3Ry
dWN0IG52bWZfYXV0aF9zZW5kX2NvbW1hbmQsIHNlY3ApOwo+PiArwqDCoMKgwqDCoMKgwqAgZ290
byBkb25lOwo+PiArwqDCoMKgIH0KPj4gK8KgwqDCoCBpZiAocmVxLT5jbWQtPmF1dGhfc2VuZC5z
cHNwMCAhPSAweDAxKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBOVk1FX1NDX0lOVkFM
SURfRklFTEQgfCBOVk1FX1NDX0ROUjsKPj4gK8KgwqDCoMKgwqDCoMKgIHJlcS0+ZXJyb3JfbG9j
ID0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb2Zmc2V0b2Yoc3RydWN0IG52bWZfYXV0aF9z
ZW5kX2NvbW1hbmQsIHNwc3AwKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZTsKPj4gK8Kg
wqDCoCB9Cj4+ICvCoMKgwqAgaWYgKHJlcS0+Y21kLT5hdXRoX3NlbmQuc3BzcDEgIT0gMHgwMSkg
ewo+PiArwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlZBTElEX0ZJRUxEIHwgTlZN
RV9TQ19ETlI7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXEtPmVycm9yX2xvYyA9Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0cnVjdCBudm1mX2F1dGhfc2VuZF9jb21tYW5kLCBz
cHNwMSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+ICvCoMKgwqAgfQo+PiArwqDC
oMKgIHRsID0gbGUzMl90b19jcHUocmVxLT5jbWQtPmF1dGhfc2VuZC50bCk7Cj4+ICvCoMKgwqAg
aWYgKCF0bCkgewo+PiArwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gTlZNRV9TQ19JTlZBTElEX0ZJ
RUxEIHwgTlZNRV9TQ19ETlI7Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXEtPmVycm9yX2xvYyA9Cj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldG9mKHN0cnVjdCBudm1mX2F1dGhfc2VuZF9j
b21tYW5kLCB0bCk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+ICvCoMKgwqAgfQo+
PiArwqDCoMKgIGlmICghbnZtZXRfY2hlY2tfdHJhbnNmZXJfbGVuKHJlcSwgdGwpKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBwcl9kZWJ1ZygiJXM6IHRyYW5zZmVyIGxlbmd0aCBtaXNtYXRjaCAoJXUp
XG4iLCBfX2Z1bmNfXywgdGwpOwo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+PiArwqDCoMKg
IH0KPj4gKwo+PiArwqDCoMKgIGQgPSBrbWFsbG9jKHRsLCBHRlBfS0VSTkVMKTsKPj4gK8KgwqDC
oCBpZiAoIWQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IE5WTUVfU0NfSU5URVJOQUw7
Cj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIGRvbmU7Cj4+ICvCoMKgwqAgfQo+PiArCj4+ICvCoMKg
wqAgc3RhdHVzID0gbnZtZXRfY29weV9mcm9tX3NnbChyZXEsIDAsIGQsIHRsKTsKPj4gK8KgwqDC
oCBpZiAoc3RhdHVzKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBrZnJlZShkKTsKPj4gK8KgwqDCoMKg
wqDCoMKgIGdvdG8gZG9uZTsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCBkYXRhID0gZDsK
Pj4gK8KgwqDCoCBwcl9kZWJ1ZygiJXM6IGN0cmwgJWQgcWlkICVkIHR5cGUgJWQgaWQgJWQgc3Rl
cCAleFxuIiwgX19mdW5jX18sCj4+ICvCoMKgwqDCoMKgwqDCoMKgIGN0cmwtPmNudGxpZCwgcmVx
LT5zcS0+cWlkLCBkYXRhLT5hdXRoX3R5cGUsIGRhdGEtPmF1dGhfaWQsCj4+ICvCoMKgwqDCoMKg
wqDCoMKgIHJlcS0+c3EtPmRoY2hhcF9zdGVwKTsKPj4gK8KgwqDCoCBpZiAoZGF0YS0+YXV0aF90
eXBlICE9IE5WTUVfQVVUSF9DT01NT05fTUVTU0FHRVMgJiYKPj4gK8KgwqDCoMKgwqDCoMKgIGRh
dGEtPmF1dGhfdHlwZSAhPSBOVk1FX0FVVEhfREhDSEFQX01FU1NBR0VTKQo+PiArwqDCoMKgwqDC
oMKgwqAgZ290byBkb25lX2ZhaWx1cmUxOwo+PiArwqDCoMKgIGlmIChkYXRhLT5hdXRoX3R5cGUg
PT0gTlZNRV9BVVRIX0NPTU1PTl9NRVNTQUdFUykgewo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKGRh
dGEtPmF1dGhfaWQgPT0gTlZNRV9BVVRIX0RIQ0hBUF9NRVNTQUdFX05FR09USUFURSkgewo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSZXN0YXJ0IG5lZ290aWF0aW9uICovCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHByX2RlYnVnKCIlczogY3RybCAlZCBxaWQgJWQgcmVzZXQgbmVn
b3RpYXRpb25cbiIsIF9fZnVuY19fLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY3RybC0+Y250bGlkLCByZXEtPnNxLT5xaWQpOwo+IAo+IFRoaXMgaXMgdGhlIHBvaW50IHdo
ZXJlIHlvdSBuZWVkIHRvIHJlc2V0IGFsc28gYXV0aCBjb25maWcgYXMgdGhpcyBtYXkKPiBoYXZl
IGNoYW5nZWQgYW5kIHRoZSBob3N0IHdpbGwgbm90IGNyZWF0ZSBhIG5ldyBjb250cm9sbGVyIGJ1
dCByYXRoZXIKPiByZS1hdXRoZW50aWNhdGUgb24gdGhlIGV4aXN0aW5nIGNvbnRyb2xsZXIuCj4g
Cj4gaS5lLgo+IAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpZiAoIXJlcS0+c3EtPnFpZCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfZGVzdHJveV9hdXRoKGN0cmwpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKG52bWV0X3NldHVwX2F1dGgoY3RybCkgPCAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJfZXJyKCJGYWlsZWQgdG8gc2V0dXAgCj4gcmUtYXV0aGVudGljYXRpb25cbiIpOwo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZG9uZV9mYWlsdXJlMTsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IAo+IAo+IAoKTm90
IHN1cmUuIFdlIGhhdmUgdHdvIHBhdGhzIGhvdyByZS1hdXRoZW50aWNhdGlvbiBjYW4gYmUgdHJp
Z2dlcmVkLgpUaGUgb25lIGlzIGZyb20gdGhlIGhvc3QsIHdoaWNoIHNlbmRzIGEgJ25lZ290aWF0
ZScgY29tbWFuZCB0byB0aGUgCmNvbnRyb2xsZXIgKGllIHRoaXMgcGF0aCkuICBUaGVuIG5vdGhp
bmcgb24gdGhlIGNvbnRyb2xsZXIgaGFzIGNoYW5nZWQsIAphbmQgd2UganVzdCBuZWVkIHRvIGVu
c3VyZSB0aGF0IHdlIHJlc3RhcnQgbmVnb3RpYXRpb24uCklFIHdlIHNob3VsZCBfbm90XyByZXNl
dCB0aGUgYXV0aGVudGljYXRpb24gKGFzIHRoYXQgd291bGQgYWxzbyByZW1vdmUgCnRoZSBjb250
cm9sbGVyIGtleXMsIHdoaWNoIGhhdmVuJ3QgY2hhbmdlZCkuIFdlIHNob3VsZCBqdXN0IGVuc3Vy
ZSB0aGF0IAphbGwgZXBoZW1lcmFsIGRhdGEgaXMgcmVnZW5lcmF0ZWQuIEJ1dCB0aGF0IHNob3Vs
ZCBiZSBoYW5kbGVkIGluLWxpbmUsIAphbmQgSSBfdGhpbmtfIEkgaGF2ZSBjb3ZlcmVkIGFsbCBv
ZiB0aGF0LgpUaGUgb3RoZXIgcGF0aCB0byB0cmlnZ2VyIHJlLWF1dGhlbnRpY2F0aW9uIGlzIHdo
ZW4gY2hhbmdpbmcgdmFsdWVzIG9uIAp0aGUgY29udHJvbGxlciB2aWEgY29uZmlnZnMuIFRoZW4g
c3VyZSB3ZSBuZWVkIHRvIHJlc2V0IHRoZSBjb250cm9sbGVyIApkYXRhLCBhbmQgdHJpZ2dlciBy
ZWF1dGhlbnRpY2F0aW9uLgpBbmQgdGhlcmUgSSBkbyBhZ3JlZSwgdGhhdCBwYXRoIGlzbid0IGZ1
bGx5IGltcGxlbWVudGVkIC8gdGVzdGVkLgpCdXQgc2hvdWxkIGJlIHN0YXJ0ZWQgd2hlbmV2ZXIg
dGhlIGNvbmZpZ2ZzIHZhbHVlcyBjaGFuZ2UuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
