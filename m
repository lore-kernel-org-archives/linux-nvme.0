Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79612C432C3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:41:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151362071C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sR6RtnEs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151362071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xsUVb2ZlL6Ax49Zg1y0iojCFXEXDz+ETVVLMyU9lVAU=; b=sR6RtnEsuKmj7F
	XgfoQrS/Gyxwq1Kd/wGoFRgv51GK3kvp5eTF157Q25OAt9Qy2eiuNLzGNnmYfbXy7n5BENgT7vG8t
	tVYMjMD/Fx8/CxY6jsl/Z/zaU4Oq/8cdmSIBweYYv/q3VMLEJeJLu4IAKRsRB6wk5OJ+7Iddzn83Z
	igZG943rcdOMJnNunQIPPVOmLNspNuv4iITWavAv1u9AKQv4r68gGlY0hUDVOLNWRFJaHSGetZ2h/
	SQe3HrrfS8gmjdl0B/eD5xXiO0vgOikzb7u1RgdpwH0YJlR00X+s9f99bifWoxh4KvZvyLQ2dAIWX
	J50PBEqZNVNQEUDa63Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXUut-0008NQ-2n; Wed, 20 Nov 2019 18:41:27 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXUuq-0008Ms-15
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 18:41:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E0C5768B05; Wed, 20 Nov 2019 19:41:18 +0100 (CET)
Date: Wed, 20 Nov 2019 19:41:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2] nvmet: make ctrl model configurable
Message-ID: <20191120184118.GA12060@lst.de>
References: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191120_104124_221570_C644151E 
X-CRM114-Status: GOOD (  20.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: MRuijter@onestopsystems.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 13, 2019 at 01:58:45PM -0800, Chaitanya Kulkarni wrote:
> From: Mark Ruijter <MRuijter@onestopsystems.com>
> 
> This patch adds a new target subsys attribute which allows user to
> optionally specify model name which then used in the
> nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.
> 
> The default value for the model is set to "Linux" for backward
> compatibility.
> 
> Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
> Changes from V1:-
> 
> 1. Don't allocate memory for default subsys model,
> 2. Use helper to get the default model string from ctrl->subsys in the
>    nvmet_execute_identify_ctrl() and nvmet_subsys_attr_model()_show.
>    Later is needed so that nvmetcli can display default value Linux
>    when the model is not set from the user.
> 3. Get rid of the extra variable c in the nvmet_subsys_attr_model_store()
>    and replace for with while loop without loosing the code redability.
> ---
>  drivers/nvme/target/admin-cmd.c |  9 +++++--
>  drivers/nvme/target/configfs.c  | 44 +++++++++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  2 ++
>  drivers/nvme/target/nvmet.h     |  4 +++
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 56c21b501185..81374507099f 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -312,12 +312,17 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>  	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
>  }
>  
> +const char *nvmet_subsys_model(struct nvmet_subsys *subsys)
> +{
> +	return subsys->model ? subsys->model : NVMET_DEFAULT_CTRL_MODEL;

Nit: I always prefer good old if statements except when passing
arguments or a few commonly used idioms as it just reads much more
easily.

> +	/* Only 20h (space) until 7eh (~) is allowed */
> +	while (pos < len && (page[pos] >= 0x20 && page[pos] <= 0x7e) && ++pos)

No nee for the inner braces here, but I wonder If this whole thing
could be reshuffled somehow to be a bit more readable.  Something like:

/* See Section 1.5 of NVMe 1.4 */
static bool nvmet_is_ascii(const char c)
{
	return c >= 0x20 && c <= 0x7e;
}

	for (pos = 0; pos < len; pos++) {
		if (!nvmet_is_ascii(page[pos]))
			goto out_unlock;
	}

> +	tmp = kstrndup(page, len, GFP_KERNEL);
> +	if (!tmp) {

Maybe name tmp model?

> +const char *nvmet_subsys_model(struct nvmet_subsys *subsys);

Maybe just call this nvmet_model_number to match the field name?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
