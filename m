Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06A3EB5946
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pynOJ6xtpyfLsY0oXS0gXXpSBuX00dn52wN+gJKCzVg=; b=elLpalVZzozsKPo95Evs3lkdhY
	pBYf+NNvrmmXOcfbu2Lb4yUm3FQG2uHGtvTf67w4Rh/e3WLpwACCkAiyi/nvv70unAs0eqxopvVzI
	OT+OwmsHpApvni4faGgiEnNvh5iJ2kZBdU1akgsiiMCJApLitgy2NjWEzvMFoQ/lO1WfBhNPhPWSp
	RUpX7SzOM2U5qZHh0ZhYtosMZ9CPABaW9/YEuh2rQ2LF77/6vzOefd9rDFuzlaxV0EmaVEsjFDJ4b
	+JhaKaSbrcP95P1l9KaDnwRUBMN7/z+z8KB71GWjSJl84i6UjYHKv672VrIGFDH2uUB6V2FrCaDH3
	GbIqMwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpyRh-0000000043A-09Ye;
	Wed, 11 Feb 2026 00:51:09 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpyRd-0000000042k-1wHv
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 00:51:08 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-5fc4857e080so502658137.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 16:51:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770771063; cv=none;
        d=google.com; s=arc-20240605;
        b=BaAbiAzTaL0Qc1f12dmOETbNHKtSZQennOCgoXjZnU+BErKSP/QqoAryEubu+/eDJF
         6qW6PHxK6em71l4NtOGDMf0/vjyl1gq6Kq2CRIyhk+htqIBLuIoNvJvA3kVqOhNgYzJR
         6YHzzKxfPKZ01HQ2NVfEQ404eFWGpm8ajpGoLq8lFRUIQP970kpHEDuzKDlmJ0bU6jgI
         F+UjvwLjG/khEmgc765M0xOM4XDUo0K7qfKRTwd/AKGYKiM5muuOp4N1p+cFDP6SWftY
         hFGbp85YjIw2GPwtAS8S14FxAOYf/tAzcs3LUnOpHFFcbmqcuAgAPiiOg2ZFn+Ht36d/
         1avQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pynOJ6xtpyfLsY0oXS0gXXpSBuX00dn52wN+gJKCzVg=;
        fh=hUFp7PBZTODhkJdnnj+rlQ5LLKQOuDHpHxSbM5+HnlA=;
        b=MrxqpC6VkVEwshIVVJFq725sM74xFNupQRxNkn+iClfFlRQd/gf43rirMr8cKlGE93
         kPzYO+QA6ebpX45L6ncVmEq8zmyq3Z1XuNC64+75VjQWUXwrCGfeNFws2/o3oHeunplS
         0H872zoRCszxH8GDnafKGOWM6OUFzateg2TPs8+u/aQay9Judam0naXL37VQ40+lamAJ
         dO4yGdPOHV4E7QOlc7YyQeznOEcclK3OmbXYFfqQd9o/jc7+pRg5H96FVRNC3uvPyGQK
         IXsj4zVGdfY1otVnVo39Y/7rLEOSFiFy3AyCIPxwlvL2/rAz54ovy54WYWV58CH46FJT
         MtYA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770771063; x=1771375863; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pynOJ6xtpyfLsY0oXS0gXXpSBuX00dn52wN+gJKCzVg=;
        b=C8xFaIA1q70agBPOQLmhF4aFhiFYrusklVryjeO35hPH5pR5j32Js34xWvUt402cDO
         2lElJO6U+kZop/tfvcLikw2b2e3IhhWYWFCjwvfPOafqxQaVuS7dIhNASJ6PKc8WJoBe
         Wb/0VTk1tHvgs0GNwNzgXgjnjVq2QC3GtJT9fgFobA4w7a32a7FqtYTkMFjsKZ8I2SIG
         45VEHaXLm+aWSVO2RsUFb6L0DL3MmJyWIBEkgyEagBRMgwN8y2+85ZP7YDmWsoQeEquZ
         4o/hJWCswndv1ySEwIV66ULHJA6hvHU9EpSwlIUua4JPEWnqu4EYZ5TJu4Y/hOyV6rSc
         bNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770771063; x=1771375863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pynOJ6xtpyfLsY0oXS0gXXpSBuX00dn52wN+gJKCzVg=;
        b=ROFl4SgcQTTS6bpaAlp2xYBwRJfDyXo5XnEizdOua9j95ijpO1LI+MR6mP5AQ5hU+6
         veyRoSV1/hH1UxdzPGwOjnK/y/9qc1H5hLBcnB7F9sJlZmUnCzijJyu8owpOCGfV7nn4
         yUSzAop5E55JaY2OZtWEWqqF4bzSIXGv5FrC+K3BGvFgMG73U5vIvkzuNG8d9Huzw8UH
         BYnA/Y5TIBF1DtX2UryuG8hftOQHBxeVHc0q8sYrZpzmOEdX1XhKWblemhtIinmpjLp9
         Wk7JMtFt3XO3MuIEaBu3i0TnfouyEnsQcaXxnQgs28KrcaHoNagcR8hwB/luQrQDcm1r
         9fOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOCUBo9p4vWIyrhwPSnz+CSkyPwpqOmyGkUR3iY4oDZjleErHHU71ePLlaBV2GF451KqKnW3/U/nrP@lists.infradead.org
