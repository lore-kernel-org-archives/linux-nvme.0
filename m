Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82654C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWBwZN22MI/EGprrEPMqtlpHhvJBn1XE7tgsfrpoGiY=; b=hsEJHnAcm+zT1PiGuEmJhxYdDz
	Wg4X9F/BiqsdIgZ2m2VlxfP25Zt9bskLGDcVPKb7zknjfcBsel19c1QtlOkC9QC9yfV3U00HgcsZH
	8mFzkHRFcTHdp7V7u0e0LFuSpargZfmeQWrqLl7W2CshTQl/l6+EaGMbDlW0+Sg7QpJdKHPjWfu3W
	eaN1hvOoZsaqhuf3U3Wpy4+rLQ0ZvStu3+IWj13JEySP+sPBVR9b1XX7mjQcK8EqCM8PuXC3w03Ky
	MyNxQk/iLUt0g5kNuGsOw4WfGCRB+Db4rx2odqX9r37Azvj7WMx+Djz0kA6HGEeygb4Ob75rkvF/Y
	GV4JGgPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0gKr-003W5x-0g;
	Wed, 08 Nov 2023 11:03:01 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0gKm-003W4v-2T
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 11:02:58 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54394328f65so11336046a12.3
        for <linux-nvme@lists.infradead.org>; Wed, 08 Nov 2023 03:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699441370; x=1700046170; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pWBwZN22MI/EGprrEPMqtlpHhvJBn1XE7tgsfrpoGiY=;
        b=GoOJhY7Zt2o7HlIu4dolcNQpsbZXI6SpzVJqTSX8wubpWggfzfE0kULetLgNDB8sqr
         dXJf/Ab0igh+uPvWMkWV2DLXyyoAr8y2mzQYiPXq5drUDfYzNIJxEzynaaf7R2IFzNuu
         GBxLmf1TUMSrCnRCTncZ7e0PnGDNak6RSVmAwvCThQFP4mKKhR9xEUMHXFqy/V+K2AD6
         gwjPcBirq1lt7sToV4b2tjrMaX4dmHGuwlJDXQ8KmnhOwdTmXlWiWo7FPvgv+Tb82214
         WnjqAoG3gz87cEd7Ak0N3MpgBoK4DhdoNTQJBerQJv7sphpwI9FU+0AtGTS8EUdTOMUq
         74TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699441370; x=1700046170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWBwZN22MI/EGprrEPMqtlpHhvJBn1XE7tgsfrpoGiY=;
        b=WKEEY2W9gJhdTlFXe386zxV6qyBo6M/WqMMEWa6McRMWo8HH2Kb/9Fem3lOf3KhByF
         i3QNyvzaPLr035Y0OTuc7V0uLfgWNWtZW8Nx8zA8ufF/7eDO47z4Yw1aUfTb0/hvsEyI
         EZtJzcVjf91GTDa9Z8jvHGF2/T3x4s70XGHOOneiCbP7EKQJpaOMm3DKG8xAHwXQInt8
         /9T76IXisBBdPKYNFID3jONU1w0DAivDKQvn1nwCUtSGlSM2QoLyht7dt3p7SeWEAcK/
         cyNAcm6L4kWH88ZRyini+AVpmImuTdK4TG95nuy/zlP0pN3ORtXd6WlB6TDzzUwb147y
         syGQ==
X-Gm-Message-State: AOJu0YxwhShLw4MLYRgsGdZ60Uqrqbfp2MF/nv5vPLx+3kZcz3ooQQPA
	ZGq6fW0x9KVFnHhBXQfg3Bdd4zFFGoeRSOClJhfrDgqrW3A0qoZv
X-Google-Smtp-Source: AGHT+IFitgMTWilhJnTu0yFDWKls8jyorWy8sEpN+FTTlK/GCXXxtpOWeMkgSF7XGgLpdK0XWjMdzekClFkZ1xmFkSc=
X-Received: by 2002:a17:907:9802:b0:9ad:e180:16e3 with SMTP id
 ji2-20020a170907980200b009ade18016e3mr1145985ejc.37.1699441370048; Wed, 08
 Nov 2023 03:02:50 -0800 (PST)
MIME-Version: 1.0
References: <CAK5usQuJ=-1wt5LxHnWtrS_3iOeG-TWy9D88WA1EHSVv+hUNJQ@mail.gmail.com>
 <1dd5331f-626c-4503-9323-77de0b0db886@nvidia.com> <CAK5usQsOP+4oV3YEcNN6Oe6_kBqP_u=e1DggJvNanH3qDG8+wA@mail.gmail.com>
 <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com>
In-Reply-To: <7942920c-b3f8-4f52-b6a4-78a3cef2cba7@nvidia.com>
From: Alon Zahavi <zahavi.alon@gmail.com>
Date: Wed, 8 Nov 2023 13:02:38 +0200
Message-ID: <CAK5usQu_mi68_ChP4OckVmY42djdPx8L3hGg7_Jj0fa1yQ2mPw@mail.gmail.com>
Subject: Re: [Bug Report] NVMe-oF/TCP - Slab OOB Read in `nvmet_ctrl_find_get`
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_030256_834260_F9428A3E 
X-CRM114-Status: GOOD (  33.57  )
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

