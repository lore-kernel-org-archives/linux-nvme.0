Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF80FC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 16:55:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EE361008
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 16:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EE361008
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/cK+G8ywMBJpzpPQTAqcqqvTL3NDnAYtfCHMuwQvPSs=; b=nXWedKrmWfo5x2JfrE/mdZUgS
	9PS4SkEN8u3rPQRyZS8Y+7YtvgIl8wQu28YFtlEAvc4M3gpSni983dHhkPUB0Sk0OyQ56eBDjejzf
	gTn3EHwhO2aM9UuR16LFTmdqfofSV00euVDJgbtJpr58Mb3JcHnHwhZxCbfS/ztRYn3eXB/7KTU+D
	uH7oYtLmxhoS5sX95P/neg04XPanjo2680sDlbhDHXiclBtR5wq0307L11sNdNlxMtIavMISIptoh
	EZnBUjIRurLanU/QagSMORVPkc0XHcEb5xB6GFx4q2WPgAYgvC2wgIs8vd2qJgxAw9NZsxzIVYwpV
	BBEeUa00Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf3ki-007cYL-Qa; Fri, 07 May 2021 16:55:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf3k9-007cPh-2n
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 16:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=UwTIfZ/76z70LLKoGkhLhSheHVssxkfHZPV6E5rZ8vk=; b=TIVzD0bT3CwYk/NhSxEnjZY3mn
 v8jOtK3Tpe5cd/NzFTR8RI4UAsipehRr2VGO6o5LUphQ4/gGnRAWXwmDDILiCKBPnNJ5625n+BPAU
 C3PXei8xdW33qw1cNZCgruzwYHaltK34xeqOoV1x7JJDKfMQUo4lGo3dkozDhwB+8yxxR4gD7YUhs
 v4QPzfoBRYCxn48r3whjEVlwmpuVtqGhQj3vNHnXQTxN1FP6kfh7zr8H7uiGxxOFnvuCeDqrJcE5g
 MwFFa5oC0roC1CvQAnhy8CqYHG0YwyXp7BnkMH5UiUj5HiysV6L1Xwpjjzc0Ai2xyO6WiaaSY+cgE
 Lvw03lTA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf3k6-0071CV-3v
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 16:54:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 20C75B1B9;
 Fri,  7 May 2021 16:54:18 +0000 (UTC)
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
References: <20210506134823.2566853-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <061e2e8b-82ba-7842-d6ab-238b5aa88c20@suse.de>
Date: Fri, 7 May 2021 18:54:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210506134823.2566853-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_095422_320548_B56BAF46 
X-CRM114-Status: GOOD (  13.72  )
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

T24gNS82LzIxIDM6NDggUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IG52bWVfaW5pdF9p
ZGVudGlmeSBhbmQgdGh1cyBudm1lX21wYXRoX2luaXQgY2FuIGJlIGNhbGxlZCBtdWx0aXBsZQo+
IHRpbWVzIGFuZCB0aHVzIG11c3Qgbm90IG92ZXJ3cml0ZSBwb3RlbnRpYWxseSBpbml0aWFsaXpl
ZCBvciBpbi11c2UKPiBmaWVsZHMuICBTcGxpdCBvdXQgYSBoZWxwZXIgZm9yIHRoZSBiYXNpYyBp
bml0aWFsaXphdGlvbiB3aGVuIHRoZQo+IGNvbnRyb2xsZXIgaXMgaW5pdGlhbGl6ZWQgYW5kIG1h
a2Ugc3VyZSB0aGUgaW5pdF9pZGVudGlmeSBwYXRoIGRvZXMKPiBub3QgYmxpbmRseSBjaGFuZ2Ug
aW4tdXNlIGRhdGEgc3RydWN0dXJlcy4KPiAKPiBGaXhlczogMGQwYjY2MGYyMTRkICgibnZtZTog
YWRkIEFOQSBzdXBwb3J0IikKPiBSZXBvcnRlZC1ieTogTWFydGluIFdpbGNrIDxtd2lsY2tAc3Vz
ZS5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Cj4g
LS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8ICAzICstCj4gICBkcml2ZXJz
L252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDUzICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggICAgICB8ICA4ICsrKystLQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKPiAKUmV2
aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVz
Ci0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFy
Y2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTEx
IDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5
MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJl
cjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
