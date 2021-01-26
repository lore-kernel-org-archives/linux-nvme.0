Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A29C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 02:16:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D93022AAA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 02:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D93022AAA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=comcast.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RS546huSPoIbK/2a6ysuUdGOxbtRGaqVlHiYGwKrQpI=; b=dtO0wX3CaUGaiz
	CCG310CMZno9FGn2zoByGJb6JqWJcmsF+T3HbvKZO8K23M4oDG53wqmvI5j0CrPWmbvtS0pOqW91c
	eq8LW2mK6Yy27/5QudVfBG2gKS++iBDMvYyzVqN/8TUOvpm4p1/lbfYEpvsJm8vjluzLhBnyJE4qR
	InuvH76T8cX64gzmcMcoW1iXykEoJL4pXhEVmX1pz8xFs/cLwts3ujSLJnPgW4m+B/8uuSdNVhYDF
	IKMnMSOhle3bUNhqfOuKbMZZSnt/pP/28STZJs0DRMswQFTWZvKpXkJmcoj7wMKhn0YQWE9txDjqi
	9b8MQ0FFYUiIwHPKa6Lw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4Dtc-0004Cg-E6; Tue, 26 Jan 2021 02:15:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Dtb-0004CV-6b
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 02:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Reply-To:Sender:Content-ID:Content-Description;
 bh=RQ+U54uwaV2uqQe5z6ynryhRzyA5nJS/tfgq/kHQKQ0=; b=BTmepSyBSrcSvU7irl1mGd37Co
 RHEoiGVKTY7kSzbt35ULvoMuwSWpI4zvIOuG2Uc5s9biZ1B8ZcI73k+ZRUYlcytt5P3ghdzHNV5X9
 dYQXwj+5CbHkWmW/7j1c8TQOJ7x8lwIpmR619fT2Yq4CiJmgJUVROmR2Z9G86bbIH/pEXKj6gWf2x
 fW/bF9/D9hvCiWFa6PGWYR7q/qZnGCMhZPd2eFuzNDzSUxz2CRXN8l5Jzh6Bbr1N1FRKmx4fU/sHT
 be02RhTIVxhRu32t7PCY6sEH8OaZKnx1Mszi0zKZ+CCyclLXXpjogPjf1EeAM2AocyiZBXVUNcjRg
 sbj3/Yww==;
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l4Dsw-004wa7-TO
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 02:15:25 +0000
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
 by resqmta-po-02v.sys.comcast.net with ESMTP
 id 4CsOlktCMuioU4DhalnKoE; Tue, 26 Jan 2021 02:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
 s=20190202a; t=1611626610;
 bh=RQ+U54uwaV2uqQe5z6ynryhRzyA5nJS/tfgq/kHQKQ0=;
 h=Received:Received:Reply-To:Subject:To:From:Message-ID:Date:
 MIME-Version:Content-Type;
 b=CQVoj1u3r3ecYN5xoeAHqcwXb+KTnK5u0Jh+71Vsy55r2OxaIcQfDePgsJSBh1/EI
 5mI1Thcqqh+OoV5n+U/bPl1GgSpb/+RNYLSZx4efylMpLuw5jsDBjwH06kYnAYxSor
 yfLw4z/9eUc0DNf3dCepL3x49zRpkb1d1DX4Cyp/2WH1BiYbz8PwoZ/bL38RkGU3wF
 Wzna1hNya8brojGGKblnTFHNS7+9Jt20hurHRlk2nL6WH274708yjsz7gVBFSX1FHY
 c3bWNQWggTRvwa/KEGGciTl4ZyRlEtG7cGvnLhC0j4sHIRX0JgtYtY6anQqVI8/pO3
 186HEpg8w1axg==
Received: from [IPv6:2601:147:c380:23e0:dd8:546c:ecb8:ee79]
 ([IPv6:2601:147:c380:23e0:dd8:546c:ecb8:ee79])
 by resomta-po-02v.sys.comcast.net with ESMTPSA
 id 4DhXl61nXgrkj4DhXlZcoI; Tue, 26 Jan 2021 02:03:29 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: Problem with SPCC 256GB NVMe 1.3 drive - refcount_t: underflow;
 use-after-free.
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <f50bc59c-db11-bb44-55be-7b9db1119872@comcast.net>
 <BYAPR04MB49659C0F0F0E11D166B31E0586A40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <a4c75497-d170-1e0f-8608-282231ff3a8e@comcast.net>
 <BYAPR04MB496542BEF594F0380F7D41CF86A20@BYAPR04MB4965.namprd04.prod.outlook.com>
 <df46d7ce-ce70-1f43-0efd-7153761bcff0@comcast.net>
 <20210121124459.GA156577@localhost.localdomain>
 <c48abecf-8e4f-b76a-c751-1a0d239c99b3@comcast.net>
 <BYAPR04MB4965404638B4C43DBA577D1686A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR04MB4965342B52D5C3C6D8A7892D86A00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <23f49172-5d0e-618a-199d-d568f695dc30@comcast.net>
 <20210125081654.GA226984@localhost.localdomain>
 <6709E718-ABD5-4B69-B4E7-883C4E4CD178@wdc.com>
