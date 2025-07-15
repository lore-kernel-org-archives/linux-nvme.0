Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708A3C83F1D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m6iuHSGE/vZuISt3qNIpWnKcZ1D4onmuE4rPXHbKh0s=; b=KzM6Bo3Ys86YZufI5MeT3ZSBoS
	HqPa8WJjozDZMme4jgOM2TSafiD1If6Ux641XR+Tx1nWSNalkBWP39l5YtfxpHYHFqCT+Aj6rCThU
	L2G6nkszT0CzYokdY9hOG3mdr7F0ECmyw9WoW5i/wjPb84jKLHulnchenA2XOYHL2isBmYZk/xLKe
	uObuFDjDgCL+OpoMoEv8o5IbHjcPB9+q8YMH2iUnwl5EDqsl9Enta1WygXW5KfmCJ0mCQO8lsBma6
	B0ecmJNS4MJSJ+AuTVSSvz1mNMJJ3RAPSN9gqAenZPHfLiuygV+lr1n1G3LOO7zpDBvtC8F4J0mZW
	q/zD0t/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubcND-00000004lTS-31KJ;
	Tue, 15 Jul 2025 09:54:55 +0000
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubbux-00000004fdf-1VbB
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 09:25:44 +0000
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-711d4689084so50332737b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 02:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752571542; x=1753176342; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6iuHSGE/vZuISt3qNIpWnKcZ1D4onmuE4rPXHbKh0s=;
        b=G28aI0TnZPSFQ+ysyvjeXMyqVTMIcQJ2NerZGpAPLoATJMmyGLrcL7xuw9g9Kgnr5e
         4ahyh5vvWxwiLWGm1urjTKfbvYjZg5bEGNiJUP+g8FOFmNMPvx5lTfCiN8wNUnDwwGDt
         IzrxRXjSRdKC8aN5+LzDunIchSKSWPw2VqH+3dK8sLGks6d/l5cOIdBO6ad4GlREU2ch
         eF03V4lxGaG024F4Vf3lHt/9bahmcCnCRc4Ycv/tvXL4iS5c3+7Ixgg2yIn4NUeit3Nw
         3YU4ii5bd9gVmOj2pWLKXWcCGE23DcbYbRKhNCgXDiL6Jx7vsEhaMYMqizNpXaqZeuYx
         rFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571542; x=1753176342;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6iuHSGE/vZuISt3qNIpWnKcZ1D4onmuE4rPXHbKh0s=;
        b=R7VaMx6aT4D+0GEFJguTy8skZKHuP+uWYWaJMOjtOL63WilBNV120FmTyGMdXQNqfJ
         NAdJT0SG7V51j9WsSD7dlwTTTn29gqiZWUS1t1nM467GwSvXDC8+bCAQCeWZyeGazTd9
         BryAEeeQxwOVLFHoeyWvvzKiN3OFDDCmlPdWnJ0LL3ik10OaroaSC0UwAmarncjBYSP3
         k+Dt56by5o6dS6gJOyp7FZwMd/TiFEHmm6LaLYIB41qtKd28Q1VyikwvwZSlGnLTZ0Od
         FlGhvPQaHaPVUkny4t6kZCzvD4+syz7kjwDSuyW8HHT5njdr6tzNq/iTpiVf7fsXk9iV
         QNnw==
X-Forwarded-Encrypted: i=1; AJvYcCXHzojBvh0cgreDvPmeMGsJW0FgfDH0zD0rQ7OBz2hdFzZxF0k9UaRGQdn+PsfSE+8xpjOhIjVQ6tQu@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4Q6EahLc5s2wkyN04tqVr2hteJuPxF1GyrnNp1eRaWV0h6f9L
	SxoI1ZIMlFeReJY3EnjmTIIPL+FJnlhzkyYOsRFnyys0M5PBQctZN+3nT5A3ql+8W4gRennkV15
	K1bBygZbulwarHMvGbgEYyEX5u0EHCXo=
X-Gm-Gg: ASbGncvvSlGxzxA2Wp2NDpJuHebh5UXx6doMXWmDXRqYL9CYBGHKoCn6U85OfnpBiVW
	5QnyI6gkv8/BIKwAjqmgvsZl3oUOFwbeuqZgTbbVFVyCeo7pUlTOFZEM3aUvtgPnd6nyJrWD5p1
	SBxDukXj9X4rooWGd3ICwsiLiCcVm79gceR8vbjr+tae5EraXAQI5tbBRdVtcbPZozUIyqlLwZ+
	Y+60t5amRQOi8qbD73ulp88U5Hf7iSBun/LJpM5l0FIqtoE9w==
X-Received: by 2002:a05:690c:9c10:b0:718:113b:a5c with SMTP id
 00721157ae682-71824af6ed1mt29005417b3.10.1752571542361; Tue, 15 Jul 2025
 02:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 15 Jul 2025 11:25:04 +0200
X-Gm-Features: Ac12FXzA95YgXoxLQ6f74t0E_Gn3zhZLRnGtrisY8g0SjgFtHHFg3IEcz3eTn5U
Message-ID: <CAAEEuhrtDcKfFF9NuME89tziuqYz4Y5fwepKE0kjSQD_6fzb2g@mail.gmail.com>
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_022543_398856_3A1DE4A7 
X-CRM114-Status: GOOD (  25.78  )
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

On Tue, Jul 15, 2025 at 11:18=E2=80=AFAM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Have nvmet_req_init() and req->execute() complete failed commands.
>
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
>
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
>
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
>

s/doubple/double/

> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.=
c
> index a4295a5b8d28..aad828eb72d6 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvm=
et_req *req)
>         iod->status =3D le16_to_cpu(req->cqe->status) >> 1;
>
>         /* If we have no data to transfer, directly complete the command.=
 */
> -       if (!iod->data_len || iod->dma_dir !=3D DMA_TO_DEVICE) {
> +       if (iod->status || !iod->data_len || iod->dma_dir !=3D DMA_TO_DEV=
ICE) {
>                 nvmet_pci_epf_complete_iod(iod);
>                 return;
>         }
> @@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct wor=
k_struct *work)
>                 goto complete;
>         }
>
> +       /*
> +        * If nvmet_req_init() fails (e.g., unsupported opcode) it will c=
all
> +        * __nvmet_req_complete() internally which will call
> +        * nvmet_pci_epf_queue_response() and will complete the command d=
irectly.
> +        */
>         if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabric=
s_ops))
> -               goto complete;
> +               return;
>
>         iod->data_len =3D nvmet_req_transfer_len(req);
>         if (iod->data_len) {
> @@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct wo=
rk_struct *work)
>
>         wait_for_completion(&iod->done);
>
> -       if (iod->status =3D=3D NVME_SC_SUCCESS) {
> -               WARN_ON_ONCE(!iod->data_len || iod->dma_dir !=3D DMA_TO_D=
EVICE);
> -               nvmet_pci_epf_transfer_iod_data(iod);
> -       }
> +       if (iod->status !=3D NVME_SC_SUCCESS)
> +               return;
> +
> +       WARN_ON_ONCE(!iod->data_len || iod->dma_dir !=3D DMA_TO_DEVICE);
> +       nvmet_pci_epf_transfer_iod_data(iod);
>
>  complete:
>         nvmet_pci_epf_complete_iod(iod);
> --
> 2.25.1
>

