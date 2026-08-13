Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFAAC5CFCF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRwFD/O04K0U6MSC2TmyZX5RYo+ejqx5JXhh+D0Pk7U=; b=m/RKAyQZ2XUNVhsBsCF5Jjgign
	sah3/9jSCkV330uOGSCHH07vCMHCNdyvd9ugDWfDEHU2e+9LqH8j4mIfqFhAW/xnYt70P4OpGFyPA
	+rlcgnTGMGcFUO0d7oxJa5glrBf57bygh5kpKr9oPrCZMKCJ10ZOCyePgtzBO7qdtVeS7ejtoy5c+
	+hiwhajWB5Y9nvRXKWi6jiNTSVX7hVI6K27q6IVhachYVqiv1ZbGQBe+CPDj8C3+GeMuunZicnlss
	x430Xj3vNb7RR4ves5D5yhRzAOhsuerG1rR14KKlOvcHuBmTbe6y1cnWCmYyTAay9QNU7LcvvsT5q
	WT3+b3Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXPS-000000012IQ-3mR5;
	Thu, 13 Aug 2026 15:31:58 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXPQ-000000012Gq-2bUJ
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 15:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=1IelT60i/ZMCIY
	ChdDmKgPjgsq2CNW98mZI27OUckFA=; h=in-reply-to:references:to:from:
	subject:date; d=arkamax.eu; b=S/JBN8nR8yKV178AzNH5x6GWsQBKIdXXxrY5JcOV
	Yvc6XatN7a728jDYF2YYEXbBQC3yqwVas6+XVtQYXXCXovqgqQQWARHYt/tKJEu4hLhuPN
	Kwlr+2M7X8II5jU0eH+8b6vJZs/kq1HOpvEehehPWppjd5G0ODA2f71CsuEwIwAVMIVsNv
	OaVa5e24+4j+Z2Mx1FIVvYnBZgFPPPrDglgK2ATvP9u6FzhjiHommmlwhjuPZFQ3dWakKS
	Yzb1FvtRc4wAm+TSyZhqnyf+mNv6u4hR40V7fSFmTxdWVDRGYX942M3sjmPj94+F3GcRzI
	JKlVfHnb5cXsdOrTLtGbFw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 30bdf237 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 17:31:50 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 17:31:50 +0200
Message-Id: <DKNXAEPC7EPS.3QR0W5PXQ1ODQ@arkamax.eu>
Subject: Re: [PATCH] nvme: nvme-fc: Fix nvme_fc_create_hw_io_queues() queue
 deletion in error path
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Ewan D. Milne" <emilne@redhat.com>, <linux-nvme@lists.infradead.org>,
 <justin.tee@broadcom.com>, <Johannes.Thumshirn@wdc.com>
X-Mailer: aerc 0.22.0
References: <20260513192551.892309-1-emilne@redhat.com>
In-Reply-To: <20260513192551.892309-1-emilne@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_083157_291513_0CB14DCA 
X-CRM114-Status: GOOD (  16.73  )
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

On Wed May 13, 2026 at 9:25 PM CEST, Ewan D. Milne wrote:
> nvme_fc_create_hw_io_queues() will call __nvme_fc_delete_hw_queue() for t=
he
> last queue on which __nvme_fc_create_hw_queue() reported an error when de=
leting
> all the io queues if they cannot all be created.  This is incorrect since=
 the
> last queue did not actually get created.
>
> The most recent change to this code was commit 17a1ec08ce70 ("nvme/fc: si=
mplify
> error handling of nvme_fc_create_hw_io_queues") which moved the cleanup t=
o the
> delete_queues: label and changed the loop bounds, however the code was no=
t
> correct prior to this change in a different way.  The original commit
> e399441de911 ("nvme-fabrics: Add host support for FC transport") had a
> different error which called __nvme_fc_delete_hw_queue() on queue index 0=
 which
> is used for the admin queue.
>
> Fix this by correcting the initial loop index when deleting the io queues=
.
>
> Fixes: 17a1ec08ce70 ("nvme/fc: simplify error handling of nvme_fc_create_=
hw_io_queues")
> Fixes: e399441de911 ("nvme-fabrics: Add host support for FC transport")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> ---
>  drivers/nvme/host/fc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index e4f4528fe2a2..f5a83798f3a9 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2318,7 +2318,7 @@ nvme_fc_create_hw_io_queues(struct nvme_fc_ctrl *ct=
rl, u16 qsize)
>  	return 0;
> =20
>  delete_queues:
> -	for (; i > 0; i--)
> +	for (--i; i > 0; i--)
>  		__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[i], i);
>  	return ret;
>  }

Looks ok to me

Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>

