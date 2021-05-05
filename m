Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7E7C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:32:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9162E613D8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9162E613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dwEEZz5Opn2xXdmYCdxl5RBQoA/6pBsaS852N1Pu4AM=; b=MDL+M6wOWczrHNveICT/o1dTY
	/x8sR4n5v1qvCGC9IVobTS75SeVKXWBXrpgHx2X6Bph1VjY6bjefEb3GKlZ1VVqWVElgKA1afCqZT
	Co4Fwk+9QdsCnGCzkJmDhUj6vh5pGrnhH+r4z0hsKKnWVNJNw6gkIFnKHE13QRkjC1njnYr5KEAh0
	/1yM9EMyuEjcif+c/qcvkskIP3TRUTbK0G8SIkQC+demBdgjKxmUaN87fGPvv0zq/FAAMKD2rrJxR
	KAyd6vBXiznsREo49QDr3i2PglC43YCx0I4tsLt8U3M4HcxKzBDqy7NyICjQeUvQ7Y5vQr1RHBpF3
	nkjrX9SsQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leOCD-002H31-IB; Wed, 05 May 2021 20:32:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOCA-002H2o-C3
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 20:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=5uS0RYrTpdpQ25rD0tXebKu0BNUyKeCAxS/1e0rkoHc=; b=RxjUweutHcveIusKrUJogKkYh1
 BhEbdMC6wvHmdbf1unYTaz3xET4n1ClDxgrmCfwMSg20eBOMkYYTu25viar3yOcvj+aOv8l2aYvEn
 Ws7QhD7CqeZvRL1BZzK8Aqv2mmG29cJe2lk+gsajZxjshMNt7oinwCHxi+xEvctGgiPDCaZ4aOoe3
 YCDsfwT9aF0FJvLU/ClV3Dl3btYi0kekb/WCW0sTRXGFV/5bZuZ53aiq5ydJVtwmEikYHLZSvt0qQ
 IYUjrqg9ss/c1UVn+W2Zzi633m8o/uCA3k79YA+lorsNGCdL1wGefIsP6P1XTQPXwOB3reFPfuUdl
 h6FR43DA==;
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leOC7-005FRH-Eh
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 20:32:33 +0000
Received: by mail-pf1-f173.google.com with SMTP id e15so2835388pfv.10
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 13:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5uS0RYrTpdpQ25rD0tXebKu0BNUyKeCAxS/1e0rkoHc=;
 b=iriDHY7BxpG06DsK1XW2JHg7XQ9meaXHmhj/ThKmrOUmtOgHc5k8ZfSnn1U/FKiDAg
 yCAwpiHtYma2HE52xwJUtDL7Cy4cOCtK75sV4LBJSicW+LfQG7LDtt3QW2MQYeKPoqE8
 92souw/Dnl98wtMDZ9tadZUOW8d5xmBmJqf0lM8gnNS0Nq/5GX5LJbmBjWiBejRcTDXY
 Mz+IL4ilMTuBXh2fMmU+V6r/R6TAEcm4duKaWVEVgpLd1Dmdd30YtcSP7SJrlgyc9wiD
 mEsOHKd6lEkYEAd2Ra+leWpmnqtMbP6v+EiGOMaodYhaE758Mhz8IiwMVTPaFJVXxSAa
 pamA==
X-Gm-Message-State: AOAM530eKg68RhTYnjdFAsYpd1nHvAyA8b6AjfAjECO78RsGsTfchfF4
 +alMd1YkuoEzpYCHnSzPC7s=
X-Google-Smtp-Source: ABdhPJzw3apKXBFofJRFklZv3LnxJZqUi4YrKTO8Jn+SM9esI/MtNz+sUR30L1nBRN0PDV1aLO6kFQ==
X-Received: by 2002:a65:5c0a:: with SMTP id u10mr672100pgr.332.1620246749646; 
 Wed, 05 May 2021 13:32:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:e504:8c1:c1db:d524?
 ([2601:647:4802:9070:e504:8c1:c1db:d524])
 by smtp.gmail.com with ESMTPSA id m19sm135446pjq.41.2021.05.05.13.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 May 2021 13:32:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4a5680c2-9a6c-377b-2666-cbc1fe105cb5@grimberg.me>
