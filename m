Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B5C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:46:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B7382078D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FrmcPWkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7382078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/bkfq6axse5RqnYA1yJs3KHZX/IiQOe3uLOJ//GhrmA=; b=FrmcPWkrxkE/ZRre0lD+Fa7ZI
	bzDscKHzi+V/Xkrk18EZBSeKhMLKODFwK/JcL2jJAxXYRtrTE1VViLE7Cs8yMYSScWF65e6S49USt
	6hCfaJbVlg8MebX4htjnTp5LS/gXBQGHhum6MTTRBq+MSpY6IcclTUrmJydQpUo7MpD1rD9bDhAxN
	HBxZ6XKwM51xjns0Iq//RW3OCSMvEBmRiVLyVIX4mubQ+XbaSEMAvz31UDBfU+NXW3k7XNV+Pnp5j
	JhigxP0QszH6lm3dKBDpcTufFBHy+V24q+CfGLgXLbvmi2XyGt/54cGeZxThOBKX4GEq0aSeFUv+Q
	aiJDvrZKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPPsY-0003jE-Ur; Mon, 05 Oct 2020 12:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPsW-0003i7-7m
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 12:46:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 821DC67373; Mon,  5 Oct 2020 14:46:05 +0200 (CEST)
Date: Mon, 5 Oct 2020 14:46:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-loop: use xarray for loop ctrl tracking
Message-ID: <20201005124605.GA518@lst.de>
References: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
 <20200930045557.53669-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930045557.53669-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_084608_404416_50D0317E 
X-CRM114-Status: GOOD (  16.92  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 09:55:56PM -0700, Chaitanya Kulkarni wrote:
> @@ -262,12 +260,10 @@ static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
>  {
>  	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
>  
> -	if (list_empty(&ctrl->list))
> +	if (!xa_load(&nvme_loop_ctrls, nctrl->cntlid))
>  		goto free_ctrl;
>  
> -	mutex_lock(&nvme_loop_ctrl_mutex);
> -	list_del(&ctrl->list);
> -	mutex_unlock(&nvme_loop_ctrl_mutex);
> +	xa_erase(&nvme_loop_ctrls, nctrl->cntlid);

xa_erase is fine with an already deleted object, so the above xa_load
check doesn't make any sense.

> @@ -599,6 +590,12 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
>  	if (ret)
>  		goto out_free_queues;
>  
> +	/* unusual place to update xarray, makes unwind code simple */
> +	ret = xa_insert(&nvme_loop_ctrls, ctrl->ctrl.cntlid, &ctrl,
> +			GFP_KERNEL);
> +	if (ret)
> +		goto out_remove_ctrl;
> +

>  out_remove_admin_queue:
>  	nvme_loop_destroy_admin_queue(ctrl);
> +out_remove_ctrl:
> +	xa_erase(&nvme_loop_ctrls, ctrl->ctrl.cntlid);

This looks weird.  Why would you remove the controller when inserting
it fails?

Also did you do an audit that none of the lookups will do something
funny with the insered but not fully initialized controller?

> @@ -678,7 +673,7 @@ static struct nvmf_transport_ops nvme_loop_transport = {
>  	.name		= "loop",
>  	.module		= THIS_MODULE,
>  	.create_ctrl	= nvme_loop_create_ctrl,
> -	.allowed_opts	= NVMF_OPT_TRADDR,
> +	.allowed_opts	= NVMF_OPT_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,

This looks unrelated?

> +	xa_init(&nvme_loop_ctrls);

DEFINE_XARRAY seems like the btter choice for nvme_loop_ctrls.


>  	return ret;
>  }
>  
>  static void __exit nvme_loop_cleanup_module(void)
>  {
> -	struct nvme_loop_ctrl *ctrl, *next;
> +	struct nvme_loop_ctrl *ctrl;
> +	unsigned long idx;
>  
>  	nvmf_unregister_transport(&nvme_loop_transport);
>  	nvmet_unregister_transport(&nvme_loop_ops);
>  
> -	mutex_lock(&nvme_loop_ctrl_mutex);
> -	list_for_each_entry_safe(ctrl, next, &nvme_loop_ctrl_list, list)
> +	xa_for_each(&nvme_loop_ctrls, idx, ctrl)
>  		nvme_delete_ctrl(&ctrl->ctrl);
> -	mutex_unlock(&nvme_loop_ctrl_mutex);
> +
> +	xa_destroy(&nvme_loop_ctrls);

What replace the protection previously provided by nvme_loop_ctrl_mutex?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
