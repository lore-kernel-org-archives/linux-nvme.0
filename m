Return-Path: <SRS0=WUld=4Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2024C10F00
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 08:39:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B3420675
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Mar 2020 08:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GccyLCS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B3420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I0vrD1pfKCw/BSRF/9NudFrbCSKo7pib1PG3RWJhbCw=; b=GccyLCS+eN/DwnTh13Y/NDj1b
	9rbnq49H19udl2t1muzUb8/z5Jzox86pDQsdy05VvDQ/VWct+MvlLLYNH5SbeK1IjWqDYUYNdBX8y
	oaRHQ3p4lLHtjAxpt7lF/GJBuJYZpdce4DfehAT3ynWZ2rorG3fm2TxzUzNAtAxH8ZAfYnqMfySz7
	iUXadjuuszMLTyadUTWH8mkqa7bjsGZ9HLQatr1urVcR8pBG3Xphv0CYsQE7gZRSghUqZY5Zv02f6
	ixk/aZ0F/sbizKHxXXQmJC9pzyFPUZp+XLXxsBfy0K9qKD4ynIvZ8LblpuZnsz9GlX/TWoTKR4uJR
	vP/LiWBNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jAUzi-0001Wj-2M; Sat, 07 Mar 2020 08:39:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jAUzf-0001Vw-KA
 for linux-nvme@lists.infradead.org; Sat, 07 Mar 2020 08:39:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 3FBCAAD20;
 Sat,  7 Mar 2020 08:39:32 +0000 (UTC)
Subject: Re: [PATCH 2/3] nvme/fcloop: short-circuit LS requests if no
 association is present
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200306130440.16864-1-hare@suse.de>
 <20200306130440.16864-3-hare@suse.de>
 <ac19a0a7-0028-488d-71f1-f11764d1b261@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <eb15551e-7908-03ac-faa5-7b7e23029113@suse.de>
