Return-Path: <SRS0=60sM=IA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C637DC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:48:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2529B61494
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Mar 2021 07:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529B61494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:To:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9aDjhBzEjOTOlvk/AeT4yhCD4aX5gX3mrXeqrC0wbyo=; b=2uEtrbR0BgUkBO0wo2z2iqjaNZ
	mv/udd+PffjmQttG+tBtRjyEwz7eXWNvlyDe4KMb9Gzv9XRp75oBDxDwGjbj4HHhBxbGN+UrUWZht
	ZqoDmG/Q47cYOLsnZ0S9R5k8v7R5SnzhVkMcU8wl4izBOQVQHm6+I5NdNMh5fHweOS+HzgW7d1Q2l
	wYxRME/lJqi/2yJHfwO8brQCV+xFPD5ZL4o6x6q3tDIQlhdvTW6tjGiMFIRQmSrExp2e/M+0998e+
	2IjM/rpVbII3i0+sinn2GDGiA9Gdmlq6KsUuc67GGccSAz52PKKFY9TE0vvBsMOQ8PE1fS2NrWfYS
	LdDE/Fsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGzlS-0007y3-4y; Tue, 02 Mar 2021 07:48:18 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGzlO-0007xB-Az
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 07:48:15 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 174E8ADDD;
 Tue,  2 Mar 2021 07:48:13 +0000 (UTC)
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Message-ID: <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
Date: Tue, 2 Mar 2021 08:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_024814_509796_83DBBABE 
X-CRM114-Status: GOOD (  23.57  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNy8yMSAxMDozMCBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+IAo+IAo+IE9uIDIwMjEvMi8y
NyAxNzoxMiwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+PiBPbiAyLzI0LzIxIDY6NTkgQU0sIENo
YW8gTGVuZyB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gMjAyMS8yLzI0IDc6MjEsIEtlaXRoIEJ1c2No
IHdyb3RlOgo+Pj4+IE9uIFR1ZSwgRmViIDIzLCAyMDIxIGF0IDAzOjI2OjAyUE0gKzA4MDAsIENo
YW8gTGVuZyB3cm90ZToKPj4+Pj4gQSBjcmFzaCBoYXBwZW5zIHdoZW4gc2V0IGZlYXR1cmUoTlZN
RV9GRUFUX05VTV9RVUVVRVMpIHRpbWVvdXQgaW4gbnZtZQo+Pj4+PiBvdmVyIHJkbWEocm9jZSkg
cmVjb25uZWN0aW9uLCB0aGUgcmVhc29uIGlzIHVzZSB0aGUgcXVldWUgd2hpY2ggaXMgbm90Cj4+
Pj4+IGFsbG9jZWQuCj4+Pj4+Cj4+Pj4+IElmIGl0IGlzIG5vdCBkaXNjb3ZlcnkgYW5kIG5vIGlv
IHF1ZXVlcywgdGhlIGNvbm5lY3Rpb24gc2hvdWxkIGZhaWwuCj4+Pj4KPj4+PiBJZiB5b3UncmUg
Z2V0dGluZyBhIHRpbWVvdXQsIHdlIG5lZWQgdG8gcXVpdCBpbml0aWFsaXphdGlvbi4gSGFubmVz
Cj4+Pj4gYXR0ZW1wdGVkIG1ha2luZyB0aGF0IHN0YXR1cyB2aXNpYmxlIGZvciBmYWJyaWNzIGhl
cmU6Cj4+Pj4KPj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgt
bnZtZS8yMDIxLUphbnVhcnkvMDIyMzUzLmh0bWwKPj4+Pgo+Pj4gSSBrbm93IHRoZSBwYXRjaC4g
SXQgY2FuIG5vdCBzb2x2ZSB0aGUgc2NlbmFyaW86IHRhcmdldCBtYXkgYmUgYW4KPj4+IGF0dGFj
a2VyIG9yIHRoZSB0YXJnZXQgYmVoYXZpb3IgaXMgaW5jb3JyZWN0Lgo+Pj4gSWYgdGFyZ2V0IHJl
dHVybiAwIGlvIHF1ZXVlcyBvciByZXR1cm4gb3RoZXIgZXJyb3IgY29kZSwgdGhlIGNyYXNoIHdp
bGwKPj4+IHN0aWxsIGhhcHBlbi4gV2Ugc2hvdWxkIG5vdCBhbGxvdyB0aGlzIHRvIGhhcHBlbi4K
Pj4gSSdtIGZ1bGx5IHdpdGggeW91IHRoYXQgd2Ugc2hvdWxkbid0IGNyYXNoLCBidXQgYXQgdGhl
IHNhbWUgdGltZSBhCj4+IHZhbHVlIG9mICcwJyBmb3IgdGhlIG51bWJlciBvZiBJL08gcXVldWVz
IGlzIGNvbnNpZGVyZWQgdmFsaWQuCj4+IFNvIHdlIHNob3VsZCBmaXggdGhlIGNvZGUgdG8gaGFu
ZGxlIHRoaXMgc2NlbmFyaW8sIGFuZCBub3QgZGlzYWxsb3dpbmcKPj4gemVybyBJL08gcXVldWVz
Lgo+ICcwJyBJL08gcXVldWVzIGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UgdG8gbnZtZSBvdmVyIGZh
YnJpY3MsIGl0IGlzCj4gZGlmZmVyZW50IHdpdGggbnZtZSBvdmVyIHBjaS4gSWYgdGhlcmUgaXMg
c29tZSBidWcgd2l0aCB0YXJnZXQsIHdlIGNhbgo+IGRlYnVnIGl0IGluIHRhcmdldCBpbnN0ZWFk
IG9mIHVzZSBhZG1pbiBxdWV1ZSBpbiBob3N0Lgo+IHRhcmdldCBtYXkgYmUgYW4gYXR0YWNrZXIg
b3IgdGhlIHRhcmdldCBiZWhhdmlvciBpcyBpbmNvcnJlY3QuIFNvIHdlCj4gc2hvdWxkIGF2b2lk
IGNyYXNoLiBBbm90aGVyIG9wdGlvbjogcHJvaGliaXTCoCByZXF1ZXN0IGRlbGl2ZXJ5IGlmCj4g
aW8gcXVldWUgZG8gbm90IGNyZWF0ZWQuCj4gSSB0aGluayBmYWlsZWQgY29ubmVjdGlvbiB3aXRo
ICcwJyBJL08gcXVldWVzIGlzIGEgYmV0dGVyIGNob2ljZS4KCk1pZ2h0IGJlLCBidXQgdGhhdCdz
IG5vdCBmb3IgbWUgdG8gZGVjaWRlLgpJIHRyaWVkIHRoYXQgaW5pdGlhbGx5LCBidXQgdGhhdCBw
YXRjaCBnb3QgcmVqZWN0ZWQgYXMgX3RlY2huaWNhbGx5XyB0aGUKY29udHJvbGxlciBpcyByZWFj
aGFibGUgdmlhIGl0cyBhZG1pbiBxdWV1ZS4KU2FnaT8gQ2hyaXN0b3BoPwpBcmUgY29udHJvbGxl
cnMgd2l0aCAwIEkvTyBxdWV1ZXMgdmFsaWQgb3IgaXMgdGhpcyBhbiBlcnJvciBjb25kaXRpb24/
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4
ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6
IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=
