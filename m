Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77713C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B34920DD4
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="emS0Ci21";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucsc.edu header.i=@ucsc.edu header.b="ChZ+VoMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B34920DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ucsc.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gFoE17oA8ptVy3e2406gNiAqubuF4yC/G/7/Ltc24Ns=; b=emS0Ci21Ta0gI0
	9fFeD0bG4EpmbfLf/QccdUu4jPayfiGkpJSCSbRdURoy1xty7hwPgfnc6SOy1SxEGxTbgH1iF0i/w
	QwpO+VjM2EdNiS4Z0Cqp3LQYwStH5RTaBxFRJkbxdqZ1eEehreBuXj/+9+V0AfbkZ78LBi4e1nFiL
	GU717Qd3so0GGsMb+Ob5QyyHGAnSYp9vsw2tUM2bk5tzs/sKC1Y242mY4C0lzU5rOW6C3fgBabhjY
	3MusTD+IlJ2nrfKmuFqRtf2efkfG84xGttMgBtTl4EbOAsJ/8bsalI+N4+ALIZvtheBkhNV+He4V5
	eHd7b8Q9xAq1Xl5Zri6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLRT-0002Pc-9T; Fri, 19 Jun 2020 18:08:43 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLRQ-0002OQ-Vl
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:08:42 +0000
Received: by mail-oi1-x242.google.com with SMTP id a21so9212475oic.8
 for <linux-nvme@lists.infradead.org>; Fri, 19 Jun 2020 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsc.edu; s=ucsc-google-2018;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D3DT/dvyeplutPzx9MyRCxvTfOCv1fH0L/e2zdrU1Ts=;
 b=ChZ+VoMRW2BGAarmRuTatpQt+A2gEkWMBVqgXJQbdxvS/j/qrK6g25/SiVVsKmXji/
 +bMSnPiyyTYYOQ0ggSaV7+oDGigp9Ml1dXNICrLE9+rx+oh4USC6aACXJ/Sv7u2eCFFh
 kZclDbM2oLieqMEwbtoW7QLCkhhN40mapJV4kGCuWSZhfjXBCAwUaZXh3ubbmooiB+yQ
 GVCuUfEd7ZhVrf3WQd5s+QlsNsLZhMf5kHugGn/67c9r7Xza2Wk9L3FEiEwy/our4Pqe
 9cl83b50tBF/HBiba/3ldJLV/8qqrq4EZWio+jjwLwaePR3d9UEi21HZDd2DzsbDsPDF
 teog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D3DT/dvyeplutPzx9MyRCxvTfOCv1fH0L/e2zdrU1Ts=;
 b=U8Cnk1ABhLMfWp15zg+yu8YO+rDqGiNumMPk3ZmIqEdIz9xyIjPMphq/xaQxmkM7zB
 pUCnE+mGGnWmKPOiCrO7CSNkS72q7mqcPihBNU25yul2nSapXfAPokL7LzN16axBPQZj
 2RMJkJf0aVmV+s8Dg6Yx2zHfjaexKYtVTCdlSUxPBz4ASJnkmY8NeyqzUyYe0c3XqIgL
 GcoZRJShZdRLN9/ljka4V4d19HFU+iaG+tIX/7WAr2WYMEQ5ry1zDbrhSrU62gbUaIqj
 0R+rpYIbiPUCg67RO1jFDscI8j4FVWHXNVDVCXVpR/h6TFvjc11HYLhPTekgop6uuzlK
 DWQw==
X-Gm-Message-State: AOAM533lYxEtlTvLp++bkOxC0Q2F8QbaWl6vgN4i8ly6ecNzmystRZvE
 mQXFzIbeQAIAtw68lv0kSTD6PaM5dBa58smHSnIGpQ==
X-Google-Smtp-Source: ABdhPJyw4j4Q+v1uB8Pg2InuO2lrwXJPlBJJQTkw1GKIuJ75wkL37Vt92Kh2YqsyukJqYxXP2jT4LnMzUhmplwQ2634=
X-Received: by 2002:aca:d15:: with SMTP id 21mr3826252oin.41.1592590117336;
 Fri, 19 Jun 2020 11:08:37 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
