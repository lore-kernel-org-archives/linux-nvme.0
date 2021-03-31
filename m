Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5758AC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:40:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C924E6100C
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 19:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C924E6100C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nucleodyne.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:MIME-Version:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=dC4bhHuZnxWUIcbFwK5XU9rGSn2oKzWBsjPupoK46hM=; b=CIygUS1k2AHXd9
	mSuEb8mPeQLkkUCh0/iAf0kthPTGMPJ/0xsZtQiGyqQ0716KshaTDl/yKZhT7XfCBPURWAgxp4NYK
	HFdpmM2g80AajYWVbgXz91Pr6SXfLclGj+EaUO/X8CDH/18aRIxVC/ae2OaJJ7No4xDSXwN8Un9/A
	kYOmSsKP0kRqiyy0AnRYv6I+UBh8+zan0hHK8Ki5hMkI3DgBxOAlmt1Tgk4fOjsHM8orJI8OQFolv
	3jxcfEaNQX0Xsph6tY9X7xrkJcke/WKknJavm151xTjoTzBMIvMidcrCpW+Cr91PIzJfedHMNBbz4
	+llGLYbt+8QaVesdiw9g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRgh4-007OFZ-V2; Wed, 31 Mar 2021 19:39:59 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRgh1-007OEr-H6
 for Linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 19:39:57 +0000
Received: by mail-pf1-f180.google.com with SMTP id x26so15347599pfn.0
 for <Linux-nvme@lists.infradead.org>; Wed, 31 Mar 2021 12:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GZp6agdSbgb9HuJg5h8+FoOd3TMeNnp0tBQknd/W2Xg=;
 b=QUanz2Ly45LZZpWiJpBcW9k5c0ZYoXCO6BWEJK4c3/lXwWV3vGECXiCZz5DY8htbQZ
 eIcbdtEbTxjhXkIfyw4v/OmIBZsofbx7i4jqrCDrxUFBcwRGjZSEugJfhX4Gj8SDTMx0
 cH3JHXGHJ0qrSxH6NsfgjVJbjpzQ2l0mFc1ONUGq8HvVSHUu0oZj7cqPdYsgRVNM9OJg
 Az54HreMwjdkdruDwZuEp5EwTRKa0s8b9Q3uFopGy4Mm4KiTKVtYhobC5RZDayFhYCNv
 Ce3swfgWWX3EetLFOi2t+ZvKnbkPijFXpqCW6yjlncScwJFhvZKYEGvPdnLUY54cPOAj
 6kdw==
X-Gm-Message-State: AOAM532+Nxlqakg34uQ8/dkJE0jZfaTSZF7ivn2oJ+ASOv4EqlkaM/2i
 Qo0SlHjc8ssFo/VtS7SIs+Z+1Z4+c2w249x9+hoHwsJWIfTOvg==
X-Google-Smtp-Source: ABdhPJyqqau8X9eMBOmuW2S14CR6mq5cNvgcl7JZfUALp96IbXadQdHttlvBedcYe11HFoDIrItK0ee7psr2sgDmr80=
X-Received: by 2002:a65:4006:: with SMTP id f6mr4602671pgp.108.1617219592562; 
 Wed, 31 Mar 2021 12:39:52 -0700 (PDT)
MIME-Version: 1.0
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Wed, 31 Mar 2021 12:39:42 -0700
Message-ID: <CAH=XD5-iHBJiyqp7M-6Pr3XwGJn33Q5nBX920ZV6PP4RYmaqrg@mail.gmail.com>
Subject: nvme bug?? -- clearing extra memory
To: Linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_203955_633776_7D627822 
X-CRM114-Status: UNSURE (   4.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,
   I have come across the following lines in the 5.8.0 nvme driver code.

drivers/nvme/host/pci.c

iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
if (!iod->sg)
       return BLK_STS_RESOURCE;
sg_init_table(iod->sg, blk_nr_phys_segments(req));

----------------------------------
void sg_init_table(struct scatterlist *sgl, unsigned int nents)
{
     memset(sgl, 0, sizeof(*sgl) * nents);
.........................................

Question: mempool_alloc will allocate a single sg entry, and then if
blk_nr_phys_segmets() is > 1, then we will clear more memory area than
intended.

Is my understanding correct?

-- 
------
Kallol Biswas
Phone: 408-718-8164 (c)
Phone: 408-725-7527 (o)
NucleoDyne Systems, Inc.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
