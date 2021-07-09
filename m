Return-Path: <SRS0=jeJI=MB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F3C07E99
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EE061279
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jul 2021 08:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EE061279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYLXRWFtZgLU7oiImBJLWWExZyndwNW46thjntg3z0s=; b=4fmLhPFEplUZFFXNo25j77/3fi
	CFxy/e0Rdmz3OWOr9H7vHaBgAqyJgYLy6rqYSUtGWVErSEOqXzMm2NTqVqs/Mdwg85oJKCdMYzDwz
	SfgOh9y5T+ihjHKAxatTKBBu5ruqvPHwY9UxSdP3s7gtKsh2IxW3QGz1wqOdj3/vZEhQZfTSy4M6T
	spzC/1WQCx4T+yxPzu1Olk46vMKtSuPgU6XVzVCL8U1F7T2L3zV4WeH/988Tb/4Td1WvLIVykN1Cc
	UNhLMRnhKccsUw2N637ZG/6wsNAL9r4ZooduaiLNjo1o1JhWbdrwhsHesB3sgoTOMWiwW+4ppjqSm
	hBiasD1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1lyB-0019wS-DG; Fri, 09 Jul 2021 08:34:47 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1ly7-0019uJ-GI
 for linux-nvme@lists.infradead.org; Fri, 09 Jul 2021 08:34:45 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLmbK1sFvzbbkW;
 Fri,  9 Jul 2021 16:31:25 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 9 Jul 2021 16:34:38 +0800
Received: from [10.169.59.115] (10.169.59.115) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 9 Jul 2021 16:34:37 +0800
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
 <28ec79af-beb0-8ef9-ab6a-d608a632ee2c@huawei.com>
 <0af5901a-4dab-70de-abda-00ed7f8cf45f@suse.de>
 <c5ddf523-af8c-eae0-03fc-6c64d0df9e7c@huawei.com>
 <f4d95ae8-7c7b-275b-0436-863c5add25cb@gmail.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <4ae04d12-cb34-45bb-5a01-54802d2a94b9@huawei.com>
Date: Fri, 9 Jul 2021 16:34:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <f4d95ae8-7c7b-275b-0436-863c5add25cb@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.169.59.115]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210709_013443_955798_AA8C5AFB 
X-CRM114-Status: GOOD (  27.19  )
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

