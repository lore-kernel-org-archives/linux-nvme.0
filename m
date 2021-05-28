Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60CBC4708C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:21:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8228613D1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8228613D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=PztKIAcIAOsSJRv4cr2weoPt6NdA3aZw/KzT3YH3Ok8=; b=XeybFJ8sTVvjBN+UJUo21QfRoV
	gpXKDXHm/l4BbMwgTxo385UCA/KL//L+7EZnvJPINcYwoq+aVzkYZj7CTSfKEuFI7pnsnINzIBcx4
	fnoXfHJ18vew8Q2Xl0HUkuce5utouNjvmh3JNvjF5GLbhsARu5syCwoVoQpS/KGZh6OwLMgSRa4d6
	fmlxElYFbjr6w6uNkN5x5KSkYi6egDWMgtxsuFPms5Yd2cb/uduub4AACTi0KkHlEtS6cNB1y02zd
	g+vq9zZQq/RY92eOIXBvPlAURrVORfpyWeHSYHkWj8gm2SBqSMEUktfBhnyanBsxie61YTG6pmCrm
	Z95LjJJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmaY2-00EluB-DS; Fri, 28 May 2021 11:21:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmZjR-00EO53-SJ
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 10:28:47 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C2A21FD2F;
 Fri, 28 May 2021 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622197724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLLRnpJnwnC8lOZask4Sa9auCbouH/FcWbVFRXt2DYk=;
 b=FmYonH3hawVF0u4F4b7Mbul3DD8fU0bCXUrR8b8xd6trR/nRpMnsiNq6DM5E79SoSxM83L
 0PL3+C2WJWov6DOPoic2JX8sGO5VeO73mNH3FOmDvEjIzAQmVCt7V+esJIZ6OBAajc9KyD
 rk+Bd3+ULzglONNd6lPzK2T5E3j6Y9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622197724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LLLRnpJnwnC8lOZask4Sa9auCbouH/FcWbVFRXt2DYk=;
 b=cl5MuJyNjuopAISOmzWI78/p8GCtx9xLo/isHDmASKqSopCfc6ROuBratJkAeNr0de7vAa
 h6SifRoKJaNmZeAQ==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id 4682E11A98;
 Fri, 28 May 2021 10:28:44 +0000 (UTC)
Subject: Re: [RFC PATCH v6 04/27] nvme-tcp-offload: Add device scan
 implementation
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Dean Balandin <dbalandin@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-5-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <a2206752-973d-6d76-3d90-921388ac5a86@suse.de>
Date: Fri, 28 May 2021 12:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-5-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_032846_107665_E4CD1A36 
X-CRM114-Status: GOOD (  15.93  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IERlYW4gQmFsYW5k
aW4gPGRiYWxhbmRpbkBtYXJ2ZWxsLmNvbT4KPiAKPiBBcyBwYXJ0IG9mIGNyZWF0ZV9jdHJsKCks
IGl0IHNjYW5zIHRoZSByZWdpc3RlcmVkIGRldmljZXMgYW5kIGNhbGxzCj4gdGhlIGNsYWltX2Rl
diBvcCBvbiBlYWNoIG9mIHRoZW0sIHRvIGZpbmQgdGhlIGZpcnN0IGRldmljZXMgdGhhdCBtYXRj
aGVzCj4gdGhlIGNvbm5lY3Rpb24gcGFyYW1zLiBPbmNlIHRoZSBjb3JyZWN0IGRldmljZXMgaXMg
Zm91bmQgKGNsYWltX2Rldgo+IHJldHVybnMgdHJ1ZSksIHdlIHJhaXNlIHRoZSByZWZjbnQgb2Yg
dGhhdCBkZXZpY2UgYW5kIHJldHVybiB0aGF0IGRldmljZQo+IGFzIHRoZSBkZXZpY2UgdG8gYmUg
dXNlZCBmb3IgY3RybCBjdXJyZW50bHkgYmVpbmcgY3JlYXRlZC4KPiAKPiBBY2tlZC1ieTogSWdv
ciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERlYW4g
QmFsYW5kaW4gPGRiYWxhbmRpbkBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFr
YXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWth
ciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hh
bCBLYWxkZXJvbiA8bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVs
IEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8
c21hbGluQG1hcnZlbGwuY29tPgo+IFJldmlld2VkLWJ5OiBIaW1hbnNodSBNYWRoYW5pIDxoaW1h
bnNodS5tYWRoYW5pQG9yYWNsZS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS9ob3N0L3RjcC1v
ZmZsb2FkLmMgfCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykKPiAKSSdtIG5vdCBlbnRpcmVseSBoYXBweSB3aXRo
IHRoZSBsb29rdXAgbWVjaGFuaXNtOyBvbmUgc2hvdWxkIGxvb2sgYXQKY29udmVydGluZyBpdCB0
byBhIHByb3BlciAnYnVzJyBsaWtlIHRoZSBtZWxsYW5veCBkcml2ZXIgZGlkLgpCdXQgdGhhdCdz
IHNvbWV0aGluZyB3b3VsZCBjb3VsZCBiZSBkb25lIGF0IGEgbGF0ZXIgc3RhZ2UuCgpSZXZpZXdl
ZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0g
CkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cmhh
cmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2
cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=
