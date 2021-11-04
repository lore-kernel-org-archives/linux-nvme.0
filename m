Return-Path: <SRS0=yHGa=PY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49ABC433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 05:19:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 405C061251
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Nov 2021 05:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 405C061251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2uzvMURoOMgQHNayHSfw0Z9zAIy+zY8rewnSWaIwec=; b=Nm/5dDxXjlE/CbpSzIBpFNaz6N
	25M13hsG65pE/a26rgJSVATLPIFiVH9koBz00W+SFH1rzIiPVrF+iszoNsSPenESWo7lQdl+7bM78
	ZqZmjFhvabWHNVJTI6O5zk1MWRfIxrKTktn49riTtCIO9u80PrLQnrL/se0KUGjin/mcspFWT3nxa
	KWoCbIBsZbky07gTRTRGxMqWqmO8vqlktpETYWfLQumgxx3TqRugeOD5+CW1acgce15QSsocYCEIE
	P2/tdZgi+PJt135NSz3np+psMRukgIHn6ApU7Qx6+bppcLpuTtWNOtr8o8QLcJEDvaeauOXk6rORc
	G6d5TKew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mirdb-00AcHL-5d; Fri, 05 Nov 2021 05:19:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1milTl-00A5R1-9w
 for linux-nvme@lists.infradead.org; Thu, 04 Nov 2021 22:45:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34F0561220;
 Thu,  4 Nov 2021 22:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636065903;
 bh=ULRO/b21e2jF5Il9UheXH6nsdKwZYueNSl7SVt5O9zM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZUlP9UzxX3fkNEDMeQgJtLu4w9c+qEK9huvXYqqHBTEkI3uCuqX0tLz5RVvdLWyh/
 hZ8PhEBO4htT2iwl68hfYDFMT0oyEA9gelhnZ4O4FxB+iv3cAPiOIZr8G3sshzoooj
 Df8MZwd+A2ohPEGqD8UoQcly2xD1WL9Wyp4vXPhDmviwFLLDhqb68g1n9gqXVHMizl
 dpwXmmfrHcKHvT3m3c8DH0lW0s4UTfcbIw75uZFJSLVW6Y3erFMaBpiAyjTvKeuWhs
 rHGgvZikJbnsNW9oovgkNlETNpgHvyVU3jrmTV6/dRMoC2wTI6ORrvKvxCBKcr888g
 8tVcvq2G9A3rQ==
Date: Thu, 4 Nov 2021 15:44:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
 agk@redhat.com, snitzer@redhat.com, song@kernel.org,
 djwong@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
 martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
 javier@javigon.com, johannes.thumshirn@wdc.com, bvanassche@acm.org,
 dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
 willy@infradead.org, jefflexu@linux.alibaba.com,
 josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
 idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
 ebiggers@google.com, jinpu.wang@cloud.ionos.com,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC PATCH 3/8] nvme: add support for the Verify command
Message-ID: <20211104224459.GB2655721@dhcp-10-100-145-180.wdc.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-4-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104064634.4481-4-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211104_154505_403783_1B616736 
X-CRM114-Status: GOOD (  12.46  )
X-Mailman-Approved-At: Thu, 04 Nov 2021 22:19:27 -0700
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

On Wed, Nov 03, 2021 at 11:46:29PM -0700, Chaitanya Kulkarni wrote:
> +static inline blk_status_t nvme_setup_verify(struct nvme_ns *ns,
> +		struct request *req, struct nvme_command *cmnd)
> +{

Due to recent driver changes, you need a "memset(cmnd, 0, sizeof(*cmnd))"
prior to setting up the rest of the command, or you need to set each
command dword individually.

> +	cmnd->verify.opcode = nvme_cmd_verify;
> +	cmnd->verify.nsid = cpu_to_le32(ns->head->ns_id);
> +	cmnd->verify.slba =
> +		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
> +	cmnd->verify.length =
> +		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
> +	cmnd->verify.control = 0;
> +	return BLK_STS_OK;
> +}

> +static void nvme_config_verify(struct gendisk *disk, struct nvme_ns *ns)
> +{
> +	u64 max_blocks;
> +
> +	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_VERIFY))
> +		return;
> +
> +	if (ns->ctrl->max_hw_sectors == UINT_MAX)
> +		max_blocks = (u64)USHRT_MAX + 1;
> +	else
> +		max_blocks = ns->ctrl->max_hw_sectors + 1;

If supported by the controller, this maximum is defined in the non-mdts
command limits in NVM command set specific Identify Controller VSL field.

> +
> +	/* keep same as discard */
> +	if (blk_queue_flag_test_and_set(QUEUE_FLAG_VERIFY, disk->queue))
> +		return;
> +
> +	blk_queue_max_verify_sectors(disk->queue,
> +				     nvme_lba_to_sect(ns, max_blocks));
> +
> +}

