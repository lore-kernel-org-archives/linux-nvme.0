Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9629ACED27C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpYPWQvQEvvdY8QhwAuHxYx2JQnW6LZOEhQecPJaW3M=; b=yzUKSvf0H/GAtdXgE/v/vrLepq
	vEkwJbj2+FMdkIwCkF1WMb1s3R93unjeLipx6wo68xEebL1vpB5QbAVw21UTTuIDGsSriX553Fkzg
	KXQBUfViEQ0HFhOOn0espRpVPC97UOuU+WnKpEY3eiHpsvChin0cVhvticPbI/HenOQ7TrcZzuHGh
	s5bvpDHlbFD0TW6l39zXKFx32HImDBlXdf73/DHP/BZvx0p6O0sIGRkJaFgVAaudb5/YRmBplVPJ2
	B4rcoT6RDPYvZARF3g6YjuhSnOn8TGoEaEw3DReeH+5ytFiFmwZFL40MLXXSjaWEBTtYp9xHeHqZr
	5Pg6aU+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5t0-000000058M7-0l1h;
	Tue, 08 Oct 2024 08:48:06 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy5qm-000000057iK-3M8N
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 08:45:51 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 0959BE0008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1728377144; bh=QpYPWQvQEvvdY8QhwAuHxYx2JQnW6LZOEhQecPJaW3M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=oZh3VRLxaIJ5DN579FWY1HAPdWo1m7a/QqGxVKQV694ihlS0klA9c3aNMoCaBOZum
	 3bHs8mLYqwpODodcvpcTMUNPylWe+8ngc5o7jJ3QUOPgDpuvmnLQDagnMzbfIaRbKD
	 98QV0dt2F3VxthOfN27WsUS80CcuUQI0TbydOz5qeZPcRMLGT70Yl9E+wfU4ELEDCx
	 IyFZGLRrRyeSFnxkHiymrCX623mZoKlMHhcj+NdcEIRy0s9CQpkXk4PRl/hY/3bxRx
	 NjmB+S7h6d2KWiJrUEPKQ0Ugnl3wR8Z1ohoLOQHpV34bUDbiZfbjyOl2Qv/ycdF+9j
	 xoOMeiBM+CLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1728377144; bh=QpYPWQvQEvvdY8QhwAuHxYx2JQnW6LZOEhQecPJaW3M=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=kVCY88GaSUqBEqA/TtZbGy//lRuXPU4R1uvf5j2CwHjP8P4yoBnu2WJAeQ6fazIID
	 vQ91dnqqiK+KT5MDwlu4koNuSa0MzvFPRqoUe5Jb5a6uPwOu53XmJ0kPV1zmV6///p
	 0FaOaMIXkl4hUJDTftPko5Zm1cqHCnnjIx1rbgPkxelWqXbH1FzcS1+mB/3gs2ojYS
	 Aes5fRMDbvj0STFVJREmHz+fo2e4X9xJtXurB+uQ1PqVhsSSOCKKKHvDXdFD21YNhA
	 jUZSorGCaGLmxV8uyKLYKT/TMrI/BXSasWJ+8rkDC1rlbVss8Xs8NP3HRfjWcp3CXZ
	 BQ/7cX5zjc1Iw==
Date: Tue, 8 Oct 2024 11:45:38 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
Message-ID: <20241008084537.GK22571@yadro.com>
References: <20240929031410.31281-1-kanie@linux.alibaba.com>
 <20240929031410.31281-2-kanie@linux.alibaba.com>
 <20240930125329.GI22571@yadro.com>
 <b5059469-d908-41e2-811d-8e4565d0b1dd@linux.alibaba.com>
 <20241007080853.GJ22571@yadro.com>
 <fea312d9-5b53-48b9-9002-2b68053a22a0@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fea312d9-5b53-48b9-9002-2b68053a22a0@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_014549_755285_CF96BBC2 
X-CRM114-Status: GOOD (  34.24  )
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

