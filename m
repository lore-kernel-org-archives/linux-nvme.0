Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE7DCDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 05:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGay0HMidIwvIDa8IQFiBzwZwAzN4hLo0QPU8H323mk=; b=AvvLa1wxdTjwaCOc0EXNPRz7jH
	U0u6QBrF9bHVVLHdP50S1AaWpXut2v/BYFOLZVTCNSW/8IdNAm1Wd1j0OtYltQGr5oWn32JAAY8If
	1h23jo5Q7xR3e5efRRtd7tC1R4R8KZh6bgp1DjtFRjhkbqf1tkCg+8Cx9yZcL/7rbGxKuIQFrQdCE
	j8oqi5ed7fnYuoYjR0n/EVXFaf1SupUA42+wiGwcA37A6RVZ8YsCLIlvdi4zpLw0wRGYeB8fr3R44
	oCDYB0P1mgK1egVqZ1Bh1xZapVQ+1aA5578OstY0VYdz+C4WJIE/8Qbsir0qqPakIgvDHgxWx0Iaj
	yWYyhPgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGaq-008Tai-1q;
	Mon, 16 Oct 2023 05:56:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsGao-008Ta2-0S;
	Mon, 16 Oct 2023 05:56:42 +0000
Date: Sun, 15 Oct 2023 22:56:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hare@suse.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-auth: complete a request only after freeing the
 dhchap pointers
Message-ID: <ZSzQmlEBkcJQ0P24@infradead.org>
References: <20231013094239.332235-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013094239.332235-1-mlombard@redhat.com>
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

On Fri, Oct 13, 2023 at 11:42:39AM +0200, Maurizio Lombardi wrote:
> -	nvmet_req_complete(req, status);
>  	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
>  	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
>  		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
>  
>  		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
>  				 auth_expire_secs * HZ);
> +
> +		nvmet_req_complete(req, status);
>  		return;
>  	}
>  	/* Final states, clear up variables */
>  	nvmet_auth_sq_free(req->sq);
>  	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
>  		nvmet_ctrl_fatal_error(ctrl);
> +	nvmet_req_complete(req, status);

I'd be tempted to use a goto here to have a single completion path.

>  }
>  
>  static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
> @@ -514,11 +516,14 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
>  	kfree(d);
>  done:
>  	req->cqe->result.u64 = 0;
> -	nvmet_req_complete(req, status);
> +
>  	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
>  		nvmet_auth_sq_free(req->sq);
>  	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
>  		nvmet_auth_sq_free(req->sq);
>  		nvmet_ctrl_fatal_error(ctrl);
> +		nvmet_req_complete(req, status);
> +		return;
>  	}
> +	nvmet_req_complete(req, status);

And this looks really odd to me.  Why do a manual complete and return
in the branch just to skip the complete right after it?

