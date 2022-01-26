Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E486C28CF5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jan 2022 19:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EWM9h/DlHCcf4Tbkj1zrmVINIFQOaer4NcFwsZqmBGk=; b=di93tr0wMUyA+VCa9XBlRd5vV8
	ptD01WELpFlAgywWFRMMrclFQcEuvq1BepUSe4LKt7cYOy+G4zKbiDk+AE/DuRVt0zUyDqxEMkbOk
	R1wcYleBqX0QTIeaE4x8vVgCWZTW1sVPf62BAf56X3W2OuF6SAIdZe1rJcUYGE+6EtUEnjaJMO577
	prlE9ekdNEO8Q6NQq0elWNUSh9+PqTb4vtsk89THLsKKQ4DD/7NCcXhrIlZyHlfb1V1iNcOUe+lc+
	q5K+WM60rK0/7RKPaxIScYIrWa50UxqF4miZ7umvXagqaw7VzxrIitxoBpsf+N16lcxDwcr0ocHiL
	JAM3tRXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCo51-00DOab-EN; Wed, 26 Jan 2022 19:35:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCo4y-00DOa7-Ua
 for linux-nvme@lists.infradead.org; Wed, 26 Jan 2022 19:35:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C542D68AFE; Wed, 26 Jan 2022 20:35:35 +0100 (CET)
Date: Wed, 26 Jan 2022 20:35:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: Re: [PATCH V5 1/1] nvme: Add verbose error logging
Message-ID: <20220126193535.GA2011@lst.de>
References: <20220126183313.85877-1-alan.adamson@oracle.com>
 <20220126183313.85877-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126183313.85877-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_113541_187575_5BA0CAE5 
X-CRM114-Status: GOOD (  21.86  )
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

On Wed, Jan 26, 2022 at 10:33:13AM -0800, Alan Adamson wrote:
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -354,6 +354,9 @@ void nvme_complete_rq(struct request *req)
>  
>  	switch (nvme_decide_disposition(req)) {
>  	case COMPLETE:
> +		if (unlikely(nvme_req(req)->status != NVME_SC_SUCCESS))
> +			nvme_error_log(req);

nvme_log_error would seem a more natural name.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVM Express device driver verbose errors
> + * Copyright (c) 2021, Oracle and/or its affiliates
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */

No more new license boilerplates, please.  That's what we have the
SPDX tag for.


> +	[nvme_cmd_dsm] = "Deallocate (DSM)",

This should be "Dataset Management" as in the spec.

> +	if (ns) {
> +#ifdef CONFIG_NVME_VERBOSE_ERRORS
> +		if (nr->cmd->common.opcode < ARRAY_SIZE(nvme_ops) &&
> +		    nvme_ops[nr->cmd->common.opcode] != NULL)
> +			op_str = nvme_ops[nr->cmd->common.opcode];
> +		else
> +			op_str = "Unknown";
> +#endif

> +	} else {
> +#ifdef CONFIG_NVME_VERBOSE_ERRORS
> +		if (nr->cmd->common.opcode < ARRAY_SIZE(nvme_admin_ops) &&
> +		    nvme_admin_ops[nr->cmd->common.opcode] != NULL)
> +			admin_op_str = nvme_admin_ops[nr->cmd->common.opcode];
> +		else
> +			admin_op_str = "Unknown";
> +#endif

Can't we factor the ifdefs bits of code into little helpers that are
stubbed out if CONFIG_NVME_VERBOSE_ERRORS is not set?  That way the main
logging helper could stay in core.c, and we could have a pretty_print.c
with just the constants and these helpers.

> +extern void nvme_error_log(struct request *req);

No need for the extern.

