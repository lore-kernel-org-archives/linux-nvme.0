Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4FFC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:29:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2376D64F1F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 17:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2376D64F1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YZ+a4DlxNdGEHr8QqIwlT44ouTpynO8bQI4Gk+tEBco=; b=R07QvfWQvg4eS5JZHl2CzKsku
	Z0KAYiBUQwUyDHEqNOBexK7CY4jTUXTY+6C8eyL6EePGFA6v6MMVhCn1d+Qiy5zgm7E4WIdcLA47M
	pR8Ep/WPDwNmqMKDBSzP8J7IbOhmxvWdvbJ7GEcSC7XAq504YM2AS8xAoml6wVHvDuWkM/N2DFPu9
	njXaY8q8PYoZVY8rSeyQEXMg8pStG/iORDBxHQcxRoHhH0v0zjB6SxUUlnyUm/nefpXs4nsHNANRS
	4vodaFmu3Aq0jiXX0NpAHpgZ5riK+q/Br4F3jTmDTAda9GmSYwxNfdkYkdbIwAJQwU9HOLJ1thK10
	3jfBDbWJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFKRm-0003Em-MM; Thu, 25 Feb 2021 17:29:06 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFKRj-0003EN-PT
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 17:29:04 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 50646ADDB;
 Thu, 25 Feb 2021 17:29:00 +0000 (UTC)
Subject: Re: [PATCH 6/6] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
To: Keith Busch <kbusch@kernel.org>
References: <20210225105527.75277-1-hare@suse.de>
 <20210225105527.75277-7-hare@suse.de>
 <20210225163140.GB31593@redsun51.ssa.fujisawa.hgst.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <16db4e63-4a07-6973-43f4-319ee3171431@suse.de>
Date: Thu, 25 Feb 2021 18:28:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210225163140.GB31593@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_122903_965933_81943CDD 
X-CRM114-Status: GOOD (  20.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8yNS8yMSA1OjMxIFBNLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBUaHUsIEZlYiAyNSwg
MjAyMSBhdCAxMTo1NToyN0FNICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdoZW4g
YSBjb21tYW5kIHRpbWVzIG91dCB3ZSBzaG91bGQgYmUgcmV0dXJuaW5nIC1FVElNRURPVVQgaW4K
Pj4gbnZtZV9zdWJtaXRfc3luY19jbWQoKSwgYW5kIG5vdCByZXF1aXJpbmcgdGhlIGNhbGxlciB0
byBndWVzcyB3aGV0aGVyCj4+IGEgc3BlY2lmaWMgTlZNZSBzdGF0dXMgc2hvdWxkIGJlIGludGVy
cHJldGVkIGFzIGEgdGltZW91dC4KPiAKPiBUaGlzIGRyaXZlciBoYXMgYmVlbiB1c2luZyAtRUlO
VFIgZm9yIHRoaXMgY29uZGl0aW9uIHNpbmNlIHRoZQo+IGJlZ2lubmluZywgdGhvdWdoLiBJcyB0
aGVyZSBhIHJlYXNvbiBJJ20gbm90IHNlZWluZyB3aHkgdGhlc2UgdXNlIGNhc2VzCj4gY2FuJ3Qg
dXNlIHRoZSBleGlzdGluZyBjb21tYW5kIGNhbmNlbGxlZCBmbGFnPwo+ICAgClRlY2huaWNhbGx5
IHdlIGhhdmUgdHdvIGRpc3RpbmN0IGNvbmRpdGlvbnMsIGEgY29tbWFuZCBiZWluZyBhYm9ydGVk
IGR1ZSAKdG8gYSB0aW1lb3V0LCBhbmQgYSBjb21tYW5kIGJlaW5nIGFib3J0ZWQgZHVlIHRvIGEg
cXVldWUgZGlzY29ubmVjdC4KQWRtaXR0ZWRseSwgdGhlIHNlY29uZCBjb25kaXRpb25zIGlzIHRo
ZSBjb21tb24gY2FzZSwgYXMgdGhlIHF1ZXVlIApkaXNjb25uZWN0IGlzIHR5cGljYWxseSBkb25l
IGR1ZSB0byB0aGUgZXJyb3IgcmVjb3Zlcnkga2lja2luZyBpbiwgd2hpY2ggCmluIGl0c2VsZiBp
cyBpbiByZWFjdGlvbiB0byBhIEtBVE8gdGltZW91dCBmaXJpbmcuClRoZSBmaXJzdCBjb25kaXRp
b24gaXMgb25seSBoaXQgaWYgd2UgcnVuIGludG8gYSB0aW1lb3V0IGZvciB0aGUgaW5pdGlhbCAK
Y29tbWFuZHMgX2JlZm9yZV8gS0FUTyBpcyBzdGFydGVkLgoKQW5kIEkgdGhvdWdodCBpdCBtaWdo
dCBiZSBnb29kIHRvIGhhdmUgdGhlc2UgdHdvIGNhc2VzIGRpZmZlcmVudGlhdGVkLgpCdXQgSSdk
IGJlIGZpbmUgd2l0aCBkcm9wcGluZyBpdCBpZiB0aGF0J3Mgbm90IG5lZWRlZC4KCkNoZWVycywK
Ckhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3Rv
cmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
KzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0
ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0
c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=
