Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9991BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:30:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5595622795
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5595622795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=13OLNM1GBXsHycXlot5l0N02LfE4ky2fCDc63QpY5bk=; b=CZ7kxIPHpqg4tXfmJ4zrj8x6V
	tja2mulHku/4bCRuoLlKN3AmnwwJVtHsnB3ML7xKDnlsTmJ0d2B387ZKgwyY8N958wzDhA4//l7CR
	h5ANPj1fFpBikeqUyI7B05nLy6oyUONWsUk5PMHyqFhvIeYhlGxjLLKqYGTT4DzsBeiw22nbTbwdn
	pCCEHXQqkw58RkBj97sAfBLu9Njn5OoG3rXlNbAjPdmWxCXRDTVk+39p1pp30OY2grWicHbAv2/MM
	ENHND4bpYTEmZsZ85hMKymFhiCcwMPsZJt98yKWmOURY/An+16IKrri5VkKdNhzGQyWGpVaUESK3T
	HPBKCKnAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrek-00056e-Kd; Mon, 11 Jan 2021 07:30:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyreh-00055F-QS
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:30:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B448CAD62;
 Mon, 11 Jan 2021 07:30:22 +0000 (UTC)
Subject: Re: [PATCH v7 02/16] blkcg: Added a app identifier support for blkcg
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-3-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d2f7a39d-203a-c542-3d50-997acaded6ff@suse.de>
Date: Mon, 11 Jan 2021 08:30:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-3-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_023024_024022_F073FDBB 
X-CRM114-Status: GOOD (  22.07  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gVGhpcyBQYXRjaCBhZGRlZCBh
IHVuaXF1ZSBhcHBsaWNhdGlvbiBpZGVudGlmaWVyIGkuZQo+IGZjX2FwcF9pZCAgbWVtYmVyIGlu
IGJsa2NnIHdoaWNoIGFsbG93cyBpZGVudGlmaWNhdGlvbiBvZiB0cmFmZmljCj4gc291cmNlcyBh
dCBhbiBpbmRpdmlkdWFsIGNncm91cCBiYXNlZCBBcHBsaWNhdGlvbnMKPiAoZXg6dmlydHVhbCBt
YWNoaW5lIChWTSkpbGV2ZWwgaW4gYm90aCBob3N0IGFuZAo+IGZhYnJpYyBpbmZyYXN0cnVjdHVy
ZS4KPiAKPiBBZGRlZCBhIG5ldyBmdW5jdGlvbiBibGtjZ19nZXRfZmNfYXBwaWQgdG8KPiBncmFi
IHRoZSBhcHAgaWRlbnRpZmllciBhc3NvY2lhdGVkIHdpdGggYSBiaW8uCj4gCj4gQWRkZWQgYSBu
ZXcgZnVuY3Rpb24gYmxrY2dfc2V0X2ZjX2FwcGlkIHRvCj4gc2V0IHRoZSBhcHAgaWRlbnRpZmll
ciBpbiBhIGJsa2NncnAgYXNzb2NpYXRlZCB3aXRoIGNncm91cCBpZAo+IAo+IEFkZGVkIGEgbmV3
IGNvbmZpZyBCTEtfQ0dST1VQX0ZDX0FQUElEIGFuZCBtb3ZlZCB0aGUgY2hhbmdlcwo+IHVuZGVy
IHRoaXMgY29uZmlnCj4gCj4gU2lnbmVkLW9mZi1ieTogTXVuZWVuZHJhIDxtdW5lZW5kcmEua3Vt
YXJAYnJvYWRjb20uY29tPgo+IAo+IC0tLQo+IHY3Ogo+IE1vZGlmaWVkIHRoZSBLY29uZmlnIGZp
bGUKPiAKPiB2NjoKPiBNb2RpZmllZCB0aGUgS2NvbmZpZyBmaWxlIGFzIHBlciBzdGFuZGFyZCBz
cGVjaWZpZWQKPiBpbiBEb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kaW5nLXN0eWxlLnJzdAo+IAo+
IHY1Ogo+IFJlbmFtZWQgdGhlIGFyZ3VtZW50cyBhcHByb3ByaWF0bGV5Cj4gUmVuYW1lZCBBUFBJ
RF9MRU4gIHRvIEZDX0FQUElEX0xFTgo+IE1vdmVkIHRoZSBpbnB1dCB2YWxpZGF0aW9uIGF0IHRo
ZSBiZWdpbmluZyBvZiB0aGUgZnVuY3Rpb24KPiBNb2RpZmllZCB0aGUgY29tbWVudHMKPiAKPiB2
NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBSZW5hbWVkIHRoZSBmdW5jdGlvbnMgYW5kIGFwcF9p
ZCB0byBtb3JlIHNwZWNpZmljCj4gCj4gQWRkcmVzc2VkIHRoZSByZWZlcmVuY2UgbGVha3MgaW4g
YmxrY2dfc2V0X2FwcF9pZGVudGlmaWVyCj4gCj4gQWRkZWQgYSBuZXcgY29uZmlnIEJMS19DR1JP
VVBfRkNfQVBQSUQgYW5kIG1vdmVkIHRoZSBjaGFuZ2VzCj4gdW5kZXIgdGhpcyBjb25maWcKPiAK
PiBBZGRlZCBibGtjZ19nZXRfZmNfYXBwaWQsYmxrY2dfc2V0X2ZjX2FwcGlkIGFzIGlubGluZSBm
dW5jdGlvbnMKPiAKPiB2MjoKPiByZW5hbWVkIGFwcF9pZGVudGlmaWVyIHRvIGFwcF9pZAo+IHJl
bW92ZWQgdGhlICBzeXNmcyBpbnRlcmZhY2UgYmxraW8uYXBwX2lkZW50aWZpZSB1bmRlcgo+IC0t
LQo+ICAgYmxvY2svS2NvbmZpZyAgICAgICAgICAgICAgfCAgOSArKysrKysKPiAgIGluY2x1ZGUv
bGludXgvYmxrLWNncm91cC5oIHwgNTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQo+IApSZXZpZXdlZC1i
eTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRy
LiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0
CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMg
Njg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7D
vHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxp
eCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
