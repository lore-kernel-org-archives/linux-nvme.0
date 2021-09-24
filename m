Return-Path: <SRS0=ODQg=OO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C76C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 02:34:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC83610C7
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Sep 2021 02:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFC83610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qF/6mZfE4Ib9DQZ4tPdu1nXDlpdNSS+DXffygv883Vg=; b=YqYiYTad7vLxQt
	5r2bHaPDxa9zfl4A5AbtElzilVrms+lpsWysXorkLQS1tC+qsZ9a0P2OFkZmyu3LFYV8ux8ofzPSS
	8a7TolIYXsnGz2ro/IEtwP/o0iq/WKjYvcZdOXZtmBwEPgT/SkOqPE8dC8tImcsLVkogs2fY4I9v5
	Lg1PESU8oCGeZee5VmaIkGlMUZ2Jo2mBlHzhPcMcK7YW/fh1Qt5+w36fOdafIizpcYvH27I2t6pTS
	n1uPYgi/+tqYhoQuXxf+MnasPoArer3je/AnJ0SC/ouh91rmVKm2RcQl/ZUT8xl+ROH8ipfTwWHAb
	YNnGZjgff/QqG5Db+K6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mTb1q-00CuuQ-5N; Fri, 24 Sep 2021 02:33:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mTb1m-00Cutl-Ma
 for linux-nvme@lists.infradead.org; Fri, 24 Sep 2021 02:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632450808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lioVrYk7Fex9BPqmTPokoys2HS5Ts3MqmCubQt10m38=;
 b=H16lFdpKtW5bbLTOdIQBa35qcB6TluX+ytBi48iIdzSnENkCCZtOKsymSAdpi9sYMzd9cB
 YJMVOl2qWi7mpHy2aa6cUjNEdpTvk/AQD7Lsv96QIXTNEX9HtEjZNctuk+Y/oeBsoTKU35
 I+4Sa1SHfu9vMn7HiYDNxMYapP2Byo0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-GwBKO3wlNQyPnyS5FmIpVg-1; Thu, 23 Sep 2021 22:33:26 -0400
X-MC-Unique: GwBKO3wlNQyPnyS5FmIpVg-1
Received: by mail-yb1-f199.google.com with SMTP id
 u206-20020a2547d7000000b005b5b9fc7299so1619467yba.16
 for <linux-nvme@lists.infradead.org>; Thu, 23 Sep 2021 19:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lioVrYk7Fex9BPqmTPokoys2HS5Ts3MqmCubQt10m38=;
 b=lTiRfNi98/Oq5YrFCt6u6EULxnekpm9KKAYPiz2p9Fz+9okEt+1xb6lK1Lq8w1LfVt
 3+Y5CbD8zF7EgSi4tomDOHiqkKzv/CnylpWMFQUzX7ygd5eNEQll4UWAyUFpUY40hGrY
 GHSlmwbFD8Jx9+tLvEZEGmxzphOURYNMCWv+8srGpZHBn6DycNtc3w85kF/eMMDqFw7v
 YKbfakF8wIbjqIakF6SPIlpdmNdiiI0rQMkVcP+gxYmHhtyVE1oJaPoyhHl9ndH8XYl9
 v7NGGM7+Zb2dw10llS7oFHdyvRqXyQI/VgZIgf27rc4QKuj40zEV9hZX8g/8Vn9a3GHN
 iilA==
X-Gm-Message-State: AOAM531oHSvlxrOK1SMax2OocSLFyJlqVrqPH3WE2oD+2mqDNk89yuz+
 AL1aMsxs9NlRSGpmyKV6TUpbXI5VbUFXwxRhA7oCdOK81M4icOt/8ZCqhDLIKjRs1wdps9jch/K
 K8Oxy3k0apBqEJ6rDKEDAvv+ATarGDaeQKBLuGaYQqHc=
X-Received: by 2002:a25:69c6:: with SMTP id e189mr9638339ybc.86.1632450805993; 
 Thu, 23 Sep 2021 19:33:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZsEwv2XjcSpe9IhckTqmyKG48g67ZwWYDR0s072mF/8sz24jpczBPVeyCINnZOrrlbQqu2TxJkR32UY5BhZ8=
