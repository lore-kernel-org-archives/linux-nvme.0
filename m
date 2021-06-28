Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CDDC48BC2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 01:11:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DDA8619C6
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DDA8619C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5219vxYcJ0R2pYAWItufoP0AsguHRtUiBU59A4e+EY=; b=QkJsaEYiYEsUugLf+iQlo+OIKu
	GPfFaqYfLq41Pz9Vb5Q4ZsnH71zLJhtsHeI/77wUBnNCtspDwom1t5zJOMMoh1ajsgy0GB/XgiIU7
	zfSKbSEiXVyqejjmBwT1j3rZ86aIZu06xpSpJoQs9m0Z9LcJ99blgZQj80fuJO3nBTSQIt91q4X1N
	jaFK4Zkf7fSDtY3nEedqKOyeAV8Hv4j6VmzinxB6oKFSefywawIQQYT7vscn5jay0scUWhj1e3gBw
	HScv+M6ggNwbgDI3lQ/f7a/EeQsDLR5tupF8XhaJ4xpjQe4RfRfUGKPNSCYfsnz6MPd0LIR3yjTz5
	imZI+VbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxfnZ-006Ng9-VC; Mon, 28 Jun 2021 01:10:53 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxfnV-006Nfi-0K
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 01:10:51 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GCqCh3cD0zXlv9;
 Mon, 28 Jun 2021 09:05:20 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:10:36 +0800
Received: from [10.169.59.115] (10.169.59.115) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 28 Jun 2021 09:10:36 +0800
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: James Smart <jsmart2021@gmail.com>, Hannes Reinecke <hare@suse.de>, "Sagi
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
From: Chao Leng <lengchao@huawei.com>
Message-ID: <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
Date: Mon, 28 Jun 2021 09:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <caa3759f-9a72-5e3b-9097-700132e4ab63@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.59.115]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_181049_445905_F3E67E95 
X-CRM114-Status: GOOD (  18.96  )
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

