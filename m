Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41687C2D0EE
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BE520848
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i66Ne9yU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ/zV+Jp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BE520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eQOdnZ2w/bV5S0O74iv+T5nUrjw69OKRR7TkS7jOqSY=; b=i66Ne9yU8x5dWI
	rstU+lbonZOSfSox1HqgWtYKY9h3VQDkkGrx/BkorUyxdk6vuNZVyV0xp21Dlbk9/qmr9pwFUCtQ6
	272om2mxSGiOBHZRx+QLRoBQZkSa1SFe0uIJBXyutYeJ0CXlAHHQ8/KgzIjyhlEPfKiR6vvGklM2h
	exndeqf+XcFUlbWYQ/2dwgRTRusak0h8RBZsXVksnPAlyWzECmuhAv6lqrCJeDPnkK1xmq3eQYH5m
	W/q25CN8u3Iq5r1+cSAz5d6dL/OOVGfMNa/1gC9FYtYv7N3tX/I/kFRMDB10mCRfq26mDZlrXcPVR
	yn4Nkh8yV0kuKBMeKFAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJ7N-0006Dk-NU; Tue, 31 Mar 2020 15:47:57 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJ7K-0006CN-3X
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:47:55 +0000
Received: by mail-qt1-x843.google.com with SMTP id t17so18673986qtn.12
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S+cb3bISW4bZmT92F1j7Pnq/uvLuSPQAD/l0XluG3es=;
 b=CZ/zV+JpODQPLEkTvr5bV1RtBpJRe9fHt7rTi1ZlaBgKVi9+wGb7JWDMSyVv0LFEsD
 o7PNPQNrt5OdGEe2WyyKKey7Y+vGvDbN3ZH4ABhpa4VnHcXwOIxT7GUBNx/KZLCkmWEk
 lrVuQgPUpgsHRfGXRvtQO3g0TW5D0OAiH81tJGPLzmcM0WGR4NBc/+UWiH2Z1VKmj6Gp
 mUinuOWxNArJRaIiJVjAmIbvhJuf9+2XxQZh8Bx8SBloKhJWEPzEszXl58bmi8CifTLw
 nT3J0bmpXMxgKhC6fTOKnt6huiA+8g/NT10Ysn2FSkTRzgZBVwIgHoorZyCh5XjndMoQ
 EmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S+cb3bISW4bZmT92F1j7Pnq/uvLuSPQAD/l0XluG3es=;
 b=o5TvnBTLgQPD0jXsLSyThGdHNR5wkJt4MKmgHZNFFfGb5lSr8OXH+2UV/mAalFhDJQ
 EsIVIGZ5grGBTjoCB3+Pmk3g4SrHTlw4AxuMNIC3jH61Ll238+d86rmFTFgVg6NyD2u5
 UemvVkET1nsHyc6ObonBObnlcqbmwlkKw1GCNSvQimquq3DfG5FnQsswcdezuacZsTjn
 AoqS8tsSGeAn/vgkQupoKTav2VjUeHRaLNt9cHZaYH3YKJhKdEIbrYYJlEvLQjjoxuHc
 pVoAuVa4a4NjZ8qt3x135uS/QkwvSfUNRAXP9IprNF4aosUT7DJfSUvXQGQGpcRCAMV3
 U5nw==
X-Gm-Message-State: ANhLgQ36CjIjTSFiNBFLBJVpAYPsnIyuD3DbuuLHc7bl0W6P9XzrXmEl
 +PfZref1HIz3Ev71jEkNEtZz3pLtfj92f3Kwi8Q=
X-Google-Smtp-Source: ADFU+vueFmwtyA1v+7pm/DjQa8uSCIHLcdiNP3fePAGUXFX+W1vqv3fkaAD0xsN2YQXUI2KJCFntt5b47zvPrwXIakg=
X-Received: by 2002:ac8:18c3:: with SMTP id o3mr5923041qtk.49.1585669672947;
 Tue, 31 Mar 2020 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1580786525.git.zhangweiping@didiglobal.com>
 <20200204154200.GA5831@redsun51.ssa.fujisawa.hgst.com>
 <CAA70yB5qAj8YnNiPVD5zmPrrTr0A0F3v2cC6t2S1Fb0kiECLfw@mail.gmail.com>
 <CAA70yB62_6JD_8dJTGPjnjJfyJSa1xqiCVwwNYtsTCUXQR5uCA@mail.gmail.com>
 <20200331143635.GS162390@mtj.duckdns.org>
