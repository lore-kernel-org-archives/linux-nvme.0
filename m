Return-Path: <SRS0=EFt+=KE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AEEC433B4
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 11:31:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230E0613D6
	for <linux-nvme@archiver.kernel.org>; Sun,  9 May 2021 11:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230E0613D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x3syjvPevKSSwxu8r988TA+vn4DGE2Wn6FZ5Pe3AG00=; b=a1rcS0+wSsXpbwZ8bDMSDDjhT
	7/NTGmUml36fdc3bYIUjdV4AyBYZco3mgHqdPDHLT9tPn+XD+CvrQ2NTxXKpp+72CINqKHbSUPdmy
	Tz85YWKkjRupT8xRNZtIrQkaPl4tj4GwyJov3i2EzkdI3FjmpvoV6Q4GCPnCrnl22OojPktiVREPt
	ttOzkGl8Yl5OzVG5vnxHQrqi/rm76XsL/PcaIXivF3U4/U4wOfNedqiu2Q5Jwh3V9730bD9LHMoBY
	85Qv9Lxjid6Sd9hHVQHz2XO+ba9QlEBX5vNhIkQiy32HjKQOUxrj+rnj/+0xsw4H4dV3Rk31PKdhZ
	MznERDRuQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lfhe4-00BW0U-DX; Sun, 09 May 2021 11:30:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfhe0-00BW0E-Oc
 for linux-nvme@desiato.infradead.org; Sun, 09 May 2021 11:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ZBL2+QesIjCVr8iRW9ONLYz6r62g2dSI8/3QQyxYQGY=; b=3fM0wLdfujxYdCCdN3lWONqxip
 Boo0MPPxwDjNn8E8TVc1zg179K6i0sESiMIAZEltHpKQbog8JyBH4EONt/nQcniEOFpDQb6MGoZP6
 TSw6ISsEqoIET1mWmqxcPFI0e33JwEmNU4MulUjraqsgNCDTZxPOFWCTOnj4Hee8ZE7lokCXQ6uRc
 g/xW44vSxOYoHxI8+DISy2AfVVC0nFgHqyfVYTIow0SGi/RwK5U1j4I5uDkhKMFn2tck6CiemHxWJ
 jNt4DBn5y88mSpR764qr3x81FHbNgItmr9qIoEsvitbjm4moH9A+MPITeEHpPXIy4SZubCV8QKoqs
 qQO5cZIQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lfhdx-007x7u-RD
 for linux-nvme@lists.infradead.org; Sun, 09 May 2021 11:30:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 93B08AEFE;
 Sun,  9 May 2021 11:30:37 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
Date: Sun, 9 May 2021 13:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210509_043042_228775_1B94FCAE 
X-CRM114-Status: GOOD (  23.35  )
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

