Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2177CC41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:08:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BCA206F4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 08:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2bPJN2oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BCA206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OLHL46gLMLcu3rL9/D1vIFUlHt5BToOvtbzGA9yYYhQ=; b=2bPJN2ozfWdyvlGxmOPYdkgJ3
	zS2FxqZ8d3Rd1TDiBWXWPM134juIQURA2aYR8LFjMtk49NRrlzvDc9JSxyiTOiI6LM3rxG5nWkG2m
	fUvsV6JeEaW5pKxO9AMwaxqru1j5ZBFNaru4l/JW+flI0XEaHdnLOvKz3aWw/HUKWLPlWSQJLUkLm
	9XiSeKFrd/gQnZxmi408BlByjUi3wm1jFG5Zt9hTEzWkoMbiONIqlIXVf6cxEm1/fhYPyMk5+225n
	k3bmwIh8e+bfByNBiPxH9trCJYIrsFhHxOJrqjsnvltAhfUWc+BfHzaN6J9JpJa8CD90Z8ATAkHUs
	al2AqE/Nw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPi0p-0005PQ-9E; Tue, 06 Oct 2020 08:07:55 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPi0m-0005Oe-RB
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 08:07:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 650E3AF4C;
 Tue,  6 Oct 2020 08:07:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Christoph Hellwig <hch@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
 <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
 <20201006075153.GA10041@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b720433b-5849-2e7f-d359-53247976bad5@suse.de>
Date: Tue, 6 Oct 2020 10:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201006075153.GA10041@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_040753_004418_4877F4E9 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNi8yMCA5OjUxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIE9j
dCAwNiwgMjAyMCBhdCAwNzo0ODo0MEFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IFdlbGwsIGJlY2F1c2UgaXQncyBlc3RhYmxpc2hlZCBiZWhhdmlvdXIgb2YgdGhlIGN1cnJlbnQg
Y29kZS4KPj4gQ2hhbmdpbmcgaXQgbm93IGhhcyB0aGUgcG90ZW50aWFsIHRvIGJyZWFrIGV4aXN0
aW5nIHNjZW5hcmlvcy4KPj4KPj4gRm9yIFBDSSAoaWUgbm9uLWZhYnJpY3MpIHRoZSBjdXJyZW50
IGJlaGF2aW91ciBpcyBhcmd1YWJseSBhIGNvcm5lciBjYXNlCj4+IChhcyBvbmUgbmVlZHMgdG8g
aGF2ZSBhIFBDSS1OVk1lIHdpdGggQ01JQyBiaXQgc2V0KSwgYnV0IG9uY2UgeW91IGhhdmUgaXQK
Pj4gUENJIGhvdHBsdWcgaXMgZG9uZSBmb3IuIFNvIHRoZXJlIHdlIHJlYWxseSB3YW50IHRvIGNo
YW5nZSB0aGUgYmVoYXZpb3VyIHRvCj4+IGdldCB0aGUgc2FtZSB1c2VyIGV4cGVyaWVuY2UgZm9y
IGFsbCBOVk1lIGRyaXZlcy4KPiAKPiBEdWFsIHBvcnQgUENJIE5WTWUgZGV2aWNlcyBhcmUgcHJl
dHR5IGNvbW1vbiBpbiB0aGUgZW50ZXJwcmlzZSBzcGFjZS4KPiBJIHJlYWxseSBkb24ndCBzZWUg
YW55IGdvb2QgcmVhc29uIHRvIGRpZmZlciBoZXJlLgo+IAo/CkRpZmZlciBmcm9tIHdoYXQ/CgpO
b3JtYWwgKG5vbi1kdWFsIHBvcnRlZCkgUENJLU5WTWU/Ck5WTWUtb0Y/CgpDaGVlcnMsCgpIYW5u
ZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJj
aGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0
MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7Zy
ZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
