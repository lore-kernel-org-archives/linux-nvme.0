Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD7CCC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 06:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgUbrgI6Nmv0Q1NvUsnFEVJ8hxHy12NfrIaEIBktx68=; b=KElc2azuRJCcWQhKf4w4GYEeov
	YfCWJmHi+OA0a8n7cBKey2Ar+oWlo37oFOF4DvfdhdhJpP/LUbGhb/iT5xWUcoolP+s3DbCLPTJDY
	bBMWdAA9fqHidbX2tef49tm8pI3KZbna7kHnhk3qpJvy5nHjJN2aKjMZwQPicRqsVeol5FiGhuJUG
	n2uiDd5IDGttea75/0WuK4whp/OYxOpJTR+nTxaAQ661YRgok4k84iPFljib/lYq4hjiEKaNIS3Ti
	0S6Xsq9V223EHNeGgkyeS6prMpx10YcHgDX6f7pHJtpG8vw04M6djDpPY+h+lqYyGvBpxVq7Ce6se
	Ga+zLTog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGsOq-0000000EbHo-3zfP;
	Wed, 14 Oct 2026 06:23:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGsOl-0000000EbHP-0kFB
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 06:23:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=EYpybl+sKkbYJx
	E4ysJBc9JgYugoN7FZg/U8lPSyFx0=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=Bq7BZPcbEPexDPJcPV1QU9ZopvZ5B2T/QPSNY
	Cbj3o++ZrXJ06RP2EguER3j4ofifK6KX2C3hvefZB99mLMgAiqY7G94KcL/7e2obbpqu0/
	+v4IPRPzJSjXM0ibax75aOeGtcdzIJqW+HK+nQSWzI2BXFYMFXs5ik/s+adRZb9Ep3VHsq
	1UtIJZExPOzw9T5Jq8R0xqCzFP60lzdeuyMF3ZXdgRcwDO1b/P96tdBul0e4VZiFLB+Oa3
	gOxuF7wD/7Zw9a4sPVyWvJrx7rcGhxJ4xXVVvFNs+7qbYLonXWsS7TfzJo//x1E5k/H/9h
	kPCSCrDW1jeV/IfGHz4jLsXXA==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 6f0b8cc8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:23:30 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Oct 2026 08:23:30 +0200
Message-Id: <DM4CGCPQCBLX.10XJ0BE8OCYH4@arkamax.eu>
Cc: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] nvmet: take subsys->lock while force-reconnecting in
 nvmet_subsys_attr_qid_max_store()
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Yu Zhang" <yuz08559@gmail.com>, "Keith Busch" <kbusch@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261014054727.53183-1-yuz08559@gmail.com>
In-Reply-To: <20261014054727.53183-1-yuz08559@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_232335_877506_6B369EC3 
X-CRM114-Status: GOOD (  21.19  )
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

On Wed Oct 14, 2026 at 7:47 AM CEST, Yu Zhang wrote:
> nvmet_subsys_attr_qid_max_store() sets subsys->max_qid and then walks
> subsys->ctrls to force every controller to reconnect, but it holds only
> nvmet_config_sem (for write).  subsys->ctrls is protected by subsys->lock=
:
> nvmet_alloc_ctrl() adds an entry under subsys->lock, and nvmet_ctrl_free(=
)
> removes it under subsys->lock with list_del() + kfree() (not kfree_rcu).
> The free path takes no nvmet_config_sem, so the two locks are independent=
.
>
> A controller teardown (host disconnect, keep-alive timeout or fatal error
> -> nvmet_sq_destroy() -> nvmet_ctrl_put() -> nvmet_ctrl_free()) can
> therefore list_del() an entry while qid_max_store() is iterating the list=
,
> corrupting the walk.
>
> KASAN, concurrent "echo 128 > .../subsystems/<nqn>/attr_qid_max" racing
> nvme-loop controllers connecting and disconnecting, panics in seconds:
>
>   BUG: KASAN: null-ptr-deref in nvmet_subsys_attr_qid_max_store+0x10d/0x1=
b0
>   Read of size 8 at addr 0000000000000090
>   Call Trace:
>    nvmet_subsys_attr_qid_max_store+0x10d/0x1b0
>    configfs_write_iter+0x1a7/0x250
>    vfs_write+0x5df/0x940
>    ksys_write+0xfd/0x1e0
>
> (also seen as a general-protection fault dereferencing a LIST_POISON
> pointer at the same instruction.)
>
> Take subsys->lock around the list_for_each_entry() loop, matching every
> other subsys->ctrls accessor.  ->delete_ctrl() only queues asynchronous
> controller teardown, so it does not re-enter subsys->lock under the loop.
>
> Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> Tested-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/nvme/target/configfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index 1111111..2222222 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1683,9 +1683,16 @@ static ssize_t nvmet_subsys_attr_qid_max_store(str=
uct config_item *item,
>  	down_write(&nvmet_config_sem);
>  	subsys->max_qid =3D qid_max;
>
> -	/* Force reconnect */
> +	/*
> +	 * Force reconnect.  subsys->ctrls is protected by subsys->lock
> +	 * (nvmet_alloc_ctrl()/nvmet_ctrl_free() add and remove entries under
> +	 * it); take it here too so a concurrent controller teardown cannot
> +	 * list_del() an entry while this loop walks the list.
> +	 */
> +	mutex_lock(&subsys->lock);
>  	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>  		ctrl->ops->delete_ctrl(ctrl);
> +	mutex_unlock(&subsys->lock);
>  	up_write(&nvmet_config_sem);
>
>  	return cnt;
> --
> 2.43.0

I don't think we need a comment in the source code just to explain that.
It's an established pattern all over the target driver code that accesses
to the subsys->ctrls list are protected by subsys->lock, so this is already=
 implied.

Anyway the fix looks good to me.

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

