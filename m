Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A0FC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NuC6fG2Sa7IixXFBfNu4pLVrJctAGAp2lQjsAauIMos=; b=SIPkIn7+vfZBMLgihRlGp8v4j1
	ngMWC4IvnaBzp63nPqsTylcXxcsNa7cUeFq3tuLttNJGxu7qh2z6cV5bwcnFRPncLLxWXAOcikFlS
	KliT7SBgV4vI7s0iXotyJ+0lMMZgOvKFdFc4lC2YsAnFXQjJP5Oqjo/TFlnGPOdSKkwJu8ohVj9PK
	Auc3Safbp9xq7rDzWm0dwNm2Rb0n391xY3FBVqeDUqWtU+IurHjnAUuspB+8Ap5Z1XmVfsRSpB4lr
	wRNPfWYJnZith32qulzTCgRpsAY+07tYaZyh81g8Zd98sZBx4NMgIqDaBb3myImEt8qLAeHgOSqjg
	E7LwpYZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3VL-00E6U6-8h; Sun, 30 Oct 2022 08:17:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3VJ-00E6SD-0F
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:17:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91DFB68BEB; Sun, 30 Oct 2022 09:17:08 +0100 (CET)
Date: Sun, 30 Oct 2022 09:17:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	chaitanyak@nvidia.com, kbusch@kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH v3 09/19] nvme: Add pr_ops read_keys support
Message-ID: <20221030081708.GA4774@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-10-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-10-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_011713_211339_DB70B3EE 
X-CRM114-Status: GOOD (  27.27  )
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

On Wed, Oct 26, 2022 at 06:19:35PM -0500, Mike Christie wrote:
> This patch adds support for the pr_ops read_keys callout by calling the
> NVMe Reservation Report helper, then parsing that info to get the
> controller's registered keys. Because the callout is only used in the
> kernel where the callers do not know about controller/host IDs, the
> callout just returns the registered keys which is required by the SCSI PR
> in READ KEYS command.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/nvme/host/pr.c | 73 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h   |  4 +++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index aa88c55879b2..df7eb2440c67 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -118,10 +118,83 @@ static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type
>  	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
>  }
>  
> +static int nvme_pr_resv_report(struct block_device *bdev, u8 *data,
> +		u32 data_len, bool *eds)

Is there any good reason this method seems to take a u8 instead of a void
pointer?  As that seems to make a few things a bit messy.

> +	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
> +	    bdev->bd_disk->fops == &nvme_ns_head_ops)
> +		ret = nvme_send_ns_head_pr_command(bdev, &c, data, data_len);
> +	else
> +		ret = nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
> +					      data, data_len);

Can you please add a hlper for this logic?

> +	for (i = 0; i < num_ret_keys; i++) {
> +		if (eds) {
> +			keys_info->keys[i] =
> +					le64_to_cpu(status->regctl_eds[i].rkey);
> +		} else {
> +			keys_info->keys[i] =
> +					le64_to_cpu(status->regctl_ds[i].rkey);
> +		}

If you shorten the status variable name to something like rs this becomes
much easier to follow :)

