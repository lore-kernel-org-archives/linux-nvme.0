Return-Path: <SRS0=FZGd=J4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607EFC433B4
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:20:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF73761409
	for <linux-nvme@archiver.kernel.org>; Sat,  1 May 2021 12:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF73761409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z/mEpgbNEU4BqvCdBG9vvw1rCPyH0Fawd3HlNwBKad8=; b=a+oW5efmkRv56YIfb9EaA6XNw
	eDJAB6NBLC7N8kPtBbBrahYLwt4rQlDuJP5KWhAz0Z25OaLY7cVS/SlQacayJUZaOqQumTUFvXBTC
	F4eP8oqKCwmD1QNS5znIX2SpPKli5QpsVyhae/XxwUd8+TGjXkgYeexuGUn5hhDZZt6jZ3rCi464a
	jIEAE8UXXySIhDKw+cTbBXu3KOhhztaxxy+xtmcZkSmx+77haRyH9a8f5U1YTHHIEco4Bd5HaL7Qo
	6le+dPcu2++LN4Z9AJF5vfIYTuvTHEbeGO9U1nrOtelg42nxV7tf+8xmOzcA+7VjlN6DxU41Pt5PA
	u7LM4vHPw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcobI-00A1kF-35; Sat, 01 May 2021 12:20:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcobA-00A1jm-71
 for linux-nvme@desiato.infradead.org; Sat, 01 May 2021 12:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=hlIljAvp8uDOcpzEcKdqnig2GogA+wQx+1i45XkxpXo=; b=OgLDCf4zR7fyoZuolK0R7nY1MF
 bp65NNvF6P86ujJsXoHuvOyhP3UzicVtP/thYLwIwfL+jwjajuTLCRF3noX+8fIMEJhUHbRmI4LuI
 c44icC8vKx2/ETHeWEehpJZDH6J5yocfMPkvAtEKGhPFBW8IcilBbvnkjRb2gd8Mk9RLpEY662qFh
 ZlGab+A1jHQ8cae3a33dLXNatg0GVNf1YrGuVrTlKZh1OKL4Nr4DHuLLDAkx5GzitPR52yUmiG7XM
 Gtvg7RrUWND5i5G90j4e/HguFXI7b8oyY9gESYqsiiWFN45A21fmdf/Kxs5wf41mOStZvn4Gsfs2c
 1JQcEOwA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcob7-001z10-Hz
 for linux-nvme@lists.infradead.org; Sat, 01 May 2021 12:19:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3FBC5B253;
 Sat,  1 May 2021 12:19:48 +0000 (UTC)
Subject: Re: [RFC PATCH v4 09/27] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org
Cc: "David S . Miller davem @ davemloft . net --cc=Jakub Kicinski"
 <kuba@kernel.org>, aelior@marvell.com, mkalderon@marvell.com,
 okulkarni@marvell.com, pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-10-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <62c750cb-b757-510e-a2fa-849f8f89d6e2@suse.de>
Date: Sat, 1 May 2021 14:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210429190926.5086-10-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210501_051949_758342_0CDFEA3A 
X-CRM114-Status: GOOD (  18.27  )
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

