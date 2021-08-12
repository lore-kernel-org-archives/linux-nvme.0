Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCFCC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 12:51:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD3B861059
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD3B861059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ER2hLORFui605EbwcibYtF7WG7wOZWp6D6SyFOPP02Y=; b=WN/+0nNqLCgIufAkfqRNvoBTKg
	oCNdct79WVztdZ1RJ4RZtGStPn9HFXaJigJjnI2NZNCu4CinpAkbIVA0XwGZeUTd3gcj0lYBCcjUV
	6B2+qw5OaqhKtUq+MM5pcRGK7l9n7raRBR+2wuVi3c4z6F4VLTZTIeF7t3UM3n8Ebk2G6Q0ucoTwD
	3iIiwQ/fuptRm8Z+pG66J0V6Omxc1iEMZwCCLut3Yalbt0ZeaqCRaz9AAjBRiTGse7QDLkRucmb6m
	0z6o2V7YqSuH3t0/7vv3mvLb6TWzzJlytnqUs0JMEtepiAFDoRxH2aX1jQLMOeKJyblCmn2sAy1or
	G4t0URTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mEABI-00A5RZ-AP; Thu, 12 Aug 2021 12:51:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mEABB-00A5Qt-Km
 for linux-nvme@lists.infradead.org; Thu, 12 Aug 2021 12:51:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 917C21FF40;
 Thu, 12 Aug 2021 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628772683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6QEAh1eIqNKepUiekTGRyznT7B1JhNBAvXQNcKttlA=;
 b=XaDMFDs0JLJ/WihTtuUXRT9qj3ezAnx5udgeVirHc43CqgvA+tLVw+Rp1Kj5SynHAlug0O
 ID03MplJ0kkDJqZ1STPMCt27giYtCUe2gQ05W/uErcRh2QWLm667KJy7DbR11DaIudIXQ9
 z/CC9KU301+kUwZaxTHRBjYw9n5t6TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628772683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6QEAh1eIqNKepUiekTGRyznT7B1JhNBAvXQNcKttlA=;
 b=DF4tXYn6vJUkrex6aNgV9b0t8rxhxsBJM3Xdpa5bsjyPzHPaS8rMNe3XdwUWXfBiApdZ1i
 WJJ/ByTUF348vSAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83AB513C49;
 Thu, 12 Aug 2021 12:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ph2sH0sZFWF9bgAAMHmgww
 (envelope-from <hare@suse.de>); Thu, 12 Aug 2021 12:51:23 +0000
Subject: Re: [PATCH 13/13] nvme: add non-standard ECDH and curve25517
 algorithms
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210810124230.12161-1-hare@suse.de>
 <20210810124230.12161-14-hare@suse.de> <20210812122518.GA19050@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b009d8f9-cf6b-ef1c-51fc-5bd7f69c2c9e@suse.de>
Date: Thu, 12 Aug 2021 14:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812122518.GA19050@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210812_055125_879484_BF11C1C2 
X-CRM114-Status: GOOD (  17.90  )
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

T24gOC8xMi8yMSAyOjI1IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIEF1
ZyAxMCwgMjAyMSBhdCAwMjo0MjozMFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IFRMUyAxLjMgc3BlY2lmaWVzIEVDREggYW5kIGN1cnZlMjU1MTcgaW4gYWRkaXRpb24gdG8gdGhl
IEZGREhFCj4+IGdyb3VwcywgYW5kIHRoZXNlIGFyZSBhbHJlYWR5IGltcGxlbWVudGVkIGluIHRo
ZSBrZXJuZWwuCj4+IFNvIGFkZCBzdXBwb3J0IGZvciB0aGVzZSBub24tc3RhbmRhcmQgZ3JvdXBz
IGZvciBOVk1lIGluLWJhbmQKPj4gYXV0aGVudGljYXRpb24gdG8gdmFsaWRhdGUgdGhlIGF1Z21l
bnRlZCBjaGFsbGVuZ2UgaW1wbGVtZW50YXRpb24uCj4gCj4gSWYgeW91IHRoaW5rIHRoZXNlIGFy
ZSB1c2VmdWwgcGxlYXNlIGFkZCB0aGVtIHRvIHRoZSBzdGFuZGFyZC4KPiAKT2ssIHdpbGwgYmUg
b21pdHRpbmcgdGhhdCBwYXRjaCBmb3IgdGhlIG5leHQgc3VibWlzc2lvbi4KSSd2ZSBqdXN0IGFk
ZGVkIHRoZW0gZm9yIHZhbGlkYXRpb24gb2YgdGhlIERIIGV4Y2hhbmdlOyBidXQgbm93CnRoYXQg
ZmZkaGUgc2VlbXMgdG8gYmUgcmVhc29uYWJseSBzdGFibGUgSSBkb24ndCBoYXZlIGFuIGlzc3Vl
IHdpdGgKZHJvcHBpbmcgdGhlbS4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWlu
ZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlCQkJ
ICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5
IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
