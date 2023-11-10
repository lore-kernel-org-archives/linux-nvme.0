Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C5C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/7i9GfBzLYRqub0vvcSZDvN8mN75jk1jpsXVRU+8YUI=; b=3DVIPTGlriwknJblqlHY0ioi2p
	/YGzx4Wm+N2Xf6DWe0UK/G/azBPOhVHu+RXUIgJSPnVpqYRBovfoiUsiC/2CUWdpt4uNkz2cbzD9t
	CFX0v23bFCD7b4dSwLQQShUE4EV8cD8jsiVg9GlomrDqnWAilzbn7hfRQFvWI0eBWHlmSk3770fLS
	D63q4zAQjClODQhCo9quynn5T96scBc8jB0j6JwEfW2k6ZQ2Hhs8YTDhzhnE+QPVnRaMh7/FLqpF2
	TbvuvUvomIs04DQ6butsb4DecZ0JEQRaAfJiSVgwneV4WJWSSE07NbT/RivXB8ndZXxELSfF864v9
	CbiSghdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1TZR-00926P-24;
	Fri, 10 Nov 2023 15:37:21 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1TZP-009262-04
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 15:37:20 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1966706b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Nov 2023 07:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1699630637; x=1700235437; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7i9GfBzLYRqub0vvcSZDvN8mN75jk1jpsXVRU+8YUI=;
        b=e4cOGoJmIPjU8/8+rb7DH9sViiC/a7/LDrB4pbu5V7Wq86sqG2aPs+zlZfZ8I7l+DK
         5A8vpMGqOusNq7MEPZwa91fPF5K9/fmVAh6y6xEryDAzPpuCXSEj8KfOXO9JCDc+ZNPI
         MPnnwG8S5QWKfDSzYClRlu8vqd3D15UyfJBCZPEUFAaJRTW2wBF4C2OoxJTXNYz5Sv/h
         er/eYn3aLnSho3mTsoPpuNotG7eTBDaX9ngsM7ygupcXcz3pxPoSYqG+3TzuqTT9aNqO
         +jmO4Xx47tQHhJv4JVlYyqCT+529jtVDQLrWyxNHKDNxnkQQLfxa/IHxMO9bMAVrZTeu
         v05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699630637; x=1700235437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7i9GfBzLYRqub0vvcSZDvN8mN75jk1jpsXVRU+8YUI=;
        b=Me3W/HJPAFQqAwiF4hFhkBN8/RGZu938OiQ1GGZUJts3yARvbr61P9WlnS/m35CjOU
         DNvIX2EPlpU/TeZJpIlY0507QbAHRgtpqBhJALPt6KtUy+oPxQrO+uYJErjtWFfwSIkI
         8mzrZR+1Mnqmf8IG3KhYgPdsC50G1nLZ+2Vu7Eqc+9oZgO936W0OyiVPweNafE2ciHGu
         PM9uCoZSmyBcxZoA64T7y4tSTGyXuFWjavuegt8eOYQdeL1kC2M6SH5+93d1uuPgKazp
         HyWKiaSUej7Xfj/bp9cPTVQePekc7Okzp/PuPtKR90ZJ7nxAgzgbwFFxrXrwXFkIeuUS
         LXsg==
X-Gm-Message-State: AOJu0YwA2QLf2T8mCswkbemYhmZgm94pH3h8Vm01k9MKJLhGoSwzXVty
	VMa0j2RGrTQcI7H88vgGKJDO/LZjxg5I7LL12Tpgwl0FkL4iTij2kk2XLA==
X-Google-Smtp-Source: AGHT+IFvGWmrCPuNZ5ppZEI0jdBlcGYV5rO66kQJEnGRGJ4So1wBUoYvVut8qvi0zS+9/Sao18r0JDupAj78eGT3k3I=
X-Received: by 2002:a05:6a20:4e23:b0:181:219f:4a6c with SMTP id
 gk35-20020a056a204e2300b00181219f4a6cmr6361958pzb.52.1699630636822; Fri, 10
 Nov 2023 07:37:16 -0800 (PST)
MIME-Version: 1.0
References: <20231110063837.810134-1-hch@lst.de>
In-Reply-To: <20231110063837.810134-1-hch@lst.de>
From: Caleb Sander <csander@purestorage.com>
Date: Fri, 10 Nov 2023 07:37:05 -0800
Message-ID: <CADUfDZpp4hen-K4zZZM_W1_2XaOomW-5aEDzaOXLyNv9Q3ZnEg@mail.gmail.com>
Subject: Re: [PATCH] nvmet: nul-terminate the NQNs passed in the connect command
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	Alon Zahavi <zahavi.alon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_073719_201963_6E3E6D38 
X-CRM114-Status: GOOD (  16.84  )
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

Won't this overrun the subsysnqn and hostnqn fields? Writing to
subsysnqn[NVMF_NQN_FIELD_LEN] will clobber the first char of hostnqn:
struct nvmf_connect_data {
        uuid_t hostid;
        __le16 cntlid;
        char resv4[238];
        char subsysnqn[NVMF_NQN_FIELD_LEN];
        char hostnqn[NVMF_NQN_FIELD_LEN];
        char resv5[256];
};

I think clearing the previous byte (index NVMF_NQN_FIELD_LEN - 1)
would work. The spec requires NQNs to be under 223 bytes anyways, so
they should never take up the whole field.

On Thu, Nov 9, 2023 at 10:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> The host and subsystem NQNs are passed in the connect command payload and
> interpreted as nul-terminated strings.  Ensure they actually are
> nul-terminated before using them.
>
> Fixes: a07b4970f464 "nvmet: add a generic NVMe target")
> Reported-by: Alon Zahavi <zahavi.alon@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/fabrics-cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabr=
ics-cmd.c
> index 43b5bd8bb6a52d..0920fe7ce4ac99 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -244,6 +244,8 @@ static void nvmet_execute_admin_connect(struct nvmet_=
req *req)
>                 goto out;
>         }
>
> +       d->subsysnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> +       d->hostnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
>         status =3D nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
>                                   le32_to_cpu(c->kato), &ctrl);
>         if (status)
> @@ -313,6 +315,8 @@ static void nvmet_execute_io_connect(struct nvmet_req=
 *req)
>                 goto out;
>         }
>
> +       d->subsysnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
> +       d->hostnqn[NVMF_NQN_FIELD_LEN] =3D '\0';
>         ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
>                                    le16_to_cpu(d->cntlid), req);
>         if (!ctrl) {
> --
> 2.39.2
>
>

