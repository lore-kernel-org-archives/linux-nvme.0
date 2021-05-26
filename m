Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14DEC47082
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 23:08:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 537A2613C1
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 23:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 537A2613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=knownhost.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCcYLFzEfyMBdiH/MNTTMQ+5k3juKVl448sPiR6PJus=; b=LD2+rX+MU52JSt49T20kwIurxQ
	0MKVUdejTACS31Ek9DI9YbvdkCm0peUtIAwQcE403zG3LZAzj6qwu4HfdwXm86IBERyNDQMvAmBnZ
	SNbfB4CzPkJL9lxoFNjbPoBrsMNduWXL5J3xvlNv1+7n4dIU5DzC3J6EfRkcbc33n6/BWWUZmBnUS
	b4FzkKXYs/350y2ZPr4Pvavkfs21Ube0cYRv2ck2IQ9gANa03uYylwlLeK32Ki22PrUUQTIyIC1Km
	6p8pHeg8N6KouhmLld9KIyondp7zH/XjN8CZl7rcU0JqoyVB2Qxujg9Q3B23nxaSgahKrjQHLjE57
	p62LDybA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lm2cr-000iBR-Gm; Wed, 26 May 2021 23:07:45 +0000
Received: from core.knownhost.net ([67.222.0.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lm2co-000i9A-IQ
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 23:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=knownhost.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+PRbVD34N05sEtNIsu6QEn09f/RO83xbx17p4bCr2io=; b=kykrT5XC40pxZq1xbSwYo+lz7m
 StPxdURL3WEHR/IJuGQd51fNOBBMVUOV24QNHOUB9/2ZpR8GWYadqKTf/tBYS0gBP86cgdzidFUVV
 b7+xvaT0UD3ie5mRbqMEG4ZZzf4+7ztKcYLUzoZySARlhZmHWladfIiplJhokbZoLwxDWgTNMSdTM
 wa+6hB/9WiP+ScOYK/FP8mMEZ11ClS54EwDMW2tEc6haZ1aITAcreEK9Mx8Ahdo5dasrFZvp+K0EI
 wc2Gt8GNl9EKAFglNKQJpyqxB8jZA0RfiufRbLXbvKXEOstIUXSLT0SFQtyS/7tNsuLwG3Ep3vN86
 BGWayYDA==;
Received: from [192.251.128.16] (port=41911
 helo=jon-office.noc.al.privatesystems.net)
 by core.knownhost.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <jonathan@knownhost.com>) id 1lm2cm-00008D-MN
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 19:07:40 -0400
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
To: linux-nvme@lists.infradead.org
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Jonathan Wright <jonathan@knownhost.com>
Message-ID: <98b9e916-1c62-d6fe-ade8-bf0a8788e622@knownhost.com>
Date: Wed, 26 May 2021 18:07:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - core.knownhost.net
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - knownhost.com
X-Get-Message-Sender-Via: core.knownhost.net: authenticated_id:
 jonathan@knownhost.com
X-Authenticated-Sender: core.knownhost.net: jonathan@knownhost.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_160742_912733_1C71D425 
X-CRM114-Status: GOOD (  12.49  )
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

SSBncmFiYmVkL2J1aWx0IHRoZSBrZXJuZWwgZnJvbSB0aGUgbnZtZS01LjE0IGJyYW5jaCAKKGh0
dHA6Ly9naXQuaW5mcmFkZWFkLm9yZy9udm1lLmdpdC9zaG9ydGxvZy9yZWZzL2hlYWRzL252bWUt
NS4xNCkgYW5kIAptYW5hZ2VkIHRvIGdldCB0aGUgTklDIGRyaXZlcnMgY29tcGlsZWQuCgpVbmZv
cnR1bmF0ZWx5IHRoZSBpc3N1ZSBzdGlsbCBwZXJzaXN0cy4KClRhcmdldDoKW8KgIDc5MC41OTE0
MjRdIG52bWV0OiBjdHJsIDEga2VlcC1hbGl2ZSB0aW1lciAoNSBzZWNvbmRzKSBleHBpcmVkIQpb
wqAgNzkwLjU5MTg0Nl0gbnZtZXQ6IGN0cmwgMSBmYXRhbCBlcnJvciBvY2N1cnJlZCEKCkluaXRp
YXRvcjoKW8KgIDY4OC42ODM5MzNdIG52bWUgbnZtZTI6IEkvTyAxIFFJRCAyIHRpbWVvdXQKW8Kg
IDY4OC42ODQwNjZdIG52bWUgbnZtZTI6IHN0YXJ0aW5nIGVycm9yIHJlY292ZXJ5ClvCoCA2ODgu
Njg0MDg5XSBudm1lIG52bWUyOiBJL08gMiBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzU2NDkyXSBu
dm1lIG52bWUyOiBJL08gMyBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzU2NTIyXSBudm1lIG52bWUy
OiBJL08gNCBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzU2NTQyXSBudm1lIG52bWUyOiBJL08gNSBR
SUQgMiB0aW1lb3V0ClvCoCA2OTEuNzU2NTYxXSBudm1lIG52bWUyOiBJL08gNiBRSUQgMiB0aW1l
b3V0ClvCoCA2OTEuNzU2NTc4XSBudm1lIG52bWUyOiBJL08gNyBRSUQgMiB0aW1lb3V0ClvCoCA2
OTEuNzU3OTIyXSBudm1lIG52bWUyOiBJL08gOCBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzU4OTk1
XSBudm1lIG52bWUyOiBJL08gOSBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzYwMDYzXSBudm1lIG52
bWUyOiBJL08gMTAgUUlEIDIgdGltZW91dApbwqAgNjkxLjc2MTEyOV0gbnZtZSBudm1lMjogSS9P
IDExIFFJRCAyIHRpbWVvdXQKW8KgIDY5MS43NjIxOTJdIG52bWUgbnZtZTI6IEkvTyAxMiBRSUQg
MiB0aW1lb3V0ClvCoCA2OTEuNzYzMjM2XSBudm1lIG52bWUyOiBJL08gMTMgUUlEIDIgdGltZW91
dApbwqAgNjkxLjc2NDI2OF0gbnZtZSBudm1lMjogSS9PIDE0IFFJRCAyIHRpbWVvdXQKW8KgIDY5
MS43NjUyODNdIG52bWUgbnZtZTI6IEkvTyAxNSBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzY2Mjg1
XSBudm1lIG52bWUyOiBJL08gMTYgUUlEIDIgdGltZW91dApbwqAgNjkxLjc2NzI2OF0gbnZtZSBu
dm1lMjogSS9PIDE3IFFJRCAyIHRpbWVvdXQKW8KgIDY5MS43NjgyMzBdIG52bWUgbnZtZTI6IEkv
TyAxOCBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzY4Mjc1XSBibG9jayBudm1lMm4xOiBubyB1c2Fi
bGUgcGF0aCAtIHJlcXVldWluZyBJL08KW8KgIDY5MS43NjkxOTRdIG52bWUgbnZtZTI6IEkvTyAx
OSBRSUQgMiB0aW1lb3V0ClvCoCA2OTEuNzcwMjY1XSBibG9jayBudm1lMm4xOiBubyB1c2FibGUg
cGF0aCAtIHJlcXVldWluZyBJL08KW8KgIDY5MS43NzEyMTBdIG52bWUgbnZtZTI6IEkvTyAyMCBR
SUQgMiB0aW1lb3V0ClvCoCA2OTEuNzcyMTU5XSBibG9jayBudm1lMm4xOiBubyB1c2FibGUgcGF0
aCAtIHJlcXVldWluZyBJL08KW8KgIDY5MS43NzMwODZdIG52bWUgbnZtZTI6IEkvTyAyMSBRSUQg
MiB0aW1lb3V0CjxzbmlwPgoKW3Jvb3RAbnZtZW9mLWNsaWVudC1jZW50b3Mgfl0jIHVuYW1lIC1h
CkxpbnV4IG52bWVvZi1jbGllbnQtY2VudG9zIDUuMTIuMCsgIzIgU01QIFdlZCBNYXkgMjYgMTg6
Mzk6MzEgRURUIDIwMjEgCng4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAoKSSB3YXNuJ3Qg
dG90YWxseSBzdXJlIHdobyB0byBzdGFydCB0YWxraW5nIHRvIGFib3V0IHRoaXMgaXNzdWUgYnV0
IEkgCmJlY2FtZSBwcmV0dHkgY29uZmlkZW50IHRoYXQgaXQgd2Fzbid0IGRpc3Ryby1zcGVjaWZp
YyB3aGljaCBpcyB3aHkgSSAKc2VudCBteSBtZXNzYWdlIGhlcmUuwqAgSWYgSSdtIHN0aWxsIGlu
IHRoZSB3cm9uZyBwbGFjZSBwbGVhc2UgbGV0IG1lIGtub3cuCgpPbiA1LzI2LzIxIDQ6NTAgUE0s
IENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToKPiBPbiA1LzI2LzIxIDEzOjUzLCBKb25hdGhhbiBX
cmlnaHQgd3JvdGU6Cj4+IEhlcmUgYXJlIHNvbWUgdGhpbmdzIEkndmUgdHJpZWQgd2hpY2ggbWFr
ZSBubyBkaWZmZXJlbmNlIChvciBtYWtlIHRoaW5ncwo+PiB3b3JzZSk6Cj4+Cj4+IFVidW50dSAy
MC4wNC4yIGtlcm5lbCA1LjQuCj4+IFVidW50dSAyMC4wNC4yIGtlcm5lbCA1LjgKPj4gVWJ1bnR1
IDIwLjA0LjIga2VybmVsIDUuMTAKPj4gQ2VudE9TIDgga2VybmVsIDQuMTgKPj4gQ2VudE9TIDgg
a2VybmVsIDUuMTAgKGZyb20gZWxyZXBvKQo+PiBDZW50T1MgOCBrZXJuZWwgNS4xMiAoZnJvbSBl
bHJlcG8pIC0gd2hvbGUgc3lzdGVtIGFjdHVhbGx5IGZyZWV6ZXMgdXBvbgo+PiAibnZtZSBjb25u
ZWN0IiBjb21tYW5kIG9uIHRoaXMgb25lCj4+IFdpdGggYW5kIHdpdGhvdXQgbXVsdGlwYXRoIChu
YXRpdmUpCj4+IFdpdGggYW5kIHdpdGhvdXQgcm91bmQtcm9iaW4gb24gbXVsdGlwYXRoIChuYXRp
dmUpCj4+IERpZmZlcmVudCBOVk1lIGRyaXZlIG1vZGVscwo+PiBXaXRoIGFuZCB3aXRob3V0IFBG
Qwo+PiAxMEcgREFDCj4+IDI1RyBEQUMKPj4gMjVHIERBQyBuZWdvdGlhdGVkIGF0IDEwRwo+PiBX
aXRoIGFuZCB3aXRob3V0IGEgc3dpdGNoCj4+IGlXQVJQIGFuZCBSb0NFMgo+IEkgdGhpbmsgeW91
IG5lZWQgdG8gdGFsayB0byByZXNwZWN0aXZlIGRpc3Ryb3MuCj4KPiBIYXZlIHlvdSBzZWVuIGFu
eSBpc3N1ZXMgd2l0aCB0aGUgbnZtZSByZXBvIGJyYW5jaCA1LjE0ID8KPgo+Cj4KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LW52bWUgbWFp
bGluZyBsaXN0Cj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCgotLSAKSm9uYXRoYW4g
V3JpZ2h0Cktub3duSG9zdCwgTExDCmh0dHBzOi8vd3d3Lmtub3duaG9zdC5jb20KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
