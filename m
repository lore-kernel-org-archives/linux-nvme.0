Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B2EC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016232073E
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CFAp9kXG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="hz+PQhL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016232073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7NITjuI+TgupZfob94JxcqEi1mYVUrZQqzpxqi2n2y0=; b=CFAp9kXGTrRjwOhjFep+hIznX
	/tAwI1l3mUVjMzkKgLYL/vX795Tv87o3XUCaxRHx9AoWe8a9OLGVdPHnTapes9l8wfdE9scDp2z/B
	1doBxFb3AOO/Xzs/pwznqv+8wWdFpli0mYIXkEt/icMvras8r5myOwEhpC6aCFPYJko6FGjAgmfbP
	XDFHC61je9WMMmOHMn8XUxQqxkEsRNoOXYrK2eRN4ZtZLPhEQ36Eq3lJuNGQgis04r+JmF4DRI7D8
	ceTnnJs5xkxEKE6MXd8rdpnXeaIzmADzuku98EpDeLbIiY/HUs/N2L3fbdR15ioosfh6brXx3MlXi
	pnMu2eUqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLad-0000Vs-L3; Fri, 19 Jun 2020 18:18:11 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLab-0000VG-6i
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:18:10 +0000
Received: by mail-wr1-x444.google.com with SMTP id h5so10607479wrc.7
 for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2020 11:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=uSHyt+KgUL6oeZLDkopz6kV5K86NXo1Z0JT3bWX80Sk=;
 b=hz+PQhL1kg7yhiBjKzV/pzggk3f78kbitti7zEDgzXMHlHn/0MVzv1u0y+JpkQz0St
 mov2LRpX1C18LR69WVFcFF79bPOuuWULbN2NjzkGjWHpwkwGqD6S1trHIT1EMnsv4ZnZ
 9YLQ7iTDMaA5AAdgmlu92ds0pb0x7JFA9Oi6OQK0SgOBREoc2wH63hxMOZOleDNmpTmW
 AfQF7x053LHHU3pEg7DVTdHK53GI6Mivj2TcNm7XcMHSzzTgDhPm4hp5o8se0jb/JUA+
 DRoQ1PJZmm43V3GI1VK+Sf61Z3Yryzpp+G8iQlVdyDh1P400XqE8JenEzZldDy2k6+R2
 HiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uSHyt+KgUL6oeZLDkopz6kV5K86NXo1Z0JT3bWX80Sk=;
 b=cIRFMPkO28rKROkGdP8naZWhSJ1I1KWjFANypsQxqqic0KSNpBV9TQjMDFGzwkRn8T
 BnkU1J/c2JYdLEu/0LbEo12ubjTKhtOUTYvRlHi/U8oLjF+eCH8byX4K0I66A7hhJPoB
 qG0GDOJhYEquXZ/upMf6wQYk6xc5MJIFov/S4fIK9Q9m93tIXJJXRxhQ2JhwxEko+ih5
 Uc6M6ICHWM3dlZt/uqO4a79an6HZCmQ4EqN6ClryUc5DenXQhCo/23ISh2gI3q8OiKLF
 ajrs29izVr+FM7BuDonJ4QrP57C/hZtZmvvzoCg8QLTZ3hyyv7M/KhWyEtY4Z55+0trA
 hIVQ==
X-Gm-Message-State: AOAM533tknfqKJrFM7EOuXzm/LevclhNxkgYMTYeSTdCc8xIbCdyx17I
 jC9S+YpUyuKkmITxBAjpM44B2lfHo4fo8Q==
