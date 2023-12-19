Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A671EC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 05:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cXHsSGYg0nHcWIza/M9HUfGXhGmZUYE4AAWBtim/Pnk=; b=0KZSxvGHjbkUaOrSYg491dqbPt
	HjaRh+14BszD3+ZMqSRLtEG8Tz7wgV60aXPVm+eB/P5Mm1pTZfr7t1pRnx+0Npv8UjkBbNhP+4Uc5
	r4aHPulr9da+VOr6cg8fUIjSLJfVdOmN1K/S26rCiVs5mzTrPYGPJz6XkyQ1V1okFdHjdFHBV4MM/
	cs0k5Epb3I344YxPnsVrkCPloSIl/EDsD502aQUgjlRALSoBNnmML0rFnedvN+0IKQmkNiCGVMR88
	D8Qe/Er9AS2v860XPzhqyRv4uy1JyaTVy66BGiUtFHZTKM/mHEt4/mJh4p6Vh3w1xnpjSeUTeW+eS
	ih83UK1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSEH-00Cql6-2N;
	Tue, 19 Dec 2023 05:01:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFSEE-00Cqkj-0v
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 05:01:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 555F568AFE; Tue, 19 Dec 2023 06:01:09 +0100 (CET)
Date: Tue, 19 Dec 2023 06:01:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, chaitanyak@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: enhance timeout kernel log
Message-ID: <20231219050108.GA31771@lst.de>
References: <20231218224633.2963811-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218224633.2963811-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_210114_464171_5F4C99AE 
X-CRM114-Status: GOOD (  10.37  )
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

On Mon, Dec 18, 2023 at 02:46:33PM -0800, Keith Busch wrote:
> -			 "I/O %d QID %d timeout, completion polled\n",
> +			 "I/O tag %d QID %d timeout, completion polled\n",

Q: should we use the Linux term tag or the NVMe term command ID
(or command_id) ?  I don't really care, just thinking out loud.

> +	opcode = nvme_req(req)->cmd->common.opcode;
>  	if (!nvmeq->qid || iod->aborted) {
>  		dev_warn(dev->ctrl.device,
> -			 "I/O %d QID %d timeout, reset controller\n",
> -			 req->tag, nvmeq->qid);
> +			 "I/O tag %d (opcode:%s %d) QID %d timeout, reset controller\n",
> +			 req->tag, nvme_opcode_str(nvmeq->qid, opcode, 0),
> +			 opcode, nvmeq->qid);

space after the ":" ?

> +		 "I/O tag %d (opcode:%s %d) QID %d timeout, aborting req_op:%s(%u) size:%u\n",
> +		 req->tag, nvme_get_opcode_str(opcode), opcode, nvmeq->qid,
> +		 blk_op_str(req_op(req)), req_op(req), blk_rq_bytes(req));

Same.