CgpPbiAyMDIxLzYvMjcgMjE6MzksIEphbWVzIFNtYXJ0IHdyb3RlOgo+IE9uIDYvMjYvMjAyMSA1
OjA5IEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDYvMjYvMjEgMzowMyBBTSwgQ2hh
byBMZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzYvMjQgMTY6MTAsIEhhbm5lcyBSZWlu
ZWNrZSB3cm90ZToKPj4+PiBPbiA2LzI0LzIxIDk6MjkgQU0sIENoYW8gTGVuZyB3cm90ZToKPj4+
Pj4KPj4+Pj4KPj4+Pj4gT24gMjAyMS82LzI0IDEzOjUxLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
Cj4+Pj4+PiBPbiA2LzIzLzIxIDExOjM4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4+Pj4+
Cj4+Pj4+Pj4+IEhpIGFsbCwKPj4+Pj4+Pj4KPj4+Pj4+Pj4gY29tbWl0IGYyNWY4ZWY3MGNlMiAo
Im52bWUtZmM6IHNob3J0LWNpcmN1aXQgcmVjb25uZWN0IHJldHJpZXMiKQo+Pj4+Pj4+PiBhbGxv
d2VkIHRoZSBmYyB0cmFuc3BvcnQgdG8gaG9ub3VyIHRoZSBETlIgYml0IGR1cmluZyByZWNvbm5l
Y3QKPj4+Pj4+Pj4gcmV0cmllcywgYWxsb3dpbmcgdG8gc3BlZWQgdXAgZXJyb3IgcmVjb3Zlcnku
Cj4+Pj4+Pj4KPj4+Pj4+PiBIb3cgZG9lcyB0aGlzIHNwZWVkIHVwIGVycm9yIHJlY292ZXJ5Pwo+
Pj4+Pj4KPj4+Pj4+IFdlbGwsIG5vdCBleGFjdGx5IGVycm9yIHJlY292ZXJ5IChhcyB0aGVyZSBp
cyBub3RoaW5nIHRvIHJlY292ZXIpLgo+Pj4+Pj4gQnV0IHdlIHdvbid0IGF0dGVtcHQgcG9pbnRs
ZXNzIHJldHJpZXMsIHRoZXJlYnkgcmVkdWNpbmcgdGhlIG5vaXNlIGluCj4+Pj4+PiB0aGUgbWVz
c2FnZSBsb2cuCj4+Pj4+IFRoaXMgY29uZmxpY3Qgd2l0aCB0aGUgdGNwIGFuZCByZG1hIHRhcmdl
dC4KPj4+Pj4gWW91IG1heSBuZWVkIHRvIGRlbGV0ZSB0aGUgaW1wcm9wZXIgTlZNRV9TQ19ETlIg
YXQgdGhlIHRhcmdldC4KPj4+Pj4gSG93ZXZlciwgdGhpcyB3aWxsIGNhdXNlIGNvbXBhdGliaWxp
dHkgaXNzdWVzIGJldHdlZW4gZGlmZmVyZW50IHZlcnNpb25zLgo+Pj4+Cj4+Pj4gV2hpY2ggb25l
cz8KPj4+IEluIG1hbnkgc2NlbmFyaW9zLCB0aGUgZGVzdGluYXRpb24gc2V0cyBETlIgZm9yIGFi
bm9ybWFsIHBhY2tldHMsCj4+PiBidXQgZWFjaCBuZXcgY29ubmVjdGlvbiBtYXkgbm90IGhhdmUg
dGhlIHNhbWUgZXJyb3IuCj4+Cj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIG9ubHkgZm9yIHRoZSBE
TlIgYml0IHNldCBpbiByZXNwb25zZSB0byB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQuCj4+IElmIHRo
ZSB0YXJnZXQgaXMgbm90IGFibGUgdG8gcHJvY2VzcyB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQsIGJ1
dCBtYXkgYmUgc28gaW4gdGhlIGZ1dHVyZSBpdCByZWFsbHkgc2hvdWxkIG5vdCBzZXQgdGhlIERO
UiBiaXQuCj4+Cj4+Pj4gSSBjaGVja2VkIHRoZSBETlIgdXNhZ2UgaW4gdGhlIHRhcmdldCBjb2Rl
LCBhbmQgdGhleSBzZWVtIHRvIHNldCBpdAo+Pj4+IGNvcnJlY3RseSAoaWUgdGhlIHJlc3VsdCB3
b3VsZCBub3QgY2hhbmdlIHdoZW4gdGhlIGNvbW1hbmQgaXMgcmV0cmllZCkuCj4+Pj4gV2l0aCB0
aGUgcG9zc2libGUgZXhjZXB0aW9uIG9mIEVOT1NQQyBoYW5kbGluZywgYXMgdGhpcyBpcyBhcmd1
YWJseQo+Pj4+IGR5bmFtaWMgYW5kIG1pZ2h0IGNoYW5nZSB3aXRoIGEgcmV0cnkuCj4+PiBUaGUg
RE5SIHN0YXR1cyBvZiB0aGUgb2xkIGNvbm5lY3Rpb24gbWF5IG5vdCBiZSByZWxldmFudCB0byB0
aGUgcmUtZXN0YWJsaXNoZWQgY29ubmVjdGlvbi4KPj4KPj4gU2VlIGFib3ZlLgo+PiBXZSBhcmUg
anVzdCBjaGVja2luZyB0aGUgRE5SIHNldHRpbmdzIGZvciB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQg
KG9yIGFueSBvdGhlciBjb21tYW5kcyBiZWluZyBzZW50IGR1cmluZyBpbml0aWFsIGNvbnRyb2xs
ZXIgY29uZmlndXJhdGlvbikuCj4+IElmIHRoYXQgZmFpbHMgdGhlIGNvbm5lY3QgbmV2ZXIgd2Fz
IHByb3Blcmx5IGluaXRpYWxpemVkOyBpZiB0aGUgY29udHJvbGxlciB3b3VsZCByZXR1cm4gYSBk
aWZmZXJlbnQgc3RhdHVzIGFmdGVyIHJlY29ubmVjdCBpdCBzaW1wbHkgc2hvdWxkIG5vdCBzZXQg
dGhlIEROUiBiaXQgLi4uCj4+Cj4+IENoZWVycywKPj4KPj4gSGFubmVzCj4gCj4gQWdyZWVkLiBT
aW5jZSAxLjMgc3BlYyBzYXlzOiAiSWYgc2V0IHRvIOKAmDHigJksIGluZGljYXRlcyB0aGF0IGlm
IHRoZSBzYW1lIGNvbW1hbmQgaXMgcmUtc3VibWl0dGVkIHRvIGFueSBjb250cm9sbGVyIGluIHRo
ZSBOVk0gc3Vic3lzdGVtLCB0aGVuIHRoYXQgcmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0
ZWQgdG8gZmFpbC4iCkFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgcHJvdG9jb2ws
IHRoaXMgaXMgbm90IHN0cmljdGx5IGltcGxlbWVudGVkIG9uIHRoZSB0YXJnZXQgc2lkZS4KSW4g
bnZtZS90YXJnZXQsIHRoZXJlIGFyZSBtYW55IGV4dGVybmFsIGVycm9ycywgdGhlIEROUiBpcyBz
ZXQgdG8gMS4KRm9yIGV4YW1wbGUsIGFib3JtYWwgZmFicmljcyBjbWQuCj4gCj4gVGh1cyBpZiB0
aGUgaW5pdGlhbCBjb25uZWN0IGZhaWxzIGluIHRoaXMgbWFubmVyLCBhbnkgbmV3IGFzc29jaWF0
aW9uIHdpbGwgYmUgb24gYSBkaWZmZXJlbnQgY29udHJvbGxlciwgd2hlcmUgaXQgaXMgbm93IGV4
cGVjdGVkIGNvbm5lY3Qgb24gdGhhdCBjb250cm9sbGVyIHdpbGwgZmFpbCB0b28uwqAgVGh1cyAt
IHdoeSBjb250aW51ZSB0byBjb25uZWN0IHdoZW4gaXQncyBleHBlY3RlZCBlYWNoIHdpbGwgZmFp
bC4KQWdyZWUuCldlIHNob3VsZCBub3QgYXR0ZW1wdCB0byByZS1lc3RhYmxpc2ggdGhlIGNvbm5l
Y3Rpb24gaWYgdGFyZ2V0IGNhbiBub3Qgd29yayBkdWUgdG8gdGFyZ2V0IGlubmVyIGVycm9yIC4K
SG93ZXZlciwgbm93ICB0YXJnZXQgZG9lcyBub3QgYmVoYXZlIGV4YWN0bHkgbGlrZSB0aGlzLCBz
byB0aGVyZSBhcmUgY29uZmxpY3RzIGFuZCBjb21wYXRpYmlsaXR5IGlzc3Vlcy4KPiAKPiAtLSBq
YW1lcwo+IC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
