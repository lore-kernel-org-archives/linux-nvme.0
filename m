Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89E2C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338DF60233
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338DF60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0sNGtzpLejPYdoTXjXZuHxVtMEUdPiXacWW/h00ID5U=; b=f9FyRfQotVIUCq3sITG6qkKT9
	ZZ0S/eirwQAKSMbgLskDwwhBaK2iIyXBoR6adJgCZU8N5UozlSGK+3Pgist16J/tgbF6q0P3Z8mDT
	Frm01tx+mN5wV6yFNGZc0a4HZ2nqMdvere67Wld79LTQe0bRI11b4vixHR5uhVBEWB3aoHB5/W5XJ
	qmT4Fdq+VrDBJ6FDNDypZhaIZ1ki3nEarBWLK2ufw6R5uo8vwWYtraUHypNYBRDowxJb9GMRfjUi6
	h9qay3/nk17TXRQb3IpUc+F+Jj0OV0pjwfZ48f7VE8pMILgayJj0wBzBQqc3DeAOsDsuioSV9btlC
	QE4V2HbOA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZYsK-00GkdX-SU; Thu, 22 Apr 2021 12:56:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYsI-00Gkd0-T2
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=21S78QhBI9paSR6lAg5Pks6hJj5M+KTZrXtyCvTMri0=; b=k5cpoCRicmd1x3D/1XcEsFp+z5
 ZyFSrYimDud1Cx1kvj7zDlcskZMBiDG9FBIo3OXFqJ2Ik/YRXZvhjhNe9v3X30qvwXq4r5/CFDMRE
 jCJJo18bjTL31v/mIN9DDwHIIv45m9caa2O0NSKy973oHrAyyQkEJ6BcnXpNNmG7HFCRFH+zR+YPu
 exI6eVKJ2XnQmkI5fI6MRzOLkJ9MKSXF2dMLMAOHLrRvYWOjLnCgvxYf0QW63im/edaptikCsqvep
 qyvXG4dRbwiKqaS2pCLSAtiKUCDs8K+7ne5+Alnl+2qsEQ7hrN/EkWKArRdfLVsc1CYNJUvyJlky9
 1CP+mncA==;
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYsG-00Dh8o-FB
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:56:05 +0000
Received: by mail-il1-x12e.google.com with SMTP id c3so31582953ils.5
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 05:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=21S78QhBI9paSR6lAg5Pks6hJj5M+KTZrXtyCvTMri0=;
 b=APhEU2WCSMjmaOL4vchgx7Q66zXsHghpOSQ3SAQTb6lTGNcoA/lYngPKbbYntpJyUy
 MHoQLjJxvtJ//C+RaM/4nzkaDIl0gPogXRMjrLFnMJ7bVqB9VFLMrvROMXjBIeR9qVuw
 bKNgzkrh/EmKCr+yarPGa3f0Reqh2J+MtMHixr1DtxAUJjbwb+Twn20sBcJM4ppaD8Lm
 jHaW8zO7VwCveclyR1ITUeQOAs9ih3/asugQ+93+Ha0knNeQ1PGh2tD3JpaWq5bWXSoR
 4Au5AtQ4o18wHKNmyL30RPAqdcrvYULBfNLn4EQcX7UDx1iJRN3EXImlpxdSx30Fy3YY
 /vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=21S78QhBI9paSR6lAg5Pks6hJj5M+KTZrXtyCvTMri0=;
 b=ZwLkpDLb4ywN1KsxcaYn5p6hz+PrtGlDl/IIFrN+f9bVY29Z+0TGn8zRW9LUD2NCNC
 uXcFZINNQ1HAk0WwRmZ0FXT4pn6v9u3rt/WOxLccCc9jfLzqpXEo9whe+b3gafTN76Tn
 OfrIB+FhRSz4ltq22SCYC7qWsZJqE4npM1hcA32DVveqGMmEj14hpB1PYSMR8xru8y/s
 tZ5M7rDhCug4LSY7gA/scYmmv+wa/lfZXemASp1/jXIkIDxMKvqcyHz3LRJm7UU9a5Bk
 aZ+rSkRnsyMrwvl8ehTghtQqS5+okwxsHTHiErjbKBKZ4jN830wKsTRFPHVzCKoJ+aKD
 /Dzg==
X-Gm-Message-State: AOAM532Npk7wN6Ld4FkJ0uvVgOl7+TbOle334vIju18K/Q/4HRFZnYfj
 +3diIhIyCea8zE3+2ITqzS+obXZnJhrGWXPra00=
X-Google-Smtp-Source: ABdhPJzyKclBB4PblZoatMmPvTATrPcDbOznS24jKO2d9K1IwNFo7WJhcmxNF3MLYuhpnqDQ8pbiHgh3YYbxyFA8SoA=
X-Received: by 2002:a05:6e02:1c4c:: with SMTP id
 d12mr2611339ilg.104.1619096163682; 
 Thu, 22 Apr 2021 05:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210422123316.18362-1-amit.engel@dell.com>
In-Reply-To: <20210422123316.18362-1-amit.engel@dell.com>
From: Hou Pu <houpu.main@gmail.com>
Date: Thu, 22 Apr 2021 20:55:52 +0800
Message-ID: <CAKHcvQh2Fz7hdsNk=qH0u5E1OwmsG3NQ0Mx+_hxkx1=y9Z63dg@mail.gmail.com>
Subject: Re: [PATCH] nvmet: move ka_work initialization to nvmet_alloc_ctrl
To: "Engel, Amit" <amit.engel@dell.com>
Cc: linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_055604_526655_2A1E3E5E 
X-CRM114-Status: GOOD (  16.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 22, 2021 at 8:33 PM <amit.engel@dell.com> wrote:
>
> From: Amit Engel <amit.engel@dell.com>
>
> Initialize keep-alive work only once, as part of alloc_ctrl
> and not each time that nvmet_start_keep_alive_timer is being called
>
> Signed-off-by: Amit Engel <amit.engel@dell.com>

Looks good to me.
Reviewed-by: Hou Pu <houpu.main@gmail.com>

Thanks,
Hou

> ---
>  drivers/nvme/target/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index adbede9ab7f3..36f9c1caa3f8 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -412,7 +412,6 @@ void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
>         pr_debug("ctrl %d start keep-alive timer for %d secs\n",
>                 ctrl->cntlid, ctrl->kato);
>
> -       INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>         schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>  }
>
> @@ -1341,6 +1340,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>         INIT_LIST_HEAD(&ctrl->async_events);
>         INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
>         INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
> +       INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
>
>         memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
>         memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
> --
> 2.18.2
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
