Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCCDCF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 05:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OBP7uXwOlLUhbaUci8/dxb/PzLE+MZiJNIENudkqU3Y=; b=BvKfIvG/uBdZ6X8iTraFCDm133
	CXH3lF0LNkWnmmPcUdDcQJV0gbsEHPhcfTq9Ryqz5mgbd7TwiU0+rBwYYOP/tPgFrBfDp4+pJt+mU
	vF+1yvV1mpvmPV9tf8pQt1zfl0siQHM1IDcIQoHerqphYye3I+UdnzGZvp67h7qw8p1M29kS08d5V
	9NY7IkJwWSXyXGSpaxn/9WNZNC3JdE/kAfHS4MW/Li6CJsVjwcm3YHyiFRffi6SEWfb18iZeuzwBB
	udJ+FkWUzM39ZR5oBITKc4l6oXmEnxq5VHpvlIt7FfsyqqcQX9m8JO6Vgt5jLE87ulunJPSleL6G4
	pN/0yjjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssyWK-000000019Qp-2i5K;
	Tue, 24 Sep 2024 05:55:32 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssyWG-000000019QP-39VQ
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 05:55:31 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 01942C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727157324; bh=OBP7uXwOlLUhbaUci8/dxb/PzLE+MZiJNIENudkqU3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=n60ZsOg/X+vPj+RtGGrik6U2Ne9kJsvtxDbAz0RzJfY+QtZO96H7JkwHIdX9oeS4V
	 iqzoyjmxzwaX7djKUBdHaUOUXmPRwDpTXZblv3KfFl/iEQcYkusuOOpU2vWnppd9k5
	 ojp6hMlZLypJ0lf2u5CA/U+cQh0/0a0Wb69VhpLVwi5gF6z6Efgm0WC0vU73VcjqzM
	 GynPnBmz2bxNyY5j+iFcZwOx0JThgvFJ3tKbO7f4CJ5ZOqcM6vPsGcxrsmckNmzaSQ
	 QbnIdHacgKZ7RBB0NZgFBVnXJP5Y+SjxXLoJiK6TIIPvpwcQbY/EsonGsonRM1DFTc
	 v3vtBdkFv0c6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727157324; bh=OBP7uXwOlLUhbaUci8/dxb/PzLE+MZiJNIENudkqU3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=NlOGOz3O91NfnUimSY/+N2KNl9/5W4GnIOtQANOUbLUgQ5A9CIR2PgQKkTPRnq+WS
	 vZOZ8Mea+4QMQW5JIIQijc5DVJVltH7FsLbvtgAThll7GEVgdLDIwsU7K2EGQ4kmx3
	 zQjKsEp9gQ9MStSCcl0Xyha6SMBjpeMW9jrsqFx3nOxfze+PKoJG6Syojw3zFvbDqU
	 j5t9lmDczfnQ7WIr8epUYQteLF/FUuy9HhyZaEKBhcRRHWfTMNHz0uBScky9PwH1Hl
	 sxB9BzRkBWv5L/bagBmz4dqN8kgonVGVmalQ9k+MTQ6eCh3faq8HjDS1TjmDOhUy1Z
	 uEOcyfNPHmiuw==
Date: Tue, 24 Sep 2024 08:54:33 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 1/1] nvmet: support reservation feature
Message-ID: <20240924055433.GE22571@yadro.com>
References: <20240923094708.42445-1-kanie@linux.alibaba.com>
 <20240923094708.42445-2-kanie@linux.alibaba.com>
 <20240923163228.GD22571@yadro.com>
 <114ce6b1-13e7-418e-bd23-8ab32a7b4c8f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <114ce6b1-13e7-418e-bd23-8ab32a7b4c8f@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_225529_686265_D4AC34FA 
X-CRM114-Status: GOOD (  34.89  )
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