In-Reply-To: <20200331143635.GS162390@mtj.duckdns.org>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Tue, 31 Mar 2020 23:47:41 +0800
Message-ID: <CAA70yB51=VQrL+2wC+DL8cYmGVACb2_w5UHc4XFn7MgZjUJaeg@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support Weighted Round Robin for blkcg and nvme
To: Tejun Heo <tj@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_084754_147971_2AC0F75D 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 cgroups@vger.kernel.org, Keith Busch <kbusch@kernel.org>, "Nadolski,
 Edmund" <edmund.nadolski@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPiDkuo4yMDIw5bm0M+aciDMx5pel5ZGo5LqMIOS4i+WN
iDEwOjM25YaZ6YGT77yaCj4KPiBIZWxsbywgV2VpcGluZy4KPgo+IE9uIFR1ZSwgTWFyIDMxLCAy
MDIwIGF0IDAyOjE3OjA2UE0gKzA4MDAsIFdlaXBpbmcgWmhhbmcgd3JvdGU6Cj4gPiBSZWNlbnRs
eSBJIGRvIHNvbWUgY2dyb3VwIGlvIHdlaWdodCB0ZXN0aW5nLAo+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2R1Ymxpby9pb3RyYWNrL3dpa2kvY2dyb3VwLWlvLXdlaWdodC10ZXN0Cj4gPiBJIHRoaW5r
IGEgcHJvcGVyIGlvIHdlaWdodCBwb2xpY3kKPiA+IHNob3VsZCBjb25zaWRlciBoaWdoIHdlaWdo
dCBjZ3JvdXAncyBpb3BzLCBsYXRlbmN5IGFuZCBhbHNvIHRha2Ugd2hvbGUKPiA+IGRpc2sncyB0
aHJvdWdocHV0Cj4gPiBpbnRvIGFjY291bnQsIHRoYXQgaXMgdG8gc2F5LCB0aGUgcG9saWN5IHNo
b3VsZCBkbyBtb3JlIGNhcmZ1bGx5IHRyYWRlCj4gPiBvZmYgYmV0d2VlbiBjZ3JvdXAncwo+ID4g
SU8gcGVyZm9ybWFuY2UgYW5kIHdob2xlIGRpc2sncyB0aHJvdWdocHV0LiBJIGtub3cgb25lIHBv
bGljeSBjYW5ub3QKPiA+IGRvIGFsbCB0aGluZ3MgcGVyZmVjdGx5LAo+ID4gYnV0IGZyb20gdGhl
IHRlc3QgcmVzdWx0IG52bWUtd3JyIGNhbiB3b3JrIHdlbGwuCj4KPiBUaGF0J3Mgdy9vIGlvY29z
dCBRb1MgdGFyZ2V0cyBjb25maWd1cmVkLCByaWdodD8gaW9jb3N0IHNob3VsZCBiZSBhYmxlIHRv
Cj4gYWNoaWV2ZSBzaW1pbGFyIHJlc3VsdHMgYXMgd3JyIHdpdGggUW9TIGNvbmZpZ3VyZWQuCj4K
WWVzLCBJIGhhdmUgbm90IHNldCBRb3MgdGFyZ2V0Lgo+ID4gRnJvbSB0aGUgZm9sbG93aW5nIHRl
c3QgcmVzdWx0LCBudm1lLXdyciB3b3JrIHdlbGwgZm9yIGJvdGggY2dyb3VwJ3MKPiA+IGxhdGVu
Y3ksIGlvcHMsIGFuZCB3aG9sZQo+ID4gZGlzaydzIHRocm91Z2hwdXQuCj4KPiBBcyBJIHdyb3Rl
IGJlZm9yZSwgdGhlIGlzc3VlcyBJIHNlZSB3aXRoIHdyciBhcmUgdGhlIGZvbGxvd2luZ3MuCj4K
PiAqIEhhcmR3YXJlIGRlcGVuZGVudC4gU29tZSB3aWxsIHdvcmsgb2sgb3IgZXZlbiBmYW50YXN0
aWMuIE1hbnkgb3RoZXJzIHdpbGwgZG8KPiAgIGhvcnJpYmx5Lgo+Cj4gKiBMYWNrIG9mIGNvbmZp
Z3VyYXRpb24gZ3JhbnVsYXJpdHkuIFdlIGNhbid0IGNvbmZpZ3VyZSBpdCBncmFudWxhciBlbm91
Z2ggdG8KPiAgIHNlcnZlIGhpZXJhcmNoaWNhbCBjb25maWd1cmF0aW9uLgo+Cj4gKiBMaWtlbHkg
bm90IGEgaHVnZSBwcm9ibGVtIHdpdGggdGhlIGRlZXAgUUQgb2YgbnZtZXMgYnV0IGxhY2sgb2Yg
cXVldWUgZGVwdGgKPiAgIGNvbnRyb2wgY2FuIGxlYWQgdG8gbG9zcyBvZiBsYXRlbmN5IGNvbnRy
b2wgYW5kIHRodXMgbG9zcyBvZiBwcm90ZWN0aW9uIGZvcgo+ICAgbG93IGNvbmN1cnJlbmN5IHdv
cmtsb2FkcyB3aGVuIHBpdGNoZWQgYWdhaW5zdCB3b3JrbG9hZHMgd2hpY2ggY2FuIHNhdHVyYXRl
Cj4gICBRRC4KPgo+IEFsbCB0aGF0IHNhaWQsIGdpdmVuIHRoZSBmZWF0dXJlIGlzIGF2YWlsYWJs
ZSwgSSBkb24ndCBzZWUgYW55IHJlYXNvbiB0byBub3QKPiBhbGxvdyB0byB1c2UgaXQsIGJ1dCBJ
IGRvbid0IHRoaW5rIGl0IGZpdHMgdGhlIGNncm91cCBpbnRlcmZhY2UgbW9kZWwgZ2l2ZW4gdGhl
Cj4gaGFyZHdhcmUgZGVwZW5kZW5jeSBhbmQgY29hcnNlIGdyYW51bGFyaXR5LiBGb3IgdGhlc2Ug
Y2FzZXMsIEkgdGhpbmsgdGhlIHJpZ2h0Cj4gdGhpbmcgdG8gZG8gaXMgdXNpbmcgY2dyb3VwcyB0
byBwcm92aWRlIHRhZ2dpbmcgaW5mb3JtYXRpb24gLSBpZS4gYnVpbGQgYQo+IGRlZGljYXRlZCBp
bnRlcmZhY2Ugd2hpY2ggdGFrZXMgY2dyb3VwIGZkIG9yIGlubyBhcyB0aGUgdGFnIGFuZCBhc3Nv
Y2lhdGUKPiBjb25maWd1cmF0aW9ucyB0aGF0IHdheS4gVGhlcmUgYWxyZWFkeSBhcmUgb3RoZXIg
dXNlIGNhc2VzIHdoaWNoIHVzZSBjZ3JvdXAgdGhpcwo+IHdheSAoZS5nLiBwZXJmKS4KPgpEbyB5
b3UgbWVhbnMgZHJvcCB0aGUgImlvLndyciIgb3IgImJsa2lvLndyciIgaW4gY2dyb3VwLCBhbmQg
dXNlIGEKZGVkaWNhdGVkIGludGVyZmFjZQpsaWtlIC9kZXYveHh4IG9yIC9wcm9jL3h4eD8KCkkg
c2VlIHRoZSBwZXJmIGNvZGU6CnN0cnVjdCBmZCBmID0gZmRnZXQoZmQpCnN0cnVjdCBjZ3JvdXBf
c3Vic3lzX3N0YXRlICpjc3MgPQpjc3NfdHJ5Z2V0X29ubGluZV9mcm9tX2RpcihmLmZpbGUtPmZf
cGF0aC5kZW50cnksCiAgICAgICAgJnBlcmZfZXZlbnRfY2dycF9zdWJzeXMpOwoKTG9va3MgY2Fu
IGJlIGFwcGxpZWQgdG8gYmxvY2sgY2dyb3VwIGluIHNhbWUgd2F5LgoKVGhhbmtzIHlvdXIgaGVs
cC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