Date: Wed, 5 May 2021 13:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_133231_519966_007DC55A 
X-CRM114-Status: GOOD (  33.59  )
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

Cj4+PiBHaXZlbiB0aGF0IHRoaXMgd2FzIHRoZSBvcmlnaW5hbCBpbnRlbnQgZm9yIGhvc3RfdHJh
ZGRyLCB3aHkgbm90IGhhdmUKPj4+IGhvc3RfdHJhZGRyIHJlc29sdmUgdGhlIGlmYWNlIGZyb20g
dGhlIGFkZHJlc3MgYW5kIHNldCBzb2Nrb3B0Cj4+PiBTT19CSU5EVE9ERVZJQ0Ugb24gaXQ/Cj4+
Pgo+PiBUaGF0IHdhcyBteSBxdWVzdGlvbiwgdG9vLgo+Pgo+PiBJIHdvdWxkIHZhc3RseSBwcmVm
ZXIgdG8gbm90IGhhdmUgYW5vdGhlciBvcHRpb24gdG8gZGVhbCB3aXRoIChhcyBpdCByYWlzZXMg
dGhlCj4+IHF1ZXN0aW9uIHdoZXRoZXIgdG8gYWRkIGl0IGVnIGR1cmluZyAnbnZtZSBjb25uZWN0
LWFsbCcpIEFuZCBvbmUgY291bGQKPj4gYXJndWUgdGhhdCB0aGlzIHdhcyB0aGUgaW50ZW50aW9u
IG9mIF9oYXZpbmdfIHRoZSBob3N0X3RyYWRkciBhcmd1bWVudCBpbgo+PiB0aGUgZmlyc3QgcGxh
Y2UgLi4uCj4+Cj4+IENoZWVycywKPj4KPj4gSGFubmVzCj4+IC0tCj4+IERyLiBIYW5uZXMgUmVp
bmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cj4+IGhhcmVAc3VzZS5kZQkJ
CSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4Cj4+IFNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCj4+IEdGOiBGLiBJbWVuZMO2cmZmZXIs
IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQo+IAo+IEhpIFNhZ2kgYW5kIEhhbm5lcywKPiAKPiBD
b3JyZWN0IG1lIGlmIEknbSB3cm9uZywgYnV0IGl0IHNvdW5kcyBsaWtlIGhvc3RfdHJhZGRyIHdh
cyBwcmltYXJpbHkgYWRkZWQgZm9yIEZDIChhdCBsZWFzdCBpdCB3YXNuJ3QgdGVzdGVkIGZvciBU
Q1Agc2luY2UgaXQgZG9lcyBub3Qgd29yayBpbiBpdHMgY3VycmVudCBzdGF0ZSkuIEknbSBub3Qg
YW4gZXhwZXJ0IG9uIEZDIGFuZCBtYXliZSBzcGVjaWZ5aW5nIGFuIGFkZHJlc3MgaXMgdGhlIHJp
Z2h0IChhbmQgb25seSkgd2F5IHRvIHNwZWNpZnkgYW5kIGludGVyZmFjZSBmb3IgRkMuIEZvciBU
Q1AsIGhvd2V2ZXIsIGl0J3Mgbm90IGFkdmlzYWJsZS4gU3BlY2lmeWluZyBhbiBpbnRlcmZhY2Ug
YnkgaXRzIGFzc29jaWF0ZWQgSVAgYWRkcmVzcyBpcyBsZXNzIGludHVpdGl2ZSB0aGFuIHNwZWNp
ZnlpbmcgdGhlIGFjdHVhbCBpbnRlcmZhY2UgbmFtZSBhbmQsIGluIHNvbWUgY2FzZXMsIGl0IHNp
bXBseSB3b24ndCB3b3JrLiBUaGF0J3MgYmVjYXVzZSB0aGUgYXNzb2NpYXRpb24gYmV0d2VlbiBp
bnRlcmZhY2VzIGFuZCBJUCBhZGRyZXNzZXMgaXMgbm90IHByZWRpY3RhYmxlLiBJUCBhZGRyZXNz
ZXMgY2FuIGJlIGNoYW5nZWQgb3IgY2FuIGNoYW5nZSBieSB0aGVtc2VsdmVzIG92ZXIgdGltZSAo
ZS5nLiBESENQKS4gSW50ZXJmYWNlIG5hbWVzIGFyZSBwcmVkaWN0YWJsZSBbMV0gYW5kIHdpbGwg
cGVyc2lzdCBvdmVyIHRpbWUuIENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgY29uZmlndXJhdGlvbi4K
PiAKPiAxOiBsbzogPExPT1BCQUNLLFVQLExPV0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mgbm9xdWV1
ZSBzdGF0ZSBVTktOT1dOIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwCj4gICAgICBsaW5rL2xvb3Bi
YWNrIDAwOjAwOjAwOjAwOjAwOjAwIGJyZCAwMDowMDowMDowMDowMDowMAo+ICAgICAgaW5ldCAx
MDAuMC4wLjEwMC8yNCBzY29wZSBnbG9iYWwgbG8KPiAgICAgICAgIHZhbGlkX2xmdCBmb3JldmVy
IHByZWZlcnJlZF9sZnQgZm9yZXZlcgo+IDI6IGVucDBzMzogPEJST0FEQ0FTVCxNVUxUSUNBU1Qs
VVAsTE9XRVJfVVA+IG10dSAxNTAwIHFkaXNjIGZxX2NvZGVsIHN0YXRlIFVQIGdyb3VwIGRlZmF1
bHQgcWxlbiAxMDAwCj4gICAgICBsaW5rL2V0aGVyIDA4OjAwOjI3OjIxOjY1OmVjIGJyZCBmZjpm
ZjpmZjpmZjpmZjpmZgo+ICAgICAgaW5ldCAxMDAuMC4wLjEwMC8yNCBzY29wZSBnbG9iYWwgZW5w
MHMzCj4gICAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXIKPiAz
OiBlbnAwczg6IDxCUk9BRENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlz
YyBmcV9jb2RlbCBzdGF0ZSBVUCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMAo+ICAgICAgbGluay9l
dGhlciAwODowMDoyNzo0Zjo5NTo1YyBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYKPiAgICAgIGluZXQg
MTAwLjAuMC4xMDAvMjQgc2NvcGUgZ2xvYmFsIGVucDBzOAo+ICAgICAgICAgdmFsaWRfbGZ0IGZv
cmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyCj4gCj4gVGhlIGFib3ZlIGlzIGEgVk0gdGhhdCBJ
IGNvbmZpZ3VyZWQgd2l0aCB0aGUgc2FtZSBJUCBhZGRyZXNzICgxMDAuMC4wLjEwMCkgb24gYWxs
IGludGVyZmFjZXMuIERvaW5nIGEgcmV2ZXJzZSBsb29rdXAgdG8gaWRlbnRpZnkgdGhlIHVuaXF1
ZSBpbnRlcmZhY2UgYXNzb2NpYXRlZCB3aXRoIDEwMC4wLjAuMTAwIHdvdWxkIHNpbXBseSBub3Qg
d29yayBoZXJlLiBBbmQgdGhpcyBpcyB3aHkgdGhlIG9wdGlvbiBob3N0X2lmYWNlIGlzIHJlcXVp
cmVkLiBJIHVuZGVyc3RhbmQgdGhhdCB0aGUgYWJvdmUgY29uZmlnIGRvZXMgbm90IHJlcHJlc2Vu
dCBhIHN0YW5kYXJkIGhvc3Qgc3lzdGVtLCBidXQgSSdtIHVzaW5nIHRoaXMgdG8gcHJvdmUgYSBw
b2ludDogIndlIGNhbiBuZXZlciBrbm93IGhvdyBhIHVzZXIgd2lsbCBjb25maWd1cmUgdGhlaXIg
c3lzdGVtIGFuZCB0aGUgYWJvdmUgY29uZmlndXJhdGlvbiBpcyBwZXJmZWN0bHkgZmluZSBieSBM
aW51eCIuCgpJcyB0aGlzIGEgY29tbW9uIHNldHRpbmc/IEknZCBzYXkgdGhhdCB3ZSBzaG91bGQg
cHJvYmFibHkgc2VlIGEgcmVhbApsaWZlIG5lZWQgZm9yIGl0IGJlZm9yZSBhZGRpbmcgYSB1c2Vy
IGludGVyZmFjZSBmb3IgaXQuCgpXaGF0IGlmIHdlIHN0YXJ0IHdpdGggZG9pbmcgYmluZCArIEJJ
TkRUT0RFVklDRSBzb2Nrb3B0IGFuZCBpZiBpbnRlcmZhY2UKcmVzb2x1dGlvbiByZXN1bHRzIGlu
IG11bHRpcGxlIGRldmljZXMgd2UganVzdCBza2lwIHRoZSBCSU5EVE9ERVZJQ0UKc29ja29wdCAo
d2hpY2ggd2lsbCBub3QgaW50cm9kdWNlIGEgcmVncmVzc2lvbikuCgpJZiB0aGlzIHdpbGwgY292
ZXIgOTklIG9mIHRoZSB1c2UtY2FzZXMgd2UgYXJlIGluIGdvb2Qgc2hhcGUgYW5kIHdlCmRpZG4n
dCBpbnRyb2R1Y2UgeWV0IGFub3RoZXIgQUJJIHRoYXQgbWF5IGJlIGp1c3QgY29uZnVzaW5nLi4u
CgpIYXZpbmcgc2FpZCB0aGF0LCBpZiB0aGlzIHNldHRpbmcgaXMgYSByZWFsIHVzZS1jYXNlIHdl
IG5lZWQgdG8gc3VwcG9ydAp0aGVuIHRoZXJlIGlzIG5vIGFsdGVybmF0aXZlIHRvIGhhdmUgdGhl
IHR3byBvcHRpb25zLiBTbyBJJ20gYSBiaXQKb24gdGhlIGZlbmNlIGhlcmUuCgo+IFRoZSBjdXJy
ZW50IFRDUCBpbXBsZW1lbnRhdGlvbiBmb3IgaG9zdF90cmFkZHIgdXNlcyBiaW5kKCktYmVmb3Jl
LWNvbm5lY3QoKS4gVGhpcyBpcyBhIGNvbW1vbiBjb25zdHJ1Y3QgdG8gc2V0IHRoZSBzb3VyY2Ug
SVAgYWRkcmVzcyBvbiB0aGUgc29ja2V0IGJlZm9yZSBjb25uZWN0aW5nLiBUaGlzIGhhcyBubyBl
ZmZlY3Qgb24gaG93IExpbnV4IHdpbGwgc2VsZWN0IHRoZSBpbnRlcmZhY2UgZm9yIHRoZSBjb25u
ZWN0aW9uLiBUaGF0J3MgYmVjYXVzZSBMaW51eCB1c2VzIHRoZSBXZWFrIEVuZCBTeXN0ZW0gbW9k
ZWwgYXMgZGVzY3JpYmVkIGluIFJGQzExMjIgWzJdLiBTZXR0aW5nIHRoZSBzb3VyY2UgYWRkcmVz
cyBvbiBhIGNvbm5lY3Rpb24gaXMgYSBjb21tb24gcmVxdWlyZW1lbnQgdGhhdCBsaW51eC1udm1l
IG5lZWRzIHRvIHN1cHBvcnQuIEluIGZhY3QsIHNwZWNpZnlpbmcgdGhlIFNvdXJjZSBJUCBhZGRy
ZXNzIGlzIGEgbWFuZGF0b3J5IEZlZEdvdiByZXF1aXJlbWVudCAoZS5nLiBjb25uZWN0aW9uIHRv
IGEgUkFESVVTL1RBQ0FDUysgc2VydmVyKS4gQ29uc2lkZXIgdGhlIGZvbGxvd2luZyBjb25maWd1
cmF0aW9uLgo+IAo+ICQgaXAgYWRkciBsaXN0IGRldiBlbnAwczgKPiAzOiBlbnAwczg6IDxCUk9B
RENBU1QsTVVMVElDQVNULFVQLExPV0VSX1VQPiBtdHUgMTUwMCBxZGlzYyBmcV9jb2RlbCBzdGF0
ZSBVUCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMAo+ICAgICAgbGluay9ldGhlciAwODowMDoyNzo0
Zjo5NTo1YyBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYKPiAgICAgIGluZXQgMTkyLjE2OC41Ni4xMDEv
MjQgYnJkIDE5Mi4xNjguNTYuMjU1IHNjb3BlIGdsb2JhbCBkeW5hbWljIG5vcHJlZml4cm91dGUg
ZW5wMHM4Cj4gICAgICAgICB2YWxpZF9sZnQgNDI2c2VjIHByZWZlcnJlZF9sZnQgNDI2c2VjCj4g
ICAgICBpbmV0IDE5Mi4xNjguNTYuMTAyLzI0IHNjb3BlIGdsb2JhbCBzZWNvbmRhcnkgZW5wMHM4
Cj4gICAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXIKPiAgICAg
IGluZXQgMTkyLjE2OC41Ni4xMDMvMjQgc2NvcGUgZ2xvYmFsIHNlY29uZGFyeSBlbnAwczgKPiAg
ICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcgo+ICAgICAgaW5l
dCAxOTIuMTY4LjU2LjEwNC8yNCBzY29wZSBnbG9iYWwgc2Vjb25kYXJ5IGVucDBzOAo+ICAgICAg
ICAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyCj4gCj4gSGVyZSB3ZSBj
YW4gc2VlIHRoYXQgc2V2ZXJhbCBhZGRyZXNzZXMgYXJlIGFzc29jaWF0ZWQgd2l0aCBpbnRlcmZh
Y2UgZW5wMHM4LiBCeSBkZWZhdWx0LCBMaW51eCB3aWxsIHNlbGVjdCB0aGUgZGVmYXVsdCBJUCBh
ZGRyZXNzLCAxOTIuMTY4LjU2LjEwMSwgYXMgdGhlIHNvdXJjZSBhZGRyZXNzIHdoZW4gY29ubmVj
dGluZyBvdmVyIGludGVyZmFjZSBlbnAwczguIFNvbWUgdXNlcnMsIGhvd2V2ZXIsIHdhbnQgdGhl
IGFiaWxpdHkgdG8gc3BlY2lmeSBhIGRpZmZlcmVudCBhZGRyZXNzIChlLmcuLCAxOTIuMTY4LjU2
LjEwMykgdG8gYmUgdXNlZCBhcyB0aGUgc291cmNlIGFkZHJlc3MuIFRoZSBvcHRpb24gaG9zdF90
cmFkZHIgY2FuIGJlIHVzZWQgYXMtaXMgdG8gcGVyZm9ybSB0aGlzIGZ1bmN0aW9uIChJIHRlc3Rl
ZCBpdCkuCj4gCgpJIG1lYW50IHRoYXQgd2UgZG8gYm90aCBiaW5kIGFuZCBzb2Nrb3B0IGZvciBo
b3N0X3RyYWRkci4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