T24gNC8yOS8yMSA5OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IEFyaWUgR2Vyc2hi
ZXJnIDxhZ2Vyc2hiZXJnQG1hcnZlbGwuY29tPgo+IAo+IE1vdmUgTlZNRl9BTExPV0VEX09QVFMg
YW5kIE5WTUZfUkVRVUlSRURfT1BUUyBkZWZpbml0aW9ucwo+IHRvIGhlYWRlciBmaWxlLCBzbyBp
dCBjYW4gYmUgdXNlZCBieSB0cmFuc3BvcnQgbW9kdWxlcy4KPiAKPiBBY2tlZC1ieTogSWdvciBS
dXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWUgR2Vy
c2hiZXJnIDxhZ2Vyc2hiZXJnQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWth
ciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2Fy
IEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFs
IEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZWwg
RWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxz
bWFsaW5AbWFydmVsbC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMg
fCA3IC0tLS0tLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaCB8IDcgKysrKysrKwo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2ZhYnJpY3MuYwo+IGluZGV4IDYwNGFiMGU1YTJhZC4uNTVkNzEyNWM4NDgzIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2ZhYnJpY3MuYwo+IEBAIC0xMDAxLDEzICsxMDAxLDYgQEAgdm9pZCBudm1mX2ZyZWVfb3B0
aW9ucyhzdHJ1Y3QgbnZtZl9jdHJsX29wdGlvbnMgKm9wdHMpCj4gICB9Cj4gICBFWFBPUlRfU1lN
Qk9MX0dQTChudm1mX2ZyZWVfb3B0aW9ucyk7Cj4gICAKPiAtI2RlZmluZSBOVk1GX1JFUVVJUkVE
X09QVFMJKE5WTUZfT1BUX1RSQU5TUE9SVCB8IE5WTUZfT1BUX05RTikKPiAtI2RlZmluZSBOVk1G
X0FMTE9XRURfT1BUUwkoTlZNRl9PUFRfUVVFVUVfU0laRSB8IE5WTUZfT1BUX05SX0lPX1FVRVVF
UyB8IFwKPiAtCQkJCSBOVk1GX09QVF9LQVRPIHwgTlZNRl9PUFRfSE9TVE5RTiB8IFwKPiAtCQkJ
CSBOVk1GX09QVF9IT1NUX0lEIHwgTlZNRl9PUFRfRFVQX0NPTk5FQ1QgfFwKPiAtCQkJCSBOVk1G
X09QVF9ESVNBQkxFX1NRRkxPVyB8XAo+IC0JCQkJIE5WTUZfT1BUX0ZBSUxfRkFTVF9UTU8pCj4g
LQo+ICAgc3RhdGljIHN0cnVjdCBudm1lX2N0cmwgKgo+ICAgbnZtZl9jcmVhdGVfY3RybChzdHJ1
Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKmJ1ZikKPiAgIHsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5oIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4g
aW5kZXggODg4YjEwOGQ4N2E0Li5iNzYyN2U4ZGNhYWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvZmFicmljcy5oCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4g
QEAgLTY4LDYgKzY4LDEzIEBAIGVudW0gewo+ICAgCU5WTUZfT1BUX0ZBSUxfRkFTVF9UTU8JPSAx
IDw8IDIwLAo+ICAgfTsKPiAgIAo+ICsjZGVmaW5lIE5WTUZfUkVRVUlSRURfT1BUUwkoTlZNRl9P
UFRfVFJBTlNQT1JUIHwgTlZNRl9PUFRfTlFOKQo+ICsjZGVmaW5lIE5WTUZfQUxMT1dFRF9PUFRT
CShOVk1GX09QVF9RVUVVRV9TSVpFIHwgTlZNRl9PUFRfTlJfSU9fUVVFVUVTIHwgXAo+ICsJCQkJ
IE5WTUZfT1BUX0tBVE8gfCBOVk1GX09QVF9IT1NUTlFOIHwgXAo+ICsJCQkJIE5WTUZfT1BUX0hP
U1RfSUQgfCBOVk1GX09QVF9EVVBfQ09OTkVDVCB8XAo+ICsJCQkJIE5WTUZfT1BUX0RJU0FCTEVf
U1FGTE9XIHxcCj4gKwkJCQkgTlZNRl9PUFRfRkFJTF9GQVNUX1RNTykKPiArCj4gICAvKioKPiAg
ICAqIHN0cnVjdCBudm1mX2N0cmxfb3B0aW9ucyAtIFVzZWQgdG8gaG9sZCB0aGUgb3B0aW9ucyBz
cGVjaWZpZWQKPiAgICAqCQkJICAgICAgd2l0aCB0aGUgcGFyc2luZyBvcHRzIGVudW0uCj4gCgpX
aHkgZG8geW91IG5lZWQgdGhlbT8gTm9uZSBvZiB0aGUgb3RoZXIgdHJhbnNwb3J0IGRyaXZlcnMg
dXNlIHRoZW0sIHdoeSB5b3U/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
