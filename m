Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022EBC64EC4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WuS60JdOCwP2Qr4SEEKLJM955G7Wh4mx6RXDgQ+gXc=; b=v8POkrx0EmlNuc8EIpetBGSxE5
	n1foqqFNRn6oqmvgvbQCWRxtjsH6LcZnxV5oVsOgiO16tklSqC+Sd7kZQTJJTNl9h9yPBihbQ3uz1
	nEWtlHpjfBwg2DLx5BYFdZjDh2I/IVrdQXIMI6rt+dPvN1C0lL6kryg8mhhGpkyK3cAu1P/yr1Xxx
	eJWfbWNIQNLSSQXD8/6EAWoMQt7dg59LNA1RcJJz25ndG4e1uYKXsAVnhOxBpsIxUXG2kUvcqSyX9
	QPfS3dbaHZRkTgXG6LY+Ps019Ctz5jmd2jdfCSCOb0HDbfFx7bxDOeFDMm3PDnXAAsPvlJ50JnjuS
	EKC7Npgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSIn-00DL9r-7E; Mon, 13 Feb 2023 06:27:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSIj-00DL8M-Pd
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:26:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C00D68BFE; Mon, 13 Feb 2023 07:26:54 +0100 (CET)
Date: Mon, 13 Feb 2023 07:26:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/5] nvme: open-code __nvme_submit_sync_cmd()
Message-ID: <20230213062654.GC14223@lst.de>
References: <20230209143820.118097-1-hare@suse.de> <20230209143820.118097-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209143820.118097-5-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_222657_997040_5D56DAC9 
X-CRM114-Status: GOOD (  15.10  )
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

On Thu, Feb 09, 2023 at 03:38:19PM +0100, Hannes Reinecke wrote:
> +	if (ret) {
>  		dev_err(ctrl->device,
> -			"qid %d auth_send failed with error %d\n", qid, ret);
> +			"qid %d auth_submit failed to map, error %d\n",
> +			qid, ret);

Plase do a goto out_free_request here instead of indenting the
normal flow in the else path.  The same comment applies in a bunch of
other places.

> -	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, 0);
> +	ret = blk_rq_map_kern(req->q, req, buffer, buflen, GFP_KERNEL);
> +	if (ret)
> +		goto out;
> +
> +	ret = nvme_execute_rq(req, &res, false);

This could use nvmf_submit_fabrics_cmd, which has nothing to with
fabrics, but just is a variant of nvme_submit_sync_cmd that returns the
result.  So if we have that helper anyway we might as well move it to
the core and turn nvme_submit_sync_cmd into a wrapper for it.

