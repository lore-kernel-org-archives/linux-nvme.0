Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B6BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aE0CYZkyAuDjFfhG04aA+oT3LKm72KjR6quqPptBowI=; b=WrM5cMSfQdpdV3y4Ays64Y13Nb
	Fley4QjNAscvMowaIzHDV4Th4oZhoG6GEoLKKABKbbrqtiwO4U37/KCAGD04j1BymQFm8qYDgsErH
	Mv90n001E4jwmBUue4CbOOsN60e2EvaJ333a5fedbScuzQsUQ98kEe3QVQgTocsItApbaMHNslEF+
	YrRVqXJdnoMifZQwk9r3zi+GYcEpVJbZdYVyyAkUBnr4ZAChu5n8NXlz562scqWMFkFOAqWvN7TUA
	ovK9+NY4HPvD9XpLofukvaq2ycCi4B/OtABZUhOBLLl5RssJ2dROMeUENuNbfyYk2fjLnOsTAvrzB
	m6ZdImgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFGR9-00Fc1A-AP; Wed, 02 Feb 2022 14:16:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFG77-00FSiA-3z
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 13:56:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0337E68AFE; Wed,  2 Feb 2022 14:55:56 +0100 (CET)
Date: Wed, 2 Feb 2022 14:55:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: Re: [PATCH V6 1/1] nvme: Add verbose error logging
Message-ID: <20220202135556.GA23889@lst.de>
References: <20220202005050.69289-1-alan.adamson@oracle.com>
 <20220202005050.69289-2-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202005050.69289-2-alan.adamson@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_055601_387715_F0CD0B4B 
X-CRM114-Status: GOOD (  17.02  )
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

On Tue, Feb 01, 2022 at 04:50:50PM -0800, Alan Adamson wrote:
> +nvme-core-y				:= core.o ioctl.o errors.o

I still don't like the errors.c/o name.  This isn't really about
errors per se, but about pretty printing protocol constants.  I think
I suggested pretty_print.c before, but maybe just following drivers/scsi/
and calling this constants.c might be best.

> +	const unsigned char *op_str  = "I/O Cmd";
> +	const unsigned char *admin_op_str  = "Admin Cmd";

No nee for these constants, just put this into the main format string.

> +	const unsigned char *err_str = NULL;
> +
> +	err_str = nvme_get_error_status_str(nr->status);
> +
> +	if (ns) {
> +		op_str = nvme_get_opcode_str(nr->cmd->common.opcode);

And not real need for err_str and op_str either, just put the calls
into the argument list of the pr_err_ratelimited calls.

Also please mark nvme_log_err static and move it so that there is no
need for a forward declaration.

> +const unsigned char *nvme_get_error_status_str(u16 status)
> +{
> +	const unsigned char *err_str;
> +
> +	if ((status & 0x7ff) < ARRAY_SIZE(nvme_statuses) &&
> +	    nvme_statuses[status & 0x7ff] != NULL)
> +		err_str = nvme_statuses[status & 0x7ff];
> +	else
> +		err_str = "Unknown";

This can be simplified to:

	status &= 0x7ff;
	if (status < ARRAY_SIZE(nvme_statuses) nvme_statuses[status])
		return nvme_statuses[status];
	return "Unknown";

Similar for the other helpers.

> +EXPORT_SYMBOL_GPL(nvme_get_error_status_str);

No need to export any of the function added in this patch, as they are
all used only inside of nvme-core.ko

