Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB3C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:49:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A975364EFC
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 09:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A975364EFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u5GKHCCGJdLoGILNM6kLaYT+FuyokZLYUuawBBtbbZ8=; b=gXw9sC3PE8/xiMDGcIni8rAPY
	XcmP+N6LqBPhwlQXfT+e9YeTd9W72sBdu+xp9ZDBoY0NcjH7tGo4DdCv6RcEaaDE/WiFlysFiRMKz
	Z7w9OZPO3xw9kwmVdXsehxxxHKxFpNV++N7dDAmDmAvQHjYlhHew43QNfG2y7rHW30DDzroJOVj3d
	tSqvRcYJj8CyzLcB0XOlDw/rxlCrT2Cd7e2/lc74v2EVtoD8KRuQgQyAAYupddRjSHxd33x7DWBVZ
	iUfdknGm6Mo2vHeUAeCANV9TbgDC0axuWcDh/KAmT/jPHcYTAX/cUGzerxl8msgcPSwKpQgn2H1Ut
	16j0375Yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lH1ed-0006Mu-66; Tue, 02 Mar 2021 09:49:23 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lH1eZ-0006MA-Ep
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 09:49:20 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DqXMM6X1bzWGZf
 for <linux-nvme@lists.infradead.org>; Tue,  2 Mar 2021 17:46:23 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 2 Mar 2021 17:49:06 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 2 Mar
 2021 17:49:05 +0800
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
To: Hannes Reinecke <hare@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
Date: Tue, 2 Mar 2021 17:49:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme709-chm.china.huawei.com (10.1.199.105) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_044919_767918_D747A06D 
X-CRM114-Status: GOOD (  18.47  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzMvMiAxNTo0OCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IE9uIDIvMjcvMjEg
MTA6MzAgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS8yLzI3IDE3OjEyLCBI
YW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiAyLzI0LzIxIDY6NTkgQU0sIENoYW8gTGVuZyB3
cm90ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS8yLzI0IDc6MjEsIEtlaXRoIEJ1c2NoIHdyb3Rl
Ogo+Pj4+PiBPbiBUdWUsIEZlYiAyMywgMjAyMSBhdCAwMzoyNjowMlBNICswODAwLCBDaGFvIExl
bmcgd3JvdGU6Cj4+Pj4+PiBBIGNyYXNoIGhhcHBlbnMgd2hlbiBzZXQgZmVhdHVyZShOVk1FX0ZF
QVRfTlVNX1FVRVVFUykgdGltZW91dCBpbiBudm1lCj4+Pj4+PiBvdmVyIHJkbWEocm9jZSkgcmVj
b25uZWN0aW9uLCB0aGUgcmVhc29uIGlzIHVzZSB0aGUgcXVldWUgd2hpY2ggaXMgbm90Cj4+Pj4+
PiBhbGxvY2VkLgo+Pj4+Pj4KPj4+Pj4+IElmIGl0IGlzIG5vdCBkaXNjb3ZlcnkgYW5kIG5vIGlv
IHF1ZXVlcywgdGhlIGNvbm5lY3Rpb24gc2hvdWxkIGZhaWwuCj4+Pj4+Cj4+Pj4+IElmIHlvdSdy
ZSBnZXR0aW5nIGEgdGltZW91dCwgd2UgbmVlZCB0byBxdWl0IGluaXRpYWxpemF0aW9uLiBIYW5u
ZXMKPj4+Pj4gYXR0ZW1wdGVkIG1ha2luZyB0aGF0IHN0YXR1cyB2aXNpYmxlIGZvciBmYWJyaWNz
IGhlcmU6Cj4+Pj4+Cj4+Pj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9s
aW51eC1udm1lLzIwMjEtSmFudWFyeS8wMjIzNTMuaHRtbAo+Pj4+Pgo+Pj4+IEkga25vdyB0aGUg
cGF0Y2guIEl0IGNhbiBub3Qgc29sdmUgdGhlIHNjZW5hcmlvOiB0YXJnZXQgbWF5IGJlIGFuCj4+
Pj4gYXR0YWNrZXIgb3IgdGhlIHRhcmdldCBiZWhhdmlvciBpcyBpbmNvcnJlY3QuCj4+Pj4gSWYg
dGFyZ2V0IHJldHVybiAwIGlvIHF1ZXVlcyBvciByZXR1cm4gb3RoZXIgZXJyb3IgY29kZSwgdGhl
IGNyYXNoIHdpbGwKPj4+PiBzdGlsbCBoYXBwZW4uIFdlIHNob3VsZCBub3QgYWxsb3cgdGhpcyB0
byBoYXBwZW4uCj4+PiBJJ20gZnVsbHkgd2l0aCB5b3UgdGhhdCB3ZSBzaG91bGRuJ3QgY3Jhc2gs
IGJ1dCBhdCB0aGUgc2FtZSB0aW1lIGEKPj4+IHZhbHVlIG9mICcwJyBmb3IgdGhlIG51bWJlciBv
ZiBJL08gcXVldWVzIGlzIGNvbnNpZGVyZWQgdmFsaWQuCj4+PiBTbyB3ZSBzaG91bGQgZml4IHRo
ZSBjb2RlIHRvIGhhbmRsZSB0aGlzIHNjZW5hcmlvLCBhbmQgbm90IGRpc2FsbG93aW5nCj4+PiB6
ZXJvIEkvTyBxdWV1ZXMuCj4+ICcwJyBJL08gcXVldWVzIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2Ug
dG8gbnZtZSBvdmVyIGZhYnJpY3MsIGl0IGlzCj4+IGRpZmZlcmVudCB3aXRoIG52bWUgb3ZlciBw
Y2kuIElmIHRoZXJlIGlzIHNvbWUgYnVnIHdpdGggdGFyZ2V0LCB3ZSBjYW4KPj4gZGVidWcgaXQg
aW4gdGFyZ2V0IGluc3RlYWQgb2YgdXNlIGFkbWluIHF1ZXVlIGluIGhvc3QuCj4+IHRhcmdldCBt
YXkgYmUgYW4gYXR0YWNrZXIgb3IgdGhlIHRhcmdldCBiZWhhdmlvciBpcyBpbmNvcnJlY3QuIFNv
IHdlCj4+IHNob3VsZCBhdm9pZCBjcmFzaC4gQW5vdGhlciBvcHRpb246IHByb2hpYml0wqAgcmVx
dWVzdCBkZWxpdmVyeSBpZgo+PiBpbyBxdWV1ZSBkbyBub3QgY3JlYXRlZC4KPj4gSSB0aGluayBm
YWlsZWQgY29ubmVjdGlvbiB3aXRoICcwJyBJL08gcXVldWVzIGlzIGEgYmV0dGVyIGNob2ljZS4K
PiAKPiBNaWdodCBiZSwgYnV0IHRoYXQncyBub3QgZm9yIG1lIHRvIGRlY2lkZS4KPiBJIHRyaWVk
IHRoYXQgaW5pdGlhbGx5LCBidXQgdGhhdCBwYXRjaCBnb3QgcmVqZWN0ZWQgYXMgX3RlY2huaWNh
bGx5XyB0aGUKPiBjb250cm9sbGVyIGlzIHJlYWNoYWJsZSB2aWEgaXRzIGFkbWluIHF1ZXVlLgpJ
IGtub3cgYWJvdXQgeW91ciBwYXRjaC4gVGhhdCBwYXRjaCBmYWlsZWQgY29ubmVjdGlvbiBmb3Ig
YWxsIHRyYW5zcG9ydHMuCkl0IGlzIG5vdCBnb29kIGZvciBwY2llIHRyYW5zcG9ydCwgdGhlIGNv
bnRyb2xsZXIgY2FuIGFjY2VwdCBhZG1pbgpjb21tYW5kcyB0byBnZXQgc29tZSBkaWFnbm9zdGlj
cyAocGVyaGFwcyBhbiBlcnJvciBsb2cgcGFnZSksIHRoaXMgaXMKa2VpdGgncyB0aG91Z2h0cy4K
PiBTYWdpPyBDaHJpc3RvcGg/Cj4gQXJlIGNvbnRyb2xsZXJzIHdpdGggMCBJL08gcXVldWVzIHZh
bGlkIG9yIGlzIHRoaXMgYW4gZXJyb3IgY29uZGl0aW9uPwo+IAo+IENoZWVycywKPiAKPiBIYW5u
ZXMKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
