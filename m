Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC3AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:17:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EE764EEC
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 18:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EE764EEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r9cW/9WmHc8hj58+PB7myjj8mFquS8MW2sWAaNvzXpM=; b=ku6n6eHatyMYwF+lZsYq02rGO
	WM2zMeZXlRweXAoeIxJEJWLmGQw4PCTO8G8M76deQbJ06bf7c3P6aPkCLDdxY/8IPUqy0I7zRyA+J
	mpXNADXuFjYFh5iTJbWS23jotxAc29Zu0ZCLh9EbY8PXQaupS/kldCnT9LM8j6CfJ7SeurfzMKZG6
	LNd//bYRTl2OW5eAs1i9aG4aGak+BseuplAAPP9BSZrIo+5lEnCBb8II1qcpgODowVjHIIVZtf5va
	lDLJ6n7lZj0b/9s52yIpqLuPUWNo7maqgwFSSnBkIXhf58qpopJIuDf0HPDUXKJcznrruDgyGcxAs
	UsyLglfMQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHW3k-005yvu-Ob; Wed, 03 Mar 2021 18:17:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSzI-005GgX-Ut
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=IZ5pyEiIfMCcLj5wpfaB3683i6FLd50QQqO8ynSOnCI=; b=fULyH9JH21735vf9wlzYPWkrL8
 Mb6sNi9tIzL9/2J1h+iHrKLWh3JyrkU66bfGhwq2Py5b2zSwae8ZwwalBH0acjbIKAtvCC0kRX9Ip
 SaZufHQTyyXZQTWiykmUJpYW6nAyI2csvOGxJS2KJCYVfX7lBSPpOp3N5A80eWjy9qzLKy9C2XoMe
 RA/ID+9dYk6edoj46TCim1BaUd6o3u9YCUoH3raM6YrsCG/8zl82iFDEBUzXjwLhhcpU5jPwo245N
 mRwLJelLkYGd7cSxrYX2xiqwxc4X4omxIPAsiXTzqlSjZVmLoB8XClNd1UX/GPuzsRGSi7S74iUK7
 7SN2z/AQ==;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHHER-000zGd-VY
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 02:27:25 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DqyX13hhFz52F4;
 Wed,  3 Mar 2021 10:25:21 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 3 Mar 2021 10:27:02 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 3 Mar
 2021 10:27:02 +0800
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: Keith Busch <kbusch@kernel.org>
CC: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
 <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <399fd796-64c2-7d25-b0d8-0f445c4bb2dd@huawei.com>
Date: Wed, 3 Mar 2021 10:27:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_022725_358672_73A12295 
X-CRM114-Status: GOOD (  18.58  )
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

