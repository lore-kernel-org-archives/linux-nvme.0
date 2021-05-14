Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE067C43460
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCB4600D3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 16:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCB4600D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jysw5Z+/FpQTfPtG2BbOxXxHysW4+yPeQg9a4uyxx+U=; b=e57QGpebT5gvCWPlFnlEVZPGo
	kl/8N9GpuWP/AFwERPjgBXDiSd3eguGQyUgC3iIm/GUE4FT3er25EsYdiROQ1NjT78ve0C1dqSqpT
	/tTGsNSZfuMCnxdAoIIs0wnF7fFVnpZaaeF9auvmhR3YiqRJeuMu3N3TFwNu35N0uCbjsdZLvNMiQ
	VVLJdlIt/nurpdtrosHXLZfkFRCZqTvk76orGMPZmrv3GnehPhf0gI7RyTgBEmyWJZh4MenWALagi
	j2m3MSa/oZgZ7C0OTLOCgNHLOQkXJNPz5Cow0Zz0SGzQuACY1vXTy/c59qlP0Ay1UUV5iqarePw1q
	C3bBKnl2g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhaUE-008SU9-Bb; Fri, 14 May 2021 16:16:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaTs-008SQE-Hl
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 16:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=E4eKfLLPwxlNLjuttUuI8VaOne71TO7fgDfREp6VqWo=; b=Q4xaj+MCJhlUTy3F8DjLU1k/Zr
 QhklBnC0R+37zjdqGdOutEHTqvT033tMycuh+1LKoyMl9n8zlihV0u7P8STUSokRzDBkiniH5xleH
 B7DsqFPDVy4KEKUkuZvvRpNh7AAu+q2hUHTapLZ76dBHMnBFN9re0BL5xX9czwOBHHvKG+7vbVVF2
 vFv7+/md6xGjR8e2s3MzQ/rgJON5CpZfrb5nB5Fqe+UMQzluqXnP+aMiIyA4ElDHaiam5r8AsVzlC
 ckUGbLaYQe06JJFeMkP/OxPnONnRx+Ov+AfQcqYmUMpMcvRKxkSKubOWqjifCeyhEmSfUEEym1iTf
 EPriSHjQ==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhaTq-00C6ag-5P
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 16:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=E4eKfLLPwxlNLjuttUuI8VaOne71TO7fgDfREp6VqWo=; b=sPRxOlEMD/ZVQ88LgoGLL9OjBW
 Wx0+B2uNVHava/VVSM9gB4FJtOz6aiI72TospMuM4DTR6YiCUjKsyUOFus7PH/19HYF72JItnGrXW
 vLLue47wtV1XdyCo9lXQkyk8vp82wx6TPOdDnUwXhjOophg0NxfdhWMpLuolM5ISe/FynxCSvGtSn
 JJsuJooWId8Qr8z3RExNK6gc34i19s93IGYSCWBOAxS9DTtnHVWXzpIfK9FdD6uCsHV5a5kGmOum/
 rXiAGakNoK/7PHlxa2iM/+f2Q+Ns8rzVCrKhqZN6zgA9a10xmb4hzYQ25BXQ/JHXfvK25hlMlmWo3
 CP907NSA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1lhaTZ-00066P-MN; Fri, 14 May 2021 10:15:46 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-9-logang@deltatee.com> <20210514135126.GB4715@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <241e7dad-8d38-9f0c-5e54-8b7df32b8bac@deltatee.com>
Date: Fri, 14 May 2021 10:15:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135126.GB4715@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 08/22] dma-mapping: Allow map_sg() ops to return
 negative error codes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_091602_232600_1C736F27 
X-CRM114-Status: GOOD (  10.94  )
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



On 2021-05-14 7:51 a.m., Christoph Hellwig wrote:
>> +int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>  		enum dma_data_direction dir, unsigned long attrs);
> 
> I don't think it makes sense to expose this __dma_map_sg_attrs helper.
> Just keep it static and move the sgtable helper to kernel/dma/mapping.c
> as well.

Makes sense. I'll fix this for v3.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