CgpPbiAyMDIxLzcvOSAxMjo1NywgSmFtZXMgU21hcnQgd3JvdGU6Cj4gT24gNy83LzIwMjEgMTE6
MjkgUE0sIENoYW8gTGVuZyB3cm90ZToKPj4KPj4KPj4gT24gMjAyMS82LzI5IDE5OjAwLCBIYW5u
ZXMgUmVpbmVja2Ugd3JvdGU6Cj4+PiBPbiA2LzI4LzIxIDM6MTAgQU0sIENoYW8gTGVuZyB3cm90
ZToKPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMS82LzI3IDIxOjM5LCBKYW1lcyBTbWFydCB3cm90ZToK
Pj4+Pj4gT24gNi8yNi8yMDIxIDU6MDkgQU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+Pj4+
IE9uIDYvMjYvMjEgMzowMyBBTSwgQ2hhbyBMZW5nIHdyb3RlOgo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+
Pj4+PiBPbiAyMDIxLzYvMjQgMTY6MTAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+Pj4+Pj4g
T24gNi8yNC8yMSA5OjI5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+IE9uIDIwMjEvNi8yNCAxMzo1MSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+Pj4+
Pj4+Pj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+PiBIaSBhbGwsCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gY29tbWl0
IGYyNWY4ZWY3MGNlMiAoIm52bWUtZmM6IHNob3J0LWNpcmN1aXQgcmVjb25uZWN0IHJldHJpZXMi
KQo+Pj4+Pj4+Pj4+Pj4gYWxsb3dlZCB0aGUgZmMgdHJhbnNwb3J0IHRvIGhvbm91ciB0aGUgRE5S
IGJpdCBkdXJpbmcgcmVjb25uZWN0Cj4+Pj4+Pj4+Pj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBz
cGVlZCB1cCBlcnJvciByZWNvdmVyeS4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gSG93IGRvZXMg
dGhpcyBzcGVlZCB1cCBlcnJvciByZWNvdmVyeT8KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFdlbGws
IG5vdCBleGFjdGx5IGVycm9yIHJlY292ZXJ5IChhcyB0aGVyZSBpcyBub3RoaW5nIHRvIHJlY292
ZXIpLgo+Pj4+Pj4+Pj4+IEJ1dCB3ZSB3b24ndCBhdHRlbXB0IHBvaW50bGVzcyByZXRyaWVzLCB0
aGVyZWJ5IHJlZHVjaW5nIHRoZSBub2lzZSBpbgo+Pj4+Pj4+Pj4+IHRoZSBtZXNzYWdlIGxvZy4K
Pj4+Pj4+Pj4+IFRoaXMgY29uZmxpY3Qgd2l0aCB0aGUgdGNwIGFuZCByZG1hIHRhcmdldC4KPj4+
Pj4+Pj4+IFlvdSBtYXkgbmVlZCB0byBkZWxldGUgdGhlIGltcHJvcGVyIE5WTUVfU0NfRE5SIGF0
IHRoZSB0YXJnZXQuCj4+Pj4+Pj4+PiBIb3dldmVyLCB0aGlzIHdpbGwgY2F1c2UgY29tcGF0aWJp
bGl0eSBpc3N1ZXMgYmV0d2VlbiBkaWZmZXJlbnQgdmVyc2lvbnMuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IFdoaWNoIG9uZXM/Cj4+Pj4+Pj4gSW4gbWFueSBzY2VuYXJpb3MsIHRoZSBkZXN0aW5hdGlvbiBz
ZXRzIEROUiBmb3IgYWJub3JtYWwgcGFja2V0cywKPj4+Pj4+PiBidXQgZWFjaCBuZXcgY29ubmVj
dGlvbiBtYXkgbm90IGhhdmUgdGhlIHNhbWUgZXJyb3IuCj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBwYXRj
aCBzZXJpZXMgaXMgb25seSBmb3IgdGhlIEROUiBiaXQgc2V0IGluIHJlc3BvbnNlIHRvIHRoZSAn
Y29ubmVjdCcgY29tbWFuZC4KPj4+Pj4+IElmIHRoZSB0YXJnZXQgaXMgbm90IGFibGUgdG8gcHJv
Y2VzcyB0aGUgJ2Nvbm5lY3QnIGNvbW1hbmQsIGJ1dCBtYXkgYmUgc28gaW4gdGhlIGZ1dHVyZSBp
dCByZWFsbHkgc2hvdWxkIG5vdCBzZXQgdGhlIEROUiBiaXQuCj4+Pj4+Pgo+Pj4+Pj4+PiBJIGNo
ZWNrZWQgdGhlIEROUiB1c2FnZSBpbiB0aGUgdGFyZ2V0IGNvZGUsIGFuZCB0aGV5IHNlZW0gdG8g
c2V0IGl0Cj4+Pj4+Pj4+IGNvcnJlY3RseSAoaWUgdGhlIHJlc3VsdCB3b3VsZCBub3QgY2hhbmdl
IHdoZW4gdGhlIGNvbW1hbmQgaXMgcmV0cmllZCkuCj4+Pj4+Pj4+IFdpdGggdGhlIHBvc3NpYmxl
IGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxpbmcsIGFzIHRoaXMgaXMgYXJndWFibHkKPj4+Pj4+
Pj4gZHluYW1pYyBhbmQgbWlnaHQgY2hhbmdlIHdpdGggYSByZXRyeS4KPj4+Pj4+PiBUaGUgRE5S
IHN0YXR1cyBvZiB0aGUgb2xkIGNvbm5lY3Rpb24gbWF5IG5vdCBiZSByZWxldmFudCB0byB0aGUg
cmUtZXN0YWJsaXNoZWQgY29ubmVjdGlvbi4KPj4+Pj4+Cj4+Pj4+PiBTZWUgYWJvdmUuCj4+Pj4+
PiBXZSBhcmUganVzdCBjaGVja2luZyB0aGUgRE5SIHNldHRpbmdzIGZvciB0aGUgJ2Nvbm5lY3Qn
IGNvbW1hbmQgKG9yIGFueSBvdGhlciBjb21tYW5kcyBiZWluZyBzZW50IGR1cmluZyBpbml0aWFs
IGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbikuCj4+Pj4+PiBJZiB0aGF0IGZhaWxzIHRoZSBjb25u
ZWN0IG5ldmVyIHdhcyBwcm9wZXJseSBpbml0aWFsaXplZDsgaWYgdGhlIGNvbnRyb2xsZXIgd291
bGQgcmV0dXJuIGEgZGlmZmVyZW50IHN0YXR1cyBhZnRlciByZWNvbm5lY3QgaXQgc2ltcGx5IHNo
b3VsZCBub3Qgc2V0IHRoZSBETlIgYml0IC4uLgo+Pj4+Pj4KPj4+Pj4+IENoZWVycywKPj4+Pj4+
Cj4+Pj4+PiBIYW5uZXMKPj4+Pj4KPj4+Pj4gQWdyZWVkLiBTaW5jZSAxLjMgc3BlYyBzYXlzOiAi
SWYgc2V0IHRvIOKAmDHigJksIGluZGljYXRlcyB0aGF0IGlmIHRoZSBzYW1lIGNvbW1hbmQgaXMg
cmUtc3VibWl0dGVkIHRvIGFueSBjb250cm9sbGVyIGluIHRoZSBOVk0gc3Vic3lzdGVtLCB0aGVu
IHRoYXQgcmUtc3VibWl0dGVkIGNvbW1hbmQgaXMgZXhwZWN0ZWQgdG8gZmFpbC4iCj4+Pj4gQWNj
b3JkaW5nIHRvIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBwcm90b2NvbCwgdGhpcyBpcyBub3Qgc3Ry
aWN0bHkgaW1wbGVtZW50ZWQgb24gdGhlIHRhcmdldCBzaWRlLgo+Pj4+IEluIG52bWUvdGFyZ2V0
LCB0aGVyZSBhcmUgbWFueSBleHRlcm5hbCBlcnJvcnMsIHRoZSBETlIgaXMgc2V0IHRvIDEuCj4+
Pj4gRm9yIGV4YW1wbGUsIGFib3JtYWwgZmFicmljcyBjbWQuCj4+Pgo+Pj4gWWVzOyBidXQgYW4g
YWJub3JtYWwgZmFicmljcyBjbWQgd2lsbCBiZSBhYm5vcm1hbCBldmVuIGFmdGVyIGEgcmVjb25u
ZWN0Lgo+PiBTb3JyeSwgZGVsYXllZCByZXBseSBkdWUgdG8gbGVhdmUuCj4+IFRoZXJlIGFyZSBt
YW55IHBvc3NpYmlsaXRpZXMgZm9yIGFibm9ybWFsIGZhYnJpY3MgY21kLgo+PiBJbiBzb21lIHNj
ZW5hcmlvcywgaWYgdGhlIGxpbmsgaXMgcmUtZXN0YWJsaXNoZWQsIHRoZSBlcnJvciBtYXkgbm90
IG9jY3VyIGFnYWluLAo+PiBzdWNoIGFzIEhCQSBpbm5lciBlcnJvciwgbmV0d29yayBpcyBhYm5v
cm1hbCBvciBhdHRhY2tlZCBldGMuCj4+Pgo+Pj4+Pgo+Pj4+PiBUaHVzIGlmIHRoZSBpbml0aWFs
IGNvbm5lY3QgZmFpbHMgaW4gdGhpcyBtYW5uZXIsIGFueSBuZXcgYXNzb2NpYXRpb24gd2lsbCBi
ZSBvbiBhIGRpZmZlcmVudCBjb250cm9sbGVyLCB3aGVyZSBpdCBpcyBub3cgZXhwZWN0ZWQgY29u
bmVjdCBvbiB0aGF0IGNvbnRyb2xsZXIgd2lsbCBmYWlsIHRvby7CoCBUaHVzIC0gd2h5IGNvbnRp
bnVlIHRvIGNvbm5lY3Qgd2hlbiBpdCdzIGV4cGVjdGVkIGVhY2ggd2lsbCBmYWlsLgo+Pj4+IEFn
cmVlLgo+Pj4+IFdlIHNob3VsZCBub3QgYXR0ZW1wdCB0byByZS1lc3RhYmxpc2ggdGhlIGNvbm5l
Y3Rpb24gaWYgdGFyZ2V0IGNhbiBub3Qgd29yayBkdWUgdG8gdGFyZ2V0IGlubmVyIGVycm9yIC4K
Pj4+PiBIb3dldmVyLCBub3fCoCB0YXJnZXQgZG9lcyBub3QgYmVoYXZlIGV4YWN0bHkgbGlrZSB0
aGlzLCBzbyB0aGVyZSBhcmUgY29uZmxpY3RzIGFuZCBjb21wYXRpYmlsaXR5IGlzc3Vlcy4KPj4+
Cj4+PiBOb3RlOiB3ZSBuZXZlciBzYWlkIHRoZSB0YXJnZXQgc2hvdWxkIF9ub3RfIHNlbmQgYSBE
TlIgc3RhdGUuIFdlIG9ubHkgc2FpZCB0aGUgdGFyZ2V0IHNob3VsZCBvbmx5IHNldCB0aGUgRE5S
IGJpdCBpZiBhIHJldHJ5IChldmVuIGFmdGVyIHJlY29ubmVjdCBvciBvbiBhIGRpZmZlcmVudCBj
b250cm9sbGVyKSB3aWxsIG5vdCBjaGFuZ2UgdGhlIHJlc3VsdC4KPj4+IFdoaWNoIGZyb20gd2hh
dCBJIGNhbiBzZWUgX2lzXyB0aGUgY2FzZSwgc28gSSBkbyBub3Qgc2VlIGFueSBpc3N1ZXMgaGVy
ZS4KPj4+Cj4+PiBQbGVhc2UgZ2l2ZSBkZXRhaWxzIGZvciB0aGUgaXNzdWVzIHlvdSBhcmUgY29u
Y2VybmVkIHdpdGguCj4+IEZvciBleGFtcGxlLCBpZiBob3N0IHNlbmQgYSBmYWJyaWMgY21kLCBi
dXQgdGhlIGZhYnJpYyBjbWQgaXMgcG9pc29uZWQKPj4gZHVlIHRvIEhCQSBpbm5lciBlcnJvciwg
YWJub3JtYWwgb3IgYXR0YWNrZWQgbmV0d29yaywgYW5kIHRoZW4gdGhlIHRhcmdldAo+PiBzZXQg
dGhlIEROUiB0byByZXBseSByZXNwb25zZS4gSWYgZG8gbm90IHJlY29ubmVjdCBmb3IgRE5SIHJl
c3BvbnNlIG9mCj4+IG9sZCBjb25uZWN0aW9uLCB0aHVzIHRoZSBjb25uZWN0aW5nIGNhbiBub3Qg
YW90byByZWNvdmVyeS4gVGhlIGZhYnJpYwo+PiBjbWQgcG9pc29uaW5nIG1heSBiZSB0cmFuc2ll
bnQsIG1heSBzdWNjZXNzIGlmIHRyeSBmb3IgcmVjb25uZWN0aW5nLgo+PiBzbyB0cnkgdG8gcmVj
b25uZWN0aW5nIGlzIGEgYmV0dGVyIGNob2ljZS4KPj4gSWYgZG8gbm90IHJlY29ubmVjdCBmb3Ig
RE5SIHJlc3BvbnNlLCB0YXJnZXQgc2hvdWxkIHNldCBETlIgc3RhdGUganVzdAo+PiBmb3IgdGFy
Z2V0IGlubmVyIGVycm9yLgo+Pj4KPj4+IENoZWVycywKPj4+Cj4+PiBIYW5uZXMKPiAKPiBJdCBy
ZWFsbHkgZG9lc24ndCBtYXR0ZXIgd2hhdCB5b3UgZGVzY3JpYmUgaXMgaGFwcGVuaW5nIG9uIHRo
ZSBiYWNrIGVuZCBvZiB0aGUgY29udHJvbGxlcnMvc3Vic3lzdGVtLsKgIFRoZSByZXYgMS40IHNw
ZWMgc2F5cyAiaWYgdGhlIHNhbWUgY29tbWFuZCBpcyByZS1zdWJtaXR0ZWQgdG8gYW55IGNvbnRy
b2xsZXIgaW4gdGhlIE5WTSBzdWJzeXN0ZW0sIHRoZW4gdGhhdCByZS1zdWJtaXR0ZWQgY29tbWFu
ZCBpcyBleHBlY3RlZCB0byBmYWlsLiIgLSBTbywgaWYgdGhlcmUncyBhIGNoYW5jZSB0aGF0IGEg
cmVjb25uZWN0IHdvdWxkIHN1Y2NlZWQsIHdoaWNoIHdvdWxkIGJlIG9uIGEgZGlmZmVyZW50IGNv
bnRyb2xsZXIgLSB0aGVuIHN1YnN5c3RlbSBpcyBub3QgZm9sbG93aW5nIHRoYXQgc3RhdGVtZW50
LiBTbyB5b3Ugc2hvdWxkbid0IGJlIHNldHRpbmcgRE5SLsKgwqAgSWYgeW91IGRpc2FncmVlIHdp
dGggdGhpcyBiZWhhdmlvciwgaXQgd2lsbCBuZWVkIHRvIGJlIHRha2VuIHVwIHdpdGggdGhlIE5W
TSBFeHByZXNzIGdyb3VwLgpJIGFncmVlIHRoZSBudm1lIHNwZWMuIEkgbWVhbiB0aGF0IGxpbnV4
IGtlcm5lbCBudm1lIHRhcmdldCBkb2VzIG5vdCBiZWhhdmUgZXhhY3RseSBsaWtlIHRoaXMuClNv
IG5lZWQgdG8gbW9kaWZ5IGJvdGggaG9zdCBhbmQgdGFyZ2V0LiBJbiBhZGRpdGlvbiwgdGhlIGNv
bXBhdGliaWxpdHkgYmV0d2VlbiBkaWZmZXJlbnQgdmVyc2lvbnMgc2hvdWxkIGJlIGNvbnNpZGVy
ZWQuCj4gCj4gLS0gamFtZXMKPiAKPiAuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
