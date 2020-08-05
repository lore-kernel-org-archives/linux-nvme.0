Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3587C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:28:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BA72073E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hezawgIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA72073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5AaTSRH1+GKARzgE7LIoNDBVAqpvZuPLTO3zwSR4pSI=; b=hezawgIgb8NhWfjmioodaRPs3
	l3h8AbmH0W/Ci5Uj8EhngiVyluS3pA1nabKhwkSbIgP48lgYFH2+VcLcIQ4CQD+gqT5617T8RX6+h
	3iYWtMQP7xjtudXOUJfOLwO5Nton5B1pBvo9A96tRtj+cgt2s5wZuJ37KLBbRpnUE9w6fp0/r8nYU
	8s9PsD6lAOshytxprI1pZIhwR+mixhviadRj7DwXp2lL7YI0zx9L93Y7L3Wc+JATAV2aWyPNKzFMy
	9IOTTbnjVOJ68TLyYB973JI9KSzAGH20FoylpASvnamnEAABdvITUixg3y2jsFvWJIYFMvNxvurYi
	NbS1Bb3AA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3DqF-00016v-Sy; Wed, 05 Aug 2020 07:28:03 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3DqC-00016K-Ch
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:28:02 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0A8443F6B7C8C406A541;
 Wed,  5 Aug 2020 15:27:53 +0800 (CST)
Received: from [10.169.42.93] (10.169.42.93) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 5 Aug 2020 15:27:47 +0800
Subject: Re: [PATCH] nvme-core: fix deadlock when reconnect failed due to
 nvme_set_queue_count timeout
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20200805063335.19882-1-lengchao@huawei.com>
 <02a20ae5-5af3-8595-c8b4-237449fbc1ee@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c0b91c52-6d5b-90d9-206e-780f836a1ed8@huawei.com>