On Tue, Sep 24, 2024 at 10:49:58AM +0800, Guixin Liu wrote:
> 
> 在 2024/9/24 00:32, Dmitry Bogdanov 写道:
> > > This patch implements the reservation feature, includes:
> > > 1. reservation register(register, unregister and replace).
> > > 2. reservation acquire(acquire, preempt, preempt and abort).
> > > 3. reservation release(release and clear).
> > > 4. reservation report.
> > > 5. set feature and get feature of reservation notify mask.
> > > 6. get log page of reservation event.
> > > 
> > > And also make reservation configurable, one can set ns to support
> > > reservation before enable ns. The default of resv_enable is false.
> > > 
> > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > ---
> > >   drivers/nvme/target/Makefile    |    2 +-
> > >   drivers/nvme/target/admin-cmd.c |   24 +-
> > >   drivers/nvme/target/configfs.c  |   27 +
> > >   drivers/nvme/target/core.c      |   58 +-
> > >   drivers/nvme/target/nvmet.h     |   49 ++
> > >   drivers/nvme/target/pr.c        | 1214 +++++++++++++++++++++++++++++++
> > >   include/linux/nvme.h            |   54 ++
> > >   7 files changed, 1419 insertions(+), 9 deletions(-)
> > >   create mode 100644 drivers/nvme/target/pr.c
> > ...
> > > +
> > > +static void nvmet_pr_unregister_one(struct nvmet_pr *pr,
> > > +                                   struct nvmet_pr_registrant *reg)
> > > +{
> > > +       struct nvmet_pr_registrant *first_reg;
> > > +       struct nvmet_pr_registrant *holder;
> > > +       u8 original_rtype;
> > > +
> > > +       lockdep_assert_held(&pr->pr_lock);
> > > +       list_del_rcu(&reg->entry);
> > > +
> > > +       holder = rcu_dereference_protected(pr->holder,
> > > +                       lockdep_is_held(&pr->pr_lock));
> > > +       if (reg != holder)
> > > +               goto out;
> > > +
> > > +       original_rtype = holder->rtype;
> > > +       if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > +           original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> > > +               first_reg = list_first_or_null_rcu(&pr->registrant_list,
> > > +                               struct nvmet_pr_registrant, entry);
> > > +               if (first_reg)
> > > +                       first_reg->rtype = original_rtype;
> > > +               rcu_assign_pointer(pr->holder, first_reg);
> > > +       } else {
> > > +               rcu_assign_pointer(pr->holder, NULL);
> > > +
> > > +               if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
> > > +                   original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY)
> > copy&past error?
> > The second check should be against NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY?
> Indeed, my mistake, it will be fixed in v10.
> > > +                       nvmet_pr_resv_released(pr, &reg->hostid);
> > > +       }
> > > +out:
> > > +       synchronize_rcu();
> > > +       kfree(reg);
> > > +}
> > > +
> > > ......
> > > +
> > > +static u16 nvmet_pr_preempt(struct nvmet_req *req,
> > > +                           struct nvmet_pr_registrant *reg,
> > > +                           u8 rtype,
> > > +                           struct nvmet_pr_acquire_data *d,
> > > +                           bool abort)
> > > +{
> > > +       struct nvmet_ctrl *ctrl = req->sq->ctrl;
> > > +       struct nvmet_pr *pr = &req->ns->pr;
> > > +       struct nvmet_pr_registrant *holder;
> > > +       enum nvme_pr_type original_rtype;
> > > +       u64 prkey = le64_to_cpu(d->prkey);
> > > +       u16 status;
> > > +
> > > +       lockdep_assert_held(&pr->pr_lock);
> > > +       holder = rcu_dereference_protected(pr->holder,
> > > +                       lockdep_is_held(&pr->pr_lock));
> > > +       if (!holder)
> > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > +                                       &ctrl->hostid, abort);
> > > +
> > > +       original_rtype = holder->rtype;
> > > +       if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > +           original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> > > +               if (!prkey) {
> > > +                       nvmet_pr_unreg_all_others(req, &ctrl->hostid, abort);
> > > +                       nvmet_pr_set_new_holder(pr, rtype, reg);
> > You didnot address the reservation atomicity here. You still remove an
> > old holder and then after a some time you set the new holder.
> > In this time gap an incomming WRITE command from a non holder will write
> > to the media.
> Right, I will change it in v10.
> > > +                       return NVME_SC_SUCCESS;
> > > +               }
> > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > +                               &ctrl->hostid, abort);
> > > +       }
> > > +
> > > +       if (holder == reg) {
> > > +               status = nvmet_pr_update_reg_attr(pr, holder,
> > > +                               nvmet_pr_update_holder_rtype, &rtype);
> > > +               if (!status && original_rtype != rtype)
> > > +                       nvmet_pr_resv_released(pr, &reg->hostid);
> > > +               return status;
> > > +       }
> > > +
> > > +       if (prkey == holder->rkey) {
> > > +               status = nvmet_pr_unreg_all_others_by_prkey(req, prkey,
> > > +                                       &ctrl->hostid, abort);
> > And here too that timegap with released reservation.
> I will fix this too, and also the
> 
> nvmet_pr_unreg_all_others_by_prkey() does not need a return value,
> 
> I remove it.
> 
> > > +               if (status)
> > > +                       return status;
> > > +
> > > +               nvmet_pr_set_new_holder(pr, rtype, reg);
> > > +               if (original_rtype != rtype)
> > > +                       nvmet_pr_resv_released(pr, &reg->hostid);
> > This function is(may be) already invoked in nvmet_pr_unregister_one.
> > 
> Not, here the original_rtype is not NVME_PR_WRITE_EXCLUSIVE_REG_ONLY or
> NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS, so the nvmet_pr_unregister_one will
> not call nvmet_pr_resv_released.

nvmet_pr_unregister_one sends an event for original_rtype == *_REG_ONLY
Here you have only original_rtype != ALL_REGS, so _REG_ONLY is possible.

> > > +               return status;
> > > +       }
> > > +
> > > +       if (prkey)
> > > +               return nvmet_pr_unreg_all_host_by_prkey(req, prkey,
> > > +                                       &ctrl->hostid, abort);
> > > +       return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> > > +}
> > > +
> > > +static void nvmet_pr_confirm_ns_pc_ref(struct percpu_ref *ref)
> > > +{
> > > +       struct nvmet_pr_per_ctrl_ref *pc_ref =
> > > +               container_of(ref, struct nvmet_pr_per_ctrl_ref, ref);
> > > +
> > > +       complete(&pc_ref->confirm_done);
> > > +}
> > > +
> > > +static void nvmet_pr_do_abort(struct nvmet_req *req)
> > > +{
> > > +       struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
> > > +       struct nvmet_pr_per_ctrl_ref *pc_ref;
> > > +       struct nvmet_ctrl *ctrl = NULL;
> > > +
> > > +find_next:
> > > +       mutex_lock(&subsys->lock);
> > > +       list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> > > +               if (ctrl->pr_abort)
> > > +                       goto do_abort;
> > > +       }
> > > +       mutex_unlock(&subsys->lock);
> > > +       return;
> > > +
> > > +do_abort:
> > > +       mutex_unlock(&subsys->lock);
> > > +       /*
> > > +        * The target dose not support abort, just wait ref to 0.
> > typo "dose"->"does"
> > 
> Sure.
> > > +        */
> > > +       pc_ref = xa_load(&req->ns->pr_per_ctrl_refs, ctrl->cntlid);
> > > +       percpu_ref_kill_and_confirm(&pc_ref->ref, nvmet_pr_confirm_ns_pc_ref);
> > > +       wait_for_completion(&pc_ref->confirm_done);
> > > +       wait_for_completion(&pc_ref->free_done);
> > > +       reinit_completion(&pc_ref->confirm_done);
> > > +       reinit_completion(&pc_ref->free_done);
> > > +       percpu_ref_resurrect(&pc_ref->ref);
> > > +
> > > +       ctrl->pr_abort = false;
> > pr_abort flag is per controller, but this function is per namespace.
> > The use case of preempt_and_abort is to preempt reservation of a "zomby" host
> > for the all namespaces. It means that preempt_and_abort command will be sent
> > for the each namespace and there will be several parallel abort processes for
> > the same controllers. And you should not mix them.
> > 
> > May be doing ref_kill instead of setting ctlr->pr_abort=true will more
> > accuratelly set the barier for incoming IO. You may use Mark feature in
> > XArrays to mark pc_ref to wait the completion for and use xa_for_each_marked
> > for going through such pc_refs.
> 
> Good idea, thanks very much, will changed in v10.
> 
> Best Regards,
> 
> Guixin Liu
> 
> > > +       nvmet_ctrl_put(ctrl);
> > > +       goto find_next;
> > > +}
> > > +
> > > +static u16 __nvmet_execute_pr_acquire(struct nvmet_req *req,
> > > +                                     struct nvmet_pr_registrant *reg,
> > > +                                     u8 acquire_act,
> > > +                                     u8 rtype,
> > > +                                     struct nvmet_pr_acquire_data *d)
> > > +{
> > > +       u16 status;
> > > +
> > > +       switch (acquire_act) {
> > > +       case NVME_PR_ACQUIRE_ACT_ACQUIRE:
> > > +               status = nvmet_pr_acquire(req, reg, rtype);
> > > +               goto out;
> > > +       case NVME_PR_ACQUIRE_ACT_PREEMPT:
> > > +               status = nvmet_pr_preempt(req, reg, rtype, d, false);
> > > +               goto inc_gen;
> > > +       case NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT:
> > > +               status = nvmet_pr_preempt(req, reg, rtype, d, true);
> > > +               if (!status)
> > > +                       nvmet_pr_do_abort(req);
> > > +               goto inc_gen;
> > > +       default:
> > > +               req->error_loc = offsetof(struct nvme_common_command, cdw10);
> > > +               status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> > > +               goto out;
> > > +       }
> > > +inc_gen:
> > > +       if (!status)
> > > +               atomic_inc(&req->ns->pr.generation);
> > > +out:
> > > +       return status;
> > > +}
> > > +

