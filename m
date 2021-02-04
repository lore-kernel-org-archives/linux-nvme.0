Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79BFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:02:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BA064D9E
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 07:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BA064D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kfvLzqw6SQAZmJ3V7/I5fDx+Mk/lmLnpHqF/IPtuGno=; b=MQL5CojErAl6rNenDPSPkeNYo
	sJoJ1V6shZj1eL4xZpfw+5tS54b73IAtlcBzh2GwBRUGRzv9KD//7kOp1pPpowvXquVAG0Pgd2wUt
	PmYtOrDnnuDsxqVk/9UVMSE5qGNgsLEasbni6YgDSXS3A00umCelbVwcc0TKEH1JS8KE9fWuFDgqA
	JI4znVg2dSJL/NtvfVbsYK+ntXWkXIMZt0G1uCSs2E8Mx/GlO/01aEzjzSxNmmpuc2zUr1Pnop9Vy
	tFhfoLV6Cwvo83CySbKCk79jWkvg0981TBBuHX8sW6BkCxnrrqCv8VuFLj5ID67AAifeztzeAFYcE
	A3c5O6qIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7Yf4-0003Ub-3g; Thu, 04 Feb 2021 07:02:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7Yf0-0003T2-VQ
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 07:02:39 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DC0DBABD5;
 Thu,  4 Feb 2021 07:02:37 +0000 (UTC)
Subject: Re: [PATCH 07/35] fabrics: use log() macro
To: mwilck@suse.com, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20210126203324.23610-1-mwilck@suse.com>
 <20210126203324.23610-8-mwilck@suse.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <60ddb80d-8a40-17e9-f601-4c19663825b9@suse.de>
Date: Thu, 4 Feb 2021 08:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126203324.23610-8-mwilck@suse.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_020239_126465_40E93CE3 
X-CRM114-Status: GOOD (  16.99  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS8yNi8yMSA5OjMyIFBNLCBtd2lsY2tAc3VzZS5jb20gd3JvdGU6Cj4gRnJvbTogTWFydGlu
IFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4gCj4gRmFicmljcyBmdW5jdGlvbmFsaXR5IHdpbGwg
YmUgdXNlZCBieSB0aGUgbW9uaXRvciBjb2RlLCB3ZQo+IG5lZWQgY29uc2lzdGVudCBsb2dnaW5n
LiBUaGlzIHBhdGNoIGNhdXNlcyBubyBmdW5jdGlvbmFsIGNoYW5nZQo+IGZvciB0aGUgZmFicmlj
cyBtb2R1bGUuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5j
b20+Cj4gLS0tCj4gICBmYWJyaWNzLmMgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0
aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