Date: Wed, 5 Aug 2020 15:27:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <02a20ae5-5af3-8595-c8b4-237449fbc1ee@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_032800_712747_04F8CC78 
X-CRM114-Status: GOOD (  12.70  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzgvNSAxNToxMCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4gQSBkZWFkbG9j
ayBoYXBwZW5zIFdoZW4gd2UgdGVzdCBudm1lIG92ZXIgcm9jZSB3aXRoIGxpbmsgYmxpbmsuIFRo
ZQo+PiByZWFzb246IGxpbmsgYmxpbmsgd2lsbCBjYXVzZSBlcnJvciByZWNvdmVyeSwgYW5kIHRo
ZW4gcmVjb25uZWN0LklmCj4+IHJlY29ubmVjdCBmYWlsIGR1ZSB0byBudm1lX3NldF9xdWV1ZV9j
b3VudCB0aW1lb3V0LCB0aGUgcmVjb25uZWN0Cj4+IHByb2Nlc3Mgd2lsbCBzZXQgdGhlIHF1ZXVl
IGNvdW50IGFzIDAgYW5kIGNvbnRpbnVlICwgYW5kIHRoZW4KPj4gbnZtZV9zdGFydF9jdHJsIHdp
bGwgY2FsbCBudm1lX2VuYWJsZV9hZW4sIGFuZCBkZWFkbG9jayBoYXBwZW5zCj4+IGJlY2F1c2Ug
dGhlIGFkbWluIHF1ZXVlIGlzIHF1aWVzY2VkLgo+IAo+IFdoeSBpcyB0aGUgYWRtaW4gcXVldWUg
cXVpZXNjZWQ/IGlmIHdlIGFyZSBjYWxsaW5nIHNldF9xdWV1ZV9jb3VudAo+IGl0IHdhcyBhbHJl
YWR5IHVucXVpZXNjZWQ/Cm52bWVfc2V0X3F1ZXVlX2NvdW50IHRpbWVvdXQgd2lsbCBudm1lX3Jk
bWFfdGVhcmRvd25fYWRtaW5fcXVldWUsIHRoZSBhZG1pbiBxdWV1ZQp3aWxsIGJlIHF1aWVzY2Vk
IGluIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZS4KPiAKPj4gbG9nOgo+PiBBdWfCoCAz
IDIyOjQ3OjI0IGxvY2FsaG9zdCBrZXJuZWw6IG52bWUgbnZtZTI6IEkvTyAyMiBRSUQgMCB0aW1l
b3V0Cj4+IEF1Z8KgIDMgMjI6NDc6MjQgbG9jYWxob3N0IGtlcm5lbDogbnZtZSBudm1lMjogQ291
bGQgbm90IHNldCBxdWV1ZSBjb3VudAo+PiAoODgxKQo+PiBzdGFjazoKPj4gcm9vdMKgwqDCoMKg
IDIzODQ4wqAgMC4wwqAgMC4wwqDCoMKgwqDCoCAwwqDCoMKgwqAgMCA/wqDCoMKgwqDCoMKgwqAg
RMKgwqDCoCBBdWcwM8KgwqAgMDowMAo+PiBba3dvcmtlci91MTI6NCtudm1lLXdxXQo+PiBbPDA+
XSBibGtfZXhlY3V0ZV9ycSsweDY5LzB4YTAKPj4gWzwwPl0gX19udm1lX3N1Ym1pdF9zeW5jX2Nt
ZCsweGFmLzB4MWIwIFtudm1lX2NvcmVdCj4+IFs8MD5dIG52bWVfZmVhdHVyZXMrMHg3My8weGIw
IFtudm1lX2NvcmVdCj4+IFs8MD5dIG52bWVfc3RhcnRfY3RybCsweGE0LzB4MTAwIFtudm1lX2Nv
cmVdCj4+IFs8MD5dIG52bWVfcmRtYV9zZXR1cF9jdHJsKzB4NDM4LzB4NzAwIFtudm1lX3JkbWFd
Cj4+IFs8MD5dIG52bWVfcmRtYV9yZWNvbm5lY3RfY3RybF93b3JrKzB4MjIvMHgzMCBbbnZtZV9y
ZG1hXQo+PiBbPDA+XSBwcm9jZXNzX29uZV93b3JrKzB4MWE3LzB4MzcwCj4+IFs8MD5dIHdvcmtl
cl90aHJlYWQrMHgzMC8weDM4MAo+PiBbPDA+XSBrdGhyZWFkKzB4MTEyLzB4MTMwCj4+IFs8MD5d
IHJldF9mcm9tX2ZvcmsrMHgzNS8weDQwCj4+Cj4+IE1hbnkgZnVuY3Rpb25zIHdoaWNoIGNhbGwg
X19udm1lX3N1Ym1pdF9zeW5jX2NtZCB0cmVhdCBlcnJvciBjb2RlIGluIHR3bwo+PiBtb2Rlczog
SWYgZXJyb3IgY29kZSBsZXNzIHRoYW4gMCwgdHJlYXQgYXMgY29tbWFuZCBmYWlsZWQuIElmIGVy
cm9lIGNvZGUKPj4gbW9yZSB0aGFuIDAsIHRyZWF0IGFzIHRhcmdldCBub3Qgc3VwcG9ydCBvciBv
dGhlci4KPiAKPiBXZSByZWx5IGluIGEgbG90IG9mIHBsYWNlcyBvbiB0aGUgbnZtZSBzdGF0dXMg
YmVpbmcgcmV0dXJuZWQgZnJvbQo+IG52bWVfc3VibWl0X3N5bmNfY21kIChlc3BlY2lhbGx5IGlu
IG52bWVfcmV2YWxpZGF0ZV9kaXNrIGFuZCBmb3IKPiBwYXRoL2Fib3J0ZWQgY2FuY2VsbGF0aW9u
cyksIGFuZCB0aGlzIHBhdGNoIGJyZWFrcyBpdC4gWW91IG5lZWQgdG8gZmluZAo+IGEgc29sdXRp
b24gdGhhdCBkb2VzIG5vdCBoaWRlIHRoZSBudm1lIHN0YXR1cyBjb2RlIGZyb20gcHJvcGFnYXRp
bmcKPiBiYWNrLgpUaGUgZGlmZmVyZW5jZSBpcyBqdXN0IEVJTlRSIGFuZCBFSU8sIHRoZXJlIGlz
IG5vIHJlYWwgaW1wYWN0LgpwY2kgZHJpdmVyIGlzIGFscmVhZHkgZG8gbGlrZSB0aGlzLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