CgpPbiAyMDIxLzMvMyAyOjI0LCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUdWUsIE1hciAwMiwg
MjAyMSBhdCAwNTo0OTowNVBNICswODAwLCBDaGFvIExlbmcgd3JvdGU6Cj4+Cj4+Cj4+IE9uIDIw
MjEvMy8yIDE1OjQ4LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiAyLzI3LzIxIDEwOjMw
IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+IE9uIDIwMjEvMi8yNyAxNzoxMiwg
SGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+PiBPbiAyLzI0LzIxIDY6NTkgQU0sIENoYW8gTGVu
ZyB3cm90ZToKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT24gMjAyMS8yLzI0IDc6MjEsIEtlaXRoIEJ1
c2NoIHdyb3RlOgo+Pj4+Pj4+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDAzOjI2OjAyUE0gKzA4
MDAsIENoYW8gTGVuZyB3cm90ZToKPj4+Pj4+Pj4gQSBjcmFzaCBoYXBwZW5zIHdoZW4gc2V0IGZl
YXR1cmUoTlZNRV9GRUFUX05VTV9RVUVVRVMpIHRpbWVvdXQgaW4gbnZtZQo+Pj4+Pj4+PiBvdmVy
IHJkbWEocm9jZSkgcmVjb25uZWN0aW9uLCB0aGUgcmVhc29uIGlzIHVzZSB0aGUgcXVldWUgd2hp
Y2ggaXMgbm90Cj4+Pj4+Pj4+IGFsbG9jZWQuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IElmIGl0IGlzIG5v
dCBkaXNjb3ZlcnkgYW5kIG5vIGlvIHF1ZXVlcywgdGhlIGNvbm5lY3Rpb24gc2hvdWxkIGZhaWwu
Cj4+Pj4+Pj4KPj4+Pj4+PiBJZiB5b3UncmUgZ2V0dGluZyBhIHRpbWVvdXQsIHdlIG5lZWQgdG8g
cXVpdCBpbml0aWFsaXphdGlvbi4gSGFubmVzCj4+Pj4+Pj4gYXR0ZW1wdGVkIG1ha2luZyB0aGF0
IHN0YXR1cyB2aXNpYmxlIGZvciBmYWJyaWNzIGhlcmU6Cj4+Pj4+Pj4KPj4+Pj4+PiBodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIxLUphbnVhcnkvMDIy
MzUzLmh0bWwKPj4+Pj4+Pgo+Pj4+Pj4gSSBrbm93IHRoZSBwYXRjaC4gSXQgY2FuIG5vdCBzb2x2
ZSB0aGUgc2NlbmFyaW86IHRhcmdldCBtYXkgYmUgYW4KPj4+Pj4+IGF0dGFja2VyIG9yIHRoZSB0
YXJnZXQgYmVoYXZpb3IgaXMgaW5jb3JyZWN0Lgo+Pj4+Pj4gSWYgdGFyZ2V0IHJldHVybiAwIGlv
IHF1ZXVlcyBvciByZXR1cm4gb3RoZXIgZXJyb3IgY29kZSwgdGhlIGNyYXNoIHdpbGwKPj4+Pj4+
IHN0aWxsIGhhcHBlbi4gV2Ugc2hvdWxkIG5vdCBhbGxvdyB0aGlzIHRvIGhhcHBlbi4KPj4+Pj4g
SSdtIGZ1bGx5IHdpdGggeW91IHRoYXQgd2Ugc2hvdWxkbid0IGNyYXNoLCBidXQgYXQgdGhlIHNh
bWUgdGltZSBhCj4+Pj4+IHZhbHVlIG9mICcwJyBmb3IgdGhlIG51bWJlciBvZiBJL08gcXVldWVz
IGlzIGNvbnNpZGVyZWQgdmFsaWQuCj4+Pj4+IFNvIHdlIHNob3VsZCBmaXggdGhlIGNvZGUgdG8g
aGFuZGxlIHRoaXMgc2NlbmFyaW8sIGFuZCBub3QgZGlzYWxsb3dpbmcKPj4+Pj4gemVybyBJL08g
cXVldWVzLgo+Pj4+ICcwJyBJL08gcXVldWVzIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgdG8gbnZt
ZSBvdmVyIGZhYnJpY3MsIGl0IGlzCj4+Pj4gZGlmZmVyZW50IHdpdGggbnZtZSBvdmVyIHBjaS4g
SWYgdGhlcmUgaXMgc29tZSBidWcgd2l0aCB0YXJnZXQsIHdlIGNhbgo+Pj4+IGRlYnVnIGl0IGlu
IHRhcmdldCBpbnN0ZWFkIG9mIHVzZSBhZG1pbiBxdWV1ZSBpbiBob3N0Lgo+Pj4+IHRhcmdldCBt
YXkgYmUgYW4gYXR0YWNrZXIgb3IgdGhlIHRhcmdldCBiZWhhdmlvciBpcyBpbmNvcnJlY3QuIFNv
IHdlCj4+Pj4gc2hvdWxkIGF2b2lkIGNyYXNoLiBBbm90aGVyIG9wdGlvbjogcHJvaGliaXTCoCBy
ZXF1ZXN0IGRlbGl2ZXJ5IGlmCj4+Pj4gaW8gcXVldWUgZG8gbm90IGNyZWF0ZWQuCj4+Pj4gSSB0
aGluayBmYWlsZWQgY29ubmVjdGlvbiB3aXRoICcwJyBJL08gcXVldWVzIGlzIGEgYmV0dGVyIGNo
b2ljZS4KPj4+Cj4+PiBNaWdodCBiZSwgYnV0IHRoYXQncyBub3QgZm9yIG1lIHRvIGRlY2lkZS4K
Pj4+IEkgdHJpZWQgdGhhdCBpbml0aWFsbHksIGJ1dCB0aGF0IHBhdGNoIGdvdCByZWplY3RlZCBh
cyBfdGVjaG5pY2FsbHlfIHRoZQo+Pj4gY29udHJvbGxlciBpcyByZWFjaGFibGUgdmlhIGl0cyBh
ZG1pbiBxdWV1ZS4KPj4gSSBrbm93IGFib3V0IHlvdXIgcGF0Y2guIFRoYXQgcGF0Y2ggZmFpbGVk
IGNvbm5lY3Rpb24gZm9yIGFsbCB0cmFuc3BvcnRzLgo+PiBJdCBpcyBub3QgZ29vZCBmb3IgcGNp
ZSB0cmFuc3BvcnQsIHRoZSBjb250cm9sbGVyIGNhbiBhY2NlcHQgYWRtaW4KPj4gY29tbWFuZHMg
dG8gZ2V0IHNvbWUgZGlhZ25vc3RpY3MgKHBlcmhhcHMgYW4gZXJyb3IgbG9nIHBhZ2UpLCB0aGlz
IGlzCj4+IGtlaXRoJ3MgdGhvdWdodHMuCj4gCj4gV2UgY2FuIGNvbnRpbnVlIHRvIGFkbWluaXN0
cmF0ZSBhIGNvbnRyb2xsZXIgdGhhdCBkaWRuJ3QgY3JlYXRlIElPCj4gcXVldWVzLCBidXQgdGhl
IGNvbnRyb2xsZXIgbXVzdCBwcm92aWRlIGEgcmVzcG9uc2UgdG8gYWxsIGNvbW1hbmRzLiBJZgo+
IGl0IGRvZXNuJ3QsIHRoZSBjb250cm9sbGVyIHdpbGwgZWl0aGVyIGJlIHJlc2V0IG9yIGFiYW5k
b25lZC4gVGhpcwo+IHNob3VsZCBiZSB0aGUgc2FtZSBiZWhhdmlvciBmb3IgYW55IHRyYW5zcG9y
dCwgdGhvdWdoOyB0aGVyZSdzIG5vdGhpbmcKPiBzcGVjaWFsIGFib3V0IFBDSWUgZm9yIHRoYXQu
ClRob3VnaCBJIGRvbid0IHNlZSBhbnkgdXNlZnVsIHNjZW5hcmlvcyBmb3IgbnZtZSBvdmVyIGZh
YnJpYyBub3csClJlc2VydmVkIGZvciBmdXR1cmUgcG9zc2liaWxpdGllcyBtYXkgYmUgYSBiZXR0
ZXIgY2hvaWNlLgpJIHdpbGwgc2VuZCBhbm90aGVyIHBhdGNoLiBQcm9oaWJpdCByZXF1ZXN0IGRl
bGl2ZXJ5IGlmIHRoZSBxdWV1ZSBpcyBub3QKbGl2ZS4KCj4gLgo+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
