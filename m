Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5765BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 05:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9zSaPciRCpiv/xQYeO4hUNPBcoEshe/eajOHecf8ojs=; b=X41lGrtBnEkyEQNr7NiN+APmMR
	ZKpVwD0I2YiKTYx0tqVgP1n5zBHjdNSlLun0/VRvdZx12UQs8HzQOefwpuiIDAm11eaGQFDHrx7YQ
	zKfGv9sfJ9HSVedT2qdYJc/LnI8ylm4Ns/OxNUSjMHF4e5aNZkU5DOjNxoFQS4tQH38ipXb/ieQe0
	ovSX1n9NbBjGaCB+Ip1f/kKPDkX3IjWcvuzEzMptyLSvaFjSAHBjG4bzYHsgFIh9UxVaKZAUmXvHj
	/xB7hYxsBY/PXeFX3c5n72Z38hGGQN6b9LV/Cd81j/Nl2j29vOlhIXsiJkbfwPqHGzeQvXYHqItwX
	+b7cdzbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrC8P-00HE93-Vc; Wed, 18 May 2022 05:22:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrC8N-00HE6n-Or
 for linux-nvme@bombadil.infradead.org; Wed, 18 May 2022 05:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=9zSaPciRCpiv/xQYeO4hUNPBcoEshe/eajOHecf8ojs=; b=dTOE6lgUFAxiXZ8vauK3TGnJbX
 GFVPOB7v7VdupgFP+YQhDD6w7BEgMc8BE8/JAByplMNCBFMlovY+aNvEPYi5LbSZtczykxOWPhNQZ
 Q7t+9/kkHqxzNuadwCnQTFUOVS9ELd2GPOLWBGxQ0sYkfCJEURPBXqQE5bd8RmvOOgM8nErd8mHcJ
 b7L4Njbg5WtKtH9V7cXdsTIMO2VY7ahLftHR4vz/9Qz7eIPPSzEnfwPuQvATQ6egYma/iLO/nrJ2I
 TF+k76uNt6njjuBS65s0OweJX+kFvguwEOifaaf26AcTx65m6vhQxD24e91amwhvfW82UCy2OKo4g
 nRJrzJGw==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrC8F-00BSuL-JJ; Wed, 18 May 2022 05:21:59 +0000
Message-ID: <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
Date: Tue, 17 May 2022 22:21:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20220517194118.2caa01b8@canb.auug.org.au>
 <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
 <20220518045704.GA30131@lst.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220518045704.GA30131@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 5/17/22 21:57, Christoph Hellwig wrote:
> The patch that adds nvme_fc_io_getuuid need something like this
> folded in:
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index a11c69e681180..3c778bb0c2944 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>  	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
>  	struct request *rq = op->rq;
>  
> -	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
> +	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
> +		return NULL;
> +	return blkcg_get_fc_appid(rq->bio);
>  }
>  EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>  

Thanks. You can add

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

to the patch.

-- 
~Randy

