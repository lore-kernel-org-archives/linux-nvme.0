Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0C2C3ABA2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gdkE3ghEoryXRE/9RJj7eJPqHDsi8hGkEMOzGG1yQQg=; b=4kuIfw2CJZI25cjFTAIXEM4UEK
	MOFPjB3Bh1V4vzHKwE9zHnrMAsw7NkkuYCGtLoKmTqWla/J9ABMmaSzDRUnZlimJxJGs0AXqO3Ybj
	YQkNyP6MU20r1mtZufoov0NfnavFzXiNfZ9x54zNvbRhnXkixewcPyrzBvT8oWSbvnh5wYlfjTUGK
	Co/BYaYQAbnq+WtuhF9ZTYJxOrliqsWZdWlAjpdETADNwf5W7HSmEwQTq2JmvyXiBCYFWZN/IJtbg
	MDBLRsLSYeAs9MAgmborXhkzCnytBDBXL5U1Y8ckok+83gVFGDBRDPBeATmXpylhUa8rafHHVyDdp
	DnDb0iHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGDF-00000004fHc-0PDx;
	Mon, 16 Sep 2024 18:12:37 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGDB-00000004fHA-2xEU
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 18:12:35 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-71790698b22so1250187b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 16 Sep 2024 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1726510352; x=1727115152; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdkE3ghEoryXRE/9RJj7eJPqHDsi8hGkEMOzGG1yQQg=;
        b=b00S0h0UJ7hdKdEYvvVkWklIX2oPbXHn3RntMots5wdfV7Htqem8J5pyfUpwtfpB86
         mrTHaVk+7YD/kNf2EqST6iabRT6ySaqxLBdaEumZV6pSDhzyFrtaCpTugnng4SYtaB6i
         oAlDFHmn6vXkMc6uKY8g9e4GTzYc/EFcdE44jTnFhg20VP4HT3/Wth92dkzhTwiaIlr8
         bdZgw2RX7EGxu48kKuvNBA0O6U1edkjfV1aLyVkPtxetsSrlrScG8ibRlDoZEkqYkfDN
         GuD8FvkrUhSpyjUpALKytHt3RQ8P1mzowS13LuqFZRvwsg4vhYfDU/cBIh4/CbgJ7EqP
         3Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726510352; x=1727115152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdkE3ghEoryXRE/9RJj7eJPqHDsi8hGkEMOzGG1yQQg=;
        b=vI6KIjG/AqKI+ND4wDaj8/VAwGBbmhChCHz218aUb9J7MeCmwvLUajrfHmVJRCBQFk
         pPdc7Wp9FoRxWL0opTWYny2spvrt2bKkVsaJACmgvUNTyS5R1zmKXxJj0jIHyfLYXQ8B
         5CL2jzFjqGtlhRoNXlZWmkuod/kBALO7RIzF+0HXuU8dqAM0KqHBjeZvY3LMUfw2k2ud
         b2BVjef/95X7M+eYYLl2+w/Jztl46wwsqjl8fAtW71bbrP6qZVcZUAhYN9rOOseIdbyU
         OTulQywh+Vu3HgOXtY3JQi60k0YHueTVwNKOyrmbWZFmmElVPa4n4/U3IsnJNdxNYTVJ
         BB9Q==
X-Gm-Message-State: AOJu0Yywn2/foqKXHEswBWWaQ0Tq8ue4kom78aeSVdGZ3tp98EWzkVSa
	O0CyONpejeygtN3gr5/cUdzQ7DlPY+U4wyGlLVMTZnCQx1vfT4NxOgEomSfxt079pw2cA0Oear/
	N18V/PbNk6Q/aiPcW+tar9UmQdd8DcaCGhAtyTu1n7OIjpV8J
X-Google-Smtp-Source: AGHT+IEpumphQnjXlynP5TlEM2XyI4TV0S2JPFnuewGSFg5/hcwjuHWh3gKVGJLt5K5BgxP9qPIdinqg5GL/YHSLUFU=
X-Received: by 2002:a05:6a20:a10b:b0:1cf:4212:4bd6 with SMTP id
 adf61e73a8af0-1cf7647b74cmr11412827637.7.1726510352365; Mon, 16 Sep 2024
 11:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240916154422.356691-1-ikegami.t@gmail.com> <CADUfDZrqAgp49K2Ak-b230ERY8P66aXA4iAoCyyYr45PAbq+1Q@mail.gmail.com>
 <1bcdab96-f2cb-4116-9f04-4016b01bad36@gmail.com>
