Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 05:17:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFA1238E7
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 05:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFA1238E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FH2LOWnNocAsL/Ir+thTgD+D7kJxYMRCi0VKW2HQxnk=; b=z2QEMRfa3HtyZ5/KYgbt+sccq
	GQQPCqj7IC+P1I9T/oUkCW7O87+sFrXYM/St4ZOsi45Xqm/aQj1SpZJC1twszdi7G1bVpGJZuyKm4
	xB4GUUNIpzYQVW3i6koRhIXAS+t6qWTHz/SEopeUdBTeCt/AGhIkbymkpK2buoVNpX9YYITz6HDV/
	UiE5Tvk0e1IFXD9xZU+reJO3GakWan8VcBoJNXAzTXuUyCQemnArmIivJ4OEkH4d29xV8QVJkPFXA
	0uBPjVatwjoluz5c4dgyxm7u0YLFb+fsUB6WqKevrDOPB1mc/oELgv3w1L8vUa0pfpO3sovRh6aoK
	/gHJedUxw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzv0q-0003Vy-Ek; Thu, 14 Jan 2021 05:17:36 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzv0l-0003VB-Sc
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 05:17:32 +0000
Received: by mail-pf1-x42a.google.com with SMTP id c79so2692769pfc.2
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oCahD8foTVoddxYHsMYM6DUY8gEUtNSocwAU/pMxRNk=;
 b=ZOeUZm0TD3YyWm4LhewhwjQFxVnPSXbygDaAWHJ3TPVTHS+J7MaGrTmK/FUY2trwCG
 fF8rrxCErQQrr3WqE2ClGAvCPAKwZqdB0IUE9Y4DdZ7cwntwhLWycL3J1uMDTDDOahS6
 HCxUtIJu7SxBppTbt0XrV6k7FhAofK7EblBeTe0Uc9nI75SD8JuG4aNieP6h83ZwysAU
 JqxYewSU5fOMtkjJeJifNxCpYJHPehNFs4UWbyKWuompazLaHwV1Xe8vTRxffxCuZN6a
 3aE749DB0A/nOk6/5glbIGnnbCV8oGqMTGeBxKKXJ9/3C6WQdQloMCVSZzJtNw2OtUMH
 D2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oCahD8foTVoddxYHsMYM6DUY8gEUtNSocwAU/pMxRNk=;
 b=oTliI3gmcxjxbK13P0RDIiVNaMtnK+NhXaiexE84ysm6IjzQwkpSR4s8veplB8KuQf
 0GhzuoAG+hNUZunpnts0lP7XHMAQkFJdgqU9sdWNWJBOQ+XlMhLpbvPTSUPtFvWnod+U
 rwuRsfyB9iDd4CKeBcFAT+P4Kbu1HpeB8RFBOSefpiHfPaZJOumy1tBXwGF2kYqJFJav
 gvxl1gCcSTu5wBfZBWJRt0oYrM4Bcm3gNRfmDtK5i0ZgkdazVxhEiI9/XKFpdjqaVBnk
 Ka6KHJ3QOu+1SMbYkkQt1x2gWawNQNaKbqTPArLiPGc6Mg4oUKN/Jx5PWxRgUcfPYShb
 xQbA==
X-Gm-Message-State: AOAM5329brIA7oIj8yleZMhuoTPdBWQbM98PavxTiG3ToJLD/FPaLm2k
 XW8DyBZbCcNlrJL8LEhPDSrWQHa3zj4Nylb1lp8=
X-Google-Smtp-Source: ABdhPJzBd6Yn13We5RDVOJOixuf16fxATi7D3gqZDlFC/ZohJYIfooO0M+SlL0eR1HNbkUwSURVk716vAvwyibyv8l4=
X-Received: by 2002:a62:1b14:0:b029:19d:fa85:9f73 with SMTP id
 b20-20020a621b140000b029019dfa859f73mr5608155pfb.25.1610601448212; Wed, 13
 Jan 2021 21:17:28 -0800 (PST)
MIME-Version: 1.0
References: <20210113160621.98615-1-fengli@smartx.com>
 <SN4PR0401MB35985C08E5FFCDF0F5817A9D9BA90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
