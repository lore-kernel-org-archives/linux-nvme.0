Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D68C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 08:57:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A706764E33
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 08:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A706764E33
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MqG+lYXY2/RkXn2i9AgoHb/PyaH8+Y7pmfmholkw3+E=; b=cMum1LputA19+zYqbHMChIWUc
	feL1w9gLyv5bPG9qUwHTrdWG4wrrI5ukzII8eQYW+e5zpRzkH/rdxtZoo+9DO1jQ3M7kZVrftIX/y
	v9B7p1bHOGVmvurjkYLuE2+4Heaus6stHDmAFAGtZmKtHhNii2RPnyvYPlAOr6uFGbhr09md1QcRh
	z4KURAXthI5Qmdoqkgi4QT0IbUwxcbHSTqxNGnB51GSt1wwyhlQZcQhg6aLfLd8CaKJ5SqLjtTkgT
	79RgCLx5nCJq+FX3iETlemvBifRToACdmLiF0VIxStxOQsYhTT7VMj4xCt8Wxp3KVf6UhhO3p8Gmu
	etlvxYOgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6V1U-0003TV-AH; Mon, 01 Feb 2021 08:57:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6V1R-0003T3-K5
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 08:57:26 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2A994AE42;
 Mon,  1 Feb 2021 08:57:23 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
 <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
 <ebb1d098-3ded-e592-4419-e905aabe824f@huawei.com>
 <675d3cf7-1ae8-adc5-b6d0-359fe10f6b23@grimberg.me>
 <59cd053e-46cb-0235-141f-4ce919c93f48@huawei.com>
 <65392653-6b03-9195-f686-5fe4b3290bd2@suse.de>
 <81b22bbf-4dd3-6161-e63a-9699690a4e4f@huawei.com>
 <715dd943-0587-be08-2840-e0948cf0bc62@suse.de>
 <eb131d8f-f009-42e7-105d-58b84060f0dd@huawei.com>
 <ac019690-7f02-d28c-ed58-bfc8c1d48879@suse.de>
 <6ceff3cb-c9e9-7e74-92f0-dd745987c943@huawei.com>
 <114751ac-1f7d-ce5e-12c5-7d6303bdb999@suse.de>
 <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <47a1b796-9d91-5947-4bac-dd8f397041a3@suse.de>
Date: Mon, 1 Feb 2021 09:57:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <aebc6c2d-4711-95ba-daf2-1cd17fc6f0e7@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_035725_775497_750673BA 
X-CRM114-Status: GOOD (  18.39  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMi8xLzIxIDk6NDcgQU0sIENoYW8gTGVuZyB3cm90ZToKPiAKPiAKPiBPbiAyMDIxLzIvMSAx
NToyOSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOlsgLi4gXQo+PiBVcmdoLiBQbGVhc2UsIG5vLiBU
aGF0IGlzIHdlbGwgaW1wb3NzaWJsZSB0byBkZWJ1Zy4KPj4gQ2FuIHlvdSBwbGVhc2Ugb3Blbi1j
b2RlIGl0IHRvIGRlbW9uc3RyYXRlIHdoZXJlIHRoZSBkaWZmZXJlbmNlIHRvIHRoZSAKPj4gY3Vy
cmVudCAoYW5kIG15IGZpeGVkKSB2ZXJzaW9ucyBpcz8KPj4gSSdtIHN0aWxsIG5vdCBjbGVhciB3
aGVyZSB0aGUgcHJvYmxlbSBpcyBvbmNlIHdlIGFwcGxpZWQgYm90aCBwYXRjaGVzLgo+IEZvciBl
eGFtcGxlIGFzc3VtZSB0aGUgbGlzdCBoYXMgdGhyZWUgcGF0aCwgYW5kIGFsbCBwYXRoIGlzIG5v
dCAKPiBOVk1FX0FOQV9PUFRJTUlaRUQ6Cj4gaGVhZC0+bmV4dCA9IG5zMTsKPiBuczEtPm5leHQg
PSBuczI7Cj4gbnMyLT5uZXh0ID0gaGVhZDsKPiBvbGQtPm5leHQgPSBuczI7Cj4gCkFuZCB0aGlz
IGlzIHdoZXJlIEkgaGF2ZSBpc3N1ZXMgd2l0aC4KV2hlcmUgZG9lcyAnb2xkJyBjb21lIGZyb20/
CkNsZWFybHkgaXQgd2FzIHBhcnQgb2YgdGhlIGxpc3QgYXQgb25lIHBvaW50OyBzbyB3aGF0IGhh
cHBlbmVkIHRvIGl0PwoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAg
ICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNv
bHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChB
RyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
