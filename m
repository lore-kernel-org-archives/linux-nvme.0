Return-Path: <SRS0=GXcx=5N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F8C43331
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 12:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CEC4206E6
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 12:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlRtpUyN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tv9lXVkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEC4206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4W/tlKjGSNPn9/dfak/MB2Xe1XMZVCNFt3VuSqLrmMc=; b=UlRtpUyNt0E9/3llcuF57Cd68
	yLPbgElYDG4qrnmUU7qdZ171aM1IOz0Ip8dwqIebqETErYCp/XLNs8xzOlaRisNhLz+j4Q25vQfB/
	HSNjLAgUCUd7ARSg3GKrMlHRolLthJ+LQkgTsx5/5Qhx1gUwB1zwgazJAevpu6Rlmt3RgNJUr6ex2
	CRDMbBCycRV8XXAbd0s70gwJ7/YMYPrJueEIo11WzzYXCz8vekBQW0zFG5aecw2JXhCCjpkx6Mpdb
	Yh3o8I1WTwgYJtQzg0QqfH828CGGxibibBL+vgY9r3lSLkLDiDtGQSvPj6Px5lJTUCx5CKpsomN4Z
	NsfwLCP+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIB23-0004F0-41; Sat, 28 Mar 2020 12:57:47 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIB1z-0004EF-SF
 for linux-nvme@lists.infradead.org; Sat, 28 Mar 2020 12:57:45 +0000
Received: by mail-pj1-x1043.google.com with SMTP id m15so4966195pje.3
 for <linux-nvme@lists.infradead.org>; Sat, 28 Mar 2020 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GPReoKNVZW+mzx3T797PiFAFYu6BaP2nNmpUKla68Y8=;
 b=tv9lXVkC+ylWkYm10Vy0+AAjz2f3GeF2nfhd4nwOzmX/P3HQ9pLSHdrVSxUZxufR2S
 e9YsRQyY6JZGyxoIEAkp6/7qJ3u8xciT+InNhKZ59leSmh2PsrGUKT5hJEnOn7XakQYG
 B8LqetvjnE/7AZvN5fhLHiR7u4U3LZPVl8k4fDo71AMaMmrLXjrxOCMZao6+MBszxt4u
 uSwTsSm2YgevyNzR9rtpBEws3ghr/RaMoYO6p84Gbmqlo70vtxfk6chHyA2rtLLn7Rg6
 CAOnr3VYwuHdl0pYw+Cm/Q6WU93XE354NOLDCiZ6s+GibPo5m2cGCe7/8uqFW51/Tjfz
 QzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=GPReoKNVZW+mzx3T797PiFAFYu6BaP2nNmpUKla68Y8=;
 b=mrjlL/aoTyo5qL8O12GjLbC5rnSRc9YY1RWtG8hoyH2dpRjUxwxVWqADIN/ba9C4QD
 XFdSZvbBvT1E9MYtTz/wOewp1V4VhkpEgVW30ax5dquLTVHeewdZCi16arRpTBF/kAr9
 yhoavxITDrRnPiV+kuYu3/asfKf+aKjqcuH08L+YpUrfWhCf1zWTMo3cK3n/8i+fvUIC
 TA+p48O/ZIv5tM6qPKsfopGpqigbEOa22lrv35qyYmy38tX3UQV/4vrnjvlhCSCzJCmr
 EIQkNBwluM8D6eo8Wssc74zUxB9CRhcWJq9k0PqIy2HaQoSSF4JdmbnMNQDifFvtIiEO
 i+xA==
X-Gm-Message-State: ANhLgQ0X5+Pl2241Up3tDexgCiV0hJA+11yIkjZYtrfmmpmz0tR9tG//
 vvwWobqnnLuhb5hYcJs6XoHT2FdI
X-Google-Smtp-Source: ADFU+vt1H+sT3LBgl23FZaghxrgRXDwrSVtsmvR1AFwXIyfiezqXNIKuAUM77ziyz1eIu10fW6Bbhw==
X-Received: by 2002:a17:90a:1acd:: with SMTP id
 p71mr5107202pjp.112.1585400262570; 
 Sat, 28 Mar 2020 05:57:42 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:5c8f:768a:547c:1376?
 ([240b:10:2720:5510:5c8f:768a:547c:1376])
 by smtp.gmail.com with ESMTPSA id y22sm6180923pfr.68.2020.03.28.05.57.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Mar 2020 05:57:42 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Ming Lei <tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