X-Gm-Message-State: AOJu0YxvJaBKb08bTPBNH/tBUvTSAtFLHPk1iINxYEPOT00c/0+WPmJN
	Z+8fm7Uh7ZKNFjYabUal8bLyblpOnxz9cgjx7kJgUohNF7kcQN2dC4jKC0E7KQRbtJxH7dCSSdk
	107m0RVXa09a8Ruvpc4EBwbSZeKctuj4chl2G3vzZ2Q==
X-Gm-Gg: AZuq6aLMnk8xIzk2NB/61InIIn5Shba07sdlgzrNk/bhvw0sJzbXxo5EPL0dgtj8ybs
	r8bk9S1VN7/KgV+Jdsio9aHTNtfM4KfFGJH7lQhOKTO5u79coFmsnQXPp5MRhVzE6681CiQx3m6
	AL+9HDXEdeGE2YxB0R5fx9h+LHugqZ1BkDB/J9q8497SRl/WJozxuvenHl1qtqVOZpDobfLnaZ7
	QCQoqghVsezXKirfb1mNGllXaGUWoTYLhe0H2W1lDTuy19MIty1xcWNplsFyqb7Vo39dqJjOyDZ
	dulFjHA=
X-Received: by 2002:a05:6102:3ec2:b0:5ec:f42c:79e4 with SMTP id
 ada2fe7eead31-5fde41e7d2amr283659137.12.1770771063336; Tue, 10 Feb 2026
 16:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20260130223531.2478849-1-mkhalfella@purestorage.com> <20260130223531.2478849-3-mkhalfella@purestorage.com>
In-Reply-To: <20260130223531.2478849-3-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Tue, 10 Feb 2026 16:50:51 -0800
X-Gm-Features: AZwV_Qght9kCfs2QE9tNVGObXx7eldaGy1kB-xXxo_P8zGGh9ykHJT-dXYLbvHg
Message-ID: <CAPpK+O25W1MUoxoa5bSXYpQf248DM7MreCM2y+MOCoY7MCJY0g@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] nvmet/debugfs: Add ctrl uniquifier and random values
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_165105_680925_17AEE06F 
X-CRM114-Status: GOOD (  16.17  )
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

On Fri, Jan 30, 2026 at 2:36=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Export ctrl->random and ctrl->uniquifier as debugfs files under
Please update to the new names.

> controller debugfs directory.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.=
c
> index 5dcbd5aa86e1..1300adf6c1fb 100644
> --- a/drivers/nvme/target/debugfs.c
> +++ b/drivers/nvme/target/debugfs.c
> @@ -152,6 +152,23 @@ static int nvmet_ctrl_tls_concat_show(struct seq_fil=
e *m, void *p)
>  }
>  NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
>  #endif
> +static int nvmet_ctrl_instance_ciu_show(struct seq_file *m, void *p)
> +{
> +       struct nvmet_ctrl *ctrl =3D m->private;
> +
> +       seq_printf(m, "%02x\n", ctrl->ciu);
> +       return 0;
> +}
> +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_ciu);
> +
> +static int nvmet_ctrl_instance_cirn_show(struct seq_file *m, void *p)
> +{
> +       struct nvmet_ctrl *ctrl =3D m->private;
> +
> +       seq_printf(m, "%016llx\n", ctrl->cirn);
> +       return 0;
> +}
> +NVMET_DEBUGFS_ATTR(nvmet_ctrl_instance_cirn);
>
>  int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
>  {
> @@ -184,6 +201,10 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl=
)
>         debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
>                             &nvmet_ctrl_tls_key_fops);
>  #endif
> +       debugfs_create_file("ciu", S_IRUSR, ctrl->debugfs_dir, ctrl,
> +                           &nvmet_ctrl_instance_ciu_fops);
> +       debugfs_create_file("cirn", S_IRUSR, ctrl->debugfs_dir, ctrl,
> +                           &nvmet_ctrl_instance_cirn_fops);
>         return 0;
>  }
>
> --
> 2.52.0
>