Date: Sat, 7 Mar 2020 09:39:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ac19a0a7-0028-488d-71f1-f11764d1b261@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200307_003935_804984_D53C9228 
X-CRM114-Status: GOOD (  24.25  )
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
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy83LzIwIDI6MTEgQU0sIEphbWVzIFNtYXJ0IHdyb3RlOgo+IE9uIDMvNi8yMDIwIDU6MDQg
QU0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4gSWYgbm8gYXNzb2NpYXRpb24gb3IgdGFyZ2V0
cG9ydCBpcyBwcmVzZW50IHNoaWZ0aW5nIExTIHByb2Nlc3NpbmcKPj4gdG8gYSB3b3JrcXVldWUg
aXMgYSBiYWQgaWRlYSBhcyB0aGUgdGFyZ2V0cG9ydCBpdHNlbGYgaXMgYWJvdXQKPj4gdG8gYmUg
cmVtb3ZlZCwgYW5kIHdlIHdvdWxkIGRlYWRsb2NrIHdpdGggdGFyZ2V0cG9ydCBkZWxldGlvbi4K
Pj4gU28gaW5zdGVhZCByZXR1cm4gYW4gZXJyb3IgZGlyZWN0bHkgYW5kIHRyZWF0IGl0IGFzIGEg
c2VuZCBlcnJvciwKPj4gYXZvaWRpbmcgdGhlIGRlYWRsb2NrLgo+IFNvIEkgZG9uJ3QgcXVpdGUg
YWdyZWUgb24gdGhlIHRhcmdldHBvcnQgc3RhdGVtZW50LCBlc3BlY2lhbGx5IHJlbGF0aXZlIAo+
IHRvIGJvdGggdGhlIGgydCBhbmQgdDJoIHBhdGhzLgo+IAo+IFJldHVybmluZyBlcnJvciBjZXJ0
YWlubHkgd29ya3MsIGJ1dCBpdCBhdm9pZHMgdGhlIGFzeW5jaHJvbm91cyAKPiBjb21wbGV0aW9u
IHBhdGggd2hpY2ggaXMgZmFyIG1vcmUgY29tbW9uLiBJdCBvbmx5IHRlc3RzIHRoZSAKPiBpbW1l
ZGlhdGUtcmV0dXJuLWVycm9yIGNvZGUgY2FzZS7CoMKgIFdoZW4gdGhyb3dpbmcgaXQgdG8gYSB3
b3JrIHF1ZXVlLCAKPiBpdCdsbCBiZSBhIHdvcmsgcXVldWUgc3BlY2lmaWMgdG8gdGhlIHBvcnQg
aW5pdGlhdGluZyB0aGUgcmVxdWVzdCAtIHNvIAo+IGl0IHNob3VsZG4ndCBiZSB0b3VjaGluZyB0
aGUgb3RoZXIgc2lkZSB3aGljaCBpcyBub24tZXhpc3RlbnQuCj4gCj4gc28gd2hhdCB5b3UgaGF2
ZSBmaW5lLCBidXQgaSdtIG5vdCBzdXJlIGl0J3Mgd2hhdCBzaG91bGQgYmUgaGVyZS4KPiAKQWgu
IHlvdSBzcG90dGVkIGl0IDotKQoKWW91IGFyZSBjb3JyZWN0LCBpdCBkb2Vzbid0IGZpeCB0aGUg
dW5kZXJseWluZyBwcm9ibGVtLiBCdXQgaXQgZG9lcyAKYWxsb3cgdGFyZ2V0cG9ydCBkZWxldGlv
biB0byBmaW5pc2gsIHNvIHRoZXJlIGlzIF9zb21lXyB2YWx1ZSBpbiBpdC4KQnV0IGluZGVlZCwg
dGhlIHJlYWwgcHJvYmxlbSBpcyB0aGUgZmx1c2hfd29yaygpIHN0YXRlbWVudCBpbgpmY2xvb3Bf
dGFyZ2V0cG9ydF9kZWxldGUoKS4gVGhpbmcgaXMsIGZjbG9vcF90YXJnZXRwb3J0X2RlbGV0ZSgp
IGlzIApjYWxsZWQgZnJvbSB0aGUgdmVyeSBzYW1lIHdvcmtxdWV1ZSBmdW5jdGlvbiB3aGVuIHBy
b2Nlc3NpbmcgbHMgCnJlcXVlc3RzLCBhbmQgdGhvc2UgbmVlZCB0byBmbHVzaGVkIHdoZW4gdGVh
cmluZyBkb3duIHRoZSB0YXJnZXRwb3J0OgoKWyAxNDg4LjIxMTMyOV0gV29ya3F1ZXVlOiBldmVu
dHMgZmNsb29wX3Rwb3J0X2xzcnFzdF93b3JrIFsKbnZtZV9mY2xvb3BdClsgMTQ4OC4yMTEzMzFd
IENhbGwgVHJhY2U6ClsgMTQ4OC4zNjk3MDZdICBzY2hlZHVsZSsweDQwLzB4YjAKWyAxNDg4LjM2
OTcwOF0gIHNjaGVkdWxlX3RpbWVvdXQrMHgxZGQvMHgzMDAKWyAxNDg4LjQ2OTcwMF0gIHdhaXRf
Zm9yX2NvbXBsZXRpb24rMHhiYS8weDE0MApbIDE0ODguNDY5NzA1XSAgX19mbHVzaF93b3JrKzB4
MTc3LzB4MWIwClsgMTQ4OC40Njk3MDhdICA/IHdvcmtlcl9kZXRhY2hfZnJvbV9wb29sKzB4YTAv
MHhhMApbIDE0ODguNjEwMjgwXSAgZmNsb29wX3RhcmdldHBvcnRfZGVsZXRlKzB4MTMvMHgyMCBb
bnZtZV9mY2xvb3BdClsgMTQ4OC42MTAyODRdICBudm1ldF9mY190Z3Rwb3J0X3B1dCsweDE1MC8w
eDE5MCBbbnZtZXRfZmNdClsgMTQ4OC43MDY5NTJdICBudm1ldF9mY19kaXNjb25uZWN0X2Fzc29j
X2RvbmUrMHg5YS8weGUwIFtudm1ldF9mY10KWyAxNDg4LjcwNjk1NF0gIGZjbG9vcF90cG9ydF9s
c3Jxc3Rfd29yaysweDdhLzB4YTAgW252bWVfZmNsb29wXQpbIDE0ODguNzA2OTU3XSAgcHJvY2Vz
c19vbmVfd29yaysweDIwOC8weDQwMApbIDE0ODguNzA2OTU5XSAgd29ya2VyX3RocmVhZCsweDJk
LzB4M2UwCgpTbyB0aGF0IG5lZWRzIHRvIGJlIG1vdmUgdG8gc29tZXdoZXJlIGVsc2UsIGJ1dCBJ
IGhhdmVuJ3QgZm9sbG93ZWQKdGhlIGZsb3cgb2YgY29udHJvbCB0aGF0IGNsb3NlbHkgdGhhdCBJ
J3ZlIGJlZW4gYWJsZSB0byBmaWd1cmUgb3V0Cl93aGVyZV8gaXQgc2hvdWxkIGdvIHRvLgoKQ2hl
ZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgVGVhbWxlYWQg
U3RvcmFnZSAmIE5ldHdvcmtpbmcKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdl
c2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
