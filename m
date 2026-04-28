Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC18AFF885D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sutRG2hRyg142gJIKwvhZGimj4PONdwY3RUJTfEzKs0=; b=x1zPTCn6RoQJDvIUQ0qZljtNiL
	AMASjkpKtMp+baFKQU5OFxcgGvkqZFbvkRdjkBSGe4YltEBobqyalOYkgBYld4Pc/1vBTQev9eVGN
	aVfvWbIdXGr5QyOj5vr6uyWrGgQy/Bflbj8ct8go4OSQTCw2tYrJJA9K0TyckxWwreeEzVBqwF6oD
	XcUAtYIZn6uXAQlGRYtTBmVwXyGOxiTAOkrULt4Q2ZIv/xwEOzvaY1uvM+UdUC0VNYVlmJEeelJ2R
	xqRsnEZnztBqU0k66kk6MoyiIWuax1qq4Z462L8NXYh40HJBkiRs1uvkF4Lr2PjqdH3eKuP5eZCGJ
	ltXLof3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgRR-00000001Ke9-10PK;
	Tue, 28 Apr 2026 11:17:25 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgRN-00000001KcT-46F1
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 11:17:23 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 6bec60e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Apr 2026 13:17:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 13:17:17 +0200
Message-Id: <DI4QV80PTNP9.1ZY7L7GFJ8TX5@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during
 reset
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-8-mlombard@redhat.com>
 <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
In-Reply-To: <8babbc78-701d-4308-b325-b4b2bab5d2c2@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_041722_349338_AC225ACB 
X-CRM114-Status: GOOD (  21.48  )
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

On Mon Apr 27, 2026 at 11:46 AM CEST, Daniel Wagner wrote:
> On Fri, Apr 10, 2026 at 09:39:23AM +0200, Maurizio Lombardi wrote:
>> @@ -375,12 +376,15 @@ static int nvme_loop_configure_admin_queue(struct =
nvme_loop_ctrl *ctrl)
>>  	}
>>  	ctrl->ctrl.queue_count =3D 1;
>> =20
>> -	error =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
>> -			&nvme_loop_admin_mq_ops,
>> -			sizeof(struct nvme_loop_iod) +
>> -			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
>> -	if (error)
>> -		goto out_free_sq;
>> +	if (new) {
>> +		error =3D nvme_alloc_admin_tag_set(&ctrl->ctrl,
>> +				&ctrl->admin_tag_set,
>> +				&nvme_loop_admin_mq_ops,
>> +				sizeof(struct nvme_loop_iod) +
>> +				NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
>> +		if (error)
>> +			goto out_free_sq;
>> +	}
>> =20
>>  	/* reset stopped state for the fresh admin queue */
>>  	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
>> @@ -415,7 +419,7 @@ static int nvme_loop_configure_admin_queue(struct nv=
me_loop_ctrl *ctrl)
>>  	return error;
>>  }
>
> Personally, I am just not a big fan of conditional creation/removal of
> resources controlled via a bool. If it's the cleanest solution fine with
> me, but I wonder if here it wouldn't be cleaner to allocated the tagset
> outside of nvme_loop_configure_admin_queue and obviously the same idea
> for destroy.
>
> Have you tried this approach, does it look too ugly?


It would be something like this (just a compile tested draft,
I still need to properly test it, but it should give you an idea):


nvmet-loop: do not alloc admin tag set during reset

Currently, resetting a loopback controller unconditionally invokes
nvme_alloc_admin_tag_set() inside nvme_loop_configure_admin_queue().
Doing so drops the old queue and allocates a new one. Consequently,
this reverts the admin queue's timeout (q->rq_timeout) back to the
module default (NVME_ADMIN_TIMEOUT), completely wiping out any custom
timeout values the user may have configured via sysfs and potentially
racing against the sysfs nvme_admin_timeout_store() function
that may dereference the admin_q pointer during the RESETTING state.

Decouple the admin tag set lifecycle from the admin queue
configuration and destruction paths, which are executed during resets;
Specifically:

* Move nvme_alloc_admin_tag_set() into nvme_loop_create_ctrl() so it
  is only allocated once during the initial controller creation.

* Defer the destruction of the admin tag set to
  nvme_loop_delete_ctrl_host(), the terminal error-handling
  paths of nvme_loop_reset_ctrl_work() and
  nvme_loop_create_ctrl().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/loop.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d98d0cdc5d6f..070d16068e6b 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -274,7 +274,6 @@ static void nvme_loop_destroy_admin_queue(struct nvme_l=
oop_ctrl *ctrl)

 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }

 static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
@@ -375,25 +374,18 @@ static int nvme_loop_configure_admin_queue(struct nvm=
e_loop_ctrl *ctrl)
 	}
 	ctrl->ctrl.queue_count =3D 1;

-	error =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_loop_admin_mq_ops,
-			sizeof(struct nvme_loop_iod) +
-			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
-	if (error)
-		goto out_free_sq;
-
 	/* reset stopped state for the fresh admin queue */
 	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);

 	error =3D nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;

 	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);

 	error =3D nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;

 	ctrl->ctrl.max_hw_sectors =3D
 		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
@@ -402,14 +394,12 @@ static int nvme_loop_configure_admin_queue(struct nvm=
e_loop_ctrl *ctrl)

 	error =3D nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;

 	return 0;

-out_cleanup_tagset:
-	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_sq:
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 	return error;
@@ -432,6 +422,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ct=
rl *ctrl)
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
 	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
+	nvme_remove_admin_tag_set(ctrl);
 }

 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
@@ -494,6 +485,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struc=
t *work)
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 	nvme_uninit_ctrl(&ctrl->ctrl);
 }
@@ -594,10 +586,17 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct=
 device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;

-	ret =3D nvme_loop_configure_admin_queue(ctrl);
+	ret =3D nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
+			&nvme_loop_admin_mq_ops,
+			sizeof(struct nvme_loop_iod) +
+			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
 		goto out_free_queues;

+	ret =3D nvme_loop_configure_admin_queue(ctrl);
+	if (ret)
+		goto out_remove_admin_tagset;
+
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
@@ -633,6 +632,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct d=
evice *dev,
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
+out_remove_admin_tagset:
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
--
2.53.0


