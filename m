Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2B0C433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 04:31:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760CF21744
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 04:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cilq1X0I";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NQgQnIg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760CF21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9x4Ebb657d+j0lfhAIS4D95cuNONhVwLOJestTotD38=; b=cilq1X0I4m0v87Xp6hiZ0iyYg
	IVsfa4ndMOcxcJWZuz7RtSsgs4KErM/UXiM+OUmUPyAyq1lTdmBmQomIch3Vj1bUir1if2mb0wLJh
	booYvlD27yXsJWtQ6Vcl4pt+s+socAJQM4zjQDx8IA4JAM2knmrubVtewhY2y7TgB8mP8FzRQApc3
	uzNN8hlOoFyrlTFzCATIuQV6nYkzp6MPpefX7iYvKcgGnjTWMln5Cete0Dvtc2CTmgOYxdGelGXPX
	vpwbk4jOo+jcxEaFttoieIlmoaLeaZANtQJTXH9BrVq1CeIh/w5fY0bxnon3okSm/CLQ3X/UaRnSH
	aM/JS7XjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3u2J-0000fy-6H; Fri, 07 Aug 2020 04:31:19 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3u2G-0000fY-4e
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 04:31:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFFCDacMNcj+hLk5ohEUbMtfe5CCmueG3YFGXgnybGU=; b=NQgQnIg7bBEB+ntzte+J3n6lEs
 /HY2H9a+dHe/3voM0qZlttH67MJGpCwBnmdEl1nTLGBhQ7uFF2nBK5r/vnA0fcsge7BrNad4r4Kdr
 hrP/GgoBFGDop6g+mhZffD8aZWhvwwgLKWUolEEl6tAGqAcocGyQkvF7XOxpoNrEQHbnnvEMkF6kL
 m+KvWdKBLLdCYHRwDHgJ/wVlIUo5fmRpU5jBMkkoP016yyYuw48ZuzVLoULFfgmik61oPAIkMJjn4
 rSpk5CocPLzGw9GGLBHvy8MmvntyLgPCw3AczIMbKHBNIGDy/yEst14sK+MaX/1q0T2ywykcRQHt5
 oWl+gWSA==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1k3u2B-0000pF-OG; Thu, 06 Aug 2020 22:31:13 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200807022032.48873-1-chaitanya.kulkarni@wdc.com>
 <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c40a3189-9417-9dd7-7ae6-7cc26815c90c@deltatee.com>
