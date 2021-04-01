Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E9C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:17:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7F56108F
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7F56108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fqb/e1GSWuGOYM5qNMZEoaE52KiNojG7ljwCs1w0p/8=; b=d7G3wxLprT6oFk/Kz9uD1Aihw
	aXQxhb/8ofP02RgywmCiBacFTQxHlRTK1N8G0w87hVUR4j7EgdyM2IYVYFkG+byCfyKv4yT4UQVnw
	aTCFGYpLb7Vixm9J5ZGIW6/SpiPKfvf0QJSPqkXqzaPWJa/jLIUJT4e+k5ZWxsPh96jzITjpoqBBa
	FoqEiEY2zrmTjw4nsbsiEkuVhFSAfTGYRZFSgwG5OeC08H0x3HNf1OCgaYeMR27XrjgYqw9ABCYwi
	wrKUUnvRnvpyTEZLOu2l40OoOc8+kTnmGQ5FNSgEs+8tgdcjncUitUoYU08YNkEEgINC42zoRMgvU
	S3KKv6f6g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRtRf-0091Zo-3J; Thu, 01 Apr 2021 09:16:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRtRa-0091ZL-FO
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 09:16:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5295968B05; Thu,  1 Apr 2021 11:16:46 +0200 (CEST)
Date: Thu, 1 Apr 2021 11:16:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, Chaitanya.Kulkarni@wdc.com,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Message-ID: <20210401091645.GA2934@lst.de>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_101652_133343_E183D94C 
X-CRM114-Status: GOOD (  12.74  )
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

On Wed, Mar 31, 2021 at 08:48:05PM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power seting to resume from RTD3 for s2idle.

Looks like this is a generic PCIe-level quirk and should go into the
core drivers/pci/ quirk table, with NVMe just looking at the
quirk flag.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
