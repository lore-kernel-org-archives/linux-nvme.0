Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C304D3E78C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9P6IKPk43AAl/74p5ZHPPLxxf4UryRpFOolh5GKtUE=; b=2L6SAy5DucrTHl8qo0AeIWM6jU
	JaY237mwfQw2OvuFCR77sFet0r+AFGYlEgDVuxq71Xb6H0JyCw6no9HGUDO0zlOsh1ZE09zMakY33
	97faehipSzEmJA/Wy7V7ENQGEugbLIFOOuqs050KRvQ1cOd/ijep8E0hPau0eQCsOpA0TbKNIk0wV
	/84daso+lVb1keTkZHwlbeRrFxsDOexAoa6LNVCNdl1AHC5DpTW5H8b/5Z1yCCFy0RGmk3Gnd/CTA
	CnH/6M5sD70aRK9KchUra1KTc917fJxIS6bfi0NRUtYHpd1BfkG/CeC+xQjQXnMyaLqRt1giaNHUC
	fxaF5a8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Z0q-00000001udH-0wMr;
	Wed, 06 Nov 2024 05:55:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Z0m-00000001ucm-2X7A
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:55:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0935568AFE; Wed,  6 Nov 2024 06:55:21 +0100 (CET)
Date: Wed, 6 Nov 2024 06:55:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 07/11] nvmet: implement endurance groups
Message-ID: <20241106055520.GA31635@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174904.3612888-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_215524_830195_32BC5AE4 
X-CRM114-Status: GOOD (  14.40  )
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

On Tue, Nov 05, 2024 at 09:49:00AM -0800, Keith Busch wrote:
> +static void nvmet_execute_get_log_page_endgrp(struct nvmet_req *req)
> +{
> +	u64 host_reads, host_writes, data_units_read, data_units_written;
> +	struct nvme_endurance_group_log *log;
> +	u16 status;
> +
> +	req->cmd->common.nsid = cpu_to_le32((u32)
> +				le16_to_cpu(req->cmd->get_log_page.lsi));
> +	status = nvmet_req_find_ns(req);

I think this would be a good place to point out that we "emulate" one
endurance group per namespace, as the code only make sense with that
in mind.

As far as I can tell cpu_to_* does all the normal implicit integer
conversions, so the case here and the ones further down should not be
needed.

> +	host_reads = part_stat_read(req->ns->bdev, ios[READ]);
> +	data_units_read =
> +		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[READ]), 1000);
> +	host_writes = part_stat_read(req->ns->bdev, ios[WRITE]);
> +	data_units_written =
> +		DIV_ROUND_UP(part_stat_read(req->ns->bdev, sectors[WRITE]), 1000);

Overly long lines, but IMHO this would read nicer anyway if the
round is done later, e.g.:

	sectors_written = part_stat_read(req->ns->bdev, sectors[WRITE]);

	...

	put_unaligned_le64(DIV_ROUND_UP(sectors_written, 1000), &log->dur[0]);


> +	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
> +		if (ns->nsid <= min_endgid)
> +			continue;
> +
> +		list[i++] = cpu_to_le16((u16)ns->nsid);
> +		if (i == buf_size / sizeof(__le16))
> +			break;
> +	}

No really important, but this could use xas_for_each for avoid
doing a full lookup on every iteration.


