Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38321C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4ZjOt/kxn+Tv01WR6ZbHO1uiIuHWE/WaF7nv1Lh3Mo=; b=NYthq2IkK3eKHthJKtdZXlf77p
	Uw4M/dDW9ehdp0jJJdDZdYnh43nTy6ckFZQen8ZPCVlIRBoGMFB5+ovDoM2ifnhqKFoJf95U/Jvpk
	ZKAfirgsIXe9CsmaYyhTH79L/Ww6dshA3YeXAggFVx1SsE9PBw9dOXEQJaDwNtYr+6vduYuniSQi3
	zYWRJz4bQ0DX3pFE7dFeO2L6BXfa5b5iOKipKMgTvw1a0OP4hpBYydgXoft4H0eEH260+zUDYQBHk
	u9wa/jK1wcZJkhH2pjPtF9MP76mcPH9eujgqFos3CqXvL+nWXwSeGO6rpBrvWXDaG063iHVjMPvFm
	ecXNlZbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0eRc-003KPd-0A;
	Wed, 08 Nov 2023 09:01:52 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0eRY-003KMp-2F
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 09:01:50 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so8994026a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Nov 2023 01:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699434106; x=1700038906; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b4ZjOt/kxn+Tv01WR6ZbHO1uiIuHWE/WaF7nv1Lh3Mo=;
        b=TqmxwWswaqyCfQYZVafWh2ipVI4vV6g5sklKWDbGojjBuEda00VviJCFZIM8DSuMrQ
         IisGIQeU6oIxR9QM4kZppPw3/pkiJ4pphMIczHdvQVTGKCkwNRtHn7jhq/QTL8KnkLLG
         O9E4YvS7iNEDMOLrpo5w17JHlySnJLumPLFovce3sXwftVk7AYspQ+Cu3nAENDR2lKzR
         JSmOjkt870XIzTtnRLx6Md8SAiYAeGGbAcFeoFPTg1AS9bMafiy221FNtm5lDQrteB98
         BdoJvvqlxS+2cL8oZjjT2AO/gFwd62z8VN99haODN/MNl9JJfXh2CZ8eVu5te8emJUN0
         S5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699434106; x=1700038906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4ZjOt/kxn+Tv01WR6ZbHO1uiIuHWE/WaF7nv1Lh3Mo=;
        b=A3YOZA2DBTzXIp5+v1cgSJG25Lp+GN5MPmrVMFduu8WkeTjHZIXsG34odDmDZblzN/
         B+0VieLRYXiYAQ+fNqI0r/Qva/Xv2zbn06oMZCsZz7S+5Rfb9muI+MPzo0G3rdxSGUfE
         7JIuxLa9NIcV5+EBmLXPdg5FwMYunjFVJk8Yj9GL95+9h4vj09dC/8kKtpPBGcoUq669
         XD2GreG3tzbXBmWN0UE1GCnmC7xpJL4lKyLKvMtkAi1pmu+4USUYYbQEoktlrlmgIHpC
         jCDmuzX6cAwmgIoIcZmnK3jkrwcWR7Z/J3myX//XWP3BqRtWbwHink75w05S4X8E8LUY
         OyeA==
X-Gm-Message-State: AOJu0YwJ8shOi83DxjzwYk8i+dWO9+ePbAm8GxrwUD/UCMfQfW+4fcTG
	cO5KzsrLS0w2UKQ0m450appD9AV1FiI4cCsnPb4=
X-Google-Smtp-Source: AGHT+IG4jX9uJhLlHcvMnjwFUtLcUTZaAh+EydomBVgqJDUqZ+zZe9NPZwbRpEA58ZfZPZHkyNRt/DoQdo1oFPMo7A8=
X-Received: by 2002:a17:907:7f9f:b0:9c4:b8c9:1bf4 with SMTP id
 qk31-20020a1709077f9f00b009c4b8c91bf4mr1006280ejc.19.1699434105690; Wed, 08
 Nov 2023 01:01:45 -0800 (PST)
MIME-Version: 1.0
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
 <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com>
In-Reply-To: <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com>
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Wed, 8 Nov 2023 11:01:34 +0200
Message-ID: <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_010148_737599_B07EDC08 
X-CRM114-Status: GOOD (  24.39  )
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

On Wed, 8 Nov 2023 at 10:46, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
>
> > ## Root Cause
> > As explained above, the root cause for this bug is the fact that there
> > are no NULL terminators to the strings in the object representing the
> > `struct nvmf_connect_data`.
>
> Can you see if this works for you ? it should at least take care of the
> subsysnqn and hostnqn being accessed as NULL terminated string.
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..569046b6a269 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1235,13 +1235,19 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const
> char *subsysnqn,
>                                         const char *hostnqn, u16 cntlid,
>                                         struct nvmet_req *req)
>   {
> +       char subsysnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
> +       char hostnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
>          struct nvmet_ctrl *ctrl = NULL;
>          struct nvmet_subsys *subsys;
>
> -       subsys = nvmet_find_get_subsys(req->port, subsysnqn);
> +       /* subsysnqn & hostnqn may not be NULL ternimated */
> +       strncpy(subsysnqn_str, subsysnqn, NVMF_NQN_SIZE);
> +       strncpy(hostnqn_str, hostnqn, NVMF_NQN_SIZE);
> +
> +       subsys = nvmet_find_get_subsys(req->port, subsysnqn_str);
>          if (!subsys) {
>                  pr_warn("connect request for invalid subsystem %s!\n",
> -                       subsysnqn);
> +                       subsysnqn_str);
>                  req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
>                  goto out;
>          }
> @@ -1249,7 +1255,7 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char
> *subsysnqn,
>          mutex_lock(&subsys->lock);
>          list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>                  if (ctrl->cntlid == cntlid) {
> -                       if (strncmp(hostnqn, ctrl->hostnqn,
> NVMF_NQN_SIZE)) {
> +                       if (strncmp(hostnqn_str, ctrl->hostnqn,
> NVMF_NQN_SIZE)) {
>                                  pr_warn("hostnqn mismatch.\n");
>                                  continue;
>                          }
> @@ -1263,7 +1269,7 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char
> *subsysnqn,
>
>          ctrl = NULL; /* ctrl not found */
>          pr_warn("could not find controller %d for subsys %s / host %s\n",
> -               cntlid, subsysnqn, hostnqn);
> +               cntlid, subsysnqn_str, hostnqn_str);
>          req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
>
>   found:
>
>
> -ck
>
>

Before I check it I should say that the same bug occurs in other
functions as well.
For example in `nvmet_alloc_ctrl()` there is the same print.

```
// From `linux/include/nvme.h`

/* NQN names in commands fields specified one size */
#define NVMF_NQN_FIELD_LEN 256

/* However the max length of a qualified name is another size */
#define NVMF_NQN_SIZE 223
```
From the macros above we can see that the actual NVMF_MAX_SIZE is 223
while the field in the original object is 256.
Can we zero out the array from index 223 till the end of the array
during the initialization of `subsysnqn` and `hostnqn`?
This way we can mitigate future problems with the same object's fields.

Thanks,
Alon.

