Return-Path: <SRS0=FSy1=AX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBEC433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2020 17:03:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF7B2068F
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2020 17:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C5jHKONj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF7B2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZwCPmbPw3yGu39BcdFgh2RDK9lRw5UlZEOlXxv6X9O0=; b=C5jHKONjq+UWtLb4ts1hq7MCh
	n/3e9uzixXtuyAoYin07uiDEAgp4tueJk4dhNBcIMZViCD+JDCaJr+uyiXJLDT91SHqDL7Qr62FUT
	1sKOt0xB3w+K2BF0VVS16HcHRaibzsBotZDK+1ZGQLxhLoHYPRUnbXMxGIPGwrLRm25yb6O57cF2P
	ErJfv1JidjOGtGB80njxm22GYBtQvetwKkQNglObNmvgVou/K8D7mkmRBJFohdsk0T1V8GjF1tsRG
	YtdXf47AWY8sLmh8aDPr7PkUemgo6CCpt06wYW2ve+A0elSnlJl7cSmU2Fk8LESnq4prKbQ9QWFre
	RLOzhr2fQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jufOL-0005Fh-3h; Sun, 12 Jul 2020 17:03:53 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jufOH-0005Ex-4m
 for linux-nvme@lists.infradead.org; Sun, 12 Jul 2020 17:03:50 +0000
IronPort-SDR: knlrslgWJ7BVOchNAHKCHaQIk5HH95jvJX6rKbPL9I9bACwjRsUaESfD8Dcmz9uwG5H6WO0f32
 Z8wCS/kTPdyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146000104"
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; d="scan'208";a="146000104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2020 10:03:47 -0700
IronPort-SDR: dapHLvAJNUhaOb6HPNqTACOLxDJVtvaAa9N4D1kGGaNnUgIaQSI8k+KivrA7wyZze9I70wua+M
 4MWNnL1Devtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,344,1589266800"; d="scan'208";a="484767236"
Received: from rrajashe-mobl1.amr.corp.intel.com (HELO [10.251.10.167])
 ([10.251.10.167])
 by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2020 10:03:46 -0700
Subject: Re: [PATCH] nvme: Namepace identification descriptor list is optional
To: Ingo Brunberg <ingo_brunberg@web.de>
References: <m3k0z9nkpl.fsf@web.de>
From: "Rajashekar, Revanth" <revanth.rajashekar@intel.com>
Message-ID: <b58c192d-bd81-651a-ca9f-d614e4655e48@intel.com>
Date: Sun, 12 Jul 2020 11:03:46 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <m3k0z9nkpl.fsf@web.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200712_130349_331923_CD20925D 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDcvMTIvMjAyMCAzOjMxIEFNLCBJbmdvIEJydW5iZXJnIHdyb3RlOgo+ICJSYWphc2hla2Fy
LCBSZXZhbnRoIiA8cmV2YW50aC5yYWphc2hla2FyQGludGVsLmNvbT4gd3JpdGVzOgo+Cj4+IEhp
LAo+Pgo+PiBPbiA3LzEwLzIwMjAgMjoyMiBBTSwgSW5nbyBCcnVuYmVyZyB3cm90ZToKPj4KPj4g
IFdpdGggY29tbWl0IGVhNDNkOTcsIGFwcGVhcmluZyBub3cgaW4ga2VybmVsIDUuNy44LCB5b3Ug
bWFkZSBteQo+PiAgY2hlYXAKPj4gU1NEIGRpc2Z1bmN0aW9uYWwgYWdhaW4uIEZvciByZWZlcmVu
Y2UsIHNlZSBidWcgMjA1Njc5LiBNYXliZSB5b3UKPj4gcmVtZW1iZXIgdGhlIGRpc2N1c3Npb24u
Cj4+Cj4+IFNob3VsZG4ndCB0aGUgbG9naWMgdXNlZCBpbiBjb21taXQgZWE0M2Q5NywgYmUgYXBw
bGllZCB0byB0aGUgbGluZSAnaWYgKHJldCA9PSAtRU5PTUVNIHx8IChyZXQgPiAwICYmCj4+ICEo
cmV0ICYgTlZNRV9TQ19ETlIpKSknIGluIGZ1bmN0aW9uICdfbnZtZV9yZXZhbGlkYXRlX2Rpc2sn
ID8KPiBJIHdhcyB3b25kZXJpbmcgdGhlIHNhbWUuIEJ1dCB0aGF0IGRvZXMgbm90IG1ha2UgbXkg
ZHJpdmUKPiB3b3JrLiBTb21ldGhpbmcgYWJvdXQgdGhhdCBsb2dpYyBpcyBub3QgcXVpdGUgcmln
aHQuIElmIHRoZSBjb25kaXRpb24gaXMKPiBtZXQgaW4gbnZtZV9pZGVudGlmeV9uc19kZXNjcywg
MCBpcyByZXR1cm5lZC4gU28gdGhlcmUgaXMgbm8gcG9pbnQgaW4KPiByZXBlYXRpbmcgdGhlIHNh
bWUgdGVzdCBpbiBudm1lX3JldmFsaWRhdGVfZGlzayBhcyB0aGF0IGNvZGUgcGF0aCBpcyBub3QK
PiByZWFjaGVkIGFueXdheS4KCkkgYWdyZWUgd2l0aCB0aGF0Li4uIE15IGNvbmNlcm4gaXMgaW4g
Y2FzZSBpZiB0aGUgc3RhdHVzIGhhZCB0aGUgRE5SIGJpdCBjbGVhcmVkLgoKSW7CoCB0aGF0IGNh
c2UgdGhpcyBsaW5lIG9mIHRoZSBjb2RlIGlzIHJlYWNoZWQgYW5kIHRoZSBzdGF0dXMgaXMgc2ls
ZW50bHkgc3VwcHJlc3NlZCB0byAwIGJlY2F1c2Ugb2YgdGhlIGNvbmRpdGlvbiAhKHJldCAmIE5W
TUVfU0NfRE5SKQoKVGhlIGludGVudGlvbiBvZiB0aGUgY29tbWl0IGVhNDNkOTcgd2FzIHRvIG5h
dmlnYXRlIGJhY2sgdGhlIGVycm9yIGluLWNhc2UgaWYgaXQgd2FzIGEgcmV0cnlhYmxlIGVycm9y
IChETlIgY2xlYXJlZCB0byAwKS4KCj4KPiBJZiBJIGdvdCBpdCByaWdodCwgTlZNRV9TQ19ETlIg
aXMgbm90IHNldCBmb3IgbXkgZHJpdmUsIHNvIHRoaXMgdGVzdCBpcwo+IG5vdCB0aGUgcmlnaHQg
c29sdXRpb24gZm9yIHRoYXQgcHJvYmxlbWF0aWMgY29udHJvbGxlci4KPgo+IFJlZ2FyZHMKPiBJ
bmdvIEJydW5iZXJnCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
