Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4F2C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:25:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD43611AB
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD43611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4oOJSS8Y8t/JgXm8Zt+SqtpyKs7YK5WNdBpLbC9fOJ4=; b=M/o417bTLXvWRQSLgZ0mib+WE
	UheMcCI3c+RJwiSnz4OBI75icaijMrqX8PLjjemW50/29TAMdcFqWxzpTU0lCP6PVPOwneMtVBy1+
	TUXsQm4M3vMjQFQ0axARKTrDusosqHyCLlKBrtWl/Db6odA5Bp2jQzQIKYgyMT9/GuNAsN5O4zpro
	RM2fILUbzPuYRkfhRndJCAQCJfNfCamN/mnlCRnCUyKb77fM82tzabzwWEddB7NNAsdi57kW4WO4w
	PF8R2DR10uTY+3fJs3vWWEbf8+44whGPVtI5IagJhesWPW+2C+jDmWg9LC5BrLmLAM4REJQ9ZRTtW
	43mmUFGuA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbNE-00EMe0-Ug; Mon, 03 May 2021 16:24:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbNB-00EMdA-HK
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 16:24:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=N+sSPuFfi0s19EvtZx7B+hijzbaxse8FDqkj/Y3GYg4=; b=4KcCgzlRiOMNM9u1EKqS9Gi0di
 0F8XOeZmG5/K1op2aYFbU7Jh/cqcwHEQmQ/O+lPIjFMei6eJiw4qleY7KcMFyyzNuTq4t1QPsB4NP
 NhHq3Ny4XrHy708ooipRFBeJVMy8gC3g1akQ0paYomrDM46IQPCp6z/hOUHBpAPkDlFTQcCT50t6Q
 lQLeymXmQps2FMsZbb2gNWryOT71uN6fmjNnBCODJhNC9ntXqeofUK5uRS43B1ona6knyzKb8dSyf
 ju2ddmMGHyEDunNmko4fE2G0F7s8LhPNQIU6vMyv1q7sPRPcLtW8dbqTPUtMXsVTS8p/zuEu7zDIa
 t05OeqZQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbN8-003EwQ-Tw
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 16:24:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 17B0BAD8A;
 Mon,  3 May 2021 16:24:37 +0000 (UTC)
Subject: Re: [PATCH 0/1] nvme-tcp: Add option to set the physical interface to
 be used when connecting over TCP sockets.
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
References: <BL0PR13MB42918D11A0A3956FA8BC549E9C5B9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5c22f2b4-fcc4-7071-c020-2b9bb956788e@suse.de>
Date: Mon, 3 May 2021 18:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BL0PR13MB42918D11A0A3956FA8BC549E9C5B9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_092439_129138_32BE8D01 
X-CRM114-Status: GOOD (  21.93  )
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

T24gNS8zLzIxIDU6MjMgUE0sIE1hcnRpbiBCZWxhbmdlciB3cm90ZToKPiBGcm9tOiBNYXJ0aW4g
QmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4KPiAKPiBJbiBvdXIgYXBwbGljYXRp
b24sIHdlIG5lZWQgYSB3YXkgdG8gZm9yY2UgVENQIGNvbm5lY3Rpb25zIHRvIGdvIG91dCBhCj4g
c3BlY2lmaWMgSVAgaW50ZXJmYWNlIGluc3RlYWQgb2YgbGV0dGluZyBMaW51eCBzZWxlY3QgdGhl
IGludGVyZmFjZQo+IGJhc2VkIG9uIHRoZSByb3V0aW5nIHRhYmxlcy4gVGhpcyBwYXRjaCBhZGRz
IHRoZSBvcHRpb24gJ2hvc3QtdHJpZmFjZScKPiB0byBhbGxvdyBzcGVjaWZ5aW5nIHRoZSBpbnRl
cmZhY2UgdG8gdXNlLiBOb3RlIHRoYXQgY29ycmVzcG9uZGluZwo+IGNoYW5nZXMgdG8gdGhlIG52
bWUtY2xpIHV0aWxpdHkgd2lsbCBmb2xsb3cuCj4gCj4gTWFydGluIEJlbGFuZ2VyICgxKToKPiAg
ICBBZGQgJ1RyYW5zcG9ydCBJbnRlcmZhY2UnICh0cmlmYWNlKSBvcHRpb24uIFRoaXMgY2FuIGJl
IHVzZWQgdG8KPiAgICAgIHNwZWNpZnkgdGhlIElQIGludGVyZmFjZSB0byB1c2UgZm9yIHRoZSBj
b25uZWN0aW9uLiBUaGUgZHJpdmVyIHVzZXMKPiAgICAgIHRoYXQgdG8gc2V0IFNPX0JJTkRUT0RF
VklDRSBvbiB0aGUgc29ja2V0IGJlZm9yZSBjb25uZWN0aW5nLgo+IAo+ICAgZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jICAgIHwgIDUgKysrKysKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3Mu
YyB8IDE0ICsrKysrKysrKysrKysKPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuaCB8ICA2
ICsrKysrLQo+ICAgZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgICAgIHwgNDEgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2MiBpbnNlcnRp
b25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IC0tCj4gMi4yNS4xCj4gCj4gCklzIHRoaXMgYSBw
bGFpbiByZXNlbmQsIG9yIGRpZCB5b3UgYWRkcmVzcyBhbnkgb2YgdGhlIHJldmlld3M/CklmIHlv
dSBhZGRyZXNzZWQgYW55IHJldmlld3MgcGxlYXNlIHVzZSAnUEFUQ0h2MicgKGluc3RlYWQgb2Yg
anVzdCAKJ1BBVENIJyksIHRvIGluZGljYXRlIHRoYXQgdGhpcyBpcyBhbiB1cGRhdGUgdG8gdGhl
IHByZXZpb3VzIHZlcnNpb24uCgpJZiBpdCdzIGEgcmVzZW5kIHBsZWFzZSBzdGF0ZSBzbywgdG9v
IChlZyBieSB1c2luZyAnUEFUQ0ggUkVTRU5EJyBvciAKc29tZXRoaW5nKS4KCkFuZCBhcyB0aGlz
IGlzIGp1c3QgYSBzaW5nbGUgcGF0Y2ggdGhlIGNvdmVyIGxldHRlciBpcyBub3QgcmVxdWlyZWQu
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAg
S2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgs
IE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