From: Heiner Litz <hlitz@ucsc.edu>
Date: Fri, 19 Jun 2020 11:08:26 -0700
Message-ID: <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: Matias Bjorling <Matias.Bjorling@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_110841_055569_57D05FD8 
X-CRM114-Status: GOOD (  17.90  )
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
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgTWF0aWFzLApubywgSSBhbSByYXRoZXIgc2F5aW5nIHRoYXQgdGhlIExpbnV4IGtlcm5lbCBo
YXMgYSBkZWZpY2l0IG9yIGF0IGxlYXN0CmlzIG5vdCBhIGdvb2QgZml0IGZvciBaTlMgYmVjYXVz
ZSBpdCBjYW5ub3QgZW5mb3JjZSBpbi1vcmRlciBkZWxpdmVyeS4KVGhlIHJlcXVpcmVtZW50IG9m
IHNlcXVlbnRpYWwgd3JpdGVzIGJhc2ljYWxseSBpbXBvc2VzIHRoaXMKcmVxdWlyZW1lbnQuIEFw
cGVuZCBlc3NlbnRpYWxseSBhIExpbnV4IHNwZWNpZmljIGZpeCBvbiB0aGUgWk5TIGxldmVsCmFu
ZCB0aGF0IGVuZm9yY2luZyBvcmRlcmluZyB3b3VsZCBiZSBhIGNsZWFuZXIgd2F5IHRvIGVuYWJs
ZSBRRD4xLgoKT24gRnJpLCBKdW4gMTksIDIwMjAgYXQgMzoyOSBBTSBNYXRpYXMgQmpvcmxpbmcg
PE1hdGlhcy5Cam9ybGluZ0B3ZGMuY29tPiB3cm90ZToKPgo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPiA+IEZyb206IEhlaW5lciBMaXR6IDxobGl0ekB1Y3NjLmVkdT4KPiA+IFNlbnQ6
IEZyaWRheSwgMTkgSnVuZSAyMDIwIDAwLjA1Cj4gPiBUbzogS2VpdGggQnVzY2ggPGtidXNjaEBr
ZXJuZWwub3JnPgo+ID4gQ2M6IERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+
OyBKYXZpZXIgR29uesOhbGV6Cj4gPiA8amF2aWVyQGphdmlnb24uY29tPjsgTWF0aWFzIEJqw7hy
bGluZyA8bWJAbGlnaHRudm0uaW8+OyBNYXRpYXMgQmpvcmxpbmcKPiA+IDxNYXRpYXMuQmpvcmxp
bmdAd2RjLmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgS2VpdGggQnVzY2gK
PiA+IDxLZWl0aC5CdXNjaEB3ZGMuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBsaW51eC0KPiA+IGJsb2NrQHZnZXIua2VybmVsLm9yZzsgU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT47IEplbnMgQXhib2UKPiA+IDxheGJvZUBrZXJuZWwuZGs+OyBIYW5zIEhvbG1i
ZXJnIDxIYW5zLkhvbG1iZXJnQHdkYy5jb20+OyBEbWl0cnkKPiA+IEZvbWljaGV2IDxEbWl0cnku
Rm9taWNoZXZAd2RjLmNvbT47IEFqYXkgSm9zaGkgPEFqYXkuSm9zaGlAd2RjLmNvbT47Cj4gPiBB
cmF2aW5kIFJhbWVzaCA8QXJhdmluZC5SYW1lc2hAd2RjLmNvbT47IE5pa2xhcyBDYXNzZWwKPiA+
IDxOaWtsYXMuQ2Fzc2VsQHdkYy5jb20+OyBKdWR5IEJyb2NrIDxqdWR5LmJyb2NrQHNhbXN1bmcu
Y29tPgo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCA1LzVdIG52bWU6IHN1cHBvcnQgZm9yIHpvbmVk
IG5hbWVzcGFjZXMKPiA+Cj4gPiBNYXRpYXMsIEtlaXRoLAo+ID4gdGhhbmtzLCB0aGlzIGFsbCBz
b3VuZHMgZ29vZCBhbmQgaXQgbWFrZXMgdG90YWwgc2Vuc2UgdG8gaGlkZSBzdHJpcGluZyBmcm9t
IHRoZQo+ID4gdXNlci4KPiA+Cj4gPiBJbiB0aGUgZW5kLCB0aGUgcmVhbCBwcm9ibGVtIHJlYWxs
eSBzZWVtcyB0byBiZSB0aGF0IFpOUyBlZmZlY3RpdmVseSByZXF1aXJlcyBpbi0KPiA+IG9yZGVy
IElPIGRlbGl2ZXJ5IHdoaWNoIHRoZSBrZXJuZWwgY2Fubm90IGd1YXJhbnRlZS4gSSB0aGluayBm
aXhpbmcgdGhpcyBwcm9ibGVtCj4gPiBpbiB0aGUgWk5TIHNwZWNpZmljYXRpb24gaW5zdGVhZCBv
ZiBpbiB0aGUgY29tbXVuaWNhdGlvbiBzdWJzdHJhdGUgKGtlcm5lbCkgaXMKPiA+IHByb2JsZW1h
dGljLCBlc3BlY2lhbGx5IGFzIG91dC1vZi1vcmRlciBkZWxpdmVyeSBhYnNvbHV0ZWx5IGhhcyBu
byBiZW5lZml0IGluIHRoZQo+ID4gY2FzZSBvZiBaTlMuCj4gPiBCdXQgSSBndWVzcyB0aGlzIGhh
cyBiZWVuIGRpc2N1c3NlZCBiZWZvcmUuLgo+Cj4gSSdtIGEgYml0IGRlbnNlLCBieSB0aGUgYWJv
dmUsIGlzIHlvdXIgY29uY2x1c2lvbiB0aGF0IFpOUyBoYXMgYSBkZWZpY2l0L2ZlYXR1cmUsIHdo
aWNoIE9DU1NEIGRpZG4ndCBhbHJlYWR5IGhhdmU/IFRoZXkgYm90aCBoYWQgdGhlIHNhbWUgcmVx
dWlyZW1lbnQgdGhhdCBhIGNodW5rL3pvbmUgbXVzdCBiZSB3cml0dGVuIHNlcXVlbnRpYWxseS4g
SXQncyB0aGUgbmFtZSBvZiB0aGUgZ2FtZSB3aGVuIGRlcGxveWluZyBOQU5ELWJhc2VkIG1lZGlh
LCBJIGFtIG5vdCBzdXJlIGhvdyBaTlMgc2hvdWxkIGJlIGFibGUgdG8gaGVscCB3aXRoIHRoaXMu
IFRoZSBnb2FsIG9mIFpOUyBpcyB0byBhbGlnbiB3aXRoIHRoZSBtZWRpYSAoYW5kIE9DU1NEKSwg
d2hpY2ggbWFrZXMgd3JpdGVzIHJlcXVpcmVkIHRvIGJlIHNlcXVlbnRpYWwsIGFuZCBvbmUgdGhl
cmVieSBnZXRzIGEgYnVuY2ggb2YgYmVuZWZpdHMuCj4KPiBJZiB0aGVyZSB3YXMgYW4gdW5kZXJz
dGFuZGluZyB0aGF0IFpOUyB3b3VsZCBhbGxvdyBvbmUgdG8gd3JpdGUgcmFuZG9tbHksIEkgbXVz
dCBwcm9iYWJseSBkaXNhcHBvaW50LiBGb3IgcmFuZG9tIHdyaXRlcywgdHlwaWNhbCBpbXBsZW1l
bnRhdGlvbnMgZWl0aGVyIHVzZSBhIHdyaXRlLWJhY2sgc2NoZW1lLCB0aGF0IHN0b3JlcyBkYXRh
IGluIHJhbmRvbSB3cml0ZSBtZWRpYSBmaXJzdCwgYW5kIHRoZW4gbGF0ZXIgd3JpdGUgaXQgb3V0
IHNlcXVlbnRpYWxseSwgb3Igd3JpdGUgYSBob3N0LXNpZGUgRlRMICh3aXRoIGl0cyB1c3VhbCBv
dmVyaGVhZHMpLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