T24gNS84LzIxIDE6MjIgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+Pj4gV2VsbCwgdGhh
dCB3b3VsZCByZXF1aXJlIGEgbW9kaWZpY2F0aW9uIHRvIHRoZSBDUUUgc3BlY2lmaWNhdGlvbiwg
bm8/Cj4+Pj4gZm1kcyB3YXMgbm90IGFtdXNlZCB3aGVuIEkgcHJvcG9zZWQgdGhhdCA6LSgKPj4+
Cj4+PiBXaHkgd291bGQgdGhhdCByZXF1aXJlIGEgbW9kaWZpY2F0aW9uIHRvIHRoZSBDUUU/IGl0
J3MganVzdCB1c2luZyBzYXkKPj4+IDQgbXNiaXRzIG9mIHRoZSBjb21tYW5kX2lkIHRvIGEgcnVu
bmluZyBzZXF1ZW5jZS4uLgo+Pgo+PiBJIHRoaW5rIEhhbm5lcyB3YXMgdW5kZXIgdGhlIGltcHJl
c3Npb24gdGhhdCB0aGUgY291bnRlciBwcm9wb3NhbCB3YXNuJ3QKPj4gcGFydCBvZiB0aGUgImNv
bW1hbmRfaWQiLiBUaGUgaG9zdCBjYW4gZW5jb2RlIHdoYXRldmVyIGl0IHdhbnRzIGluIHRoYXQK
Pj4gdmFsdWUsIGFuZCB0aGUgY29udHJvbGxlciBqdXN0IGhhcyB0byByZXR1cm4gdGhlIHNhbWUg
dmFsdWUuCj4gCj4gWWVhLCBtYXliZSBzb21ldGhpbmcgbGlrZSB0aGlzPwo+IC0tIAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiBpbmRleCBlNjYxMjk3MWY0ZWIuLjdhZjQ4ODI3ZWE1NiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBA
QCAtMTAwNiw3ICsxMDA2LDcgQEAgYmxrX3N0YXR1c190IG52bWVfc2V0dXBfY21kKHN0cnVjdCBu
dm1lX25zICpucywgCj4gc3RydWN0IHJlcXVlc3QgKnJlcSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gQkxLX1NUU19JT0VSUjsKPiAgwqDCoMKgwqDCoMKgIH0KPiAKPiAt
wqDCoMKgwqDCoMKgIGNtZC0+Y29tbW9uLmNvbW1hbmRfaWQgPSByZXEtPnRhZzsKPiArwqDCoMKg
wqDCoMKgIGNtZC0+Y29tbW9uLmNvbW1hbmRfaWQgPSBudm1lX2NpZChyZXEpOwo+ICDCoMKgwqDC
oMKgwqAgdHJhY2VfbnZtZV9zZXR1cF9jbWQocmVxLCBjbWQpOwo+ICDCoMKgwqDCoMKgwqAgcmV0
dXJuIHJldDsKPiB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2Ry
aXZlcnMvbnZtZS9ob3N0L252bWUuaAo+IGluZGV4IDA1ZjMxYTJjNjRiYi4uOTZhYmZiMGUyZGRk
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaAo+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaAo+IEBAIC0xNTgsNiArMTU4LDcgQEAgZW51bSBudm1lX3F1aXJrcyB7
Cj4gc3RydWN0IG52bWVfcmVxdWVzdCB7Cj4gIMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9jb21t
YW5kwqDCoMKgwqAgKmNtZDsKPiAgwqDCoMKgwqDCoMKgIHVuaW9uIG52bWVfcmVzdWx0wqDCoMKg
wqDCoMKgIHJlc3VsdDsKPiArwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdlbmN0cjsKPiAgwqDCoMKgwqDCoMKgIHU4wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHJpZXM7Cj4gIMKgwqDCoMKgwqDCoCB1
OMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmbGFnczsKPiAgwqDC
oMKgwqDCoMKgIHUxNsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Rh
dHVzOwo+IEBAIC00OTcsNiArNDk4LDQ4IEBAIHN0cnVjdCBudm1lX2N0cmxfb3BzIHsKPiAgwqDC
oMKgwqDCoMKgIGludCAoKmdldF9hZGRyZXNzKShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBjaGFy
ICpidWYsIGludCBzaXplKTsKPiB9Owo+IAo+ICsvKgo+ICsgKiBudm1lIGNvbW1hbmRfaWQgaXMg
Y29uc3RydWN0ZWQgYXMgc3VjaDoKPiArICogfCB4eHh4IHwgeHh4eHh4eHh4eHh4IHwKPiArICrC
oMKgIGdlbsKgwqDCoCByZXF1ZXN0IHRhZwo+ICsgKi8KPiArI2RlZmluZSBudm1lX2NpZF9pbnN0
YWxsX2dlbmN0cihnZW4pwqDCoMKgwqDCoMKgwqDCoMKgwqAgKChnZW4gJiAweGYpIDw8IDEyKQo+
ICsjZGVmaW5lIG52bWVfZ2VuY3RyX2Zyb21fY2lkKGNpZCnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAoKGNpZCAmIDB4ZjAwMCkgPj4gMTIpCj4gKyNkZWZpbmUgbnZtZV90YWdfZnJvbV9jaWQo
Y2lkKcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChjaWQgJiAweGZmZikKPiArCgpU
aGF0IGlzIGEgZ29vZCBpZGVhLCBidXQgd2Ugc2hvdWxkIGVuc3VyZSB0byBsaW1pdCB0aGUgbnVt
YmVyIG9mIApjb21tYW5kcyBhIGNvbnRyb2xsZXIgY2FuIHJlcXVlc3QsIHRvby4KQXMgcGVyIHNw
ZWMgZWFjaCBjb250cm9sbGVyIGNhbiBzdXBwb3J0IGEgZnVsbCAzMiBiaXQgd29ydGggb2YgcmVx
dWVzdHMsIAphbmQgaWYgd2UgbGltaXQgdGhhdCBhcmJpdHJhcmlseSBmcm9tIHRoZSBzdGFjayB3
ZSdsbCBuZWVkIHRvIGNhcCB0aGUgCm51bWJlciBvZiByZXF1ZXN0cyBhIGNvbnRyb2xsZXIgb3Ig
ZmFicmljcyBkcml2ZXIgY2FuIHJlcXVlc3QuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNV
U0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVu
ZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
