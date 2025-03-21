Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F7CC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rt907Ki4XIl77VahxCfCvfLBFhhyjiPGIOI+pXkwmoQ=; b=V5dnyepm1vk4ugV3fAAeT12gkE
	Bdieu/tBfUeyIk5HIVBANgXtlvluGPGQeQM783iKFO/n/mqRdQ4T09Y7R9GpZKIgSSG4iexwdgcFG
	pv+Z1bSUDovkGSnYiBmxbk4YbnukVcNDH51K4iVXZFuAMK0swrHs/5fZNKpoxl7pqCdmhKnZZ0pLe
	Lnuci6IrM+cU6JF/ZTSFiiW067Hxm69FQOlfY+5PW9jv+Pp+wwcerunGLu2qzsA9L+NWzxmZPIh9c
	GpaO5rIDjKPsuzEEJzv3EBqZZPCl6Ydpqsx4iCOAP4iuJCg9gI0nSN4GMW3SQcKE5pVR7LgkK4nQf
	nK32UsDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVcp-0000000Dxi0-3Y97;
	Fri, 21 Mar 2025 06:12:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVcn-0000000Dxhg-0rRP
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:12:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F26FF68AA6; Fri, 21 Mar 2025 07:12:52 +0100 (CET)
Date: Fri, 21 Mar 2025 07:12:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
Message-ID: <20250321061252.GA3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231257_382413_948F7530 
X-CRM114-Status: GOOD (  14.82  )
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

On Tue, Mar 18, 2025 at 11:40:02AM +0100, Daniel Wagner wrote:
> -	if (!tfcp_req)
> +	if (!tfcp_req) {
>  		/* abort has already been called */
> +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
>  		return;
> +	}
>  
>  	/* break initiator/target relationship for io */
>  	spin_lock_irqsave(&tfcp_req->reqlock, flags);
> @@ -982,6 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
>  		break;
>  	default:
>  		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
> +		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);

Maybe share this using a goto?


