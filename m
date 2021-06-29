Return-Path: <SRS0=UYep=LX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F4BC11F68
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DAE61D92
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jun 2021 12:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DAE61D92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fI73yWi8szYfzX7NELNmb5oy0aY/CJLAyeh6+rF4RBE=; b=GbQEcG8zqD5YQ3gFClZp3wCqDm
	JrdoMXmZXH5SQ/VXRcw/a1rnmJm+be0XTWOvAzA0Zv1+DJxz9V+zTWnYyyEvx7F9xGkXv9VLNjju9
	cfxlY6vWxlXkEhO+6r6FzbMpnUMS6o3zWtpv4Xp/Qw+Oew3HB4q6un33L9WdNdE9cAh+JIZ5zLurZ
	9lhenYTd63VaD0bDe/qXb++Tu+sU6E4fOSgOdzPemc5ID+InJ5ZkjzlBZTQhFCfyKAosm60MV2ap5
	QgHzciss39B9KmTBgB/KOQxWMoa7K5V5ugKrz68QcmWWY4V+JNyzxER0ogtrYeMdchfQoMIlCLGYm
	tIA/wZVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyCto-00ApDK-8j; Tue, 29 Jun 2021 12:31:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyCtl-00ApBV-2Z
 for linux-nvme@lists.infradead.org; Tue, 29 Jun 2021 12:31:30 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4292C226C9;
 Tue, 29 Jun 2021 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624969886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
 b=17psiHPvIhgmVbM+cUCSHTOP4LYqLwUTJpo17O0GiOMsVwnbZQfp6N+Esjy64iLXUnz4mj
 oiV0N//COGEqeDrfvioZQgQDmjpisgpFshDMjivwkL6xbYwvsN/99bpP0cT2OiwXbGozhE
 6fOWF7lHYNmDjIs0th/H3CIkt7j2omU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624969886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
 b=DB9SexW3tuHSpBBvFMe4hAj5CaGiaeTvQ1aV24x+bhEJFr4YSp4VKHQfFdduEriuDDvQxD
 vyiiigQgZDNO6hCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 0F5F711906;
 Tue, 29 Jun 2021 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624969886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
 b=17psiHPvIhgmVbM+cUCSHTOP4LYqLwUTJpo17O0GiOMsVwnbZQfp6N+Esjy64iLXUnz4mj
 oiV0N//COGEqeDrfvioZQgQDmjpisgpFshDMjivwkL6xbYwvsN/99bpP0cT2OiwXbGozhE
 6fOWF7lHYNmDjIs0th/H3CIkt7j2omU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624969886;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYdod1Jl3r0ZKD72T4epi0bSja0sCKQ3Knam8SHOrXI=;
 b=DB9SexW3tuHSpBBvFMe4hAj5CaGiaeTvQ1aV24x+bhEJFr4YSp4VKHQfFdduEriuDDvQxD
 vyiiigQgZDNO6hCQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id xXfYAp4S22D3SQAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 29 Jun 2021 12:31:26 +0000
Subject: Re: [PATCH 1/2] nvme-fc: Update hardware queues before using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <11737f53-8959-3d83-6be8-feca7fa40be7@suse.de>
Date: Tue, 29 Jun 2021 14:31:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210625101649.49296-2-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210629_053129_323753_BDD4630C 
X-CRM114-Status: GOOD (  15.86  )
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

T24gNi8yNS8yMSAxMjoxNiBQTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBJbiBjYXNlIHRoZSBu
dW1iZXIgb2YgaGFyZHdhcmUgcXVldWVzIGNoYW5nZXMsIGRvIHRoZSB1cGRhdGUgdGhlCj4gdGFn
c2V0IGFuZCBjdHggdG8gaGN0eCBmaXJzdCBiZWZvcmUgdXNpbmcgdGhlIG1hcHBpbmcgdG8gcmVj
cmVhdGUgYW5kCj4gY29ubm5lY3QgdGhlIElPIHF1ZXVlcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBE
YW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9z
dC9mYy5jIHwgMTYgKysrKysrKystLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8
aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
