Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32982CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 08:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2MZ13KSpovK/1f8WvC0ydyUi4gsaDwi7dW4OXPTlUI0=; b=Fpj0XuWY0L80Uifa7DDi5kq3BW
	Zs8ohKWstyf2MT/qsr4uT1tah1TNzEkxNHewCEOwq2Y/E8K14Q1qWhUhxX4q+9LM/p4QgjkfMcKkl
	IXiVgeG/knEA7pYmBx8OYVj9fDT1jb4zAD3bPqYZljJDl9Jgyo82N1kAyj62uebJZdU/Q1qvwKE0e
	UqqyHHfrUTCvuANVc2WG0jJsZD9L2tpt8Mo5/YcLfDaF9BLJFuzuHbICeAQZIezelyf1OxA7Mnnk8
	OirKog+EOIx0oYAG6UwxIuImB4EvVwiTpYvN1KBT1tNMcyvt7DplFBofSZirooeING8lby8A+HdLF
	gN/yghGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st0rL-00000001aR5-1VyW;
	Tue, 24 Sep 2024 08:25:23 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st0rH-00000001aPf-2m1e
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 08:25:22 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 69C6EC0007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727166316; bh=2MZ13KSpovK/1f8WvC0ydyUi4gsaDwi7dW4OXPTlUI0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=CM1P94bGqRhe2RueT9cyUFomIjgdIgiUSuGRN2RX9WGntkaiLIqa0wNrXmCst3fdT
	 Ro7aquHeBbj0v2OPOHeiX0yx+an+ebmHK/pzB/jEhd0+f2hzKvRNv2oX+fezUrgxGO
	 az2WQ0SHagepjZOT74aP5Dr1eN7D/ULX5B2MEagDVwrqfBGsRgwI3PmWRZ5Q7VyLbX
	 Cx1tYfvAHc8y/1lyeUo53Ie8KuKawj/ozRiQFxdeqUODi3bd/dbk+hyx7A71mrvWX6
	 3qncaq9M7NPgKi17ogJ3wkJmDc1/eUYPYzu96YSbe5k+hX7K64ZAvKY4K7JL5Elzw1
	 SyxtaAtTqXNGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727166316; bh=2MZ13KSpovK/1f8WvC0ydyUi4gsaDwi7dW4OXPTlUI0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=nsolFsnW1f5TyaDm0D6j3N2nsYwEkkxFMGsXrETdFfqu0z3xhpiMC4s4auEaTjCPv
	 qV3TdWSA07L8LO7GlAbzSdk8Mjfmcrqxr34CkKgMVohxKH011zuCRHr3zGhW+l0PMy
	 EwI6Tt8WQpJi4V9pMYqwcaA0HmfrfK8qgbsGTsPVjNGK2Oztab0rwbzgiNKwXTbEQd
	 2uyqlhQw04FrlL/3e6aup81C+mccPZcMXHXr5P4g4Z4+ClAHy8+zdYSNoedtp3usBP
	 p8gsRDr3ZO063PZYnQhjYZCTfE3fK6CCMgpj1noM+wHcAC7JCVD7wDlwYhhjdPtEK9
	 dSXTRyoeycZ2w==
Date: Tue, 24 Sep 2024 11:24:25 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 1/1] nvmet: support reservation feature
Message-ID: <20240924082425.GF22571@yadro.com>
References: <20240923094708.42445-1-kanie@linux.alibaba.com>
 <20240923094708.42445-2-kanie@linux.alibaba.com>
 <20240923163228.GD22571@yadro.com>
 <114ce6b1-13e7-418e-bd23-8ab32a7b4c8f@linux.alibaba.com>
 <20240924055433.GE22571@yadro.com>
 <3b315daf-76a6-4360-aeac-65def22aa196@linux.alibaba.com>
 <0cddf902-9e60-43ca-b138-630c5485efa0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0cddf902-9e60-43ca-b138-630c5485efa0@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_012520_759888_78A9A17E 
X-CRM114-Status: GOOD (  33.51  )
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

