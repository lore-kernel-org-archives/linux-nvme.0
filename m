Return-Path: <SRS0=yQ2W=6E=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FFCC54FCC
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133A62078C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2020 22:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4CB3Y9R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8rq4igM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133A62078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bEssgq0/3X1QPQjavu06DeSOqUJVPcjtjTtgHdMsuyw=; b=a4CB3Y9R4j3tar
	ZylxdEMKuQs7txeUp9eaeFgebMSBYVKTwA9EcEoMjsc2/lEF08wknNKs6THwbsB1co86I8y7hIRJA
	zFjD4l0uUE30NxGigicYLXlLti8amo+8fWeF1bFeaQ6XqABK71fQWAElhm5k8Y/zxtANmWqbaBavl
	q45PFz6LvJpEcs4sz1cNmYLuussOR7S6i4GjuBrDqaPTjb19/SkEDX6xZbsAvAtxukDV9wmtOP6pv
	v4SrAZ7UrLHbE6wVl+/EdH528/QwWL8010+fDhCjCCoQtjB/xQijjYsEeRoCy26hl8WVfuRFfV2vt
	cRlA9W/GPKnG+tzYQCdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQesV-0001bQ-3t; Mon, 20 Apr 2020 22:26:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQesS-0001aA-L7
 for linux-nvme@lists.infradead.org; Mon, 20 Apr 2020 22:26:57 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3ABAA2078C;
 Mon, 20 Apr 2020 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587421614;
 bh=EWVzh88DNd4xeWlsexuidhZpIDlePK+hTSyEl1GX/8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s8rq4igMfXXijc389ELBl5dQwloilfDDQMohpJXxaRWtdIKgyDc07+5kh8co+PUup
 r+6Z54NwOW5xZFGmhIX/9UUU37s4Z7yGbgpCmN8isJapDDS3+dQdMBqGLYl1Dfqq65
 pk9gQ+cFF7aXKSpcYIsxq7I56fqA6ULGH895zwsI=
Date: Tue, 21 Apr 2020 07:26:46 +0900
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 1/9] nvme-core: Clear any SGL flags in passthru
 commands
Message-ID: <20200420222646.GA11115@redsun51.ssa.fujisawa.hgst.com>
References: <20200420164700.21620-1-logang@deltatee.com>
 <20200420164700.21620-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200420164700.21620-2-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200420_152656_724605_E76416E2 
X-CRM114-Status: GOOD (  14.92  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 20, 2020 at 10:46:52AM -0600, Logan Gunthorpe wrote:
> The host driver should decide whether to use SGLs or PRPs and they
> currently assume the flags are cleared after the call to
> nvme_setup_cmd(). However, passed-through commands may erroneously
> set these bits; so clear them for all cases.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 91c1bd659947..f5283b300e87 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -756,6 +756,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  	case REQ_OP_DRV_IN:
>  	case REQ_OP_DRV_OUT:
>  		memcpy(cmd, nvme_req(req)->cmd, sizeof(*cmd));
> +		/* passthru commands should let the driver set the SGL flags */
> +		cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>  		break;

Is this really necessary? The passthrough handler currently rejects user
commands that set command flags:

static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
			struct nvme_passthru_cmd __user *ucmd)
{
	...
	if (cmd.flags)
		return -EINVAL;

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
