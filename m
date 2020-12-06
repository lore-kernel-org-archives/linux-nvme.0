Return-Path: <SRS0=lw7P=FK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D43C4361B
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Dec 2020 16:48:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033BE2312F
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Dec 2020 16:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033BE2312F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=71UqNFdEYWoAhypS5813w2kN3hzsEtadL3NP7oXcJig=; b=3Du9EOIPI0MlZQfb7FFBmghvQ
	xicqH/C64t28ZjOBMzKbwpX2Ba4KM8jk9HUd8Or+WO1dmyxttexaUpKAH/QkC5DIOow92G9dFnk7A
	/dTxG8UdwrYt0yceOPP7/CvzztKl1VrcP8JZ8YCIc2Vj4K6XHoBxesjaBKdSumwWkNlBzGYhZjLUj
	SSdjD6SGV7MuNMYqQEHIZ/ixAOOjFRxJFvGMYjYEMugMBHKFsF6mPsRiB68KhpfMESO6EShUl0p9o
	1t34tPzom2XJ620XZywmBWlJgI9zZNiE6vy6cr3mzqDKK25GHVXSc5eJzwS4G2nf73fqBV7fU4snK
	ATvbTyLig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klxCT-0004zL-36; Sun, 06 Dec 2020 16:47:53 +0000
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klxCN-0004ye-Q1
 for linux-nvme@lists.infradead.org; Sun, 06 Dec 2020 16:47:48 +0000
Received: by mail-lf1-x12d.google.com with SMTP id r24so14557206lfm.8
 for <linux-nvme@lists.infradead.org>; Sun, 06 Dec 2020 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RW0lDqSJK11o5Hdo0ZTtiX38zMds7s0ivaE30jYDc08=;
 b=fyWAecBmSWqbeKTDqjVW+CVkNXAQmZ410oGJ+xz0B3svfmdqi9ApYJY14RYlLULq1X
 NQfKYWKNfPcKgC+hJNLBviDdi4gBw6UW0zBYYEzqUyiPbgT5G5L/KO8GooMOlf8fcq8V
 t75RXhiKmf+bn3sH0AYBYtKLi3q2jhRa/RQpy5AYfan7yvFFFKQqrH8wwvd+Vy6atRaf
 is1yTY0QYFtQXGVSI7EWg9vnv6exSx3VEEew5PE68sbe+WTEaviOQmbo8QaJLc2eaK7y
 HuNPjjSrWCxhDwki9gHeW6OEwhG/glGZEokkXpBsTQWHYr1m1cgxf2uOFGFRVK13vvp0
 MUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RW0lDqSJK11o5Hdo0ZTtiX38zMds7s0ivaE30jYDc08=;
 b=L689zOf21zq7bTBtiHmWMWjd518V4VCs3zCiMI+doOt7WY73gwcZElAY3JaEhSuItF
 7K8TJzcW0cG1+Sc2G2IR00KZTHOhQ95N+sjPEycbvVJupMqVhU7BnjMY+NPzRzt9aLjw
 FyknOkkLMqdV3rqBomv/NaqpO6fnzblnRop2dFKMvVrfn0rZVjAdLQOBE2kJfuzLgaux
 ZzRXyGd3H59ppAJcH7qoL/TLEZsIbdgIds6Z2mDCo0X4d8/lXsmPLt/ywK48UJsKV/ac
 4NBTnaGaJpnIxJHm6NivwogB9X83QeJEcIAmQZtsqY6uWSeIr70c1q/X4rBMdT73AO9x
 eUwQ==
X-Gm-Message-State: AOAM5307AA0PXZ2luhZKd0cDeGS03kp4yDU6iCgPWtmou3ytywLuR68c
 vzppnBEtOhM6sfhLzn57T+qjxbqkU6Uxu9t2ggg=
X-Google-Smtp-Source: ABdhPJw9vQiBpQRjhN/8CX+xAjLRplV+JVJIeCtYqBQQJnmgOmlExZLWBZV8I1M5wikJWFGCCY4w8C0bQqI+B6jfbXY=
X-Received: by 2002:a19:3c5:: with SMTP id 188mr6378736lfd.202.1607273263606; 
 Sun, 06 Dec 2020 08:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20201129035639.GW2532@mail-itl>
 <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
 <20201202000642.GJ201140@mail-itl> <20201204110847.GU201140@mail-itl>
 <20201204120803.GA20727@lst.de> <20201204122054.GV201140@mail-itl>
 <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
