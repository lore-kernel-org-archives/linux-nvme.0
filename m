Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798CAC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 02:56:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154CA64D9F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 02:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154CA64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ik5Tf9VkEz+kahQ30RHhfHnGz69+argFvxIEJGWR7q0=; b=QC7Ih5BdA3box5BzA3giMhpPq
	Hssc5uWtKRx4BsMzMJH1Qgir1449MD5VRAQRS+Ri+q8W3DnQkf04ikuoCxmBXcQ9yzGTjwsgnVtLc
	0VTg0o4b+mBlWMNCBZXawcwTs8kkc9wAb8tbSmW/Rw3GGkGq4ZwUQR5tdMVm/lSFZ4YnVeX08fhlp
	Kzno9bz4BjcpcXaSWvGeobUw6NKrA6aoHyvbYQ9RKX/sWXoAcopTag8PeTu/Y/50UkoNlICeiixr5
	ddy4/k72asI7A0PcpY6mi7dlvyndmpAuMP5nVLS70XRWbbps0vQaB4ED1JErx61IGHr/744c3U7iC
	g85au2cNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMMM6-002Jd6-Fj; Wed, 17 Mar 2021 02:56:18 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMMM0-002JZr-4g
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 02:56:15 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F0ZVj5n8hz5Vn9;
 Wed, 17 Mar 2021 10:54:05 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 10:55:58 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 17
 Mar 2021 10:55:58 +0800
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
Date: Wed, 17 Mar 2021 10:55:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_025612_791457_2103BF9A 
X-CRM114-Status: GOOD (  18.08  )
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

