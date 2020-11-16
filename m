Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F01C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:11:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC4A205ED
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGrEaC6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC4A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mI+1uURH3vkt5x3NDsTAh4CfPdP+SeUlBk9LB+xV1zo=; b=OGrEaC6/00VsxjiVP3IKYEgF1
	67rzmKvB6WYdFIVm3qoFeXngScrxOD/KjYXFrwQ8OjRlab66s71TuHgPa2GkpjR0qu6JDbgikDyNv
	xqqMDsZitzZwmLpnQ3+oqlMrSY3MWbRM73uzcXovmomUD7LFYu1IRExyARcVTIXAOeoaLWBc6VddQ
	kV06R9CFKPOvKfrpcuR3XGRWZuAiV2A7X1mbP3y1OHqddb6KY3nYf7BH6S2OOz7QxADSso5eDHn+c
	o0kb5OhxDgs0c8T2KIh4ZF0nGx1guwsCI8s93GOXJguBeqnvwRHs2OU8JuMEQXryHmN56H5Xw/H8T
	PFeXq0BuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZbs-0004no-H3; Mon, 16 Nov 2020 08:11:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZbq-0004n3-JW
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:11:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7F912AFA0;
 Mon, 16 Nov 2020 08:11:33 +0000 (UTC)
Subject: Re: [PATCH v4 16/19] lpfc: vmid: Timeout implementation for vmid
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-17-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0a332d7f-63f9-536d-ef45-85ca7a473453@suse.de>
Date: Mon, 16 Nov 2020 09:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-17-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_031134_769172_9744E4B1 
X-CRM114-Status: GOOD (  18.03  )
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
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGlt
cGxlbWVudHMgdGhlIHRpbWVvdXQgZnVuY3Rpb25hbGl0eSBmb3IgdGhlIHZtaWQuIEFmdGVyIHRo
ZQo+IHNldCB0aW1lIHBlcmlvZCBvZiBpbmFjdGl2aXR5LCB0aGUgdm1pZCBpcyBkZXJlZ2lzdGVy
ZWQgZnJvbSB0aGUgc3dpdGNoLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZh
ICA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IFNpZ25lZC1vZmYtYnk6IEphbWVz
IFNtYXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAKPiAtLS0KPiB2NDoKPiBObyBjaGFuZ2UK
PiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2MjoKPiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBv
ZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAgIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfaGJhZGlz
Yy5jIHwgMTA5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfaW5pdC5jICAgIHwgIDQwICsrKysrKysrKysrKwo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCAxNDkgaW5zZXJ0aW9ucygrKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAg
ICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29s
dXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFH
IE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
