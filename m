Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF09CD37AC
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 02:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y05BrdBf1u8fgsHeU99R0+r6Fe2fIQVXK9QoNT+LqkM=; b=CjDgJDJY/4oQkbLDA2ZL4LitAM
	1mGtC4pT1WXo9PCP1qkSY+2VLwhB80hXgkMWejH3HsDsW6WLYT2YaV3LLRllOFfPuSC6xNE/A8oEI
	F50fh482wqNCWiE8iA3WwcH8peicKq7YXBmt8iGj8KHzNqlwAn6M2btK7l4K0vxTi4keQ/mzV+9w9
	cewfMG3H8TL8mM/PTVkxGqexZPc3wCyWQnGlgxFsHCJQ0MlCSuuHIypm8U/Kb/B2iMybH3L90BFKE
	br/SnFqaGAThdMXvbn/kb45a+Z++C2G/9hQL0D3O6WvoVIR/pqEeqd0sN/2DQQkq4jrOGNLtZV8Ea
	DHRtZLiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNicQ-00000007A5s-1RP2;
	Fri, 15 May 2026 02:49:42 +0000
Received: from mail-ua1-x92d.google.com ([2607:f8b0:4864:20::92d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNicN-00000007A5H-2gTz
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 02:49:40 +0000
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-95d0476492bso4832254241.2
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 19:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778813377; cv=none;
        d=google.com; s=arc-20240605;
        b=UA/3ufaMwSf+mH7oIMdTVqJYWFMcO5/0HYH86tT6ylVCU7bnr4gcNfLR5x5cNg1qXP
         sJLdcnIKnEhdTnfPWcDlenbYe4m437VzlM1+J9/9rjfy4FEdUWcr5mh5c8SM43RNJV1O
         gxsQV1PpbE8dZLjGx5eZwLMAYEtb8n6L5EJzt4sbnbRvrZq+FdGV6i6mx4QLxnJOKVdB
         F+bv+AItzPl64E+2V1DtSJKq6oTxNhYx0truSfn4f1L9Wbr3mIRi03i48uIsdnXDBLdi
         gkerbSzCRjo41NynXWicjzSgPauVgsWcPur5uRRfo60P5vGVC6zxNtoypt2QekM761pS
         ID5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y05BrdBf1u8fgsHeU99R0+r6Fe2fIQVXK9QoNT+LqkM=;
        fh=tPcSuEl4T9JpNKJKx1uJ8NmXHf6DNMNU9YQJ46qzCqI=;
        b=gaeYEunKY9x+W6lLOmLJmO8+6MEAii3frUeKZrO1S8e6SYeCGw0U5MHZcKLuf0maXT
         bp9nw+BBGGU1yRV/HJQoI9nhYKpJQYeEvAEYoMRUCJErrxeggGy9EM5dHXxY+wSLUeOp
         ZzRMIpHok7ugY38TM3yIXHK922zlta02WMFAgVG67GpJ3JaYdg6crDAf73vWyygCRFm4
         Fq8QjU9cqaup0h/D0kFBmzk7NsgXBTIpYwwvfBM4+AWzQPR8eYzoYlCXDG922VHEOKsC
         OEpj/riLKaSrOMs2QTGVY5iMSJB2/DDZgjxAb7HJcuePCNrlJUyB9uVZJ+teleq4rKx/
         BLiw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778813377; x=1779418177; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y05BrdBf1u8fgsHeU99R0+r6Fe2fIQVXK9QoNT+LqkM=;
        b=RRzTNhBFTeUVqO4U6AAlJNFTQuQaJ8iL3bprnMnTWVZOVS5plkiR9Vo6Vg5azLJJCU
         HQYiohXFkKWd9JUOjbZ1G+sVmeZfZgr11U2UaA/ltqQCTxg+MvOxoTRA1AH0xZIfYphM
         L56tmqi2f511D58vd2wzuff8av9q8znUzn6IaqWA88SNrmuU2yTO1UglBeLgKsntlFLO
         wKbg0D77F9cNE5Yh9eR8j8Iq52aWAsX9qi8dVw3CWStnxtD+PNvI0e+3V3fkOF7eL85f
         GRhdUbGYNa6cTW7QnYy/KF9aRM1WMG3pm+e3zBSSxkBzOu0+FxOoVqxSMGB4I9tWiPDe
         j9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778813377; x=1779418177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y05BrdBf1u8fgsHeU99R0+r6Fe2fIQVXK9QoNT+LqkM=;
        b=a7Is0gKgGLLgjXb+GGFp/L4DQijVx2vnWRpavXWAo+kqs88SGUg4/HCgrmeJIw5jFc
         94eoszFCRATgzg2T7fylhWhA8vhA79SLcAHHAyubNyK+S7GllYEB4wzhgE/XhPViPLyz
         B06uIBr14hP546CBIV667FaOodKJdV3hZGiJ0/s21kWS1VJhtRvwxXl5B7ZMKDQ/3KXb
         eSmldDxAmxMxHi+mU0bNEvrBazKesQQIXIpoJA3xlFJO2H9RrEzIPj1uuk7ehDf5x3ia
         wGvDk44iuFeZQM4mCJjq16XFWCTFdby6I+7ouiJGZpHmEKvDv25ApRS/AgXHggJG0o3D
         H0Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8F29oxnD83I+/pk4L4Hf2zIeWTDTQ+R7NPvvmI8NFL8zhuRkLxtNpn4tc8gPNgp62ONpD+Nu9dBYSc@lists.infradead.org
X-Gm-Message-State: AOJu0YxhxS4+rFHiBIudvUS9TUpxMTvfZHgD/H1ygm2T/nOjcYj3e9le
	v0y90j9ZhWwp1qj1pRxgxA4kxn+3W7kOa4KZ1eRAybhKb70+6UjBz9gu9puNmXGPlj9cgzntREw
	qQd/mERxGTR/e00fZwkOPZLMakF/uFUQ0S5VGQw2A7A==
X-Gm-Gg: Acq92OFiSvxaKU76Xui0O4yEzcOHOYumwCt4h1D3lVr4ovrjsRyMKkXy/cNK6qudl7D
	Rx7ovukvQYN/2GMrYiTtmrL9wh1rcZtGZMTWJBvOKp6CfwUIr7oBqNvX8wUYmUF4ijCYh+dQJ2f
	4u9L4GmoxAEELynPPJvbwk5q86jm6x2L6qhL33wYooLqBSByeg2l1+tQ/GadL4b6zivVaTx9fyk
	e4yaFawwVSYbaBsu9yuJxXoRUEViNeBxgbsiJKTbDxhyh51oMhxFQySdIkW52LTJ3+hmUushCP7
	8Zm7VKWpHPcB2oLUaxZ9iH0E0uw0dRPeW6nxtxU2ntQMQrAMGG1aQ0jXLCER+ttGD5FXJg==
X-Received: by 2002:a05:6102:2acc:b0:631:7781:fe8a with SMTP id
 ada2fe7eead31-63a3ef8252dmr962876137.19.1778813377296; Thu, 14 May 2026
 19:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
 <20260328004518.1729186-10-mkhalfella@purestorage.com> <73a9c0e2-ecd0-4170-8723-259529617ec0@suse.de>
 <20260331165510.GD2861-mkhalfella@purestorage.com> <019cf04f-8988-46fd-aecd-0f77ac5f8b8a@suse.de>
 <20260407190940.GF2861-mkhalfella@purestorage.com>
In-Reply-To: <20260407190940.GF2861-mkhalfella@purestorage.com>
From: Randy Jennings <randyj@purestorage.com>
Date: Thu, 14 May 2026 19:49:25 -0700
X-Gm-Features: AVHnY4KgRnVMeojU6TJc9W0sK0kdC4KQzgjkeCzgQj7ffI3CHrpfknMybALGGlk
Message-ID: <CAPpK+O2OLh2FVyGNMfvZPXD_3YgjH_b1pfSZkHvuNQRE4L5x+w@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] nvme: Implement cross-controller reset completion
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Hannes Reinecke <hare@suse.de>, Justin Tee <justin.tee@broadcom.com>, 
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>, Paul Ely <paul.ely@broadcom.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart833426@gmail.com>, 
	Aaron Dailey <adailey@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_194939_703018_E06AB2F2 
X-CRM114-Status: GOOD (  37.32  )
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

On Tue, Apr 7, 2026 at 12:09=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> On Tue 2026-04-07 07:48:50 +0200, Hannes Reinecke wrote:
> > On 3/31/26 18:55, Mohamed Khalfella wrote:
> > > On Mon 2026-03-30 12:53:07 +0200, Hannes Reinecke wrote:
> > >> On 3/28/26 01:43, Mohamed Khalfella wrote:
> > >>> An nvme source controller that issues CCR command expects to receiv=
e an
> > >>> NVME_AER_NOTICE_CCR_COMPLETED when pending CCR succeeds or fails. A=
dd
> > >>> sctrl->ccr_work to read NVME_LOG_CCR logpage and wakeup any thread
> > >>> waiting on CCR completion.
> > >>>
> > >>> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > >>> ---
> > >>>    drivers/nvme/host/core.c | 49 ++++++++++++++++++++++++++++++++++=
+++++-
> > >>>    drivers/nvme/host/nvme.h |  1 +
> > >>>    2 files changed, 49 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > >>> index 5603ae36444f..793f203bfc38 100644
> > >>> --- a/drivers/nvme/host/core.c
> > >>> +++ b/drivers/nvme/host/core.c
> > >>> @@ -1920,7 +1920,8 @@ EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> > >>>
> > >>>    #define NVME_AEN_SUPPORTED \
> > >>>           (NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
> > >>> -  NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
> > >>> +  NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_CCR_COMPLETE | \
> > >>> +  NVME_AEN_CFG_DISC_CHANGE)
> > >>>
> > >>>    static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> > >>>    {
> > >>> @@ -4873,6 +4874,47 @@ static void nvme_get_fw_slot_info(struct nvm=
e_ctrl *ctrl)
> > >>>           kfree(log);
> > >>>    }
> > >>>
> > >>> +static void nvme_ccr_work(struct work_struct *work)
> > >>> +{
> > >>> + struct nvme_ctrl *ctrl =3D container_of(work, struct nvme_ctrl, c=
cr_work);
> > >>> + struct nvme_ccr_entry *ccr;
> > >>> + struct nvme_ccr_log_entry *entry;
> > >>> + struct nvme_ccr_log *log;
> > >>> + unsigned long flags;
> > >>> + int ret, i;
> > >>> +
> > >>> + log =3D kmalloc(sizeof(*log), GFP_KERNEL);
> > >>> + if (!log)
> > >>> +         return;
> > >>> +
> > >>> + ret =3D nvme_get_log(ctrl, 0, NVME_LOG_CCR, 0x01,
> > >>> +                    0x00, log, sizeof(*log), 0);
> > >>> + if (ret)
> > >>> +         goto out;
> > >>> +
> > >>> + spin_lock_irqsave(&ctrl->lock, flags);
> > >>> + for (i =3D 0; i < le16_to_cpu(log->ne); i++) {
> > >>> +         entry =3D &log->entries[i];
> > >>> +         if (entry->ccrs =3D=3D NVME_CCR_STATUS_IN_PROGRESS)
> > >>> +                 continue;
> > >>> +
> > >>> +         list_for_each_entry(ccr, &ctrl->ccr_list, list) {
> > >>> +                 struct nvme_ctrl *ictrl =3D ccr->ictrl;
> > >>> +
> > >>> +                 if (ictrl->cntlid !=3D le16_to_cpu(entry->icid) |=
|
> > >>> +                     ictrl->ciu !=3D entry->ciu)
> > >>> +                         continue;
> > >>> +
> > >>> +                 /* Complete matching entry */
> > >>> +                 ccr->ccrs =3D entry->ccrs;
> > >>> +                 complete(&ccr->complete);
> > >>> +         }
> > >>> + }
> > >>> + spin_unlock_irqrestore(&ctrl->lock, flags);
> > >>> +out:
> > >>> + kfree(log);
> > >>> +}
> > >>> +
> > >>>    static void nvme_fw_act_work(struct work_struct *work)
> > >>>    {
> > >>>           struct nvme_ctrl *ctrl =3D container_of(work,
> > >>> @@ -4949,6 +4991,9 @@ static bool nvme_handle_aen_notice(struct nvm=
e_ctrl *ctrl, u32 result)
> > >>>           case NVME_AER_NOTICE_DISC_CHANGED:
> > >>>                   ctrl->aen_result =3D result;
> > >>>                   break;
> > >>> + case NVME_AER_NOTICE_CCR_COMPLETED:
> > >>> +         queue_work(nvme_wq, &ctrl->ccr_work);
> > >>> +         break;
> > >>>           default:
> > >>>                   dev_warn(ctrl->device, "async event result %08x\n=
", result);
> > >>>           }
> > >>> @@ -5144,6 +5189,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> > >>>           nvme_stop_failfast_work(ctrl);
> > >>>           flush_work(&ctrl->async_event_work);
> > >>>           cancel_work_sync(&ctrl->fw_act_work);
> > >>> + cancel_work_sync(&ctrl->ccr_work);
> > >>>           if (ctrl->ops->stop_ctrl)
> > >>>                   ctrl->ops->stop_ctrl(ctrl);
> > >>>    }
> > >>> @@ -5267,6 +5313,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, st=
ruct device *dev,
> > >>>           ctrl->quirks =3D quirks;
> > >>>           ctrl->numa_node =3D NUMA_NO_NODE;
> > >>>           INIT_WORK(&ctrl->scan_work, nvme_scan_work);
> > >>> + INIT_WORK(&ctrl->ccr_work, nvme_ccr_work);
> > >>>           INIT_WORK(&ctrl->async_event_work, nvme_async_event_work)=
;
> > >>>           INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> > >>>           INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
> > >>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > >>> index f2bcff9ccd25..776ee8aa5a93 100644
> > >>> --- a/drivers/nvme/host/nvme.h
> > >>> +++ b/drivers/nvme/host/nvme.h
> > >>> @@ -419,6 +419,7 @@ struct nvme_ctrl {
> > >>>           struct nvme_effects_log *effects;
> > >>>           struct xarray cels;
> > >>>           struct work_struct scan_work;
> > >>> + struct work_struct ccr_work;
> > >>>           struct work_struct async_event_work;
> > >>>           struct delayed_work ka_work;
> > >>>           struct delayed_work failfast_work;
> > >>
> > >> Hmm. The 'nvme_fence_ctrl' operation introduced in the previous patc=
h
> > >> is synchronous, yet in this patch we're looking a a log page to figu=
re
> > >> out if the cross-controller reset is complete.
> > >> Which is slightly irritating.
> > >> Wouldn't it be better to make the 'nvme_fence_ctrl' operation
> > >> asynchronous, and then have a separate function to wait for the fenc=
e
> > >> operation to complete (which then could look at log pages etc)?
> > >
> > > True nvme_fence_ctrl() is synchronous, but it runs in from ctrl->fenc=
ing_work.
> > > What is it that you find irritating about nvme_fence_ctrl()?
> > >
> >
> > Thins is, in order to make nvme_fence_ctrl() synchronous we have to
> > wait for the operation itself (which is asynchronous) to complete.
> > And that wait in itself is implemented by a wait queue.
> > So we're having a wait queue calling nvme_fence_ctrl(), which calls
> > another wait queue waiting for a completion.
> > And then (if the IRS bit is not set) calling another waitqueue for
> > checking the log page.
>
> There is no point of checking the CCR logpage before getting AEN. Sure
> we can implement some sort of polling, but I do not think this is the
> right approach.
>
> >
> > I think we could simplify this by simply making nvme_fence_ctrl()
> > asynchronous, which could do away with all the workqueue handling.
>
> I am not sure I understand exactly how nvme_fence_ctrl() can be make
> asynchronous. Can you provide example code?

I was able to convince Hannes at LSF to withdraw the request for an
asynchronous structure for the code.

Sincerely,
Randy Jennings

