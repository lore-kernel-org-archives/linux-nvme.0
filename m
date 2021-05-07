Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFFDC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:20:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 851CC6145E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851CC6145E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KUKj9U2qQW9O3KwP6PxyBLv4SJmnKY35DPA3r8VFuI8=; b=ehSxC8HwbUneZVNZVWEZ3jF7g
	umG4BI0gpQnxMjwf5Ea54/oUN8YXz6kxWNO8++EOGZjiPtEtGHZvM+WocHkDi/s7jRlBjxdcALOu1
	1i+84MAQ48rrYp4FS0pKN4sFiTnqoOz97gvRMyZ2xRj1dJngJBoPnSuQ8pmDM4tcbga0Xbat33B4e
	/g3t9O5qRwaJsegWZrAs3TEtgSiHl3gNOcxl0s+7uMqwOFzmpj8N9XWLRjIssx4H0E3Yz3jSNuKWB
	wKsYsAxbWQqWETdjE+zyyFQnqY0j78MUmONZTOX9RE5AEeyuGprHSg2ZQg+mMVGYfURD39rgkIQz8
	cbtalsR6Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf49M-007f0o-25; Fri, 07 May 2021 17:20:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf49J-007f0V-Sc
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 17:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=LC0GOsjnO2OwpHMUbo6mmVic2N2fIbRbpi52Vu8wkds=; b=zrD+NGEUCGuKbdCmvNqUwB96wJ
 yI1gp+JGWAncPuj9MYQCcsKK4CdXj7/SPfQ/bHuzMOPRhlvO+lrodiOusZpDVmy7yEsajz25GY0Kx
 nf+HQ8akiPGoMdCftBP2GV5cIa/EiO+iM/V8oUu3yqYu/FquBMVMh8P08i7Tszp2kcSr9Xo/+XrK7
 FMz38y4VHtaD/syBIXVlsWa4OZT+0WYtBgKLlulhJ1az3Zu/5kVK2pqK0c76bouFoe1FJaAfK1C7B
 c1AhpnbsX0+Oui0orX3976n2NdzDQhrFaJO5ryw1dCtE8wzoZhHyTxhdDqoJbqkZ+0p4uOiU2SvFG
 RAhpaffQ==;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf49H-0072FY-Eo
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 17:20:24 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 4-20020a05600c26c4b0290146e1feccd8so5305213wmv.1
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 10:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LC0GOsjnO2OwpHMUbo6mmVic2N2fIbRbpi52Vu8wkds=;
 b=sqA4kztZu4YiFL9LkDR1ERbM/PD4f39LMg/KsRkuSdOgTEq8FaYJqSd4WMqB4cfN2k
 U572AJhOkZnYhDwPXpIhl2CVG0psdIngckPVPaLhnDnzWnuIA90VkjabxFkIX2RQjYEa
 nINVLwReUxUOs2Bml84c0rxpluz9r6nUiF5CjHfrVE4A0BPCEj0F6emQSie72Nv3uO4P
 jj0IChsAoTO5Tfmvjm2esTvl3000N8tocnwfDPN/ZYsv0RyErUEsbRspBlqlwbovsXzj
 HfW29/BH1npfslAOOoa30tkhijIIwCan4Er7TzbeaOhd36DOsXqmdfjgFXc/jdQYKr3z
 ch5w==
X-Gm-Message-State: AOAM532HeZB+evqxCG27GcTLqrkWSzNjODsjrC5+A9iY1cAxqKV65jhN
 d6+3RofnXghE3N48Q5oKCF3fuP0vwzA=
X-Google-Smtp-Source: ABdhPJwX4ISPktcJkIII+XKrpq6kCKMxArzUT8H4uk2qyqSH1OCAL6Ra+wQfNwHO004hq740PZN5nQ==
X-Received: by 2002:a1c:1f8d:: with SMTP id f135mr8338567wmf.109.1620408021951; 
 Fri, 07 May 2021 10:20:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7945:4a4a:9424:5a3f?
 ([2601:647:4802:9070:7945:4a4a:9424:5a3f])
 by smtp.gmail.com with ESMTPSA id y15sm9079894wrh.8.2021.05.07.10.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 10:20:21 -0700 (PDT)
