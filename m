Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E085DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F82860200
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 06:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F82860200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDWUT3cV4Hv4DGir937++Q2ZoBsh4q8Kepi7BRNuYPM=; b=GuEs+gJQxUxQlXx1NPNncplGRF
	EvMEr1zLj9juSG5yDOpjB4N4Syg/E1IallqNLihidACvCP33rPVg4KmpeZYfiXPVfNog0CbJYpSdK
	HJzdCVa2HNT9d/ABR9opjaVkzE+Zol5U2BenucQ9u9m/noxegHo8n0U1PyoE0tCevuCkj1dMmVGus
	5+iTwIZMgv44vFykIhwWlP8ipRSkV50njSdO4cHOFf7/FDvCsysXw3s142/7p5iifHq3MXTLMD62f
	XoBjtGZemyLejsSRYSUgTxKTi2CtJ9d7SpLV/rcMrdePtpv3IjYScuTdr+5kxNKLj6llyt8GKYOQ1
	Cu1xPh+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ23E-004IeQ-TA; Tue, 14 Sep 2021 06:36:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ23B-004Idl-GY
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 06:36:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C84AA220AF;
 Tue, 14 Sep 2021 06:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631601371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQGVjuaI5/qCIUYMdxGT1f2TfrIwRnyWcIXUj9n7LEQ=;
 b=MKZ66PNfMWQ96+8uj48e9iUY9BPpWC0tjYB3E0Y2BLaitPKcB10BmEJupl3NIDAeDnQTte
 GR4zl38mRV2aLTjIebfQ/dXCBRADYdyV65Bb9+PS/4+Hoz9XeowHQWR21MB7xt1EDIwTLE
 9zva5PKWJbZx9/I82qbEcs9j7dRpguk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631601371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQGVjuaI5/qCIUYMdxGT1f2TfrIwRnyWcIXUj9n7LEQ=;
 b=xsBQgT9iIP4MbtA0rPX91UhtU7mjTp4Kug9mI6tLt9olQlI59mAzHU/va4Yill+N2TQX9E
 Rormr4h2E9q4xeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA28A13E4F;
 Tue, 14 Sep 2021 06:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4fKQI9tCQGE8ZgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 06:36:11 +0000
Subject: Re: [PATCH nvme-cli] nvme-connect: Add 'dhchap-secret' and
 'dhchap-bidi' arguments
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210913094201.18729-1-hare@suse.de>
 <692f5019-fb1e-7a59-8bbb-9d181745147c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <94599051-83a3-eb8e-bf1b-16710c89d354@suse.de>
Date: Tue, 14 Sep 2021 08:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <692f5019-fb1e-7a59-8bbb-9d181745147c@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_233613_739731_A85A2328 
X-CRM114-Status: GOOD (  11.71  )
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

T24gOS8xNC8yMSA4OjI4IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiArLUI6Ogo+PiAr
LS1kaGNoYXAtYmlkaTo6Cj4+ICvCoMKgwqAgRW5hYmxlIGJpZGlyZWN0aW9uYWwgYXV0aGVudGlj
YXRpb24gKFRDUCkuCj4gCj4gTm90IFRDUCBvbmx5CgpPaywgd2lsbCBiZSByZW1vdmluZyBpdC4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
