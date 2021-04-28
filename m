Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B71C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:38:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAB661419
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 06:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAB661419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BzcnEkGTTAzdiBB/WQtprd1WegGKv/yieMGnBJ3adCI=; b=US/iqOzE/N0XbOtlbYhj+9xv6
	4dBMhI2uHUmYk3c5j4k3pgAFp/gACrTYF/1z3rEpHxHmA3E2qihfLWM43+PahKkw3f4VI06O4nADI
	uNhGIRtMPd+F2vTPQjw9ekOKEgfFzy+yKKxUGtJjzZRS3kue2OxtmKbFDfHV7L4a6NL9mFqPNfyTw
	MSXvN4R1YvXShHPOiql3/u2Vd7PQaCA6EypedbsKXfCviJwvEHiELX464KAa4ZUWoivO0J/8GKOwV
	/L5r5NIE2qv1gMefur+wRY7lCAOEs/YMOveC8jLXaHU69/4sF8qBlgpRFk2alVuu01OKwBxSLgH8l
	zW8hRquxg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbdpw-002wCZ-Mv; Wed, 28 Apr 2021 06:38:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdpl-002wC3-Td
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 06:38:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=lEiua06zQwxMCPtqYg075EFjxV46DnV2n3+Qrs+TkXk=; b=YfyW3mMzViT/WBaIrjVp5bVrq7
 E1HqrQmkcejhGiVFSWnikx5+7lkKikshSnNDB6U8kz2TeZQmTBD6dFrKVOSGFfx12noUNK0HuVvhD
 CKlEXrLSIYH5hyAYfuc+tNfHB1Fora13LtgPQ6AQoePxN29YYjKkwA3ERZnegM2lpVoVlluVjx4nc
 zTQdiKZvOEzd5gSmvZcXWdc0VOmWQQrSY0gaq2ADXUJviVHIA9oNM2zCWYhwJQCy3DCGDRRGSGjKX
 XWvoy22wmpIVFSnnhGqrsxLQidgLROEuHy6boqGVhlPyIFw6oNYvbRVAxtSADvReyV7oYdNYQCwMM
 dh9iDFpw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbdpj-00HDZr-CY
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 06:38:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 16A94AF31;
 Wed, 28 Apr 2021 06:38:02 +0000 (UTC)
Subject: Re: [PATCH v10 08/13] lpfc: vmid: Functions to manage vmids
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
 <1619562897-14062-9-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <c1d2551e-a70a-37f9-81d2-7bff9068f61d@suse.de>
Date: Wed, 28 Apr 2021 08:38:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1619562897-14062-9-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_233803_594613_5C7E4E84 
X-CRM114-Status: GOOD (  10.30  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC8yOC8yMSAxMjozNCBBTSwgTXVuZWVuZHJhIHdyb3RlOgo+IEZyb206IEdhdXJhdiBTcml2
YXN0YXZhIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gCj4gVGhpcyBwYXRjaCBj
b250YWlucyB0aGUgcm91dGluZXMgdG8gc2F2ZSwgcmV0cmlldmUgYW5kIHJlbW92ZSB0aGUgdm1p
ZHMKPiBmcm9tIHRoZSBkYXRhIHN0cnVjdHVyZS4gQSBoYXNoIHRhYmxlIGlzIHVzZWQgdG8gc2F2
ZSB0aGUgdm1pZHMgYW5kCj4gdGhlIGNvcnJlc3BvbmRpbmcgVVVJRHMgYXNzb2NpYXRlZCB3aXRo
IHRoZSBhcHBsaWNhdGlvbi9WTXMuCj4gCj4gU2lnbmVkLW9mZi1ieTogR2F1cmF2IFNyaXZhc3Rh
dmEgIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFt
ZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJl
aW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bnZtZQo=
