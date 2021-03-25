Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B34DC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 02:10:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D291619B1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 02:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D291619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1KSNd+Cb2IHTWcw6OKW5zwcGBZuJofs6XyLIKO+K/6Q=; b=VV75hgZothJeHBZmWd3TdUmLh
	qOs6xpJYkllvROBU2m6xKC6s+fnGr15PqTWNq3OZT/IbemdVry3DvGiwK6S2Oy8mrPdw9XvSu5FUO
	QpQHHo/TC5fSR/pIdfsblFeXTPWSVLd1t2V9hpgg3hLf87Lli+LH82UI8tETTw7s2k3gRbyhUgdKB
	gR6+PxWd6amScMnxd9+ZfbKI88dNrJceB8Acu66VpPpMQpTbZASBs2XDc9pYCLQhYmQEgScV387d9
	HSQkVg+RTmUbQq2d5ggVR1Jc2Gw0IKDaA2Qlgh3NKqBJt4aCTMdFSRV3p6Cf4ks2320qWbZhOcOj3
	sFWJmqmNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPFRl-000TqS-62; Thu, 25 Mar 2021 02:10:05 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPFRd-000Tpj-U3
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 02:10:00 +0000
Received: by mail-pg1-x531.google.com with SMTP id m7so260034pgj.8
 for <linux-nvme@lists.infradead.org>; Wed, 24 Mar 2021 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=GnPkrUWVHgQAkE7X9Q+gS1Rm0hw8IZfxa51KQLQaH2w=;
 b=APFhGsnvbabBnyPJKGOX/84vrQW9EE5xS06+iv5qV4t5nvQXqDViUjmAOjrVJiQj2J
 Cwk+AkMAfN0PR8vAIY4ARrwsy01cSc8001Z/eiEnv4CMGx1Sle1hJjyRaI5MwvmcdUV+
 jwb7leeD0C8/Dncxzlsp3Qip4Xy8WCg9HhV5axzjsXIFNNB4xxz0AYT4sI6EUrK95bKy
 FUnkX3OT5sJJBF0Uaz23lAJeBGJ1hD5XM+icNGNHkdOR8RHuOtovNLF3Veas4WXp2QNv
 HMQTB85iKg+HFOq4gS2TQCnMWMAG9ebH2mUWblX3DMNFJdLP/T/HOxkoReTfwUpKQVH8
 /97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=GnPkrUWVHgQAkE7X9Q+gS1Rm0hw8IZfxa51KQLQaH2w=;
 b=gzgOsTho735okLkPaJ5L/QXttm2BO8GyP29vEFDJ5vAT9kU0kenzXJG8Ws4OmpjrpW
 jWaY1zK8tAqQwAYs1O0BaCiSGPXkUcYxc7sD5nnBmBOjD6BpjF0otg9kO2z7o5SSpVu6
 fwycYf8pl3wpGkPkAtyHjoQ6lnw2guOLf1fsch0du985q12YKCoPQJI8qRN8jJ6UoM66
 mZ+WKfSsqTcqZlATO5bDD+QKYKNJr6tLBv9kX7fTZ/mhRzEXd0C8A03k1by+yYQDg2rF
 HqNjmTIADIL85FGiXbtIBNPFyitI1yYxRrWxZgXaVccm+VD5lpYGHgCu3hXjK1/LFoGt
 vXPg==
X-Gm-Message-State: AOAM533Yf8xThejFA2xzxpcYLc97cI4dIaMCa/A1W2D1DbSSWGR3GdO+
 2bX1US3kZikC8WxtADJT50A=
X-Google-Smtp-Source: ABdhPJxU2KB058XE51CYUcSMipnPvf0Qk5VzTZS8EsUwLZjX4qc3Y6n8xujrzD2lZFufpuw3Huu37w==
X-Received: by 2002:a17:902:d4cc:b029:e4:9cd9:f189 with SMTP id
 o12-20020a170902d4ccb02900e49cd9f189mr6587626plg.53.1616638194758; 
 Wed, 24 Mar 2021 19:09:54 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id i8sm3706537pjl.32.2021.03.24.19.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Mar 2021 19:09:54 -0700 (PDT)
Date: Thu, 25 Mar 2021 11:09:51 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325020951.GA2105@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFswq8pgzg9y00GO@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_020958_076189_F2FB3C87 
X-CRM114-Status: GOOD (  35.64  )
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