X-Google-Smtp-Source: ABdhPJxEwzbXT40sCVi2vQr63v9sKxYr7ssYfouZwmT+qG/Zp8dBu0I32P+75PsfRmPLlCumkY8sBA==
X-Received: by 2002:adf:f507:: with SMTP id q7mr5297216wro.353.1592590687910; 
 Fri, 19 Jun 2020 11:18:07 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id e5sm5803237wrs.33.2020.06.19.11.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 11:18:07 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Heiner Litz <hlitz@ucsc.edu>, Matias Bjorling <Matias.Bjorling@wdc.com>
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <da284d55-dea6-b51c-4bd0-40e119b5a733@lightnvm.io>
Date: Fri, 19 Jun 2020 20:18:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_111809_315644_C00F2C1E 
X-CRM114-Status: GOOD (  18.53  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTkvMDYvMjAyMCAyMC4wOCwgSGVpbmVyIExpdHogd3JvdGU6Cj4gSGkgTWF0aWFzLAo+IG5v
LCBJIGFtIHJhdGhlciBzYXlpbmcgdGhhdCB0aGUgTGludXgga2VybmVsIGhhcyBhIGRlZmljaXQg
b3IgYXQgbGVhc3QKPiBpcyBub3QgYSBnb29kIGZpdCBmb3IgWk5TIGJlY2F1c2UgaXQgY2Fubm90
IGVuZm9yY2UgaW4tb3JkZXIgZGVsaXZlcnkuCj4gVGhlIHJlcXVpcmVtZW50IG9mIHNlcXVlbnRp
YWwgd3JpdGVzIGJhc2ljYWxseSBpbXBvc2VzIHRoaXMKPiByZXF1aXJlbWVudC4gQXBwZW5kIGVz
c2VudGlhbGx5IGEgTGludXggc3BlY2lmaWMgZml4IG9uIHRoZSBaTlMgbGV2ZWwKPiBhbmQgdGhh
dCBlbmZvcmNpbmcgb3JkZXJpbmcgd291bGQgYmUgYSBjbGVhbmVyIHdheSB0byBlbmFibGUgUUQ+
MS4KCkFoLCBJIGFtIG5vdCBzdXJlIEkgYWdyZWUgd2l0aCB0aGF0IHN0YXRlbWVudC4gQXMgS2Vp
dGggcG9pbnRzIG91dCwgCnRoZXJlIGlzIG5vdCBldmVuIGluLW9yZGVyIGRlbGl2ZXJ5IGluIE5W
TWUuIEFueSBzeXN0ZW0gd2hlcmUgaGlnaCAKcGVyZm9ybWFuY2UgaXMgcmVxdWlyZWQsIGhhcyBv
dXQgb2Ygb3JkZXIgbWVjaGFuaXNtcyB0aGF0IGltcHJvdmVzIApwYXJhbGxlbGlzbSBhbmQgcGVy
Zm9ybWFuY2UuIElmIG9uZSB3YW50cyB0byBpc3N1ZSBJL09zIGluIG9yZGVyLCBpdCBpcyAKYXMg
ZWFzeSBhcyBzdXBwbHlpbmcgYSB3cml0ZS1iYWNrIGNhY2hlLiBMaW51eCBhbmQgYW55IG90aGVy
IHN5c3RlbXMgYXJlIAphYmxlIHRvIGRvIHRoYXQuCgo+IE9uIEZyaSwgSnVuIDE5LCAyMDIwIGF0
IDM6MjkgQU0gTWF0aWFzIEJqb3JsaW5nIDxNYXRpYXMuQmpvcmxpbmdAd2RjLmNvbT4gd3JvdGU6
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogSGVpbmVyIExpdHogPGhs
aXR6QHVjc2MuZWR1Pgo+Pj4gU2VudDogRnJpZGF5LCAxOSBKdW5lIDIwMjAgMDAuMDUKPj4+IFRv
OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+Cj4+PiBDYzogRGFtaWVuIExlIE1vYWwg
PERhbWllbi5MZU1vYWxAd2RjLmNvbT47IEphdmllciBHb256w6FsZXoKPj4+IDxqYXZpZXJAamF2
aWdvbi5jb20+OyBNYXRpYXMgQmrDuHJsaW5nIDxtYkBsaWdodG52bS5pbz47IE1hdGlhcyBCam9y
bGluZwo+Pj4gPE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPjsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhj
aEBsc3QuZGU+OyBLZWl0aCBCdXNjaAo+Pj4gPEtlaXRoLkJ1c2NoQHdkYy5jb20+OyBsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQo+Pj4gYmxvY2tAdmdlci5rZXJuZWwub3Jn
OyBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgSmVucyBBeGJvZQo+Pj4gPGF4Ym9l
QGtlcm5lbC5kaz47IEhhbnMgSG9sbWJlcmcgPEhhbnMuSG9sbWJlcmdAd2RjLmNvbT47IERtaXRy
eQo+Pj4gRm9taWNoZXYgPERtaXRyeS5Gb21pY2hldkB3ZGMuY29tPjsgQWpheSBKb3NoaSA8QWph
eS5Kb3NoaUB3ZGMuY29tPjsKPj4+IEFyYXZpbmQgUmFtZXNoIDxBcmF2aW5kLlJhbWVzaEB3ZGMu
Y29tPjsgTmlrbGFzIENhc3NlbAo+Pj4gPE5pa2xhcy5DYXNzZWxAd2RjLmNvbT47IEp1ZHkgQnJv
Y2sgPGp1ZHkuYnJvY2tAc2Ftc3VuZy5jb20+Cj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNV0g
bnZtZTogc3VwcG9ydCBmb3Igem9uZWQgbmFtZXNwYWNlcwo+Pj4KPj4+IE1hdGlhcywgS2VpdGgs
Cj4+PiB0aGFua3MsIHRoaXMgYWxsIHNvdW5kcyBnb29kIGFuZCBpdCBtYWtlcyB0b3RhbCBzZW5z
ZSB0byBoaWRlIHN0cmlwaW5nIGZyb20gdGhlCj4+PiB1c2VyLgo+Pj4KPj4+IEluIHRoZSBlbmQs
IHRoZSByZWFsIHByb2JsZW0gcmVhbGx5IHNlZW1zIHRvIGJlIHRoYXQgWk5TIGVmZmVjdGl2ZWx5
IHJlcXVpcmVzIGluLQo+Pj4gb3JkZXIgSU8gZGVsaXZlcnkgd2hpY2ggdGhlIGtlcm5lbCBjYW5u
b3QgZ3VhcmFudGVlLiBJIHRoaW5rIGZpeGluZyB0aGlzIHByb2JsZW0KPj4+IGluIHRoZSBaTlMg
c3BlY2lmaWNhdGlvbiBpbnN0ZWFkIG9mIGluIHRoZSBjb21tdW5pY2F0aW9uIHN1YnN0cmF0ZSAo
a2VybmVsKSBpcwo+Pj4gcHJvYmxlbWF0aWMsIGVzcGVjaWFsbHkgYXMgb3V0LW9mLW9yZGVyIGRl
bGl2ZXJ5IGFic29sdXRlbHkgaGFzIG5vIGJlbmVmaXQgaW4gdGhlCj4+PiBjYXNlIG9mIFpOUy4K
Pj4+IEJ1dCBJIGd1ZXNzIHRoaXMgaGFzIGJlZW4gZGlzY3Vzc2VkIGJlZm9yZS4uCj4+IEknbSBh
IGJpdCBkZW5zZSwgYnkgdGhlIGFib3ZlLCBpcyB5b3VyIGNvbmNsdXNpb24gdGhhdCBaTlMgaGFz
IGEgZGVmaWNpdC9mZWF0dXJlLCB3aGljaCBPQ1NTRCBkaWRuJ3QgYWxyZWFkeSBoYXZlPyBUaGV5
IGJvdGggaGFkIHRoZSBzYW1lIHJlcXVpcmVtZW50IHRoYXQgYSBjaHVuay96b25lIG11c3QgYmUg
d3JpdHRlbiBzZXF1ZW50aWFsbHkuIEl0J3MgdGhlIG5hbWUgb2YgdGhlIGdhbWUgd2hlbiBkZXBs
b3lpbmcgTkFORC1iYXNlZCBtZWRpYSwgSSBhbSBub3Qgc3VyZSBob3cgWk5TIHNob3VsZCBiZSBh
YmxlIHRvIGhlbHAgd2l0aCB0aGlzLiBUaGUgZ29hbCBvZiBaTlMgaXMgdG8gYWxpZ24gd2l0aCB0
aGUgbWVkaWEgKGFuZCBPQ1NTRCksIHdoaWNoIG1ha2VzIHdyaXRlcyByZXF1aXJlZCB0byBiZSBz
ZXF1ZW50aWFsLCBhbmQgb25lIHRoZXJlYnkgZ2V0cyBhIGJ1bmNoIG9mIGJlbmVmaXRzLgo+Pgo+
PiBJZiB0aGVyZSB3YXMgYW4gdW5kZXJzdGFuZGluZyB0aGF0IFpOUyB3b3VsZCBhbGxvdyBvbmUg
dG8gd3JpdGUgcmFuZG9tbHksIEkgbXVzdCBwcm9iYWJseSBkaXNhcHBvaW50LiBGb3IgcmFuZG9t
IHdyaXRlcywgdHlwaWNhbCBpbXBsZW1lbnRhdGlvbnMgZWl0aGVyIHVzZSBhIHdyaXRlLWJhY2sg
c2NoZW1lLCB0aGF0IHN0b3JlcyBkYXRhIGluIHJhbmRvbSB3cml0ZSBtZWRpYSBmaXJzdCwgYW5k
IHRoZW4gbGF0ZXIgd3JpdGUgaXQgb3V0IHNlcXVlbnRpYWxseSwgb3Igd3JpdGUgYSBob3N0LXNp
ZGUgRlRMICh3aXRoIGl0cyB1c3VhbCBvdmVyaGVhZHMpLgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
