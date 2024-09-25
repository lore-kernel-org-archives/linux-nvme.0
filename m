Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6090CF9C71
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8VVGPUxI0RylZBszL62GNK5yc2P8e/5OWZQB69Sht9c=; b=HZ6i3v1OxoaU4BDCiD5AYomx5Q
	vR4dnEuzVr+pPOAJDCH0vxAvSUOVik+n7FOxFq82dTZWFTKFJWdOIfH3oycpsz+QPx0LQX//c8U72
	gyVls/fZB0w06TqK/UY6vFiZ9F7aXPWj5Z6jMepzNBGHOU6mq4mGNtkQsTA9K0s2pmiLisiIETdOl
	EFDP76glN91WxkJn1cS4tk614LnsgdzgSo9XbZg26VdfwlG8B/Z8CuKEPJR9+F1WUBVWo/u/21FK8
	S97Q9JF8bRWlRhpkRB/q7+kgdfz88dUA8jlp+OTXx/rjBjQj6hlJyxCZ1uEzx0Cn8A9huxzzZg2OF
	dAKGsvpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stSxT-00000005cGp-2Q42;
	Wed, 25 Sep 2024 14:25:35 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stSuu-00000005bZ4-38k0
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 14:22:59 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 77365C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727274169; bh=8VVGPUxI0RylZBszL62GNK5yc2P8e/5OWZQB69Sht9c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=eE6IGbyUGzArdleGFVc5Qi2jUObWa0SD9DFlLnnmvxi6tPhH6V+2Zdm9tCyRrZk6e
	 bnCq63wlF80vmSmFNFHI/f7ljTUkDXfzRkofaZQZm7k+eahuUyuoil9EzkFz5k+J6a
	 R7YgsMA4w0mWoH2z/jNVPzLKP4uZqIcAi8H0BlRpJvqjGiQ0dx5nhsRJ/q/fyBOoOD
	 b7AiJ2QnQ/d3u/DdEIlP8CKtek2Ha9CGcttCQoRRCV7hb9KgCd4BX4AUaSlD/MBEoE
	 +C/jznUSHHnRGFOcwlNXo8K0MitwUoD3+qP5XddNRy/UyQol21Yvf0rvXUonuBcNyM
	 8RwqgSihW+cfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727274169; bh=8VVGPUxI0RylZBszL62GNK5yc2P8e/5OWZQB69Sht9c=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=XeQ03rUpcnqRo8gPq764FudpsfnaF/Q97BAW8oFej+e9lJwmdEHCyHEp5/so2WFCW
	 82x07XbC6oaDS37F2ry3xLjjRD1kL88Q9O2/Er7M/Bw304UHOvfvMFyccGdX72Av2V
	 el7UJ6riwqP5MR3hXHD2Ud1RIQvI8y4Ppix4Tafwk9Nj3KcUyvTs8lem5LxCqpsGAy
	 U4uuFBPU9LeEHgc+VrUZTk3xrZHmgSrGpK8CsSNwsd8izUQUwQhojWO5cU1pZ8WtJn
	 5bGBvXj1LCm9eV1xW5eR83i5ZQ8prP2BesMa/mIUE0RTeX2owYRoR3RS8Zmpr5eWki
	 P5tM4+EgIEFoQ==
Date: Wed, 25 Sep 2024 17:21:57 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v10 1/1] nvmet: support reservation feature
Message-ID: <20240925142157.GH22571@yadro.com>
References: <20240925021110.26121-1-kanie@linux.alibaba.com>
 <20240925021110.26121-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240925021110.26121-2-kanie@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_072257_649184_8F55525F 
X-CRM114-Status: GOOD (  22.13  )
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