From: Bradley Chapman <chapman6235@comcast.net>
Message-ID: <05db52bd-7484-56f1-510f-b1bd3808d385@comcast.net>
Date: Mon, 25 Jan 2021 21:03:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6709E718-ABD5-4B69-B4E7-883C4E4CD178@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_021525_636378_072DE3FB 
X-CRM114-Status: GOOD (  15.24  )
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
Reply-To: chapman6235@comcast.net
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

R29vZCBldmVuaW5nIQoKT24gMS8yNS8yMSAzOjM0IEFNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6Cj4gSSBoYXZlIHBvaW50ZWQgdGhhdCBvdXQgb24gZnJpZGF5IGFscmVhZHkgb2ZmbGluZSB0
byByZWR1Y2UgdGhlIG1haWxpbmcgbGlzdCBub2lzZS4KPiAKPj4gT24gSmFuIDI1LCAyMDIxLCBh
dCAxMjoxNiBBTSwgTmlrbGFzIENhc3NlbCA8TmlrbGFzLkNhc3NlbEB3ZGMuY29tPiB3cm90ZToK
Pj4KPj4g77u/T24gRnJpLCBKYW4gMjIsIDIwMjEgYXQgMDc6NTQ6MjZQTSAtMDUwMCwgQnJhZGxl
eSBDaGFwbWFuIHdyb3RlOgo+Pj4gV2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoIGFwcGxpZWQgdG8g
dGhlIE5WTWUgdHJlZSwgbXkgc3lzdGVtIGhhcmQtbG9ja2VkIGFuZAo+Pj4gd291bGQgbm90IHJl
c3BvbmQgdG8gQWx0K1N5c1JRIG9uY2UgSSBtb3VudGVkIHRoZSBmaWxlc3lzdGVtIGFuZCBhdHRl
bXB0ZWQgYQo+Pj4gZGlyZWN0b3J5IGxpc3Rpbmcgb2YgdGhlIHJvb3Qgb2YgdGhlIGZpbGVzeXN0
ZW0uCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvcGNpLmMKPj4+IGluZGV4IDI1NDU2ZDAyZWRkYi4uN2JhNWU4ZTkyZTE5IDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKPj4+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jCj4+PiBAQCAtMzIyOCw2ICszMjI4LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBwY2lfZGV2aWNlX2lkIG52bWVfaWRfdGFibGVbXSA9IHsKPj4+ICAgICAgICAgICAgICAg
ICAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VTLCB9LAo+Pj4g
ICAgICAgICB7IFBDSV9ERVZJQ0UoMHgxNWI3LCAweDIwMDEpLCAgIC8qICBTYW5kaXNrIFNreWhh
d2sgKi8KPj4+ICAgICAgICAgICAgICAgICAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0RJU0FC
TEVfV1JJVEVfWkVST0VTLCB9LAo+Pj4gKyAgICAgICB7IFBDSV9ERVZJQ0UoMHgxZDk3LCAweDIy
NjMpLCAgIC8qICBTUENDICovCj4+PiArICAgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gTlZN
RV9RVUlSS19TSU5HTEVfVkVDVE9SIH0sCj4+PiAgICAgICAgIHsgUENJX0RFVklDRShQQ0lfVkVO
RE9SX0lEX0FQUExFLCAweDIwMDEpLAo+Pj4gICAgICAgICAgICAgICAgIC5kcml2ZXJfZGF0YSA9
IE5WTUVfUVVJUktfU0lOR0xFX1ZFQ1RPUiB9LAo+Pj4gICAgICAgICB7IFBDSV9ERVZJQ0UoUENJ
X1ZFTkRPUl9JRF9BUFBMRSwgMHgyMDAzKSB9LAo+Pj4KPj4KPj4gSGVsbG8gQnJhZGxleSwKPj4K
Pj4gQ2hhaXRhbnlhIGFza2VkIHlvdSB0byB0ZXN0IHRoZSBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJ
VEVfWkVST0VTIHF1aXJrLgo+PiBZb3VyIHBhdGNoIHNlZW1zIHRvIGluc3RlYWQgdXNlIHRoZSBO
Vk1FX1FVSVJLX1NJTkdMRV9WRUNUT1IgcXVpcmsuCj4+Cj4+IERpZCB5b3UgdHJ5IHRoZSBOVk1F
X1FVSVJLX0RJU0FCTEVfV1JJVEVfWkVST0VTIHF1aXJrPwo+Pgo+Pgo+PiBLaW5kIHJlZ2FyZHMs
Cj4+IE5pa2xhcwoKQXMgQ2hhaXRhbnlhIHBvaW50ZWQgb3V0LCBJIGRpZCBpbiBmYWN0IHJlLXRl
c3Qgd2l0aCB0aGUgY29ycmVjdCBwYXRjaCAKYW5kIGV2ZXJ5dGhpbmcgd29ya2VkIGZsYXdsZXNz
bHkuIEkgaGF2ZSBzZW50IHRoZSBjb3JyZWN0ZWQgcGF0Y2hlcyB0byAKQ2hhaXRhbnlhIGRpcmVj
dGx5LgoKQnJhZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
