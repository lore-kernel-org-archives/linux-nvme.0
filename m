Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46559C47087
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:00:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123DC6139A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123DC6139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DgYw/B+/Dn1sZwYaIQK8WDXOdgqN4izVzRLSSlSO+xU=; b=VRjvRln6dAfXq0nEy3kJgntnsK
	4iwhSkCxL7ddPqXNO3LmKdz/u/PYUkBxSpBudMZ2AzT+pDCRpuPpUUZA8RRjhOnXLHepK6rPLazeW
	vtJ1gQqrW6Us1UgiY+nYMQmzsLPgOoaTRHHqWYwno1NOF4ceaxRhObAO+NgUTniQ3u1j6mHJ20+0x
	XPS/aRjVYh7GGoPUfchbP92egzG5xaRa6F7qWDE6Lq0iLyxyDKi+dSDDMJtR6TDDcARBI+kGmPu6r
	I+csg8BDnjDgzhxcPENj38Fim3wZdGGSw0eWrRJqUC/KrDSqrUPuJk4/8FYU6NDXk0cxwP71vYyuR
	/pFA08Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmc5s-00FahX-W2; Fri, 28 May 2021 13:00:05 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmbo9-00FSra-L1
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 12:41:47 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2CFC218B0;
 Fri, 28 May 2021 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622205703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psICT56KcHw2VZjNUFvNu+cUaaBZPwU0GchRi03lC/k=;
 b=ByQlowES0N0uVLrXiOthXGwdqBaVNdRRH3olzbCYKb3puJ1lwx4drdLARCgWg7F9UlE0gC
 iHbDR8HZChiifKW8fzM+3i/pJ3sc+dn6xAfs4EhVgHTn0l+fWY+kDm5k6BvH8d45jHHAxl
 HSR3QUCIKlUDmjHcdNmAKHZVpUht1IU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622205703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psICT56KcHw2VZjNUFvNu+cUaaBZPwU0GchRi03lC/k=;
 b=koRsLBSKI9oQ7xfgXP/4OoYjP7O8YmooJF2Y1fLNmZ+40O2KxverL/DLzorSM4IBDp3HFu
 mThKx+V7C+PeeFDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id A168711A98;
 Fri, 28 May 2021 12:41:43 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id SfS6JgflsGCoLwAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 12:41:43 +0000
Subject: Re: [RFC PATCH v6 13/27] qed: Add NVMeTCP Offload IO Level FW and HW
 HSI
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-14-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <02fd8ffa-db79-1b19-7faf-e3d2f153c510@suse.de>
Date: Fri, 28 May 2021 14:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-14-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_054145_871489_9E9E0A77 
X-CRM114-Status: GOOD (  12.91  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IFRoaXMgcGF0Y2ggaW50cm9k
dWNlcyB0aGUgTlZNZVRDUCBPZmZsb2FkIEZXIGFuZCBIVyAgSFNJIGluIG9yZGVyCj4gdG8gaW5p
dGlhbGl6ZSB0aGUgSU8gbGV2ZWwgY29uZmlndXJhdGlvbiBpbnRvIGEgcGVyIElPIEhXCj4gcmVz
b3VyY2UgKCJ0YXNrIikgYXMgcGFydCBvZiB0aGUgSU8gcGF0aCBmbG93Lgo+IAo+IEFja2VkLWJ5
OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
UHJhYmhha2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogT21rYXIgS3Vsa2FybmkgPG9rdWxrYXJuaUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5
OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFs
IEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZWwg
RWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4KPiAtLS0KPiAgaW5jbHVkZS9saW51eC9xZWQvbnZt
ZXRjcF9jb21tb24uaCB8IDMzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ICBpbmNs
dWRlL2xpbnV4L3FlZC9xZWRfbnZtZXRjcF9pZi5oIHwgIDMxICsrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDM2NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gUmV2aWV3ZWQtYnk6IEhhbm5l
cyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlCQkgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZwpHRjogRi4gSW1lbmTDtnJmZmVyLCBIUkIg
MzY4MDkgKEFHIE7DvHJuYmVyZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
