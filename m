Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4129FC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 06:30:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2EE61C91
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 06:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2EE61C91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTKX4g1Pg8EWjM8puBnU0TjfqvZ/nS9FKRGQgGGJUyU=; b=w5eHg1EB7E64SVkpkvLCtNOpT0
	XyB2pUb/zR+/O+Vz4OCCnElHbxEASeVSbN7LrPDZ1of7aTLr/ZSEN+ke9YA5WeHZPq3CnDTGEtelh
	SFOQGqH9faA3TsoWUn3UUcIPt/I83ACmItbhyy9yumUrT+gWXht6FJoXgcd6E4EA5xfJ3uqfYu/cn
	Ls1jZ1Qy9VrMI/pei2CY3i+mYDRYvFR5SbIsNd008wzAQF2AwlNApcbATruKWJgvEh4ICEJKHVXBm
	ig0CAdW7SbToCEhrUY4L8tRGuxVYujVRr51YuWguepPhOkb9nB2ZIEMkUeuiy73Hs5Jem+qaqlBVr
	PxlJ2tlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1NXx-00G8b4-Dl; Thu, 08 Jul 2021 06:30:05 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1NXs-00G8ZR-L9
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 06:30:03 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GL5sQ1d2Gz79C8;
 Thu,  8 Jul 2021 14:26:18 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 14:29:46 +0800
Received: from [10.169.59.115] (10.169.59.115) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 8 Jul 2021 14:29:45 +0800
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>, "Sagi
 Grimberg" <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: Keith Busch <keith.busch@wdc.com>, <linux-nvme@lists.infradead.org>
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
 <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
 <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
Date: Thu, 8 Jul 2021 14:29:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.59.115]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_233001_206526_1F76A8E9 
X-CRM114-Status: GOOD (  23.05  )
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

