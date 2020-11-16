Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2258C55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:08:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691542225B
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m81Uyp75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691542225B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+hzJjg69JoIFbPHkRlvvhjHj77FZRQmTrbdSc9J/wkA=; b=m81Uyp75tnuWcU2dkg/YYlf7k
	GvWKLBbPOQzyOyT13LxraIDVeg5Fx2oSpH9BFpBfacEjjJQrnnSmU4jwi2X/IpMYm19+BFuw5/x+K
	ExrFPlSmN7x5pTJpzNjfxI6uMplYM9OQnowdEpb8qwBAFdBC7wAgmS8rgxi68ehNvk+npzR5V+TNS
	H54gS2zTt3ayRCVSVwKJ9GnLdP5MyoeKXfEdOThPUW6quAyHcx71rhegkKwvSWGuh/wb07x6ND+aS
	MuoKCQUw5WwiMvmxDXWrzpOz6L0pcOL9WLr/cpemJocoq96lJFZUGaOlA+sgi14cJKSKgzU+31MbP
	wWJ5Rd/Pw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZYo-00047Y-9T; Mon, 16 Nov 2020 08:08:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZYl-000464-3j
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:08:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 14955AFA8;
 Mon, 16 Nov 2020 08:08:22 +0000 (UTC)
Subject: Re: [PATCH v4 14/19] lpfc: vmid: Implements CT commands for appid.
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-15-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <60f3f26f-7994-a820-8a75-df3ff018aa3a@suse.de>
Date: Mon, 16 Nov 2020 09:08:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-15-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_030823_347188_48B463C2 
X-CRM114-Status: GOOD (  19.08  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjI0IEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGUgcGF0Y2ggaW1w
bGVtZW50cyBDVCBjb21tYW5kcyBmb3IgcmVnaXN0ZXJpbmcgYW5kIGRlcmVnaXN0ZXJpbmcgdGhl
Cj4gYXBwaWQgZm9yIHRoZSBhcHBsaWNhdGlvbi4gQWxzbywgYSBzbWFsbCBjaGFuZ2UgaW4gZGVj
cmVtZW50aW5nIHRoZSBuZGxwCj4gcmVmIGNvdW50ZXIgaGFzIGJlZW4gYWRkZWQuCj4gCj4gU2ln
bmVkLW9mZi1ieTogR2F1cmF2IFNyaXZhc3RhdmEgIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNv
bS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29t
Pgo+IAo+IC0tLQo+IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYzOgo+IE5vIGNoYW5nZQo+IAo+IHYy
Ogo+IFBvcnRlZCB0aGUgcGF0Y2ggb24gdG9wIG9mIDUuMTAvc2NzaS1xdWV1ZQo+IFJlbW92ZWQg
cmVkdW5kYW50IGNvZGUgZHVlIHRvIGNoYW5nZXMgc2luY2UgbGFzdCBzdWJtaXQKPiAtLS0KPiAg
IGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfY3QuYyB8IDI0OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNDkgaW5zZXJ0aW9ucygrKQo+IFJl
dmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZQoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
