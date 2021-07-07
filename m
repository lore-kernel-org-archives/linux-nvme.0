Return-Path: <SRS0=InZj=L7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72BDC07E95
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 14:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF6461C99
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jul 2021 14:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6461C99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6VJ2tDJpdYQ//LkPMUukfyTzoY2/QJ78jEYOl5A1/FE=; b=m2eUzTKZJtOQzS9nNmqQnFhzvg
	Up5wvJbNYJz4/PpTuEBVcgWwys6eg+b7trwjwY/eqyK9HqFtYMceMc2ztbJhnb6NO4PCT0ow9QHH8
	W+lymBF0ZCni9ufoZ7yYDf3yG9NXy/HP7iXoFReCbTgbgcW8U2wfKUNMdKQxx1J2hOR9t1aGUM7Bh
	PpCtPx/KU/57ly+SIP3SGoS5fhIM3DPmn0hzOadRqa1T2sNxujq32pumeeqSWs+cHlWYFn/dQX+kM
	8mYHIVl89lBA8B8z8JlLjGwon10jBC0KyXXHlOAw4ZXRIX0rKxXQ1qpnWhAJO7pwV07mn3U3L8GrU
	x5IJo00A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m190l-00F8qP-DM; Wed, 07 Jul 2021 14:58:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m190i-00F8q3-7u
 for linux-nvme@lists.infradead.org; Wed, 07 Jul 2021 14:58:49 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ECDE3200A1;
 Wed,  7 Jul 2021 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625669924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n49FotfPrPKI8JC8vQ8cyLmwT0+1CDpD+nkEHErNG1I=;
 b=d+qcdvR7XJfF+EvffMQkFaMiZHtFnCWnkNqUmMUgANH+QXPEt3puWxo8auxcWPs+RjadH1
 tNDNDiwTVYkN1T6WkK3E8ciO4ptBwlFkN6T9OKk6hLqUxgDDP0zWduJfiJEG0XcoYq8rsn
 +xpdn9OJjDJqeoQSmbP1Y4FIX0kPTA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625669924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n49FotfPrPKI8JC8vQ8cyLmwT0+1CDpD+nkEHErNG1I=;
 b=ZMTTY7ft37ABWr9SMyBEMWTNIp3fB6a9SyIsL0JUAqpf3fd64nWJ9O7vg0e5QdwE3U0O5K
 3CVVMBTovmODI8BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A665513645;
 Wed,  7 Jul 2021 14:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 68yeJyTB5WB+MAAAGKfGzw
 (envelope-from <hare@suse.de>); Wed, 07 Jul 2021 14:58:44 +0000
Subject: Re: [PATCH v4 00/20] NVMeTCP Offload ULP
To: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, davem@davemloft.net, kuba@kernel.org, smalin@marvell.com,
 aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 prabhakar.pkin@gmail.com, malin1024@gmail.com
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210701132307.GA18548@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c19a9d80-0d12-1ad0-8dce-169997ba5364@suse.de>
Date: Wed, 7 Jul 2021 16:58:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701132307.GA18548@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210707_075848_479433_7E226BF8 
X-CRM114-Status: GOOD (  14.67  )
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

T24gNy8xLzIxIDM6MjMgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IEkgbG9va2VkIG92
ZXIgaXQgYSBiaXQgKGFuZCB3aWxsIHNlbmQgc29tZSBpbmRpdmlkdWFsIGNvbW1lbnRzKSwgYW5k
IEkKPiBoYXZlIHRvIHNheSBJIHJlYWxseSBkaXNsaWtlIGhvdyB0aGlzIGxheWVyIGFuZCBob3cg
dGhlIGhhcmR3YXJlIHdvcmtzLgo+IAo+IFRoZSB3aG9sZSBwb2ludCBvZiBOVk1lIGlzIHRoYXQg
d2UgaGF2ZSBhIG5pY2VseSBzdGFuZGFyZGl6ZWQgUENJZQo+IHJlZ2lzdGVyIGxldmVsIGludGVy
ZmFjZS4gIE9uZSB0aGF0IHlvdSBjYW4gdHJpdmlhbGx5IGhpZGUgYSBUQ1Agb2ZmbG9hZAo+IHVu
ZGVyIHdpdGgganVzdCBhIGxpdHRsZSBjb250cm9sIHBsYW5lIGxvZ2ljLiAgQnV0IGluc3RlYWQg
d2UgY29tZSB1cCB3aXRoCj4gdGhpcyBnaWdhbnQgbWVzcy4KPiAKSSBjYW4ndCByZWFsbHkgc2Vl
IGhvdyB0aGlzIGNvbnRyb2wgcGxhbmUgbG9naWMgc2hvdWxkIHdvcms7IGhvdyB3b3VsZCAKdGhl
IGVudGlyZSBOVk1lLW9GIGRpc2NvdmVyeSBiZSBhYnN0cmFjdGVkIGF3YXkgdG8gaGlkZSBiZWhp
bmQgYW4gCk5WTWUtUENJIGRldmljZT8KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBS
ZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNl
LmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhS
QiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7Zy
ZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
