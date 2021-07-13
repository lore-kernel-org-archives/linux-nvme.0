Return-Path: <SRS0=tkdf=MF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54571C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:41:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80C61158
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jul 2021 09:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80C61158
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Cagud96jV9ei5KK2Atnioh+yC8ksWyWf6VRquieU7g8=; b=e6tGmS9QDeOl5hu20li7bl2r5W
	Zr7Hj2cSxqAR4MEkejbykY/sM1sD1gcEv54OMdgQ123gzE1d5ZxzNBFgNOwcEkH+Y3/f9037iEpxv
	uopNuXZlkxeG5Ji52a8CoIyMYJsrD+8zM8BZWcVFlhqJHkN8i6r8f0qI7PTNtqmnYaCPGvX6jDFKY
	YXyr1wHdqkjhBkxCuBuuD97PmGGwo+wZw7NIn0FhLlCbhMN9qycnTymqYJ5tbUlu1/he5eX/hujwx
	SxWLZNi9KgxokGEPQhFIs402k+53b9ZBsxZo/EB90Nw8zF7t0fvVmtMB4q/ImJIWmR1JWxUNDt+rJ
	MuT9JWbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3Euy-009gHy-56; Tue, 13 Jul 2021 09:41:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3Eut-009gGl-Rp
 for linux-nvme@lists.infradead.org; Tue, 13 Jul 2021 09:41:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8680120086;
 Tue, 13 Jul 2021 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626169286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNEOWWiDCwdrZkBvGro15Dc7dvgsoRPFKyn6YMn8PyU=;
 b=1iO/3Jsg35x9lMetID00HShq6yj2uezcViSI/RzGg5/qCvYfixuoUOoX2iO+uQIUDtvu3a
 kmQxp8xIZG+VNF04M1GKoTrzkuRM48fUD7Q9/vx7xkidEUn2BWifijN2EezNcbfe8vkbbD
 oDH6rsmQL6gvVI9BfYeAkzZLpWXUqIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626169286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNEOWWiDCwdrZkBvGro15Dc7dvgsoRPFKyn6YMn8PyU=;
 b=lgd4cdwMqSsw8RY6OKMGEuQIZaJulohZ5MLxQLOe3uZXTrXGwwjPx/eZJaOabaWcp9tPMS
 cbPlslsu5IW1cJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B42E13AE2;
 Tue, 13 Jul 2021 09:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id X8HMGMZf7WBvWAAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 13 Jul 2021 09:41:26 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.com>,
 linux-nvme@lists.infradead.org
References: <20210212155229.98816-1-hare@suse.de>
 <20210713092125.GB25039@lst.de>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH 0/3] nvmetcli: remote configuation
Message-ID: <b88c2c58-5d47-6d7a-4490-d78cb7c2f89a@suse.de>
Date: Tue, 13 Jul 2021 11:41:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713092125.GB25039@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210713_024128_111192_352CE819 
X-CRM114-Status: GOOD (  14.12  )
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

T24gNy8xMy8yMSAxMToyMSBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gU28gdGhpcyBk
b2Vzbid0IGxvb2sgaG9ycmlibGUgdG8gbWUsIGJ1dCBkbyB5b3UgcGxhbiB0byBhY3R1YWxseQo+
IGhhdmUgdXNlcnMgZm9yIHRoaXM/ICBUZXN0IGNhc2VzIHdvdWxkIGFsc28gYmUgcmVhbGx5IGhl
bHBmdWwuCj4gCldlbGwsIGlkZWEgd2FzIHRvIGVuYWJsZSB0aGluZ3MgbGlrZSBibGt0ZXN0IHRv
IGNvbmZpZ3VyZSByZW1vdGUgc3lzdGVtcwpzdWNoIHRoYXQgd2UgY2FuIGV4cGFuZCB0aGUgdGVz
dCBtYXRyaXggYmV5b25kIG52bWUtbG9vcCB0byAncmVhbCcKaGFyZHdhcmUgbGlrZSBudm1lLWZj
IG9yIG52bWUtcmRtYS4KCkJ1dCB0aGVuIEkgZm91bmQgdGhhdCBqc29ucnBjIGlzIGFjdHVhbGx5
IGRlZnVuY3QgYXMgZ29vZ2xlIHN3aXRjaGVkIHRvCmdSUEMgKGFuZCBnbyBpbiBnZW5lcmFsKSwg
bWFraW5nIHRoZSB1c2Ugb2YganNvbnJwYyBldmVyIHNvIHNsaWdodGx5CmF3a3dhcmQuCgpTbyBu
b3Qgc3VyZTsgSSdkIGJlIGhhcHB5IHRvIGxlYXZlIGl0IGZvciBub3csIGFuZCBJJ2xsIHNlZSB0
byB0aWUgaW4KYmxrdGVzdHMgd2l0aCB0aGlzLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFu
bmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