Subject: Re: [PATCHv3] nvme-mpath: delete disk after last connection
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <daniel.wagner@suse.de>
References: <20210501120447.45478-1-hare@suse.de>
 <20210504085457.GA21826@lst.de>
 <5e4df9ec-c66c-17cf-542f-bac71b490e62@suse.de>
 <d1ca6eab-1ec9-d6c7-ed8a-00d9110bf023@grimberg.me>
 <20210506074341.GC14615@lst.de>
 <96fbc678-a7e8-aaf3-5f15-8c866e683afe@suse.de>
 <d50ca6e6-5340-6f38-bc56-6f10b49d7801@grimberg.me>
 <20210506120855.GA1546@lst.de> <7cd891d9-6aa0-fd98-cbc5-1df2eabbe31d@suse.de>
 <20210507064656.GA24437@lst.de>
 <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <da9afc01-756b-2e09-b669-2f41cb85a177@grimberg.me>
Date: Fri, 7 May 2021 10:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4fd33328-9060-6e95-dd26-ab013e44c07a@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_102023_515669_DB25C2D5 
X-CRM114-Status: GOOD (  17.42  )
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

Cj4+PiBQQ0kgYW5kIGZhYnJpY3MgaGF2ZSBkaWZmZXJlbnQgZGVmYXVsdHM7IGZvciBQQ0kgdGhl
IGRldmljZSBnb2VzIGF3YXkgaWYKPj4+IHRoZSBsYXN0IHBhdGggKGllIHRoZSBjb250cm9sbGVy
KSBnb2VzIGF3YXksIGZvciBmYWJyaWNzIGl0IGRvZXNuJ3QgCj4+PiBpZiB0aGUKPj4+IGRldmlj
ZSBpcyBtb3VudGVkLgo+Pgo+PiBFcnIsIG5vLsKgIEZvciBmYWJyaWNzIHdlIHJlY29ubmVjdCBh
IHdoaWxlLCBidXQgb3RoZXJ3aXNlIHRoZSBiZWhhdmlvcgo+PiBpcyB0aGUgc2FtZSByaWdodCBu
b3cuCj4+Cj4gTm8sIHRoYXQgaXMgbm90IHRoZSBjYXNlLgo+IAo+IFdoZW4gYSBQQ0kgbnZtZSBk
ZXZpY2Ugd2l0aCBDTUlDPTAgaXMgcmVtb3ZlZCAodmlhIHBjaSBob3RwbHVnLCBzYXkpLCAKPiB0
aGUgbnZtZSBkZXZpY2UgaXMgY29tcGxldGVseSByZW1vdmVkLCBpcnJlc3BlY3RpdmUgb24gd2hl
dGhlciBpdCdzIAo+IG1vdW50ZWQgb3Igbm90Lgo+IFdoZW4gdGhlIF9zYW1lXyBQQ0kgZGV2aWNl
IHdpdGggQ01JQz0xIGlzIHJlbW92ZWQsIHRoZSBudm1lIGRldmljZSAoaWUgCj4gdGhlIG5zbmhl
YWQpIHdpbGwgX3N0YXlfIHdoZW4gbW91bnRlZCAoYXMgdGhlIHJlZmNvdW50IGlzIG5vdCB6ZXJv
KS4KPiAKPiBUaGlzIGNhbiBiZSBlYXNpbHkgZGVtb25zdHJhdGVkIG9uIHFlbXU7IGp1c3Qgc2V0
IHRoZSAnc3Vic3lzJyBwYXJhbWV0ZXIgCj4gZm9yIHRoZSBudm1lIGRldmljZS4KClBlcmhhcHMg
d2UgbmVlZCB0byBmaXggdGhlIGlzc3VlIGFuZCBhbGxvdyB0aGUgZXhpc3RpbmcgYmVoYXZpb3Ig
YnkKaGF2aW5nIGFuIGV4cGxpY2l0IHF1ZXVlX2lmX25vX3BhdGggYXJndW1lbnQuCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
