Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B62CCD1A5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dUQzTJ3GHa+ZleDgS1Bc9Xyqd4J5LqQGFbaizeuOKtU=; b=CHAhif2m69XW+RN1QwLIQ7Zmud
	7F2EYJ5xtRyHw9ORKYcqeZcmV7j4E0i84fgjEPquFK/4P8EVfqFHpOaObbesMT9hUK88EBugP4B58
	ZhIsmfMEtPEItIVZZTet0sufITZnmN2lAqVdTrgm162CUA23J5tS57yRS/HSIqWhTq1Kb8vvGfw+m
	OBozwNI4yX2cIHzN2y0ZaVI/4U1pSkvedLmvKhM0Eq8bu0xXJbUufnEv3THiCLJkNJhIdYq0ZtsAU
	iSlT4iUwS6N6aY8qrncnx3JlwGx5zxnAo2lBXxaTYC7hPSdYJnY2r+DylJou8XLqr9q+uxkoWhhdi
	0HhPvBDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1squxR-00000008MLb-3eG9;
	Wed, 18 Sep 2024 13:43:01 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1squxG-00000008MJZ-0F4Q
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 13:42:52 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 48151C0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726666964; bh=dUQzTJ3GHa+ZleDgS1Bc9Xyqd4J5LqQGFbaizeuOKtU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=gkILKALrzPoFKgenKQn63zTN15BMa/2XnWwlZK4zQbPoNbmBjOlbyGv9PEWflUxxn
	 beAtRFCvCh+Y2dnupTek1DhsnDEbBcfSNGdZwwNPHvdquGeK06W2dawExc4hpwUDSL
	 pmNMWEfGayfx7akFCUIR7wO+JvTqftRjjz7oPdRaTQ4atQIQq37HiDZH+w6u2B/dZf
	 5G1MgF6i9/WVpgy7DJcViJFIyxM5UH8yc4d2zh9KitEZetk4J+xwiGVLg2wtmIMQ04
	 P+FMSlqtk+Lp1bR1Mpe5eoOZggdpAZjuE8F0Um5Yrn6tIK3pnY474VRHySeswA9i7k
	 yrH4WYqJKoexA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726666964; bh=dUQzTJ3GHa+ZleDgS1Bc9Xyqd4J5LqQGFbaizeuOKtU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=uqorleE02u/qfVtnQUaFBCO02MoEkplFJCJzjNu7Wjc8gOuTPAn44rO1hdqSG15Kq
	 LnFB64O+cp2TbSMZuiobg6KT6U6jxFv+3nEiwwi5z8aC1ntAXTtC0OzIk9GNLv99kZ
	 gXL0okTkG2t/Sg7wPGinPRvgHYmk34sbz0q7ACk3GT4PThK0RQUix9lStp/zhqQ6+G
	 9/isOQrEySgAhZ5pyJEbq16Di1dWtzuVRP24954sVFBpAGOIehHXNnX1doNocFiOz1
	 fx9b01HFdbxUJvrH9iM1SNMfU+OZhGA/D9IfFPAlK1XKtwlHcnZW4mg/icGJEwOGGv
	 WNuZNBJeYVtRg==
Date: Wed, 18 Sep 2024 16:41:59 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v8 1/1] nvmet: support reservation feature
Message-ID: <20240918134159.GC22571@yadro.com>
References: <20240229031241.8692-1-kanie@linux.alibaba.com>
 <20240229031241.8692-2-kanie@linux.alibaba.com>
 <20240917084352.GB22571@yadro.com>
 <ac49575c-006b-4244-8114-c992ba9948cc@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac49575c-006b-4244-8114-c992ba9948cc@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_064250_987099_593D4C7A 
X-CRM114-Status: GOOD (  30.84  )
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