Date: Thu, 6 Aug 2020 22:31:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807022032.48873-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_003116_247949_B40F5E6C 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLTA4LTA2IDg6MjAgcC5tLiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+IElu
IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIGJlZm9yZSBzdWJtaXR0aW5nIHRoZSBwYXNzdGhy
dSBjbWTCoHdlCj4gbWF5IGNvbWUgYWNyb3NzwqBlcnJvciBlLmcuIGdldHRpbmcgbnMgZnJvbSBw
YXNzdGhydSBjb250cm9sbGVyLAo+IGFsbG9jYXRpbmcgYSByZXF1ZXN0IGZyb20gcGFzc3RocnUg
Y29udHJvbGxlciwgZXRjLiBGb3IgYWxsIHRoZSBmYWlsdXJlCj4gY2FzZXMgaXQgb25seSB1c2Vz
IHNpbmdsZSBnb3RvIGxhYmVsIGZhaWxfb3V0Lgo+IAo+IEluIHRoZSB0YXJnZXQgY29kZSwgd2Ug
Zm9sbG93IHRoZSBwYXR0ZXJuIHRvIGhhdmUgYSBzZXBhcmF0ZSBsYWJlbCBmb3IKPiBlYWNoIGVy
cm9yIG91dCB0aGUgY2FzZSB3aGVuIHNldHRpbmcgdXAgbXVsdGlwbGUgdGhpbmdzIGJlZm9yZSB0
aGUgYWN0dWFsCj4gYWN0aW9uLgo+IAo+IFRoaXMgcGF0Y2ggZm9sbG93cyB0aGUgc2FtZSBwYXR0
ZXJuIGFuZCByZW5hbWVzIGdlbmVyaWMgZmFpbF9vdXQgbGFiZWwKPiB0byBvdXRfcHV0X25zIGFu
ZCB1cGRhdGVzIHRoZSBlcnJvciBvdXQgY2FzZXMgaW4gdGhlCj4gbnZtZXRfcGFzc3RocnVfZXhl
Y3V0ZV9jbWQoKSB3aGVyZSBpdCBpcyBuZWVkZWQuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4KPiAtLS0KPiAgZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jIHwgOSArKysrKy0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5j
Cj4gaW5kZXggODlkOTFkYzk5OWE2Li5lN2RiY2ExMjc4NWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jCj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9wYXNz
dGhydS5jCj4gQEAgLTIzMCw3ICsyMzAsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9wYXNzdGhydV9l
eGVjdXRlX2NtZChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCj4gIAkJaWYgKHVubGlrZWx5KCFucykp
IHsKPiAgCQkJcHJfZXJyKCJmYWlsZWQgdG8gZ2V0IHBhc3N0aHJ1IG5zIG5zaWQ6JXVcbiIsIG5z
aWQpOwo+ICAJCQlzdGF0dXMgPSBOVk1FX1NDX0lOVkFMSURfTlMgfCBOVk1FX1NDX0ROUjsKPiAt
CQkJZ290byBmYWlsX291dDsKPiArCQkJZ290byBvdXQ7CgpOb3Qgc3VyZSBpdCdzIG5lY2Vzc2Fy
eSB0byBoYXZlIHRoaXMgZXh0cmEgbGFiZWwgc2VlaW5nICJpZiAobnMpIiB0YWtlcwpjYXJlIG9m
IHRoaW5ncy4gQnV0LCBJIGd1ZXNzLCBpdCBkb2Vzbid0IHJlYWxseSBodXJ0LgoKRm9yIGJvdGgg
dGhpcyBwYXRjaCBhbmQgdGhlIG5leHQgb25lOgoKUmV2aWV3ZWQtYnk6IExvZ2FuIEd1bnRob3Jw
ZSA8bG9nYW5nQGRlbHRhdGVlLmNvbT4KCkxvZ2FuCgo+ICAJCX0KPiAgCj4gIAkJcSA9IG5zLT5x
dWV1ZTsKPiBAQCAtMjQwLDE0ICsyNDAsMTQgQEAgc3RhdGljIHZvaWQgbnZtZXRfcGFzc3RocnVf
ZXhlY3V0ZV9jbWQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQo+ICAJaWYgKElTX0VSUihycSkpIHsK
PiAgCQlycSA9IE5VTEw7Cj4gIAkJc3RhdHVzID0gTlZNRV9TQ19JTlRFUk5BTDsKPiAtCQlnb3Rv
IGZhaWxfb3V0Owo+ICsJCWdvdG8gb3V0X3B1dF9uczsKPiAgCX0KPiAgCj4gIAlpZiAocmVxLT5z
Z19jbnQpIHsKPiAgCQlyZXQgPSBudm1ldF9wYXNzdGhydV9tYXBfc2cocmVxLCBycSk7Cj4gIAkJ
aWYgKHVubGlrZWx5KHJldCkpIHsKPiAgCQkJc3RhdHVzID0gTlZNRV9TQ19JTlRFUk5BTDsKPiAt
CQkJZ290byBmYWlsX291dDsKPiArCQkJZ290byBvdXRfcHV0X25zOwo+ICAJCX0KPiAgCX0KPiAg
Cj4gQEAgLTI3NCw5ICsyNzQsMTAgQEAgc3RhdGljIHZvaWQgbnZtZXRfcGFzc3RocnVfZXhlY3V0
ZV9jbWQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQo+ICAKPiAgCXJldHVybjsKPiAgCj4gLWZhaWxf
b3V0Ogo+ICtvdXRfcHV0X25zOgo+ICAJaWYgKG5zKQo+ICAJCW52bWVfcHV0X25zKG5zKTsKPiAr
b3V0Ogo+ICAJbnZtZXRfcmVxX2NvbXBsZXRlKHJlcSwgc3RhdHVzKTsKPiAgCWJsa19wdXRfcmVx
dWVzdChycSk7Cj4gIH0KPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK
