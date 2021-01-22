Return-Path: <SRS0=yPeo=GZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4923CC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:46:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EC722B43
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jan 2021 01:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EC722B43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wlbLXbgChM7MfsFJKl/FWL8UYcu3mATkveRoo0cPvEA=; b=aah3AeIsSeshVCvCblLAV162+
	GxhwCCERWki6aC/oH1cjuHSVxcRbAetPdpeCdzkAQYXRKQaxO7Na4jNiLuqTEwv4i8V2RKT8b/MJi
	wzNUwktvPW+8yWB/2emch64BiTvsPiwzWq71oaNTgj2UPJ/WfWx7obqHxMNkHStuBwVtZmWw4voqZ
	98xLEz7u3YRNgK+X9zm8reXbZx6OiAecWhTxdencJHhjbYGF8M8pv5j+odULddqRU++jCRxSU1Wkg
	0qJcpf9cUph+ICLBQReFz6ACU3uCWyA8dLbB8ULfIjKWjqA2e3ZYnNamnWDGr+IBDz456kB0bPsr8
	MVbZG2QoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2lWm-0002pW-In; Fri, 22 Jan 2021 01:46:20 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2lWk-0002ox-FB
 for linux-nvme@lists.infradead.org; Fri, 22 Jan 2021 01:46:19 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMMXB4Q27zR666;
 Fri, 22 Jan 2021 09:45:14 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 09:46:16 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Fri, 22
 Jan 2021 09:46:15 +0800
Subject: Re: [PATCH v3 1/5] blk-mq: introduce blk_mq_set_request_complete
To: Christoph Hellwig <hch@lst.de>
References: <20210121070330.19701-1-lengchao@huawei.com>
 <20210121070330.19701-2-lengchao@huawei.com> <20210121084059.GA25963@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e053944e-e8de-187e-78f2-21974fb97dbf@huawei.com>
Date: Fri, 22 Jan 2021 09:46:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210121084059.GA25963@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_204618_755904_817BA304 
X-CRM114-Status: GOOD (  13.20  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIxLzEvMjEgMTY6NDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFRodSwg
SmFuIDIxLCAyMDIxIGF0IDAzOjAzOjI2UE0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4gbnZt
ZSBkcml2ZXJzIG5lZWQgdG8gc2V0IHRoZSBzdGF0ZSBvZiByZXF1ZXN0IHRvIE1RX1JRX0NPTVBM
RVRFIHdoZW4KPj4gZGlyZWN0bHkgY29tcGxldGUgcmVxdWVzdCBpbiBxdWV1ZV9ycS4KPj4gU28g
YWRkIGJsa19tcV9zZXRfcmVxdWVzdF9jb21wbGV0ZS4KPiAKPiBTbyBJJ20gbm90IGhhcHB5IHdp
dGggdGhpcyBoZWxwZXIuICBJdCBzaG91bGQgYXQgbGVhc3Q6Cj4gCj4gICBhKSBiZSBuYW1lZCBh
bmQgZG9jdW1lbnRlZCB0byBvbmx5IGFwcGx5IGZvciB0aGUgLT5xdWV1ZV9ycSBmYdGWbHVyZSBj
YXNlCkFsdGhvdWdoIGJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZSBjYW4gc2V0IHRoZSBt
YXJrdXAgZGlyZWN0bHksCmJsa19tcV9jb21wbGV0ZV9yZXF1ZXN0X3JlbW90ZSBjYW4gYWxzbyB1
c2UgdGhpcyBoZWxwZXIuIFRoaXMgaGVscGVyIGRvCm5vdCBuZWVkIHNwZWNpYWwgcHJvY2Vzc2lu
ZyBmb3IgLT5xdWV1ZV9ycSBmYWlsdXJlLgo+ICAgYikgY2hlY2sgdGhhdCB0aGUgcmVxdWVzdCBp
cyBpbiBNUV9SUV9JRExFIHN0YXRlCk5vLCB0aGUgcmVxdWVzdCBtYXkgYWxzbyBiZSBpbiBNUV9S
UV9JTl9GTElHSFQgc3RhdGUuIERvIG5vdCBuZWVkIHRvCmNhcmUgd2hldGhlciB0aGUgb3JpZ2lu
YWwgc3RhdGUgaXMgTVFfUlFfSURMRSBvciBNUV9SUV9JTl9GTElHSFQuCj4gLgo+IAoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
