Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A036DC4BA06
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:14:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C8520732
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p0QCFEPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C8520732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5dohCTJIdZOW73yHYE+9YxLFyGsilFwK8YuNdagIi3E=; b=p0QCFEPV7nRdVmUgot6I9i6P5
	JAtLN20LjCt6kIh9vqbLOOuW8hmVdojtRQsspFtg174BI0UZCMCyYzIif57xdaKONHaKGM4kdT9h9
	uq7OaVezKH//m8nbpEIQLnSphLNGZ9IMJl8WPbxo4l8pCblu5gIsi9cPPcmyd5/RRKBNLfa866PIJ
	rEBSf9IeYB4F5xduFRy2T34eUxP8scXOQkmi2HfsV9/R2XosIPc97rK8ewtvH+8PTkInrJ30N1YEj
	4acJUcqyuqQdSjBnJxzaYvKmNm4JQrVJ71ZrVzCauoR0fciYaOK+L3FQyJOK9u+g70Io1lRGKlbZJ
	zVA2gwJBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6kLm-0005Pd-EG; Wed, 26 Feb 2020 00:14:54 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6kLj-0005PH-Q9
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 00:14:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1EC33ABF4;
 Wed, 26 Feb 2020 00:14:50 +0000 (UTC)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <d1aabd1c-dd2a-df7e-3735-dd36c3f1c53f@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3611ba73-0d9d-a7ed-356b-bb856711a27c@suse.de>
Date: Wed, 26 Feb 2020 01:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d1aabd1c-dd2a-df7e-3735-dd36c3f1c53f@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_161451_997518_D6488785 
X-CRM114-Status: GOOD (  14.77  )
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
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNi8yMCAxOjA4IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBBcyBwZXIgTlZN
ZS1vRiBzcGVjIHNxIGZsb3cgY29udHJvbCBpcyBhY3R1YWxseSBtYW5kYXRvcnksIGFuZCB3ZSBz
aG91bGQKPj4gYmUgaW1wbGVtZW50aW5nIGl0IHRvIGF2b2lkIHRoZSBjb250cm9sbGVyIHRvIHJl
dHVybiBhIGZhdGFsIHN0YXR1cwo+PiBlcnJvciwgYW5kIHRyeSB0byBwbGF5IG5pY2VseSB3aXRo
IGNvbnRyb2xsZXJzIHVzaW5nIHNxIGZsb3cgY29udHJvbAo+PiB0byBpbXBsZW1lbnQgUW9TLgo+
IAo+IFdoeSBpcyB5b3VyIHRhcmdldCBzZXR0aW5nIFNRIGZsb3cgY29udHJvbCBkaXNhYmxlIGlu
IHRoZSBkaXNjb3ZlcnkKPiBsb2cgZW50cnkgdHJlcSBmaWVsZD8gV2UgYXJlIG5vdCBzdXBwb3Nl
ZCB0byBkbyBpdCBpZiB0aGUgTlZNIHN1YnN5c3RlbQo+IGRvZXNuJ3Qgc3VwcG9ydCBpdC4KRGlk
IEkgc2F5IHRoaXM/IEkgd2Fzbid0IGF3YXJlIHRoYXQgSSBkaWQgaW1wbHkgdGhhdCBpbiBhbnkg
d2F5LgpJJ20ganVzdCB1c2luZyB0aGUgZmxhZyB0byBmaWd1cmUgb3V0IGlmIHNxIGZsb3cgY29u
dHJvbCBpcyBkaXNhYmxlZCBvciBub3QuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICBUZWFtbGVhZCBTdG9yYWdlICYgTmV0d29ya2luZwpoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VT
RSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
CkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5k
w7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
