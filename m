Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32907D2F7EF
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ep3Qs4/tLDqIt2+skBCut2VM0vxp7ZispkeMLUnu7ns=; b=ZGF2DmEcEMb0itzjOlry9/YkaB
	1S12ZXxzHEwPF9+/0tXjiAIkyOUS1u+vFXe0O87ZerCMMlJmawr7Gie35Jz8saEfNZHcZS5cuO/Ts
	6v1xFGgBi+e2uEbmIlLUBQnCc/vzvjPd8E63/+toZZFiZmPfsq1Z2H9MW5WkP8EmBjCGN6Xmr/Fk5
	pEUnSC8VdoOcZDFEx0yTGBbERJa+OVn7DH46xiF0QpXkCrMGPJw0+rpucpRkRpFglBPVcDtg0Flv7
	0mVse5eps5OPjW9C6LZBB0ixSl1kdHNkFGflJjTl2cTDQJYg0fjD/BDzrrUkBQ+u9PS1wOpoqJj/t
	3mMhyY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRWOi-00000009Ya5-3ahq;
	Fri, 05 Dec 2025 14:03:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRWOg-00000009YZW-08IR
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 14:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764943375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ep3Qs4/tLDqIt2+skBCut2VM0vxp7ZispkeMLUnu7ns=;
	b=jAPaMN8simDAcmo6chX4y5ic15ewDdea+1pbfZijt6DJAX0USyAt6YAWhSVOeeed4lCQCE
	qLPMJtFpKK4D3kWA2borpqLi0YuwFsgzCmmYQy5rDhB+nbB+zf5HLnPLLHDmJnk/gMpyLz
	tuncnmVCZtG28ZIUSbGCf7obqRMe3jk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-BfhPMskiN4i6-m98mfgCNQ-1; Fri,
 05 Dec 2025 09:02:53 -0500
X-MC-Unique: BfhPMskiN4i6-m98mfgCNQ-1
X-Mimecast-MFC-AGG-ID: BfhPMskiN4i6-m98mfgCNQ_1764943372
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 460371800642;
	Fri,  5 Dec 2025 14:02:52 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.22.88.76])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C8BC3011A86;
	Fri,  5 Dec 2025 14:02:51 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
	id B2EE7C34DF; Fri,  5 Dec 2025 09:02:50 -0500 (EST)
Date: Fri, 5 Dec 2025 09:02:50 -0500
From: Aristeu Rozanski <aris@redhat.com>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <wagi@kernel.org>, 
	"Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 1/1] nvmet-fcloop: Check remoteport port_state before
 calling done callback
Message-ID: <ecb2482e-966a-4815-9069-834dd74c6def@work>
References: <20251204202613.14908-1-justintee8345@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20251204202613.14908-1-justintee8345@gmail.com>
User-Agent: NeoMutt/20241114-35-62db1e
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lRU4OQnTuyeD42Ty-3rWIoDknS0qwcV-6BlK5MXxSrM_1764943372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_060258_152685_F9994B84 
X-CRM114-Status: GOOD (  22.62  )
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

On Thu, Dec 04, 2025 at 12:26:13PM -0800, Justin Tee wrote:
> In nvme_fc_handle_ls_rqst_work, the lsrsp->done callback is only set when
> remoteport->port_state is FC_OBJSTATE_ONLINE.  Otherwise, the
> nvme_fc_xmt_ls_rsp's LLDD call to lport->ops->xmt_ls_rsp is expected to
> fail and the nvme-fc transport layer itself will directly call
> nvme_fc_xmt_ls_rsp_free instead of relying on LLDD's done callback to free
> the lsrsp resources.
> 
> Update the fcloop_t2h_xmt_ls_rsp routine to check remoteport->port_state.
> If online, then lsrsp->done callback will free the lsrsp.  Else, return
> -ENODEV to signal the nvme-fc transport to handle freeing lsrsp.
> 
> Cc: Aristeu Rozanski <aris@redhat.com>
> Cc: Daniel Wagner <wagi@kernel.org>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Closes: https://lore.kernel.org/linux-nvme/21255200-a271-4fa0-b099-97755c8acd4c@work/
> Fixes: 10c165af35d2 ("nvmet-fcloop: call done callback even when remote port is gone")
> Signed-off-by: Justin Tee <justintee8345@gmail.com>
> ---
>  drivers/nvme/target/fcloop.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index c30e9a3e014f..38bd2db3d6bb 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -491,6 +491,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>  	struct fcloop_rport *rport = remoteport->private;
>  	struct nvmet_fc_target_port *targetport = rport->targetport;
>  	struct fcloop_tport *tport;
> +	int ret = 0;
>  
>  	if (!targetport) {
>  		/*
> @@ -500,12 +501,18 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
>  		 * We end up here from delete association exchange:
>  		 * nvmet_fc_xmt_disconnect_assoc sends an async request.
>  		 *
> -		 * Return success because this is what LLDDs do; silently
> -		 * drop the response.
> +		 * Return success when remoteport is still online because this
> +		 * is what LLDDs do and silently drop the response.  Otherwise,
> +		 * return with error to signal upper layer to perform the lsrsp
> +		 * resource cleanup.
>  		 */
> -		lsrsp->done(lsrsp);
> +		if (remoteport->port_state == FC_OBJSTATE_ONLINE)
> +			lsrsp->done(lsrsp);
> +		else
> +			ret = -ENODEV;
> +
>  		kmem_cache_free(lsreq_cache, tls_req);
> -		return 0;
> +		return ret;
>  	}
>  
>  	memcpy(lsreq->rspaddr, lsrsp->rspbuf,

survived overnight here and makes sense to me. Thanks!

Tested-by: Aristeu Rozanski <aris@redhat.com>
Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu


