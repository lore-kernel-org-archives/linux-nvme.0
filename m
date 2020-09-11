Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D865C43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 06:03:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B2E20735
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 06:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0cDO/NZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B2E20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Sb4j8EAd246y3MIGhdnK2+lLwUI5rpJa6TfCF9jXd/U=; b=0cDO/NZV5C617fSeEDgE2Q//l
	k/Ha1lyAyhICl0fFGa8FnyABguP30XtbRBwRvKPqgBVk5IAvMjoefG8txFQYEbljNzqlmcBHFqtZT
	5qSj+4lMAazA/Tno2dLj/rNpwGE9O52kFpBKsZbRCYrKzA6jHB+pOf1sJf79B6SzTvBnVvZtmky+i
	9nXfQhLcU+J1aprLUQvMO0x9p5N2E6ZpOaYe+NOT7hw1AgOzUehxsH26kHhlapSfe/rSd0UH9dJMD
	Fd0GZ6zPy4sXiBSnzecYiWi1efpdXNY/Kk7nbXannD1Bs695WvQ5cu6WAHbB6Ya17L33cshWL5jkH
	x/bNZQLMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGc9m-0002mg-3Q; Fri, 11 Sep 2020 06:03:34 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGc9i-0002lt-DG
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 06:03:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 95412AB54;
 Fri, 11 Sep 2020 06:03:43 +0000 (UTC)
Subject: Re: [PATCH V5 1/4] block: use test_and_{clear|test}_bit to set/clear
 QUEUE_FLAG_QUIESCED
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <20200911024117.62480-2-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <18b0ac79-73bb-66c4-3a3b-2263f7cd6c24@suse.de>
Date: Fri, 11 Sep 2020 08:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911024117.62480-2-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_020330_556322_B9F9AD69 
X-CRM114-Status: GOOD (  19.74  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8xMS8yMCA0OjQxIEFNLCBNaW5nIExlaSB3cm90ZToKPiBQcmVwYXJlIGZvciByZXBsYWNp
bmcgc3JjdSB3aXRoIHBlcmNwdS1yZWZjb3VudCBmb3IgaW1wbGVtZW50aW5nIHF1ZXVlCj4gcXVp
ZXNjZS4KPiAKPiBUaGUgZm9sbG93aW5nIHBhdGNoIG5lZWRzIHRvIGF2b2lkIGR1cGxpY2F0ZWQg
cXVpZXNjZSBhY3Rpb24gZm9yCj4gQkxLX01RX0ZfQkxPQ0tJTkcsIHNvIHVzZSB0ZXN0X2FuZF97
Y2xlYXJ8dGVzdH1fYml0IHRvIHNldC9jbGVhcgo+IFFVRVVFX0ZMQUdfUVVJRVNDRUQuCj4gCj4g
U2lnbmVkLW9mZi1ieTogTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+Cj4gQ2M6IFNhZ2kg
R3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4gQ2M6IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFz
c2NoZUBhY20ub3JnPgo+IENjOiBKb2hhbm5lcyBUaHVtc2hpcm4gPEpvaGFubmVzLlRodW1zaGly
bkB3ZGMuY29tPgo+IENjOiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+Cj4gLS0tCj4g
ICBibG9jay9ibGstY29yZS5jIHwgMTMgKysrKysrKysrKysrKwo+ICAgYmxvY2svYmxrLW1xLmMg
ICB8IDExICsrKysrKysrLS0tCj4gICBibG9jay9ibGsuaCAgICAgIHwgIDIgKysKPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQt
Ynk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApE
ci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVj
dApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUz
IDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBO
w7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVs
aXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
