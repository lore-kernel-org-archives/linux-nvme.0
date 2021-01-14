Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846BDC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:10:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F4823406
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 01:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F4823406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zyVzRaY/sOsu5IzeSFxZEuDyUbZ+Esc86ip0aW+szWY=; b=k91OAbpcMcMP7HHTCPVsVmreu
	4CaIaGwJShf12D4TaqwLLkt2NMaVFkp1+zmTL+PbP/5lgQb+3PK0Zfnb9BTbCWR5ANsri/ZYkodJ/
	ZbRlB0mV9x27qmPR0YQJKQj4q053moYOWAOlWmhZ8x5+nNn5+d0ktZzylPJRxn3iXMPwGsvnUn5V/
	IO027ChvXB90dkHfRDvNy9AS4DUB6ii4b3nYUjyJaYj1fyGivfW/jtxwHMO3w+10EEMvxLR/Pz2F9
	DfGGZ/ZQX+avMDP0/UiOzoR3NYStNstRUx0yonMrYqkoYv51Um7nsHdUjfbmrIHoTcoEaKvGcGVT3
	R21WGaEAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzr9T-00050j-5L; Thu, 14 Jan 2021 01:10:15 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzr9Q-00050K-5w
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 01:10:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id v15so391811wrx.4
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 17:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w+VuZrTP/bwrCEn7v11x9xUabW2osjpyIGb9iYlIfvE=;
 b=U4N+LCrJ/3OSU9jFcbNHqLfKwGtsh67ocyvjgpg8YrO6aAFOSoa10zrAnRYTmQ5oBe
 6bdSQLYGfeI53rff+t04ZNkB9aDwFru0a/WqsWnGK/iJ6UV6TpGRBJTdSoGZIic99eNr
 oMbjRbrfqDF2xptiuvNbVqXRl1YEgLtHR9OepsOpcZVKGmiHaKvon7zczqeZlBy1X069
 cxUsRT5O1VXkwXZvRBB7ATyHA0PywiOUXxwpZMKBo4yrpbSuZIE3ar6rLvI8HZpbq/ch
 OAn3QcnCfuuAlmixBjcd7uTN3JSwl4OqfdGjlDWd9gpVLZ+P/C66VUGuh4V5tUSQFBsf
 D+oQ==
X-Gm-Message-State: AOAM531iAOXFOPVyeNHOF1OebCtQ+Kkvt6RAAExVNpRlz0+tH4ZDT+Pb
 L8/qELM5pjzxeXdJJmHDXJE=
X-Google-Smtp-Source: ABdhPJybfyfN4c9LoaWtiKpifwB351lZNctsGrL1m7upj7zsNXsAgIxRgYEbB8mWdqz7Xr4pMu2sew==
X-Received: by 2002:a05:6000:1290:: with SMTP id
 f16mr5275265wrx.298.1610586609268; 
 Wed, 13 Jan 2021 17:10:09 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id r2sm6052986wrn.83.2021.01.13.17.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 17:10:08 -0800 (PST)
Subject: Re: fabrics connect cmd with a non-zero reserved value
From: Sagi Grimberg <sagi@grimberg.me>
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <SN6PR1901MB202957C808A7D493E252D873EED00@SN6PR1901MB2029.namprd19.prod.outlook.com>
 <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
