Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D18FC433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:54:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E55610CF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 08:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E55610CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nZ91fbnxAZTsSbHAkL16NVenp8JcTCvSm0gbtqZ8OGI=; b=BCw72Rf82O8aumZb3ZsTx18GS
	VWHeHg67EryGNT0EJgjOMg70BUN9chTieZTiE5OJnJNBDX6JjisEZP46qE9qgL6je/jhuXH3KGxO5
	Tpkh8R9iLFUoHbQycgGbmBGbd/RXS9oHRc53QEtpCbiUlJMo15+9+t8bBX8INL19o+A4RWhUHPRKy
	MpcEse46R4cFzW1lMb4pwz2Je34zR0Ng+lkt9U2R3bOESa8xhVe+Vd9brzE7U80Ox6HXYLx9IpRMZ
	7KodTplf8WCcTu3cVSkFtgkdigO40NT+heXBsFLy8EwtlbtekaWGtJU+j8OeAhQmITjK3HHetYYi9
	FEVk3L1EQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUQQG-007OPh-M2; Thu, 08 Apr 2021 08:53:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUQQ3-007OMm-AI
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 08:53:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1B816B10B;
 Thu,  8 Apr 2021 08:53:42 +0000 (UTC)
Subject: Re: [PATCH v9 09/13] lpfc: vmid: Implements CT commands for appid.
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
 <1617750397-26466-10-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2bc65444-c26f-1c03-53e7-70e943ffb4a8@suse.de>
Date: Thu, 8 Apr 2021 10:37:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1617750397-26466-10-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_095344_242843_D9F2630C 
X-CRM114-Status: GOOD (  15.28  )
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
dGF2YSA8Z2F1cmF2LnNyaXZhc3RhdmFAYnJvYWRjb20uY29tPgo+IAo+IFRoZSBwYXRjaCBpbXBs
ZW1lbnRzIENUIGNvbW1hbmRzIGZvciByZWdpc3RlcmluZyBhbmQgZGVyZWdpc3RlcmluZyB0aGUK
PiBhcHBpZCBmb3IgdGhlIGFwcGxpY2F0aW9uLiBBbHNvLCBhIHNtYWxsIGNoYW5nZSBpbiBkZWNy
ZW1lbnRpbmcgdGhlIG5kbHAKPiByZWYgY291bnRlciBoYXMgYmVlbiBhZGRlZC4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBHYXVyYXYgU3JpdmFzdGF2YSAgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29t
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+
Cj4gCj4gLS0tCj4gdjk6Cj4gQWRkZWQgQ2hhbmdlcyByZWxhdGVkIHRvIGxvY2tpbmcgYW5kIG5l
dyBoYXNodGFibGUgaW1wbGVtZW50YXRpb24KPiAKPiB2ODoKPiBtb2RpZmllZCBsb2cgbWVzc2Fn
ZXMgYW5kIGZpeGVkIHRoZSByZWZjb3VudAo+IAo+IHY3Ogo+IE5vIENoYW5nZQo+IAo+IHY2Ogo+
IEFkZGVkIEZvcndhcmQgZGVjbGFyYXRpb25zIGFuZCBmdW5jdGlvbnMgdG8gc3RhdGljCj4gCj4g
djU6Cj4gTm8gY2hhbmdlCj4gCj4gdjQ6Cj4gTm8gY2hhbmdlCj4gCj4gdjM6Cj4gTm8gY2hhbmdl
Cj4gCj4gdjI6Cj4gUG9ydGVkIHRoZSBwYXRjaCBvbiB0b3Agb2YgNS4xMC9zY3NpLXF1ZXVlCj4g
UmVtb3ZlZCByZWR1bmRhbnQgY29kZSBkdWUgdG8gY2hhbmdlcyBzaW5jZSBsYXN0IHN1Ym1pdAo+
IC0tLQo+ICAgZHJpdmVycy9zY3NpL2xwZmMvbHBmY19jdC5jIHwgMjU3ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDI1NiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4gClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVA
c3VzZS5kZT4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAg
ICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8
cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