On Wed, Sep 25, 2024 at 10:11:10AM +0800, Guixin Liu wrote:
> 
> This patch implements the reservation feature, includes:
> 1. reservation register(register, unregister and replace).
> 2. reservation acquire(acquire, preempt, preempt and abort).
> 3. reservation release(release and clear).
> 4. reservation report.
> 5. set feature and get feature of reservation notify mask.
> 6. get log page of reservation event.
> 
> And also make reservation configurable, one can set ns to support
> reservation before enable ns. The default of resv_enable is false.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/nvme/target/Makefile    |    2 +-
>  drivers/nvme/target/admin-cmd.c |   24 +-
>  drivers/nvme/target/configfs.c  |   27 +
>  drivers/nvme/target/core.c      |   58 +-
>  drivers/nvme/target/nvmet.h     |   48 ++
>  drivers/nvme/target/pr.c        | 1197 +++++++++++++++++++++++++++++++
>  include/linux/nvme.h            |   54 ++
>  7 files changed, 1401 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/nvme/target/pr.c
> 
> +static void nvmet_execute_pr_report(struct nvmet_req *req)
> +{
> +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
> +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
> +       struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
> +       struct nvme_registered_ctrl_ext *ctrl_eds;
> +       struct nvme_reservation_status_ext *data;
> +       struct nvmet_pr *pr = &req->ns->pr;
> +       struct nvmet_pr_registrant *holder;
> +       struct nvmet_pr_registrant *reg;
> +       struct nvmet_ctrl *ctrl;
> +       u16 num_ctrls = 0;
> +       u16 status;
> +       u8 rtype;
> +
> +       /* nvmet hostid(uuid_t) is 128 bit. */
> +       if (!eds) {
> +               req->error_loc = offsetof(struct nvme_common_command, cdw11);
> +               status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
> +               goto out;
> +       }
> +
> +       if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
> +               req->error_loc = offsetof(struct nvme_common_command, cdw10);
> +               status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +               goto out;
> +       }
> +
> +       mutex_lock(&subsys->lock);
> +       num_ctrls = list_count_nodes(&subsys->ctrls);
> +       mutex_unlock(&subsys->lock);
> +
> +       num_bytes = min(num_bytes,
> +                       sizeof(struct nvme_reservation_status_ext) +
> +                       sizeof(struct nvme_registered_ctrl_ext) * num_ctrls);
> +
> +       data = kmalloc(num_bytes, GFP_KERNEL);
> +       if (!data) {
> +               status = NVME_SC_INTERNAL;
> +               goto out;
> +       }
> +       memset(data, 0, num_bytes);
> +       data->gen = cpu_to_le32(atomic_read(&pr->generation));
> +       data->ptpls = 0;
> +       ctrl_eds = data->regctl_eds;
> +
> +       mutex_lock(&subsys->lock);
> +       rcu_read_lock();
> +       holder = rcu_dereference(pr->holder);
> +       rtype = holder ? holder->rtype : 0;
> +       data->rtype = rtype;
> +       num_ctrls = 0;
> +       list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
> +                       break;
> +               reg = nvmet_pr_find_registrant(pr, &ctrl->hostid);
> +               if (!reg)
> +                       continue;
> +               ctrl_eds->cntlid = cpu_to_le16(ctrl->cntlid);
> +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
> +                       ctrl_eds->rcsts = 1;
> +               if (holder && uuid_equal(&ctrl->hostid, &holder->hostid))
> +                       ctrl_eds->rcsts = 1;
> +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &ctrl->hostid);
> +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
> +               ctrl_eds++;
> +               num_ctrls++;
> +       }
> +       rcu_read_unlock();
> +       mutex_unlock(&subsys->lock);

That code fully confroms NVMe Base Spec 2.0c but it is completely wrong
from the logic point of view.
ControllerId is a dynamic thing - it's allocated for the each
fabric session(Connect command). It has no meaning for an initiator.
The association between Registrant (uniq key HostId) and Controller
(uniq key CtrlId) is not 1..1, it is 1..N.

NVMe Base Spec 2.1 addressed this issue and it states, that here target
shall report just list if the registrants:

	Number of Registrants (REGSTRNT): This field indicates the number of registrants of the
	namespace. This indicates the number of Registrant data structures or Registrant Extended data
	structures contained in this data structure.
	Note: This field was formerly named Number of Registered Controllers (REGCTL).


Though, v2.1 still does not clearly states what exact CNTLID is to be
reported from 1..N association.

I suggest you to update your patch to conform the Spec v2.1 - remove cntlid
from nvmet_pr_registrant and report here just ns->pr.registrant_list.
And not to track the connectivity of registrants - report always CNTLID=0xFFFF
as a some compromise value that is allowed by the Spec.


> +
> +       put_unaligned_le16(num_ctrls, data->regctl);
> +       num_bytes = sizeof(struct nvme_reservation_status_ext) +
> +                       sizeof(struct nvme_registered_ctrl_ext) * num_ctrls;

num_bytes was a size of requested buffer (cdw10), you even allocate that
size. You shall not extend it here. Instead you should allocate maximum
possible size and copy here only cdw10 dwords from your buffer to sgl.

> +       status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
> +       kfree(data);
> +out:
> +       nvmet_req_complete(req, status);
> +}
> +

BR,
 Dmitry

