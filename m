Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44595C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:39:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BE864F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BE864F11
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oEm9pq8OfJ96hRsqRPGDmyuKCzyurkUuGssIpCWHzGw=; b=Nv7LAdUJN3WFs1KeYy3GyBO5A
	8KmnNLm/m2tCBoEnEqbUClhENe3MsaojU+Zalc2AhBSzK8aNrb8Q3CNte1wvF9DzO31azeKBx9LeG
	g4ZrpQC8ONPPBxFEROQOrmieP23Mc1+a6dH/n4e76ahkg60xeLN1rhQ+k/GYv8Ek65n0Q+7RU9HkD
	3+4vh8Xb1khUQ4g4WYvMxxW+1TC/ckLe9Q9UINEUmfDgSNnIMLP/AKxQ91rLfHvZZR5Y0POivRqTe
	DFtyJbnrqkisFOUfkop4YINdkatoPwlUfXMj364BolrEE1aHAyB+1fFbU0J/KOb8rVYMLInTN7F7m
	YXtz9VSIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnFx-008dgU-An; Thu, 04 Mar 2021 12:39:05 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnDF-008dIy-Bg
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:36:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B9A71AE47;
 Thu,  4 Mar 2021 12:36:16 +0000 (UTC)
Subject: Re: [PATCH v8 09/16] lpfc: vmid: Implements ELS commands for appid
 patch
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-10-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a89ebdfa-78cc-16b5-b281-ab3175b42f65@suse.de>
Date: Thu, 4 Mar 2021 13:36:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-10-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBGcm9tOiBHYXVyYXYgU3JpdmFz
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoaXMgcGF0Y2ggaW1w
bGVtZW50cyBFTFMgY29tbWFuZCBsaWtlIFFGUEEgYW5kIFVWRU0gZm9yIHRoZSBwcmlvcml0eQo+
IHRhZ2dpbmcgYXBwaWQgc3VwcG9ydC4gT3RoZXIgc3VwcG9ydGluZyBmdW5jdGlvbnMgYXJlIGFs
c28gcGFydCBvZiB0aGlzCj4gcGF0Y2guCj4gCj4gU2lnbmVkLW9mZi1ieTogR2F1cmF2IFNyaXZh
c3RhdmEgIDxnYXVyYXYuc3JpdmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
SmFtZXMgU21hcnQgPGpzbWFydDIwMjFAZ21haWwuY29tPgo+IAo+IC0tLQo+IHY4Ogo+IEFkZGVk
IGxvZyBtZXNzYWdlcyBtb2RpZmljYXRpb25zLCBtZW1vcnkgYWxsb2NhdGlvbiBBUEkgY2hhbmdl
cywKPiByZXR1cm4gZXJyb3IgY29kZXMKPiAKPiB2NzoKPiBObyBjaGFuZ2UKPiAKPiB2NjoKPiBB
ZGRlZCBGb3J3YXJkIGRlY2xhcmF0aW9ucywgc3RhdGljIGZ1bmN0aW9ucyBhbmQKPiByZW1vdmVk
IHVudXNlZCB2YXJpYWJsZXMKPiAKPiB2NToKPiBDaGFuZ2VkIFJldHVybiBjb2RlIHRvIG5vbi1u
dW1lcmljL1N5bWJvbC4KPiBBZGRyZXNzZWQgdGhlIHJldmlldyBjb21tZW50cyBieSBIYW5uZXMK
PiAKPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFuZ2UKPiAKPiB2MjoKPiBQb3J0
ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUKPiAtLS0KPiAgIGRyaXZlcnMv
c2NzaS9scGZjL2xwZmNfZWxzLmMgfCAzNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzNjAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJz
LAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBT
dG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxk
c3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOk
ZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