Date: Sat, 28 Mar 2020 21:57:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200328_055743_938197_5DFF6767 
X-CRM114-Status: GOOD (  18.75  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAyMDIwLzAzLzI4IDExOjExLCBNaW5nIExlaSB3cm90ZToKPiBPbiBTYXQsIE1hciAy
OCwgMjAyMCBhdCAyOjE4IEFNIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4gd3JvdGU6
Cj4+IE9uIFNhdCwgTWFyIDI4LCAyMDIwIGF0IDAyOjUwOjQzQU0gKzA5MDAsIFRva3Vub3JpIElr
ZWdhbWkgd3JvdGU6Cj4+PiBPbiAyMDIwLzAzLzI1IDE6NTEsIFRva3Vub3JpIElrZWdhbWkgd3Jv
dGU6Cj4+Pj4gT24gMjAyMC8wMy8yNCA5OjAyLCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+Pj4gV2Ug
ZGlkbid0IGhhdmUgMzItYml0IG1heCBzZWdtZW50cyBiZWZvcmUsIHRob3VnaC4gV2h5IHdhcyAx
Ni1iaXRzCj4+Pj4+IGVub3VnaCBpbiBvbGRlciBrZXJuZWxzPyBXaGljaCBrZXJuZWwgZGlkIHRo
aXMgc3RvcCB3b3JraW5nPwo+Pj4+IE5vdyBJIGFtIGFza2luZyB0aGUgZGV0YWlsIGluZm9ybWF0
aW9uIHRvIHRoZSByZXBvcnRlciBzbyBsZXQgbWUKPj4+PiB1cGRhdGUgbGF0ZXIuICBUaGF0IHdh
cyBhYmxlIHRvIHVzZSB0aGUgc2FtZSBjb21tYW5kIHNjcmlwdCB3aXRoIHRoZQo+Pj4+IGxhcmdl
IGRhdGEgbGVuZ3RoIGluIHRoZSBwYXN0Lgo+Pj4gSSBoYXZlIGp1c3QgY29uZmlybWVkIHRoZSBk
ZXRhaWwgc28gbGV0IG1lIHVwZGF0ZSBiZWxvdy4KPj4+Cj4+PiBUaGUgZGF0YSBsZW5ndGggMjAs
NTMxLDcxMiAoMHgxMzk0QTAwKSBpcyB1c2VkIG9uIGtlcm5lbCAzLjEwLjAgKENlbnRPUwo+Pj4g
NjRiaXQpLgo+Pj4gQWxzbyBpdCBpcyBmYWlsZWQgb24ga2VybmVsIDEwIDQuMTAuMCAoVWJ1bnR1
IDMyYml0KS4KPj4+IEJ1dCBqdXN0IGNvbmZpcm1lZCBpdCBhcyBzdWNjZWVkZWQgb24gYm90aCA0
LjE1LjAgKFVidW50dSAzMmJpdCkgYW5kIDQuMTUuMQo+Pj4gKFVidW50dSA2NGJpdCkuCj4+PiBT
byB0aGUgb3JpZ2luYWwgMjAsNTMxLDcxMiBsZW5ndGggZmFpbHVyZSBpc3N1ZSBzZWVtcyBhbHJl
YWR5IHJlc29sdmVkLgo+Pj4KPj4+IEkgdGVzdGVkIHRoZSBkYXRhIGxlbmd0aCAweDEwMDAwMDAw
ICgyNjgsNDM1LDQ1NikgYW5kIGl0IGlzIGZhaWxlZAo+Pj4gQnV0IG5vdyBjb25maXJtZWQgaXQg
YXMgZmFpbGVkIG9uIGFsbCB0aGUgYWJvdmUga2VybmVsIHZlcnNpb25zLgo+Pj4gQWxzbyB0aGUg
cGF0Y2ggZml4ZXMgb25seSB0aGlzIDB4MTAwMDAwMDAgbGVuZ3RoIGZhaWx1cmUgaXNzdWUuCj4+
IFRoaXMgaXMgYWN0dWFsbHkgZXZlbiBtb3JlIGNvbmZ1c2luZy4gV2UgZG8gbm90IHN1cHBvcnQg
MjU2TUIgdHJhbnNmZXJzCj4+IHdpdGhpbiBhIHNpbmdsZSBjb21tYW5kIGluIHRoZSBwY2kgbnZt
ZSBkcml2ZXIgYW55bW9yZS4gVGhlIG1heCBpcyA0TUIsCj4+IHNvIEkgZG9uJ3Qgc2VlIGhvdyBp
bmNyZWFzaW5nIHRoZSBtYXggc2VnbWVudHMgd2lsbCBoZWxwOiB5b3Ugc2hvdWxkIGJlCj4+IGhp
dHRpbmcgdGhlICdtYXhfc2VjdG9ycycgbGltaXQgaWYgeW91IGRvbid0IGhpdCB0aGUgc2VnbWVu
dCBsaW1pdCBmaXJzdC4KPiBUaGF0IGxvb2tzIGEgYnVnIGZvciBwYXNzdGhyb3VnaCByZXEsIGJl
Y2F1c2UgJ21heF9zZWN0b3JzJyBsaW1pdCBpcyBvbmx5Cj4gY2hlY2tlZCBpbiBiaW9fYWRkX3Bj
X3BhZ2UoKSwgbm90IGRvbmUgaW4gYmxrX3JxX2FwcGVuZF9iaW8oKSwgc29tZXRoaW5nCj4gbGlr
ZSB0aGUgZm9sbG93aW5nIHNlZW1zIHJlcXVpcmVkOgo+Cj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Js
ay1tYXAuYyBiL2Jsb2NrL2Jsay1tYXAuYwo+IGluZGV4IGIwNzkwMjY4ZWQ5ZC4uZTEyMGQ4MGI3
NWE1IDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2Jsay1tYXAuYwo+ICsrKyBiL2Jsb2NrL2Jsay1tYXAu
Ywo+IEBAIC0yMiw2ICsyMiwxMCBAQCBpbnQgYmxrX3JxX2FwcGVuZF9iaW8oc3RydWN0IHJlcXVl
c3QgKnJxLCBzdHJ1Y3QgYmlvICoqYmlvKQo+ICAgICAgICAgIHN0cnVjdCBiaW9fdmVjIGJ2Owo+
ICAgICAgICAgIHVuc2lnbmVkIGludCBucl9zZWdzID0gMDsKPgo+ICsgICAgICAgaWYgKCgocnEt
Pl9fZGF0YV9sZW4gKyAoKmJpbyktPmJpX2l0ZXIuYmlfc2l6ZSkgPj4gOSkgPgo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHF1ZXVlX21heF9od19zZWN0b3JzKHJxLT5xKSkKPiArICAgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKwoKSSBoYXZlIGp1c3QgY29uZmlybWVkIGFib3V0IHRo
ZSBtYXhfaHdfc2VjdG9ycyBjaGVja2luZyBiZWxvdy4KSXQgaXMgY2hlY2tlZCBieSB0aGUgZnVu
Y3Rpb24gYmxrX3JxX21hcF9rZXJuKCkgYWxzbyBhcyBiZWxvdy4KCiDCoMKgwqAgaWYgKGxlbiA+
IChxdWV1ZV9tYXhfaHdfc2VjdG9ycyhxKSA8PCA5KSkKIMKgwqDCoCDCoMKgwqAgcmV0dXJuIC1F
SU5WQUw7CgpUaGUgZnVuY3Rpb24gY2FsbHMgYmxrX3JxX2FwcGVuZF9iaW8oKS4KU28gdGhlIG1h
eF9od19zZWN0b3JzIHdpbGwgYmUgdXNlZCB0byBjaGVjayB0aGUgbGVuZ3RoIHdpdGggdGhlIGNo
YW5nZSAKYWJvdmUuCkJ1dCBpdCBzZWVtcyB0aGF0IHRoZXJlIGlzIGEgZGlmZmVyZW5jZSBhbHNv
IGZvciB0aGUgY2hlY2tpbmcgbGltaXQgCmNvbmRpdGlvbi4KCkl0IHNlZW1zIHRoYXQgaXQgaXMg
YmV0dGVyIHRvIGNoZWNrIHRoZSBsaW1pdCBieSBibGtfcnFfbWFwX3VzZXIoKSAKaW5zdGVhZCBv
ZiBibGtfcnFfYXBwZW5kX2JpbygpLgpPciBpdCBjYW4gYmUgY2hhbmdlZCB0byBjaGVjayB0aGUg
bGltaXQgYnkgYmxrX3JxX2FwcGVuZF9iaW8oKSBvbmx5IAp3aXRob3V0IGJsa19ycV9tYXBfa2Vy
bigpLgoKUmVnYXJkcywKSWtlZ2FtaQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK
