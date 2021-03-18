Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C4CC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:51:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B2364E83
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2364E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BBA7KdD11YM16doxbG6sT5SV9VDlkX2kDGvSddKMI6g=; b=QjxG6E5feh+MdD8F/axVcsrXJ
	rHp6LuTsWJwFkeilIa4OAt+Bmqc75kQ1DhyzXSXDI/IMUUEqBjTR2KTDCUOrvWkYs4/GSD4L0S9Os
	Zlvlo9PYemEwIZ7NixTSnYPR6tkyj7VMPNc884Xmz/z+sKMQiTjtp4uwZJiqAu6dJGDuqs92tnH6+
	feRsKqdiAdaEonb9yWKtm15kuF1lCkDJSuAPhrqCR4ASfAcnYtz6USiIRub2Xywcu9G0/0rzbl87R
	J8pw2sRmNK7y+DMW9qlHqeyA4tq0yLX8F3+2P/x/kT0Ys1MLVUE1HqZDXSbIE6MhpZc5mjMEDEMvm
	fOvmqrCGA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMhoz-004G5A-6o; Thu, 18 Mar 2021 01:51:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMhoq-004G4a-QJ
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:51:30 +0000
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F191k4932zRR53;
 Thu, 18 Mar 2021 09:49:30 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 09:51:15 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 18
 Mar 2021 09:51:14 +0800
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
Date: Thu, 18 Mar 2021 09:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_015128_305124_2B2891B8 
X-CRM114-Status: GOOD (  19.62  )
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

CgpPbiAyMDIxLzMvMTggMjo0MywgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+Pj4+IFdpbGwg
aXQgd29yayBpZiBudm1lIG1wYXRoIHVzZWQgcmVxdWVzdCBOT1dBSVQgZmxhZyBmb3IgaXRzIHN1
Ym1pdF9iaW8oKQo+Pj4+Pj4gY2FsbCwgYW5kIGFkZCB0aGUgYmlvIHRvIHRoZSByZXF1ZXVlX2xp
c3QgaWYgYmxrX3F1ZXVlX2VudGVyKCkgZmFpbHM/IEkKPj4+Pj4+IHRoaW5rIHRoYXQgbG9va3Mg
bGlrZSBhbm90aGVyIHdheSB0byByZXNvbHZlIHRoZSBkZWFkbG9jaywgYnV0IHdlIG5lZWQKPj4+
Pj4+IHRoZSBibG9jayBsYXllciB0byByZXR1cm4gYSBmYWlsZWQgc3RhdHVzIHRvIHRoZSBvcmln
aW5hbCBjYWxsZXIuCj4+Pgo+Pj4gWWVzLCBJIHRoaW5rIEJMS19NUV9SRVFfTk9XQUlUIG1ha2Vz
IHRvdGFsIHNlbnNlIGhlcmUuwqAgZG0tbXBhdGggYWxzbwo+Pj4gdXNlcyBpdCBmb3IgaXRzIHJl
cXVlc3QgYWxsb2NhdGlvbiBmb3Igc2ltaWxhciByZWFzb25zLgo+Pj4KPj4+Pj4KPj4+Pj4gQnV0
IHdobyB3b3VsZCBraWNrIHRoZSByZXF1ZXVlIGxpc3Q/IGFuZCB0aGF0IHdvdWxkIG1ha2UgbmVh
ci10YWctZXhoYXVzdCBwZXJmb3JtYW5jZSBzdGluay4uLgo+Pj4KPj4+IFRoZSBtdWx0aXBhdGgg
Y29kZSB3b3VsZCBoYXZlIHRvIGtpY2sgdGhlIGxpc3QuwqAgV2UgY291bGQgYWxzbyB0cnkgdG8K
Pj4+IHNwbGl0IGludG8gdHdvIGZsYWdzLCBvbmUgdGhhdCBhZmZlY3RzIGJsa19xdWV1ZV9lbnRl
ciBhbmQgb25lIHRoYXQKPj4+IGFmZmVjdHMgdGhlIHRhZyBhbGxvY2F0aW9uLgo+Pj4KPj4+PiBt
b3ZpbmcgbnZtZV9zdGFydF9mcmVlemUgZnJvbSBudm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVz
IHRvIG52bWVfcmRtYV9jb25maWd1cmVfaW9fcXVldWVzIGNhbiBmaXggaXQuCj4+Pj4gSXQgY2Fu
IGFsc28gYXZvaWQgSS9PIGhhbmcgbG9uZyB0aW1lIGlmIHJlY29ubmVjdGlvbiBmYWlsZWQuCj4+
Pgo+Pj4gQ2FuIHlvdSBleHBsYWluIGhvdyB3ZSdkIHN0aWxsIGVuc3VyZSB0aGF0IG5vIG5ldyBj
b21tYW5kcyBnZXQgcXVldWVkCj4+PiBkdXJpbmcgdGVhcmRvd24gdXNpbmcgdGhhdCBzY2hlbWU/
Cj4+IDEuIHRlYXIgZG93biB3aWxsIGNhbmNlbCBhbGwgaW5mbGlnaHQgcmVxdWVzdHMsIGFuZCB0
aGVuIG11bHRpcGF0aCB3aWxsIGNsZWFyIHRoZSBwYXRoLgo+PiAyLiBhbmQgdGhlbiB3ZSBtYXkg
ZnJlZXplIHRoZSBjb250cm9sZXIuCj4+IDMuIG52bWVfbnNfaGVhZF9zdWJtaXRfYmlvIGNhbiBu
b3QgZmluZCB0aGUgcmVjb25uZWN0aW9uIGNvbnRyb2xsZXIgYXMgdmFsaWQgcGF0aCwgc28gaXQg
aXMgc2FmZS4KPiAKPiBJbiBub24tbXBhdGggKHdoaWNoIHVuZm9ydHVuYXRlbHkgaXMgYSB2YWxp
ZCB1c2UtY2FzZSksIHRoZXJlIGlzIG5vCj4gZmFpbG92ZXIsIGFuZCB3ZSBjYW5ub3QgZnJlZXpl
IHRoZSBxdWV1ZSBhZnRlciB3ZSBzdG9wcGVkIChhbmQvb3IKPiBzdGFydGVkKSB0aGUgcXVldWVz
IGJlY2F1c2UgdGhlbiBmYWlsX25vbl9yZWFkeV9jb21tYW5kKCkgY29uc3RhbnRseSByZXR1cm4g
QkxLX1NUU19SRVNPVVJDRSAoanVzdCBjYXVzaW5nIGEgcmUtc3VibWlzc2lvbiBvdmVyIGFuZCBv
dmVyCj4gYWdhaW4pIGFuZCB0aGUgZnJlZXplIHdpbGwgbmV2ZXIgY29tcGxldGUgKHRoZSBjb21t
YW5kcyBhcmUgc3RpbGwKPiBpbmZsaWdodCBmcm9tIHRoZSBxdWV1ZS0+Z191c2FnZV9jb3VudGVy
IHBlcnNwZWN0aXZlKS4KSWYgdGhlIHJlcXVlc3Qgc2V0IHRoZSBmbGFncyB0byBSRVFfRkFJTEZB
U1RfeHh4LCB3aWxsIGhhbmcgbG9uZyB0aW1lIGlmIHJlY29ubmVjdGlvbiBmYWlsZWQuClRoaXMg
aXMgbm90IGV4cGVjdGVkLgpBbm90aGVyLCBJZiB0aGUgY29udHJvbGxlciBpcyBub3QgbGl2ZSBh
bmQgdGhlIGNvbnRyb2xsZXIgaXMgZnJlZXplZCDvvIxmYXN0X2lvX2ZhaWxfdG1vIHdpbGwgbm90
IHdvcmsuClRoaXMgaXMgYWxzbyBub3QgZXhwZWN0ZWQuClNvIEkgdGhpbmsgZnJlZXppbmcgdGhl
IGNvbnRyb2xsZXIgd2hlbiByZWNvbm5lY3RpbmcgaXMgbm90IGdvb2QgaWRlYS4KSXQncyByZWFs
bHkgbm90IGdvb2QgYmVoYXZpb3IgdG8gdHJ5IGFnYWluIGFuZCBhZ2Fpbi4gVGhpcyBpcyBhdCBs
ZWFzdCBiZXR0ZXIgdGhhbiByZXF1ZXN0IGhhbmcgbG9uZyB0aW1lLgo+IAo+IFNvIEkgdGhpbmsg
d2Ugc2hvdWxkIHN0aWxsIHN0YXJ0IHF1ZXVlIGZyZWV6ZSBiZWZvcmUgd2UgcXVpZXNjZQo+IHRo
ZSBxdWV1ZXMuCldlIHNob3VsZCB1bnF1aWVzY2UgYW5kIHVuZnJlZXplIHRoZSBxdWV1ZXMgd2hl
biByZWNvbm5lY3RpbmcsIG90aGVyd2lzZSBmYXN0X2lvX2ZhaWxfdG1vIHdpbGwgbm90IHdvcmsu
Cj4gCj4gSSBzdGlsbCBkb24ndCBzZWUgaG93IHRoZSBtcGF0aCBOT1dBSVQgc3VnZ2VzdGlvbiB3
b3JrcyBlaXRoZXIuLi4KbXBhdGggd2lsbCBxdWV1dWUgcmVxdWVzdCB0byBvdGhlciBsaXZlIHBh
dGggb3IgcmVxdWV1ZSB0aGUgcmVxdWVzdChpZiBubyB1c2VkIHBhdGgpLCBzbyBpdCB3aWxsIG5v
dCB3YWl0Lgo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
