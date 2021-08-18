Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5CC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 08:03:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CED60F39
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 08:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41CED60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LlrQE+UmlSik/32gBvKLpDGoY2/hrKw5SsfR7V3pH8Y=; b=BMdVmNFuCQARl/
	oBZT85za95zjSQ8pRs9DEBF3MIVX191A3TV3jSmZ2tEKVv+XmHRECBJkTLOE0UL1+xgYe1iIunRhz
	86JGUwt6PE65CjEhXAoTOLv3bWiY+71/k0m5rc81BzEkAAaeaMsTmUwfX0xZ69Kh4BEvrs/vVdiV0
	xTG+2dtUD+I4lSmYKUNvVh6wddR/8YHxco4TmchW8Xz9cYmzYG6Zd4PyTCYQBBHCahIZLcb68jwNE
	yeFpuvZX16rHgmKb1tdEQNyzetrGSCUPP0IUEXCscNi8wux3Ay3bpVbDaqe+ExifQ529lcScAjyj+
	bffqOEViuQleSTNwqpvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGGXX-004ZCo-7l; Wed, 18 Aug 2021 08:03:11 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGGXT-004ZCF-On
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 08:03:09 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqKzn3C3lzbfSc;
 Wed, 18 Aug 2021 15:59:17 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 16:03:01 +0800
Received: from [10.169.63.14] (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 18 Aug
 2021 16:03:01 +0800
Message-ID: <3ec5e6fa-913b-b674-830d-a9f24c76f93e@huawei.com>
Date: Wed, 18 Aug 2021 16:03:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH nvme-cli 0/3] nvme-cli/plugins/huawei: display the status
 of each disk
To: Keith Busch <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sunao.sun@huawei.com>,
 <liuzhouhua@huawei.com>, <lengchao@huawei.com>, <jiangtao62@huawei.com>
References: <20210817150715.1173-1-chengjike.cheng@huawei.com>
 <20210817161400.GB223727@dhcp-10-100-145-180.wdc.com>
From: "Chengjike (ISSP)" <chengjike.cheng@huawei.com>
In-Reply-To: <20210817161400.GB223727@dhcp-10-100-145-180.wdc.com>
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_010308_095935_420CFAD8 
X-CRM114-Status: UNSURE (   7.47  )
X-CRM114-Notice: Please train this message.
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

T2ssIEkgd2lsbCBsYXRlciBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggdG8gYWRkIHRoaXMgZmVhdHVy
ZSB0byB0aGUgIm52bWUgCmxpc3QiIGNvbW1hbmQuCgrlnKggMjAyMS84LzE4IDA6MTQsIEtlaXRo
IEJ1c2NoIOWGmemBkzoKPiBPbiBUdWUsIEF1ZyAxNywgMjAyMSBhdCAxMTowNzoxMlBNICswODAw
LCBjaGVuZ2ppa2Ugd3JvdGU6Cj4+IEhpLCBJJ2QgbGlrZSB0byBkaXNwbGF5IHRoZSBjdXJyZW50
IHN0YXR1cyBvZiBlYWNoIGRpc2sgd2hlbiBJIGV4ZWN1dGUgdGhlIGNvbW1hbmQgIm52bWUgaHVh
d2VpIGxpc3QiLgo+PiBUd28gYnVncyB3ZXJlIGFsc28gZml4ZWQgaW4gb3JkZXIgdG8gYmUgYWJs
ZSB0byBkaXNwbGF5IHN0YXR1cy4KPiBUaGVyZSBpcyBub3RoaW5nIGh1YXdlaSBzcGVjaWZpYyBh
Ym91dCBhbnkgb2YgdGhpcywgY2FuJ3Qgd2UganVzdCBtYWtlCj4gdGhlIGdlbmVyaWMgbGlzdCBj
b21tYW5kcyBkaXNwbGF5IHRoaXMga2luZCBvZiBzdHVmZj8KPiAuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApM
aW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
