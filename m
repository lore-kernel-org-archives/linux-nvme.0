Return-Path: <SRS0=G/Rm=MN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B380C07E9B
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:08:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062646024A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jul 2021 06:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062646024A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=/AvY1qTvw+M2B1vljk0AkqFWN/8mImPSODRqyXX2rFc=; b=a6E6TpqOMRyCNXJIGZngKW4iWA
	XkWzm0XdtnkG6AgC76nvW+rAO1RXIWhv6C9TNOmvV+lqRbqQ1SfoLEClfSgPVzs2JpLiJWtP21s0n
	dkINRGZ5jdF+6jbigXNJzlqW55y+JZHP2HeNKL7h1u+lHYLv4WtdL9ys5EVl+KfRxDrpQpBQrbRoT
	QiXQhXiBeUwDCnpVeiqLOxIKJnmJIi3ZEBYmV4FzMeMafL9SDcyUT8ebMiVuxlnVcq2uoIYeIrjFF
	lW94sFLpKPgPa5CC93nPXRsTwB6aqpSD53BIYzrKttt8aSzq+E1UaHv36XUmpyi0Sdounb+nN/koz
	SidjtFSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m65Os-00EYp1-ET; Wed, 21 Jul 2021 06:08:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m65Op-00EYoO-O7
 for linux-nvme@lists.infradead.org; Wed, 21 Jul 2021 06:08:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D97D4224CD;
 Wed, 21 Jul 2021 06:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626847685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYj9KiJVrhiYcTQ+iUDXp8rg+ELidPbaHpW20hGsliE=;
 b=THp1dYd43Q1OmgNGTDgkYdnnKsE5tk7cecT6Af9uSYxb2NlqcFs9qWJo8FIcREcOMmK2rk
 Q6CMYdpsNCC1qL1f6+H5KFeDNd+rbJhtIjAhXjnGyjgtuWfCp3EqM3G4AYeITQO0PO3w9u
 t7gzI8i+jgvPRBmshZLYKOYF18sAvfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626847685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYj9KiJVrhiYcTQ+iUDXp8rg+ELidPbaHpW20hGsliE=;
 b=EyakkcMPna1jg0ywbNF4HH2MxLV1uoIaGBMolNepkidTfDgMOquJGPONPUgik6dmIPEZB6
 rmC4kDgTzY076bBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8BF4133D1;
 Wed, 21 Jul 2021 06:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uCexMMW592C9bAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 21 Jul 2021 06:08:05 +0000
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
To: Vladislav Bolkhovitin <vst@vlnb.net>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-7-hare@suse.de>
 <2946f3ff-bfa5-2487-4d91-c5286e3a7189@vlnb.net>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a728cc00-700a-203b-d229-a4592af7b936@suse.de>
Date: Wed, 21 Jul 2021 08:08:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2946f3ff-bfa5-2487-4d91-c5286e3a7189@vlnb.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_230807_975957_9DDA7473 
X-CRM114-Status: GOOD (  12.68  )
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

T24gNy8yMC8yMSAxMDoyNyBQTSwgVmxhZGlzbGF2IEJvbGtob3ZpdGluIHdyb3RlOgo+IAo+IE9u
IDcvMTYvMjEgMjowNCBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOgo+IAo+IFsuLi5dCj4gCj4+
ICtzdHJ1Y3QgbnZtZXRfZGhjaGFwX2hhc2hfbWFwIHsKPj4gKwlpbnQgaWQ7Cj4+ICsJaW50IGhh
c2hfbGVuOwo+PiArCWNvbnN0IGNoYXIgaG1hY1sxNV07Cj4+ICsJY29uc3QgY2hhciBkaWdlc3Rb
MTVdOwo+PiArfSBoYXNoX21hcFtdID0gewo+PiArCXsuaWQgPSBOVk1FX0FVVEhfREhDSEFQX0hB
U0hfU0hBMjU2LAo+PiArCSAuaGFzaF9sZW4gPSAzMiwKPj4gKwkgLmhtYWMgPSAiaG1hYyhzaGEy
NTYpIiwgLmRpZ2VzdCA9ICJzaGEyNTYiIH0sCj4+ICsJey5pZCA9IE5WTUVfQVVUSF9ESENIQVBf
SEFTSF9TSEEzODQsCj4+ICsJIC5oYXNoX2xlbiA9IDQ4LAo+PiArCSAuaG1hYyA9ICJobWFjKHNo
YTM4NCkiLCAuZGlnZXN0ID0gInNoYTM4NCIgfSwKPj4gKwl7LmlkID0gTlZNRV9BVVRIX0RIQ0hB
UF9IQVNIX1NIQTUxMiwKPj4gKwkgLmhhc2hfbGVuID0gNjQsCj4+ICsJIC5obWFjID0gImhtYWMo
c2hhNTEyKSIsIC5kaWdlc3QgPSAic2hhNTEyIiB9LAo+PiArfTsKPiAKPiAiaG1hYygpIiBpcyBh
bHdheXMgaGVyZSwgc28gd2h5IG5vdCB0byBqdXN0IGF1dG8tZ2VuZXJhdGUgaG1hYyhzaGE1MTIp
Cj4gZnJvbSBzaGE1MTI/Cj4gCgouLi4gYWxsIHBhcnQgb2YgdGhlIGxlYXJuaW5nIGN1cnZlIC4u
LgpJZiB0aGF0J3MgdHJ1ZSB0aGVuIG9mIGNvdXJzZSBJIGNhbiBhdXRvLWdlbmVyYXRlIHRoZSBo
bWFjIG5hbWUuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAg
ICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5i
ZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
