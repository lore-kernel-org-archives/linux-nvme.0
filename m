Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E6C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 19:31:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB08206D7
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dDI6bqya";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+aazRjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB08206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VLPVGxRLg1XEyZ//JjhVv1DMb5P9iFvX/KaIsvfMqp4=; b=dDI6bqyak+d8vl
	UqIASU9HuLvi9DY3NY7JlnNxyvPwh5s2gWJxCqEvEOWFC4kuAyNt9sMgqzYuK2VT8d6nCYSKLJp4y
	/z5sqYHCFq9uIdMkyfBRcr9OLpR1vRmxeC0ox9E/yTLyGqbVjTo75QfQgg4UmHPvjNhsEtCZLpRXA
	QV8WiGHIvrS7MAUi8R9+m7LfkSaF4VxaW8I1lf2kcBmrq/BrjsUPq7acV3/d06ABhTzoT8AgdsKJV
	jvLbh7qTwoBfGFf05/UzPt6M2Ko6+TOUBC5K15BglJg7oONpikdeY65RrSCH1w2IzGywFj+nddpKB
	dBOQ1ZjdYal6XA/+xQGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXsB8-0008HW-RI; Thu, 21 Nov 2019 19:31:46 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXsB6-0008HB-Cj
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 19:31:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574364703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ib5rcoCmtPuK/g17wBn0ECB7i9m87M7k1aLliVmkRPA=;
 b=C+aazRjxLPbK9rVUBP4Tmil/uycS2VqXqzkv+tCJTwS7kx5hx2O9bwEYCFeNEkJmyLjnHq
 lBjLt5hMQBxO+JDjK9a3tMZvTBaOBiI8lqdBWAG1GrKpp6tDY/CpBo/ZvbLSjS2aE1D0Gt
 VyByiguCBD6s4vpYv7ZWJo1HBXVqjq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-V4UynWf8MY6bHgL8h9q3Gg-1; Thu, 21 Nov 2019 14:31:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB36B801E58
 for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2019 19:31:40 +0000 (UTC)
Received: from emilne (unknown [10.18.25.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88CAD6683F
 for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2019 19:31:40 +0000 (UTC)
Message-ID: <aa5ab9ccface65cba94340384f5f790b0944de2e.camel@redhat.com>
Subject: Re: [PATCH] nvme-fc: fix double-free scenarios on hw queues
From: "Ewan D. Milne" <emilne@redhat.com>
To: linux-nvme@lists.infradead.org
Date: Thu, 21 Nov 2019 14:31:40 -0500
In-Reply-To: <20191121175937.19615-1-jsmart2021@gmail.com>
References: <20191121175937.19615-1-jsmart2021@gmail.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: V4UynWf8MY6bHgL8h9q3Gg-1
X-Mimecast-Spam-Score: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_113144_501557_9FD8B168 
X-CRM114-Status: GOOD (  23.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2019-11-21 at 09:59 -0800, James Smart wrote:
> If an error occurs on one of the ios used for creating an
> association, the creating routine has error paths that are
> invoked by the command failure and the error paths will free
> up the controller resources created to that point.
> 
> But... the io was ultimately determined by an asynchronous
> completion routine that detected the error and which
> unconditionally invokes the error_recovery path which calls
> delete_association. Delete association deletes all outstanding
> io then tears down the controller resources. So the
> create_association thread can be running in parallel with
> the error_recovery thread. What was seen was the LLDD received
> a call to delete a queue, causing the LLDD to do a free of a
> resource, then the transport called the delete queue again
> causing the driver to repeat the free call. The second free
> routine corrupted the allocator. The transport shouldn't be
> making the duplicate call, and the delete queue is just one
> of the resources being freed.
> 
> To fix, it is realized that the create_association path is
> completely serialized with one command at a time. So the
> failed io completion will always be seen by the create_association
> path and as of the failure, there are no ios to terminate and there
> is no reason to be manipulating queue freeze states, etc.
> The serialized condition stays true until the controller is
> transitioned to the LIVE state. Thus the fix is to change the
> error recovery path to check the controller state and only
> invoke the teardown path if not already in the CONNECTING state.
> 
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> ---
>  drivers/nvme/host/fc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 679a721ae229..2acb850bf9f4 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2910,10 +2910,22 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
>  static void
>  __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
>  {
> -	nvme_stop_keep_alive(&ctrl->ctrl);
> +	/*
> +	 * if state is connecting - the error occurred as part of a
> +	 * reconnect attempt. The create_association error paths will
> +	 * clean up any outstanding io.
> +	 *
> +	 * if it's a different state - ensure all pending io is
> +	 * terminated. Given this can delay while waiting for the
> +	 * aborted io to return, we recheck adapter state below
> +	 * before changing state.
> +	 */
> +	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
> +		nvme_stop_keep_alive(&ctrl->ctrl);
>  
> -	/* will block will waiting for io to terminate */
> -	nvme_fc_delete_association(ctrl);
> +		/* will block will waiting for io to terminate */
> +		nvme_fc_delete_association(ctrl);
> +	}
>  
>  	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
>  	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
