Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116B9C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 13:35:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D402A20B1F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 13:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bG+gaqR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D402A20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6gS8t7W+kGAj/trVRkQLKN6gG4T4kzVBZcUV5NksxUc=; b=bG+gaqR95CuxM+9KHfeAATXV7
	Kp+4AjPM6SzMM/sceUOWK+EOHQQ7s93zcsWTY2vSPlTH1fNikUlE9jhX7dB1lB7K13fTsXaVqaibO
	MqAfbFM8Z3/PsA/eNd0uYKdk6KjsraNoAKP44FiyJwplb00GamaAuZ+yzMLQ32VdnWFgyiGU+nSPt
	jdkRs9VCnQ3+x9GPukkjFNWnQuRzfTYw0zzcd8IZ+1OO6Vcs22bfAUlLnRp8nh3vo7WJiSkWWxc/y
	TVYOulEkZZ90bTE4xaxBldLUkyHj9Rwlgvk/iHJSWHsLx/F3Tyv296db3U28qYP/7jNqjzCkiQclU
	7OjFD7Clw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxVwY-0004UE-PZ; Mon, 20 Jul 2020 13:34:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxVwW-0004Tq-Uw
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 13:34:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 96B9968BFE; Mon, 20 Jul 2020 15:34:54 +0200 (CEST)
Date: Mon, 20 Jul 2020 15:34:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200720133454.GA2837@lst.de>
References: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
 <20200720033203.11474-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720033203.11474-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_093457_157999_0D52623E 
