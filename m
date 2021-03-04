Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:43:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576FD64F23
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576FD64F23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qZBoRtWlc1SfvWC0xCs5jcpOxPRAGHeHYWeKKmAv/EI=; b=byIcE1chaSkf2De/DI9XONL5q
	VIxvb3tOz0ej+/Y20+59pjFL5GxlayLZYraU5yg0aaYJJKr/01JPOR0/DSyJiBcNeSqNcSc6n1QoC
	bSudq5f1qBI3PAjrXxY5weUMW8Tnde2BWyuXssycyjjAcGTSsAdzw/va8UJuveNrCdvE0zHFyD+zq
	uF/8ng6R4b5A5qqVETWBrQPTYYcsxlM5bJhg6LKL2oFcuyi/KzDvl02peYnpMJ2IH5lCqbU/oniRQ
	KUYpYbKpL5Ciw64VxQ0049xaKXwCr2XI2cStAnmnG17OzwOFzQbXx4zuKMXt2ZYvFJt4p7nWQjON/
	jCUHEG6kw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnJh-008eGA-ME; Thu, 04 Mar 2021 12:42:57 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnJR-008eED-PN
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:42:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 32E6EAD57;
 Thu,  4 Mar 2021 12:42:41 +0000 (UTC)
Subject: Re: [PATCH v8 11/16] lpfc: vmid: Implements CT commands for appid.
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-12-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4b55120d-00f9-75ae-f12b-cb2f0acc7d1f@suse.de>
Date: Thu, 4 Mar 2021 13:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-12-git-send-email-muneendra.kumar@broadcom.com>
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
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoZSBwYXRjaCBpbXBs
ZW1lbnRzIENUIGNvbW1hbmRzIGZvciByZWdpc3RlcmluZyBhbmQgZGVyZWdpc3RlcmluZyB0aGUK
PiBhcHBpZCBmb3IgdGhlIGFwcGxpY2F0aW9uLiBBbHNvLCBhIHNtYWxsIGNoYW5nZSBpbiBkZWNy
ZW1lbnRpbmcgdGhlIG5kbHAKPiByZWYgY291bnRlciBoYXMgYmVlbiBhZGRlZC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29t
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+
Cj4gCj4gLS0tCj4gdjg6Cj4gbW9kaWZpZWQgbG9nIG1lc3NhZ2VzIGFuZCBmaXhlZCB0aGUgcmVm
Y291bnQKPiAKPiB2NzoKPiBObyBDaGFuZ2UKPiAKPiB2NjoKPiBBZGRlZCBGb3J3YXJkIGRlY2xh
cmF0aW9ucyBhbmQgZnVuY3Rpb25zIHRvIHN0YXRpYwo+IAo+IHY1Ogo+IE5vIGNoYW5nZQo+IAo+
IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYzOgo+IE5vIGNoYW5nZQo+IAo+IHYyOgo+IFBvcnRlZCB0
aGUgcGF0Y2ggb24gdG9wIG9mIDUuMTAvc2NzaS1xdWV1ZQo+IFJlbW92ZWQgcmVkdW5kYW50IGNv
ZGUgZHVlIHRvIGNoYW5nZXMgc2luY2UgbGFzdCBzdWJtaXQKPiAtLS0KPiAgIGRyaXZlcnMvc2Nz
aS9scGZjL2xwZmNfY3QuYyB8IDI0OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+
IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpI
YW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3Jh
Z2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0
OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
