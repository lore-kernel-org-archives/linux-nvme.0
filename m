Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DEBC48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 08:10:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB04600D1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 08:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB04600D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:Subject:From:References:Cc:To:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=LhRBDJZT8J9sNpjsB+kg+d+NerHdgjnV6+8XaeoDNM0=; b=e7RWG3dYay9zOgNCJY0LL6/bEB
	sQ5BSGBSzvtWhWD+iwOi/g0Z3Da8n9O8nB76CLCj3VwQaK6TIKGNvBaFYxyFrn4XA+yMgxOPK/euq
	JnsjLrjs3hRfFSAZlLUiNDXvS0bmU+r7pSAJnMcIjFHwweMHrb6bFWCrsp9sFtj6Q/Md5xiPFsZzE
	0QQhJFOcEzgsGv4OnzyxXTGPEsz9u2+z6Q9fgVpgoyIid/K6CNMnQbCjo/HRcfxA0M7Bn+byCCMyf
	nF5YmjlyNx0eyGCz9TE5dhc+JtAvwyxnhro4Ws+Y8fpvdZBcWJ0zxQzuFTYC8aKBeN0gyQEZ1dz8E
	aVN0szzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwKRL-00DMfN-FT; Thu, 24 Jun 2021 08:10:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwKRH-00DMcj-NA
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 08:10:22 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4637B1FD66;
 Thu, 24 Jun 2021 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624522218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtMzIYp/akj75pCLvuqwo7k1dSmnFrdVtaywCJ1xhPQ=;
 b=1HZQyQYe0oddpO3fPKD4Fe8RpacPI9jY0S6Ijkn/LvXw5/4kMoF2AHFsokoVdv6g+ReMPe
 9249SAkNx9XPmJgE4TZ0XXpmkqlstDvYoU3eNwKasJch8kYrsQJuHtR2IpAk61AOgmRscX
 bK51RQkV/zkg+464luU25nrCIOi4I54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624522218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtMzIYp/akj75pCLvuqwo7k1dSmnFrdVtaywCJ1xhPQ=;
 b=yVckGJHAg9qCAUoSLyj2RNghYPLvhCmW55CK21DDFveB8VDvjN5LI2mVEMsOs50rKSpNc/
 3lbploRQgERe1jCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 2D97411A97;
 Thu, 24 Jun 2021 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624522218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtMzIYp/akj75pCLvuqwo7k1dSmnFrdVtaywCJ1xhPQ=;
 b=1HZQyQYe0oddpO3fPKD4Fe8RpacPI9jY0S6Ijkn/LvXw5/4kMoF2AHFsokoVdv6g+ReMPe
 9249SAkNx9XPmJgE4TZ0XXpmkqlstDvYoU3eNwKasJch8kYrsQJuHtR2IpAk61AOgmRscX
 bK51RQkV/zkg+464luU25nrCIOi4I54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624522218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtMzIYp/akj75pCLvuqwo7k1dSmnFrdVtaywCJ1xhPQ=;
 b=yVckGJHAg9qCAUoSLyj2RNghYPLvhCmW55CK21DDFveB8VDvjN5LI2mVEMsOs50rKSpNc/
 3lbploRQgERe1jCw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id W1zqCuo91GAeFwAALh3uQQ
 (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 08:10:18 +0000
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
Message-ID: <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
Date: Thu, 24 Jun 2021 10:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_011019_973675_A5B047E9 
X-CRM114-Status: GOOD (  14.73  )
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

T24gNi8yNC8yMSA5OjI5IEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS82LzI0
IDEzOjUxLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDYvMjMvMjEgMTE6MzggUE0sIFNh
Z2kgR3JpbWJlcmcgd3JvdGU6Cj4+Pgo+Pj4+IEhpIGFsbCwKPj4+Pgo+Pj4+IGNvbW1pdCBmMjVm
OGVmNzBjZTIgKCJudm1lLWZjOiBzaG9ydC1jaXJjdWl0IHJlY29ubmVjdCByZXRyaWVzIikKPj4+
PiBhbGxvd2VkIHRoZSBmYyB0cmFuc3BvcnQgdG8gaG9ub3VyIHRoZSBETlIgYml0IGR1cmluZyBy
ZWNvbm5lY3QKPj4+PiByZXRyaWVzLCBhbGxvd2luZyB0byBzcGVlZCB1cCBlcnJvciByZWNvdmVy
eS4KPj4+Cj4+PiBIb3cgZG9lcyB0aGlzIHNwZWVkIHVwIGVycm9yIHJlY292ZXJ5Pwo+Pgo+PiBX
ZWxsLCBub3QgZXhhY3RseSBlcnJvciByZWNvdmVyeSAoYXMgdGhlcmUgaXMgbm90aGluZyB0byBy
ZWNvdmVyKS4KPj4gQnV0IHdlIHdvbid0IGF0dGVtcHQgcG9pbnRsZXNzIHJldHJpZXMsIHRoZXJl
YnkgcmVkdWNpbmcgdGhlIG5vaXNlIGluCj4+IHRoZSBtZXNzYWdlIGxvZy4KPiBUaGlzIGNvbmZs
aWN0IHdpdGggdGhlIHRjcCBhbmQgcmRtYSB0YXJnZXQuCj4gWW91IG1heSBuZWVkIHRvIGRlbGV0
ZSB0aGUgaW1wcm9wZXIgTlZNRV9TQ19ETlIgYXQgdGhlIHRhcmdldC4KPiBIb3dldmVyLCB0aGlz
IHdpbGwgY2F1c2UgY29tcGF0aWJpbGl0eSBpc3N1ZXMgYmV0d2VlbiBkaWZmZXJlbnQgdmVyc2lv
bnMuCgpXaGljaCBvbmVzPwpJIGNoZWNrZWQgdGhlIEROUiB1c2FnZSBpbiB0aGUgdGFyZ2V0IGNv
ZGUsIGFuZCB0aGV5IHNlZW0gdG8gc2V0IGl0CmNvcnJlY3RseSAoaWUgdGhlIHJlc3VsdCB3b3Vs
ZCBub3QgY2hhbmdlIHdoZW4gdGhlIGNvbW1hbmQgaXMgcmV0cmllZCkuCldpdGggdGhlIHBvc3Np
YmxlIGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxpbmcsIGFzIHRoaXMgaXMgYXJndWFibHkKZHlu
YW1pYyBhbmQgbWlnaHQgY2hhbmdlIHdpdGggYSByZXRyeS4KCkNoZWVycywKCkhhbm5lcwotLSAK
RHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QK
aGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBT
b2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
