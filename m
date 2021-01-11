Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD98C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:32:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B634522795
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B634522795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=joe2tqUQwMoMZ4Eqtdb3k9432Rz/HJehccMfaBGqJAo=; b=eEkOlm0/RW+zRQLshmD7iCb01
	WLwUwklmWUcPdDQtlYKGotZmqxxje0m1ehvlkkjYphi3nxtX7pNo56VviVR3UFjoYVNm1jzKfPrjS
	O77Kj6ZkMSFHaoc04BB+41Enm9cwwtAvLkEfNdjP+t9WNCCX+LfgJuhg/5OiIZjvUzDyAjgduud9G
	dsptjGgTRDKt6VsITjbJaoCnzjxanDN76qs0AqwbsbHMtp+1hivdjlIQk5iDTC/SiymRWXLrpdXY1
	v75bpVuIdijfAtuXF84ODuprwBgpMe1s6Rt8KYpbDs0xD5lAel8p5infNwqFp3eN8zAVONmvoX+py
	UVgocC/3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrgp-0005qK-9P; Mon, 11 Jan 2021 07:32:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyrgm-0005oz-DI
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:32:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3B9D6AF7F;
 Mon, 11 Jan 2021 07:32:31 +0000 (UTC)
Subject: Re: [PATCH v7 04/16] lpfc: vmid: Add the datastructure for supporting
 VMID in lpfc
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-5-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7d50f389-91fe-2110-2ef5-fc4ce27293b9@suse.de>
Date: Mon, 11 Jan 2021 08:32:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-5-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_023232_608163_5543953B 
X-CRM114-Status: GOOD (  19.46  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGFk
ZHMgdGhlIHByaW1hcnkgZGF0YXN0cnVjdHVyZXMgbmVlZGVkIHRvIGltcGxlbWVudCBWTUlEIGlu
IGxwZmMKPiBkcml2ZXIuIEl0IG1haW50YWlucyB0aGUgY2FwYWJpbGl0eSwgY3VycmVudCBzdGF0
ZSwgaGFzaCB0YWJsZSBmb3IgdGhlCj4gdm1pZC9hcHBpZCBhbG9uZyB3aXRoIG90aGVyIGluZm9y
bWF0aW9uLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEdhdXJhdiBTcml2YXN0YXZhIDxnYXVyYXYuc3Jp
dmFzdGF2YUBicm9hZGNvbS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogSmFtZXMgU21hcnQgPGpzbWFy
dDIwMjFAZ21haWwuY29tPgo+IAo+IC0tLQo+IHY3Ogo+IE5vIGNoYW5nZQo+IAo+IHY2Ogo+IE5v
IGNoYW5nZQo+IAo+IHY1Ogo+IE5vIENoYW5nZQo+IAo+IHY0Ogo+IE5vIGNoYW5nZQo+IAo+IHYz
Ogo+IE5vIGNoYW5nZQo+IAo+IHYyOgo+IFBvcnRlZCB0aGUgcGF0Y2ggb24gdG9wIG9mIDUuMTAv
c2NzaS1xdWV1ZQo+IFJlbW92ZWQgdW51c2VkIHZhcmlhYmxlLgo+IC0tLQo+ICAgZHJpdmVycy9z
Y3NpL2xwZmMvbHBmYy5oIHwgOTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKykKPiBSZXZpZXdlZC1ieTog
SGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
