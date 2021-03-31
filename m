Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6594C433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:36:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624A1619C2
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 06:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624A1619C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2YuPAPmUZvRLTHDElgLhtGeMiOlTZyO7E1GesXEOvho=; b=B5C25bcwDxRyLed1mP/Wa/vyZ
	sIeqcTagGs/rh2H55pfbrnI12Wr5kkXCf72qqynNArCqH7e+8GSBdqhqJ/c0oUYjBaZaQFuO4vLMy
	TliFXlJvptp/oyV2OEIEXrCdBzXUZkxAESgmm0bGhYei+kzInLazQPCD/5rjEby6Dbo+T3Czvw85V
	8+y7ZDLp8gnC1O0VNWfGl+EiYpHIxMIyH/v8gfWnULBFumrjcC2J9/XMM7ZyALmg6XYCyqK0poSC8
	ox8B6+3zHUkCTY6bEujls1HDhgzSpnvhT1JlqNC6QOb6tcbbC+kPV/p7Ew1+8WkWgyGN6KW6sNxn1
	ZV940UnnA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRUSx-005ewj-K0; Wed, 31 Mar 2021 06:36:35 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRUSm-005evL-G9
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 06:36:27 +0000
Received: by mail-pl1-x62c.google.com with SMTP id v23so7389288ple.9
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=s30vVxva7MwH+KhYq9Db4PVfzF6oJBGoCOiZ5S0Z7zs=;
 b=gzkbui7rjm5fRabTNJ/6lHL87dRuOG1YlXIn5N6LRTW+VkQkQ1ZK1bD6uSXbjpT8yH
 ozLW+gIpH8sI2leNL0pcEu90dBZ00/yE4uQ+LMAuXsKHPeEnzvamGzIxzvnauVPBrwgW
 +Fai5v/LloeumyPRympC4gRHgvndY9RpXfWwWQEKjIPKM9AjKIdjQTiHfgXMGb8aQoRK
 /gRUWBAn+TWu+ZxPZJobJnV4shb+9WeIYzxhQ0p5JwbcSlIofalTSylYdyIc37Jv/C6Y
 uFwD3tZ1S2OeDFPpAU+hglColVPA1wvDztAfCBpCCbG0hzEYArxaYoa9Q325qnUoj9Ig
 6fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=s30vVxva7MwH+KhYq9Db4PVfzF6oJBGoCOiZ5S0Z7zs=;
 b=ET3rGgOSMMd89NC1hQ4GHqKNQgtIWWjm6sK8m1D8RbzqPpV04hcwg8UvFRoerddqDD
 uuJ918/g6NVuMVMuDnCSmLZnTg9/HTJNVQ0R1HvaqjiNMm2gDSJuWbJ2jv9avFeWjH0R
 lxLVhi9ZvYTN6IIwJ8tYHkpZB7eAG4haV4L1ANowwaH7oz6YAGSPNB68ALBtqs8E86iI
 K7tQqoDkyjRGRlbMvQ66JkiAtaO8L3cDlByAYEMGDLsiok5mXOdqCojweTJkeFQkj2QR
 1NPJXzXSzwxXD6fxHKwsBSteB4w+dgnsd5Y8LglawUU6VGAlakasExizwsqLSdhfLYo8
 YnuA==
X-Gm-Message-State: AOAM532cps8avTc6Dobw1e33qzixe2x9MAM3owctt466KIoBGvi/1JcP
 MvegBRbriAGsWfVk28GFDOwOb7M6ozs=
X-Google-Smtp-Source: ABdhPJxr7NP97MJWnxXtAC3wn0m19tCgBSFhAVvEhtM3AD4CMWo/BYcZsmcrnq2GPNtLmUbS4tvT8w==
X-Received: by 2002:a17:90a:ba8b:: with SMTP id
 t11mr2049628pjr.177.1617172582712; 
 Tue, 30 Mar 2021 23:36:22 -0700 (PDT)
Received: from houpudeMacBook-Pro.local ([240e:b1:e401:3::e])
 by smtp.gmail.com with ESMTPSA id n5sm1007647pfq.44.2021.03.30.23.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 23:36:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: remove unneeded code from nvmet_alloc_ctrl()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20210330115907.15432-1-houpu.main@gmail.com>
 <20210330115907.15432-3-houpu.main@gmail.com>
 <BYAPR04MB4965E59C632B8A45D015B4EC867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <0eb32563-a2f7-3b20-64b5-bb17c6981529@gmail.com>
 <5F1FE896-F02E-401B-981B-D7D8C0E5CBC7@wdc.com>
From: Hou Pu <houpu.main@gmail.com>
Message-ID: <6a25ad2c-8b07-50dd-e40b-246696cf0bd6@gmail.com>
Date: Wed, 31 Mar 2021 14:36:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5F1FE896-F02E-401B-981B-D7D8C0E5CBC7@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_073625_009500_88845AE5 
X-CRM114-Status: GOOD (  16.96  )
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

Ck9uIDIwMjEvMy8zMSAyOjIyIFBNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6Cj4KPiDvu79P
biAzLzMwLzIxLCA3OjE4IFBNLCAiSG91IFB1IiA8aG91cHUubWFpbkBnbWFpbC5jb20+IHdyb3Rl
Ogo+Cj4KPiAgICAgIE9uIDIwMjEvMy8zMSA3OjMwIOS4iuWNiCwgQ2hhaXRhbnlhIEt1bGthcm5p
IHdyb3RlOgo+ICAgICAgPiBPbiAzLzMwLzIxIDA0OjU5LCBIb3UgUHUgd3JvdGU6Cj4gICAgICA+
PiBTaWduZWQtb2ZmLWJ5OiBIb3UgUHUgPGhvdXB1Lm1haW5AZ21haWwuY29tPgo+ICAgICAgPj4g
LS0tCj4gICAgICA+PiAgIGRyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jIHwgMSAtCj4gICAgICA+
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gICAgICA+IE9uIHdoYXQgYnJhbmNo
IHlvdSBoYXZlIGdlbmVyYXRlZCB0aGlzIHBhdGNoID8KPiAgICAgID4KPiAgICAgID4KPiAgICAg
IFRoZSBwYXRjaCBpcyBiYXNlZCBvbiB2NS4xMi1yYzQuCj4KPiAgICAgIChodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJl
ZS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYz9oPXY1LjEyLXJjNCNuMTMyOCkKPgo+Cj4gICAg
ICBUaGFua3MsCj4KPiAgICAgIEhvdQo+Cj4KPiBJIHRoaW5rIEkndmUgZml4ZWQgdGhpcyBpbiA1
LjEzLCBwbGVhc2UgY2hlY2ssIGlmIHNvIHdlIG1heSBuZWVkIHRvIGRyb3AgdGhpcyBwYXRjaC4K
ClllcywganVzdCBub3RpY2UgdGhhdCBmcm9tIG52bWUuZ2l0IHRyZWUuIFRoYW5rcy4KCkkgd2ls
bCBkcm9wIHRoaXMgaW4gdjIuCgoKVGhhbmtzLAoKSG91CgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
