Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF8BC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:33:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07BD620768
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bCG4bdbP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="aiAK/tW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07BD620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dFl0roEFI7n6BHQYK51Bo+i4UX8Y+spAUlMErv2bm/c=; b=bCG4bdbPC1UOCbdj9gToiCdeU
	VbSzD/anZObxTl+c5YKAPo/LMKmP7Y01Qgay1BovCy9Tire1jHNkdNKMei4GM2XP8ycyhYZtbPHYo
	xCIxFDS2D3jrb8pM3W7/SZBbxIAkbgc4YXf/5ybhtxd6tQ//Su0oFpPMzOpDiFJZFhP/qU+Haoxbc
	H3JBzCBoLwjUH4TAFTm84645pebpwKRi85RgLuTR2pGoyHqNwTEF9noKLnSRqYwVuX6jlOmQMELGE
	g/KEuadJwYGBCpV39jzXu4hm+YjH1r9163mha8B/kSfQ5EnEXKbUU/ib+yCVHhPhMUlOdtJoEUm3d
	eTFouh+iA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolfn-0006Jy-NU; Fri, 26 Jun 2020 10:33:31 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolfC-00061l-MF
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:33:06 +0000
Received: by mail-lj1-x244.google.com with SMTP id i3so9803791ljg.3
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=k9vzA2Sgr7pZTav9AqdNguX09fGHlD9BrNDa/e+1XN0=;
 b=aiAK/tW03+8F8XcWg6QUOOejPQrGfXeQpyRHszENJXb4Az8CReLO3XnuzzPWD/4zsq
 VqwXo4N1AEkpu69+P+qom5+dqdQolsZZ4VQEQ1mT4JQq4Yte6GgwioX7P3QcQpNSyncd
 b4/yWkf6l7ifJCK7P0m+Vdg/haktCuqF3kTx1FBXHkNq9YwUzhjUy87uKAj++mYtzoS7
 28vT2joWqXA4zznXv1mDvHO2aJt2a3X16BzTDUvwj8JuPBroKXt+9b8EPY1WnwJlmk7U
 7fMbBxiaO9QXDrYwD3hR8SzUDHj1tDQ/z8NepEejgm9IZcPpJWDxzUFmY9jCuHZzVrtm
 Jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=k9vzA2Sgr7pZTav9AqdNguX09fGHlD9BrNDa/e+1XN0=;
 b=GtkLELO770kLd8/RWybFwF7YRr2TBL/JQ0Vpp7tTEY3eJ9BDu8BNlybGZlSDe8MvTU
 lDKyKeu/r9Shi5JeoYDsbuzrSiQS7sCfe6MYlfhCeT8QVe6IxqxBfgxow6Mu0bwIK5ns
 QtR0h23emeyOk2gPMf44l8qaG2h3SigPxq+looSc5oD3ab0NPiYRVtfRpV6QEgn+MI2q
 OoSv5c6GI1BoTs4e4HhCNhHn/bKo84YGu7hNUfoHC4rSwv/KFl5AOHViOx6ckhsbA2YK
 vN293qDnr1WV90cou0R5xZGZq18rfeAtZlQMB63E3LgTWkAoHAG2UNUmtme4LruOBxSt
 I0NA==
X-Gm-Message-State: AOAM530PzTE8YXjMYB/RP2dLoQW0KDk5d93VqazeBP8POmcyXEKSgsBH
 eQyp+0Tbq44xWz2g1ksqb9VT4TA3YjeDSaoB
X-Google-Smtp-Source: ABdhPJylJHZy0o/JgfVoIlK1EuAMe4WEPJl2gf3egNwYjEuDfbFAdP7iE8/9KPUp7EtmvxGBAunYmg==
X-Received: by 2002:a05:6402:1803:: with SMTP id
 g3mr1714657edy.377.1593152777854; 
 Thu, 25 Jun 2020 23:26:17 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id q21sm18095668ejd.30.2020.06.25.23.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:26:17 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:26:16 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
