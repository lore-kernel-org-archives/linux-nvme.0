Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA100C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 20:03:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485DF60ED7
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 20:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 485DF60ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vlnb.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FolkNxEuMHhFjPleh6PgzJp3toM8veqD3vLrenoPl/w=; b=BS6+Rl1UASjVs2ricrQ8EMJ0RO
	3bluj7xFFf2gS/TLXEvQ21d33LSNHK8sii6O5Z3ephCQ2BblgTebD4VJ1e+FYu8kY7HH6GNTCY5Cs
	Il4FuXxyLah37ErtOcRkgUmO9S4yyAnREcaQiuqMtlvjBmOMD4VSPErcRgEbuP92on3PZFcv4udM0
	VutHB7tTz0eSpVZwyRX7/CifY6hHWMLykM3Fl1WGW859pFfr2I/yQ37YBaI23/XvJ2nGBixnZOSn3
	JbgMm3CpMKT1kfPhla08OghnaqHCUZ54Lag7ztkhNhuDZ4rv8hGoZWTCtilC19pEX5Hu0UHv8Stbs
	7owpK5cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m71O9-005ojH-Cc; Fri, 23 Jul 2021 20:03:17 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m71O6-005ohi-2M
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 20:03:16 +0000
Received: from [192.168.0.113] ([178.252.67.224]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.179]) with ESMTPSA (Nemesis) id
 1MTiHb-1lfIPd23ED-00Tz9u; Fri, 23 Jul 2021 22:02:48 +0200
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
To: Stephan Mueller <smueller@chronox.de>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
 <6538288.aohFRl0Q45@positron.chronox.de>
 <59695981-9edc-6b7a-480a-94cca95a0b8c@suse.de>
 <463a191b9896dd708015645cfc125988cd5deaef.camel@chronox.de>
 <2af95a8e-50d9-7e2d-a556-696e9404fee4@suse.de>
 <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
From: Vladislav Bolkhovitin <vst@vlnb.net>
Message-ID: <5eb59cb2-75c7-f21c-b0a2-c5d6b8bec53c@vlnb.net>
Date: Fri, 23 Jul 2021 23:02:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <740af9f7334c294ce879bef33985dfab6d0523b3.camel@chronox.de>
Content-Language: en-US
X-Provags-ID: V03:K1:6kCqBtG5jsfxD5zTrmlNFZV7U01GfmgfMq8knZTmjxPZGZJ2Tj+
 7eb3/qB2HkCWfz3t9sv1PZKZEgKnThQRYEATAu6juN1BLyy3zh8K00jkOwGVH/gYhzuJQHY
 oGGyA/qnG+UaaygImUYHZKLUBf1KgVlqUjh/I3MYyIkLjGDmBaJZlcRgeX98qyBsks2NtVW
 Yax+rZ9fL9/V3RrJrO82Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vvPfKYNtUX4=:0hP+AbxlgHWDDw6ou7RYAg
 i0SBJDZzrHqLj82UZBF5lno40pU1RpyremPecoMkmKTvsIgy4T6AkfEkdWWIgXAQcIYChv05D
 /xFnLHVS+HrP/Kgac9Sjd6B7mh5Vhr9aMJAd6u2l/hwMW1j5I3SLjLnLHiVSFXci4Iejh6BGJ
 Kke+9VWsbD2gjH4yVvXBvYlTorwof8DPbqzGsq7/E+Z8dIuxhUB3dgIEncsx08lLEHo2RxLYW
 Jj8bNU4JS3kVE3mro26sO+WCuAwyhj74tMZ71kmZGCBlOnY2VaikFDJUOz4XFDlGM1l+uiS5/
 DsYTF62eqQT//JHPFj9rFkUMJQWli9rWjXthOE8olalHW3nqKxt/oqDOBIJY0SAdsAV98W+JS
 ypJd9gxSQqmPNpP8KN/C90q5DBXAEIiAk2Beapcbda+RZlaeMKDGtdHJeujMRKiWYYIq+sZxB
 zM/EIuisSZlbQvfADsXI0n6sWIi9++thlW1zOURqT0psKSniAKAaeP2WJNng35MtM4U4W7yd4
 Y+BXXe0tcIUONVME7oz4iQdrosRdZ/K7Zkci8Nv3lotHg3ov/amu7A7Ql+YC5aUqo0Ms6eFU+
 oidulEggU9/axRh8Y2aOCwvjmxtSSX86ZVbFwHZvdJxYvim/17JejTYDMFhX+48ZUlAb/IDTq
 +WnmJ/DCNrF/gv4OWSO2mAtI4cTVxez4UXiRUnbP78t1LYDAEDuvLyFAtygj9ItFjJ4+/IsXG
 ZlK8isqU+uqsiEM3KfzNBpytCosGLo4HSJXVMUr/ZSzCeqchSIWXZ1bRVuos0FatBZJFn+d49
 d2du/LWef0lipaOAWiB9J0COAslSRUM1wjEUTHtId66OjZ5WPDU7u/wFtVTphVRJtI/u3y8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210723_130314_453677_E097027E 
