Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B433C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 15:52:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EBC61101
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 15:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10EBC61101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AK2EqIoxxGrGrcVLli2xnnu93NyXF/BCAyPPpAiwfdU=; b=hrwN2RPM1EByfzj3QSHXMAsl0Y
	OGR/OV7bNR+Bvicz+LfzF47+Vq3Sr9Tz6hE9j7L3Bw1S62blniBd5GpnxPbwYWLY2zoO/ZasFrJ3Z
	dxbN/MkKVhef7wgP+3c7gfXm0/U7GOTMS3OeXzZZ1i6p1vqRm2hDaKtys6DXbkoMMqQ6+ifULHyeL
	aOB0tRYcCmSnxJWPRRz/ejsSKNB9be4iH6oDX6Q/uAmFJDyC8ljg532jVQwZUAGU16dztXuMvUSit
	wGFvB3J1phHOTXAn2Y1EwGDMjtskyrR+6RfEzyuN7MaWvhxECBkAxL1TRmyy+wvweaA+huI2qIUTb
	GEgJgXdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIvBd-007c0F-Oq; Wed, 25 Aug 2021 15:51:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIvBY-007bys-02
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 15:51:32 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 29E6020128;
 Wed, 25 Aug 2021 15:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629906686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MccwDfvIRHA1wKv36RouYR5dfCf1KOnt4ZYAj6Mqvo0=;
 b=Rh1RZWSXFMYnhWwYjLw4+60Epx2V2QYHUMUCFGQYM+ttLZzn2LK9qpP7DCsJ9B88toEg7M
 lgaTSe9Ramhii3yZ4B595WOsxpuSEQUCv3wMbXWPya2E3qAU0O/do4HZTmePWtV0MabOTc
 ER73EpH6Di3lSIk63fAFx9CHvwBxP6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629906686;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MccwDfvIRHA1wKv36RouYR5dfCf1KOnt4ZYAj6Mqvo0=;
 b=95N6DcY2DvXZ2+FlYlbvCwZn5Lwl1a9PeKIIGHjin2qC1Zw/J5LIooUQS1tVYotrDaf3uP
 nhuvz3a9XH4Ru6Dw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E5C0D13A89;
 Wed, 25 Aug 2021 15:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id XKoeNv1mJmFgXgAAGKfGzw
 (envelope-from <hare@suse.de>); Wed, 25 Aug 2021 15:51:25 +0000
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
To: "hch@lst.de" <hch@lst.de>, sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <20210825085345.GA31419@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2fc5b98a-b397-3be1-1957-986e8b6aa732@suse.de>
Date: Wed, 25 Aug 2021 17:51:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210825085345.GA31419@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_085128_229294_4DC2FC91 
X-CRM114-Status: GOOD (  13.61  )
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

T24gOC8yNS8yMSAxMDo1MyBBTSwgaGNoQGxzdC5kZSB3cm90ZToKPiBBbnkgcmVhc29uIHdlIGNh
bid0IGp1c3QgY2FsbCB0aGlzIGZyb20gbnZtZV9wYXNzdGhydV9lbmQgaW5zdGVhZAo+IG9mIGlu
dmVudGluZyBhIG5ldyBBUEk/ICBSaWdodCBub3cgdGhlIG52bWV0IHBhc3N0aHJvdWdoIGNvZGUg
bmV2ZXIKPiB1c2VzIHRoZSB1bmRlcmx5aW5nIGtlZXAgYWxpdmUgY29kZSwgc28gaXQgZG9lc24n
dCBtYWtlIGEgZGlmZmVyZW5jZSwKPiBidXQgSSBleHBlY3Qgd2UnbGwgbmVlZCBtb3JlIGhhbmRs
aW5nIGZvciBwYXNzdGhyb3VnaCBjb21tYW5kcyBsaWtlCj4gdGhpcywgYW5kIHdlIG1pZ2h0IGFs
c28gZ3JvdyBtb3JlIHVzZXJzIChlLmcuIHRoZSBpb191cmluZyBiYXNlZAo+IHBhc3N0aHJvdWdo
KS4KPiAKWWVhaCwgd2UnbGwgbmVlZCB0aGF0IGFueXdheSBpZiBhbmQgd2hlbiBob3N0aWQgYmVj
b21lcyBzZXR0YWJsZS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAg
ICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBT
b2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAo
QUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
