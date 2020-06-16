Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1200C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 12:28:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE71F207C4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 12:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hgBdGipe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="qyK9J9uQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE71F207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8dIpklv7Fpd+Zz7XHva07ESzOZyh4QdcYo16ku59C2U=; b=hgBdGipeB1cFtYD8mCZ1TzoBb
	A2bvineito57jAyEO2/VsdjLUlon/NPd5PeVk1n7Z3lqKTON3277kBuwGo4Qu3T7n9Cj9JXXqeVTX
	tOx7umhP6kyaOl8pfsZv56lmPcklH5T8Pv+Eb19NmUzhPmiHGP+XyDLcuqQWWjmGmJFFPT0yAWNOS
	QEp5x5GQh5Zqr2QJ8RMliKnrLoEN/6s7CVbYJ7dkCFiuwC2LCovc42+l5t59lLM2CYXI5EIN1C8Eh
	bBxhDOQOJZ72vNIUo4Siyl26x1UO9+BVpggMzffjDulFXWAcFI54bUQCna8oJGRpY85GKE8TC7sSy
	cIt4dmPag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlAh7-0001Yu-6G; Tue, 16 Jun 2020 12:28:01 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlAh3-0001X1-FA
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 12:27:59 +0000
Received: by mail-wr1-x441.google.com with SMTP id p5so20540837wrw.9
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 05:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=f3FqSsegVWuONp3eG1WkA/5RlLNylVls991uj2lRwqI=;
 b=qyK9J9uQoKsaNt2FGRy0BUP/bfjDIRw0YZp1nruNfgz7pQmEDjNLnahweKf/xLrnZa
 E2qZ94//oAm+qdeYNTp5H0YAH5CwICOoR96qd8JPLrcmS02WzF+o+fgYS9jMkm+MiC57
 f9g18fu0/wqugZ5XpJWc8J5uKNgrKEMuLqnDT3GIcmxf1Z9lE5RM4yHX2MdJ7fJh8gln
 EMKK8oF9MlJiOrc9DRiMXfjfMXJ5rh3Pl3xvr4fOR0hVeVeauxRybulEzDGNx0Glfm0P
 hwHSpuhgnCUhroaUt3yr0Zfght5PmbHNf3vLdSZdy3UDcrqFPqq5IuMZHtCLjTQH2FL8
 8qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=f3FqSsegVWuONp3eG1WkA/5RlLNylVls991uj2lRwqI=;
 b=IDfOkstd5KdAJexalxOYU3cmJ3TAu9JfSjyfCuvDG/w6q+WjCST35N0GhVE4R9YEti
 cgp574r4jBsMUqUkei3vytR1HHiVmgh5ufqx6bVuaxKfG/mmsX+okNwAuypF2al4trHT
 MT+RN42/6L87a16IAxBKPo7Y6ZgstJPz5ijyX3lTfAh9FtmTG23LlKYoFVr26yc0F9Zp
 cF4X0PtTWm34Db+AGmtmlQ73XWadIe8orRW2so/uV6Ntru3vNO5fz6z3+NGd2SxSVHpo
 qDuUlc0QUE9ODP/yndpknSgLxM9BOsUXFsF/swEsAe5e1IvmHWUNv4upOLqZL1vzbJqv
 NYzg==
X-Gm-Message-State: AOAM530h5QlxEvHDfKTDF9raWMGohRwTOfWtzlwFv1u+YjPA0L+3dZbw
 9lz1lb2wiYlRAdjeiSKxMeWhRg==
X-Google-Smtp-Source: ABdhPJxN7epVg3PiMWkO7GDgGTIqnGR7t9+3TLGyUPPj2EK8eXiPAJ0rW5PBN9YTxhs9vmhG0BT79g==
X-Received: by 2002:adf:82d0:: with SMTP id 74mr2701433wrc.138.1592310476204; 
 Tue, 16 Jun 2020 05:27:56 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id e25sm4487850wrc.69.2020.06.16.05.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 05:27:55 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <0a49ade0-1961-ee21-30b6-de589d7ddd48@lightnvm.io>
