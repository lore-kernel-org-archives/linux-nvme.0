Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40A7C49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 10:49:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE352613DA
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 10:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE352613DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i/ZjjpUg11u0SwE3GoRsV9BFpC+EyTwMjQwxTZwsyI8=; b=y8Vqokg/qTGr8l5zXbr2AgzD/B
	EJWgzjj/WVj8GpOoa8EOauz0yIBs4AFBDf0jMlSA9SJhrU+JPodejhUCgBpxZT7ua2aP3Z+cUmlVw
	wTuLO6IzR6GpAC6uYjYyLYux2HO2qvIk+7Rjzx954MsRamQzuBuHR8OsjGEIPGWaCzExKtx++Vz4w
	ITdweoKEaJ3Ivioe0PYEVev9P+Dcs3binHqZJs9ePCKDDB0kH2mD/8ybL7NxURMQDG86fzCXiiyQz
	VAW0nX8PWH1kRCYwzycTVOdrXgy6x/86hlDUitVFqjXhJq9XBP7nZGaGZqvpu6jja7YTGR9EdTWnz
	+Q/Z2Ttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwMvE-00EEsh-Le; Thu, 24 Jun 2021 10:49:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwMvC-00EEr8-6t
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 10:49:23 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8A7D1FD35;
 Thu, 24 Jun 2021 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624531760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9oV592X+YGCnULusaYWeqUq0qHPVzUEyAXprYQwitM=;
 b=FOfhBTrwK8vqqRKLv3egwL32EeXW388sjxzZRo1jwQ0Cc0gcCzdQ5MNKWZ5bxVaEf82BFK
 rtttwSWlLFiNt5oYl9aFF0kW4ym5Wwo7F83WxtHkiwUrBbT1jm/vqXz0uF1j32GunLMDAe
 +/3NfwYiPy1AzSzfbAjGik4TeZ5KS9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624531760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9oV592X+YGCnULusaYWeqUq0qHPVzUEyAXprYQwitM=;
 b=RJRiyS4YxfabMHqSgdZbxRKMQ9W25376n8/scMq7A0cpHBNMI03NxyXRNHp9i/Upb0lIqy
 /zPC938XRze9MzBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id D27E111A97;
 Thu, 24 Jun 2021 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624531760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9oV592X+YGCnULusaYWeqUq0qHPVzUEyAXprYQwitM=;
 b=FOfhBTrwK8vqqRKLv3egwL32EeXW388sjxzZRo1jwQ0Cc0gcCzdQ5MNKWZ5bxVaEf82BFK
 rtttwSWlLFiNt5oYl9aFF0kW4ym5Wwo7F83WxtHkiwUrBbT1jm/vqXz0uF1j32GunLMDAe
 +/3NfwYiPy1AzSzfbAjGik4TeZ5KS9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624531760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9oV592X+YGCnULusaYWeqUq0qHPVzUEyAXprYQwitM=;
 b=RJRiyS4YxfabMHqSgdZbxRKMQ9W25376n8/scMq7A0cpHBNMI03NxyXRNHp9i/Upb0lIqy
 /zPC938XRze9MzBw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id TMAwMzBj1GAzbgAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 10:49:20 +0000
To: Keith Busch <kbusch@kernel.org>, "Rao, Vinay" <Vinay.Rao@dell.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>, Christoph Hellwig <hch@lst.de>,
 Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Message-ID: <097e56b6-2b13-e00c-ef84-509fa0e887ca@suse.de>
Date: Thu, 24 Jun 2021 12:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_034922_451995_E0B173F5 
X-CRM114-Status: GOOD (  20.18  )
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