On Tue, Oct 08, 2024 at 03:27:46PM +0800, Guixin Liu wrote:
> 在 2024/10/7 16:08, Dmitry Bogdanov 写道:
> > On Sat, Oct 05, 2024 at 10:26:58PM +0800, Guixin Liu wrote:
> > > 在 2024/9/30 20:53, Dmitry Bogdanov 写道:
> > > > On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
> > > > > This patch implements the reservation feature, includes:
> > > > > 1. reservation register(register, unregister and replace).
> > > > > 2. reservation acquire(acquire, preempt, preempt and abort).
> > > > > 3. reservation release(release and clear).
> > > > > 4. reservation report.
> > > > > 5. set feature and get feature of reservation notify mask.
> > > > > 6. get log page of reservation event.
> > > > > 
> > > > > And also make reservation configurable, one can set ns to support
> > > > > reservation before enable ns. The default of resv_enable is false.
> > > > > 
> > > > > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > > > > ---
> > > > > +
> > > > > +static void nvmet_execute_pr_report(struct nvmet_req *req)
> > > > > +{
> > > > > +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> > > > > +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> > > > > +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
> > > > > +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
> > > > > +       struct nvme_registered_ctrl_ext *ctrl_eds;
> > > > > +       struct nvme_reservation_status_ext *data;
> > > > > +       struct nvmet_pr *pr = &req->ns->pr;
> > > > > +       struct nvmet_pr_registrant *holder;
> > > > > +       struct nvmet_pr_registrant *reg;
> > > > > +       u16 num_ctrls = 0;
> > > > > +       u16 status;
> > > > > +       u8 rtype;
> > > > > +
> > > > > +       /* nvmet hostid(uuid_t) is 128 bit. */
> > > > > +       if (!eds) {
> > > > > +               req->error_loc = offsetof(struct nvme_common_command, cdw11);
> > > > > +               status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
> > > > > +               req->error_loc = offsetof(struct nvme_common_command, cdw10);
> > > > > +               status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       data = kmalloc(num_bytes, GFP_KERNEL);
> > > > > +       if (!data) {
> > > > > +               status = NVME_SC_INTERNAL;
> > > > > +               goto out;
> > > > > +       }
> > > > > +       memset(data, 0, num_bytes);
> > > > > +       data->gen = cpu_to_le32(atomic_read(&pr->generation));
> > > > > +       data->ptpls = 0;
> > > > > +       ctrl_eds = data->regctl_eds;
> > > > > +
> > > > > +       rcu_read_lock();
> > > > > +       holder = rcu_dereference(pr->holder);
> > > > > +       rtype = holder ? holder->rtype : 0;
> > > > > +       data->rtype = rtype;
> > > > > +
> > > > > +       list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
> > > > > +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
> > > > > +                       break;
> > > > > +               /*
> > > > > +                * Dynamic controller, set cntlid to 0xffff.
> > > > > +                */
> > > > > +               ctrl_eds->cntlid = 0xffff;
> > > > > +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > > > +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
> > > > > +                       ctrl_eds->rcsts = 1;
> > > > > +               if (holder && uuid_equal(&reg->hostid, &holder->hostid))
> > > > is just (reg == holder) not enough here?
> > > Yes.
> > > > > +                       ctrl_eds->rcsts = 1;
> > > > > +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
> > > > > +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
> > > > > +               ctrl_eds++;
> > > > > +               num_ctrls++;
> > > > > +       }
> > > > > +       rcu_read_unlock();
> > > > > +
> > > > > +       put_unaligned_le16(num_ctrls, data->regctl);
> > > > Here you should report the number of all registered registrants in ns,
> > > > not the only reported. It is used by the host to understand that it got
> > > > not a full response.
> > > > NUMD field (cdw11) is about transfering the response. But the structure itsef in
> > > > the reposnse has to be complete.
> > > The NVMe spec says that:
> > > 
> > >      "This indicates the number of Registered Controller data structures
> > > and/or Registered Controller extended data structures contained in this
> > > data structure."
> > You read not the latest Spec again. Spec v2.1 has another statement:
> >    Number of Registrants (REGSTRNT): This field indicates the number of registrants of the
> >    namespace. This indicates the number of Registrant data structures or Registrant Extended data
> >    structures contained in this data structure.
> 
> Well, still, "contained in this data structure" means that we should
> report how many registrants we reported.

No, vice-versa :), that means that "this data structure" shall contain "the number
of registrants of the namespace".

> 
> I do a research on nvme-cli and SPDK:
> 
> 1. nvme-cli: In json_nvme_resv_report, use reported regctls to traverse
> reported registrants.

I saw, and that is a security violation - to trust a data from a network.
Try to set a small NUMD and ask ReservationRepost from SPDK nvme target -
you will get a coredump of nvme-cli due to aouut-of-bound access of its
buffer (NUMD sized).

Instead, it shall send ReservationReport twice - the first with small
buffer to get just REGSTRNT, and the second with a full buffer to get
the whole list. That is a common handling of a variable length response
in SCSI, and NVME too.

> 
> 2. SPDK: In nvmf_ns_reservation_report, set regctl to the number of
> reported registrants.

Looks like you see again not the last version of the reference.
The latest SPDK has a correct implementation - It reports a whole
registrants list since Feb 13, 2023.
Please, follow it.

> Best Regards,
> 
> Guixin Liu
> 
> > > It means that host use this filed to obtain the reported registrants number.
> > > 
> > Think from the host point of view - how are you going to understand
> > how much registrants are there in the namespace?

BR,
 Dmitry