Date: Tue, 16 Jun 2020 14:27:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_052757_531862_D608E540 
X-CRM114-Status: GOOD (  15.95  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ajay Joshi <ajay.joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Aravind Ramesh <aravind.ramesh@wdc.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYvMDYvMjAyMCAxNC4yNCwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBPbiAxNi4wNi4y
MDIwIDE0OjA2LCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+PiBPbiAxNi8wNi8yMDIwIDE0LjAw
LCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+Pj4gT24gMTYuMDYuMjAyMCAxMzoxOCwgTWF0aWFz
IEJqw7hybGluZyB3cm90ZToKPj4+PiBPbiAxNi8wNi8yMDIwIDEyLjQxLCBKYXZpZXIgR29uesOh
bGV6IHdyb3RlOgo+Pj4+PiBPbiAxNi4wNi4yMDIwIDA4OjM0LCBLZWl0aCBCdXNjaCB3cm90ZToK
Pj4+Pj4+IEFkZCBzdXBwb3J0IGZvciBOVk0gRXhwcmVzcyBab25lZCBOYW1lc3BhY2VzIChaTlMp
IENvbW1hbmQgU2V0IAo+Pj4+Pj4gZGVmaW5lZAo+Pj4+Pj4gaW4gTlZNIEV4cHJlc3MgVFA0MDUz
LiBab25lZCBuYW1lc3BhY2VzIGFyZSBkaXNjb3ZlcmVkIGJhc2VkIG9uIAo+Pj4+Pj4gdGhlaXIK
Pj4+Pj4+IENvbW1hbmQgU2V0IElkZW50aWZpZXIgcmVwb3J0ZWQgaW4gdGhlIG5hbWVzcGFjZXMg
TmFtZXNwYWNlCj4+Pj4+PiBJZGVudGlmaWNhdGlvbiBEZXNjcmlwdG9yIGxpc3QuIEEgc3VjY2Vz
c2Z1bGx5IGRpc2NvdmVyZWQgWm9uZWQKPj4+Pj4+IE5hbWVzcGFjZSB3aWxsIGJlIHJlZ2lzdGVy
ZWQgd2l0aCB0aGUgYmxvY2sgbGF5ZXIgYXMgYSBob3N0IG1hbmFnZWQKPj4+Pj4+IHpvbmVkIGJs
b2NrIGRldmljZSB3aXRoIFpvbmUgQXBwZW5kIGNvbW1hbmQgc3VwcG9ydC4gQSBuYW1lc3BhY2Ug
Cj4+Pj4+PiB0aGF0Cj4+Pj4+PiBkb2VzIG5vdCBzdXBwb3J0IGFwcGVuZCBpcyBub3Qgc3VwcG9y
dGVkIGJ5IHRoZSBkcml2ZXIuCj4+Pj4+Cj4+Pj4+IFdoeSBhcmUgd2UgZW5mb3JjaW5nIHRoZSBh
cHBlbmQgY29tbWFuZD8gQXBwZW5kIGlzIG9wdGlvbmFsIG9uIHRoZQo+Pj4+PiBjdXJyZW50IFpO
UyBzcGVjaWZpY2F0aW9uLCBzbyB3ZSBzaG91bGQgbm90IG1ha2UgdGhpcyBtYW5kYXRvcnkgaW4g
Cj4+Pj4+IHRoZQo+Pj4+PiBpbXBsZW1lbnRhdGlvbi4gU2VlIHNwZWNpZmljcyBiZWxvdy4KPj4+
Cj4+Pj4KPj4+PiBUaGVyZSBpcyBhbHJlYWR5IGdlbmVyYWwgc3VwcG9ydCBpbiB0aGUga2VybmVs
IGZvciB0aGUgem9uZSBhcHBlbmQgCj4+Pj4gY29tbWFuZC4gRmVlbCBmcmVlIHRvIHN1Ym1pdCBw
YXRjaGVzIHRvIGVtdWxhdGUgdGhlIHN1cHBvcnQuIEl0IGlzIAo+Pj4+IG91dHNpZGUgdGhlIHNj
b3BlIG9mIHRoaXMgcGF0Y2hzZXQuCj4+Pj4KPj4+Cj4+PiBJdCBpcyBmaW5lIHRoYXQgdGhlIGtl
cm5lbCBzdXBwb3J0cyBhcHBlbmQsIGJ1dCB0aGUgWk5TIHNwZWNpZmljYXRpb24KPj4+IGRvZXMg
bm90IGltcG9zZSB0aGUgaW1wbGVtZW50YXRpb24gZm9yIGFwcGVuZCwgc28gdGhlIGRyaXZlciBz
aG91bGQgbm90Cj4+PiBkbyB0aGF0IGVpdGhlci4KPj4+Cj4+PiBaTlMgU1NEcyB0aGF0IGNob29z
ZSB0byBsZWF2ZSBhcHBlbmQgYXMgYSBub24taW1wbGVtZW50ZWQgb3B0aW9uYWwKPj4+IGNvbW1h
bmQgc2hvdWxkIG5vdCByZWx5IG9uIGVtdWxhdGVkIFNXIHN1cHBvcnQsIHNwZWNpYWxseSB3aGVu
Cj4+PiB0cmFkaXRpb25hbCB3cml0ZXMgd29yayB2ZXJ5IGZpbmUgZm9yIGEgbGFyZ2UgcGFydCBv
ZiBjdXJyZW50IFpOUyB1c2UKPj4+IGNhc2VzLgo+Pj4KPj4+IFBsZWFzZSwgcmVtb3ZlIHRoaXMg
dmlydHVhbCBjb25zdHJhaW50Lgo+Pgo+PiBUaGUgWm9uZSBBcHBlbmQgY29tbWFuZCBpcyBtYW5k
YXRvcnkgZm9yIHpvbmVkIGJsb2NrIGRldmljZXMuIFBsZWFzZSAKPj4gc2VlIGh0dHBzOi8vbHdu
Lm5ldC9BcnRpY2xlcy84MTg3MDkvIGZvciB0aGUgYmFja2dyb3VuZC4KPgo+IEkgZG8gbm90IHNl
ZSBhbnl3aGVyZSBpbiB0aGUgYmxvY2sgbGF5ZXIgdGhhdCBhcHBlbmQgaXMgbWFuZGF0b3J5IGZv
cgo+IHpvbmVkIGRldmljZXMuIEFwcGVuZCBpcyBlbXVsYXRlZCBvbiBaQkMsIGJ1dCBiZXlvbmQg
dGhhdCB0aGVyZSBpcyBubwo+IG1hbmRhdG9yeSBiaXRzLiBQbGVhc2UgZXhwbGFpbi4KPgo+PiBQ
bGVhc2Ugc3VibWl0cGF0Y2hlcyBpZiB5b3Ugd2FudCB0byBoYXZlIHN1cHBvcnQgZm9yIFpOUyBk
ZXZpY2VzIHRoYXQKPj4gZG9lcyBub3QgaW1wbGVtZW50IHRoZSBab25lIEFwcGVuZCBjb21tYW5k
LiBJdCBpcyBvdXRzaWRlIHRoZSBzY29wZQo+PiBvZiB0aGlzIHBhdGNoc2V0Lgo+Cj4gVGhhdCB3
ZSB3aWxsLgo+ClRoYW5rcywgYXBwcmVjaWF0ZSBpdC4KCkJlc3QsIE1hdGlhcwoKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxp
bmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
