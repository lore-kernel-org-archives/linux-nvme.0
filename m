Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9FC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:27:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17265613D6
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17265613D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2oyn20Q+2aOO60eKrGvUAi4jSqZDW4b6DPD+574Q/zs=; b=FPb/FWAAioeXCAppT597gWbky
	Rc2zS12rc5YAV8V4UzItOG8T/5txlU80lezzee3qakThKxl+DsR7Cfujn9Vy6ehq0nj/4LFpchE4W
	f5HBUtB3GgAfOAJnA4npvc2upS7JrQityRZuHbN0Wj6pxRTBWHoCNSxUzv/4AF4rHCbwmhNNOp3YG
	jSQWSi+gwgfdOK4ZkXxTzAepN81yv/ldEiBVDvcrvgu7R5kAovBe2K0PggXOBYXrw9MbZBkObqDS2
	gWPLJFO/t5nfYwyYvb0ZGZBTEAowvxjsI7v4K2NF93EyLt7bPMCnZIGw1iJqPGemR1gJRxF4udoTJ
	sSR/U9YkA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgotf-002tNl-Lh; Wed, 12 May 2021 13:27:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgokd-002s09-Aq
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:18:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=HmnZM9dQQNd2wDMFQOUoHg64Q7MfBsbn/8wTxl24GaA=; b=n6SMWK8Lb/oO6zwE7DfSVLPi2Z
 D7ZNw6X1PpfXoJdVGR4/J2lUBjBtE0LtjOBlwgLSVBH5PItiSe7Hw/aFq427CyaIyQCqIFzUdj3Fq
 zQ5cG/2WjlSUvOUpGsagoP7SwHTM+6n92B0uf8oCqVldfxA7y3DIxW2EGRlfQ9mo0e4ZQxnN969wM
 j6t83tyJHyx6xR+9XeaXjJKwqZdKtAK9kJQcqvOA8Z8GWJKkECSQ4zJUqvax0RSaD9iMsL0M+RsU7
 sfyNqa3NygZ2MsDhKCR70onAAe2v1f7YIVd9edxYJtnezD1TkFXJGW8cyuTdrjILnaOCdVaQVZcD1
 qsJsjskA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoka-00AOEH-MD
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 13:18:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 12216B188;
 Wed, 12 May 2021 13:18:07 +0000 (UTC)
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210510144906.8305-1-hare@suse.de>
 <20210510155325.GA1857448@dhcp-10-100-145-180.wdc.com>
 <d3f800eb-a917-d139-b430-b7b7976331de@grimberg.me>
 <20210511213741.GA1924433@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: allow to re-attach namespaces after all paths are
 down
Message-ID: <75c0ab18-5dd5-a7a0-9e53-29f6200626ce@suse.de>
Date: Wed, 12 May 2021 15:18:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210511213741.GA1924433@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_061808_888766_A4F34BFE 
X-CRM114-Status: GOOD (  22.76  )
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