X-CRM114-Status: GOOD (  16.35  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU3VuLCBKdWwgMTksIDIwMjAgYXQgMDg6MzI6MDNQTSAtMDcwMCwgQ2hhaXRhbnlhIEt1bGth
cm5pIHdyb3RlOgo+IFRoaXMgcGF0Y2ggcmVwbGFjZXMgdGhlIGN0cmwtPm5hbWVzcGFjZXMgdHJh
Y2tpbmcgZnJvbSBsaW5rZWQgbGlzdCB0bwo+IHhhcnJheSBhbmQgaW1wcm92ZXMgdGhlIHBlcmZv
cm1hbmNlLiBGb3IgaG9zdCBldmVuIHRob3VnaAo+IG52bWVfZmluZF9nZXRfbnMoKSBkb2Vzbid0
IGZhbGwgaW50byB0aGUgZmFzdCBwYXRoIHlldCBpdCBkb2VzIGZvcgo+IE5WTWVPRiBwYXNzdGhy
dSBwYXRjaC1zZXJpZXMgd2hpY2ggaXMgY3VycmVudGx5IHVuZGVyIHJldmlldy4gVGhpcwo+IHBy
ZXBhcmVzIHVzIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UgZm9yIGZ1dHVyZSBOVk1lT0YgcGFzc3Ro
cnUgYmFja2VuZAo+IHNpbmNlIG52bWVfZmluZF9nZXRfbnMoKSB1c2VzIHNhbWUgZGF0YSBzdHJ1
Y3R1cmUgYXMgaXQgZG9lcyBpbiB0YXJnZXQKPiB0byBmaW5kIG5hbWVzcGFjZSBpbiBJL08gcGF0
Y2ggZnJvbSBuc2lkIHNwZWNpZmllZCBpbiB0aGUgbnZtZV9yd19jbWQuCgrQhidtIHN0aWxsIG5v
dCByZWFsbHkgc29sZCBvbiB0aGF0IHJhdGlvbmFsZS4uCgo+ICsJaWYgKHhhX2VtcHR5KCZjdHJs
LT5uYW1lc3BhY2VzKSkgewo+ICAJCXJldCA9IC1FTk9UVFk7Cj4gLQkJZ290byBvdXRfdW5sb2Nr
Owo+ICsJCWdvdG8gb3V0Owo+ICAJfQo+IC0KPiAtCW5zID0gbGlzdF9maXJzdF9lbnRyeSgmY3Ry
bC0+bmFtZXNwYWNlcywgc3RydWN0IG52bWVfbnMsIGxpc3QpOwo+IC0JaWYgKG5zICE9IGxpc3Rf
bGFzdF9lbnRyeSgmY3RybC0+bmFtZXNwYWNlcywgc3RydWN0IG52bWVfbnMsIGxpc3QpKSB7Cj4g
LQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLAo+IC0JCQkiTlZNRV9JT0NUTF9JT19DTUQgbm90IHN1
cHBvcnRlZCB3aGVuIG11bHRpcGxlIG5hbWVzcGFjZXMgcHJlc2VudCFcbiIpOwo+IC0JCXJldCA9
IC1FSU5WQUw7Cj4gLQkJZ290byBvdXRfdW5sb2NrOwo+ICsJeGFfZm9yX2VhY2goJmN0cmwtPm5h
bWVzcGFjZXMsIGlkeCwgbnMpIHsKPiArCQlpZiAoY291bnQgPiAwKQo+ICsJCQlnb3RvIGVycjsK
PiArCQljb3VudCsrOwoKSG93IGFib3V0IGZhY3RvcmluZyB0aGUgY2hlY2sgaW50byBhIGxpdHRs
ZQpudm1lX2hhc19tdWx0aXBsZV9uYW1lc3BhY2VzIGhlbHBlciBhbmQgYXZvaWQgdGhlIGJhY2t3
YXJkcyBqdW1waW5nCmdvdG8gbGF0ZXIgb24/Cgo+ICsJcmN1X3JlYWRfbG9jaygpOwo+ICsJbnMg
PSB4YV9sb2FkKCZjdHJsLT5uYW1lc3BhY2VzLCBuc2lkKTsKPiArCW5zID0gbnMgJiYga3JlZl9n
ZXRfdW5sZXNzX3plcm8oJm5zLT5rcmVmKSA/IG5zIDogTlVMTDsKPiArCXJjdV9yZWFkX3VubG9j
aygpOwoKVGhlIGNhbm9uaWNhbCB3YXkgdG8gd3JpdGUgdGhpcyBpczoKCglyY3VfcmVhZF9sb2Nr
KCk7CglucyA9IHhhX2xvYWQoJmN0cmwtPm5hbWVzcGFjZXMsIG5zaWQpOwoJaWYgKG5zICYmICFr
cmVmX2dldF91bmxlc3NfemVybygmbnMtPmtyZWYpKQoJCW5zID0gTlVMTDsKCXJjdV9yZWFkX3Vu
bG9jaygpOwoKPiArIG91dF91bnJlZ2lzdGVyX252bToKCk1heWJlIGNhbGwgdGhpcyBvdXRfdW5y
ZWdpc3Rlcl9saWdodG52bSB0byBiZSBhIGxpdHRsZSBtb3JlIGRlc2NyaXB0aXZlLgoKPiArCj4g
Kwl4YV9sb2NrKCZjdHJsLT5uYW1lc3BhY2VzKTsKPiArCXhhX2Zvcl9lYWNoKCZjdHJsLT5uYW1l
c3BhY2VzLCBpZHgsIG5zKSB7Cj4gKwkJdG5zaWQgPSBucy0+aGVhZC0+bnNfaWQ7Cj4gKwkJaWYg
KHRuc2lkID4gbnNpZCB8fCB0ZXN0X2JpdChOVk1FX05TX0RFQUQsICZucy0+ZmxhZ3MpKSB7Cj4g
KwkJCV9feGFfZXJhc2UoJmN0cmwtPm5hbWVzcGFjZXMsIHRuc2lkKTsKPiArCQkJeGFfdW5sb2Nr
KCZjdHJsLT5uYW1lc3BhY2VzKTsKPiArCQkJLyogRXZlbiBpZiBpbnNlcnQgZmFpbHMga2VlcCBn
b2luZyAqLwo+ICsJCQlyZXQgPSB4YV9pbnNlcnQoJnJtX2FycmF5LCBuc2lkLCBucywgR0ZQX0tF
Uk5FTCk7Cj4gKwkJCWlmIChyZXQpCj4gKwkJCQlwcl9lcnIoInhhX2luc2VydCAlZFxuIiwgcmV0
KTsKPiArCQkJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7Cj4gKwkJfQoKQW5kIHRoaXMgaXMg
d2hlcmUgSSdtIHN0aWxsIHdvcnJpZWQgdGhhdCB3ZSBub3cgbmVlZCBhbiBpbnNlcnQKYXMgcGFy
dCBvZiB0aGUgbmFtZXNwYWNlIGRlbGV0aW9uLiAgRWl0aGVyIGtlZXAgdGhlIGxpc3QgaGVyZSBh
cwpJIHN1Z2dlc3RlZCBiZWZvcmUsIG9yIHdlIGp1c3QgbmVlZCByZXdvcmsgdGhlIGRlbGV0aW9u
IGhlcmUgZmlyc3QuCgoKPiBAQCAtNDExOSwxMSArNDExNCwxOCBAQCB2b2lkIG52bWVfcmVtb3Zl
X25hbWVzcGFjZXMoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiAgCWlmIChjdHJsLT5zdGF0ZSA9
PSBOVk1FX0NUUkxfREVBRCkKPiAgCQludm1lX2tpbGxfcXVldWVzKGN0cmwpOwo+ICAKPiAtCWRv
d25fd3JpdGUoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+IC0JbGlzdF9zcGxpY2VfaW5pdCgm
Y3RybC0+bmFtZXNwYWNlcywgJm5zX2xpc3QpOwo+IC0JdXBfd3JpdGUoJmN0cmwtPm5hbWVzcGFj
ZXNfcndzZW0pOwo+ICsJeGFfbG9jaygmY3RybC0+bmFtZXNwYWNlcyk7Cj4gKwl4YV9mb3JfZWFj
aCgmY3RybC0+bmFtZXNwYWNlcywgaWR4LCBucykgewo+ICsJCV9feGFfZXJhc2UoJmN0cmwtPm5h
bWVzcGFjZXMsIG5zLT5oZWFkLT5uc19pZCk7Cj4gKwkJeGFfdW5sb2NrKCZjdHJsLT5uYW1lc3Bh
Y2VzKTsKPiArCQlyZXQgPSB4YV9pbnNlcnQoJnJtX2FycmF5LCBucy0+aGVhZC0+bnNfaWQsIG5z
LCBHRlBfS0VSTkVMKTsKPiArCQlpZiAocmV0KQo+ICsJCQlwcl9lcnIoInhhX2luc2VydCAlZFxu
IiwgcmV0KTsKPiArCQl4YV9sb2NrKCZjdHJsLT5uYW1lc3BhY2VzKTsKPiArCX0KPiArCXhhX3Vu
bG9jaygmY3RybC0+bmFtZXNwYWNlcyk7CgpTYW1lIGhlcmUuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