In-Reply-To: <87698545-de26-c0ca-01e9-4dc2ddcacc80@grimberg.me>
From: Feng Li <lifeng1519@gmail.com>
Date: Thu, 14 Jan 2021 13:17:03 +0800
Message-ID: <CAEK8JBC8SzabKnG_K-axf-7Fbvc6Ng57gh=5CJjfd8U1uqjvRQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_001731_947834_6B42031A 
X-CRM114-Status: GOOD (  19.32  )
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
Cc: "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Li Feng <fengli@smartx.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4g5LqOMjAyMeW5tDHmnIgxNOaXpeWRqOWb
myDkuIrljYg2OjEz5YaZ6YGT77yaCj4KPgo+ID4+IFRoZSBudm1lIHNwZWMoMS40YSwgZmlndXJl
IDI0OCkgc2F5czoKPiA+PiAiQSB2YWx1ZSBzbWFsbGVyIHRoYW4gOSAoaS5lLiwgNTEyIGJ5dGVz
KSBpcyBub3Qgc3VwcG9ydGVkLiIKPiA+Pgo+ID4+IFNpZ25lZC1vZmYtYnk6IExpIEZlbmcgPGZl
bmdsaUBzbWFydHguY29tPgo+ID4+IC0tLQo+ID4+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IHwgNiArKysrKysKPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPiA+Pgo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMKPiA+PiBpbmRleCBmMzIwMjczZmM2NzIuLjFmMDJlNmU0OWEwNSAxMDA2NDQK
PiA+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiA+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMKPiA+PiBAQCAtMjE2MSw2ICsyMTYxLDEyIEBAIHN0YXRpYyBpbnQgbnZt
ZV91cGRhdGVfbnNfaW5mbyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCBudm1lX2lkX25zICpp
ZCkKPiA+Pgo+ID4+ICAgICAgYmxrX21xX2ZyZWV6ZV9xdWV1ZShucy0+ZGlzay0+cXVldWUpOwo+
ID4+ICAgICAgbnMtPmxiYV9zaGlmdCA9IGlkLT5sYmFmW2xiYWZdLmRzOwo+ID4+ICsgICAgaWYg
KG5zLT5sYmFfc2hpZnQgPCA5KSB7Cj4gPj4gKyAgICAgICAgICAgIHByX3dhcm4oIiVzOiBiYWQg
bGJhX3NoaWZ0KCVkKVxuIiwgbnMtPmRpc2stPmRpc2tfbmFtZSwgbnMtPmxiYV9zaGlmdCk7Cj4g
Pj4gKyAgICAgICAgICAgIHJldCA9IC0xOwo+Cj4gTWVhbmluZ2Z1bCBlcnJubyB3b3VsZCBiZSB1
c2VmdWwuIEFsc28gYmV0dGVyIHRvIHVzZSBkZXZfd2Fybgo+Cj4gPj4gKyAgICAgICAgICAgIGdv
dG8gb3V0X3VuZnJlZXplOwo+ID4+ICsgICAgfQo+ID4+ICsKPiA+PiAgICAgIG52bWVfc2V0X3F1
ZXVlX2xpbWl0cyhucy0+Y3RybCwgbnMtPnF1ZXVlKTsKPiA+Pgo+ID4+ICAgICAgaWYgKG5zLT5o
ZWFkLT5pZHMuY3NpID09IE5WTUVfQ1NJX1pOUykgewo+ID4+Cj4gPgo+ID4KPiA+IEJ1dCB0aGlz
IG9ubHkgY2F0Y2hlcyBhIHBoeXNpY2FsIGJsb2NrIHNpemUgPCA1MTIgZm9yIE5WTWUsIG5vdCBh
bnkgb3RoZXIgYmxvY2sgZGV2aWNlLgo+ID4KPiA+IFBsZWFzZSBmaXggaXQgZm9yIHRoZSBnZW5l
cmFsIGNhc2UgaW4gYmxrX3F1ZXVlX3BoeXNpY2FsX2Jsb2NrX3NpemUoKS4KPgo+IFdlIGFjdHVh
bGx5IGNhbGwgdGhhdCBsYXRlciBhbmQgd291bGQgcHJvYmFibHkgYmUgYmV0dGVyIHRvIGNoZWNr
IGhlcmUuLgpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuCgpUaGUgcHJvdG90eXBlIGlzOgp2b2lk
IGJsa19xdWV1ZV9sb2dpY2FsX2Jsb2NrX3NpemUoc3RydWN0IHJlcXVlc3RfcXVldWUgKiwgdW5z
aWduZWQgaW50KTsKClNvIGNoYW5nZSBpdCB0bzoKYm9vbCBibGtfcXVldWVfbG9naWNhbF9ibG9j
a19zaXplKHN0cnVjdCByZXF1ZXN0X3F1ZXVlICosIHVuc2lnbmVkIGludCk7CgpBbmQgY2hlY2sg
YWxsIGNhbGxlcnMgb2YgdGhpcyBmdW5jdGlvbiwgcmlnaHQ/CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