In-Reply-To: <20201205082839.ts3ju6yta46cgwjn@Air-de-Roger>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Sun, 6 Dec 2020 11:47:32 -0500
Message-ID: <CAKf6xpvdD-XJoRO91B+Lwc=0Sb6Luw2X8Y9sH_MQsAWhZmj+hw@mail.gmail.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201206_114747_882525_8D09BA75 
X-CRM114-Status: GOOD (  16.37  )
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
Cc: Juergen Gross <jgross@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 xen-devel <xen-devel@lists.xenproject.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBEZWMgNSwgMjAyMCBhdCAzOjI5IEFNIFJvZ2VyIFBhdSBNb25uw6kgPHJvZ2VyLnBh
dUBjaXRyaXguY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgRGVjIDA0LCAyMDIwIGF0IDAxOjIwOjU0
UE0gKzAxMDAsIE1hcmVrIE1hcmN6eWtvd3NraS1Hw7NyZWNraSB3cm90ZToKPiA+IE9uIEZyaSwg
RGVjIDA0LCAyMDIwIGF0IDAxOjA4OjAzUE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Ogo+ID4gPiBPbiBGcmksIERlYyAwNCwgMjAyMCBhdCAxMjowODo0N1BNICswMTAwLCBNYXJlayBN
YXJjenlrb3dza2ktR8OzcmVja2kgd3JvdGU6Cj4gPiA+ID4gY3VscHJpdDoKPiA+ID4gPgo+ID4g
PiA+IGNvbW1pdCA5ZTIzNjljMDZjOGExODE0NzgwMzkyNThhNDU5OGMxZGRkMmNhZGZhCj4gPiA+
ID4gQXV0aG9yOiBSb2dlciBQYXUgTW9ubmUgPHJvZ2VyLnBhdUBjaXRyaXguY29tPgo+ID4gPiA+
IERhdGU6ICAgVHVlIFNlcCAxIDEwOjMzOjI2IDIwMjAgKzAyMDAKPiA+ID4gPgo+ID4gPiA+ICAg
ICB4ZW46IGFkZCBoZWxwZXJzIHRvIGFsbG9jYXRlIHVucG9wdWxhdGVkIG1lbW9yeQo+ID4gPiA+
Cj4gPiA+ID4gSSdtIGFkZGluZyByZWxldmFudCBwZW9wbGUgYW5kIHhlbi1kZXZlbCB0byB0aGUg
dGhyZWFkLgo+ID4gPiA+IEZvciBjb21wbGV0ZW5lc3MsIGhlcmUgaXMgdGhlIG9yaWdpbmFsIGNy
YXNoIG1lc3NhZ2U6Cj4gPiA+Cj4gPiA+IFRoYXQgY29tbWl0IGRlZmluaXRpdmVseSBhZGRzIGEg
bmV3IFpPTkVfREVWSUNFIHVzZXIsIHNvIGl0IGRvZXMgbG9vawo+ID4gPiByZWxhdGVkLiAgQnV0
IHlvdSBhcmUgbm90IHJ1bm5pbmcgb24gWGVuLCBhcmUgeW91Pwo+ID4KPiA+IEkgYW0uIEl0IGlz
IFhlbiBkb20wLgo+Cj4gSSdtIGFmcmFpZCBJJ20gb24gbGVhdmUgYW5kIHdvbid0IGJlIGFibGUg
dG8gbG9vayBpbnRvIHRoaXMgdW50aWwgdGhlCj4gYmVnaW5uaW5nIG9mIEphbnVhcnkuIEkgd291
bGQgZ3Vlc3MgaXQncyBzb21lIGtpbmQgb2YgYmFkCj4gaW50ZXJhY3Rpb24gYmV0d2VlbiBibGti
YWNrIGFuZCBOVk1lIGRyaXZlcnMgYm90aCB1c2luZyBaT05FX0RFVklDRT8KPgo+IE1heWJlIHRo
ZSBiZXN0IGlzIHRvIHJldmVydCB0aGlzIGNoYW5nZSBhbmQgSSB3aWxsIGxvb2sgaW50byBpdCB3
aGVuCj4gSSBnZXQgYmFjaywgdW5sZXNzIHNvbWVvbmUgaXMgd2lsbGluZyB0byBkZWJ1ZyB0aGlz
IGZ1cnRoZXIuCgpMb29raW5nIGF0IGNvbW1pdCA5ZTIzNjljMDZjOGEgYW5kIHhlbi1ibGtiYWNr
IHB1dF9mcmVlX3BhZ2VzKCkgLCB0aGV5CmJvdGggdXNlIHBhZ2UtPmxydSB3aGljaCBpcyBwYXJ0
IG9mIHRoZSBhbm9ueW1vdXMgdW5pb24gc2hhcmVkIHdpdGgKKnBnbWFwLiAgVGhhdCBtYXRjaGVz
IE1hcmVrJ3Mgc3VzcGljaW9uIHRoYXQgdGhlIFpPTkVfREVWSUNFIG1lbW9yeSBpcwpiZWluZyB1
c2VkIGFzIFpPTkVfTk9STUFMLgoKbWVtbWFwX2luaXRfem9uZV9kZXZpY2UoKSBzYXlzOgoqIFpP
TkVfREVWSUNFIHBhZ2VzIHVuaW9uIC0+bHJ1IHdpdGggYSAtPnBnbWFwIGJhY2sgcG9pbnRlcgoq
IGFuZCB6b25lX2RldmljZV9kYXRhLiAgSXQgaXMgYSBidWcgaWYgYSBaT05FX0RFVklDRSBwYWdl
IGlzCiogZXZlciBmcmVlZCBvciBwbGFjZWQgb24gYSBkcml2ZXItcHJpdmF0ZSBsaXN0LgoKUmVn
YXJkcywKSmFzb24KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