T24gMjEtMDMtMjQgMTI6Mjk6MzIsIE5pa2xhcyBDYXNzZWwgd3JvdGU6Cj4gT24gTW9uLCBNYXIg
MDEsIDIwMjEgYXQgMDg6MjQ6NTFQTSArMDEwMCwgamF2aWVyQGphdmlnb24uY29tIHdyb3RlOgo+
ID4gRnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4gPiAK
PiA+IENyZWF0ZSBhIGNoYXIgZGV2aWNlIHBlciBOVk1lIG5hbWVzcGFjZS4gVGhpcyBjaGFyIGRl
dmljZSBpcyBhbHdheXMKPiA+IGluaXRpYWxpemVkLCBpbmRlcGVuZGVudGx5IG9mIHdoZXRoZXIg
dGhlIGZlYXR1cmVzIGltcGxlbWVudGVkIGJ5IHRoZQo+ID4gZGV2aWNlIGFyZSBzdXBwb3J0ZWQg
YnkgdGhlIGtlcm5lbC4gVXNlci1zcGFjZSBjYW4gdGhlcmVmb3JlIGFsd2F5cwo+ID4gaXNzdWUg
SU9DVExzIHRvIHRoZSBOVk1lIGRyaXZlciB1c2luZyB0aGUgY2hhciBkZXZpY2UuCj4gPiAKPiA+
IFRoZSBjaGFyIGRldmljZSBpcyBwcmVzZW50ZWQgYXMgL2Rldi9udm1lLWdlbmVyaWMtWGNZblou
IFRoaXMgbmFtaW5nCj4gPiBzY2hlbWUgZm9sbG93cyB0aGUgY29udmVudGlvbiBvZiB0aGUgaGlk
ZGVuIGRldmljZSAobnZtZVhjWW5aKS4gU3VwcG9ydAo+ID4gZm9yIG11bHRpcGF0aCB3aWxsIGZv
bGxvdy4KPiA+IAo+IAo+IEhlbGxvIGFsbCwKPiAKPiBMb29raW5nIGF0IHRoZSBkaXNjdXNzaW9u
IHRoYXQgbGVkIHVwIHRvIHRoZSBjdXJyZW50IGRlc2lnbjoKPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1ibG9jay8yMDIwMTEwMjE4NTg1MS5HQTIxMzQ5QGxzdC5kZS8KPiAKPiBLZWl0
aCBpbml0aWFsbHkgc3VnZ2VzdGVkOgo+IAo+IGEpIFNldCB1cCB0aGUgZXhpc3RpbmcgY29udHJv
bGxlciBjaGFyYWN0ZXIgZGV2aWNlIHdpdGggYSBnZW5lcmljCj4gICAgZGlzay1sZXNzIHJlcXVl
c3RfcXVldWUgdG8gdGhlIElPIHF1ZXVlcyBhY2NlcHRpbmcgSU8gY29tbWFuZHMgdG8KPiAgICBh
cmJpdHJhcnkgTlNJRHMuCj4gCj4gSG93ZXZlciBDaHJpc3RvcGggcmVwbGllZDoKPiAKPiBUaGUg
cHJvYmxlbSB3aXRoIGEpIGlzIHRoYXQgaXQgY2FuJ3QgYmUgdXNlZCB0byBnaXZlIHVzZXJzIG9y
IGdyb3Vwcwo+IGFjY2VzcyB0byBqdXN0IG9uZSBuYW1lc3BhY2VzLCBzbyBpdCBjYXVzZXMgYSBy
ZWFsIGFjY2VzcyBjb250cm9sCj4gbmlnaHRtYXJlLgo+IAo+IGMpIEVhY2ggbmFtZXNwYWNlIGdl
dHMgaXRzIG93biBjaGFyYWN0ZXIgZGV2aWNlLCBwZXJpb2QuCgpUaGFua3MgZm9yIHN1bW1hcml6
aW5nIHRoaXMgdXAhCgo+IEhvd2V2ZXIsIHRlc3RpbmcgdGhpcyBwYXRjaCBzZXJpZXMgb3V0Ogo+
IAo+IGNydy0tLS0tLS0gMSByb290IHJvb3QgMjQ5LCAgIDAgTWFyIDI0IDExOjMyIC9kZXYvbnZt
ZS1nZW5lcmljLTBjMG4xCj4gY3J3LS0tLS0tLSAxIHJvb3Qgcm9vdCAyNDksICAgMSBNYXIgMjQg
MTE6MzIgL2Rldi9udm1lLWdlbmVyaWMtMGMwbjIKPiBjcnctLS0tLS0tIDEgcm9vdCByb290IDI1
MCwgICAwIE1hciAyNCAxMTozMiAvZGV2L252bWUwCj4gYnJ3LXJ3LS0tLSAxIHJvb3QgZGlzayAy
NTksICAgMSBNYXIgMjQgMTE6MzIgL2Rldi9udm1lMG4yCj4gCj4gTlNJRDEgaGFzIGJlZW4gcmVq
ZWN0ZWQgKGJlY2F1c2Ugb2YgWk5TIFpPQywgd2hpY2gga2VybmVsIGRvZXMgbm90IHN1cHBvcnQp
Lgo+IAo+IEhvd2V2ZXIsIGlmIEkgdXNlIHRoZSBuZXcgY2hhciBkZXZpY2UgZm9yIE5TSUQxLCBi
dXQgc3BlY2lmeSBOU0lEMiB0byBudm1lLWNsaToKPiAKPiBzdWRvIG52bWUgd3JpdGUtemVyb2Vz
IC1zIDAgLWMgMCAtLW5hbWVzcGFjZS1pZD0yIC9kZXYvbnZtZS1nZW5lcmljLTBjMG4xCj4gCj4g
SSB3YXMgc3RpbGwgYWxsb3dlZCB0byB3cml0ZSB0byBOU0lEMjoKPiAKPiBzdWRvIG52bWUgem5z
IHJlcG9ydC16b25lcyAtZCAxIC9kZXYvbnZtZTBuMgo+IFNMQkE6IDB4MCAgICAgICAgV1A6IDB4
MSAgICAgICAgQ2FwOiAweDNlMDAwICAgIFN0YXRlOiBJTVBfT1BFTkVEICAgVHlwZTogU0VRV1JJ
VEVfUkVRICAgQXR0cnM6IDB4MAo+IAo+IFNob3VsZCB0aGlzIHJlYWxseSBiZSBhbGxvd2VkPwoK
SSB0aGluayB0aGlzIHNob3VsZCBub3QgYmUgYWxsb3dlZCBhdCBhbGwuICBUaGFua3MgZm9yIHRo
ZSB0ZXN0aW5nIQoKPiAKPiBJIHdhcyB1bmRlciB0aGUgaW1wcmVzc2lvbiB0aGF0IENocmlzdG9w
aCdzIGFyZ3VtZW50IGZvciBpbXBsZW1lbnRpbmcgcGVyCj4gbmFtZXNwYWNlIGNoYXIgZGV2aWNl
cywgd2FzIHRoYXQgeW91IHNob3VsZCBiZSBhYmxlIHRvIGRvIGFjY2VzcyBjb250cm9sLgo+IERv
ZXNuJ3QgdGhhdCBtZWFuIHRoYXQgZm9yIHRoZSBuZXcgY2hhciBkZXZpY2VzLCB3ZSBuZWVkIHRv
IHJlamVjdCBpb2N0bHMKPiB0aGF0IHNwZWNpZnkgYSBudm1lX3Bhc3N0aHJ1X2NtZC5uc2lkICE9
IHRoZSBOU0lEIHRoYXQgdGhlIGNoYXIgZGV2aWNlCj4gcmVwcmVzZW50cz8KPiAKPiAKPiBBbHRo
b3VnaCwgdGhpcyBpcyBub3QgcmVhbGx5IHNvbWV0aGluZyBuZXcsIGFzIHdlIGFscmVhZHkgaGF2
ZSB0aGUgc2FtZQo+IGJlaGF2aW9yIHdoZW4gaXQgY29tZXMgaW9jdGxzIGFuZCB0aGUgYmxvY2sg
ZGV2aWNlcy4gUGVyaGFwcyB3ZSB3YW50IHRvCj4gYWRkIHRoZSBzYW1lIHZlcmlmaWNhdGlvbiB0
aGVyZT8KCkkgdGhpbmsgdGhlcmUgc2hvdWxkIGJlIHZlcmlmaWNhdGlvbnMuCgo+IAo+IFJlZ2Fy
ZGxlc3MgaWYgd2Ugd2FudCB0byBhZGQgYSB2ZXJpZmljYXRpb24gZm9yIGJsb2NrIGRldmljZXMg
b3Igbm90LAo+IGl0IGp1c3Qgc2VlbWVkIHRvIG1lIHRoYXQgdGhlIHdob2xlIGFyZ3VtZW50IGZv
ciBpbnRyb2R1Y2luZyBuZXcgY2hhcgo+IGRldmljZXMgd2FzIHRvIGFsbG93IGFjY2VzcyBjb250
cm9sIHBlciBuYW1lc3BhY2UsIHdoaWNoIGRvZXNuJ3Qgc2VlbQo+IHRvIGhhdmUgYmVlbiB0YWtl
biBpbnRvIGFjY291bnQsIGJ1dCBwZXJoYXBzIEknbSBtaXNzaW5nIHNvbWV0aGluZy4KCkFueSBv
dGhlciBwb2ludHMgdGhhdCB5b3UgdGhpbmsgaXQncyBub3QgYmVlbiB0YWtlbiBhY2NvdW50PyAg
SSB0aGluayBpdApzaG91bGQgbWFwIHRvIHByZXZpb3VzIGJsa2RldiBvcGVyYXRpb25zLCBidXQg
d2l0aCBzb21lIHZlcmZpY2F0aW9ucwp0aGVyZS4gIEl0IHdvdWxkIGJlIGdyZWF0IGlmIHlvdSBj
YW4gc2hhcmUgYW55IG90aGVyIHBvaW50cyBzdXBwb3NlZCB0bwpiZSBzdXBwb3J0ZWQgaGVyZSA6
KQoKPiBLaW5kIHJlZ2FyZHMsCj4gTmlrbGFzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==
