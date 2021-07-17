Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D96C636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:00:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE466115A
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE466115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6cksLlfTmVV+weKQno6QOXLYvqwuUWwLyNNd8UTL0k=; b=SbsxIaHWen4zpStKOYsrhx8qAT
	/s3xwIvh3FS7P4cqd9oSAGTzXyilqDDOCYcBU3sSe3Pc8qtQ9w1biROYL0rDoQrP5u1f2kD9/rHFC
	vsNCRy+7LBAKDmq5oudUBB0kK4EpKSbLZ+Yu8w87y7MzErYwQ5Q3gU7UACrTUkikN19S4JtA8Ucdp
	Svn04KIR/A+I90Jm1ThSQ6LxWC/7LuNveiMY064RQrTwosVbmUwfQee5nHzLPvBi+oh8U5OH1OzLJ
	GWQa1vb2QZAHn64xarCMiKqMeSl36Ujv9X/qXM+WhvdOaYqPqW8FMtXQ3ymQAK52Qiz6CMrkt5GJE
	rqqcqlQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4krg-006gyU-MT; Sat, 17 Jul 2021 14:00:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4kre-006gy6-HG
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 14:00:23 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 464121FF14;
 Sat, 17 Jul 2021 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626530421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IajkUIDctCZ3jnytmgu4H5g4bmZ6IGfTpK0hbibjwbI=;
 b=xHi81pc4e1E/R22aOVfiML6H363ZEN2VtAA+lPNE5Zf/+FRGij3CtMUpN2haxuqkOzz8ez
 EzhKWJa6cHoQ++jOqCtUbEoOizV8OWpMa0fli3QOqo8bvePF5wSlcMswv2iyAdCnH47JH9
 yS/H56naT8ojsNQOSw9rnOBL+WLkl+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626530421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IajkUIDctCZ3jnytmgu4H5g4bmZ6IGfTpK0hbibjwbI=;
 b=TECs47syT7ZzB/dr8hyDwJ74T1sHakhZlIcl8rMTVPD4j8pq4t72tFflNypSJ+lQMghOxL
 0ZzBtMzRUL5DsSCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1D31913A57;
 Sat, 17 Jul 2021 14:00:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id nlq7BXXi8mC8XAAAGKfGzw
 (envelope-from <hare@suse.de>); Sat, 17 Jul 2021 14:00:21 +0000
Subject: Re: [PATCH 04/11] lib/base64: RFC4648-compliant base64 encoding
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-5-hare@suse.de>
 <a6708951-76f6-21bb-f7fe-e4bb32cd0448@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7f320b51-1077-9b3f-bf29-49d0753adf6c@suse.de>
Date: Sat, 17 Jul 2021 16:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a6708951-76f6-21bb-f7fe-e4bb32cd0448@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_070022_767412_5C7476C5 
X-CRM114-Status: GOOD (  11.01  )
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

T24gNy8xNy8yMSA4OjE2IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+PiBBZGQgUkZDNDY0
OC1jb21wbGlhbnQgYmFzZTY0IGVuY29kaW5nIGFuZCBkZWNvZGluZyByb3V0aW5lcy4KPiAKPiBM
b29rcyBnb29kIHRvIG1lIChhbHRob3VnaCBkaWRuJ3QgbG9vayBpbiB0aGUgbG9naWMgaXRzZWxm
KS4KPiBDYW4geW91IG1heWJlIG1lbnRpb24gd2hlcmUgd2FzIHRoaXMgdGFrZW4gZnJvbT8KClVt
bSAuLi4geWVhaCwgSSBndWVzcyBJIGNhbjsgSSBfdGhpbmtfIEkndmUgY29waWVkIGl0IGZyb20g
YmFzZTY0IApyb3V0aW5lcyBpbiBmcy9jcnlwdG8vZm5hbWUuYywgYnV0IEknbGwgY2hlY2suCgpD
aGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2Vy
bmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1h
eGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdl
c2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
