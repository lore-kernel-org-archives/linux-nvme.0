Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38CC433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 13:00:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC9564F02
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 13:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC9564F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/FEQlxR399H1nCI7QOlk++QmP49KNIbm8/1zV5sBCvU=; b=WYDiYLAhyMWSadaUbkQYKdM58
	NFAZgL9T/kJPMyr26U7rqalOI16WgZEpR+hx2QMrlnhD6ZdJYCbjkMA5gtRYE2Wss0r/hJYxoziJj
	jqrScX9q2y99L8N28fd+VFjJCqD0CHQ+C6yO19TPNbo5DUhd17CptFf+ce0zwNLpCaUtcADKZgSnN
	qCCFFIXUeEM2YYBimuzubfYX5iv94uQNrrCcc1kMlWM6uWdUzoLeYbCueZVhJ1bTz2ObPUu1y26EG
	kk9nivGOZC5gueMTlUXuaGzZbbmrpRaJUcujd0tFIQZZ6Z8xrDdPz2vp0CTure883S/I7E6mIz8kf
	8mB6yirfw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnaR-008gJq-RG; Thu, 04 Mar 2021 13:00:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHnTY-008fZF-7u
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:53:47 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B92DFADDB;
 Thu,  4 Mar 2021 12:53:07 +0000 (UTC)
Subject: Re: [PATCH v8 16/16] scsi: Made changes in Kconfig to select
 BLK_CGROUP_FC_APPID
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-17-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <9e01bb33-f8b0-3770-40f2-06adf5d9a917@suse.de>
Date: Thu, 4 Mar 2021 13:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-17-git-send-email-muneendra.kumar@broadcom.com>
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

T24gMy80LzIxIDY6MjcgQU0sIE11bmVlbmRyYSB3cm90ZToKPiBBZGRlZCBhIG5ldyBjb25maWcg
RkNfQVBQSUQgdG8gc2VsZWN0IEJMS19DR1JPVVBfRkNfQVBQSUQKPiB3aGljaCBFbmFibGUgc3Vw
cG9ydCB0byB0cmFjayBGQyBpbyBUcmFmZmljLgo+IAo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNdW5lZW5kcmEgPG11bmVl
bmRyYS5rdW1hckBicm9hZGNvbS5jb20+Cj4gCj4gLS0tCj4gdjg6Cj4gTm8gY2hhbmdlCj4gCj4g
djc6Cj4gTW9kaWZpZWQgdGhlIEtjb25maWcgY29tbWVudHMKPiAKPiB2NjoKPiBNb2RpZmllZCB0
aGUgS2NvbmZpZyBjb21tZW50cwo+IAo+IHY1Ogo+IE5vIGNoYW5nZQo+IAo+IHY0Ogo+IEFkZHJl
c3NlZCB0aGUgZXJyb3IgcmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3QKPiAKPiB2MzoKPiBO
ZXcgcGF0Y2gKPiAtLS0KPiAgIGRyaXZlcnMvc2NzaS9LY29uZmlnIHwgMTMgKysrKysrKysrKysr
Kwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL0tjb25maWcgYi9kcml2ZXJzL3Njc2kvS2NvbmZpZwo+IGluZGV4IDA2Yjg3
YzdmNmJhYi4uMjBhYTE1MzZhM2JhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9LY29uZmln
Cj4gKysrIGIvZHJpdmVycy9zY3NpL0tjb25maWcKPiBAQCAtMjM1LDYgKzIzNSwxOSBAQCBjb25m
aWcgU0NTSV9GQ19BVFRSUwo+ICAgCSAgZWFjaCBhdHRhY2hlZCBGaWJlckNoYW5uZWwgZGV2aWNl
IHRvIHN5c2ZzLCBzYXkgWS4KPiAgIAkgIE90aGVyd2lzZSwgc2F5IE4uCj4gICAKPiArY29uZmln
IEZDX0FQUElECj4gKwlib29sICJFbmFibGUgc3VwcG9ydCB0byB0cmFjayBGQyBJL08gVHJhZmZp
YyIKPiArCWRlcGVuZHMgb24gQkxPQ0sgJiYgQkxLX0NHUk9VUAo+ICsJZGVwZW5kcyBvbiBTQ1NJ
Cj4gKwlzZWxlY3QgQkxLX0NHUk9VUF9GQ19BUFBJRAo+ICsJZGVmYXVsdCB5Cj4gKwloZWxwCj4g
KwkgIElmIHlvdSBzYXkgWSBoZXJlLCBpdCBlbmFibGVzIHRoZSBzdXBwb3J0IHRvIHRyYWNrCj4g
KwkgIEZDIEkvTyB0cmFmZmljIG92ZXIgZmFicmljLiBJdCBlbmFibGVzIHRoZSBGYWJyaWMgYW5k
IHRoZQo+ICsJICBzdG9yYWdlIHRhcmdldHMgdG8gaWRlbnRpZnksIG1vbml0b3IsIGFuZCBoYW5k
bGUgRkMgdHJhZmZpYwo+ICsJICBiYXNlZCBvbiBWTSB0YWdzIGJ5IGluc2VydGluZyBhcHBsaWNh
dGlvbiBzcGVjaWZpYwo+ICsJICBpZGVudGlmaWNhdGlvbiBpbnRvIHRoZSBGQyBmcmFtZS4KPiAr
Cj4gICBjb25maWcgU0NTSV9JU0NTSV9BVFRSUwo+ICAgCXRyaXN0YXRlICJpU0NTSSBUcmFuc3Bv
cnQgQXR0cmlidXRlcyIKPiAgIAlkZXBlbmRzIG9uIFNDU0kgJiYgTkVUCj4gClNob3VsZCBiZSBt
ZXJnZWQgd2l0aCB0aGUgcGF0Y2ggdXNpbmcgdGhlIEtjb25maWcgc2V0dGluZ3MuCgpDaGVlcnMs
CgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRz
dHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6Rm
dHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LW52bWUK
