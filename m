Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC34CFB43F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cODEJYL8GQvI2usSorTSsUTvVQJOhd7FI2nKKFzqdmM=; b=mNvh6gIDR71GEwjh6WJCcLMsMQ
	53ZNiLFKYXy0pZ26Kc1VpbCaSaxtumgdSOJZO7/9wRfn7BKNW2NdBHBFoQcZf15G333Y7TCj7vwq6
	+7XbJiF8K9JdmcBHbVi/XmI6edlZEvqRwutk1Eql5M2txfRLTcCk1dcRQQb8HPB2YlAKi+0+J96nu
	9WCjUyz1UGD2Lz9BmHXENnpHXRLPvFZDmQIGwYDDdcQxFFTVUSqIaHDEOXWD+8g/JaCjXOYkcaPN/
	BkjEI+f30CUTiSNdnrjSzQhrPwv7K83YDDU6SwibnUz9FppO0xMT4DdkgTldHUKpesUGLYt/b3UTJ
	ODHwhuZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxk4S-00000001ua3-0pLC;
	Mon, 07 Oct 2024 09:30:28 +0000
Received: from mta-03.yadro.com ([89.207.88.253])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxinh-00000001hgW-3rvb
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 08:09:08 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com BC9BEE0025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1728288538; bh=cODEJYL8GQvI2usSorTSsUTvVQJOhd7FI2nKKFzqdmM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=Vr3M2WaERcWUMq/JnOSvWmUXPumXRG7mjvPltzrZ/1nTG832WBRpa4mHiVb6ltRZQ
	 B+giGCtRg6WvbAuUNhWvj1VsURieyhOL0QrpEqJpLg+jjvekx6JkZc2jIfDp07PPOz
	 r0N80DgOyLc5NGafK8/jSlIco7eBJZnwjoP5rhjLLsNgy+1NgN1vOg0VYJ2gABQmbQ
	 7+r0YRHAVTwH+ia04jNBLRFC4o2fkTPrKbJYgnZW83QYqO75zXjWl2Pt4vGESy+kCi
	 9VVfwSVv0JVyjuIIgDfQZt1LaFugg6QvqcUdOF+hsWV5ovNzCww+YMHLhIoIKHsduS
	 P1rLrx7QAhjhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1728288538; bh=cODEJYL8GQvI2usSorTSsUTvVQJOhd7FI2nKKFzqdmM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=g/deKL8HdzHk7lO9Cmf0wVJtjoeY69gWPWiB0TMx5RAfPWdYN6LOatge0bxygzcwY
	 y+W9p6gM5BU0SPvJff6gchTTDXdk4isesC+u8zHLCyz8Z+fxPYktN4oFglaPArpSov
	 GvbspShE5xrXK6GEm0nANteahKPmPvEkcteiHxraZDIdravrRUuSuQ2rEnuCVSlBCw
	 W08Xe/G0DxSvDpm2TcvWJOKr/3KYLvM7hrrzuJAAkUf1SW0l6YYDYaIPFv32hoCaD7
	 TYMyhBmPXN+Gcc8K+fBW6OBKxUngM8cw5qTNk5DxTOK06Mk40YjSOX1jQcfN1QLIGk
	 Z3YrtE4b3dl8A==
Date: Mon, 7 Oct 2024 11:08:53 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
Message-ID: <20241007080853.GJ22571@yadro.com>
References: <20240929031410.31281-1-kanie@linux.alibaba.com>
 <20240929031410.31281-2-kanie@linux.alibaba.com>
 <20240930125329.GI22571@yadro.com>
 <b5059469-d908-41e2-811d-8e4565d0b1dd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5059469-d908-41e2-811d-8e4565d0b1dd@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_010906_836806_5B673621 
X-CRM114-Status: GOOD (  25.24  )
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

On Sat, Oct 05, 2024 at 10:26:58PM +0800, Guixin Liu wrote:
> 在 2024/9/30 20:53, Dmitry Bogdanov 写道:
> > On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
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
> > > +
> > > +static void nvmet_execute_pr_report(struct nvmet_req *req)
> > > +{
> > > +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> > > +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> > > +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
> > > +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
> > > +       struct nvme_registered_ctrl_ext *ctrl_eds;
> > > +       struct nvme_reservation_status_ext *data;
> > > +       struct nvmet_pr *pr = &req->ns->pr;
> > > +       struct nvmet_pr_registrant *holder;
> > > +       struct nvmet_pr_registrant *reg;
> > > +       u16 num_ctrls = 0;
> > > +       u16 status;
> > > +       u8 rtype;
> > > +
> > > +       /* nvmet hostid(uuid_t) is 128 bit. */
> > > +       if (!eds) {
> > > +               req->error_loc = offsetof(struct nvme_common_command, cdw11);
> > > +               status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
> > > +               goto out;
> > > +       }
> > > +
> > > +       if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
> > > +               req->error_loc = offsetof(struct nvme_common_command, cdw10);
> > > +               status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> > > +               goto out;
> > > +       }
> > > +
> > > +       data = kmalloc(num_bytes, GFP_KERNEL);
> > > +       if (!data) {
> > > +               status = NVME_SC_INTERNAL;
> > > +               goto out;
> > > +       }
> > > +       memset(data, 0, num_bytes);
> > > +       data->gen = cpu_to_le32(atomic_read(&pr->generation));
> > > +       data->ptpls = 0;
> > > +       ctrl_eds = data->regctl_eds;
> > > +
> > > +       rcu_read_lock();
> > > +       holder = rcu_dereference(pr->holder);
> > > +       rtype = holder ? holder->rtype : 0;
> > > +       data->rtype = rtype;
> > > +
> > > +       list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
> > > +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
> > > +                       break;
> > > +               /*
> > > +                * Dynamic controller, set cntlid to 0xffff.
> > > +                */
> > > +               ctrl_eds->cntlid = 0xffff;
> > > +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> > > +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
> > > +                       ctrl_eds->rcsts = 1;
> > > +               if (holder && uuid_equal(&reg->hostid, &holder->hostid))
> > is just (reg == holder) not enough here?
> Yes.
> > > +                       ctrl_eds->rcsts = 1;
> > > +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
> > > +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
> > > +               ctrl_eds++;
> > > +               num_ctrls++;
> > > +       }
> > > +       rcu_read_unlock();
> > > +
> > > +       put_unaligned_le16(num_ctrls, data->regctl);
> > Here you should report the number of all registered registrants in ns,
> > not the only reported. It is used by the host to understand that it got
> > not a full response.
> > NUMD field (cdw11) is about transfering the response. But the structure itsef in
> > the reposnse has to be complete.
> 
> The NVMe spec says that:
> 
>     "This indicates the number of Registered Controller data structures
> and/or Registered Controller extended data structures contained in this
> data structure."

You read not the latest Spec again. Spec v2.1 has another statement:
  Number of Registrants (REGSTRNT): This field indicates the number of registrants of the
  namespace. This indicates the number of Registrant data structures or Registrant Extended data
  structures contained in this data structure.

> 
> It means that host use this filed to obtain the reported registrants number.
> 

Think from the host point of view - how are you going to understand
how much registrants are there in the namespace? 

BR,
 Dmitry

