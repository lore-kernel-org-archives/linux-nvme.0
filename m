Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14F5C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:01:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E1360FEE
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 14:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E1360FEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d2qQMEsKaX29AGdo7waJZCfBgRVJzc7quQSaNnx+crE=; b=bBWt1iHgnj/vx6HK/00JmzYlr
	4zAi0kc2XVosaPgoPbUNrHjOed3CTXjkZjqhICm5bItPnmcqsq50wk7XuZr5OXCxcbSLL0vj2TZtG
	FtFArrt1dk7ZgM3taSrTLp3npGf40de9832R7sFuvfEY/mTWG5napnIXZyFamzpIeeWuBXue59uQm
	s5TZiNmCSbed7FlbmqolqNytr3HrsROElx2iNXN5Sms1lJOqE4sltwEjj1IgN3KEUQ4cMQYOMUt7i
	INwqSz747NmNPvk/JCOmlhRMKWsYmMuHWOV8n5Y5o8qcu5a90yqYaIkPvmfsK5xrK85dDX5iGbEMl
	8S5H/p76Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXP1z-002Kli-Bs; Fri, 16 Apr 2021 14:01:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXP1x-002KlW-50
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 14:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=oKbye+kcNsMhffsLXBzApRHPnB3mSJI1a4raYXEvO0k=; b=N8y55F6HpCQLf0PDlZLT+vVuqr
 TkFGvOKtGPuonnqW2wv9lUz0tvHhyD0+6YjDEL4xlTAZ0mNmH8h0gwYAF7ea/sMk6G6Rbwt0utq2W
 9dZtLsrVlV2QTHpl/3RnqJKLNNFM/rHGuJQpzG7p62/3kAEOzFVklaUS3ZYIIuyWVHpYu6qJ2kzOm
 nV+oPL8okvpr4KQZI67pxTkmoN1ZF7/mpdJEXjdCFdDEblxueMTdiOd/FAszdr8FA/gor+TlQyiC0
 fvVB2v6m2I0VbGDSlAdG1/g0qlrCGbtQHIdLGzUpLeqUsraMxiM3waPOyiLy/fVLHfF+yquJmoMOa
 wFX4ToSg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXP1r-009Q6i-IJ
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 14:01:07 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0484EB12D;
 Fri, 16 Apr 2021 14:01:01 +0000 (UTC)
