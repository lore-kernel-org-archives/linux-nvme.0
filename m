Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D998FC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 18:26:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D7B61026
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 18:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D7B61026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pmuq48tC9M0Hu+GiPM3/rPYveosC3p0/LFknPyDWAdU=; b=TGmdSWZW0Rf6jnil4ysYkT6IS
	Gmaktakz20z789mLDSV9StPmY/Xp+xyKkIZ7rsHqAmim5ziJ4XaVjLHbfV2JR4zx8k07sqzCskoxX
	Uyf30d4GY2G+aiSK0N+MRFiPzqX5i4wZkikECZhE9Beri0fU+7ooJ3NgdijJO5zoQf4i2grWVLevR
	zTreYnWLI/haQu9avTh1E03IBrd9zFFXyN1FZUlakMJilkShm9wNrjnfd8tZVPepeH+6jM2ndDvEX
	m+8s3bqUYw6p7cwonU9SUmYcsgDHNNCGhAIfyT2spW4MzzMhtgoIay1PFTliIvs7Jf8vCah9UsfHY
	axjd+pCyA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWNjk-00A83b-IY; Tue, 13 Apr 2021 18:26:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWNjg-00A83B-PE
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 18:26:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=gUmzsxIe9Usd79B4Ol6Ovwj7y0RVrVcb5f5DujLhjr4=; b=n5G9xO9csdiPKwk95HYVfQP+By
 HuM/nB/SRhdyMqUztvKYdlW0pFp/YVtjKmHN2CR5fW8HbNUaEC5u3qILpz9crf2Ec6JDP24Vl/0zd
 E04WS/+2c47rMrybddOA8l2RgxNjf0I/KlUQ+/nQTdzDv3O/uZnFiOQTbc6ISXdOc4MdQ6M7UQrc0
 0ZbMsejK/z9e8zQ229yc79FG6bFadnpseCMDL5JZL8BoL7R0AeygE2nE5MqzjbPoq+We2cTMIiTcv
 tY2NGeDeQyQwoAgbrNt9fJrllskPW9fBeXk0IBl6RaOBqSqcyro1T+YvdUt63n00jzS+fd+cvQBic
 0O+7SWRA==;
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWNjd-007Fhn-Qh
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 18:26:03 +0000
Received: by mail-ed1-x52f.google.com with SMTP id h10so20499066edt.13
 for <linux-nvme@lists.infradead.org>; Tue, 13 Apr 2021 11:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=gUmzsxIe9Usd79B4Ol6Ovwj7y0RVrVcb5f5DujLhjr4=;
 b=MVR0RaulAxRTS3KavGFiJnMRa4rOOhLGMpz5Oyx0Spl9UpUeonzmqZCqqUUmm/Vsl1
 1NH7MNR6MpB3mJNmBa+Xj5uO7rqSbqKovC/DqB24g8v7o2FMPgAjSGGg8Oc83fMfiQSo
 CLtjw2fWWPHU0zS7/7TMN0CivdY+ncE0f1V3EIv8hbU/hYbkcjN0PIPLWgJwCTsXjAzx
 oDT6sYIP4BmoUCXP+kyjPwaJ3o1hGpgjsXFga2Z/u18pL4smKnTh/1S4aZrmLszdri25
 2ceicyt/UnGdHZm9KTLaH08dvaBeCXM4S8na0V5cz5fDiYNSa25qve1VajGyhzTn0AKA
 KFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gUmzsxIe9Usd79B4Ol6Ovwj7y0RVrVcb5f5DujLhjr4=;
 b=AG4znH1ziEESawL36H3TrIArIaE2r8IWnrz3lnAOa3br/rxAwnJuZXH+aRblVWsLmS
 PP9VEgBt1Y/U3kITfE55TYRbr2cznjmubvf6PGC8+Jx/gxKw1/oUUpcYtQVqJy1cAbGP
 5HbXxxuy3aeXyFTXiG0WnwQJO9rI//VrsTby4HUitz/dha5c0Ngmao+2uxSUWMi09ZBA
 Y9rz+RvY48gzB8t1/Ec7jSFlPx6mn42OJerfHDvPbhYhZFYaqWgEqPq62Q9HvaqWwyaM
 FPk3692yn0KnUhCjatnzixozaHzKCQT91q+piI//OX24NjndmtuHpSumRswoN9TCKlJZ
 Y5fQ==
X-Gm-Message-State: AOAM532hc0XOCSY4gAxfIpI86B1jfsJygRNA54UuuiHeiq7s4kTW9Ai/
 zWb8FxcpYj+k/D84eMwnk/DpbA==
