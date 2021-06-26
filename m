Return-Path: <SRS0=/gGm=LU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1B3C49EA5
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Jun 2021 12:10:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185FA61954
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Jun 2021 12:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185FA61954
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rH2WgHtdZ4D4H+vzfv6c5HkC+9vEq380rjqIKA0MhlQ=; b=yd2e5nStlNVEy/HKNQy3UKHHR5
	t1C4YxZ/JKJHYy1fSJ446ZYxZ2a890S2yQB1Dq/7p4LA4NfC8W1ZkCz1zNEEHuET+n5zY4OUb/7/r
	JdlqJ3wz372YeX5vwrcI+yASYU1lEdUPGBJ6kYimp+owCnbIFQaLuGJv3LJ+WOY6wKC8ZSwa+e6/a
	gKYeF3kKECWev8KMdWDgot/a4LF4AD+3S8IDbgbpLQ5MmHyc6nGjhytMGQUpDA7XqhQu8z++pt/JN
	Ougx2eGMpqkyE+C33d/qp9u2e1zRByZrl8XLUNoyquPAp9f9jICSzwu79cHpBvwXx9cJCAs37oC0B
	V694kaqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lx78H-0046PV-HU; Sat, 26 Jun 2021 12:09:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lx78D-0046Oi-Kf
 for linux-nvme@lists.infradead.org; Sat, 26 Jun 2021 12:09:55 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A54A81FFB3;
 Sat, 26 Jun 2021 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624709389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2RQbT7xMYUpwJg2UFbYHIJCUJfft+5oRuaCrVxYrxA=;
 b=wsPMm7Vs+Rg5KUPNkP9Q6TkyxjbEFulb8IMqjb10PHuikqAATG/ZVgWlgf6szEPFqtLR41
 XAEywCDmiMOFnpe6B+iQ42QbVJfr6J3ebndXHlfTsaNIrT6+mwUuin5GEsek6Jck5YzSby
 xQuYpUYNarSAB3aXNeFWP/PO7AR7yXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624709389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2RQbT7xMYUpwJg2UFbYHIJCUJfft+5oRuaCrVxYrxA=;
 b=vb0JN9ypY+kozZAKAHDgrtRMVZD7WQW/vVOKQdLyiS2UDUdmpUFBAKdVziFdR2Iet/KASU
 OT3N7zBZTLavkTCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 39929118DD;
 Sat, 26 Jun 2021 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624709389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2RQbT7xMYUpwJg2UFbYHIJCUJfft+5oRuaCrVxYrxA=;
 b=wsPMm7Vs+Rg5KUPNkP9Q6TkyxjbEFulb8IMqjb10PHuikqAATG/ZVgWlgf6szEPFqtLR41
 XAEywCDmiMOFnpe6B+iQ42QbVJfr6J3ebndXHlfTsaNIrT6+mwUuin5GEsek6Jck5YzSby
 xQuYpUYNarSAB3aXNeFWP/PO7AR7yXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624709389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2RQbT7xMYUpwJg2UFbYHIJCUJfft+5oRuaCrVxYrxA=;
 b=vb0JN9ypY+kozZAKAHDgrtRMVZD7WQW/vVOKQdLyiS2UDUdmpUFBAKdVziFdR2Iet/KASU
 OT3N7zBZTLavkTCw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id OzzHCg0Z12BtMwAALh3uQQ
 (envelope-from <hare@suse.de>); Sat, 26 Jun 2021 12:09:49 +0000
Subject: Re: [PATCH 0/2] nvme-fabrics: short-circuit connect retries
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210623143250.82445-1-hare@suse.de>
 <8d7c79d9-0928-8c71-74fd-7185d67e7895@grimberg.me>
 <204a6656-ef83-b688-4979-26fe17f57974@suse.de>
 <cdf40226-12ed-5f87-8549-10b4defceae5@huawei.com>
 <91ff9961-6537-05d1-c552-18a02d13bf0c@suse.de>
 <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d20b23fc-dd08-cb51-eb29-aa033810b0a4@suse.de>
Date: Sat, 26 Jun 2021 14:09:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <984b2d1a-f319-1a09-7347-6c4edd1dbab6@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210626_050953_877405_CDBB76A8 
X-CRM114-Status: GOOD (  20.98  )
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