X-CRM114-Status: GOOD (  24.57  )
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

Ck9uIDcvMTkvMjEgMToxOSBQTSwgU3RlcGhhbiBNdWVsbGVyIHdyb3RlOgo+IEFtIE1vbnRhZywg
ZGVtIDE5LjA3LjIwMjEgdW0gMTE6NTcgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVpbmVja2U6Cj4+
IE9uIDcvMTkvMjEgMTA6NTEgQU0sIFN0ZXBoYW4gTXVlbGxlciB3cm90ZToKPj4+IEFtIE1vbnRh
ZywgZGVtIDE5LjA3LjIwMjEgdW0gMTA6MTUgKzAyMDAgc2NocmllYiBIYW5uZXMgUmVpbmVja2U6
Cj4+Pj4gT24gNy8xOC8yMSAyOjU2IFBNLCBTdGVwaGFuIE3DvGxsZXIgd3JvdGU6Cj4+Pj4+IEFt
IFNvbm50YWcsIDE4LiBKdWxpIDIwMjEsIDE0OjM3OjM0IENFU1Qgc2NocmllYiBIYW5uZXMgUmVp
bmVja2U6Cj4+Pgo+Pj4+Pj4gVGhlIGtleSBpcyBhbHNvIHVzZWQgd2hlbiB1c2luZyB0aGUgZmZk
aGUgYWxnb3JpdGhtLgo+Pj4+Pj4gTm90ZTogSSBfdGhpbmtfIHRoYXQgSSBuZWVkIHRvIHVzZSB0
aGlzIGtleSBmb3IgdGhlIGZmZGhlIGFsZ29yaXRobSwKPj4+Pj4+IGJlY2F1c2UgdGhlIGltcGxl
bWVudGF0aW9uIEkgY2FtZSB1cCB3aXRoIGlzIGVzc2VudGlhbGx5IHBsYWluIERICj4+Pj4+PiB3
aXRoCj4+Pj4+PiBwcmUtZGVmaW5lZCAncCcsICdxJyBhbmQgJ2cnIHZhbHVlcy4gQnV0IHRoZSBE
SCBpbXBsZW1lbnRhdGlvbiBhbHNvCj4+Pj4+PiByZXF1aXJlcyBhICdrZXknLCBhbmQgZm9yIHRo
YXQgSSdtIHVzaW5nIHRoaXMga2V5IGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4gSXQgbWlnaHQgYmUgdGhh
dCBJJ20gY29tcGxldGVseSBvZmYsIGFuZCBkb24ndCBuZWVkIHRvIHVzZSBhIGtleSBmb3IKPj4+
Pj4+IG91cgo+Pj4+Pj4gREggaW1wbGVtZW50YXRpb24uIEluIHRoYXQgY2FzZSB5b3UgYXJlIGNv
cnJlY3QuCj4+Pj4+PiAoQW5kIHRoYXQncyB3aHkgSSBzYWlkIEknbGwgbmVlZCBhIHJldmlldyBv
ZiB0aGUgRkZESEUKPj4+Pj4+IGltcGxlbWVudGF0aW9uKS4KPj4+Pj4+IEJ1dCBmb3Igbm93IEkn
bGwgbmVlZCB0aGUga2V5IGZvciBGRkRIRS4KPj4+Pj4KPj4+Pj4gRG8gSSB1bmRlcnN0YW5kIHlv
dSBjb3JyZWN0bHkgdGhhdCB0aGUgZGhjaGFwX2tleSBpcyB1c2VkIGFzIHRoZSBpbnB1dAo+Pj4+
PiB0bwo+Pj4+PiB0aGUgCj4+Pj4+IERIIC0gaS5lLiBpdCBpcyB0aGUgcmVtb3RlIHB1YmxpYyBr
ZXkgdGhlbj8gSXQgbG9va3Mgc3RyYW5nZSB0aGF0IHRoaXMKPj4+Pj4gaXMKPj4+Pj4gdXNlZCAK
Pj4+Pj4gZm9yIERIIGJ1dCB0aGVuIGl0IGlzIGNoYW5nZWQgaGVyZSBieSBoYXNoaW5nIGl0IHRv
Z2V0aGVyIHdpdGgKPj4+Pj4gc29tZXRoaW5nCj4+Pj4+IGVsc2UgCj4+Pj4+IHRvIGZvcm0gYSBu
ZXcgZGhjaGFwX2tleS4gTWF5YmUgdGhhdCBpcyB3aGF0IHRoZSBwcm90b2NvbCBzYXlzLiBCdXQg
aXQKPj4+Pj4gc291bmRzIAo+Pj4+PiBzdHJhbmdlIHRvIG1lLCBlc3BlY2lhbGx5IHdoZW4geW91
IHRoaW5rIHRoYXQgZGhjaGFwX2tleSB3b3VsZCBiZSwKPj4+Pj4gc2F5LAo+Pj4+PiAyMDQ4IAo+
Pj4+PiBiaXRzIGlmIGl0IGlzIHRydWx5IHRoZSByZW1vdGUgcHVibGljIGtleSBhbmQgdGhlbiBh
ZnRlciB0aGUgaGFzaGluZwo+Pj4+PiBpdCBpcwo+Pj4+PiAyNTYgCj4+Pj4+IHRoaXMgZGhjaGFw
X2tleSBjYW5ub3QgYmUgdXNlZCBmb3IgRkZDLURILgo+Pj4+Pgo+Pj4+PiBPciBhcmUgeW91IHVz
aW5nIHRoZSBkaGNoYXBfa2V5IGZvciB0d28gZGlmZmVyZW50IHB1cnBvc2VzPwo+Pj4+Pgo+Pj4+
PiBJdCBzZWVtcyBJIG1pc3Mgc29tZXRoaW5nIGhlcmUuCj4+Pj4+Cj4+Pj4gTm8sIG5vdCBlbnRp
cmVseS4gSXQncyBtZSB3aG8gYnVnZ2VyZWQgaXQgdXAuCj4+Pj4gSSBnb3QgY2FycmllZCBhd2F5
IGJ5IHRoZSBmYWN0IHRoYXQgdGhlcmUgaXMgYSBjcnlwdG9fZGhfZW5jb2RlX2tleSgpCj4+Pj4g
ZnVuY3Rpb24sIGFuZCB0aG91Z2h0IEkgbmVlZCB0byB1c2UgaXQgaGVyZS4KPj4+Cj4+PiBUaGFu
ayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhhdC4gSXQgc291bmRzIHRvIG1lIHRoYXQgdGhlcmUgaXMg
bm8gZGVmaW5lZAo+Pj4gcHJvdG9jb2wgKG9yIGlmIHRoZXJlLCBJIHdvdWxkIGJlIHdvbmRlcmlu
ZyBob3cgdGhlIGNvZGUgd291bGQgaGF2ZSB3b3JrZWQKPj4+IHdpdGggYSBkaWZmZXJlbnQgaW1w
bGVtZW50YXRpb24pLiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGZpcnN0IHNwZWNpZnkgYQo+Pj4g
cHJvdG9jb2wgZm9yIGF1dGhlbnRpY2F0aW9uIGFuZCBoYXZlIGl0IGRpc2N1c3NlZD8gSSBwZXJz
b25hbGx5IHRoaW5rIGl0Cj4+PiBpcyBhCj4+PiBiaXQgZGlmZmljdWx0IHRvIGZ1bGx5IHVuZGVy
c3RhbmQgdGhlIHByb3RvY29sIGZyb20gdGhlIGNvZGUgYW5kIGRpc2N1c3MKPj4+IHByb3RvY29s
LWxldmVsIGl0ZW1zIGJhc2VkIG9uIHRoZSBjb2RlLgo+Pj4KPj4gT2gsIHRoZSBwcm90b2NvbCBf
aXNfIHNwZWNpZmllZDoKPj4KPj4gaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3Vw
bG9hZHMvTlZNLUV4cHJlc3MtQmFzZS1TcGVjaWZpY2F0aW9uLTJfMC0yMDIxLjA2LjAyLVJhdGlm
aWVkLTUucGRmCj4+Cj4+IEl0J3MganVzdCB0aGF0IEkgaGF2ZSBpc3N1ZXMgdHJhbnNsYXRpbmcg
dGhhdCBzcGVjIG9udG8gd2hhdCB0aGUga2VybmVsCj4+IHByb3ZpZGVzLgo+IAo+IGFjY29yZGlu
ZyB0byB0aGUgbmFtaW5nIGNvbnZlbnRpb25zIHRoZXJlIGluIGZpZ3VyZXMgNDQ3IGFuZCBmb2xs
b3dpbmc6Cj4gCj4gLSB4IGFuZCB5OiBESCBwcml2YXRlIGtleSAoa2VybmVsIGNhbGxzIGl0IHNl
Y3JldCBzZXQgd2l0aCBkaF9zZXRfc2VjcmV0IG9yCj4gZW5jb2RlZCBpbnRvIHBhcmFtLmtleSkK
CnggYW5kIHkgYXJlIGRlZmluZWQgaW4gRmlndXJlIDQ0NDogIlJhbmRvbSBudW1iZXJzIHVzZWQg
YXMgZXhwb25lbnRzIGluCmEgREggZXhjaGFuZ2UiLiBTZWN0aW9ucyA4LjEzLjUuMyAiREgtSE1B
Qy1DSEFQX0NoYWxsZW5nZSBNZXNzYWdlIiBhbmQKOC4xMy41LjQgIkRILUhNQUMtQ0hBUF9SZXBs
eSBNZXNzYWdlIiBhZGRpdGlvbmFsbHkgc3BlY2lmeSB0aGF0ICJ4IGlzIGEKcmFuZG9tIG51bWJl
ciBzZWxlY3RlZCBieSB0aGUgY29udHJvbGxlciB0aGF0IHNoYWxsIGJlIGF0IGxlYXN0IDI1NiBi
aXRzCmxvbmciIGFuZCAieSBpcyBhIHJhbmRvbSBudW1iZXIgc2VsZWN0ZWQgYnkgdGhlIGhvc3Qg
dGhhdCBzaGFsbCBiZSBhdApsZWFzdCAyNTYgYml0cyBsb25nIi4KClNvLCB4IGFuZCB5IGFyZSBq
dXN0IHJhbmRvbSBudW1iZXJzLCBubyBuZWVkIHRvIG92ZXJjb21wbGljYXRlIHRoZWlyCmdlbmVy
YXRpb24gaW4gdGhlIHdheSB0aGF0IGlzIGJleW9uZCBvZiB0aGUgc3RhbmRhcmQgc2NvcGUuCgpW
bGFkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
