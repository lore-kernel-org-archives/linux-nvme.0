Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AC7C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F666115B
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F666115B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CEQH/Zlc8ZhwwfeJ+QZGiV3hpcEXlF/Ayi+fkYpjgMM=; b=ICColO/RZ2kKw6XefYAm8ccW7
	xcuPUzysp8LiGDIwVthmV4vkOAW/ud2AuqPM4fn+JBi+jlNLYn2btQT70wqmXUuxpQ7wjgTlErPNH
	sxMK1C91MvKbbQGQH9XD8FkSJZnF5IKm+0V2IsTVcN5ejJAR6nQRtFhKIwXphIA6mmJpL/jC1ITef
	tcSAFvPfhFpbfLcBc6imnofChhR8Mm6TyceBVOOkjmyuAuME6TnKkO5wwLlz5iQ6HzusChnxESfAq
	hOI0RO0B0fQN8bxg/qkj6nayiv/kczhF7G4ZmgD8fCuNaqTj/pCP0qY+ytAOTIoIC7moMJEYHZyBF
	Z/5chZ5TQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQ88-007Ldf-Dx; Thu, 08 Apr 2021 08:35:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQ7m-007LXS-DU
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:34:54 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C94BFB10B;
 Thu,  8 Apr 2021 08:34:49 +0000 (UTC)
Subject: Re: [PATCH v9 04/13] lpfc: vmid: Add the datastructure for supporting
 VMID in lpfc
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-5-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8bfcafe4-d116-62d5-4f6f-049f6c9fe260@suse.de>
Date: Thu, 8 Apr 2021 10:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-5-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_093450_583886_8E927F3B 
X-CRM114-Status: GOOD (  17.41  )
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
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggYWRk
cyB0aGUgcHJpbWFyeSBkYXRhc3RydWN0dXJlcyBuZWVkZWQgdG8gaW1wbGVtZW50IFZNSUQKPiBp
biBscGZjIGRyaXZlci4gSXQgbWFpbnRhaW5zIHRoZSBjYXBhYmlsaXR5LCBjdXJyZW50IHN0YXRl
LAo+IGhhc2ggdGFibGUgZm9yIHRoZSB2bWlkL2FwcGlkIGFsb25nIHdpdGggb3RoZXIgaW5mb3Jt
YXRpb24uCj4gVGhlIGltcGxlbWVudGF0aW9uIHN1cHBvcnRzIHRoZSB0d28gdmVyc2lvbnMgb2Yg
dm1pZCBpbXBsZW1lbnRhdGlvbgo+IChhcHAgaGVhZGVyIGFuZCBwcmlvcml0eSB0YWdnaW5nKQo+
IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3JpdmFzdGF2YUBi
cm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21h
aWwuY29tPgo+IAo+IC0tLQo+IHY5Ogo+IFVwZGF0ZWQgdGhlIGRhdGEgc3RydWN0dXJlcwo+IE1l
cmdlZCBwYXRjaCA1IGFuZCA2IG9mIHByZXZpb3VzIHZlcnNpb24gdjggdG8gdGhpcyBwYXRjaAo+
IAo+IHY4Ogo+IG1vZGlmeSBzdHJ1Y3R1cmUgbWVtYmVyIHRvIHVuaWZvcm0gZGF0YSB0eXBlIG5h
bWluZyBzY2hlbWUKPiAKPiB2NzoKPiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBObyBjaGFuZ2UKPiAK
PiB2NToKPiBObyBDaGFuZ2UKPiAKPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFu
Z2UKPiAKPiB2MjoKPiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUK
PiBSZW1vdmVkIHVudXNlZCB2YXJpYWJsZS4KPiAtLS0KPiAgIGRyaXZlcnMvc2NzaS9scGZjL2xw
ZmMuaCAgICAgIHwgMTIyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgZHJp
dmVycy9zY3NpL2xwZmMvbHBmY19jcnRuLmggfCAgMTEgKysrCj4gICBkcml2ZXJzL3Njc2kvbHBm
Yy9scGZjX2Rpc2MuaCB8ICAgMSArCj4gICBkcml2ZXJzL3Njc2kvbHBmYy9scGZjX2h3LmggICB8
IDEyNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCj4gICBkcml2ZXJzL3Njc2kv
bHBmYy9scGZjX3NsaS5oICB8ICAgOCArKysKPiAgIDUgZmlsZXMgY2hhbmdlZCwgMjYyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
