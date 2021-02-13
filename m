Return-Path: <SRS0=EhmY=HP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7605C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 08:46:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C85564E00
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 08:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85564E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xRbMlu+w9WU0e4NO9gW4huR/Sour/erW//rIfIr3XVI=; b=gguEiGv6TiTA46ImY87PDZ3M6
	JqGGsc/Jwl9IwcMZhorqinkK8ePodIU+FE5FxD28avdm82enY8rgeTbEYzC1/ONlHDdfVe/YOSuLQ
	0QgkZonmK82uE5swJQrEIfz10kSOWFn+PyLozQz2r7eSDgkn6IzirJ/y+QSlV0cTKj9uw3FtSvRGO
	jjsRg0L+k4ytOEfFymEWk4ZVa33OsO2GuIEOpKH6uIuAddN64ZnlmTM6d/tXRDLm00QovOycgBjsx
	1/e1qWNo9+TKlMNG7cTNxpudC3Icwn7PnhJr3TDXQwKC1gmngEATby0xXY5JH+POC0wCbOcCLk4H9
	6UBl+W7BA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAqZi-0005Ky-Nn; Sat, 13 Feb 2021 08:46:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAqZg-0005KX-Gy
 for linux-nvme@lists.infradead.org; Sat, 13 Feb 2021 08:46:45 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8ECD7AC32;
 Sat, 13 Feb 2021 08:46:42 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
Date: Sat, 13 Feb 2021 09:46:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210213_034644_718376_F35AE667 
X-CRM114-Status: GOOD (  16.73  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xMi8yMSAxMDo0OSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiAKPj4+PiBibGtfbXFf
dGFnX3RvX3JxKCkgd2lsbCBhbHdheXMgcmV0dXJuIGEgcmVxdWVzdCBpZiB0aGUgY29tbWFuZF9p
ZCBpcwo+Pj4+IGluIHRoZSB2YWxpZCByYW5nZS4gQ2hlY2sgaWYgdGhlIHJlcXVlc3QgaGFzIGJl
ZW4gc3RhcnRlZC4gSWYgd2UKPj4+PiBibGluZGx5IHByb2Nlc3MgdGhlIHJlcXVlc3Qgd2UgbWln
aHQgZG91YmxlIGNvbXBsZXRlIGEgcmVxdWVzdCB3aGljaAo+Pj4+IGNhbiBiZSBmYXRhbC4KPj4+
Cj4+PiBIb3cgZGlkIHlvdSBnZXQgdG8gdGhpcyBvbmU/IGRpZCB0aGUgY29udHJvbGxlciBzZW5k
IGEgY29tcGxldGlvbiBmb3IKPj4+IGEgY29tcGxldGVkL2JvZ3VzIHJlcXVlc3Q/Cj4+Cj4+IElm
IHRoYXQgaXMgdGhlIGNhc2UsIHRoZW4gdGhhdCBtdXN0IG1lYW4gaXQncyBwb3NzaWJsZSB0aGUg
ZHJpdmVyIGNvdWxkCj4+IGhhdmUgc3RhcnRlZCB0aGUgY29tbWFuZCBpZCBqdXN0IGJlZm9yZSB0
aGUgYm9ndXMgY29tcGxldGlvbiBjaGVjay4gRGF0YQo+PiBpb3JydXB0aW9uLCByaWdodD8KPiAK
PiBZZXMsIHdoaWNoIGlzIHdoeSBJIGRvbid0IHRoaW5rIHRoaXMgY2hlY2sgaXMgdmVyeSB1c2Vm
dWwuLgoKSSBhY3R1YWxseSB2aWV3IHRoYXQgYXMgYSB2YWxpZCBwcm90ZWN0aW9uIGFnYWluc3Qg
c3Bvb2ZlZCBmcmFtZXMuCldpdGhvdXQgaXQgaXQncyBlYXN5IHRvIGNyYXNoIHRoZSBtYWNoaW5l
IGJ5IGluamVjdGluZyBmYWtlIGNvbXBsZXRpb25zIAp3aXRoIHJhbmRvbSBjb21tYW5kIGlkcy4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
