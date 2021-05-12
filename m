Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51975C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 05:25:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F726143A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 05:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F726143A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=It5qXmeyP4BSrHg9tKyo1I8DTl/Tp1KTy1IaoKml//k=; b=FWm8pAWXZOdG1L8a+cbgAa6Zn
	gKk3zuaqDECEPQH+gpn+29yZ+bjcIwEp5wuCZTwjXIWwemkRblrbddTAJZX42Asw6jfZTuQ7nBO3u
	Y8JmSrk3IteG8hed7lcBX/MccVEAMzl2LWJmgVL/NbNkPV3EaBtgLGSYo9NZlNAS9X5S+YI8U608S
	j/sgCc5BpWBfjNoPViOZ9+n4PkLvdTO2E6fQtoJknS9Q1AwyAT9x8Nz4ArQ1Gv48vygo411pWFvw6
	qU6a86P3FjcSzIWX5NEefw0SjuONw3XVfuzt/uBizQDhhpOsopZ4CSld4fk35G32joGG8oAxG8yPS
	0/VezaXwg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lghMh-0023n8-2x; Wed, 12 May 2021 05:24:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lghMe-0023mx-3y
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 05:24:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=oo/Vd5NTAQopEmBmiN3X9MQx1Mztcd1I9Wgq5z6s3c0=; b=e+riG5ZrYu5x3iZIn1NcPGS2LS
 0b2f3AUqZa0cfxsq0TuVsoKUSqSgeMWuYR3N6s3EXa1eEI/bqNjcPx2oV2DrzImTlvyn8iovM8Fhn
 TctOkQBY7x9i3it0xmq0a2jSzhTwiSbBlGxJwVDMDRw/LNpy9DJk87l4LXwEWsy+LOvyrWHSycHgw
 ZyHjVY5wvyZvcZxOpJXogmeONv3u8BLjU5bATJYSCwHPUM2pxjit3kGBI70uomuf4iT3tVRpODqhP
 5ihJIeKfJ/nDQ2s4JeCm/NXV95VVBTsDzrqetk7+lS6rRNHQIdZC2fV5/gP4bPjwhWO8aOgDHyzio
 vfwL2faA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lghMa-00A7IW-L3
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 05:24:53 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3C22BAF37;
 Wed, 12 May 2021 05:24:45 +0000 (UTC)
Subject: Re: [PATCHv2] nvme: generate uevent once a multipath namespace is
 operational again
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210511080308.6734-1-hare@suse.de>
 <20210511161907.GA17525@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7b01589e-3987-9573-ccd7-b599affed2a5@suse.de>
Date: Wed, 12 May 2021 07:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210511161907.GA17525@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210511_222452_853196_4F4AF6C7 
X-CRM114-Status: GOOD (  13.85  )
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

T24gNS8xMS8yMSA2OjE5IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBUdWUsIE1h
eSAxMSwgMjAyMSBhdCAxMDowMzowOEFNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IEluIGFuIGFsbCBwYXRocyBkb3duIHNjZW5hcmlvIEkvTyB3aWxsIGJlIHJlcXVldWVkIG9yIGFi
b3J0ZWQsIHNvIG5vCj4+IGZ1cnRoZXIgSS9PIHdpbGwgYmUgb25nb2luZyBvbiB0aGlzIG5hbWVz
cGFjZS4KPj4gVGhpcyBsZWF2ZXMgdXBwZXIgbGF5ZXJzIGxpa2UgTUQgdW5hYmxlIHRvIGRldGVy
bWluZSBpZiB0aGUgbmFtZXNwYWNlCj4+IGJlY29tZXMgb3BlcmF0aW9uYWwgYWdhaW4gYWZ0ZXIg
YSBzdWNjZXNzZnVsIGNvbnRyb2xsZXIgcmVzZXQuCj4+IFRoaXMgcGF0Y2ggd2lsbCBzZW5kIGFu
IHVldmVudCBwZXIgbXVsdGlwYXRoZWQgbmFtZXNwYWNlIG9uY2UgdGhlCj4+IHVuZGVybHlpbmcg
Y29udHJvbGxlciBpcyBMSVZFLCBhbGxvd2luZyBNRCB0byBzdGFydCByZXN5bmMuCj4gCj4gQ2Fu
IHlvdSBwbGVhc2UgYWxzbyBhZGQgYSBjb21tZW50IHdoeSB3ZSBhcmUgc2VuZGluZyB0aGUgZXZl
bnQ/Cj4gCllvdSBtZWFuLCB3aHkgc2VuZGluZyBLT0JKX0NIQU5HRSBhbmQgbm90IEtPQkpfQURE
PwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJI
LCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcp
LCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