On Wed, Sep 18, 2024 at 04:26:10PM +0800, Guixin Liu wrote:
> 
> Hi Dmitry,
> 
>     My thanks for your advice, I will work on this back recently.
> 
> 
> 在 2024/9/17 16:43, Dmitry Bogdanov 写道:
> > Hi,
> > 
> > Waiting for the final solution half an year we taken this patch as is.
> > Here is my comments on it. Hope, this will bring the life to the patch.
> > 
> > > +void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
> > > +{
> > > +       struct nvmet_pr_log_mgr *log_mgr = &req->sq->ctrl->pr_log_mgr;
> > > +       struct nvme_pr_log next_log = {0};
> > > +       struct nvme_pr_log log = {0};
> > > +       u16 status = NVME_SC_SUCCESS;
> > > +       u64 lost_count;
> > > +       u64 cur_count;
> > > +       u64 next_count;
> > > +
> > > +       mutex_lock(&log_mgr->lock);
> > > +       if (!kfifo_get(&log_mgr->log_queue, &log))
> > > +               goto out;
> > > +
> > > +       /*
> > > +        * We can't get the last in kfifo.
> > > +        * Utilize the current count and the count from the next log to
> > > +        * calculate the number of lost logs, while also addressing cases
> > > +        * of overflow. If there is no subsequent log, the number of lost
> > > +        * logs is equal to the lost_count within the nvmet_pr_log_mgr.
> > > +        */
> > > +       cur_count = le64_to_cpu(log.count);
> > > +       if (kfifo_peek(&log_mgr->log_queue, &next_log)) {
> > > +               next_count = le64_to_cpu(next_log.count);
> > > +               if (next_count > cur_count)
> > > +                       lost_count = next_count - cur_count - 1;
> > > +               else
> > > +                       lost_count = U64_MAX - cur_count + next_count - 1;
> > > +       } else {
> > > +               lost_count = log_mgr->lost_count;
> > > +       }
> > > +
> > > +       log.count = cpu_to_le64(cur_count + lost_count);
> > This value should be wrapped by U64_MAX too but in reverse direction
> > (count is next_count-1). If == 0 then = -1.
> > 
> The next_count will never be 0, you can see in nvmet_pr_add_resv_log, when
> 
> the log_mgr->counter == 0, I set the log_mgr->counter to 1.
I mean that herer tou should add the same logic as in nvmet_pr_add_resv_log.
I am talking about this case:
next_count = 2
cur_count  = 0xffffffff
lost_count = U64_MAX - cur_count + next_count - 1 =  0xffffffff - 0xffffffff + 2 - 1 = 1
log.count = cpu_to_le64(cur_count + lost_count) = 0xffffffff + 1 = 0

0 in this case shall became 1 (not -1 as in my original comment)

if (log.count == 0)
	log.count = 1;

would fix that.

> > > +static u16 nvmet_pr_create_new_reservation(struct nvmet_pr *pr, u8 new_rtype,
> > > +                                          struct nvmet_pr_registrant *reg)
> > > +{
> > > +       u16 status;
> > > +
> > > +       status = nvmet_pr_validate_rtype(new_rtype);
> > You shall check the validity of the command in the very beginning of
> > command handling, not at the very end.
> 
> In some situations, we dont care the value of rtype, for example
> 
> using preempt to unregister other host.
> 
> So I only check it if needed.

I have two arguemnts for:
1. It is more convenient to check a validity of a command in the beginning -
there will be less changes to rollback. Now you do some unregistrations
and then may fail the command due to invalid rtype, but Reservation data
you does not change back.

2. Yes, the spec does not state that RTYPE shall be valid in Reservation Acquire Action (RACQA) field to 001b (Preempt) 
when reservation is not going to be changed. But it doesnot state that it
might be ignored too :). In some places I see that such a statement there is.
Also, there is such general statement for reserved values
	1.4.1.6 reserved
	Receipt of reserved coded values in defined fields in
	commands shall be reported as an error.

> > > +       if (!status) {
> > > +               reg->rtype = new_rtype;
> > > +               rcu_assign_pointer(pr->holder, reg);
> > > +       }
> > > +       return status;
> > > +}
> > > +

BR,
 Dmitry

