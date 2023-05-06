Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5FC77B7C
	for <linux-nvme@archiver.kernel.org>; Sat,  6 May 2023 03:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdMPYfbqUvqx1VS6WVNqiqHNhbYxuIXZ5Z67rSWQStI=; b=4KzNlv2IxUJDdpqzCasDx3VhaB
	LXSiTtGEVyptDtyWJp3M4zkYlXV6AEw3aX2btuqXtihOg74RzuxvlYjXCe+3X4FmDDphFlRWORO0k
	W6qrdO9CH9Y3WezvG/B35lIFZgmuUBm7+XFWiUkjMn7bKtqQpOMWQ8+wIzhWKcJkGnXzXzUDX5XuQ
	f2zQVKCMS4YJ1ZUXhivPlfhY2IdkY3Y0NVkRWILTnvSaV/fnW1zOl+WbFrfxLojwrMgJyIPyyy9bl
	GbnZdtc/gjBiSNTk7VfEGr5fY0yPi+SbXXhOMQvscBx1o/wblw4cBBCVVoQj6nFjO0l1RNv6P8/Zk
	o5AWPcLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Ti-00CRFS-0H;
	Sat, 06 May 2023 03:20:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv8Tf-00CREZ-2L
	for linux-nvme@lists.infradead.org;
	Sat, 06 May 2023 03:20:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1683343254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdMPYfbqUvqx1VS6WVNqiqHNhbYxuIXZ5Z67rSWQStI=;
	b=YRzhIHkzbrzh8OqXqDQ96DVsdbltFZTzbnctXKigOaYpCgpxUL+IY8fB9YiEYJdNYbEb01
	LR3JGxydAiIi16CoShPiUK4QeZigMMhL3fZ1CPIkRPnXjutnB97wz9L9lhl7FIxahePJos
	geGrD8FGh+6/cnu70yZqgxEoyiMykzw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-dVRTBqssMQyFD3ssTUKtJg-1; Fri, 05 May 2023 23:20:52 -0400
X-MC-Unique: dVRTBqssMQyFD3ssTUKtJg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1ab28ec0facso12750365ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 05 May 2023 20:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683343252; x=1685935252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdMPYfbqUvqx1VS6WVNqiqHNhbYxuIXZ5Z67rSWQStI=;
        b=Oc/XnEfz8dA1ZMHJ+2pMc70rcd+FEF5/qyU0a3mYeAkokrTlPEE+emec0NVac4u1wa
         qdWO+Gy1XHhDazr3C1dZBsEb9KV4U/oxqySE/5ov4Of+Uorzlc7nAMgfHdCMIHpdQeYS
         iBd8bFj7Y2vR9X995RDD2FfFwTxlvSHKNDsMrWjzK8YZaKlm9nBLDcqtmRP0NS3gMCRA
         HURFBvGQ3vNLtOo8Sw1xHuqZXnyvmoQGZ17iQ/o6clB+9XCGBLdhsgESpi1bhK2kHpRu
         LLXqeOC6zxjd1Ze4f58Ryk+sly1tS6rK3l8liZ2BVIyYAaDshkfQk3TBMJrekfScHyj/
         KVFg==
X-Gm-Message-State: AC+VfDztS3gaEhMFU0mb+9Zsc6zf3ruUVx/6sDxEO++zoCp9bat9iO/r
	kyi0t7n8ivJUASLzJk+6EWfGEGxC9IutTPLtD7/lKqL1TlfnCmUACAF0oXfdWer9TlaZB52xTu2
	UTZ7fmwFCmvmYNU3b6y+bUhR90Zx5qzBpYZIYIjNXuQ8=
X-Received: by 2002:a17:902:ce82:b0:19e:4bc3:b1ef with SMTP id f2-20020a170902ce8200b0019e4bc3b1efmr3929885plg.64.1683343252031;
        Fri, 05 May 2023 20:20:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XS9Te17i0C3FyHNiIXVvHTRqoTM7FSUksk6iyTPnp4ljKeZ3R+fG8nPFnCnJzT4JOLWP7MtgEbz3swU6xPgA=
X-Received: by 2002:a17:902:ce82:b0:19e:4bc3:b1ef with SMTP id
 f2-20020a170902ce8200b0019e4bc3b1efmr3929874plg.64.1683343251746; Fri, 05 May
 2023 20:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230428073115.22987-1-kch@nvidia.com> <20230428073115.22987-4-kch@nvidia.com>
In-Reply-To: <20230428073115.22987-4-kch@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 6 May 2023 11:20:39 +0800
Message-ID: <CAHj4cs82aak1CYd+bH6bvpg4jmddvuk7cy2UP8t_=0G0pm++Gw@mail.gmail.com>
Subject: Re: [PATCH V2 3/4] nvme-core: add missing fault-injection cleanup
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_202055_866461_B947D380 
X-CRM114-Status: GOOD (  14.03  )
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

Confirmed the issue was fixed, feel free to add:

Tested-by: Yi Zhang <yi.zhang@redhat.com>


On Fri, Apr 28, 2023 at 3:40=E2=80=AFPM Chaitanya Kulkarni <kch@nvidia.com>=
 wrote:
>
> Add missing fault-injection cleanup in nvme_init_ctrl() in the error
> unwind path that also fixes following message for blktests:-
>
> linux-block (for-next) # grep debugfs debugfs-err.log
> [  147.853464] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [  147.853973] nvme1: failed to create debugfs attr
> [  148.802490] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [  148.803244] nvme1: failed to create debugfs attr
> [  148.877304] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [  148.877775] nvme1: failed to create debugfs attr
> [  149.816652] debugfs: Directory 'nvme1' with parent '/' already present=
!
> [  149.818011] nvme1: failed to create debugfs attr
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/host/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 42e90d00fc40..15607281baaa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5201,6 +5201,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct d=
evice *dev,
>
>         return 0;
>  out_free_cdev:
> +       nvme_fault_inject_fini(&ctrl->fault_inject);
>         cdev_device_del(&ctrl->cdev, ctrl->device);
>  out_free_name:
>         nvme_put_ctrl(ctrl);
> --
> 2.40.0
>
>


--
Best Regards,
  Yi Zhang


