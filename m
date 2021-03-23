Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CBC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 08:37:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B0661974
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 08:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B0661974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ymRfFSPD1vE27076fRtjwHXUMzIgU3SjnSuBHHgrT80=; b=ZfsJN+NefAPeAw7vFEE7KBOrv
	PLMomcH61A0OJtTIBqTaMGfwI8k5PGCi2hYVF4R6zszJp1kmGJzWqmrcNgG0jL3vdF85U822F0+FX
	SF/gkuZ4OB4iKFT6Q47AaA9gT7+5y58GPAyv/oA2DrNnqAIRJP1Ghx27r5Xp38z5/irPFlTEPRORf
	IAoMbzjkVwHbR067Muv5RyFpv59kxFIiXRRIhm8GF9hq5fwqsJwHQcmMNBwIsFcz3M2EfaHHWFQSk
	VnsTKR2MgtBW6JnAIJx3MYBQCXpTHT0dgFRZqsxv2XyFb2iZjrwi/A4Ot9a8TpbFlQCfSU4hUUN7V
	jfqpRBUkg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOcX0-00EKpl-ND; Tue, 23 Mar 2021 08:36:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOcWu-00EKoh-V9
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 08:36:51 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6110AAC3E;
 Tue, 23 Mar 2021 08:36:48 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of the
 underlying device
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <c064b296-c25c-3731-cbbd-f99ab93e6bd2@suse.de>
 <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <250dc97d-8781-1655-02ca-5171b0bd6e24@suse.de>
Date: Tue, 23 Mar 2021 09:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <608f8198-8c0d-b59c-180b-51666840382d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_083649_289671_F8AF2899 
X-CRM114-Status: GOOD (  17.50  )
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

