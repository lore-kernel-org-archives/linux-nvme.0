Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273EFC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB37F61164
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB37F61164
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L57OkSbkmkjgJ77Waex51NLB+Zd8xVEfyJIf/PFNBt4=; b=TSbKXvdhTCXj7lkcwD5E3BHta
	pyIiByFu8NEiIpZ6e5XWSNdVOhdEtVcQWrQ8+oSJ5EBITy71kmU2XjrdifPQkfrU1IjnmBFBr/CZX
	/o1kzZR6drZXWcrlZFTeGZ66m4SHSZxKN+aaG9uyGyAu0KhlUo/enCRv0WpnkAcH1uUQjWYzLO0KA
	pUkMWre79b8/EMLiJzWSkXmFzjjBF1/eS6OhAQK3ow6gmsoYMGQKWrpGGq4GVgSlOMPXvndpKPPaN
	OjyF3pcyboN6MKYtGiTFOpGEPGV2fR3IdRGm6Rh70pc7bRonhZhLx0zfv1ifsPHRH28bhD362N/Ir
	bhn5m4t4Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQ7z-007Lbe-Eb; Thu, 08 Apr 2021 08:35:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQ7m-007LXP-8d
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:34:52 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC4C8B03A;
 Thu,  8 Apr 2021 08:34:49 +0000 (UTC)
Subject: Re: [PATCH v9 05/13] lpfc: vmid: VMID params initialization
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-6-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <ce9701df-d029-9918-8374-1067f0a2f83a@suse.de>
Date: Thu, 8 Apr 2021 10:29:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-6-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_093450_378956_AEFC57F9 
X-CRM114-Status: GOOD (  13.38  )
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

T24gNC83LzIxIDE6MDYgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW5p
dGlhbGl6ZXMgdGhlIFZNSUQgcGFyYW1ldGVycyBsaWtlIHRoZSB0eXBlIG9mIHZtaWQsIG1heAo+
IG51bWJlciBvZiB2bWlkcyBzdXBwb3J0ZWQgYW5kIHRpbWVvdXQgdmFsdWUgZm9yIHRoZSB2bWlk
IHJlZ2lzdHJhdGlvbgo+IGJhc2VkIG9uIHRoZSB1c2VyIGlucHV0Lgo+IAo+IFNpZ25lZC1vZmYt
Ynk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IC0t
LQo+IHY5Ogo+IHVwZGF0ZWQgY29tbWVudHMKPiAKPiB2ODoKPiBObyBjaGFuZ2UKPiAKPiB2NzoK
PiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBObyBjaGFuZ2UKPiAKPiB2NToKPiBObyBjaGFuZ2UKPiAK
PiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2MjoKPiBQb3J0ZWQg
dGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAgIGRyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfYXR0ci5jIHwgNDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspCj4gClJldmlld2VkLWJ5OiBI
YW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhh
bm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5i
ZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IElt
ZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