Message-ID: <69465d48-5a63-5c49-50aa-39c4f921ed4a@grimberg.me>
Date: Wed, 13 Jan 2021 17:10:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6e271be1-088b-5a23-0eec-23578f707c28@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_201012_243126_65AE994B 
X-CRM114-Status: GOOD (  13.92  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>, Frederick.Knight@netapp.com, "Grupi,
 Elad" <Elad.Grupi@dell.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzEzLzIxIDQ6MzQgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IEhlbGxvLAo+
PiBXZSBzZWUgdGhhdCB3aGVuIGV4ZWN1dGluZyBudm1lIGNvbm5lY3QgY21kIChPcGNvZGU6IDB4
N2YgRmFicmljIENtZCkKPj4gVGhlIGhvc3QgaXMgc3VibWl0dGluZyB0aGUgY21kIHdpdGggcmVz
ZXJ2ZWQgZmlsZWQgc2V0IHRvIG5vbi16ZXJvIAo+PiB2YWx1ZSAtIHdoaWNoIGlzIG91dCBvZiBz
cGVjLgo+PiBTZWVtcyBsaWtlIHRoaXMgaXNzdWUgaXMgbm90IG9ubHkgZm9yIGNvbm5lY3QgYnV0
IGFsc28gZm9yIG90aGVyIAo+PiBmYWJyaWNzIGNtZHMuCj4+Cj4+IEhlcmUgaXMgYSBwYWNrZXQg
Y2FwdHVyZSBmb3IgbnZtZSBjb25uZWN0IDoKPj4KPj4gwqDCoMKgwqAgTlZNIEV4cHJlc3MgRmFi
cmljcyAoQ21kKQo+PiDCoMKgwqDCoMKgwqDCoMKgIE9wY29kZTogMHg3ZiBGYWJyaWMgQ21kCj4+
IMKgwqDCoMKgwqDCoMKgwqAgW0ZhYnJpYyBDcWUgaW46IDMwMl0KPj4gwqDCoMKgwqDCoMKgwqDC
oCBSZXNlcnZlZDogMHg0MAo+PiDCoMKgwqDCoMKgwqDCoMKgIENvbW1hbmQgSUQ6IDB4MDAwMAo+
PiDCoMKgwqDCoMKgwqDCoMKgIEZhYnJpYyBDbWQgVHlwZTogQ29ubmVjdCAoMHgwMSkKPj4gwqDC
oMKgwqDCoMKgwqDCoCBSZXNlcnZlZDogMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAKPj4gwqDCoMKgwqDCoMKgwqDCoCBTR0wxCj4+IMKgwqDCoMKgwqDCoMKgwqAgUmVjb3Jk
IEZvcm1hdDogMHgwMDAwCj4+IMKgwqDCoMKgwqDCoMKgwqAgUXVldWUgSUQ6IDB4MDAwMAo+PiDC
oMKgwqDCoMKgwqDCoMKgIFNRIFNpemU6IDB4MDAxZgo+PiDCoMKgwqDCoMKgwqDCoMKgIENvbm5l
Y3QgQXR0cmlidXRlczogMHgwMAo+PiDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkOiAwMAo+PiDC
oMKgwqDCoMKgwqDCoMKgIEtlZXAgQWxpdmUgVGltZW91dDogMTUwMDBtcwo+PiDCoMKgwqDCoMKg
wqDCoMKgIFJlc2VydmVkOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAKPj4gwqDCoMKgwqAgRGF0
YQo+PiDCoMKgwqDCoMKgwqDCoMKgIEhvc3QgSWRlbnRpZmllcjogZjFhYTk3ODQtMTk1Yi00ODE0
LTg5M2QtNDRmOTBhNmE5MmQ5Cj4+IMKgwqDCoMKgwqDCoMKgwqAgQ29udHJvbGxlciBJRDogMHhm
ZmZmCj4+IMKgwqDCoMKgwqDCoMKgwqAgUmVzZXJ2ZWQ6IAo+PiAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLi4g
Cj4+Cj4+IMKgwqDCoMKgwqDCoMKgwqAgU3Vic3lzdGVtIE5RTjogCj4+IG5xbi4yMDE1LTEwLmNv
bS5kZWxsOmRlbGxlbWMtcG93ZXJzdG9yZS0yM2I1MTQ1NTkxOTc1RURGRjJGRQo+PiDCoMKgwqDC
oMKgwqDCoMKgIEhvc3QgTlFOOiBucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlkOm5jNTE5
OTAwNwo+PiDCoMKgwqDCoMKgwqDCoMKgIFJlc2VydmVkOiAKPj4gMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwLi4u
IAo+Pgo+Pgo+PiAweDQwIHZhbHVlIGlzIGNvcnJlc3BvbmRpbmcgdG8gUFNEVCwgaW4gYSBub3Jt
YWwgKG5vbi1mYWJyaWMpIG52bWUgCj4+IGNtZCwgUFNEVCBmaWVsZCBleGlzdHMuCj4+IERvIHdl
IGV4cGVjdCBmb3IgdGhlIHNhbWUgZm9yIGZhYnJpYyBjbWQ/Cj4+IElmIHNvLCB0aGUgc3BlYyBj
YW4ndCBtYXJrIHRoZSBzZWNvbmQgYnl0ZSBvZiBjb25uZWN0IGNtZCBhcyByZXNlcnZlZC4KPj4g
QmFzZWQgb24gbnZtZSBzcGVjOgo+PiAiQSByZXNlcnZlZCBiaXQsIGJ5dGUsIHdvcmQsIGZpZWxk
LCBvciByZWdpc3RlciBzaGFsbCBiZSBjbGVhcmVkIHRvIAo+PiAwaCwgb3IgaW4gYWNjb3JkYW5j
ZSB3aXRoIGEgZnV0dXJlIGV4dGVuc2lvbiB0byB0aGlzIHNwZWNpZmljYXRpb24iCj4+Cj4+IElz
IHRoaXMgYSByZWFsIGJ1ZyBvciBhIHNwZWMgYnVnPwo+IAo+IFdlIHNob3VsZG4ndCBiZSBzZXR0
aW5nIHJlc2VydmVkIGJpdHMuIEJ1dCBmcm9tIHdoYXQgSSBzZWUsIHdlIHplcm8gdGhlIAo+IG52
bWUgY29tbWFuZHMgYmVmb3JlIHNldHRpbmcgaXQgc28gdGhpcyBpcyBzdHJhbmdlIHRvIG1lLi4K
Ck9LLCBub3cgSSBzZWUgdGhlIGlzc3VlLgoKVGhpcyBhcHBlYXJzIHRvIG1lIHRoaXMgd291bGQg
YmUgYW4gaXNzdWUgd2l0aCB0aGUgc3BlYy4gQXMgdGhlIGNvbm5lY3QKZGF0YSAobGlrZSBhbnkg
Y29tbWFuZCBwYXlsb2FkKSBpcyBjb21pbmcgaW4gdGhlIGZvcm0gb2YgYW4gc2dsLgoKQWRkaW5n
IEZyZWQgZm9yIHRoaXMgcXVlc3Rpb24uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
