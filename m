Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E43EC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:08:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F1661451
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 10:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F1661451
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8G1q6b4rdpq9E8yuR2vCcAwWmR6lOBgLWQm3HmKkUxc=; b=YP8yNUr4GgAEirrxL/ofBuoAt1
	v7vRPrM3AgZKLur3E+iTU5fIgi7RhWhCJKh8ZTLoYioobjkQmr3p9zMhj9lHh3CbCeoOSiFnkHPOo
	/VYGvl++s46bSERPmd3BsW1n3Zj42aaOs5OjaLQemgeEiZSYXgJnqJDviRbhB66MKBFo/H9hrufJH
	Gi3kQPt/X+QG2jH/KPq9DdCDET8buxYZzS29qE/pCgzeQVOEwQIV35fztTjzjau0ZKNR7dMoAk5W1
	9whUGl/0c7wsEltVk1T7/y12H6hhaW7nD71PDNIDFq/6mI/VDxfRTQYi3gdTjRCCYYS1u3wiKYRte
	wTAQ0uXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1Qxc-00GZbm-Um; Thu, 08 Jul 2021 10:08:48 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1Qxa-00GZap-73
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 10:08:47 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA60922323;
 Thu,  8 Jul 2021 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625738924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9TyFwEe5FQOuKpCFtv0haO4nVb73dTNISc703GO9ys=;
 b=GSDEOWff/FWfkPQgg2zY7s9aYRVZO3IwE878kHzsbP5wOSKSBo103QxkBjJZo/yIP5p5qU
 rypfQ4MP60ziq9cfeML2yTkBScNesVNsZNtxhZx8zEnkPEa8LHtX4nPxUsuGqgyZPLEd22
 5aRJ/X06dGYsbu2j4D3L+DjSnfy3hNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625738924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9TyFwEe5FQOuKpCFtv0haO4nVb73dTNISc703GO9ys=;
 b=wPD/xKmgZ6jRqWlXdmY0hKpg1kEVrQJnXkgcdUqQ6Sp12oCclFoEv4uNlsxH9GxyqWCpd/
 P107rqkbI25GJ5CA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C1A7C1338E;
 Thu,  8 Jul 2021 10:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id O6MNLqzO5mBeMgAAGKfGzw
 (envelope-from <hare@suse.de>); Thu, 08 Jul 2021 10:08:44 +0000
Subject: Re: [PATCH v2 1/5] nvme-fc: Update hardware queues before using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <jsmart2021@gmail.com>
References: <20210708092755.15660-1-dwagner@suse.de>
 <20210708092755.15660-2-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57de7af1-b263-ceed-54aa-e9880327bcc1@suse.de>
Date: Thu, 8 Jul 2021 12:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210708092755.15660-2-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_030846_454999_D31E2B1D 
X-CRM114-Status: GOOD (  15.07  )
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

T24gNy84LzIxIDExOjI3IEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IEluIGNhc2UgdGhlIG51
bWJlciBvZiBoYXJkd2FyZSBxdWV1ZXMgY2hhbmdlcywgZG8gdGhlIHVwZGF0ZSB0aGUKPiB0YWdz
ZXQgYW5kIGN0eCB0byBoY3R4IGZpcnN0IGJlZm9yZSB1c2luZyB0aGUgbWFwcGluZyB0byByZWNy
ZWF0ZSBhbmQKPiBjb25ubmVjdCB0aGUgSU8gcXVldWVzLgo+IAo+IFJldmlld2VkLWJ5OiBKYW1l
cyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gUmV2aWV3ZWQtYnk6IE1pbmcgTGVpIDxt
aW5nLmxlaUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWdu
ZXJAc3VzZS5kZT4KPiAtLS0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgfCAxNiArKysrKysr
Ky0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQo+IApSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVl
cnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZl
bGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2No
w6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
