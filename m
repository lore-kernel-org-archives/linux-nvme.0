Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955CBC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:56:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579CB60FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 17:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579CB60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/l2UDTdm/b0nJ2hpDozNuz9GzKU/V281j6Fiw28UjU=; b=GjI0He/fXkCCP1AYvfKVLOV+CW
	X1I65Qbi7AqC4khgZZYIFotUDwXtbkAmFBNLt3SlnNCSksFOb69cyju6/wm/NM19dodnnRpDiiynt
	oYp/qbyYe2aD5trDYSdIERSmS1zQDMfjRCNNCa5YGo8aiOIi/oMYWP7+j2Z094CaY1LzdD4aQsPFk
	P8Rr1MqU/AW+i05II+4xknYlQuMjAF0d2MuneQfVygWEDiUnxKfgIcHWgpKmmQOC7rADQmbwhFcf3
	MfG9ZfqavYZJci6tyHjkTbcUn3RWuj6UJEGe6KJ5m2GgG68XkQqEQ94AepWXY2pE1SB1gBNDrLyTF
	cEn8Z6ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5tyU-00Dh9D-JI; Tue, 20 Jul 2021 17:56:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5tyQ-00Dh7w-Pq
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 17:56:08 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8514E2246A;
 Tue, 20 Jul 2021 17:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626803765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoxJJ5NGUDLAYGuGREc01BPrLsJH1eS+cT2d1AAwCUA=;
 b=a69n++8vwI0jS0IOmXfH0QJAexPDIcQGA0Zh67/BFeTdGihCNT8C6uAGJApV3N8Zs/3xtK
 cADxorAbUkKl/NS0AVxwOJEwkuhxMH7TOhhkK7b4yzPK0AIlC+dNvHx1kXPYI350SoswKm
 gxlRS04IUP4y6rsJcSgKy2OZkt8jIcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626803765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yoxJJ5NGUDLAYGuGREc01BPrLsJH1eS+cT2d1AAwCUA=;
 b=TwJGfHMkAK6AVE8Z2MajKrSXezDPpNDddcWpRWGF9j6BzIFP/xCWYyTiAs2NZCKEwWAtsm
 a0GtWIl+fvfCTeCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5D42013B9D;
 Tue, 20 Jul 2021 17:56:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id okDKFTUO92BoUgAAGKfGzw
 (envelope-from <hare@suse.de>); Tue, 20 Jul 2021 17:56:05 +0000
Subject: Re: [PATCH v3 5/6] nvme-fc: avoid race between time out and tear down
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>,
 Chao Leng <lengchao@huawei.com>
References: <20210720124353.127959-1-dwagner@suse.de>
 <20210720124353.127959-6-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <376e5dd0-a6e1-0018-9048-abcb6f405eaf@suse.de>
Date: Tue, 20 Jul 2021 19:56:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210720124353.127959-6-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_105607_050234_BCD7BB97 
X-CRM114-Status: GOOD (  17.73  )
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

T24gNy8yMC8yMSAyOjQzIFBNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IEZyb206IEphbWVzIFNt
YXJ0IDxqc21hcnQyMDIxQGdtYWlsLmNvbT4KPiAKPiBUbyBhdm9pZCByYWNlIGJldHdlZW4gdGlt
ZSBvdXQgYW5kIHRlYXIgZG93biwgaW4gdGVhciBkb3duIHByb2Nlc3MsCj4gZmlyc3Qgd2UgcXVp
ZXNjZSB0aGUgcXVldWUsIGFuZCB0aGVuIGRlbGV0ZSB0aGUgdGltZXIgYW5kIGNhbmNlbAo+IHRo
ZSB0aW1lIG91dCB3b3JrIGZvciB0aGUgcXVldWUuCj4gCj4gVGhpcyBwYXRjaCBtZXJnZXMgdGhl
IGFkbWluIGFuZCBpbyBzeW5jIG9wcyBpbnRvIHRoZSBxdWV1ZSB0ZWFyZG93biBsb2dpYwo+IGFz
IHNob3duIGluIHRoZSBSRE1BIHBhdGNoIDMwMTcwMTNkY2MgIm52bWUtcmRtYTogYXZvaWQgcmFj
ZSBiZXR3ZWVuIHRpbWUKPiBvdXQgYW5kIHRlYXIgZG93biIuIFRoZXJlIGlzIG5vIHRlYXJkb3du
X2xvY2sgaW4gbnZtZS1mYy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0
MjAyMUBnbWFpbC5jb20+Cj4gQ0M6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4KPiBU
ZXN0ZWQtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPiBbZHdhZ25lcjogdXBk
YXRlZCBjb21taXQgaWQgcmVmZXJlbmNlZCBpbiBjb21taXQgbWVzc2FnZV0KPiBSZXZpZXdlZC1i
eTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPgo+IC0tLQo+ICAgZHJpdmVycy9udm1l
L2hvc3QvZmMuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPiAK
UmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