In-Reply-To: <1bcdab96-f2cb-4116-9f04-4016b01bad36@gmail.com>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 16 Sep 2024 11:12:21 -0700
Message-ID: <CADUfDZo=WwCTWwmY+UcUA7zpXb9CMpOsNC0icat7opwwFpJh=A@mail.gmail.com>
Subject: Re: [PATCH] nvme: convert little endian NVME definitions to native format
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_111233_826063_F463B14D 
X-CRM114-Status: GOOD (  25.54  )
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

On Mon, Sep 16, 2024 at 9:41=E2=80=AFAM Tokunori Ikegami <ikegami.t@gmail.c=
om> wrote:
>
> For example the definition below is not native byte order I think.
>      NVME_CTRL_ONCS_TIMESTAMP        =3D 1 << 6,

Why not? CPUs assume native byte order for all arithmetic operations.
The fact that you could print this value implies it must be
represented in native byte order. Non-native endianness is only
relevant when interacting with byte-addressable data external to the
CPU (storage, network, etc.).

>
> On 2024/09/17 1:12, Caleb Sander wrote:
> > Why is this necessary? All these values obtained from the Identify
> > Controller data structure are already stored in the CPU's native byte
> > order. So testing them against native byte order constants looks
> > correct.
> >
> > ctrl->oacs =3D le16_to_cpu(id->oacs);
> > ctrl->oncs =3D le16_to_cpu(id->oncs);
> > ctrl->mtfa =3D le16_to_cpu(id->mtfa);
> > ctrl->oaes =3D le32_to_cpu(id->oaes);
> > // ...
> > ctrl->ctratt =3D le32_to_cpu(id->ctratt);
> >
> > On Mon, Sep 16, 2024 at 8:46=E2=80=AFAM Tokunori Ikegami <ikegami.t@gma=
il.com> wrote:
> >> This is to compare the definitions correctly with the converted values=
.
> >>
> >> Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
> >> ---
> >>   drivers/nvme/host/core.c | 20 ++++++++++----------
> >>   drivers/nvme/host/nvme.h |  4 ++--
> >>   drivers/nvme/host/pci.c  |  2 +-
> >>   3 files changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >> index ca9959a8fb9e..5e26546e811a 100644
> >> --- a/drivers/nvme/host/core.c
> >> +++ b/drivers/nvme/host/core.c
> >> @@ -1273,7 +1273,7 @@ static unsigned long nvme_keep_alive_work_period=
(struct nvme_ctrl *ctrl)
> >>           * command completion can postpone sending a keep alive comma=
nd
> >>           * by up to twice the delay between runs.
> >>           */
> >> -       if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
> >> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS))
> >>                  delay /=3D 2;
> >>          return delay;
> >>   }
> >> @@ -1343,7 +1343,7 @@ static void nvme_keep_alive_work(struct work_str=
uct *work)
> >>
> >>          ctrl->ka_last_check_time =3D jiffies;
> >>
> >> -       if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
> >> +       if ((ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_TBKAS)) && comp=
_seen) {
> >>                  dev_dbg(ctrl->device,
> >>                          "reschedule traffic based keep-alive timer\n"=
);
> >>                  ctrl->comp_seen =3D false;
> >> @@ -1699,7 +1699,7 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >>
> >>   static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >>   {
> >> -       u32 result, supported_aens =3D ctrl->oaes & NVME_AEN_SUPPORTED=
;
> >> +       u32 result, supported_aens =3D ctrl->oaes & le32_to_cpu(NVME_A=
EN_SUPPORTED);
> >>          int status;
> >>
> >>          if (!supported_aens)
> >> @@ -1829,7 +1829,7 @@ static void nvme_config_discard(struct nvme_ns *=
ns, struct queue_limits *lim)
> >>          if (ctrl->dmrsl && ctrl->dmrsl <=3D nvme_sect_to_lba(ns->head=
, UINT_MAX))
> >>                  lim->max_hw_discard_sectors =3D
> >>                          nvme_lba_to_sect(ns->head, ctrl->dmrsl);
> >> -       else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> >> +       else if (ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_DSM))
> >>                  lim->max_hw_discard_sectors =3D UINT_MAX;
> >>          else
> >>                  lim->max_hw_discard_sectors =3D 0;
> >> @@ -1913,7 +1913,7 @@ static void nvme_configure_metadata(struct nvme_=
ctrl *ctrl,
> >>          if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORT=
ED))
> >>                  return;
> >>
> >> -       if (nvm && (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
> >> +       if (nvm && (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS)))=
 {
> >>                  nvme_configure_pi_elbas(head, id, nvm);
> >>          } else {
> >>                  head->pi_size =3D sizeof(struct t10_pi_tuple);
> >> @@ -2137,7 +2137,7 @@ static int nvme_update_ns_info_block(struct nvme=
_ns *ns,
> >>          }
> >>          lbaf =3D nvme_lbaf_index(id->flbas);
> >>
> >> -       if (ns->ctrl->ctratt & NVME_CTRL_ATTR_ELBAS) {
> >> +       if (ns->ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS)) {
> >>                  ret =3D nvme_identify_ns_nvm(ns->ctrl, info->nsid, &n=
vm);
> >>                  if (ret < 0)
> >>                          goto out;
> >> @@ -2341,7 +2341,7 @@ static int nvme_sec_submit(void *data, u16 spsp,=
 u8 secp, void *buffer, size_t l
> >>
> >>   static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_sus=
pended)
> >>   {
> >> -       if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
> >> +       if (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_SEC_SUPP)) {
> >>                  if (!ctrl->opal_dev)
> >>                          ctrl->opal_dev =3D init_opal_dev(ctrl, &nvme_=
sec_submit);
> >>                  else if (was_suspended)
> >> @@ -2520,7 +2520,7 @@ static int nvme_configure_timestamp(struct nvme_=
ctrl *ctrl)
> >>          __le64 ts;
> >>          int ret;
> >>
> >> -       if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
> >> +       if (!(ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_TIMESTAMP)))
> >>                  return 0;
> >>
> >>          ts =3D cpu_to_le64(ktime_to_ms(ktime_get_real()));
> >> @@ -2541,7 +2541,7 @@ static int nvme_configure_host_options(struct nv=
me_ctrl *ctrl)
> >>          /* Don't bother enabling the feature if retry delay is not re=
ported */
> >>          if (ctrl->crdt[0])
> >>                  acre =3D NVME_ENABLE_ACRE;
> >> -       if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
> >> +       if (ctrl->ctratt & le32_to_cpu(NVME_CTRL_ATTR_ELBAS))
> >>                  lbafee =3D NVME_ENABLE_LBAFEE;
> >>
> >>          if (!acre && !lbafee)
> >> @@ -3109,7 +3109,7 @@ static int nvme_init_non_mdts_limits(struct nvme=
_ctrl *ctrl)
> >>           * controllers max_hw_sectors value, which is based on the MD=
TS field
> >>           * and possibly other limiting factors.
> >>           */
> >> -       if ((ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) &&
> >> +       if ((ctrl->oncs & le16_to_cpu(NVME_CTRL_ONCS_WRITE_ZEROES)) &&
> >>              !(ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
> >>                  ctrl->max_zeroes_sectors =3D ctrl->max_hw_sectors;
> >>          else
> >> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> >> index 313a4f978a2c..25886b9d2796 100644
> >> --- a/drivers/nvme/host/nvme.h
> >> +++ b/drivers/nvme/host/nvme.h
> >> @@ -860,9 +860,9 @@ static inline bool nvme_is_unique_nsid(struct nvme=
_ctrl *ctrl,
> >>                  struct nvme_ns_head *head)
> >>   {
> >>          return head->shared ||
> >> -               (ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
> >> +               (ctrl->oacs & le16_to_cpu(NVME_CTRL_OACS_NS_MNGT_SUPP)=
) ||
> >>                  (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
> >> -               (ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
> >> +               (ctrl->ctratt & le32_to_cpu(NVME_CTRL_CTRATT_NVM_SETS)=
);
> >>   }
> >>
> >>   /*
> >> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >> index 7990c3f22ecf..f8fa424fa952 100644
> >> --- a/drivers/nvme/host/pci.c
> >> +++ b/drivers/nvme/host/pci.c
> >> @@ -249,7 +249,7 @@ static void nvme_dbbuf_dma_alloc(struct nvme_dev *=
dev)
> >>   {
> >>          unsigned int mem_size =3D nvme_dbbuf_size(dev);
> >>
> >> -       if (!(dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP))
> >> +       if (!(dev->ctrl.oacs & le16_to_cpu(NVME_CTRL_OACS_DBBUF_SUPP))=
)
> >>                  return;
> >>
> >>          if (dev->dbbuf_dbs) {
> >> --
> >> 2.43.0
> >>
> >>

