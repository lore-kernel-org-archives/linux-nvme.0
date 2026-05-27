Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC40CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTL6yZlbLP21Myxcr9pykEN+iHj6/xiPcXebu47xlN4=; b=RHVrTSvwPuSHpAKqJFp6aMdian
	Bf3/gN+ZG88E8w0cbgjSJ6Uc23aaLxf+dRI3LxO1a03Ulnu6vq7TE1VGk8XdYjvQJr7dLMIHCFbsN
	jTXMCkdLVqcVxLmzNPl8D8UMRWZ8QIEhAxy2mc4PJbwphEI6rFeaZGMqJ0KSw8MEahEwUPazGacAq
	YOZ+X/tUouzqm1OmzdVyt0oE8tem+KqjwSowKNakf1uMhNw7E+ydUxlh3MzgxmFPz1srVh/OO4LNj
	C2rIkT0XWGFzB9mvOXa7kuwwoRDW22UO6rWcKEYXxVUYXVyThnH0NfT24iQT2BLc9KvFmf/ms/qG/
	vXYJ01Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEXV-00000004Dvi-48SL;
	Wed, 27 May 2026 13:43:17 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEXR-00000004Du7-2oBs
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=fukSbpzTSZWbXh
	qD1K6i9VlLCv3zf2kh0B8sum8EzDQ=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=obpeadIUqP2I5XI/5KNw90N9d+23JNf/KLFBi
	P282M9/YqezvZYdnzdCbgNjQe4mze0TtnXy6Ww1ykg2A7XsSrNBrmRiPnvFYWDbT8KHObj
	2LPp5NUNYaWrkAt3EA1fHIDEP6LUZ7gF158s64zvPNB17u3KBfXqDh6w/kfxnqMLPJ3+8c
	V//rVPvjvH8olWSD0W0Z3JzSSm6nW48XY4x+AepgNDdLWrCJh/mFFk8eA9nVYRIVuHJEeM
	6msfz2wqHR1IgkpXKAztUG8H49ob0+w+KftL6JSBW0JPbaFbnoDWsCSrVn/0M89DGGXLyK
	du33P1jBJ6H3Icr2aP6gTPJUw==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id dcdf1598 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 May 2026 15:43:09 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 15:43:08 +0200
Message-Id: <DITI4P5FYA3L.I5QN2QBDOK14@arkamax.eu>
Cc: <dwagner@suse.de>, <mkhalfella@purestorage.com>, <hare@kernel.org>,
 <hch@lst.de>, <mlombard@arkamax.eu>, <linux-nvme@lists.infradead.org>,
 <error27@gmail.com>
Subject: Re: [PATCH V2] nvme-core: fix unsigned comparison warning in
 nvme_wait_freeze_timeout
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Maurizio Lombardi" <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260521153716.548351-1-mlombard@redhat.com>
In-Reply-To: <20260521153716.548351-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_064314_347132_9473A12D 
X-CRM114-Status: GOOD (  15.00  )
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

On Thu May 21, 2026 at 5:37 PM CEST, Maurizio Lombardi wrote:
> The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
> Checking if it is <=3D 0 triggers a compiler warning because an unsigned
> variable can never be negative.
>
> Fix this warning by changing the type to long.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202605211257.STzj2Ujv-lkp@intel.com/
> Fixes: 23b6d2cbf75f ("nvme: remove redundant timeout argument from nvme_w=
ait_freeze_timeout")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>
> v2: keep the <=3D comparison, change the type from unsigned to signed lon=
g
>
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 72c50d5e938d..554649ffe430 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5246,7 +5246,7 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
> =20
>  int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
>  {
> -	unsigned long timeout =3D ctrl->io_timeout;
> +	long timeout =3D ctrl->io_timeout;
>  	struct nvme_ns *ns;
>  	int srcu_idx;
>=20

Keith?

Does this one look better to you?

Maurizio


