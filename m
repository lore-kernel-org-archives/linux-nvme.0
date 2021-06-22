Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F312C2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 06:22:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9CB6113E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 06:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9CB6113E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zs1CZOxF2al9FBQ/1aKkChrje0xQ2EB+EV/V/3dQu24=; b=aKvFj9E8nI01sQrsaEdMvXr4wF
	0y9D6wKUjoHmhv6nZorEs2ckCEFR1VcXYpNMDKiXirXg6uxuA09GJ2JhTCf2sA0fRDwvVQMthELeg
	mkSHHT7fyeROXO8dKkXYSqNwUDf1udp3IdI21HDWzPN3yZx6WIwUkXioQKZFSQJ4rV3mbwel+/oD4
	sFxoPnclZJAozxqE86CnFqlFpWRt4nChcRgiB+8eBVwJAVygL2bjvP01nu6sR2RzXX3J8awdE8Y1n
	4yiNQKgu4FYeZA4kv1PyCTysATFzLStziOUd504qqhi7CE9NoQp/PySnpEFFXv+YijgdAc4gYUhOo
	6WrF0D1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvZnK-005o5Y-28; Tue, 22 Jun 2021 06:21:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvZnH-005o52-Jw
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 06:21:57 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C91D41FD5C;
 Tue, 22 Jun 2021 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624342913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ttRlrRSbeRfvh1H++ETaEK+j094fj2LSTOh25O2EBQ=;
 b=OK8BxxiN/uWMs1La9AbocAg6jhpd+mOR93CrLbB/hyQIGOxTipCtIV1BR4VW9S0UeeIPGs
 DBw0dd6Ueyuh7onRhwsyiJxQNmnqPh75lDLi2YbD6zztSlTZeq+qJW9QHlvR160iOq1sl7
 17lE9s60dOTSYO883BTGL7otHUDXNso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624342913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ttRlrRSbeRfvh1H++ETaEK+j094fj2LSTOh25O2EBQ=;
 b=A1iLWZW8y+qIeCMxKwcF0pXgTIjph3su93H+Rm0KDA2i7hU73m/znPWRDiQUBuFI/+QASv
 FMPRgaCibHQcQfBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 966D9118DD;
 Tue, 22 Jun 2021 06:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624342913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ttRlrRSbeRfvh1H++ETaEK+j094fj2LSTOh25O2EBQ=;
 b=OK8BxxiN/uWMs1La9AbocAg6jhpd+mOR93CrLbB/hyQIGOxTipCtIV1BR4VW9S0UeeIPGs
 DBw0dd6Ueyuh7onRhwsyiJxQNmnqPh75lDLi2YbD6zztSlTZeq+qJW9QHlvR160iOq1sl7
 17lE9s60dOTSYO883BTGL7otHUDXNso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624342913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ttRlrRSbeRfvh1H++ETaEK+j094fj2LSTOh25O2EBQ=;
 b=A1iLWZW8y+qIeCMxKwcF0pXgTIjph3su93H+Rm0KDA2i7hU73m/znPWRDiQUBuFI/+QASv
 FMPRgaCibHQcQfBA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id PezNI4GB0WDyTAAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 22 Jun 2021 06:21:53 +0000
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths are
 down
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210609150118.130650-1-hare@suse.de>
 <20210621172653.GC1268033@dhcp-10-100-145-180.wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b4637359-9846-4086-2fc2-a1a990933c7b@suse.de>
Date: Tue, 22 Jun 2021 08:21:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210621172653.GC1268033@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_232155_873513_14DA20A1 
X-CRM114-Status: GOOD (  21.81  )
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

T24gNi8yMS8yMSA3OjI2IFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBXZWQsIEp1biAwOSwg
MjAyMSBhdCAwNTowMToxOFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IC12b2lk
IG52bWVfbXBhdGhfcmVtb3ZlX2Rpc2soc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkKPj4gK3Zv
aWQgbnZtZV9tcGF0aF9jaGVja19sYXN0X3BhdGgoc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCkK
Pj4gICB7Cj4+ICsJYm9vbCBsYXN0X3BhdGggPSBmYWxzZTsKPj4gICAJaWYgKCFoZWFkLT5kaXNr
KQo+PiAgIAkJcmV0dXJuOwo+PiAtCWlmIChoZWFkLT5kaXNrLT5mbGFncyAmIEdFTkhEX0ZMX1VQ
KSB7Cj4+IC0JCW52bWVfY2Rldl9kZWwoJmhlYWQtPmNkZXYsICZoZWFkLT5jZGV2X2RldmljZSk7
Cj4+IC0JCWRlbF9nZW5kaXNrKGhlYWQtPmRpc2spOwo+PiArCj4+ICsJLyogU3luY2hyb25pemUg
d2l0aCBudm1lX2luaXRfbnNfaGVhZCgpICovCj4+ICsJbXV0ZXhfbG9jaygmaGVhZC0+c3Vic3lz
LT5sb2NrKTsKPj4gKwlpZiAobGlzdF9lbXB0eSgmaGVhZC0+bGlzdCkpCj4+ICsJCWxhc3RfcGF0
aCA9IHRydWU7Cj4+ICsJbXV0ZXhfdW5sb2NrKCZoZWFkLT5zdWJzeXMtPmxvY2spOwo+PiArCWlm
IChsYXN0X3BhdGgpIHsKPj4gKwkJa2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZoZWFkLT5yZXF1ZXVl
X3dvcmspOwo+PiArCQlpZiAoaGVhZC0+ZGlzay0+ZmxhZ3MgJiBHRU5IRF9GTF9VUCkgewo+PiAr
CQkJbnZtZV9jZGV2X2RlbCgmaGVhZC0+Y2RldiwgJmhlYWQtPmNkZXZfZGV2aWNlKTsKPj4gKwkJ
CWRlbF9nZW5kaXNrKGhlYWQtPmRpc2spOwo+PiArCQl9Cj4+ICAgCX0KPj4gK30KPiAKPiBUaGlz
IGlzIGJlaW5nIGNhbGxlZCB3aGVuIGEgcGF0aCBpcyByZW1vdmVkLiBJZiBpdCBpcyB0aGUgbGFz
dCBwYXRoLCB0aGUKPiBoZWFkJ3MgYmxvY2sgZGV2aWNlIGlzIGJlaW5nIGRlbGV0ZWQuIElmIGEg
bGl2ZSBoZWFkIHJlZmVyZW5jZSBpcyBoZWxkLAo+IGFuZCB0aGUgYSBwYXRoIHJlY29ubmVjdHMs
IHRoZSBjb2RlIHdpbGwgZmluZCB0aGUgcHJldmlvdXMgaGVhZCwgYnV0IHRoZQo+IGRpc2sgaXMg
Z29uZSBhbmQgaXQncyBub3QgY29taW5nIGJhY2ssIHNvIHRoZSBuZXcgY29ubmVjdGlvbiBjYW4n
dCBiZQo+IHVzZWQuCj4gCkdvb2QgcG9pbnQuIEJ1dCB0aGF0IGNhbiBiZSBmaXhlZCBieSByZW1v
dmluZyB0aGUgbnNfaGVhZCBmcm9tIHRoZSAKc3Vic3lzdGVtIGxpc3QgYXQgdGhpcyBjaGVjayBy
YXRoZXIgdGhhbiBpbiBudm1lX2ZyZWVfbnNfaGVhZCgpLgpXaWxsIGJlIHNlbmRpbmcgYW4gdXBk
YXRlZCB2ZXJzaW9uLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
