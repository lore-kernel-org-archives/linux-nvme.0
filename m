Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF36C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:59:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB9E60EBA
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 06:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFB9E60EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbylkZfEaaFvic/k+SRQ0EbaDk+5Cnu3CE3jvLLsqFM=; b=ySSSiFDnjdGmot2h5khV47iEaC
	PO+kURF9JkC1NW9BUETyFKm8dnwEreh6VW9ROrPCHCTWGkDaZmpxsguYiuSPymCaivHQwAzcPIQuS
	FxMQL4dQ5Y0sKKGUvNjI3AQXnhNk7GKgLoQyJ8JdkU0mfMJbjFa3EoISld+YneIWhng8mLmgBazx2
	FUpP/fSiEjdsDWl6hz7UUzxp6h12OzOdTu/RsT+iWo6AK7eFeaEtFaaQEA2MyfT+a4H8lYvCNnJGs
	Egib13oJhjEJZgnLIiVXdZmSN0K1gT0aj7+F019xo9UajZfqwngjZfHwKlKTP7cQ0tt48CvyHFiYC
	w5QvLMZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN8ax-00HTkq-Fq; Mon, 06 Sep 2021 06:59:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN8av-00HTkC-Ee
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 06:59:06 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D2C82204F;
 Mon,  6 Sep 2021 06:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630911544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dn0AdOvFpZsUlxjV7t+j3XKO1jkWdOoSxY3S7G4pEQ0=;
 b=iBl212aH0D/EELR8gHhKD8PTFR+y7Jj/RkoRzTP9wiq0fitael9dqrnWPTRJtuToFGNxk4
 b2HLI0L7uqjnOMQyluQmeZoh+gyjVbQHVriTl6eyoDq7bz3yxWjS9Ujy0BcwfJHz4IadzZ
 4TAbEVrSeKInT5ocC7ytVSbNsozhtFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630911544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dn0AdOvFpZsUlxjV7t+j3XKO1jkWdOoSxY3S7G4pEQ0=;
 b=5+c3MmVDMZMmPVmvg9/t8jFNraF3/pF5u85tBzmf3y7lDML1xMHkKLGm6KEeR7tO7ciHMy
 gg6i0GusvzMEwVAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0288713299;
 Mon,  6 Sep 2021 06:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id HZQ5Oze8NWHzVgAAGKfGzw
 (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 06:59:03 +0000
Subject: Re: [PATCH] nvmet: fixup buffer overrun in nvmet_subsys_attr_serial()
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20210827092926.9525-1-hare@suse.de>
 <20210827162636.GA24829@lst.de> <20210901122247.GA10562@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f06240ed-5fd4-b8fa-a8cc-be10b9f62bcf@suse.de>
Date: Mon, 6 Sep 2021 08:59:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210901122247.GA10562@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210905_235905_685525_D43D94F5 
X-CRM114-Status: GOOD (  18.49  )
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

T24gOS8xLzIxIDI6MjIgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIEZyaSwgQXVn
IDI3LCAyMDIxIGF0IDA2OjI2OjM2UE0gKzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+
PiBPbiBGcmksIEF1ZyAyNywgMjAyMSBhdCAxMToyOToyNkFNICswMjAwLCBIYW5uZXMgUmVpbmVj
a2Ugd3JvdGU6Cj4+PiBUaGUgc2VyaWFsIG51bWJlciBpcyBjb3BpZWQgaW50byB0aGUgYnVmZmVy
IHZpYSBtZW1jcHlfYW5kX3BhZCgpCj4+PiB3aXRoIHRoZSBsZW5ndGggTlZNRVRfU05fTUFYX1NJ
WkUuIFNvIHdoZW4gcHJpbnRpbmcgb3V0IHdlIGFsc28KPj4+IG5lZWQgdG8gdGFrZSBqdXN0IHRo
YXQgbGVuZ3RoIGFzIGFueXRoaW5nIGJleW9uZCB0aGF0IHdpbGwgYmUKPj4+IHVuaW5pdGlhbGl6
ZWQuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+
Cj4+Cj4+IFRoZSBub3JtYWwgd2F5IHRvIHByaW50IGEgcG90ZW50aWFsbHkgdW50ZXJtaW5hdGVk
IGZpeGVkIGxlbmd0aCBzdHJpbmcKPj4gd291bGQgYmUgc29tZXRoaW5nIGxpa2U6Cj4gCj4gRG9l
cyB0aGlzIHZlcnNpb24gc3RpbGwgbG9vayBvayB0byB5b3U/Cj4gCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2Nv
bmZpZ2ZzLmMKPj4gaW5kZXggZjc0NDg1YzcwNWZmMi4uZDc4NGYzYzIwMGI0YyAxMDA2NDQKPj4g
LS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9jb25maWdmcy5jCj4+ICsrKyBiL2RyaXZlcnMvbnZt
ZS90YXJnZXQvY29uZmlnZnMuYwo+PiBAQCAtMTA2Nyw3ICsxMDY3LDggQEAgc3RhdGljIHNzaXpl
X3QgbnZtZXRfc3Vic3lzX2F0dHJfc2VyaWFsX3Nob3coc3RydWN0IGNvbmZpZ19pdGVtICppdGVt
LAo+PiAgIHsKPj4gICAJc3RydWN0IG52bWV0X3N1YnN5cyAqc3Vic3lzID0gdG9fc3Vic3lzKGl0
ZW0pOwo+PiAgIAo+PiAtCXJldHVybiBzbnByaW50ZihwYWdlLCBQQUdFX1NJWkUsICIlc1xuIiwg
c3Vic3lzLT5zZXJpYWwpOwo+PiArCXJldHVybiBzbnByaW50ZihwYWdlLCBQQUdFX1NJWkUsICIl
KnNcbiIsCj4+ICsJCQlOVk1FVF9TTl9NQVhfU0laRSwgc3Vic3lzLT5zZXJpYWwpOwo+PiAgIH0K
Pj4gICAKPj4gICBzdGF0aWMgc3NpemVfdAo+IC0tLWVuZCBxdW90ZWQgdGV4dC0tLQo+IApZZXMs
IGl0IGRvZXM7IHdpbGwgYmUgc2VuZGluZyBhbiB1cGRhdGVkIHBhdGNoLgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
