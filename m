Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEADDCE8345
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Sep 2024 13:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uRzcEKhXIkTHOLuRtAPkotya4v8N4kyfMO3iTutU1mE=; b=qgIc8/Qhg7DFAzCT30A1A6+Mk/
	5mbfyPVLm0u1kN8xjrhgKoBZx1m411n4RAeMw46Xz9UuFaFHz8axx3Z8kzpNZfIt23N1CQdCfhlQk
	1ZaxOD66HLMb0ottMldIebqdMxrTv1caq96WXz8qqUjVcd3TtIYw3DvG/ZC+i2E/p78vP1vip/11e
	vwG4x3wYod0gNzdZCbw09snJAKuaQWH4LRlf73LP5C5xGiP/brABCNI0LarVUymN/9JbbVS5gQc6H
	BqUNn6H2SxdHSsFjkGr6wy3ODUbYSgbBtWi4fiQZAyTVvtARwi4dDIHrI5u/TCr9xBs0mDDNXXLHN
	cFmbaToQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svGKM-0000000HGWi-48J9;
	Mon, 30 Sep 2024 13:20:38 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svFvC-0000000H9aB-3LWF
	for linux-nvme@lists.infradead.org;
	Mon, 30 Sep 2024 12:54:41 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 417EFC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727700867; bh=uRzcEKhXIkTHOLuRtAPkotya4v8N4kyfMO3iTutU1mE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=KG5tL5SJONM1JdeCSnppM56zWueGDYws6m/zyPqaDYs6lHTFAv7FvUBktGKfVxov5
	 UeXUAA70a1jWpvQsaZ6hCl3paWvI/kqzVTJW1bFHkyfsHgbKTUXj5MJcHIF8ItuKgC
	 4mUcKNPNJX+uP2qSwV20F8i5goTJ98Q6eGGO3HiszfLPA7EmzbOmjVdwHrxpRXZHy3
	 6T2z4Pxzl3uaySvwOCskydbxooFpnE5k8NF+npbSoAyrHkJNWdVsjg5AZ95lCJKYOr
	 iIY7g+23PEaeEKFbJJoNLAP3lx+3nngufDHf5IrriS1SZ54Z3+R1sxjFINPHbH5L7i
	 oStQxylbQCbYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727700867; bh=uRzcEKhXIkTHOLuRtAPkotya4v8N4kyfMO3iTutU1mE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=UjQHRsnmU3h/+w0tCjIvJGut4zeMog9l6TrQERiqoIgOQK8e8T7B5gfh1fe2vw3R5
	 rGlvjweuGqkjNRtdcG3RWCiVphYxwq4hhNzOJAC6+S8SWA9UUTNM8l8UQdp8Ib9b1J
	 EzWWWclZbo7oohGe+Uc8y2x0d/WcuV8FBrCVF6jZTHcLdhJEmFwQLVn3STsSC5Cp3I
	 sa08fhZF3sRQ4u3a0BRhBbG4VJ+Yq+4OoqezfnUsPhAG9XuHGKZm066jbMZX3cltp3
	 l6samlM82zGI5FgAQu3iwwmif9D/c5AN/htBhPOn0OB6vr/Ol20PdPwq27JRF152wL
	 MRoa5twE7NZZA==
Date: Mon, 30 Sep 2024 15:53:29 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v11 1/1] nvmet: support reservation feature
Message-ID: <20240930125329.GI22571@yadro.com>
References: <20240929031410.31281-1-kanie@linux.alibaba.com>
 <20240929031410.31281-2-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240929031410.31281-2-kanie@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_055439_695766_8893152F 
X-CRM114-Status: GOOD (  24.24  )
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

On Sun, Sep 29, 2024 at 11:14:10AM +0800, Guixin Liu wrote:
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
>  drivers/nvme/target/Makefile      |    2 +-
>  drivers/nvme/target/admin-cmd.c   |   24 +-
>  drivers/nvme/target/configfs.c    |   27 +
>  drivers/nvme/target/core.c        |   56 +-
>  drivers/nvme/target/fabrics-cmd.c |    4 +-
>  drivers/nvme/target/nvmet.h       |   50 +-
>  drivers/nvme/target/pr.c          | 1177 +++++++++++++++++++++++++++++
>  include/linux/nvme.h              |   54 ++
>  8 files changed, 1382 insertions(+), 12 deletions(-)
>  create mode 100644 drivers/nvme/target/pr.c
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index bd87dfd173a4..9a56269cefd0 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -748,6 +748,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
> 
>  CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
> 
> +static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
> +{
> +       return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);

sysfs_emit is to be used in show()

> +}
> +


> +
> +static void nvmet_execute_pr_report(struct nvmet_req *req)
> +{
> +       u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> +       u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +       u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
> +       u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
> +       struct nvme_registered_ctrl_ext *ctrl_eds;
> +       struct nvme_reservation_status_ext *data;
> +       struct nvmet_pr *pr = &req->ns->pr;
> +       struct nvmet_pr_registrant *holder;
> +       struct nvmet_pr_registrant *reg;
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
> +       rcu_read_lock();
> +       holder = rcu_dereference(pr->holder);
> +       rtype = holder ? holder->rtype : 0;
> +       data->rtype = rtype;
> +
> +       list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
> +               if ((void *)ctrl_eds >= (void *)(data + num_bytes))
> +                       break;
> +               /*
> +                * Dynamic controller, set cntlid to 0xffff.
> +                */
> +               ctrl_eds->cntlid = 0xffff;
> +               if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> +                   rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
> +                       ctrl_eds->rcsts = 1;
> +               if (holder && uuid_equal(&reg->hostid, &holder->hostid))

is just (reg == holder) not enough here?

> +                       ctrl_eds->rcsts = 1;
> +               uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
> +               ctrl_eds->rkey = cpu_to_le64(reg->rkey);
> +               ctrl_eds++;
> +               num_ctrls++;
> +       }
> +       rcu_read_unlock();
> +
> +       put_unaligned_le16(num_ctrls, data->regctl);

Here you should report the number of all registered registrants in ns,
not the only reported. It is used by the host to understand that it got
not a full response.
NUMD field (cdw11) is about transfering the response. But the structure itsef in
the reposnse has to be complete.

> +       status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
> +       kfree(data);
> +out:
> +       nvmet_req_complete(req, status);
> +}
> +

BR,
 Dmitry