T24gNS8xMS8yMSAxMTozNyBQTSwgS2VpdGggQnVzY2ggd3JvdGU6Cj4gT24gTW9uLCBNYXkgMTAs
IDIwMjEgYXQgMDM6MjU6MDRQTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4gSGFubmVz
LCB5b3Ugc2VudCBhIHBhdGNoIGxpa2UgdGhpcyBiZWZvcmUsIG15IGNvbW1lbnQgd2FzIHRoYXQg
YSBuc2hlYWQKPj4gc2hvdWxkIGJlIHJlbW92ZWQgYmVmb3JlIHRoZSBmaW5hbCByZWZlcmVuY2Ug
KHdoaWNoIHdobyBrbm93cyB3aGVuIGl0Cj4+IHdpbGwgZXZlciBhcnJpdmUpIGFzIGlmIGEgbnNp
ZCB3ZXJlIHRvIGJlIHJldXNlZCBieSB0aGUgY29udHJvbGxlciBmb3IKPj4gYSBkaWZmZXJlbnQg
bmFtZXNwYWNlIHRoZW4gd2UnZCByZWplY3QgaXQgc28gSSdtIG5vdCBzdXJlIGhvdyB0aGlzIGhl
bHBzPwo+IAo+IEhtLCB5b3UncmUgY29uc2lkZXJpbmcgc29tZXRoaW5nIGxpa2UgaWYgYSB1c2Vy
IGRvZXMgbmFtZXNwYWNlCj4gbWFuYWdlbWVudCBjb21tYW5kcyB0byBkZWxldGUgb25lIHRoYXQg
aXMgaW4tdXNlIChtb3VudGVkLCByYWlkLCBldGMpLAo+IHRoZW4gY3JlYXRlcyBhbmQgYXR0YWNo
ZXMgYSBuZXcgbmFtZXNwYWNlIHRoYXQgaGFwcGVucyB0byBiZSBhc3NpZ25lZAo+IHRoZSBzYW1l
IE5TSUQuCj4gCj4gVGhlIG5ldyBvbmUgbWF5IGdldCBkaWZmZXJlbnQgRVVJL05HVUlEIHZhbHVl
cywgc28gdGhpcyBhcHByb2FjaCBoZXJlCj4gd291bGQgcHJldmVudCB0aGUgbmFtZXNwYWNlIGZy
b20gYmVpbmcgdXNhYmxlIHdpdGhvdXQgYWRkaXRpb25hbCB1c2VyCj4gaW50ZXJ2ZW50aW9uLiBJ
IHRoaW5rIHdlJ2Qgd2FudCB0aGUgZHJpdmVyIHRvIGFsbG9jYXRlIGFuIGVudGlyZWx5IG5ldwo+
IGhlYWQgaW4gdGhhdCBjYXNlIGlmIHdlIGNvdWxkIGRldGVjdCB0aGF0J3Mgd2hhdCBoYXBwZW5l
ZC4gVGhlcmUgaXMgYWxzbwo+IGEgcG9zc2liaWxpdHkgdGhhdCB0aGUgY29udHJvbGxlciByZWN5
Y2xlcyB0aGUgc2FtZSBOR1VJRCBmb3IgdGhlIG5ldwo+IG5hbWVzcGFjZSwgYW5kIHRoYXQgY291
bGQgYmUgY29uZnVzaW5nIGZvciB0aGUgYXBwbGljYXRpb24gaG9sZGluZyB0aGUKPiBvcGVuIHJl
ZmVyZW5jZSBvbiB0aGUgb2xkIG5hbWVzcGFjZS4KPiAKLi4uIGFuZCwgb2YgY291cnNlLCBub25l
IG9mIHRoaXMgd291bGQgaGFwcGVuIGlmIHdlIHdvdWxkIF9ub3RfIGtlZXAgdGhlCm9sZCBuc2hl
YWQgYXJvdW5kLiBJJ20gc3RpbGwgbm90IHN1cmUgX3doeV8gdGhpcyBpcyBjb25zaWRlcmVkCmlt
cG9ydGFudC4gQWZ0ZXIgYWxsLCB0aGluZ3Mgd29yayBwZXJmZWN0bHkgd2hlbiB0aGUgQ01JQyBi
aXQgaXMgbm90CnNldDsgZXZlbiBkZXZpY2UgaG90LXJlbW92YWwgYW5kIHJlLWluc2VydGlvbiAo
b25lIG9mIG91ciBJSFZzIHRlc3RlZAp0aGUgY3JhcCBvdXQgb2YgdGhhdCBvbmUsIGFuZCBJIGNh
biBjb25maWRlbnRseSBzdGF0ZSB0aGUgbnZtZSBzdGFjayBkaWQKbm90IGNhdXNlIGFueSBpc3N1
ZSB0aGVyZS4gVW5saWtlIG90aGVyIHN1YnN5c3RlbXMgLi4uKS4KClNvIEknbSByZWFsbHkgY3Vy
aW91cyB3aGljaCB1c2UtY2FzZSB3ZSdyZSB0cnlpbmcgdG8gc3VwcG9ydCB3aXRoIHRoYXQ7CkVJ
TyBpcyBFSU8sIGFuZCB0aGUgYXBwbGljYXRpb24gY291bGRuJ3QgY2FyZSBsZXNzIGlmIGl0J3Mg
Z2VuZXJhdGVkIGR1ZQp0byB0aGUgbnNoZWFkIHJ1bm5pbmcgb3V0IG9mIHBhdGhzIG9yIHRoZSBu
c2hlYWQgbm90IGV4aXN0aW5nLi4uCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVp
bmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJ
CSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRp
b25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
