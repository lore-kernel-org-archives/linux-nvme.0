Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C263C47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:25:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3723061222
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3723061222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=knownhost.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J2ShstHi9nAAQPylvWbscorHohBAyoaGeZHdNBb2wlU=; b=nT01IFevMUu6i2qdQxvtw+m80C
	1hlTrl7kkqdg0f6v1YQaOVLFM1GjRStaOZMpQFFDOCfOQnF7vbfUTeyozJ5y6Gqhe/AgbyawOr4E1
	hTOgBbavvHjPBxP/5Z9mGHKgHTpQoMmhFloi15wkLjf7pzjGfFGssrcTeBx/g072WoAFhmh7ZdQsH
	55iDysFm0Pu7WPgNDKmc31wHqOaymy3Q6OM/yMl5uByQeJ1ep2QvjdaDbN7Migwxz1sTDgJhMN1gZ
	oefABtko8BW3Fc7In64U1Luh9mJikLhLu8PFLS4Qtdh4n+5O4yqshWCHWEzGkME6rFMmTIsTpkpck
	WMs/m1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmKh4-008T7c-Em; Thu, 27 May 2021 18:25:18 +0000
Received: from core.knownhost.net ([67.222.0.2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmJJu-007qbS-9l
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 16:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=knownhost.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aIB4LUlGjqw1FDhmQ7WziHVqIcPBMaLOc675TJbeTI=; b=YeRhl5uODIW4St17VQYaxlapdZ
 OKrHagKTltn5YyBTAn6SUDRYqJospr834gKwRRG0AgR6eBfTsFSI4E1U1Vcm0vlHiDMETuT+EeT/I
 W9ebDdpfsZyhd7sMQYMhEgYrTyFTQlJDQCXoStz5jWRZplUc9toSbWL2Dk1M2Z3pugp5FZY61n2cN
 DnJngtnQSxhNZHxh2z19JnOS4GWynrg0MtsE8fHS2VeQ2HpNDg2R60b2X6+htiWkYaZHssI5Xss5Y
 2Sgj2RuUiicTvQ0PPJ9fa1qSAg/Duv1nr8WV/7DjORloeNPZJLnTz5qqC0oCe7OLrdlLa2cDRDw/S
 fVvUCovA==;
Received: from [192.251.128.16] (port=32841
 helo=jon-office.noc.al.privatesystems.net)
 by core.knownhost.net with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <jonathan@knownhost.com>)
 id 1lmJJr-00082p-TF; Thu, 27 May 2021 12:57:15 -0400
Subject: Re: nvmeof Issues with Zen 3/Ryzen 5000 Initiator
To: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <ffae89d5-05d8-e0a4-ca71-b3db18f70286@knownhost.com>
 <BYAPR04MB49650971173C72A97AC8B0D186249@BYAPR04MB4965.namprd04.prod.outlook.com>
 <98b9e916-1c62-d6fe-ade8-bf0a8788e622@knownhost.com>
 <BYAPR04MB4965276BE6BD29AD9594F4DB86239@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210527165108.GB3706388@dhcp-10-100-145-180.wdc.com>
From: Jonathan Wright <jonathan@knownhost.com>
Message-ID: <0d912782-96a7-919a-51e6-c77572ba0e8d@knownhost.com>
Date: Thu, 27 May 2021 11:57:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210527165108.GB3706388@dhcp-10-100-145-180.wdc.com>
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
X-CRM114-CacheID: sfid-20210527_095718_671147_23A682AD 
X-CRM114-Status: GOOD (  11.79  )
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

WWVzLCBpbiBhbiBhdHRlbXB0IHRvIHB1dCBmb3J0aCBtb3JlIGVmZm9ydCB0byBoZWxwIGhlcmUg
SSd2ZSBzcGVudCB0aGUgCm1vcm5pbmcgY29tcGlsaW5nIHZhcmlvdXMgYnJhbmNoZXMgb2YgdGhl
IG52bWUga2VybmVsIGJyYW5jaGVzLgoKNS44IC0gTklDIGRyaXZlcnMgd29uJ3QgY29tcGlsZSwg
Y2Fubm90IHRlc3QKNS45IC0gSXNzdWUgcGVyc2lzdHMgYW5kIHdoZW4gaXQgaGFwcGVucyB0aGUg
ZW50aXJlIHN5c3RlbSBsb2NrcyB1cAo1LjEwIC0gSXNzdWUgcGVyc2lzdHMKCkkgZG9uJ3Qgc2Vl
IG11Y2ggcG9pbnQgaW4gY29udGludWluZyBmdXJ0aGVyIHdpdGggc3VjaCB0ZXN0cyBob25lc3Rs
eS7CoCAKSSB0aGluayB0aGlzIGlzIHNvbWV0aGluZyB0aGF0IGhhcyBuZXZlciB3b3JrZWQgd2l0
aCBaZW4gMyBhbmQgbm90IGEgCnJlZ3Jlc3Npb24uCgpJJ20gZ2F0aGVyaW5nIHVwIG1vcmUgaGFy
ZHdhcmUgdG8gdGVzdCBsYXRlciB0b2RheSBvbiBzb21lIG90aGVyIApjb21iaW5hdGlvbnMgLSBu
YW1lbHkgWmVuIDIgKFJ5emVuIDM2MDApIHRvIHNlZSBpZiB0aGUgaXNzdWUgZXhpc3RzIAp0aGVy
ZS7CoCBJIGhhdmUgc29tZSBFUFlDcyAoWmVuIDIpIGFzIHdlbGwgYnV0IGl0J2QgYmUgbGF0ZXIg
bmV4dCB3ZWVrIApiZWZvcmUgSSBjYW4gZ2V0IHRoZW0gaW4gbXkgbGFiIGZvciB0ZXN0aW5nLgoK
T24gNS8yNy8yMSAxMTo1MSBBTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gVGh1LCBNYXkgMjcs
IDIwMjEgYXQgMDI6MzY6NTlBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOgo+PiBP
biA1LzI2LzIxIDE2OjE0LCBKb25hdGhhbiBXcmlnaHQgd3JvdGU6Cj4+PiBJIGdyYWJiZWQvYnVp
bHQgdGhlIGtlcm5lbCBmcm9tIHRoZSBudm1lLTUuMTQgYnJhbmNoCj4+PiAoaHR0cDovL2dpdC5p
bmZyYWRlYWQub3JnL252bWUuZ2l0L3Nob3J0bG9nL3JlZnMvaGVhZHMvbnZtZS01LjE0KSBhbmQK
Pj4+IG1hbmFnZWQgdG8gZ2V0IHRoZSBOSUMgZHJpdmVycyBjb21waWxlZC4KPj4+Cj4+PiBVbmZv
cnR1bmF0ZWx5IHRoZSBpc3N1ZSBzdGlsbCBwZXJzaXN0cy4KPj4gSXQgd2lsbCBhbGxvdyBldmVy
eW9uZSB0byBoZWxwIHlvdSB0byBmaXggdGhpcyBpZiB5b3UgY2FuIGJpc2VjdAo+PiB0aGUgcHJv
YmxlbS4KPiBZb3UgbmVlZCBhICJnb29kIiBjb21taXQgcG9pbnQgaW4gb3JkZXIgdG8gYmlzZWN0
LCBhbmQgd2UgZG9uJ3QgaGF2ZSBvbmUKPiBoZXJlLiBUaGUgZGVzY3JpcHRpb24gc291bmRzIGxp
a2Ugbm8ga2VybmVsIHJlbGVhc2UgZXZlciB3b3JrZWQuCgotLSAKSm9uYXRoYW4gV3JpZ2h0Cktu
b3duSG9zdCwgTExDCmh0dHBzOi8vd3d3Lmtub3duaG9zdC5jb20KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
