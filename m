Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1F0C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 19:27:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E686105A
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 19:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E686105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WnZkZgKsYadfau6+kHPkSWQu4GMPxYSD6zXVxAETyFU=; b=gbAXtlMfym02oTHl3knyUtjhR
	oSaMa8bggxShBJy+yq3tggkDwKy0shMZSaHsEOhkqYRw8Sr+9eHUZ/9kd3zp5mq1ELWWrEISIiYBp
	7kxbm3tf1xPe6uV6QCWEXzuuLfjlSpZ8bzEXWXkUOSN30iFLhEXMHxyp9Aao55z4icfZ5VmiXmijs
	fxOkVMgF58Wwr9CHDaLNBRxBzfFON+E8X8W7lsVuDKAA4LNh7AZxsW/DY4bso1TlP2AOzrtx8OtIL
	UC3niRCbSc/qhDGj7sPy/nx8OKTx3iRS0sgT7qnBZ+Vekvsy7xO7PENS6eK27v3JeuD32Z6ET+PDn
	Grg7x5Qtw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVfje-004zPA-8N; Sun, 11 Apr 2021 19:27:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVfjP-004zP4-OW
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 19:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=/8TJhA68h/8e3XqwlnCzlH6v3LnaNubb1RVVGCxTa4g=; b=mD3eaKNFoXCK7nO+6CJJNFHSxf
 VX16RGRzAd83jky1abO+9jRN7+KRqQtVnWuxN2zio6KEw7Pw11YjbVdeHPDA2dJkJ9hrkaQkmDTf6
 q+7Ig656E9ONFAB2xT9eHscMEnNpRlvsdt/ZTn4gpwY7jhVYuFP4q24By52/tN3sbgniuLCWqZ/R/
 snEaa/C6vVUyFNLBME8G7uLmQpAeiFH2DcXOZaSBtIpCod5ABgQc+gpFTirbL/PLMUSxTp8RZ+sEW
 pgW++PG2HUtJGl8vTXNW3zA0HjFqvhiXXiCzshN5q2RGTxxJv0yrOyEU5q/7UrOWiW2JTSLQhI7FD
 F9JS3MYA==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVfjM-005fYp-Jg
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 19:26:50 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 o20-20020a05600c4fd4b0290114265518afso5661923wmq.4
 for <linux-nvme@lists.infradead.org>; Sun, 11 Apr 2021 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=/8TJhA68h/8e3XqwlnCzlH6v3LnaNubb1RVVGCxTa4g=;
 b=J/l21sH2xEiKQ5zss8PE24t6RX0KijI3aKHY/zYCZ215ztzsJxk3YljLf/9ftP+pPe
 W2hIc9la/fpqnWUY3TUAuScz4dE1UIQItk2QhltQbkThx0ZFcUtLEyo9eWse4P5qaoGn
 sVrV13I6RW6IfJqFSoDl8o3kyGU7FpHMH7YI6Vv6I/QtjipsPPfa1VoVXNs55fE86dWB
 fmA6d8XTjvDkCBtqS8KZ8EzaGTFkfEAVMmtmWT7qIMmUGtH2ziIzg7IpgUebjLAj6Yb9
 l6g37HwskvyYSfmzdloylJzUbLJUGkrKUGnzOCqluZCe6dn9gEVSQ08hl5AMZ80QmEgB
 CohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/8TJhA68h/8e3XqwlnCzlH6v3LnaNubb1RVVGCxTa4g=;
 b=PIRaLCPaWhzkagkhim51lxRplXtkYSb+pUJR9HhRND64xoxZsMZXcBVnPpxI9xKorA
 9wNs16DMKxX/vkgtto0dxOtYAfZr2E4fL1azwvprWn+VRXdwjLYFGxtlPMXVn1OoSbjj
 +stB9WibiJAQ/zJZ93dk7Fanle9Z/S7F+EL9Vy3tcnCDc5jkrCLpfCtfe9MfQ8WnMZCy
 +eRIWP3VOJXpa6QoLETirPLUoJu7bGlJ+Jeo0JAdY4KBETWBd/zk0mKHlmp+0amMKI2p
 8wMJx7fEafU0o5UyXkNVBcHgAI/UgziV2h0oUkfQ/Fg3nIn9x294HnO2meSaDRNRUqnv
 MJqQ==
