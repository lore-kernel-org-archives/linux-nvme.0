Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DDBC636C8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C087461029
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C087461029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HIoYmVEpiPUA0KiGhH5IvJcZpwP3s5k7EpZ68SEVMPI=; b=hyTQn1fbRsLyUcuUarL5tpvdKa
	y4Ueb/F8yRLs8576KPscnkbwFSBG9J/h2l+gBCRzhRQrnvMq0gCQhmJGlZNvh8ZpsnF5MM8iXRGeL
	xCGftRfS0A0yKuVR2MkRz5yRHxQ43s8xdjSsCADPeGND71DoShiERgMCZOxwkgXoz1oXAk41Q8ZFV
	LxE14sHhNJEKf4RDuzJkQZM/YNPxyciRp6ItHqGsILcTVsrs9UzIM7WktSskwZF6x6Ji3j7QEQi+K
	it2zHYWku38QByCm3sXx4HNBE98epi4EAMi4DrXZCKV0MeikybxkA9YYx2EoMEuGPcn9gaVQOUL/8
	ziBJvHtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5txM-00Dgrt-Lf; Tue, 20 Jul 2021 17:55:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5txK-00Dgqp-8m
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 17:54:59 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C6ED202F0;
 Tue, 20 Jul 2021 17:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626803693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpRzxjBR15aVpBT84U5St6uEXHRtmrkDNyaHcqlpRxU=;
 b=aJc6vcnXTypljSasNQrNi7jUVzYz6kXF3wNqGyFc1w3cxqPXtDh21qSVKINqjNoRd2vdda
 KwIzvGHvEXrQw6TRdlWxVEQHepHfpToGVGqGpmYicJWtJapSSIXxzejp+cEMCeAAPNINR5
 q3ggYtohYIr0FEbY83TcCAmU2Hp+s2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626803693;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dpRzxjBR15aVpBT84U5St6uEXHRtmrkDNyaHcqlpRxU=;
 b=5Fp85cA8D+JIkL8mBigq7LA7PgkQQHBD0qQFSf+Kwz4NQnSgT2bSGfQ/YGgzAWyK8XpvPX
 2uYrdt2nDH7GKODQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 88A0613B9D;
 Tue, 20 Jul 2021 17:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id xr7KFOwN92AbUgAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:54:52 +0000
Subject: Re: [PATCH v3 3/6] nvme-rdma: Update number of hardware queues before
 using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <90ab8cc1-a900-9869-3a65-acf69ebc08fb@suse.de>
Date: Tue, 20 Jul 2021 19:54:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-4-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_105458_504472_8857C3AF 
X-CRM114-Status: GOOD (  14.90  )
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

T24gNy8yMC8yMSAyOjQzIFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IFdoZW4gdGhlIG51bWJl
ciBvZiBoYXJkd2FyZSBxdWV1ZXMgY2hhbmdlcyBkdXJpbmcgcmVzZXR0aW5nIHdlIHNob3VsZAo+
IHVwZGF0ZSB0aGUgdGFnc2V0IGZpcnN0IGJlZm9yZSB1c2luZyBpdC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252
bWUvaG9zdC9yZG1hLmMgfCAxMyArKysrKystLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5l
Y2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
