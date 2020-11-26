Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC6C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 12:58:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A597621D46
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 12:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWpTbjux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A597621D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yllb9FwkaieNAwb3E7diJXvwgJOHYk1qkkAS2UkrzOc=; b=CWpTbjuxxcbSzQ5oV/I+T9pK8
	baZZiBwlD9d8fUj9U+3k5ayqQADH9HWRQScReedi2XSuWvpUOULgqr69dpS2aU1WaseSWqc287lfV
	QreWrLChICEOkqBL4uQY+dNgsfzlgqAJLjYJUHj28lGpgTeBwil0Kpl5CXW6cy1nfpGz/FQR9OZad
	nUEc16t46cxit0Bf6fovutzUXubj6X0ybZA43fiylhmLjGrirxroqISjMZ0MdxoxbGf2F2CH9SyVr
	bvqxgEa5sFgS4kGXULf/qB8OiK0AMLQxhLs6gp539pN0w7iKgT2IIH42JCycLQqhU4IQlRbZeboL2
	CRWZQwkUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiGqu-0006wG-8t; Thu, 26 Nov 2020 12:58:24 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiGqp-0006vS-Qi
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 12:58:22 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 26 Nov 2020 04:58:14 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9]) by
 SJSMAIL01.us.kioxia.com ([fe80::f5d9:1f19:c784:d6e9%4]) with mapi id
 15.01.1779.007; Thu, 26 Nov 2020 04:58:14 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v11] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH v11] nvme-fabrics: reject I/O to offline device
Thread-Index: AdbCkIGB3lxzt72fRXqZWcxyhS93BABSQqYAAAA0KAAABjVl4A==
Date: Thu, 26 Nov 2020 12:58:14 +0000
Message-ID: <3c71869dd01d46ac8c47780ccbfab043@kioxia.com>
References: <bf6b3ed97dec401ab9ba9626d7764ab1@kioxia.com>
 <4cfe3787-659c-8300-609a-d6cb2901e04e@huawei.com>
 <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
In-Reply-To: <a9a2b522-2417-f751-8520-9baa88c2338d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_075819_969827_B4622721 
X-CRM114-Status: UNSURE (   8.61  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, "Ewan D.
 Milne" <emilne@redhat.com>, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> > Looks good. It might be better to add fast_io_fail_tmo to
> > nvme_dev_attrs so that it can be viewed and modified dynamically.
> 
> I thought it was added, I recall asking this in the past...

Do we want fast_io_fail_tmo to be only visible or modified dynamically too?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