Message-ID: <20200626062616.4xhaj6awtre4zxxf@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
 <d7b3dc5f-a10c-bcf2-8d13-26301d7736df@lightnvm.io>
 <20200625193929.eitl3th2mn2mlxu2@MacBook-Pro.localdomain>
 <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2c075399-36ff-58bc-e29f-36157c852e05@lightnvm.io>
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUuMDYuMjAyMCAyMTo1MywgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDI1LzA2LzIw
MjAgMjEuMzksIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+T24gMjUuMDYuMjAyMCAxNjo0OCwg
TWF0aWFzIEJqw7hybGluZyB3cm90ZToKPj4+T24gMjUvMDYvMjAyMCAxNS4wNCwgTWF0aWFzIEJq
w7hybGluZyB3cm90ZToKPj4+Pk9uIDI1LzA2LzIwMjAgMTQuMjEsIEphdmllciBHb256w6FsZXog
d3JvdGU6Cj4+Pj4+RnJvbTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5j
b20+Cj4+Pj4+Cj4+Pj4+VGhpcyBwYXRjaHNldCBleHRlbmRzIHpvbmVkIGRldmljZSBmdW5jdGlv
bmFsaXR5IG9uIHRvcCBvZiB0aGUgCj4+Pj4+ZXhpc3RpbmcKPj4+Pj52MyBaTlMgcGF0Y2hzZXQg
dGhhdCBLZWl0aCBzZW50IGxhc3Qgd2Vlay4KPj4+Pj4KPj4+Pj5QYXRjaGVzIDEtNSBhcmUgem9u
ZWQgYmxvY2sgaW50ZXJmYWNlIGFuZCBJT0NUTCBhZGRpdGlvbnMgdG8gCj4+Pj4+ZXhwb3NlIFpO
Uwo+Pj4+PnZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlzIHRoZSBhZGRp
dGlvbiBvZiBhIG5ldyB6b25lCj4+Pj4+bWFuYWdlbWVudCBJT0NUTCB0aGF0IGFsbG93cyB0byBl
eHRlbmQgem9uZSBtYW5hZ2VtZW50IGNvbW1hbmRzIHdpdGgKPj4+Pj5mbGFncy4gSSByZWNhbGwg
YSBjb252ZXJzYXRpb24gaW4gdGhlIG1haWxpbmcgbGlzdCBmcm9tIGVhcmx5IAo+Pj4+PnRoaXMg
eWVhcgo+Pj4+PndoZXJlIGEgc2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFz
LCBidXQgbmV2ZXIgbWFkZSBpdAo+Pj4+PnVwc3RyZWFtLiBXZSBleHRlbmRlZCB0aGUgSU9DVEwg
aGVyZSB0byBhbGlnbiB3aXRoIHRoZSAKPj4+Pj5jb21tZW50cyBpbiB0aGF0Cj4+Pj4+dGhyZWFk
LiBIZXJlLCB3ZSBhcmUgaGFwcHkgdG8gZ2V0IHNpZ24tb2ZmcyBieSBhbnlvbmUgdGhhdCBjb250
cmlidXRlZAo+Pj4+PnRvIHRoZSB0aHJlYWQgLSBqdXN0IGNvbW1lbnQgaGVyZSBvciBvbiB0aGUg
cGF0Y2guCj4+Pj4KPj4+PlRoZSBvcmlnaW5hbCBwYXRjaHNldCBpcyBhdmFpbGFibGUgaGVyZTog
Cj4+Pj5odHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS82LzIxLzQxOQo+Pj4+Cj4+Pj5XZSB3YW50
ZWQgdG8gd2FpdCBwb3N0aW5nIG91ciB1cGRhdGVkIHBhdGNoZXMgdW50aWwgdGhlIGJhc2UgCj4+
Pj5wYXRjaGVzIHdlcmUgdXBzdHJlYW0uIEkgZ3Vlc3MgdGhlIGNhdCBpcyBvdXQgb2YgdGhlIGJh
Zy4gOikKPj4+Pgo+Pj4+Rm9yIHRoZSBvcGVuL2ZpbmlzaC9yZXNldCBwYXRjaCwgeW91J2xsIHdh
bnQgdG8gdGFrZSBhIGxvb2sgYXQgCj4+Pj50aGUgb3JpZ2luYWwgcGF0Y2hzZXQsIGFuZCBhcHBs
eSB0aGUgZmVlZGJhY2sgZnJvbSB0aGF0IHRocmVhZCAKPj4+PnRvIHlvdXIgcGF0Y2guIFBsZWFz
ZSBhbHNvIGNvbnNpZGVyIHRoZSB1c2VycyBvZiB0aGVzZSAKPj4+Pm9wZXJhdGlvbnMsIGUuZy4s
IGRtLCBzY3NpLCBudWxsX2JsaywgZXRjLiBUaGUgb3JpZ2luYWwgcGF0Y2hzZXQgCj4+Pj5oYXMg
cGF0Y2hlcyBmb3IgdGhhdC4KPj4+Pgo+Pj5QbGVhc2UgZGlzcmVnYXJkIHRoZSBhYm92ZSAtIEkg
Zm9yZ290IHRoYXQgdGhlIG9yaWdpbmFsIHBhdGNoc2V0IAo+Pj5hY3R1YWxseSB3ZW50IHVwc3Ry
ZWFtLgo+Pj4KPj4+WW91J3JlIHJpZ2h0IHRoYXQgd2UgZGlzY3Vzc2VkIChJIGF0IGxlYXN0IGRp
c2N1c3NlZCBpdCBpbnRlcm5hbGx5IAo+Pj53aXRoIERhbWllbiwgYnV0IEkgY2FuJ3QgZmluZCB0
aGUgbWFpbCkgaGF2aW5nIG9uZSBtZ210IGlzc3VpbmcgCj4+PnRoZSBjb21tYW5kcy4gV2UgZGlk
bid0IGdvIGFoZWFkIGFuZCBhZGRlZCBpdCBhdCB0aGF0IHBvaW50IGR1ZSB0byAKPj4+Wk5TIHN0
aWxsIGJlaW5nIGluIGEgZmx1ZmZ5IHN0YXRlLgo+Pj4KPj4KPj5Eb2VzIHRoZSBwcm9wb3NlZCBJ
T0NUTCBhbGlnbiB3aXRoIHRoZSB1c2UgY2FzZXMgeW91IGhhdmUgaW4gbWluZD8gSSdtCj4+aGFw
cHkgdG8gdGFrZSBpdCBpbiBhIGRpZmZlcmVudCBzZXJpZXMgaWYgeW91IHdhbnQgdG8gYWRkIHBh
dGNoZXMgdG8gaXQKPj5mb3Igb3RoZXIgZHJpdmVycyAoc2NzaSwgbnVsbF9ibGssIGV0Yy4pLgo+
Cj5JIHRoaW5rIHRoZSBpb2N0bCBtYWtlcyBzZW5zZS4gSSB3YW50ZWQgdG8gaGF2ZSBpdCBsaWtl
IHRoYXQgCj5vcmlnaW5hbGx5LiBJJ20gc3RpbGwgdGhpbmtpbmcgdGhyb3VnaCBpZiBpdCBjb3Zl
cnMgdGhlIHNob3J0LXRlcm0gCj5jYXNlcyBmb3IgdGhlIHVwY29taW5nIFRQcy4KClllcy4gWW91
IGNhbiBzZWUgdGhhdCBzb21lIG9mIHRoaXMgaXMgaW50ZW5kZWQgdG8gc3VwcG9ydCBhdCBsZWFz
dCBvbmUKb2YgdGhlIFRQcyB0aGF0IGFyZSBpbiB0aGUgVFdHLiBJdCBpcyBhbHNvIHN1aXRhYmxl
IGZvciBhIGNvdXBsZSBUUHMgd2UKYXJlIHdvcmtpbmcgb24gaW50ZXJuYWxseSBhbmQgZXhwZWN0
IHRvIGJyaW5nIHRvIHRoZSBncm91cC4KCkJ1dCBwbGVhc2UsIGRvIG1ha2Ugc3VyZSBpdCBjb3Zl
cnMgVFBzIHRoYXQgeW91IGtub3cgd2lsbCBiZSBzaGFyZWQgaW4KdGhlIFRXRy4KCkphdmllcgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
