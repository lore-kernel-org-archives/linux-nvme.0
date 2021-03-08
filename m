Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B6C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A979E651CD
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 13:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A979E651CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/ra3Dccq+XTox1hfv4TsiCfbLlDWT52ItiOOyKamy4I=; b=LdQh5iGOmsTKU5j3LxkG2rirM
	q61LQhR6Y9qOoaQajWCieYWsocEavw2h58J1QL6QI01Gyz3JdDoXU1mWqmaaYrrnvMFznymgeLfeG
	pWYHQAIy8AHBoIwGiitNb3OXTaMjF5PnOM3fD17EO9wDxyhHKotujehWccmgjTOIAAjK7uiypJQ+z
	eCVseFkPSkCjPl/hP6YbkdCWTXWXpleHx7oKJ4JvbqTlP53l/b/fmNnyiYXsNyNdDn9fxKD1JuXLc
	R/41EqHX0s0yvFh8vSm8v+wq79o41yO24/p7k43M4UXf8ZlJZ0iCXcLnG2gHAtN1SDbUXU2fDMSoJ
	SmugrKssQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJFl2-00HOJO-Ac; Mon, 08 Mar 2021 13:17:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJFkx-00HOHm-UN
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 13:17:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B8721AD74;
 Mon,  8 Mar 2021 13:17:06 +0000 (UTC)
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
 <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
 <20201006082727.GC10243@lst.de>
 <a848297e-3243-6366-86ee-0800d51198e1@suse.de>
 <20201006083926.GA13568@lst.de>
 <00e75643-d422-ca12-1648-02ca89044182@suse.de>
 <ce2c93e1-ba38-cebb-33b3-d506116a61aa@suse.de>
 <28830f4b-181d-2a4d-0bdd-2f63fcdbcf72@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
Message-ID: <44affc5e-d655-aa1c-55fe-65805d66065a@suse.de>
Date: Mon, 8 Mar 2021 14:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <28830f4b-181d-2a4d-0bdd-2f63fcdbcf72@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_131708_471004_BAC88A62 
X-CRM114-Status: GOOD (  21.21  )
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

