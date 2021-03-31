Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CECC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:24:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EFE61041
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EFE61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ylBh+kXc6wi1onNvUWHAyoYe9DY8JcNWm86EODtIWV4=; b=SzGTLZ2bl0uMml2R+zxb3hm2R
	zJpoVGgF0hB6XTFaUYa1tGoGeDAVA6lRHVy5oxjTXZ9Oy5ZrwgBf0WN32x0virBt9GKdC48L1uH4q
	VQIeG0m5+xekjDNJ03+Z8geO68e1/SYssca08j+BbFfrp8zT51ZeowEf4uhmjO8rn7wxEdh6Vq2j6
	tcsSQf8yQUDusAH3djXfIIhqeaQOHeLGXO2HFqH4Pq0Zm2McTrQgpAxN0+wgQMktKtant9P8FUsWv
	/QB3f3PSy3YkVfD6kjDHvagq/3d7eyf3/U8O3KiOZrSiT/4bAqajjl5KgJGkolh2W0JiUl1OG9Tf2
	9HyVFo/QA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRiJY-007e9e-66; Wed, 31 Mar 2021 21:23:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRiJS-007e7g-Qj
 for Linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 21:23:46 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0517661073;
 Wed, 31 Mar 2021 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617225821;
 bh=Uu7o3W/FkBsD+iaYZYR5IpiudApV+9pyOFyI4OSaS6U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aYZ1V6zDSVZaXT6T7NPRVt7Flm67TwKYL/fIPWL3XS13nyvR3AQDiIe2dgXEwnZKV
 PZZ8ZekBz+iVENqUqXmnHYFYkKRkoB84miPQ2TdzyYutFzzeP5Vg+hic2QH9f0hjng
 tqaegfrSYSMv+WASmPyktLEMPvpfARWBMuBmnOWmRhOg4cGF935sSndVNNkmOg22Tb
 zbpeF0aO/2uPmOxrayFdJ/PCc1SNh6dwPLGWhSy7esBmFRp/yTuk35TNe/u53BIYyF
 Pi5V8yy2FrA3X3xdrZcu1X30nZGBjWNBMIGmmmbaSAniz1Ei7YCNME00Ctm+GwLDFx
 UyXtGZh0dZsdQ==
Date: Thu, 1 Apr 2021 06:23:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kallol Biswas <kallol@nucleodyne.com>
Cc: Linux-nvme@lists.infradead.org
Subject: Re: nvme bug?? -- clearing extra memory
Message-ID: <20210331212335.GE23886@redsun51.ssa.fujisawa.hgst.com>
References: <CAH=XD5-iHBJiyqp7M-6Pr3XwGJn33Q5nBX920ZV6PP4RYmaqrg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAH=XD5-iHBJiyqp7M-6Pr3XwGJn33Q5nBX920ZV6PP4RYmaqrg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_222345_057612_22151AD9 
X-CRM114-Status: UNSURE (   9.42  )
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

On Wed, Mar 31, 2021 at 12:39:42PM -0700, Kallol Biswas wrote:
> Hi,
>    I have come across the following lines in the 5.8.0 nvme driver code.
> 
> drivers/nvme/host/pci.c
> 
> iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
> if (!iod->sg)
>        return BLK_STS_RESOURCE;
> sg_init_table(iod->sg, blk_nr_phys_segments(req));
> 
> ----------------------------------
> void sg_init_table(struct scatterlist *sgl, unsigned int nents)
> {
>      memset(sgl, 0, sizeof(*sgl) * nents);
> .........................................
> 
> Question: mempool_alloc will allocate a single sg entry, and then if
> blk_nr_phys_segmets() is > 1, then we will clear more memory area than
> intended.
> 
> Is my understanding correct?

The size from this mempool is set by nvme_pci_iod_alloc_size(), which is
larger than one sg entry.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