On Wed, 8 Nov 2023 at 12:02, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
>
> On 11/8/23 01:01, Alon Zahavi wrote:
> > On Wed, 8 Nov 2023 at 10:46, Chaitanya Kulkarni <chaitanyak@nvidia.com> wrote:
> >>
> >>> ## Root Cause
> >>> As explained above, the root cause for this bug is the fact that there
> >>> are no NULL terminators to the strings in the object representing the
> >>> `struct nvmf_connect_data`.
> >> Can you see if this works for you ? it should at least take care of the
> >> subsysnqn and hostnqn being accessed as NULL terminated string.
> >>
> >> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> >> index 3935165048e7..569046b6a269 100644
> >> --- a/drivers/nvme/target/core.c
> >> +++ b/drivers/nvme/target/core.c
> >> @@ -1235,13 +1235,19 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const
> >> char *subsysnqn,
> >>                                          const char *hostnqn, u16 cntlid,
> >>                                          struct nvmet_req *req)
> >>    {
> >> +       char subsysnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
> >> +       char hostnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
> >>           struct nvmet_ctrl *ctrl = NULL;
> >>           struct nvmet_subsys *subsys;
> >>
> >> -       subsys = nvmet_find_get_subsys(req->port, subsysnqn);
> >> +       /* subsysnqn & hostnqn may not be NULL ternimated */
> >> +       strncpy(subsysnqn_str, subsysnqn, NVMF_NQN_SIZE);
> >> +       strncpy(hostnqn_str, hostnqn, NVMF_NQN_SIZE);
> >> +
> >> +       subsys = nvmet_find_get_subsys(req->port, subsysnqn_str);
> >>           if (!subsys) {
> >>                   pr_warn("connect request for invalid subsystem %s!\n",
> >> -                       subsysnqn);
> >> +                       subsysnqn_str);
> >>                   req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
> >>                   goto out;
> >>           }
> >> @@ -1249,7 +1255,7 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char
> >> *subsysnqn,
> >>           mutex_lock(&subsys->lock);
> >>           list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> >>                   if (ctrl->cntlid == cntlid) {
> >> -                       if (strncmp(hostnqn, ctrl->hostnqn,
> >> NVMF_NQN_SIZE)) {
> >> +                       if (strncmp(hostnqn_str, ctrl->hostnqn,
> >> NVMF_NQN_SIZE)) {
> >>                                   pr_warn("hostnqn mismatch.\n");
> >>                                   continue;
> >>                           }
> >> @@ -1263,7 +1269,7 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char
> >> *subsysnqn,
> >>
> >>           ctrl = NULL; /* ctrl not found */
> >>           pr_warn("could not find controller %d for subsys %s / host %s\n",
> >> -               cntlid, subsysnqn, hostnqn);
> >> +               cntlid, subsysnqn_str, hostnqn_str);
> >>           req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
> >>
> >>    found:
> >>
> >>
> >> -ck
> >>
> >>
> > Before I check it I should say that the same bug occurs in other
> > functions as well.
> > For example in `nvmet_alloc_ctrl()` there is the same print.
> >
>
> yes it has same pattern and will need a same fix here is an updated
> patch with nvmet_alloc_ctrl() fix :-
>
>
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 3935165048e7..5c1a71d16df7 100644
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
> @@ -1358,25 +1364,32 @@ static void nvmet_fatal_error_handler(struct
> work_struct *work)
>   u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
>                  struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
>   {
> +       char subsysnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
> +       char hostnqn_str[NVMF_NQN_SIZE + 1] = { 0 };
>          struct nvmet_subsys *subsys;
>          struct nvmet_ctrl *ctrl;
>          int ret;
>          u16 status;
>
>          status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
> -       subsys = nvmet_find_get_subsys(req->port, subsysnqn);
> +
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
>                  req->error_loc = offsetof(struct nvme_common_command,
> dptr);
>                  goto out;
>          }
>
>          down_read(&nvmet_config_sem);
> -       if (!nvmet_host_allowed(subsys, hostnqn)) {
> +       if (!nvmet_host_allowed(subsys, hostnqn_str)) {
>                  pr_info("connect by host %s for subsystem %s not
> allowed\n",
> -                       hostnqn, subsysnqn);
> +                       hostnqn_str, subsysnqn_str);
>                  req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
>                  up_read(&nvmet_config_sem);
>                  status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
>
> -ck
>
>

I think that although those patches will fix the bug in the two
functions we talked about, the non-terminated strings are still stored
in the `struct nvmf_connect_data` object.
This can cause major security bugs in the future. Moreover, handling
this kind of copy of strings before each time we use `subsysnqn` or
`sysnqn` is taking resources and time.
For example, in `nvmf_connect_data_prep()` it uses
`strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);` to
copy the subsysnqn to the object, with NVMF_NQN_SIZE as the max size.

Is it possible to add a NULL terminator after each time we use
`nvmet_copy_from_sgl()` to copy from an SGL to `struct
nvmf_connect_data` object?
Also, I think `nvmet_copy_from_sgl()` should be considered as unsafe
when using it to copy strings, as it doesn't check for NULL
termination.

Thanks,
Alon.