T24gNi8yNi8yMSAzOjAzIEFNLCBDaGFvIExlbmcgd3JvdGU6Cj4gCj4gCj4gT24gMjAyMS82LzI0
IDE2OjEwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IE9uIDYvMjQvMjEgOToyOSBBTSwgQ2hh
byBMZW5nIHdyb3RlOgo+Pj4KPj4+Cj4+PiBPbiAyMDIxLzYvMjQgMTM6NTEsIEhhbm5lcyBSZWlu
ZWNrZSB3cm90ZToKPj4+PiBPbiA2LzIzLzIxIDExOjM4IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3Rl
Ogo+Pj4+Pgo+Pj4+Pj4gSGkgYWxsLAo+Pj4+Pj4KPj4+Pj4+IGNvbW1pdCBmMjVmOGVmNzBjZTIg
KCJudm1lLWZjOiBzaG9ydC1jaXJjdWl0IHJlY29ubmVjdCByZXRyaWVzIikKPj4+Pj4+IGFsbG93
ZWQgdGhlIGZjIHRyYW5zcG9ydCB0byBob25vdXIgdGhlIEROUiBiaXQgZHVyaW5nIHJlY29ubmVj
dAo+Pj4+Pj4gcmV0cmllcywgYWxsb3dpbmcgdG8gc3BlZWQgdXAgZXJyb3IgcmVjb3ZlcnkuCj4+
Pj4+Cj4+Pj4+IEhvdyBkb2VzIHRoaXMgc3BlZWQgdXAgZXJyb3IgcmVjb3Zlcnk/Cj4+Pj4KPj4+
PiBXZWxsLCBub3QgZXhhY3RseSBlcnJvciByZWNvdmVyeSAoYXMgdGhlcmUgaXMgbm90aGluZyB0
byByZWNvdmVyKS4KPj4+PiBCdXQgd2Ugd29uJ3QgYXR0ZW1wdCBwb2ludGxlc3MgcmV0cmllcywg
dGhlcmVieSByZWR1Y2luZyB0aGUgbm9pc2UgaW4KPj4+PiB0aGUgbWVzc2FnZSBsb2cuCj4+PiBU
aGlzIGNvbmZsaWN0IHdpdGggdGhlIHRjcCBhbmQgcmRtYSB0YXJnZXQuCj4+PiBZb3UgbWF5IG5l
ZWQgdG8gZGVsZXRlIHRoZSBpbXByb3BlciBOVk1FX1NDX0ROUiBhdCB0aGUgdGFyZ2V0Lgo+Pj4g
SG93ZXZlciwgdGhpcyB3aWxsIGNhdXNlIGNvbXBhdGliaWxpdHkgaXNzdWVzIGJldHdlZW4gZGlm
ZmVyZW50IAo+Pj4gdmVyc2lvbnMuCj4+Cj4+IFdoaWNoIG9uZXM/Cj4gSW4gbWFueSBzY2VuYXJp
b3MsIHRoZSBkZXN0aW5hdGlvbiBzZXRzIEROUiBmb3IgYWJub3JtYWwgcGFja2V0cywKPiBidXQg
ZWFjaCBuZXcgY29ubmVjdGlvbiBtYXkgbm90IGhhdmUgdGhlIHNhbWUgZXJyb3IuCgpUaGlzIHBh
dGNoIHNlcmllcyBpcyBvbmx5IGZvciB0aGUgRE5SIGJpdCBzZXQgaW4gcmVzcG9uc2UgdG8gdGhl
IAonY29ubmVjdCcgY29tbWFuZC4KSWYgdGhlIHRhcmdldCBpcyBub3QgYWJsZSB0byBwcm9jZXNz
IHRoZSAnY29ubmVjdCcgY29tbWFuZCwgYnV0IG1heSBiZSAKc28gaW4gdGhlIGZ1dHVyZSBpdCBy
ZWFsbHkgc2hvdWxkIG5vdCBzZXQgdGhlIEROUiBiaXQuCgo+PiBJIGNoZWNrZWQgdGhlIEROUiB1
c2FnZSBpbiB0aGUgdGFyZ2V0IGNvZGUsIGFuZCB0aGV5IHNlZW0gdG8gc2V0IGl0Cj4+IGNvcnJl
Y3RseSAoaWUgdGhlIHJlc3VsdCB3b3VsZCBub3QgY2hhbmdlIHdoZW4gdGhlIGNvbW1hbmQgaXMg
cmV0cmllZCkuCj4+IFdpdGggdGhlIHBvc3NpYmxlIGV4Y2VwdGlvbiBvZiBFTk9TUEMgaGFuZGxp
bmcsIGFzIHRoaXMgaXMgYXJndWFibHkKPj4gZHluYW1pYyBhbmQgbWlnaHQgY2hhbmdlIHdpdGgg
YSByZXRyeS4KPiBUaGUgRE5SIHN0YXR1cyBvZiB0aGUgb2xkIGNvbm5lY3Rpb24gbWF5IG5vdCBi
ZSByZWxldmFudCB0byB0aGUgCj4gcmUtZXN0YWJsaXNoZWQgY29ubmVjdGlvbi4KClNlZSBhYm92
ZS4KV2UgYXJlIGp1c3QgY2hlY2tpbmcgdGhlIEROUiBzZXR0aW5ncyBmb3IgdGhlICdjb25uZWN0
JyBjb21tYW5kIChvciBhbnkgCm90aGVyIGNvbW1hbmRzIGJlaW5nIHNlbnQgZHVyaW5nIGluaXRp
YWwgY29udHJvbGxlciBjb25maWd1cmF0aW9uKS4KSWYgdGhhdCBmYWlscyB0aGUgY29ubmVjdCBu
ZXZlciB3YXMgcHJvcGVybHkgaW5pdGlhbGl6ZWQ7IGlmIHRoZSAKY29udHJvbGxlciB3b3VsZCBy
ZXR1cm4gYSBkaWZmZXJlbnQgc3RhdHVzIGFmdGVyIHJlY29ubmVjdCBpdCBzaW1wbHkgCnNob3Vs
ZCBub3Qgc2V0IHRoZSBETlIgYml0IC4uLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVz
IFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1
c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNF
IFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcK
SFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTD
tnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
