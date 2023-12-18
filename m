Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89681C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqWW4iSEe5Qt/nSSGu/Y3LT1iTpOXu9HO0tPP1tnb50=; b=b5UC16SPhPjzRCY6m3EWdjYrX/
	nLDarxO0ToHkzRA0mZvaKlzHhl0BOhdUduqFX+D2bp42LMpXMnCboHzU2SyPeAhFQdsc2daPJ9sSC
	Q932LsUfWuHd7mkjQgR2JNdadoXkvJd9nnMLpyXb+tnnnv41gnA1RL3ZzGu+U55evBW/7CJp/ygB9
	mido9vowf4K3HD+VFk1x38Wx5EjrpWOmRnopvQlJY6eFCS9SRAy8kO0vEdk8MsYRAmT9JUp2/ixkV
	wZO3MYk3M80BbSt+4HdNxaqk/0thynUnLafpbr3YGknvZVoLUfIFaHcGUMTh8KREEl9q7FuoaU5ER
	M0mA0AxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFG6v-00BMHZ-0G;
	Mon, 18 Dec 2023 16:04:53 +0000
Received: from mail-lj1-f170.google.com ([209.85.208.170])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFG6s-00BMGf-2x
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 16:04:52 +0000
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc64237ee0so4354891fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 08:04:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702915489; x=1703520289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqWW4iSEe5Qt/nSSGu/Y3LT1iTpOXu9HO0tPP1tnb50=;
        b=KTE0DBj0LknLXv7FpuTWIWaLUDv9BwvEni9J7fHc/LYKcXvMDgIEXq1XwgY01L1UNL
         EeP++5QtBNdTZhObkowk5zio4GdWXFu3m6f73RF9pjIChqxpnJq0C0sma0ZnPxgk60qE
         VT2vYIoZPxG+7fyKttgJqLn9hCJ7MH6IECli9S3S9InmSeC2KS8lB92EOXJUQyxv0R9G
         Uf56OIbqKi8i4JasG/TLOSU20GV57LyiFz4eKNiQZwK2yTTpMtXc41xypsrHn6PdnUgD
         WS25c+7Aus7CoHa5rgXoMygpiV7LHo/xKVkRKG6tzbxZJU/h4s67yBXB7tF61ZBxZ3HT
         CHIQ==
X-Gm-Message-State: AOJu0YzRE8Tmnkgq+1SHDBh6m9OnanXOAE8STxDumhtMRlxRqnsvjAd+
	65HAvyK1kk4u6uZARq+97Kg=
X-Google-Smtp-Source: AGHT+IFVVKnAqgzEq3AL2vGbc6fiuIIyK+FfA5MVD0fqngArQHBNIJBrdQQRqbBDpxX7Y4NaKBVnCg==
X-Received: by 2002:a2e:bc02:0:b0:2ca:143:a52f with SMTP id b2-20020a2ebc02000000b002ca0143a52fmr18133584ljf.2.1702915488331;
        Mon, 18 Dec 2023 08:04:48 -0800 (PST)
Received: from [10.100.102.14] (46-117-87-214.bb.netvision.net.il. [46.117.87.214])
        by smtp.gmail.com with ESMTPSA id gw18-20020a05600c851200b004063c9f68f2sm41787105wmb.26.2023.12.18.08.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:04:48 -0800 (PST)
Message-ID: <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
Date: Mon, 18 Dec 2023 18:04:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ioccsz and iorcsz check failing
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_080450_952989_8F665042 
X-CRM114-Status: GOOD (  13.01  )
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


>> Is anything else in the identify wrong, or is it just these
>> fabrics fields?
> 
> So what I am seeing on the wire are a few fabrics commands (connect, get
> property) followed by the nvme id ctrl command (opcode 0x6).
> 
>   nvmet: nvmet_req_init:962
>   nvmet: nvmet_parse_admin_cmd:1011
>   nvmet: nvmet_parse_discovery_cmd:359 opcode 6
> 
> This calls then nvmet_execute_disc_identify, so adding
> 
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>   {
>          struct nvmet_ctrl *ctrl = req->sq->ctrl;
>          struct nvme_id_ctrl *id;
> +       u32 cmd_capsule_size;
>          u16 status = 0;
> 
>          if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>                  id->sgls |= cpu_to_le32(1 << 2);
>          if (req->port->inline_data_size)
>                  id->sgls |= cpu_to_le32(1 << 20);
> +       /*
> +        * Max command capsule size is sqe + in-capsule data size.
> +        * Disable in-capsule data for Metadata capable controllers.
> +        */
> +       cmd_capsule_size = sizeof(struct nvme_command);
> +       if (!ctrl->pi_support)
> +               cmd_capsule_size += req->port->inline_data_size;
> +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);

Yes, this is the culprit. Nice that it exposed a bug.

There is no in-capsule data for discovery controllers afaict.

