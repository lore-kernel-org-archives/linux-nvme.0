Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3A4C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:41:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F2320782
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2SlbZ7ok";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EODff5MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F2320782
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ON+/pvqZ7I29Drve98+gPH4jpX4FvQKSoKg/22igO5k=; b=2SlbZ7okByrpnOiEOjBPkXFRl
	g859fI+eR4iJ59m9/UJS11FNlXgRzZbpllPu3P/xt5PrFDhcHmE7D90DuKGq9ewHYayCbxZsGmxeV
	GsG12phKOMRpV7RYF0ZJNkdRixdmemdLte2RUfFf4AhkTp2VA5CNbkZFCqxCiHAi6jik5z3O/mVD6
	hDjMGRUB4cVVTFmZPI55Z/fKATi4FeLZ/M8O5JRFjZiUPnmY9mv+ypTcatbQCnWu3dAOdh0uqWd5O
	SA3jnbY1SufqOIXPu9ec72SNw47eraJ1b5+9N2mG+TM+QvaqUZkebZsgJWCcvE7g0inoU2NzmLGCR
	vYx0wJDMA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAb4a-0001Fk-NS; Tue, 25 Aug 2020 15:41:20 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAb4Y-0001FI-NP
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 15:41:19 +0000
Received: by mail-pg1-x542.google.com with SMTP id p37so7095182pgl.3
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=tRbOEHOhIAfVDHryKeqmvmxTGz33tdrjEJzrTP7Y0nM=;
 b=EODff5MGN1wgR0ZinrOKD3jW4Tx4knRy3k5kk3FXLZH85Kj994Ey+rO1YfQaDDknzI
 gSdM5OTpygyI4RmcTDlLoccYvFYjIRF4yyVfHdy3mV36sYYtSyJrIat263S+zAjT+uSw
 EkhJw0H+/hC92NveHdHB3F7UK9n0D8a8uQ/tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tRbOEHOhIAfVDHryKeqmvmxTGz33tdrjEJzrTP7Y0nM=;
 b=MWQyQNCbZFVqPA1XPNfC33vijQn5OG/ypiqe7NUlGdhGy8DoeYq1MVk9DX+E/99AwI
 wC0PEpnd7FV4hP2woF3MePp8YG3nXPxiNuoEf5jqgQOjI0SlYSCD/Mky5OM+xMVVLm1t
 JPcyL+mRg/6HcE2ra1a3IaFivL41JNn787EuWHgRFYWV/9gPkr/9Zw+iXvNGXpwKD+TD
 7N8gCgzebdlmcuf0IespmGOKm6cdlXLNLRmQR6CUQe03r6O2ZfFnLqZN8l7fH4LcLjxH
 xvSUJExtCTN7Cm0WOFBt9Sk8cXkVDi6Zkg7GgeAWeE8RAkand91+fZKaE5MO2ehEVWud
 wZDA==
X-Gm-Message-State: AOAM532i9iFbLwRqfNavTytycZ2K3PkZNk9NpU3ioRgN7J/hGAEyoIiM
 vSxaISrDryw5KYVieRFGXi3QmfRa3lf1JM6v6MVANFqTPW+v5tUhUdlStPqPdf2J4ykpyYSaswH
 K13FlsktbSyP3GK9FtBwK4iK/X439L/t+NZDULse0NeEMRu52iQe50t5FXwsc7Ve8q6lGan+NO9
 rBt1uqiQKQ
X-Google-Smtp-Source: ABdhPJwHnpC+UVGhZCB2qVPmCD89dgu2AyluwoCWIBNdygmoeCELddNQq1RhpfcDQ+6xRoMeDsb1Nw==
X-Received: by 2002:a63:9d02:: with SMTP id i2mr6981214pgd.378.1598370076294; 
 Tue, 25 Aug 2020 08:41:16 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id lb1sm2844040pjb.26.2020.08.25.08.41.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 08:41:15 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
Date: Tue, 25 Aug 2020 08:41:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_114118_776635_F3ABCFDD 
X-CRM114-Status: GOOD (  15.51  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzI1LzIwMjAgODowMCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4gU28gd2Ug
ZWl0aGVyIGtlZXAgdGhpcyBleGNlcHRpb24gZm9yIGFkbWluIGNvbW1hbmRzLCBvciB3ZSBhbHNv
IGxldAo+Pj4gdGhlbSB0aHJvdWdoIGFzIGl0IHNlZW1zIHRvIGJlIHNhZmUgd2l0aCB0aGUgY3Vy
cmVudCBjb2RlIChmcm9tIHRoZQo+Pj4gcmVzZXQgZm9yd2FyZC1wcm9ncmVzcyBwZXJzcGVjdGl2
ZSkuCj4+Pgo+Pj4gSSB2b3RlIHRvIHJlbW92ZSB0aGlzIGV4Y2VwdGlvbiBhbHRvZ2V0aGVyLi4u
Cj4+Cj4+IFRvIG1lIHRoZSByaWdodCBhbnN3ZXIgd291bGQgYmUgdG8gcmVqZWN0IHVzZXIgY29t
bWFuZHMgb24gdGhlIGFkbWluCj4+IG9yIEkvTyBxdWV1ZSBmb3IgdGhlIG5vdCBsaXZlIGNvbnRy
b2xsZXIgYXMgdGhlIGNhbGxlcnMgbmVlZCB0byBoYW5kbGUKPj4gaXQuwqAgVGhhdCBzZWVtcyB0
byBtYWtlIG1vcmUgc2Vuc2UgdG8gbWUgdGhhbiBhIHNwZWNpYWwgYWRtaW4gcXVldWUKPj4gZXhj
ZXB0aW9uLgo+Cj4gU28geW91IHNheSB0aGF0IHdlIHNob3VsZCBuZXZlciByZXR1cm4gQkxLX1NU
U19SRVNPVVJDRSBidXQgcmF0aGVyIGZhaWwKPiBhbGwgcmVxdWVzdHM/IHJlZ2FyZGxlc3MgZm9y
IG11bHRpcGF0aCBvciBub3Q/CgpIb3cgYWJvdXQgd2Uga2VlcCB0aGUgZXhjZXB0aW9uIGZvciBu
b3cuIEFzIEkgbWVudGlvbmVkIGVhcmxpZXIsIEkgaGF2ZSAKYW4gaW9jdGwgcmV0cnkgcGF0Y2gg
Y29taW5nIGZvciBudm1lLWNsaSBhbmQgaWYgd2UgYWdyZWUgd2l0aCB3aGF0IGl0IApkb2VzIHRo
ZW4gd2UgY2FuIHB1dCBpbiB0aGUgcmVqZWN0IGFuZCByZW1vdmUgdGhlIGV4Y2VwdGlvbi4KCi0t
IGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
