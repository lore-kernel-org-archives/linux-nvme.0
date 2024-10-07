Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE96CFB443
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 06:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QQernF8bsktnXckcY/8C7dkqTBVch8ft0pWEMh6TmRU=; b=fkQ6lpH0Vrl/djDGyO8dcXQxwI
	acobNdqbKV87cJzzB42geJgZt6hVy1xoSePl1dYJWHTiWvteeMtOBGXGleHaBDHKJJ6MvTVPdVozp
	/zgGkmouQxEasPwqGa4Qa0a30EWEq68vGGXgN3kN8vJs0QjTtSEHHY705/15Ui4lVnQmed+1EcPjf
	MGK46k8vkXZHev8XrAV9qppACAlYM+lzA/kDVelan+ke/hKS5+PfxAYJ+1DAw4Dnd8o8rvb5WcB0e
	zfkAHD+g9Ue1sqWG1WdH4NkB5pdIfLGxQVTxsmODhMGSufX5iFEsdf8URdDphzp7RJ0heeGDrfesA
	+9BP5A+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhRC-00000001TLy-3dwL;
	Mon, 07 Oct 2024 06:41:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhMe-00000001SrY-39ma
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 06:37:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E059227A8E; Mon,  7 Oct 2024 08:36:59 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:36:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kch@nvidia.com,
	d.bogdanov@yadro.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
Message-ID: <20241007063659.GA1112@lst.de>
References: <20240929031410.31281-1-kanie@linux.alibaba.com> <20240929031410.31281-2-kanie@linux.alibaba.com> <20241002080943.GA21262@lst.de> <3fedef45-0714-4d5e-b256-60c5b7a65914@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fedef45-0714-4d5e-b256-60c5b7a65914@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_233705_077677_CE6F3515 
X-CRM114-Status: GOOD (  11.09  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Oct 05, 2024 at 11:09:20PM +0800, Guixin Liu wrote:
>>> +struct nvmet_pr_register_data {
>>> +	__le64	crkey;
>>> +	__le64	nrkey;
>>> +};
>>> +
>>> +struct nvmet_pr_acquire_data {
>>> +	__le64	crkey;
>>> +	__le64	prkey;
>>> +};
>>> +
>>> +struct nvmet_pr_release_data {
>>> +	__le64	crkey;
>>> +};
>> Using little endian fields for purely in-memory data feels strange.
>> Is there a good reason for this?
>>
> I use nvmet_copy_from_sgl to obtain the command's detail, just like
>
> nvme_dsm_range, maybe I can put them in to include/linux/nvme.h.

Ah right, you just store the on the wire format locally.  Yes,
pleaﬂe ad them to nvme.h.