X-Gm-Message-State: AOAM533NsygdPtdycsUYtxSj/olvpfnzk30LU4gfiGoCnPq+Zu+JUzzG
 YD2l0eNbbQIUMWkccY53tgNWQw==
X-Google-Smtp-Source: ABdhPJztsA/xwX5L/DoL1oZX+LcVXnIQD+VgkEO9P1o2PIOgshz/wlckdDgYHVifqaAMs+uSrN4kbw==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr23533683wmc.100.1618169203190; 
 Sun, 11 Apr 2021 12:26:43 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d5sm16939244wrx.0.2021.04.11.12.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Apr 2021 12:26:42 -0700 (PDT)
Date: Sun, 11 Apr 2021 21:26:41 +0200
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
Message-ID: <20210411192641.ya6ntxannk3gjyl5@mpHalley.localdomain>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
 <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c7848f1c-c2c1-6955-bf20-f413a44f9969@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210411_122648_674241_2C9A0D44 
X-CRM114-Status: GOOD (  17.60  )
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

T24gMTEuMDQuMjAyMSAxMjoxMCwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Cj5PbiA0LzEwLzIwMjEg
OTozMiBBTSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+T24gMTAgQXByIDIwMjEsIGF0IDAy
LjMwLCBDaGFpdGFueWEgS3Vsa2FybmkgPENoYWl0YW55YS5LdWxrYXJuaUB3ZGMuY29tPiB3cm90
ZToKPj4+Cj4+Pu+7v09uIDQvOS8yMSAxNzoyMiwgTWF4IEd1cnRvdm95IHdyb3RlOgo+Pj4+Pk9u
IDIvMTkvMjAyMSAyOjQ1IFBNLCBTZWx2YUt1bWFyIFMgd3JvdGU6Cj4+Pj4+VGhpcyBwYXRjaHNl
dCB0cmllcyB0byBhZGQgc3VwcG9ydCBmb3IgVFA0MDY1YSAoIlNpbXBsZSBDb3B5IENvbW1hbmQi
KSwKPj4+Pj52MjAyMC4wNS4wNCAoIlJhdGlmaWVkIikKPj4+Pj4KPj4+Pj5UaGUgU3BlY2lmaWNh
dGlvbiBjYW4gYmUgZm91bmQgaW4gZm9sbG93aW5nIGxpbmsuCj4+Pj4+aHR0cHM6Ly9udm1leHBy
ZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMvTlZNLUV4cHJlc3MtMS40LVJhdGlmaWVkLVRQcy0x
LnppcAo+Pj4+Pgo+Pj4+PlNpbXBsZSBjb3B5IGNvbW1hbmQgaXMgYSBjb3B5IG9mZmxvYWRpbmcg
b3BlcmF0aW9uIGFuZCBpcyAgdXNlZCB0byBjb3B5Cj4+Pj4+bXVsdGlwbGUgY29udGlndW91cyBy
YW5nZXMgKHNvdXJjZV9yYW5nZXMpIG9mIExCQSdzIHRvIGEgc2luZ2xlIGRlc3RpbmF0aW9uCj4+
Pj4+TEJBIHdpdGhpbiB0aGUgZGV2aWNlIHJlZHVjaW5nIHRyYWZmaWMgYmV0d2VlbiBob3N0IGFu
ZCBkZXZpY2UuCj4+Pj4+Cj4+Pj4+VGhpcyBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0IGFkZCBuYXRp
dmUgY29weSBvZmZsb2FkIHN1cHBvcnQgZm9yIHN0YWNrZWQKPj4+Pj5kZXZpY2VzIHJhdGhlciBj
b3B5IG9mZmxvYWQgaXMgZG9uZSB0aHJvdWdoIGVtdWxhdGlvbi4gUG9zc2libGUgdXNlCj4+Pj4+
Y2FzZXMgYXJlIEYyRlMgZ2MgYW5kIEJUUkZTIHJlbG9jYXRpb24vYmFsYW5jZS4KPj4+Pj4KPj4+
Pj4qYmxrZGV2X2lzc3VlX2NvcHkqIHRha2VzIHNvdXJjZSBiZGV2LCBubyBvZiBzb3VyY2VzLCBh
cnJheSBvZiBzb3VyY2UKPj4+Pj5yYW5nZXMgKGluIHNlY3RvcnMpLCBkZXN0aW5hdGlvbiBiZGV2
IGFuZCBkZXN0aW5hdGlvbiBvZmZzZXQoaW4gc2VjdG9ycykuCj4+Pj4+SWYgYm90aCBzb3VyY2Ug
YW5kIGRlc3RpbmF0aW9uIGJsb2NrIGRldmljZXMgYXJlIHNhbWUgYW5kIGNvcHlfb2ZmbG9hZCA9
IDEsCj4+Pj4+dGhlbiBjb3B5IGlzIGRvbmUgdGhyb3VnaCBuYXRpdmUgY29weSBvZmZsb2FkaW5n
LiBDb3B5IGVtdWxhdGlvbiBpcyB1c2VkCj4+Pj4+aW4gb3RoZXIgY2FzZXMuCj4+Pj4+Cj4+Pj4+
QXMgU0NTSSBYQ09QWSBjYW4gdGFrZSB0d28gZGlmZmVyZW50IGJsb2NrIGRldmljZXMgYW5kIG5v
IG9mIHNvdXJjZSByYW5nZSBpcwo+Pj4+PmVxdWFsIHRvIDEsIHRoaXMgaW50ZXJmYWNlIGNhbiBi
ZSBleHRlbmRlZCBpbiBmdXR1cmUgdG8gc3VwcG9ydCBTQ1NJIFhDT1BZLgo+Pj4+QW55IGlkZWEg
d2h5IHRoaXMgVFAgd2Fzbid0IGRlc2lnbmVkIGZvciBjb3B5IG9mZmxvYWQgYmV0d2VlbiAyCj4+
Pj5kaWZmZXJlbnQgbmFtZXNwYWNlcyBpbiB0aGUgc2FtZSBjb250cm9sbGVyID8KPj4+WWVzLCBp
dCB3YXMgdGhlIGZpcnN0IGF0dGVtcHQgc28gdG8ga2VlcCBpdCBzaW1wbGUuCj4+Pgo+Pj5GdXJ0
aGVyIHdvcmsgaXMgbmVlZGVkIHRvIGFkZCBpbmNyZW1lbnRhbCBUUCBzbyB0aGF0IHdlIGNhbiBh
bHNvIGRvIGEgY29weQo+Pj5iZXR3ZWVuIHRoZSBuYW1lLXNwYWNlcyBvZiBzYW1lIGNvbnRyb2xs
ZXIgKGlmIHdlIGNhbid0IGFscmVhZHkpIGFuZCB0byB0aGUKPj4+bmFtZXNwYWNlcyB0aGF0IGJl
bG9uZ3MgdG8gdGhlIGRpZmZlcmVudCBjb250cm9sbGVyLgo+Pj4KPj4+PkFuZCBhIHNpbXBsZSBj
b3B5IHdpbGwgYmUgdGhlIGNhc2Ugd2hlcmUgdGhlIHNyY19uc2lkID09IGRzdF9uc2lkID8KPj4+
Pgo+Pj4+QWxzbyB3aHkgdGhlcmUgYXJlIG11bHRpcGxlIHNvdXJjZSByYW5nZXMgYW5kIG9ubHkg
b25lIGRzdCByYW5nZSA/IFdlCj4+Pj5jb3VsZCBhZGQgYSBiaXQgdG8gaW5kaWNhdGUgaWYgdGhp
cyByYW5nZSBpcyBzcmMgb3IgZHN0Li4KPj5PbmUgb2YgdGhlIHRhcmdldCB1c2UgY2FzZXMgd2Fz
IFpOUyBpbiBvcmRlciB0byBhdm9pZCBmYWJyaWMgdHJhbnNmZXJzIGR1cmluZyBob3N0IEdDLiBZ
b3UgY2FuIHNlZSBob3cgdGhpcyBwbGF5cyB3ZWxsIHdpdGggc2V2ZXJhbCB6b25lIHJhbmdlcyBh
bmQgYSBzaW5nbGUgem9uZSBkZXN0aW5hdGlvbi4KPj4KPj5JZiB3ZSBzdGFydCBnZXR0aW5nIHN1
cHBvcnQgaW4gTGludXggdGhyb3VnaCB0aGUgZGlmZmVyZW50IHBhc3QgY29weSBvZmZsb2FkIGVm
Zm9ydHMsIEnigJltIHN1cmUgd2UgY2FuIGV4dGVuZCB0aGlzIFRQIGluIHRoZSBmdXR1cmUuCj4K
PkJ1dCB0aGUgImNvcHkiIGNvbW1hbmQgSU1PIGlzIG1vcmUgZ2VuZXJhbCB0aGFuIHRoZSBaTlMg
R0MgY2FzZSwgdGhhdCAKPmNhbiBiZSBhIHByaXZhdGUgY2FzZSBvZiBjb3B5LCBpc24ndCBpdCA/
CgpJdCBhcHBsaWVzIHRvIGFueSBuYW1lc3BhY2UgdHlwZSwgc28geWVzLiBJIGp1c3Qgd2FudGVk
IHRvIGdpdmUgeW91IHRoZQpiYWNrZ3JvdW5kIGZvciB0aGUgY3VycmVudCAic2ltcGxlIiBzY29w
ZSB0aHJvdWdoIG9uZSBvZiB0aGUgdXNlIGNhc2VzCnRoYXQgd2FzIGluIG1pbmQuCgo+V2UgY2Fu
IGdldCBhIGJpZyBiZW5lZml0IG9mIG9mZmxvYWRpbmcgdGhlIGRhdGEgY29weSBmcm9tIG9uZSBu
cyB0byAKPmFub3RoZXIgaW4gdGhlIHNhbWUgY29udHJvbGxlciBhbmQgZXZlbiBpbiBkaWZmZXJl
bnQgY29udHJvbGxlcnMgaW4gCj50aGUgc2FtZSBzdWJzeXN0ZW0uCgpEZWZpbml0ZWx5LgoKPgo+
RG8geW91IHRoaW5rIHRoZSBleHRlbnNpb24gc2hvdWxkIGJlIHRvICJjb3B5IiBjb21tYW5kIG9y
IHRvIGNyZWF0ZSBhIAo+bmV3IGNvbW1hbmQgInhfY29weSIgZm9yIGNvcHlpbmcgdG8gZGlmZmVy
ZW50IGRlc3RpbmF0aW9uIG5zID8KCkkgYmVsaWV2ZSB0aGVyZSBpcyBzcGFjZSBmb3IgZXh0ZW5z
aW9ucyB0byBzaW1wbGUgY29weS4gQnV0IGdpdmVuIHRoZQpleHBlcmllbmNlIHdpdGggWENPUFks
IEkgY2FuIGltYWdpbmUgdGhhdCBjaGFuZ2VzIHdpbGwgYmUgaW5jcmVtZW50YWwsCmJhc2VkIG9u
IHZlcnkgc3BlY2lmaWMgdXNlIGNhc2VzLgoKSSB0aGluayBnZXR0aW5nIHN1cHBvcnQgdXBzdHJl
YW0gYW5kIGJyaW5naW5nIGRlcGxveWVkIGNhc2VzIGlzIGEgdmVyeQpnb29kIHN0YXJ0LgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