T24gNC8zMC8yMSA2OjIxIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBGcmksIEFwciAzMCwg
MjAyMSBhdCAwNToxNDo1NUFNICswMDAwLCBSYW8sIFZpbmF5IHdyb3RlOgo+PiArIE1hZGh1Cj4+
Cj4+IEhpIENoYWl0YW55YSwgCj4+Cj4+IFNvbWUgb2YgdGhlIEFFTidzIGxpa2UgQU5BIHN0YXRl
IGNoYW5nZSBhbmQgTmFtZSBTcGFjZSBhdHRyaWJ1dGUgY2hhbmdlIGV2ZW50cyBhcmUgb2YgaW50
ZXJlc3Qgb3V0c2lkZSB0aGUgTlZNRSBkcml2ZXIuIAo+Pgo+PiBJdCB3b3VsZCBiZSBnb29kIHRv
IGNvbnNpZGVyIHRoZXNlIGV2ZW50cyB0byBiZSBwcm9wYWdhdGVkIHVwIHRvIHVzZXIgc3BhY2Uu
IEkgYW0gbm90IHlldCBjb252aW5jZWQgb24gaG93IHByb3BhZ2F0aW5nCj4+IHRoaXMgYWJvdmUg
dG8gdXNlciBzcGFjZSBpcyBwcm9ibGVtYXRpYy4KPiAKPiBUaGUgbmFtZXNwYWNlIGF0dHJpYnV0
ZSBjaGFuZ2UgZXZlbnQgcGFpcnMgd2l0aCB0aGUgQ2hhbmdlZCBOYW1lc3BhY2UKPiBMaXN0IGxv
ZywgYW5kIHJlYWRpbmcgdGhhdCBsb2cgd2lsbCBjaGFuZ2UgdGhlIHJlc3VsdCBmb3IgYSBzdWJz
ZXF1ZW50Cj4gcmVhZGVyLiBVc2VyIHNwYWNlIHJhY2luZyB3aXRoIHRoZSBrZXJuZWwgb24gYSBs
b2cgYWNjZXNzIHdoZW4gdGhlcmUgYXJlCj4gcmVhZCBzaWRlIGVmZmVjdHMgY3JlYXRlcyBub24t
ZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciwgYW5kIHRoYXQgaXMKPiBwcm9ibGVtYXRpYy4KPiAKSXQg
d291bGQsIGlmIHdlIHdlcmUgcmVseWluZyBvbiB0aGUgQ2hhbmdlZCBOYW1lc3BhY2UgTGlzdCBs
b2cuCkJ1dCBpbiB0aGUgZW5kIHdlJ3JlIGp1c3QgcmVhZGluZyBpdCB0byBjbGVhciB0aGUgQUVO
IGZsYWc7IHRoZSBjb250ZW50cwphcmUgY29tcGxldGVseSBpbW1hdGVyaWFsIHRvIHVzIGFzIHdl
J3JlIGRvaW5nIGEgZnVsbCBuYW1lc3BhY2Ugc2NhbgphZnRlcndhcmRzIGFueXdheS4KU28gSSBk
b24ndCB0aGluayB0aGF0IHRoYXQnbGwgYmUgYSBwcm9ibGVtIGZvciB1cy4KCldoYXQgd2lsbCBi
ZSBwcm9ibGVtYXRpYywgdGhvdWdoLCBpcyBpZiB3ZSB3ZXJlIHRvIGFsbG93IHVzZXJzcGFjZSB0
bwpyZWdpc3RlciBhbiBBRU47IGFzIHNvb24gYXMgdGhlIGNvbnRyb2xsZXIgYWxsb3dzIG1vcmUg
dGhhbiBvbmUgcGVuZGluZwpBRVJzIHRoZXJlIG5vdGhpbmcgcHJldmVudGluZyBpdCBmcm9tIGRv
aW5nIHNvLgpJZiBoZSBkb2VzIG91ciBpbnRlcm5hbCBzdGF0ZXMgd2lsbCBiZSBtZXNzZWQgdXAg
YXMgd2UncmUgbm90IHJlY2VpdmluZwphbGwgZXZlbnRzLiBJJ2QgcmF0aGVyIGVycm9yIG91dCBh
bnkgYXR0ZW1wdCBoZXJlLCBidXQgdGhlbiB3ZSBjYW4ndCBkbwphIGZ1bGwgcGFzc3Rocm91Z2gs
IGFuZCBJIGd1ZXNzIHRoaW5ncyBsaWtlIFNQREsgbWlnaHQgYmVjb21lIHVuaGFwcHkuCgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0
b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0
ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=
