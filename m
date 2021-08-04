Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0215C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 07:26:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3569660EBC
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 07:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3569660EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BEN5XTcfUOu5YYRM1yj9TyHsRXV4m/xFWdXwbKsizpc=; b=KFGCA9zn86dQ82oKwHhFJQVDT9
	/TZZv+Vu/+NiLBsIP+jd1GMjAiN2BN0v3U+630QH8dlVvW99F6GtO0osOsN/HCUfqsIGk3FLvQABG
	rz/zclVHwtn2X+gts6d27tdAau30uAq80YNLrOFGEW13H0Zd4oP2KbBafk5GxBsBi+DKM21Wf2z8L
	wTQvzqypIcjhfDOWYe1RXOIg/XPZA3BxilyTjYKwiwVN824j3kX6SJNrunSd7bz0QC+u05tf+hnU2
	Wl5vQHor7/pajhfErOqnc32unX3fUbJQ6uXGVqFAbT+oeyppvblcGIcZLmVB/kTdoh+UJhhW8Ji9y
	peWIC7gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBBH7-0051UT-6w; Wed, 04 Aug 2021 07:25:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBBH4-0051To-0C
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 07:25:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A811520106;
 Wed,  4 Aug 2021 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628061908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbOcGokMbJk/XuXlCzXTIBoRTK5BBDFqLJNu9Hgtsf0=;
 b=syC0N/OopS1qLJN9kO78E5MwdaRpWnvkyLcwSEKPR9xGuL3cQQ6qgoXrHYDN9I9ZK5Jud0
 4KNh4GzQQwAyfuWY5QoZen54tRYWscL/YqkaNXvgYes53TC8gO7U5juredf/5Va4Xjxj0J
 cxRwNbQSL4POMyRhFnhTZq5rCi8A7HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628061908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbOcGokMbJk/XuXlCzXTIBoRTK5BBDFqLJNu9Hgtsf0=;
 b=cDHpXk24cpzV0WvT3kFBWu/IZc5vCa/uk28EBjTH5Iw7QVU/KlY6jIn6ym1b9hY8Kda4hA
 eyYu+f+J6EfEosBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98F0F139FC;
 Wed,  4 Aug 2021 07:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eoQWJdRACmH3dAAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 04 Aug 2021 07:25:08 +0000
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <788e9210-37d4-6a52-2b5d-241c2442cea0@suse.de>
Date: Wed, 4 Aug 2021 09:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210802112658.75875-9-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_002510_241145_BD256C75 
X-CRM114-Status: GOOD (  19.59  )
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

T24gOC8yLzIxIDE6MjYgUE0sIERhbmllbCBXYWduZXIgd3JvdGU6Cj4gRHVyaW5nIHRoZSBxdWV1
ZSB0ZWFyZG93biBpbiBudm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVzKCkgZnJlZXplIGlzCj4g
Y2FsbGVkIHVuY29uZGl0aW9uYWxseS4gV2hlbiB3ZSByZWNvbm5lY3Qgd2UgbmVlZCB0byBwYWly
IHRoZSBmcmVlemUKPiB3aXRoIGFuIHVuZnJlZXplIHRvIGF2b2lkIGhhbmdpbmcgSS9Pcy4gRm9y
IG5ld2x5IGNyZWF0ZWQgY29ubmVjdGlvbgo+IHRoaXMgaXMgbm90IG5lZWRlZC4KPiAKPiBGaXhl
czogOWY5ODc3MmJhMzA3ICgibnZtZS1yZG1hOiBmaXggY29udHJvbGxlciByZXNldCBoYW5nIGR1
cmluZyB0cmFmZmljIikKPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1
c2UuZGU+Cj4gLS0tCj4gIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyB8IDIgKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
aG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiBpbmRleCBkZTJhODk1MGQy
ODIuLjIxYThhNTM1M2FmMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMK
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiBAQCAtOTAxLDYgKzkwMSw4IEBAIHN0
YXRpYyBpbnQgbnZtZV9yZG1hX2NvbmZpZ3VyZV9hZG1pbl9xdWV1ZShzdHJ1Y3QgbnZtZV9yZG1h
X2N0cmwgKmN0cmwsCj4gIAkJCWVycm9yID0gUFRSX0VSUihjdHJsLT5jdHJsLmFkbWluX3EpOwo+
ICAJCQlnb3RvIG91dF9jbGVhbnVwX2ZhYnJpY3NfcTsKPiAgCQl9Cj4gKwl9IGVsc2Ugewo+ICsJ
CW52bWVfdW5mcmVlemUoJmN0cmwtPmN0cmwpOwo+ICAJfQo+ICAKPiAgCWVycm9yID0gbnZtZV9y
ZG1hX3N0YXJ0X3F1ZXVlKGN0cmwsIDApOwo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tl
IDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJ
CSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdl
cm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