T24gMy8yMy8yMSA4OjMxIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBBY3R1YWxseSwg
SSBoYWQgYmVlbiBwbGF5aW5nIGFyb3VuZCB3aXRoIG1hcmtpbmcgdGhlIGVudGlyZSBiaW8gYXMg
Cj4+ICdOT1dBSVQnOyB0aGF0IHdvdWxkIGF2b2lkIHRoZSB0YWcgc3RhbGwsIHRvbzoKPj4KPj4g
QEAgLTMxMyw3ICszMTYsNyBAQCBibGtfcWNfdCBudm1lX25zX2hlYWRfc3VibWl0X2JpbyhzdHJ1
Y3QgYmlvICpiaW8pCj4+IMKgwqDCoMKgwqDCoMKgwqAgbnMgPSBudm1lX2ZpbmRfcGF0aChoZWFk
KTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAobGlrZWx5KG5zKSkgewo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBiaW9fc2V0X2RldihiaW8sIG5zLT5kaXNrLT5wYXJ0MCk7Cj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJpby0+Ymlfb3BmIHw9IFJFUV9OVk1FX01Q
QVRIOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiaW8tPmJpX29wZiB8PSBSRVFf
TlZNRV9NUEFUSCB8IFJFUV9OT1dBSVQ7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRyYWNlX2Jsb2NrX2Jpb19yZW1hcChiaW8sIGRpc2tfZGV2dChucy0+aGVhZC0+ZGlzayks
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmlvLT5iaV9pdGVyLmJpX3NlY3Rvcik7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHN1Ym1pdF9iaW9fbm9hY2N0KGJpbyk7
Cj4+Cj4+Cj4+IE15IG9ubHkgd29ycnkgaGVyZSBpcyB0aGF0IHdlIG1pZ2h0IGluY3VyIHNwdXJp
b3VzIGZhaWx1cmVzIHVuZGVyIGhpZ2ggCj4+IGxvYWQ7IGJ1dCB0aGVuIHRoaXMgaXMgbm90IG5l
Y2Vzc2FyaWx5IGEgYmFkIHRoaW5nLgo+IAo+IFdoYXQ/IG1ha2luZyBzcHVyaW91cyBmYWlsdXJl
cyBpcyBub3Qgb2sgdW5kZXIgYW55IGxvYWQuIHdoYXQgZnMgd2lsbAo+IHRha2UgaW50byBhY2Nv
dW50IHRoYXQgeW91IG1heSBoYXZlIHJ1biBvdXQgb2YgdGFncz8KCldlbGwsIGl0J3Mgbm90IGFj
dHVhbGx5IGEgc3B1cmlvdXMgZmFpbHVyZSBidXQgcmF0aGVyIGEgc3B1cmlvdXMgCmZhaWxvdmVy
LCBhcyB3ZSdyZSBzdGlsbCBvbiBhIG11bHRpcGF0aCBzY2VuYXJpbywgYW5kIGJpb3Mgd2lsbCBz
dGlsbCBiZSAKcmUtcm91dGVkIHRvIG90aGVyIHBhdGhzLiBPciBxdWV1ZWQgaWYgYWxsIHBhdGhz
IGFyZSBvdXQgb2YgdGFncy4KSGVuY2UgdGhlIE9TIHdvdWxkIG5vdCBzZWUgYW55IGRpZmZlcmVu
Y2UgaW4gYmVoYXZpb3VyLgoKQnV0IGluIHRoZSBlbmQsIHdlIGFiYW5kb25lZCB0aGlzIGF0dGVt
cHQsIGFzIHRoZSBjcmFzaCB3ZSd2ZSBiZWVuIApzZWVpbmcgd2FzIGluIGJpb19lbmRpbyAoZHVl
IHRvIGJpX2JkZXYgc3RpbGwgcG9pbnRpbmcgdG8gdGhlIHJlbW92ZWQgCnBhdGggZGV2aWNlKToK
ClsgNjU1Mi4xNTUyNTFdICBiaW9fZW5kaW8rMHg3NC8weDEyMApbIDY1NTIuMTU1MjYwXSAgbnZt
ZV9uc19oZWFkX3N1Ym1pdF9iaW8rMHgzNmYvMHgzZTAgW252bWVfY29yZV0KWyA2NTUyLjE1NTI3
MV0gIHN1Ym1pdF9iaW9fbm9hY2N0KzB4MTc1LzB4NDkwClsgNjU1Mi4xNTUyODRdICA/IG52bWVf
cmVxdWV1ZV93b3JrKzB4NWEvMHg3MCBbbnZtZV9jb3JlXQpbIDY1NTIuMTU1MjkwXSAgbnZtZV9y
ZXF1ZXVlX3dvcmsrMHg1YS8weDcwIFtudm1lX2NvcmVdClsgNjU1Mi4xNTUyOTZdICBwcm9jZXNz
X29uZV93b3JrKzB4MWY0LzB4M2UwClsgNjU1Mi4xNTUyOTldICB3b3JrZXJfdGhyZWFkKzB4MmQv
MHgzZTAKWyA2NTUyLjE1NTMwMl0gID8gcHJvY2Vzc19vbmVfd29yaysweDNlMC8weDNlMApbIDY1
NTIuMTU1MzA1XSAga3RocmVhZCsweDEwZC8weDEzMApbIDY1NTIuMTU1MzA3XSAgPyBrdGhyZWFk
X3BhcmsrMHhhMC8weGEwClsgNjU1Mi4xNTUzMTFdICByZXRfZnJvbV9mb3JrKzB4MzUvMHg0MAoK
U28gd2UncmUgbm90IGJsb2NrZWQgb24gYmxrX3F1ZXVlX2VudGVyKCksIGFuZCBpdCdzIGEgY3Jh
c2gsIG5vdCBhIApkZWFkbG9jay4gQmxvY2tpbmcgb24gYmxrX3F1ZXVlX2VudGVyKCkgY2VydGFp
bmx5IHBsYXlzIGEgcGFydCBoZXJlLApidXQgaXMgc2VlbXMgbm90IHRvIGJlIHRoZSBmdWxsIHBp
Y3R1cmUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJu
YmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