X-Received: by 2002:a25:69c6:: with SMTP id e189mr9638321ybc.86.1632450805782; 
 Thu, 23 Sep 2021 19:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210922020425uscas1p22ca979458bbbb94c243af890bdca04b6@uscas1p2.samsung.com>
 <CAHj4cs_9AM7YvirAhcztZjhOV0nac_qShHs9qs4B1JAMc3PXdA@mail.gmail.com>
 <20210923165410.GA489884@bgt-140510-bm01>
In-Reply-To: <20210923165410.GA489884@bgt-140510-bm01>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 24 Sep 2021 10:33:14 +0800
Message-ID: <CAHj4cs_LDy2GWJFi9O2iaKJF8Ziw+Z1BzzL+QmCoTN1SbRnTMw@mail.gmail.com>
Subject: Re: [bug report] nvme removing after probe failed with pci rescan
 after nvme sysfs removal
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210923_193330_859179_D5373B0E 
X-CRM114-Status: GOOD (  17.13  )
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

T24gRnJpLCBTZXAgMjQsIDIwMjEgYXQgMTI6NTggQU0gQWRhbSBNYW56YW5hcmVzCjxhLm1hbnph
bmFyZXNAc2Ftc3VuZy5jb20+IHdyb3RlOgo+Cj4gT24gV2VkLCBTZXAgMjIsIDIwMjEgYXQgMDk6
NTY6NDdBTSArMDgwMCwgWWkgWmhhbmcgd3JvdGU6Cj4gPiBIZWxsbwo+ID4KPiA+IEkgZm91bmQg
dGhpcyBpc3N1ZSBkdXJpbmcgdGhlIG52bWUgcmVtb3ZhbCB0ZXN0LCBJIGRpZCBzb21lIGRlYnVn
IGNvZGUKPiA+IGZvdW5kIGl0IHdhcyBmYWlsZWQgZHVyaW5nIG52bWUgIkNTVFMg4oCTIENvbnRy
b2xsZXIgU3RhdHVzIiByZWFkLCBjb3VsZAo+ID4gYW55b25lIGhlbHAgY2hlY2sgaWYgdGhpcyBp
cyBvbmUgSFcgb3IgU1cgaXNzdWU/Cj4KPiBIZWxsbyBZaSwKPgo+IFdoYXQgaXMgdGhlIG52bWUg
cmVtb3ZhbCB0ZXN0PyBXaGVuIEkgZ2V0IGFjY2VzcyB0byB0aGUgdGVzdCBJIHdpbGwgcnVuIGl0
IG9uCj4gdGhlIEhXIG9uIG15IGN1cnJlbnQgbWFjaGluZSB0byBzZWUgd2hhdCBoYXBwZW5zLiBJ
IGRvbid0IGhhdmUgdGhlIHNhbWUgU1NEIGluCj4gbXkgY3VycmVudCB0ZXN0IHN5c3RlbSwgYnV0
IEkgd2lsbCBtYWtlIHN1cmUgSSBhbSBhYmxlIHRvIHJ1biB0aGUgdGVzdCBvbiB0aGUKPiBzYW1l
IEhXIHlvdSBhcmUgaGF2aW5nIGlzc3VlcyB3aXRoLgo+CkhpIEFkYW0KSGVyZSBpcyB0aGUgc3Rl
cHMsIGFuZCB0aGUgc2VydmVyIEkgdXNlZCBpcyBERUxMIFI3MzB4ZCBhbmQgREVMTCBSNjQwLApm
ZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgeW91IG5lZWQgbW9yZSBpbmZvLCB0aGFua3MuCgoj
IGxzcGNpIHwgZ3JlcCAtaSBudm1lCjg3OjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9s
bGVyOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENvIEx0ZApOVk1lIFNTRCBDb250cm9sbGVyIFNNOTgx
L1BNOTgxL1BNOTgzCiNlY2hvIDEgPi9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDBcOjg3XDowMC4w
L3JlbW92ZQojZWNobyAxID4vc3lzL2J1cy9wY2kvcmVzY2FuCgpUaGFua3MKWWkKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
