Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C93C636CA
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:22:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4513610CB
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4513610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5UUQXEfiRV/K1wiXshPC3dAs9YsjDqO7ukjY8kiim4=; b=1NXfM5Dij5UVYqr9BMmPXxMeSW
	Lb1I9AqyUm3s3GBkwRN7MT/Y7O2OUQaJzgCNqudaY2PdOnuyQKRsbpiiZxqI88u5bHTiLMohgOZzU
	LtJ9hyl0iTNUS7I1/SH4lf/HkUzPqIkf7HGxKWOamLUskJ16ARcDIijpCOAeVhXuyR68drQOh2zbj
	m8iLwBkAEiwp74LojSQ7GjgnsL+4R8/OpRaydzNgTCF6+Hag5ZZ3FTFJJlIsBt5ufmICPLNEaGpHY
	gk9u/m0TSgDlGUlNeF4pAWOx3sdwkc9RKunGJKs9HVYkIwzdQMsmy5kmSm0sbfzLz93fzzHexUZY2
	fyD6Ef5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m55oI-007fbg-9y; Sun, 18 Jul 2021 12:22:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m55oG-007fb1-47
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 12:22:17 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D71BF224EB;
 Sun, 18 Jul 2021 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626610934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pugyD51b77ZzuWl1Jldtt+XqGHZGBTYClAPtWrnyQCA=;
 b=jYVsQlu5W5FlNCN4W7Sw612NN8CSZ0FVAZ90I7qLCgBoJET+PJOb/achfvmyqLd39xJgNM
 Ni1OWvNJdZHcdpoj22NQo+fY0/yP89s4VE4AcTRnwdHMa612FLfLH10GUPUngyW3TQVgWB
 pRyXIRy6YQaLexbkIDcJNGY0dG4YNfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626610934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pugyD51b77ZzuWl1Jldtt+XqGHZGBTYClAPtWrnyQCA=;
 b=1e5cukwEBcVb4JIyJU46lkt7eN5noYoVf8FxWGUd/3714Qnekh1XrXO7U9h53whQUkjvL1
 3fgkbPeTC/9224BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AED2E13AD2;
 Sun, 18 Jul 2021 12:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id GsOoKfYc9GD3OgAAGKfGzw
 (envelope-from <hare@suse.de>); Sun, 18 Jul 2021 12:22:14 +0000
Subject: Re: [PATCH 03/11] crypto/ffdhe: Finite Field DH Ephemeral Parameters
To: =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-4-hare@suse.de>
 <29491463.gfxVf8N7Et@positron.chronox.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fceab658-f7dd-3588-790f-c0eec2743ab0@suse.de>
Date: Sun, 18 Jul 2021 14:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <29491463.gfxVf8N7Et@positron.chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_052216_360721_AF609A9C 
X-CRM114-Status: GOOD (  12.07  )
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

T24gNy8xNy8yMSA1OjAzIFBNLCBTdGVwaGFuIE3DvGxsZXIgd3JvdGU6Cj4gQW0gRnJlaXRhZywg
MTYuIEp1bGkgMjAyMSwgMTM6MDQ6MjAgQ0VTVCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToKPiAK
PiBIaSBIYW5uZXMsCj4gCj4+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+ICsjaW5jbHVk
ZSA8Y3J5cHRvL2ludGVybmFsL2twcC5oPgo+PiArI2luY2x1ZGUgPGNyeXB0by9rcHAuaD4KPj4g
KyNpbmNsdWRlIDxjcnlwdG8vZGguaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9tcGkuaD4KPj4gKwo+
PiArLyoKPj4gKyAqIGZmZGhlMjA0OCBnZW5lcmF0b3IgKGcpLCBtb2R1bHVzIChwKSBhbmQgZ3Jv
dXAgc2l6ZSAocSkKPj4gKyAqLwo+PiArY29uc3QgdTggZmZkaGUyMDQ4X2dbXSA9IHsgMHgwMiB9
Owo+IAo+IFdoYXQgYWJvdXQgdXNpbmcgc3RhdGljIGNvbnN0IGhlcmUgKGFuZCBmb3IgYWxsIHRo
ZSBmb2xsb3dpbmcgZ3JvdXBzKT8KPiAKWWVzLCBvZiBjb3Vyc2UuIFdpbGwgYmUgZml4aW5nIGl0
LgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