To: Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-3-snitzer@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Message-ID: <da184561-2c97-5807-5c5b-9cc6593693c6@suse.de>
Date: Fri, 16 Apr 2021 16:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415231530.95464-3-snitzer@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_070103_776252_B74E7285 
X-CRM114-Status: GOOD (  25.39  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8xNi8yMSAxOjE1IEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4gRnJvbTogQ2hhbyBMZW5n
IDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+IAo+IFJFUV9GQUlMRkFTVF9UUkFOU1BPUlQgd2FzIGRl
c2lnbmVkIGZvciBTQ1NJLCBiZWNhdXNlIHRoZSBTQ1NJIHByb3RvY29sCj4gZG9lcyBub3QgZGVm
aW5lIHRoZSBsb2NhbCByZXRyeSBtZWNoYW5pc20uIFNDU0kgaW1wbGVtZW50cyBhIGZ1enp5Cj4g
bG9jYWwgcmV0cnkgbWVjaGFuaXNtLCBzbyBSRVFfRkFJTEZBU1RfVFJBTlNQT1JUIGlzIG5lZWRl
ZCB0byBhbGxvdwo+IGhpZ2hlci1sZXZlbCBtdWx0aXBhdGhpbmcgc29mdHdhcmUgdG8gcGVyZm9y
bSBmYWlsb3Zlci9yZXRyeS4KPiAKPiBOVk1lIGlzIGRpZmZlcmVudCB3aXRoIFNDU0kgYWJvdXQg
dGhpcy4gSXQgZGVmaW5lcyBhIGxvY2FsIHJldHJ5Cj4gbWVjaGFuaXNtIGFuZCBwYXRoIGVycm9y
IGNvZGVzLCBzbyBOVk1lIHNob3VsZCByZXRyeSBsb2NhbCBmb3Igbm9uCj4gcGF0aCBlcnJvci4g
SWYgcGF0aCByZWxhdGVkIGVycm9yLCB3aGV0aGVyIHRvIHJldHJ5IGFuZCBob3cgdG8gcmV0cnkK
PiBpcyBzdGlsbCBkZXRlcm1pbmVkIGJ5IGhpZ2hlci1sZXZlbCBtdWx0aXBhdGhpbmcncyBmYWls
b3Zlci4KPiAKPiBVbmxpa2UgU0NTSSwgTlZNZSBzaG91bGRuJ3QgcHJldmVudCByZXRyeSBpZiBS
RVFfRkFJTEZBU1RfVFJBTlNQT1JUCj4gYmVjYXVzZSBOVk1lJ3MgbG9jYWwgcmV0cnkgaXMgbmVl
ZGVkIC0tIGFzIGlzIE5WTWUgc3BlY2lmaWMgbG9naWMgdG8KPiBjYXRlZ29yaXplIHdoZXRoZXIg
YW4gZXJyb3IgaXMgcGF0aCByZWxhdGVkLgo+IAo+IEluIHRoaXMgd2F5LCB0aGUgbWVjaGFuaXNt
IG9mIE5WTWUgbXVsdGlwYXRoIG9yIG90aGVyIG11bHRpcGF0aCBhcmUKPiBub3cgZXF1aXZhbGVu
dC4gVGhlIG1lY2hhbmlzbSBpczogbm9uIHBhdGggcmVsYXRlZCBlcnJvciB3aWxsIGJlCj4gcmV0
cmllZCBsb2NhbGx5LCBwYXRoIHJlbGF0ZWQgZXJyb3IgaXMgaGFuZGxlZCBieSBtdWx0aXBhdGgu
Cj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+IFtz
bml0emVyOiBlZGl0ZWQgaGVhZGVyIGZvciBncmFtbWFyIGFuZCBjbGFyaXR5LCBhbHNvIGFkZGVk
IGNvZGUgY29tbWVudF0KPiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAcmVk
aGF0LmNvbT4KPiAtLS0KPiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgOSArKysrKysrKy0K
PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9j
b3JlLmMKPiBpbmRleCA1NDBkNmZkOGZmZWYuLjQxMzRjZjNjN2U0OCAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
PiBAQCAtMzA2LDcgKzMwNiwxNCBAQCBzdGF0aWMgaW5saW5lIGVudW0gbnZtZV9kaXNwb3NpdGlv
biBudm1lX2RlY2lkZV9kaXNwb3NpdGlvbihzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+ICAJaWYgKGxp
a2VseShudm1lX3JlcShyZXEpLT5zdGF0dXMgPT0gMCkpCj4gIAkJcmV0dXJuIENPTVBMRVRFOwo+
ICAKPiAtCWlmIChibGtfbm9yZXRyeV9yZXF1ZXN0KHJlcSkgfHwKPiArCS8qCj4gKwkgKiBSRVFf
RkFJTEZBU1RfVFJBTlNQT1JUIGlzIHNldCBieSB1cHBlciBsYXllciBzb2Z0d2FyZSB0aGF0Cj4g
KwkgKiBoYW5kbGVzIG11bHRpcGF0aGluZy4gVW5saWtlIFNDU0ksIE5WTWUncyBlcnJvciBoYW5k
bGluZyB3YXMKPiArCSAqIHNwZWNpZmljYWxseSBkZXNpZ25lZCB0byBoYW5kbGUgbG9jYWwgcmV0
cnkgZm9yIG5vbi1wYXRoIGVycm9ycy4KPiArCSAqIEFzIHN1Y2gsIGFsbG93IE5WTWUncyBsb2Nh
bCByZXRyeSBtZWNoYW5pc20gdG8gYmUgdXNlZCBmb3IKPiArCSAqIHJlcXVlc3RzIG1hcmtlZCB3
aXRoIFJFUV9GQUlMRkFTVF9UUkFOU1BPUlQuCj4gKwkgKi8KPiArCWlmICgocmVxLT5jbWRfZmxh
Z3MgJiAoUkVRX0ZBSUxGQVNUX0RFViB8IFJFUV9GQUlMRkFTVF9EUklWRVIpKSB8fAo+ICAJICAg
IChudm1lX3JlcShyZXEpLT5zdGF0dXMgJiBOVk1FX1NDX0ROUikgfHwKPiAgCSAgICBudm1lX3Jl
cShyZXEpLT5yZXRyaWVzID49IG52bWVfbWF4X3JldHJpZXMpCj4gIAkJcmV0dXJuIENPTVBMRVRF
Owo+IApIdWg/CgojZGVmaW5lIGJsa19ub3JldHJ5X3JlcXVlc3QocnEpIFwKICAgICAgICAoKHJx
KS0+Y21kX2ZsYWdzICYgKFJFUV9GQUlMRkFTVF9ERVZ8UkVRX0ZBSUxGQVNUX1RSQU5TUE9SVHwg
XAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJFUV9GQUlMRkFTVF9EUklWRVIpKQoKbWFr
aW5nIHRoZSBvbmx5IF9hY3R1YWxfIGNoYW5nZSBpbiB5b3VyIHBhdGNoIF9ub3RfIGV2YWx1YXRp
bmcgdGhlClJFUV9GQUlMRkFTVF9EUklWRVIsIHdoaWNoIGluY2lkZW50YWxseSBpcyBvbmx5IHVz
ZWQgYnkgdGhlIE5WTWUgY29yZS4KU28gd2hhdCBpcyBpdCB5b3UncmUgdHJ5aW5nIHRvIHNvbHZl
PwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgIEtlcm5l
bCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7D
vHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZykKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
