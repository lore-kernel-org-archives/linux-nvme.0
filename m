Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFEBC48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 20:03:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1B66136D
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 20:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1B66136D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=94/UJDrLSpABYl8VeWF0KWv+k57wtloX6cdC6ASy2RU=; b=gpZIKYpobddCIUBl0xXY7WDJXF
	cu0TpuMoH6G+Uuf5wpa/6N8Zw3Ndh4pAtTCrrkP+kVojc9XYMPYT3K/NGFdXm3b4r52y73zdb2I/N
	6KlhPdJ6iO8m9NcnT5l4zuePcjJA4Hu4g06Zt4P0ZkTPRJ/J0/FgFkH/4VgovYcWDwUMQBoKvHVZJ
	BsUujkx0FU0dQTEAE1UXoKJera1R/F+9Qz2CAwaFaWsSK/l7z0xPjMBnDjVsZx7FcwyavXf6FVA6B
	2PZF2DMFsya2i7Wzyy7l1NuUvCKvspKNYlfS7XM4NLQ+nj8cUSapaDVny5QBbnKGagLKO3kclD9Xm
	W83pIyYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrQtX-002KJI-L5; Thu, 10 Jun 2021 20:03:15 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrQtU-002KIH-C8
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 20:03:13 +0000
Received: by mail-wr1-f42.google.com with SMTP id i94so3617684wri.4
 for <linux-nvme@lists.infradead.org>; Thu, 10 Jun 2021 13:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8SR3M8QoPDbqUoXThZ5ia4xLRClEtwRltqDONg1V2rY=;
 b=d2k7PzNWq+GDL0M7uqEi3e7i0rqSvy1bdNRSUeTIlVu9Ai8MIpUebf9J4lDHTbyqfb
 M5NVAKt9VP/eN7wAmHpJWlf98HJhsRgYjXIN4SxLS9BoAEqA/u+ijsTUGoABMzyuSmj7
 xVWS71zDQ6Ktzf7CwnAOUbBpoMX+Q+9yfXMg18PnydRJGGwPsZXAIkmjRmobLLQTCukW
 KBIxHwF8sU90vsfR+Zm89xJ6PmDU6XSiTHTvC6JTZZl1PbgZJETAAX9nwCeRxBk7Cpq6
 5Yn9aNVQeIGpiXFF8pNdqcZwLG5nwRGvAj5qCvLPy468hso2ylDBnIAskApF82XSPOUe
 1ltQ==
X-Gm-Message-State: AOAM530YZYca4Na2IwOU/4mKnHPSZbSWI9mSGG9wHoq5w2wHY04MxPn8
 x3KQa5BKtT4eSq5DpwbIsr4MfURu3VM=
X-Google-Smtp-Source: ABdhPJzUCEogcJfpsSqZkQyzMpLidz2k+6Zl1acZZVxy0JJ1nQy9GYFyTUR3uGyXBFwOPfcrq4XWjQ==
X-Received: by 2002:a5d:618f:: with SMTP id j15mr184374wru.348.1623355388018; 
 Thu, 10 Jun 2021 13:03:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:369a:b2e8:3b7e:75d8?
 ([2601:647:4802:9070:369a:b2e8:3b7e:75d8])
 by smtp.gmail.com with ESMTPSA id g23sm10358324wmk.3.2021.06.10.13.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jun 2021 13:03:07 -0700 (PDT)
Subject: Re: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "Anner, Ran" <Ran.Anner@dell.com>, "Grupi, Elad" <Elad.Grupi@dell.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
 <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
 <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <172e3128-d1dc-ca9a-c679-752b621e956f@grimberg.me>
Date: Thu, 10 Jun 2021 13:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_130312_447019_BCA4BBC0 
X-CRM114-Status: GOOD (  12.95  )
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

Cj4gQ29ycmVjdCwgZnJlZV9xdWV1ZSBpcyBiZWluZyBjYWxsZWQgKHNvY2stPnNrIGJlY29tZXMg
TlVMTCkgYmVmb3JlIHJlc3RvcmVfc29ja19jYWxscwo+IAo+IFdoZW4gcmVzdG9yZV9zb2NrX2Nh
bGxzIGlzIGNhbGxlZCwgd2UgZmFpbCBvbiAnd3JpdGVfbG9ja19iaCgmc29jay0+c2stPnNrX2Nh
bGxiYWNrX2xvY2spJwo+IAo+IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCAweDIzMCDihpIg
NTYwIGRlY2ltYWwKPiBjcmFzaD4gc3RydWN0IHNvY2sgLW8KPiBzdHJ1Y3Qgc29jayB7Cj4gICAg
IFswXSBzdHJ1Y3Qgc29ja19jb21tb24gX19za19jb21tb247Cj4gICAgIOKApgo+ICAgICAuLi4K
PiAgICAg4oCmCj4gICAgIFs1NjBdIHJ3bG9ja190IHNrX2NhbGxiYWNrX2xvY2s7Cj4gCj4gc3Rv
cCBxdWV1ZSBpbiBjdHgyIGRvZXMgbm90IHJlYWxseSBkbyBhbnl0aGluZyBzaW5jZSAnTlZNRV9U
Q1BfUV9MSVZFJyBiaXQgaXMgYWxyZWFkeSBjbGVhcmVkIChieSBjdHgxKS4KPiBjYW4geW91IHBs
ZWFzZSBleHBsYWluIGhvdyBzdG9wIHRoZSBxdWV1ZSBiZWZvcmUgZnJlZSBoZWxwcyB0byBzZXJp
YWxpemUgY3R4MSA/CgpXaGF0IEkgdW5kZXJzdG9vZCBmcm9tIHlvdXIgZGVzY3JpcHRpb24gaXM6
CjEuIGN0eDEgY2FsbHMgc3RvcF9xdWV1ZSAtIGNhbGxzIGtlcm5lbF9zb2NrX3NodXRkb3duCjIu
IGN0eDEgZ2V0cyB0byByZXN0b3JlX3NvY2tfY2FsbHMgKGp1c3QgYmVmb3JlKQozLiBjdHgyIGlz
IHRyaWdnZXJlZCBmcm9tIHN0YXRlX2NoYW5nZSAtIHNjaGVkdWxpbmcgZXJyX3dvcmsKNC4gY3R4
MiBkb2VzIHN0b3BfcXVldWVzCjUuIGN0eDIgY2FsbHMgZGVzdHJveV9xdWV1ZXMgLT4gdGhlcmUg
ZG9lcyBzb2NrX3JlbGVhc2UKNi4gY3R4MSBkb2VzIGZyd2QgcHJvZ3Jlc3MgYW5kIGFjY2VzcyBh
biBhbHJlYWR5IGZyZWVkIHNrCgpIZW5jZSB3aXRoIHRoZSBtdXRleCBwcm90ZWN0aW9uLCBjdHgy
IHdpbGwgYmUgc2VyaWFsaXplZCBvbiBzdGVwICg0KQp1bnRpbCBjdHgyIHJlbGVhc2VzIHRoZSBt
dXRleCBhbmQgaGVuY2UgY2Fubm90IGdldCB0byBzdGVwICg1KSBidXQKb25seSBhZnRlciBjdHgx
IHJlbGVhc2VzIHRoZSBtdXRleCwgaW4gc3RlcCAoNikuCgpCdXQgbWF5YmUgSSdtIG5vdCBpbnRl
cnByZXRpbmcgdGhpcyBjb3JyZWN0bHk/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