On Tue, Sep 24, 2024 at 02:38:40PM +0800, Guixin Liu wrote:
> 
> 在 2024/9/24 14:18, Guixin Liu 写道:
> > 
> > 在 2024/9/24 13:54, Dmitry Bogdanov 写道:
> > > On Tue, Sep 24, 2024 at 10:49:58AM +0800, Guixin Liu wrote:
> > > > 在 2024/9/24 00:32, Dmitry Bogdanov 写道:
> > > > > > This patch implements the reservation feature, includes:
> > > > > > 1. reservation register(register, unregister and replace).
> > > > > > 2. reservation acquire(acquire, preempt, preempt and abort).
> > > > > > 3. reservation release(release and clear).
> > > > > > 4. reservation report.
> > > > > > 5. set feature and get feature of reservation notify mask.
> > > > > > 6. get log page of reservation event.
> > > > > > 
> > > > > > And also make reservation configurable, one can set ns to support
> > > > > > reservation before enable ns. The default of resv_enable is false.
> > > > > > 
> > > > > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > > > > ---
> > > > > >    drivers/nvme/target/Makefile    |    2 +-
> > > > > >    drivers/nvme/target/admin-cmd.c |   24 +-
> > > > > >    drivers/nvme/target/configfs.c  |   27 +
> > > > > >    drivers/nvme/target/core.c      |   58 +-
> > > > > >    drivers/nvme/target/nvmet.h     |   49 ++
> > > > > >    drivers/nvme/target/pr.c        | 1214
> > > > > > +++++++++++++++++++++++++++++++
> > > > > >    include/linux/nvme.h            |   54 ++
> > > > > >    7 files changed, 1419 insertions(+), 9 deletions(-)
> > > > > >    create mode 100644 drivers/nvme/target/pr.c
> > > > > ...
> > > > > > +
> > > > > > +static void nvmet_pr_unregister_one(struct nvmet_pr *pr,
> > > > > > +                                   struct nvmet_pr_registrant *reg)
> > > > > > +{
> > > > > > +       struct nvmet_pr_registrant *first_reg;
> > > > > > +       struct nvmet_pr_registrant *holder;
> > > > > > +       u8 original_rtype;
> > > > > > +
> > > > > > +       lockdep_assert_held(&pr->pr_lock);
> > > > > > +       list_del_rcu(&reg->entry);
> > > > > > +
> > > > > > +       holder = rcu_dereference_protected(pr->holder,
> > > > > > + lockdep_is_held(&pr->pr_lock));
> > > > > > +       if (reg != holder)
> > > > > > +               goto out;
> > > > > > +
> > > > > > +       original_rtype = holder->rtype;
> > > > > > +       if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > > > > +           original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> > > > > > +               first_reg =
> > > > > > list_first_or_null_rcu(&pr->registrant_list,
> > > > > > +                               struct nvmet_pr_registrant, entry);
> > > > > > +               if (first_reg)
> > > > > > +                       first_reg->rtype = original_rtype;
> > > > > > +               rcu_assign_pointer(pr->holder, first_reg);
> > > > > > +       } else {
> > > > > > +               rcu_assign_pointer(pr->holder, NULL);
> > > > > > +
> > > > > > +               if (original_rtype ==
> > > > > > NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
> > > > > > +                   original_rtype ==
> > > > > > NVME_PR_WRITE_EXCLUSIVE_REG_ONLY)
> > > > > copy&past error?
> > > > > The second check should be against NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY?
> > > > Indeed, my mistake, it will be fixed in v10.
> > > > > > + nvmet_pr_resv_released(pr, &reg->hostid);
> > > > > > +       }
> > > > > > +out:
> > > > > > +       synchronize_rcu();
> > > > > > +       kfree(reg);
> > > > > > +}
> > > > > > +
> > > > > > ......
> > > > > > +
> > > > > > +static u16 nvmet_pr_preempt(struct nvmet_req *req,
> > > > > > +                           struct nvmet_pr_registrant *reg,
> > > > > > +                           u8 rtype,
> > > > > > +                           struct nvmet_pr_acquire_data *d,
> > > > > > +                           bool abort)
> > > > > > +{
> > > > > > +       struct nvmet_ctrl *ctrl = req->sq->ctrl;
> > > > > > +       struct nvmet_pr *pr = &req->ns->pr;
> > > > > > +       struct nvmet_pr_registrant *holder;
> > > > > > +       enum nvme_pr_type original_rtype;
> > > > > > +       u64 prkey = le64_to_cpu(d->prkey);
> > > > > > +       u16 status;
> > > > > > +
> > > > > > +       lockdep_assert_held(&pr->pr_lock);
> > > > > > +       holder = rcu_dereference_protected(pr->holder,
> > > > > > + lockdep_is_held(&pr->pr_lock));
> > > > > > +       if (!holder)
> > > > > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > > > > + &ctrl->hostid, abort);
> > > > > > +
> > > > > > +       original_rtype = holder->rtype;
> > > > > > +       if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > > > > +           original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> > > > > > +               if (!prkey) {
> > > > > > +                       nvmet_pr_unreg_all_others(req,
> > > > > > &ctrl->hostid, abort);
> > > > > > +                       nvmet_pr_set_new_holder(pr, rtype, reg);
> > > > > You didnot address the reservation atomicity here. You still remove an
> > > > > old holder and then after a some time you set the new holder.
> > > > > In this time gap an incomming WRITE command from a non holder will
> > > > > write
> > > > > to the media.
> > > > Right, I will change it in v10.
> > > > > > +                       return NVME_SC_SUCCESS;
> > > > > > +               }
> > > > > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > > > > +                               &ctrl->hostid, abort);
> > > > > > +       }
> > > > > > +
> > > > > > +       if (holder == reg) {
> > > > > > +               status = nvmet_pr_update_reg_attr(pr, holder,
> > > > > > + nvmet_pr_update_holder_rtype, &rtype);
> > > > > > +               if (!status && original_rtype != rtype)
> > > > > > +                       nvmet_pr_resv_released(pr, &reg->hostid);
> > > > > > +               return status;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (prkey == holder->rkey) {
> > > > > > +               status = nvmet_pr_unreg_all_others_by_prkey(req,
> > > > > > prkey,
> > > > > > + &ctrl->hostid, abort);
> > > > > And here too that timegap with released reservation.
> > > > I will fix this too, and also the
> > > > 
> > > > nvmet_pr_unreg_all_others_by_prkey() does not need a return value,
> > > > 
> > > > I remove it.
> > > > 
> > > > > > +               if (status)
> > > > > > +                       return status;
> > > > > > +
> > > > > > +               nvmet_pr_set_new_holder(pr, rtype, reg);
> > > > > > +               if (original_rtype != rtype)
> > > > > > +                       nvmet_pr_resv_released(pr, &reg->hostid);
> > > > > This function is(may be) already invoked in nvmet_pr_unregister_one.
> > > > > 
> > > > Not, here the original_rtype is not NVME_PR_WRITE_EXCLUSIVE_REG_ONLY or
> > > > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS, so the nvmet_pr_unregister_one will
> > > > not call nvmet_pr_resv_released.
> > > nvmet_pr_unregister_one sends an event for original_rtype == *_REG_ONLY
> > > Here you have only original_rtype != ALL_REGS, so _REG_ONLY is possible.
> > My mistake, it will be removed in v10, thanks.
> 
> I take a look again, if we set self new holder before call
> nvmet_pr_unreg_all_others_by_prkey(), the
> nvmet_pr_unreg_all_others_by_prkey() will
> 
> not unregister self, so this will not goto nvmet_pr_unregister_one()'s
> calling nvmet_pr_resv_released().

Yes, and this is a reason not to try to fix non-atomicity (anothter my
comment) by setting new holder before unregistering.

Regarding this place, here nvmet_pr_resv_released should be called for
original_rtype !=*_REG_ONLY with a note that _REG_ONLY handled in nvmet_pr_unregister_one.

Please, do not take my suggestions "how to fix" as a direct order, it's
just suggestion.

> > > > > > +               return status;
> > > > > > +       }
> > > > > > +
> > > > > > +       if (prkey)
> > > > > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > > > > + &ctrl->hostid, abort);
> > > > > > +       return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> > > > > > +}
> > > > > > +
> > > > > > +static void nvmet_pr_confirm_ns_pc_ref(struct percpu_ref *ref)
> > > > > > +{
> > > > > > +       struct nvmet_pr_per_ctrl_ref *pc_ref =
> > > > > > +               container_of(ref, struct nvmet_pr_per_ctrl_ref, ref);
> > > > > > +
> > > > > > +       complete(&pc_ref->confirm_done);
> > > > > > +}
> > > > > > +