T24gMy81LzIxIDk6MzEgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4gCj4+IENvbXBhcmUgdGhh
dCB0byB0aGUgJ3N0YW5kYXJkJywgbm9uLUNNSUMgbnZtZSwgd2hlcmUgd2l0aCB0aGUgc2FtZQo+
PiBzZXR1cCBNRCB3b3VsZCBkZXRhY2ggdGhlIG52bWUgb24gaXRzIG93bjoKPj4KPj4gIyBjYXQg
L3Byb2MvbWRzdGF0Cj4+IFBlcnNvbmFsaXRpZXMgOiBbcmFpZDEwXQo+PiBtZDEyNyA6IGFjdGl2
ZSAoYXV0by1yZWFkLW9ubHkpIHJhaWQxMCBudm1lMm4xWzFdCj4+IMKgwqDCoMKgwqDCoCA0MTg5
MTg0IGJsb2NrcyBzdXBlciAxLjIgMiBuZWFyLWNvcGllcyBbMi8xXSBbX1VdCj4+IMKgwqDCoMKg
wqDCoCBiaXRtYXA6IDAvMSBwYWdlcyBbMEtCXSwgNjU1MzZLQiBjaHVuawo+Pgo+PiB1bnVzZWQg
ZGV2aWNlczogPG5vbmU+Cj4+ICMgbnZtZSBsaXN0Cj4+IE5vZGXCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgU07CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTW9kZWwgwqDCoMKg
wqDCoCBOYW1lc3BhY2UKPj4gVXNhZ2XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgRm9ybWF0wqDCoMKgwqDCoMKgwqDCoMKgwqAgRlcgUmV2Cj4+IC0tLS0tLS0tLS0t
LS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0t
LS0tLS0tLS0tLS0tLSAtLS0tLS0tLQo+PiAvZGV2L252bWUwbjHCoMKgwqDCoCBTTEVTTlZNRTHC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFFFTVUgTlZNZSBDdHJsIMKgwqDCoMKgwqAgMcKgwqDCoMKg
wqDCoMKgwqDCoAo+PiAxNy4xOMKgIEdCIC/CoCAxNy4xOMKgIEdCwqDCoMKgIDUxMsKgwqAgQiAr
wqAgMCBCwqDCoCAxLjAKPj4gL2Rldi9udm1lMm4xwqDCoMKgwqAgU0xFU05WTUUzwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBRRU1VIE5WTWUgQ3RybCDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgwqDCoMKg
wqDCoAo+PiA0LjI5wqAgR0IgL8KgwqAgNC4yOcKgIEdCwqDCoMKgIDUxMsKgwqAgQiArwqAgMCBC
wqDCoCAxLjAKPj4KPj4gQW5kIHllcywgdGhpcyBpcyBleGFjdGx5IHRoZSBzYW1lIHNldHVwLCB0
aGUgb25seSBkaWZmZXJlbmNlIGJlaW5nIHRoZQo+PiBDTUlDIHNldHRpbmcgZm9yIHRoZSBOVk1l
IGRldmljZS4KPiAKPiBJIGFncmVlIHdpdGggQ2hyaXN0b3BoIHRoYXQgd2Ugc2hvdWxkIGRvIGV4
YWN0bHkgdGhlIHNhbWUgZm9yIGFsbC4KPiAKPiBIYW5uZXMsIE15IHVuZGVyc3RhbmRpbmcgaGVy
ZSBpcyB0aGF0IHlvdSB3YW50IHRoZSBkZXZpY2UgdG8gZ28gYXdheQo+IGFmdGVyIHRoZSBsYXN0
IHBhdGggZGlzYXBwZWFyZWQgYmVjYXVzZSBpdCBicmVha3MgbWQsIHdoeSBkb24ndCB5b3UKPiB3
YW50IHRvIGhhdmUgdGhpcyBhbHNvIGZvciBmYWJyaWNzPwo+IApPaCwgSSB3b3VsZCBfbG92ZV8g
dG8gaGF2ZSBpdCBmb3IgZmFicmljcyBwZXIgZGVmYXVsdC4KSWYgeW91IGFncmVlIHdpdGggaXQg
SSBjYW4gcmVzZW5kIEtlaXRocyBvcmlnaW5hbCBwYXRjaCwgd2hpY2ggc29sdmVzCnRoZSBpc3N1
ZSB3aXRob3V0IHRoZSBuZWVkIGZvciBhbnkgYWRkaXRpb25hbCBzZXR0aW5ncy4KCj4gWW91IG1l
bnRpb24gdGhhdCBpbiBmYWJyaWNzIG9uZSBjYW4gbWFudWFsbHkgZGlzY29ubmVjdCwgYnV0IHdo
eSBzaG91bGQKPiB0aGUgdXNlciByZXNvcnQgdG8gYSBtYW51YWwgZGlzY29ubmVjdD8KPiAKPiBJ
cyBzb21ldGhpbmcgZWxzZSBicm9rZW4gd2l0aCB0aGlzIGJlaGF2aW9yPyBNYXliZSBJIGFtIG1p
c3NpbmcKPiBzb21ldGhpbmcgaGVyZT8KCkknbSBqdXN0IHRyeWluZyB0byB1bmRlcnN0YW5kIHdo
eSB0aGUgY3VycmVudCBsb2dpYyB3YXMgYnVpbGQgaW50bwpmYWJyaWNzIGluIHRoZSBmaXJzdCBw
bGFjZS4KQnV0IGlmIG5vLW9uZSByZW1lbWJlcnMgKG9yIHRoZXJlIHdhcyBub25lKSBJJ2QgaGFw
cGlseSBjb252ZXJ0IHRvIHRoZQpQQ0kgbG9naWMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBI
YW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVA
c3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJn
CkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
