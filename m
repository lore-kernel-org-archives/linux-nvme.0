Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA14C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:06:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956D660200
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 13:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956D660200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JgV0wkhmu6ijEnLxuib6Q/Qvp6WeYqURMgAiTRxP+cM=; b=c/scWwV2iG1tzmiRC0iUKnIS5
	ZvKeSuXu+5QwHzbLl4IVKjU6FNRYlJxyyUDcaEuuhYqeAMoh+RnJCIRuK9hTZmcFjOfNU2NMJ6/I5
	HMWWYMPcDj+EeYqB09Jdc93u8LyZyeKT3Tle6vh4C1YifVzXnRuyYRTE8UNb6AAajzYIhdY6MGhgH
	xcXAITCZDs/q0s4Mu7e1T3H9eUX3duphHaRczA4kK0HucLnfO3VNUOPBL/Z3y/waJ8G4lspiwZ8SY
	uPpm1927y67ZhC8UvfzKMLswI2nv2T9jx5sOUx54dRZEspIq8jTB+YNrpDlbX5rzsXiIbhGm+lmgm
	M/yUpl0mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgoZ3-002qTM-7v; Wed, 12 May 2021 13:06:13 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoZ0-002qSz-Ns
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 13:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=OCCYY2eT1EW13uz2XMdodNNpnr1AoTeYr6E2KAOsmY4=; b=sLUN5PCdGj62fcDw8r1fAjc93M
 li8G6aNAE3KX4SF+udocOsXuSOXeB2+/2qzmL525VYmiP/pfLnJm7CGBuMoY7rOsyDkA6whrfDEYH
 NUqamoP/PMl9bOFI7LNNFb30tpyrJBhIGPI7w3Kj+/zqgPXkVAl+SmXKmxQdJa9DhWNfOW3EQNsTQ
 0lXwxvafk0o+3WrAClO2MFB+ctxnBXX67Gzp7G3szDDbL1f6oZYhoA7lhqfNLWV420tujb4mwcTo9
 t9RA30w/8b4WowbTj9xc2ZoIb7zUVrr8ktAV3oie+uDDDvmh7KeVCcutRS3jZeRuHvZUjkXfcBMFk
 EyKRHqCQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgoYy-00ANXj-22
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 13:06:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9BA9DB17B;
 Wed, 12 May 2021 13:06:06 +0000 (UTC)
Subject: Re: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210511080308.6734-1-hare@suse.de>
 <20210511161907.GA17525@lst.de>
 <7b01589e-3987-9573-ccd7-b599affed2a5@suse.de>
 <20210512062047.GA18271@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <acd874cc-12d2-bfdf-3f88-1fdf1a9cf832@suse.de>
Date: Wed, 12 May 2021 15:06:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512062047.GA18271@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_060608_261649_4A5DFA48 
X-CRM114-Status: GOOD (  10.80  )
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

T24gNS8xMi8yMSA4OjIwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBXZWQsIE1h
eSAxMiwgMjAyMSBhdCAwNzoyNDo0NEFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
PiBDYW4geW91IHBsZWFzZSBhbHNvIGFkZCBhIGNvbW1lbnQgd2h5IHdlIGFyZSBzZW5kaW5nIHRo
ZSBldmVudD8KPj4+Cj4+IFlvdSBtZWFuLCB3aHkgc2VuZGluZyBLT0JKX0NIQU5HRSBhbmQgbm90
IEtPQkpfQUREPwo+IAo+IE1heWJlIHRoYXQgdG8sIGJ1dCBtb3N0IGltcG9ydGFudGx5IHdoeSB3
ZSBhcmUgc2VuZGluZyBhbiBldmVudCBoZXJlLgo+IApBaC4gQSBjb21tZW50IGluIHRoZSBjb2Rl
LCB5b3UgbWVhbi4KT2YgY291cnNlLCB3aWxsIGRvLgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