CgpPbiAyMDIxLzYvMjkgMTk6MDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA2LzI4LzIx
IDM6MTAgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS82LzI3IDIxOjM5LCBK
YW1lcyBTbWFydCB3cm90ZToKPj4+IE9uIDYvMjYvMjAyMSA1OjA5IEFNLCBIYW5uZXMgUmVpbmVj
a2Ugd3JvdGU6Cj4+Pj4gT24gNi8yNi8yMSAzOjAzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+
Cj4+Pj4+Cj4+Pj4+IE9uIDIwMjEvNi8yNCAxNjoxMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+
Pj4+Pj4gT24gNi8yNC8yMSA5OjI5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pj4KPj4+Pj4+
Pgo+Pj4+Pj4+IE9uIDIwMjEvNi8yNCAxMzo1MSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+
Pj4+PiBPbiA2LzIzLzIxIDExOjM4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+PiBIaSBhbGwsCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBjb21taXQgZjI1ZjhlZjcw
Y2UyICgibnZtZS1mYzogc2hvcnQtY2lyY3VpdCByZWNvbm5lY3QgcmV0cmllcyIpCj4+Pj4+Pj4+
Pj4gYWxsb3dlZCB0aGUgZmMgdHJhbnNwb3J0IHRvIGhvbm91ciB0aGUgRE5SIGJpdCBkdXJpbmcg
cmVjb25uZWN0Cj4+Pj4+Pj4+Pj4gcmV0cmllcywgYWxsb3dpbmcgdG8gc3BlZWQgdXAgZXJyb3Ig
cmVjb3ZlcnkuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSG93IGRvZXMgdGhpcyBzcGVlZCB1cCBlcnJv
ciByZWNvdmVyeT8KPj4+Pj4+Pj4KPj4+Pj4+Pj4gV2VsbCwgbm90IGV4YWN0bHkgZXJyb3IgcmVj
b3ZlcnkgKGFzIHRoZXJlIGlzIG5vdGhpbmcgdG8gcmVjb3ZlcikuCj4+Pj4+Pj4+IEJ1dCB3ZSB3
b24ndCBhdHRlbXB0IHBvaW50bGVzcyByZXRyaWVzLCB0aGVyZWJ5IHJlZHVjaW5nIHRoZSBub2lz
ZSBpbgo+Pj4+Pj4+PiB0aGUgbWVzc2FnZSBsb2cuCj4+Pj4+Pj4gVGhpcyBjb25mbGljdCB3aXRo
IHRoZSB0Y3AgYW5kIHJkbWEgdGFyZ2V0Lgo+Pj4+Pj4+IFlvdSBtYXkgbmVlZCB0byBkZWxldGUg
dGhlIGltcHJvcGVyIE5WTUVfU0NfRE5SIGF0IHRoZSB0YXJnZXQuCj4+Pj4+Pj4gSG93ZXZlciwg
dGhpcyB3aWxsIGNhdXNlIGNvbXBhdGliaWxpdHkgaXNzdWVzIGJldHdlZW4gZGlmZmVyZW50IHZl
cnNpb25zLgo+Pj4+Pj4KPj4+Pj4+IFdoaWNoIG9uZXM/Cj4+Pj4+IEluIG1hbnkgc2NlbmFyaW9z
LCB0aGUgZGVzdGluYXRpb24gc2V0cyBETlIgZm9yIGFibm9ybWFsIHBhY2tldHMsCj4+Pj4+IGJ1
dCBlYWNoIG5ldyBjb25uZWN0aW9uIG1heSBub3QgaGF2ZSB0aGUgc2FtZSBlcnJvci4KPj4+Pgo+
Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIG9ubHkgZm9yIHRoZSBETlIgYml0IHNldCBpbiByZXNw
b25zZSB0byB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQuCj4+Pj4gSWYgdGhlIHRhcmdldCBpcyBub3Qg
YWJsZSB0byBwcm9jZXNzIHRoZSAnY29ubmVjdCcgY29tbWFuZCwgYnV0IG1heSBiZSBzbyBpbiB0
aGUgZnV0dXJlIGl0IHJlYWxseSBzaG91bGQgbm90IHNldCB0aGUgRE5SIGJpdC4KPj4+Pgo+Pj4+
Pj4gSSBjaGVja2VkIHRoZSBETlIgdXNhZ2UgaW4gdGhlIHRhcmdldCBjb2RlLCBhbmQgdGhleSBz
ZWVtIHRvIHNldCBpdAo+Pj4+Pj4gY29ycmVjdGx5IChpZSB0aGUgcmVzdWx0IHdvdWxkIG5vdCBj
aGFuZ2Ugd2hlbiB0aGUgY29tbWFuZCBpcyByZXRyaWVkKS4KPj4+Pj4+IFdpdGggdGhlIHBvc3Np
YmxlIGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxpbmcsIGFzIHRoaXMgaXMgYXJndWFibHkKPj4+
Pj4+IGR5bmFtaWMgYW5kIG1pZ2h0IGNoYW5nZSB3aXRoIGEgcmV0cnkuCj4+Pj4+IFRoZSBETlIg
c3RhdHVzIG9mIHRoZSBvbGQgY29ubmVjdGlvbiBtYXkgbm90IGJlIHJlbGV2YW50IHRvIHRoZSBy
ZS1lc3RhYmxpc2hlZCBjb25uZWN0aW9uLgo+Pj4+Cj4+Pj4gU2VlIGFib3ZlLgo+Pj4+IFdlIGFy
ZSBqdXN0IGNoZWNraW5nIHRoZSBETlIgc2V0dGluZ3MgZm9yIHRoZSAnY29ubmVjdCcgY29tbWFu
ZCAob3IgYW55IG90aGVyIGNvbW1hbmRzIGJlaW5nIHNlbnQgZHVyaW5nIGluaXRpYWwgY29udHJv
bGxlciBjb25maWd1cmF0aW9uKS4KPj4+PiBJZiB0aGF0IGZhaWxzIHRoZSBjb25uZWN0IG5ldmVy
IHdhcyBwcm9wZXJseSBpbml0aWFsaXplZDsgaWYgdGhlIGNvbnRyb2xsZXIgd291bGQgcmV0dXJu
IGEgZGlmZmVyZW50IHN0YXR1cyBhZnRlciByZWNvbm5lY3QgaXQgc2ltcGx5IHNob3VsZCBub3Qg
c2V0IHRoZSBETlIgYml0IC4uLgo+Pj4+Cj4+Pj4gQ2hlZXJzLAo+Pj4+Cj4+Pj4gSGFubmVzCj4+
Pgo+Pj4gQWdyZWVkLiBTaW5jZSAxLjMgc3BlYyBzYXlzOiAiSWYgc2V0IHRvIOKAmDHigJksIGlu
ZGljYXRlcyB0aGF0IGlmIHRoZSBzYW1lIGNvbW1hbmQgaXMgcmUtc3VibWl0dGVkIHRvIGFueSBj
b250cm9sbGVyIGluIHRoZSBOVk0gc3Vic3lzdGVtLCB0aGVuIHRoYXQgcmUtc3VibWl0dGVkIGNv
bW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iCj4+IEFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlv
biBvZiB0aGUgcHJvdG9jb2wsIHRoaXMgaXMgbm90IHN0cmljdGx5IGltcGxlbWVudGVkIG9uIHRo
ZSB0YXJnZXQgc2lkZS4KPj4gSW4gbnZtZS90YXJnZXQsIHRoZXJlIGFyZSBtYW55IGV4dGVybmFs
IGVycm9ycywgdGhlIEROUiBpcyBzZXQgdG8gMS4KPj4gRm9yIGV4YW1wbGUsIGFib3JtYWwgZmFi
cmljcyBjbWQuCj4gCj4gWWVzOyBidXQgYW4gYWJub3JtYWwgZmFicmljcyBjbWQgd2lsbCBiZSBh
Ym5vcm1hbCBldmVuIGFmdGVyIGEgcmVjb25uZWN0LgpTb3JyeSwgZGVsYXllZCByZXBseSBkdWUg
dG8gbGVhdmUuClRoZXJlIGFyZSBtYW55IHBvc3NpYmlsaXRpZXMgZm9yIGFibm9ybWFsIGZhYnJp
Y3MgY21kLgpJbiBzb21lIHNjZW5hcmlvcywgaWYgdGhlIGxpbmsgaXMgcmUtZXN0YWJsaXNoZWQs
IHRoZSBlcnJvciBtYXkgbm90IG9jY3VyIGFnYWluLApzdWNoIGFzIEhCQSBpbm5lciBlcnJvciwg
bmV0d29yayBpcyBhYm5vcm1hbCBvciBhdHRhY2tlZCBldGMuCj4gCj4+Pgo+Pj4gVGh1cyBpZiB0
aGUgaW5pdGlhbCBjb25uZWN0IGZhaWxzIGluIHRoaXMgbWFubmVyLCBhbnkgbmV3IGFzc29jaWF0
aW9uIHdpbGwgYmUgb24gYSBkaWZmZXJlbnQgY29udHJvbGxlciwgd2hlcmUgaXQgaXMgbm93IGV4
cGVjdGVkIGNvbm5lY3Qgb24gdGhhdCBjb250cm9sbGVyIHdpbGwgZmFpbCB0b28uwqAgVGh1cyAt
IHdoeSBjb250aW51ZSB0byBjb25uZWN0IHdoZW4gaXQncyBleHBlY3RlZCBlYWNoIHdpbGwgZmFp
bC4KPj4gQWdyZWUuCj4+IFdlIHNob3VsZCBub3QgYXR0ZW1wdCB0byByZS1lc3RhYmxpc2ggdGhl
IGNvbm5lY3Rpb24gaWYgdGFyZ2V0IGNhbiBub3Qgd29yayBkdWUgdG8gdGFyZ2V0IGlubmVyIGVy
cm9yIC4KPj4gSG93ZXZlciwgbm93wqAgdGFyZ2V0IGRvZXMgbm90IGJlaGF2ZSBleGFjdGx5IGxp
a2UgdGhpcywgc28gdGhlcmUgYXJlIGNvbmZsaWN0cyBhbmQgY29tcGF0aWJpbGl0eSBpc3N1ZXMu
Cj4gCj4gTm90ZTogd2UgbmV2ZXIgc2FpZCB0aGUgdGFyZ2V0IHNob3VsZCBfbm90XyBzZW5kIGEg
RE5SIHN0YXRlLiBXZSBvbmx5IHNhaWQgdGhlIHRhcmdldCBzaG91bGQgb25seSBzZXQgdGhlIERO
UiBiaXQgaWYgYSByZXRyeSAoZXZlbiBhZnRlciByZWNvbm5lY3Qgb3Igb24gYSBkaWZmZXJlbnQg
Y29udHJvbGxlcikgd2lsbCBub3QgY2hhbmdlIHRoZSByZXN1bHQuCj4gV2hpY2ggZnJvbSB3aGF0
IEkgY2FuIHNlZSBfaXNfIHRoZSBjYXNlLCBzbyBJIGRvIG5vdCBzZWUgYW55IGlzc3VlcyBoZXJl
Lgo+IAo+IFBsZWFzZSBnaXZlIGRldGFpbHMgZm9yIHRoZSBpc3N1ZXMgeW91IGFyZSBjb25jZXJu
ZWQgd2l0aC4KRm9yIGV4YW1wbGUsIGlmIGhvc3Qgc2VuZCBhIGZhYnJpYyBjbWQsIGJ1dCB0aGUg
ZmFicmljIGNtZCBpcyBwb2lzb25lZApkdWUgdG8gSEJBIGlubmVyIGVycm9yLCBhYm5vcm1hbCBv
ciBhdHRhY2tlZCBuZXR3b3JrLCBhbmQgdGhlbiB0aGUgdGFyZ2V0CnNldCB0aGUgRE5SIHRvIHJl
cGx5IHJlc3BvbnNlLiBJZiBkbyBub3QgcmVjb25uZWN0IGZvciBETlIgcmVzcG9uc2Ugb2YKb2xk
IGNvbm5lY3Rpb24sIHRodXMgdGhlIGNvbm5lY3RpbmcgY2FuIG5vdCBhb3RvIHJlY292ZXJ5LiBU
aGUgZmFicmljCmNtZCBwb2lzb25pbmcgbWF5IGJlIHRyYW5zaWVudCwgbWF5IHN1Y2Nlc3MgaWYg
dHJ5IGZvciByZWNvbm5lY3RpbmcuCnNvIHRyeSB0byByZWNvbm5lY3RpbmcgaXMgYSBiZXR0ZXIg
Y2hvaWNlLgpJZiBkbyBub3QgcmVjb25uZWN0IGZvciBETlIgcmVzcG9uc2UsIHRhcmdldCBzaG91
bGQgc2V0IEROUiBzdGF0ZSBqdXN0CmZvciB0YXJnZXQgaW5uZXIgZXJyb3IuCj4gCj4gQ2hlZXJz
LAo+IAo+IEhhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
