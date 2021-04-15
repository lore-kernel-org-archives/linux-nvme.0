Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D4AC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:12:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD259610FC
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD259610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5Ey9U8QA8xKppYzP4ru60ejc2QO6V4AG1Y8IH4nHSbw=; b=jzJsw7x2QWej9ixiw4wEk+qQS
	CRQRJJKcYQucPaXfbZc+PoDk6PsiIfp2gupcpwJRXsKbWiFYyES6hVnFJl4Bv0Xra0lujmS5evxff
	Br6pIUx1wHPpFGDLCA63INy7PTxvWCDa89RNQBvvh8oudKaHirY8w8PIS6erVXHMJHK8cfsqClcQk
	OhjcCbduow4SNyuE7TyON5qMomQmVbboN1a1X46uazjXSXEq7ipPJq0TsLYR8phLaITJR0+IOoFjn
	1n8Vu9HzY5GpgT9M/a+oyxrfL2iJ0/8y8yDyqioABLxJbUGpU79prQ0KFwhGO2V790hF36amJMtxS
	aucz+EIJQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXAD1-00HUjK-LV; Thu, 15 Apr 2021 22:11:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXACv-00HUj4-94
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 22:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+qEP7shkxlYhat8wHFvJqU4G4YBDmHNetKlfJDQbcXE=; b=PDZmT1mXoShnCl54MrPJLbwQBG
 09qSey8FGGHf6WDpBegoSE/HvHEpjvUYL03GagyjT6QUm1AB0uCyZxDAflCYs4f735aWlJfcUGh7o
 jKrCVnZySNZc8WvRIMQlX5+MOhZLI1YAY2wFziPTRKRkYX21bMFSAWwLJz6AYfqxbAPM2UBnBWGFT
 P0OgKnQvBIIDrXr3NpUQhFYKB7jEYHT9PyIE5dUl1ChhWjauH7N1mzV5aZ+088XC9zPixAjrts9aS
 MeVo8qeBC2NPfKVF7AXgl3OyMBfwgeIkPcz7vNzwiPOtTiC2N8nXf6EHpJ18d0QEjrTq9iTpVUPUf
 dR8MOiHg==;
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXACs-008vEy-CK
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 22:11:27 +0000
Received: by mail-ot1-x335.google.com with SMTP id
 k14-20020a9d7dce0000b02901b866632f29so24025058otn.1
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purestorage.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+qEP7shkxlYhat8wHFvJqU4G4YBDmHNetKlfJDQbcXE=;
 b=mbGjMHsIyFXXOY0bx879lbGKY5VynHa5sTAroSbZI48P+zp1S0nimC75LjeJlKKFex
 bKdS2g3LXoGgnRqs4ypK80XlLljEnxJOL2jzYW2+fRNZV/Ojv5s/R7WEjHtstWBub1z1
 rV9VVQ1PF47uawDi1VZUIimodiytzXudB1zAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+qEP7shkxlYhat8wHFvJqU4G4YBDmHNetKlfJDQbcXE=;
 b=KoMkBioZTxpfpjeypowqgZOCDZbSkEBQbVJj2pta3cGFv2YoqcgAoJQqSoKuWa1dsX
 MMbK6xqTVAdt36LoOlV0VxqCpXfNA4q8GR9NuGmEjxWTBvu1vwi7aUpTBmQNwIMPdBlt
 ObnnH7W5ATX7iveXUgaNmpwBB/y7YH42Fho/QcK8XbQ/1lPLiUXxoGm2nDo6zKIvlAaG
 JDUjG/QTbn5N7/xP0Mnnk2/mcNHETHDyPfuxdUrErJGbV6fZy7snyZloEcXyRo8TmB2s
 niSse5XH5HrmTvCoNMjS88VEM9xs9ro3LWj7r+He4dfMcjlVGW8sOw/4y6C4F4Fr5jzE
 e4Kg==
X-Gm-Message-State: AOAM532KDY6UroNfg/yNJJp6JpZkFlja99NHicwxrQszb6F8XNqcKBui
 OQ/A2pHOb/avZqxYg31FtkD+ENXQoXt/qS7CIpnbvQ==
X-Google-Smtp-Source: ABdhPJwSX1iThNaIt/njGUMI3k7dAuMxChgDu2DUW5q+v2OA4+kmOBNSNfqpZeYTQq8PWkiV8n19g7S6vduAJAgPMX8=
X-Received: by 2002:a9d:7a53:: with SMTP id z19mr1094433otm.40.1618524684670; 
 Thu, 15 Apr 2021 15:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210414170833.24929-1-yzhong@purestorage.com>
 <20210415193030.GA2452080@dhcp-10-100-145-180.wdc.com>
 <20210415201726.GB2452080@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210415201726.GB2452080@dhcp-10-100-145-180.wdc.com>
From: Yuanyuan Zhong <yzhong@purestorage.com>
Date: Thu, 15 Apr 2021 15:11:13 -0700
Message-ID: <CA+AMecHdnFg73z8LkjTDzT-5y0dcApV9X-vJ9cDRMGBhkNrNtw@mail.gmail.com>
Subject: Re: [PATCH v2] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya.Kulkarni@wdc.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me, 
 linux-nvme@lists.infradead.org, Casey Chen <cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_151126_534145_A0E885D3 
X-CRM114-Status: GOOD (  10.50  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> > It doesn't look like these types of errors are unique to nvme. Could we
> > not just have blk_execute_rq() return an error instead?
Looking at history of commit b7819b925918 ("block: remove the blk_execute_rq
return value") and commit be549d491154 ("scsi: core: set result when the
command cannot be dispatched"), it seems scsi code no longer have issue.

> -extern void blk_execute_rq(struct gendisk *, struct request *, int);
> +extern int blk_execute_rq(struct gendisk *, struct request *, int);
Changing blk_execute_rq() prototype needs tree-wide callers update.
While it could be a fix, I'd wait for maintainers to chime in.

I don't quite like initializing the status for every nvme command. However for
such a long standing bug across multiple stable releases, I think it will be an
easy backport for stable-tree.

--
Regards,
Yuanyuan Zhong

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