X-Google-Smtp-Source: ABdhPJy7SvyslbxUDaNLIDv1BBMpbhsvXcAeoi5qDTCEQdBe4vv+UqkCJh1ZRD5tvlU1eL4u4IyrjA==
X-Received: by 2002:a05:6402:35cd:: with SMTP id
 z13mr36855014edc.21.1618338359704; 
 Tue, 13 Apr 2021 11:25:59 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id g20sm181363edu.91.2021.04.13.11.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 11:25:59 -0700 (PDT)
Date: Tue, 13 Apr 2021 20:25:58 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>,
 linux-nvme@lists.infradead.org, axboe@kernel.dk,
 Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
 sagi@grimberg.me, snitzer@redhat.com, selvajove@gmail.com,
 linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, joshi.k@samsung.com, kbusch@kernel.org,
 joshiiitr@gmail.com, hch@lst.de
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Message-ID: <20210413182558.v2lynge6aleazgbv@mpHalley.localdomain>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
 <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
 <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a52cc06-27ce-96a4-b180-60fc269719ba@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_112601_944865_0CC6CD49 
X-CRM114-Status: GOOD (  22.41  )
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

T24gMTMuMDQuMjAyMSAxODozOCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Cj5PbiA0LzExLzIwMjEg
MTA6MjYgUE0sIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+T24gMTEuMDQuMjAyMSAxMjoxMCwg
TWF4IEd1cnRvdm95IHdyb3RlOgo+Pj4KPj4+T24gNC8xMC8yMDIxIDk6MzIgQU0sIEphdmllciBH
b256w6FsZXogd3JvdGU6Cj4+Pj4+T24gMTAgQXByIDIwMjEsIGF0IDAyLjMwLCBDaGFpdGFueWEg
S3Vsa2FybmkgCj4+Pj4+PENoYWl0YW55YS5LdWxrYXJuaUB3ZGMuY29tPiB3cm90ZToKPj4+Pj4K
Pj4+Pj7vu79PbiA0LzkvMjEgMTc6MjIsIE1heCBHdXJ0b3ZveSB3cm90ZToKPj4+Pj4+Pk9uIDIv
MTkvMjAyMSAyOjQ1IFBNLCBTZWx2YUt1bWFyIFMgd3JvdGU6Cj4+Pj4+Pj5UaGlzIHBhdGNoc2V0
IHRyaWVzIHRvIGFkZCBzdXBwb3J0IGZvciBUUDQwNjVhICgiU2ltcGxlIAo+Pj4+Pj4+Q29weSBD
b21tYW5kIiksCj4+Pj4+Pj52MjAyMC4wNS4wNCAoIlJhdGlmaWVkIikKPj4+Pj4+Pgo+Pj4+Pj4+
VGhlIFNwZWNpZmljYXRpb24gY2FuIGJlIGZvdW5kIGluIGZvbGxvd2luZyBsaW5rLgo+Pj4+Pj4+
aHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMvTlZNLUV4cHJlc3MtMS40
LVJhdGlmaWVkLVRQcy0xLnppcAo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PlNpbXBsZSBjb3B5IGNv
bW1hbmQgaXMgYSBjb3B5IG9mZmxvYWRpbmcgb3BlcmF0aW9uIGFuZCBpc8KgIAo+Pj4+Pj4+dXNl
ZCB0byBjb3B5Cj4+Pj4+Pj5tdWx0aXBsZSBjb250aWd1b3VzIHJhbmdlcyAoc291cmNlX3Jhbmdl
cykgb2YgTEJBJ3MgdG8gYSAKPj4+Pj4+PnNpbmdsZSBkZXN0aW5hdGlvbgo+Pj4+Pj4+TEJBIHdp
dGhpbiB0aGUgZGV2aWNlIHJlZHVjaW5nIHRyYWZmaWMgYmV0d2VlbiBob3N0IGFuZCBkZXZpY2Uu
Cj4+Pj4+Pj4KPj4+Pj4+PlRoaXMgaW1wbGVtZW50YXRpb24gZG9lc24ndCBhZGQgbmF0aXZlIGNv
cHkgb2ZmbG9hZCAKPj4+Pj4+PnN1cHBvcnQgZm9yIHN0YWNrZWQKPj4+Pj4+PmRldmljZXMgcmF0
aGVyIGNvcHkgb2ZmbG9hZCBpcyBkb25lIHRocm91Z2ggZW11bGF0aW9uLiBQb3NzaWJsZSB1c2UK
Pj4+Pj4+PmNhc2VzIGFyZSBGMkZTIGdjIGFuZCBCVFJGUyByZWxvY2F0aW9uL2JhbGFuY2UuCj4+
Pj4+Pj4KPj4+Pj4+PipibGtkZXZfaXNzdWVfY29weSogdGFrZXMgc291cmNlIGJkZXYsIG5vIG9m
IHNvdXJjZXMsIAo+Pj4+Pj4+YXJyYXkgb2Ygc291cmNlCj4+Pj4+Pj5yYW5nZXMgKGluIHNlY3Rv
cnMpLCBkZXN0aW5hdGlvbiBiZGV2IGFuZCBkZXN0aW5hdGlvbiAKPj4+Pj4+Pm9mZnNldChpbiBz
ZWN0b3JzKS4KPj4+Pj4+PklmIGJvdGggc291cmNlIGFuZCBkZXN0aW5hdGlvbiBibG9jayBkZXZp
Y2VzIGFyZSBzYW1lIGFuZCAKPj4+Pj4+PmNvcHlfb2ZmbG9hZCA9IDEsCj4+Pj4+Pj50aGVuIGNv
cHkgaXMgZG9uZSB0aHJvdWdoIG5hdGl2ZSBjb3B5IG9mZmxvYWRpbmcuIENvcHkgCj4+Pj4+Pj5l
bXVsYXRpb24gaXMgdXNlZAo+Pj4+Pj4+aW4gb3RoZXIgY2FzZXMuCj4+Pj4+Pj4KPj4+Pj4+PkFz
IFNDU0kgWENPUFkgY2FuIHRha2UgdHdvIGRpZmZlcmVudCBibG9jayBkZXZpY2VzIGFuZCBubyAK
Pj4+Pj4+Pm9mIHNvdXJjZSByYW5nZSBpcwo+Pj4+Pj4+ZXF1YWwgdG8gMSwgdGhpcyBpbnRlcmZh
Y2UgY2FuIGJlIGV4dGVuZGVkIGluIGZ1dHVyZSB0byAKPj4+Pj4+PnN1cHBvcnQgU0NTSSBYQ09Q
WS4KPj4+Pj4+QW55IGlkZWEgd2h5IHRoaXMgVFAgd2Fzbid0IGRlc2lnbmVkIGZvciBjb3B5IG9m
ZmxvYWQgYmV0d2VlbiAyCj4+Pj4+PmRpZmZlcmVudCBuYW1lc3BhY2VzIGluIHRoZSBzYW1lIGNv
bnRyb2xsZXIgPwo+Pj4+PlllcywgaXQgd2FzIHRoZSBmaXJzdCBhdHRlbXB0IHNvIHRvIGtlZXAg
aXQgc2ltcGxlLgo+Pj4+Pgo+Pj4+PkZ1cnRoZXIgd29yayBpcyBuZWVkZWQgdG8gYWRkIGluY3Jl
bWVudGFsIFRQIHNvIHRoYXQgd2UgY2FuIAo+Pj4+PmFsc28gZG8gYSBjb3B5Cj4+Pj4+YmV0d2Vl
biB0aGUgbmFtZS1zcGFjZXMgb2Ygc2FtZSBjb250cm9sbGVyIChpZiB3ZSBjYW4ndCAKPj4+Pj5h
bHJlYWR5KSBhbmQgdG8gdGhlCj4+Pj4+bmFtZXNwYWNlcyB0aGF0IGJlbG9uZ3MgdG8gdGhlIGRp
ZmZlcmVudCBjb250cm9sbGVyLgo+Pj4+Pgo+Pj4+Pj5BbmQgYSBzaW1wbGUgY29weSB3aWxsIGJl
IHRoZSBjYXNlIHdoZXJlIHRoZSBzcmNfbnNpZCA9PSBkc3RfbnNpZCA/Cj4+Pj4+Pgo+Pj4+Pj5B
bHNvIHdoeSB0aGVyZSBhcmUgbXVsdGlwbGUgc291cmNlIHJhbmdlcyBhbmQgb25seSBvbmUgZHN0
IHJhbmdlID8gV2UKPj4+Pj4+Y291bGQgYWRkIGEgYml0IHRvIGluZGljYXRlIGlmIHRoaXMgcmFu
Z2UgaXMgc3JjIG9yIGRzdC4uCj4+Pj5PbmUgb2YgdGhlIHRhcmdldCB1c2UgY2FzZXMgd2FzIFpO
UyBpbiBvcmRlciB0byBhdm9pZCBmYWJyaWMgCj4+Pj50cmFuc2ZlcnMgZHVyaW5nIGhvc3QgR0Mu
IFlvdSBjYW4gc2VlIGhvdyB0aGlzIHBsYXlzIHdlbGwgd2l0aCAKPj4+PnNldmVyYWwgem9uZSBy
YW5nZXMgYW5kIGEgc2luZ2xlIHpvbmUgZGVzdGluYXRpb24uCj4+Pj4KPj4+PklmIHdlIHN0YXJ0
IGdldHRpbmcgc3VwcG9ydCBpbiBMaW51eCB0aHJvdWdoIHRoZSBkaWZmZXJlbnQgcGFzdCAKPj4+
PmNvcHkgb2ZmbG9hZCBlZmZvcnRzLCBJ4oCZbSBzdXJlIHdlIGNhbiBleHRlbmQgdGhpcyBUUCBp
biB0aGUgCj4+Pj5mdXR1cmUuCj4+Pgo+Pj5CdXQgdGhlICJjb3B5IiBjb21tYW5kIElNTyBpcyBt
b3JlIGdlbmVyYWwgdGhhbiB0aGUgWk5TIEdDIGNhc2UsIAo+Pj50aGF0IGNhbiBiZSBhIHByaXZh
dGUgY2FzZSBvZiBjb3B5LCBpc24ndCBpdCA/Cj4+Cj4+SXQgYXBwbGllcyB0byBhbnkgbmFtZXNw
YWNlIHR5cGUsIHNvIHllcy4gSSBqdXN0IHdhbnRlZCB0byBnaXZlIHlvdSB0aGUKPj5iYWNrZ3Jv
dW5kIGZvciB0aGUgY3VycmVudCAic2ltcGxlIiBzY29wZSB0aHJvdWdoIG9uZSBvZiB0aGUgdXNl
IGNhc2VzCj4+dGhhdCB3YXMgaW4gbWluZC4KPj4KPj4+V2UgY2FuIGdldCBhIGJpZyBiZW5lZml0
IG9mIG9mZmxvYWRpbmcgdGhlIGRhdGEgY29weSBmcm9tIG9uZSBucyAKPj4+dG8gYW5vdGhlciBp
biB0aGUgc2FtZSBjb250cm9sbGVyIGFuZCBldmVuIGluIGRpZmZlcmVudCAKPj4+Y29udHJvbGxl
cnMgaW4gdGhlIHNhbWUgc3Vic3lzdGVtLgo+Pgo+PkRlZmluaXRlbHkuCj4+Cj4+Pgo+Pj5EbyB5
b3UgdGhpbmsgdGhlIGV4dGVuc2lvbiBzaG91bGQgYmUgdG8gImNvcHkiIGNvbW1hbmQgb3IgdG8g
Cj4+PmNyZWF0ZSBhIG5ldyBjb21tYW5kICJ4X2NvcHkiIGZvciBjb3B5aW5nIHRvIGRpZmZlcmVu
dCBkZXN0aW5hdGlvbiAKPj4+bnMgPwo+Pgo+PkkgYmVsaWV2ZSB0aGVyZSBpcyBzcGFjZSBmb3Ig
ZXh0ZW5zaW9ucyB0byBzaW1wbGUgY29weS4gQnV0IGdpdmVuIHRoZQo+PmV4cGVyaWVuY2Ugd2l0
aCBYQ09QWSwgSSBjYW4gaW1hZ2luZSB0aGF0IGNoYW5nZXMgd2lsbCBiZSBpbmNyZW1lbnRhbCwK
Pj5iYXNlZCBvbiB2ZXJ5IHNwZWNpZmljIHVzZSBjYXNlcy4KPj4KPj5JIHRoaW5rIGdldHRpbmcg
c3VwcG9ydCB1cHN0cmVhbSBhbmQgYnJpbmdpbmcgZGVwbG95ZWQgY2FzZXMgaXMgYSB2ZXJ5Cj4+
Z29vZCBzdGFydC4KPgo+Q29weWluZyBkYXRhIChmaWxlcykgd2l0aGluIHRoZSBjb250cm9sbGVy
L3N1YnN5c3RlbSBmcm9tIG5zX0EgdG8gbnNfQiAKPnVzaW5nIE5WTWYgd2lsbCByZWR1Y2UgbmV0
d29yayBCVyBhbmQgbWVtb3J5IEJXIGluIHRoZSBob3N0IHNlcnZlci4KPgo+VGhpcyBmZWF0dXJl
IGlzIHdlbGwga25vd24gYW5kIHRoZSB1c2UgY2FzZSBpcyB3ZWxsIGtub3duLgoKRGVmaW5pdGVs
eS4KCj4KPlRoZSBxdWVzdGlvbiB3aGV0aGVyIHdlIGltcGxlbWVudCBpdCBpbiB2ZW5kb3Igc3Bl
Y2lmaWMgbWFubmVyIG9mIHdlIAo+YWRkIGl0IHRvIHRoZSBzcGVjaWZpY2F0aW9uLgo+Cj5JIHBy
ZWZlciBhZGRpbmcgaXQgdG8gdGhlIHNwZWMgOikKCkFncmVlLiBMZXQncyBidWlsZCB1cCBvbiB0
b3Agb2YgU2ltcGxlIENvcHkuIFdlIGNhbiB0YWxrIGFib3V0IGl0Cm9mZmxpbmUgaW4gdGhlIGNv
bnRleHQgb2YgdGhlIE5WTWUgVFdHLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtbnZtZQo=