CgpPbiAyMDIxLzMvMTcgNzo1MSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBUaGVzZSBw
YXRjaGVzIG9uIHRoZWlyIG93biBhcmUgY29ycmVjdCBiZWNhdXNlIHRoZXkgZml4ZWQgYSBjb250
cm9sbGVyIHJlc2V0Cj4+Pj4gcmVncmVzc2lvbi4KPj4+Pgo+Pj4+IFdoZW4gd2UgcmVzZXQvdGVh
cmRvd24gYSBjb250cm9sbGVyLCB3ZSBtdXN0IGZyZWV6ZSBhbmQgcXVpZXNjZSB0aGUgbmFtZXNw
YWNlcwo+Pj4+IHJlcXVlc3QgcXVldWVzIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIHNhZmVseSBzdG9w
IGluZmxpZ2h0IEkvTyBzdWJtaXNzaW9ucy4KPj4+PiBGcmVlemUgaXMgbWFuZGF0b3J5IGJlY2F1
c2UgaWYgb3VyIGhjdHggbWFwIGNoYW5nZWQgYmV0d2VlbiByZWNvbm5lY3RzLAo+Pj4+IGJsa19t
cV91cGRhdGVfbnJfaHdfcXVldWVzIHdpbGwgaW1tZWRpYXRlbHkgYXR0ZW1wdCB0byBmcmVlemUg
dGhlIHF1ZXVlLCBhbmQKPj4+PiBpZiBpdCBzdGlsbCBoYXMgcGVuZGluZyBzdWJtaXNzaW9ucyAo
dGhhdCBhcmUgc3RpbGwgcXVpZXNjZWQpIGl0IHdpbGwgaGFuZy4KPj4+PiBUaGlzIGlzIHdoYXQg
dGhlIGFib3ZlIHBhdGNoZXMgZml4ZWQuCj4+Pj4KPj4+PiBIb3dldmVyLCBieSBmcmVlemluZyB0
aGUgbmFtZXNwYWNlcyByZXF1ZXN0IHF1ZXVlcywgYW5kIG9ubHkgdW5mcmVlemluZyB0aGVtCj4+
Pj4gd2hlbiB3ZSBzdWNjZXNzZnVsbHkgcmVjb25uZWN0LCBpbmZsaWdodCBzdWJtaXNzaW9ucyB0
aGF0IGFyZSBydW5uaW5nCj4+Pj4gY29uY3VycmVudGx5IGNhbiBub3cgYmxvY2sgZ3JhYmJpbmcg
dGhlIG5zaGVhZCBzcmN1IHVudGlsIGVpdGhlciB3ZSBzdWNjZXNzZnVsbHkKPj4+PiByZWNvbm5l
Y3Qgb3IgY3RybF9sb3NzX3RtbyBleHBpcmVkIChvciB0aGUgdXNlciBleHBsaWNpdGx5IGRpc2Nv
bm5lY3RlZCkuCj4+Pj4KPj4+PiBUaGlzIGNhdXNlZCBhIGRlYWRsb2NrIFsxXSB3aGVuIGEgZGlm
ZmVyZW50IGNvbnRyb2xsZXIgKGRpZmZlcmVudCBwYXRoIG9uIHRoZQo+Pj4+IHNhbWUgc3Vic3lz
dGVtKSBiZWNhbWUgbGl2ZSAoaS5lLiBvcHRpbWl6ZWQvbm9uLW9wdGltaXplZCkuIFRoaXMgaXMg
YmVjYXVzZQo+Pj4+IG52bWVfbXBhdGhfc2V0X2xpdmUgbmVlZHMgdG8gc3luY2hyb25pemUgdGhl
IG5zaGVhZCBzcmN1IGJlZm9yZSByZXF1ZXVlaW5nIEkvTwo+Pj4+IGluIG9yZGVyIHRvIG1ha2Ug
c3VyZSB0aGF0IGN1cnJlbnRfcGF0aCBpcyB2aXNpYmxlIHRvIGZ1dHVyZSAocmUpc3VibWlzaW9u
cy4KPj4+PiBIb3dldmVyIHRoZSBzcmN1IGxvY2sgaXMgdGFrZW4gYnkgYSBibG9ja2VkIHN1Ym1p
c3Npb24gb24gYSBmcm96ZW4gcmVxdWVzdAo+Pj4+IHF1ZXVlLCBhbmQgd2UgaGF2ZSBhIGRlYWRs
b2NrLgo+Pj4+Cj4+Pj4gRm9yIG11bHRpcGF0aCwgd2Ugb2J2aW91c2x5IGNhbm5vdCBhbGxvdyB0
aGF0IGFzIHdlIHdhbnQgdG8gZmFpbG92ZXIgSS9PIGFzYXAuCj4+Pj4gSG93ZXZlciBmb3Igbm9u
LW1wYXRoLCB3ZSBkbyBub3Qgd2FudCB0byBmYWlsIEkvTyAoYXQgbGVhc3QgdW50aWwgY29udHJv
bGxlcgo+Pj4+IEZBU1RGQUlMIGV4cGlyZXMsIGFuZCB0aGF0IGlzIGRpc2FibGVkIGJ5IGRlZmF1
bHQgYnR3KS4KPj4+Pgo+Pj4+IFRoaXMgY3JlYXRlcyBhIG5vbi1zeW1tZXRyaWMgYmVoYXZpb3Ig
b2YgaG93IHRoZSBkcml2ZXIgc2hvdWxkIGJlaGF2ZSBpbiB0aGUKPj4+PiBwcmVzZW5jZSBvciBh
YnNlbmNlIG9mIG11bHRpcGF0aC4KPj4+Pgo+Pj4+IFsxXToKPj4+PiBXb3JrcXVldWU6IG52bWUt
d3EgbnZtZV90Y3BfcmVjb25uZWN0X2N0cmxfd29yayBbbnZtZV90Y3BdCj4+Pj4gQ2FsbCBUcmFj
ZToKPj4+PiDCoMKgIF9fc2NoZWR1bGUrMHgyOTMvMHg3MzAKPj4+PiDCoMKgIHNjaGVkdWxlKzB4
MzMvMHhhMAo+Pj4+IMKgwqAgc2NoZWR1bGVfdGltZW91dCsweDFkMy8weDJmMAo+Pj4+IMKgwqAg
d2FpdF9mb3JfY29tcGxldGlvbisweGJhLzB4MTQwCj4+Pj4gwqDCoCBfX3N5bmNocm9uaXplX3Ny
Y3UucGFydC4yMSsweDkxLzB4YzAKPj4+PiDCoMKgIHN5bmNocm9uaXplX3NyY3VfZXhwZWRpdGVk
KzB4MjcvMHgzMAo+Pj4+IMKgwqAgc3luY2hyb25pemVfc3JjdSsweGNlLzB4ZTAKPj4+PiDCoMKg
IG52bWVfbXBhdGhfc2V0X2xpdmUrMHg2NC8weDEzMCBbbnZtZV9jb3JlXQo+Pj4+IMKgwqAgbnZt
ZV91cGRhdGVfbnNfYW5hX3N0YXRlKzB4MmMvMHgzMCBbbnZtZV9jb3JlXQo+Pj4+IMKgwqAgbnZt
ZV91cGRhdGVfYW5hX3N0YXRlKzB4Y2QvMHhlMCBbbnZtZV9jb3JlXQo+Pj4+IMKgwqAgbnZtZV9w
YXJzZV9hbmFfbG9nKzB4YTEvMHgxODAgW252bWVfY29yZV0KPj4+PiDCoMKgIG52bWVfcmVhZF9h
bmFfbG9nKzB4NzYvMHgxMDAgW252bWVfY29yZV0KPj4+PiDCoMKgIG52bWVfbXBhdGhfaW5pdCsw
eDEyMi8weDE4MCBbbnZtZV9jb3JlXQo+Pj4+IMKgwqAgbnZtZV9pbml0X2lkZW50aWZ5KzB4ODBl
LzB4ZTIwIFtudm1lX2NvcmVdCj4+Pj4gwqDCoCBudm1lX3RjcF9zZXR1cF9jdHJsKzB4MzU5LzB4
NjYwIFtudm1lX3RjcF0KPj4+PiDCoMKgIG52bWVfdGNwX3JlY29ubmVjdF9jdHJsX3dvcmsrMHgy
NC8weDcwIFtudm1lX3RjcF0KPj4+Pgo+Pj4+Cj4+Pj4gSW4gb3JkZXIgdG8gZml4IHRoaXMsIHdl
IHJlY29nbml6ZSB0aGUgZGlmZmVyZW50IGJlaGF2aW9yIGEgZHJpdmVyIG5lZWRzIHRvIHRha2UK
Pj4+PiBpbiBlcnJvciByZWNvdmVyeSBzY2VuYXJpb3MgZm9yIG1wYXRoIGFuZCBub24tbXBhdGgg
c2NlbmFyaW9zIGFuZCBleHBvc2UgdGhpcwo+Pj4+IGF3YXJlbmVzcyB3aXRoIGEgbmV3IGhlbHBl
ciBudm1lX2N0cmxfaXNfbXBhdGggYW5kIHVzZSB0aGF0IHRvIGtub3cgd2hhdCBuZWVkcwo+Pj4+
IHRvIGJlIGRvbmUuCj4+Pgo+Pj4gQ2hyaXN0b3BoLCBLZWl0aCwKPj4+Cj4+PiBBbnkgdGhvdWdo
dHMgb24gdGhpcz8gVGhlIFJGQyBwYXJ0IGlzIGdldHRpbmcgdGhlIHRyYW5zcG9ydCBkcml2ZXIg
dG8KPj4+IGJlaGF2ZSBkaWZmZXJlbnRseSBmb3IgbXBhdGggdnMuIG5vbi1tcGF0aC4KPj4KPj4g
V2lsbCBpdCB3b3JrIGlmIG52bWUgbXBhdGggdXNlZCByZXF1ZXN0IE5PV0FJVCBmbGFnIGZvciBp
dHMgc3VibWl0X2JpbygpCj4+IGNhbGwsIGFuZCBhZGQgdGhlIGJpbyB0byB0aGUgcmVxdWV1ZV9s
aXN0IGlmIGJsa19xdWV1ZV9lbnRlcigpIGZhaWxzPyBJCj4+IHRoaW5rIHRoYXQgbG9va3MgbGlr
ZSBhbm90aGVyIHdheSB0byByZXNvbHZlIHRoZSBkZWFkbG9jaywgYnV0IHdlIG5lZWQKPj4gdGhl
IGJsb2NrIGxheWVyIHRvIHJldHVybiBhIGZhaWxlZCBzdGF0dXMgdG8gdGhlIG9yaWdpbmFsIGNh
bGxlci4KPiAKPiBCdXQgd2hvIHdvdWxkIGtpY2sgdGhlIHJlcXVldWUgbGlzdD8gYW5kIHRoYXQg
d291bGQgbWFrZSBuZWFyLXRhZy1leGhhdXN0IHBlcmZvcm1hbmNlIHN0aW5rLi4uCm1vdmluZyBu
dm1lX3N0YXJ0X2ZyZWV6ZSBmcm9tIG52bWVfcmRtYV90ZWFyZG93bl9pb19xdWV1ZXMgdG8gbnZt
ZV9yZG1hX2NvbmZpZ3VyZV9pb19xdWV1ZXMgY2FuIGZpeCBpdC4KSXQgY2FuIGFsc28gYXZvaWQg
SS9PIGhhbmcgbG9uZyB0aW1lIGlmIHJlY29ubmVjdGlvbiBmYWlsZWQuCj4gCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1udm1lIG1haWxp
bmcgbGlzdAo+IExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo+IC4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
