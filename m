Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8C8D2E9D1
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSWHqQ5c85sVlS2t12pW+d9AGdHjzHvwSPST7Tglwy8=; b=EgS6VTpLmeafhy3w+3t+ZMNKqU
	J4HLqgKrTnLMQ3B+dMSdGcFFtYucCJ6K0//a5qTtxVvKZZNHjesjBEzv3PPbQpOUO+ZgV33XEX9eg
	9vG0v+F15n6R/sxOJGw7CAdjMfUIZqZvJH8ulUxGgQHJBUVe9I8X1RhdGG7ehVKkVHC54MzBOlZM8
	mSU/KsgUKXZtt4w8DQSdeKTppSHrn9UqZyi0MnSZm8w3Tq/NHmYMxA7locS7UBfNVnFo2UiLyOQXg
	oYIHI8GUqyAk1uq/a4l7b69ncYCCyStgEQN1VBLr4KP3aEhJRtuEXBwTfIP5A8bhk03p2it6L92BC
	TBLiCWnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tARNT-0000000HEWW-1UnA;
	Mon, 11 Nov 2024 10:10:35 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tARFE-0000000HCsw-0jVF
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 10:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731319319; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tSWHqQ5c85sVlS2t12pW+d9AGdHjzHvwSPST7Tglwy8=;
	b=gIt7opAPm814gmOw7h6Wk6rOc0GFI7AqVCp6VAY+/5AymM9LE3Y9Mxt0+Q+mJAH/RzwdE7bWfKLp5eMH6X95gKSApWqWqTqb7D/5X3Juy9kKNc7T+H3mpJJEb/VRIxyzcjqr6Dv0qn4Fwlm7T1tk0NYiLndSBvxRT1j8jRDbDXo=
Received: from 30.178.82.47(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJ9OMNi_1731319314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 Nov 2024 18:01:55 +0800
Message-ID: <e59911d3-488c-40d5-a549-e698a3886bae@linux.alibaba.com>
Date: Mon, 11 Nov 2024 18:01:52 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [linux-nvme:nvme-6.13 7/7] drivers/nvme/target/pr.c:851
 nvmet_execute_pr_report() warn: potential pointer math issue ('ctrl_eds' is a
 512 bit pointer)
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <61ac311c-ca48-4ab7-9b77-32164288cbaa@stanley.mountain>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <61ac311c-ca48-4ab7-9b77-32164288cbaa@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_020204_632340_34A5534B 
X-CRM114-Status: GOOD (  13.29  )
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


在 2024/11/11 17:47, Dan Carpenter 写道:
> tree:   git://git.infradead.org/nvme.git nvme-6.13
> head:   4c0ce9416cd06e9ef0e049f7a9226707c3786b1a
> commit: 4c0ce9416cd06e9ef0e049f7a9226707c3786b1a [7/7] nvmet: support reservation feature
> config: i386-randconfig-141-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081457.mmSUxHMU-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411081457.mmSUxHMU-lkp@intel.com/
>
> smatch warnings:
> drivers/nvme/target/pr.c:851 nvmet_execute_pr_report() warn: potential pointer math issue ('ctrl_eds' is a 512 bit pointer)
>
> vim +851 drivers/nvme/target/pr.c
>
> 4c0ce9416cd06e Guixin Liu 2024-11-06  803  static void nvmet_execute_pr_report(struct nvmet_req *req)
> 4c0ce9416cd06e Guixin Liu 2024-11-06  804  {
> 4c0ce9416cd06e Guixin Liu 2024-11-06  805  	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  806  	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  807  	u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
> 4c0ce9416cd06e Guixin Liu 2024-11-06  808  	u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
> 4c0ce9416cd06e Guixin Liu 2024-11-06  809  	struct nvme_registered_ctrl_ext *ctrl_eds;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  810  	struct nvme_reservation_status_ext *data;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  811  	struct nvmet_pr *pr = &req->ns->pr;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  812  	struct nvmet_pr_registrant *holder;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  813  	struct nvmet_pr_registrant *reg;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  814  	u16 num_ctrls = 0;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  815  	u16 status;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  816  	u8 rtype;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  817
> 4c0ce9416cd06e Guixin Liu 2024-11-06  818  	/* nvmet hostid(uuid_t) is 128 bit. */
> 4c0ce9416cd06e Guixin Liu 2024-11-06  819  	if (!eds) {
> 4c0ce9416cd06e Guixin Liu 2024-11-06  820  		req->error_loc = offsetof(struct nvme_common_command, cdw11);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  821  		status = NVME_SC_HOST_ID_INCONSIST | NVME_STATUS_DNR;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  822  		goto out;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  823  	}
> 4c0ce9416cd06e Guixin Liu 2024-11-06  824
> 4c0ce9416cd06e Guixin Liu 2024-11-06  825  	if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
> 4c0ce9416cd06e Guixin Liu 2024-11-06  826  		req->error_loc = offsetof(struct nvme_common_command, cdw10);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  827  		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  828  		goto out;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  829  	}
> 4c0ce9416cd06e Guixin Liu 2024-11-06  830
> 4c0ce9416cd06e Guixin Liu 2024-11-06  831  	data = kmalloc(num_bytes, GFP_KERNEL);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  832  	if (!data) {
> 4c0ce9416cd06e Guixin Liu 2024-11-06  833  		status = NVME_SC_INTERNAL;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  834  		goto out;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  835  	}
> 4c0ce9416cd06e Guixin Liu 2024-11-06  836  	memset(data, 0, num_bytes);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  837  	data->gen = cpu_to_le32(atomic_read(&pr->generation));
> 4c0ce9416cd06e Guixin Liu 2024-11-06  838  	data->ptpls = 0;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  839  	ctrl_eds = data->regctl_eds;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  840
> 4c0ce9416cd06e Guixin Liu 2024-11-06  841  	rcu_read_lock();
> 4c0ce9416cd06e Guixin Liu 2024-11-06  842  	holder = rcu_dereference(pr->holder);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  843  	rtype = holder ? holder->rtype : 0;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  844  	data->rtype = rtype;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  845
> 4c0ce9416cd06e Guixin Liu 2024-11-06  846  	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
> 4c0ce9416cd06e Guixin Liu 2024-11-06  847  		num_ctrls++;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  848  		/*
> 4c0ce9416cd06e Guixin Liu 2024-11-06  849  		 * continue to get the number of all registrans.
> 4c0ce9416cd06e Guixin Liu 2024-11-06  850  		 */
> 4c0ce9416cd06e Guixin Liu 2024-11-06 @851  		if ((void *)(ctrl_eds + sizeof(*ctrl_eds)) >
>
> The parenthesis are in the wrong place so it's a pointer math bug.
>
> 4c0ce9416cd06e Guixin Liu 2024-11-06  852  			(void *)(data + num_bytes))
>
> This is wrong too.  I'm disappointed that Smatch doesn't catch this.  I thought
> it would...
>
> 	if ((void *)ctrl_eds + sizeof(*ctrl_eds) > (void *)data + num_bytes) {

Thanks, this is a bug truly, I will send a patch to fix this quickly.

Best Regards,

Guixin Liu

>
> 4c0ce9416cd06e Guixin Liu 2024-11-06  853  			continue;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  854  		/*
> 4c0ce9416cd06e Guixin Liu 2024-11-06  855  		 * Dynamic controller, set cntlid to 0xffff.
> 4c0ce9416cd06e Guixin Liu 2024-11-06  856  		 */
> 4c0ce9416cd06e Guixin Liu 2024-11-06  857  		ctrl_eds->cntlid = NVME_CNTLID_DYNAMIC;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  858  		if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
> 4c0ce9416cd06e Guixin Liu 2024-11-06  859  		    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
> 4c0ce9416cd06e Guixin Liu 2024-11-06  860  			ctrl_eds->rcsts = 1;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  861  		if (reg == holder)
> 4c0ce9416cd06e Guixin Liu 2024-11-06  862  			ctrl_eds->rcsts = 1;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  863  		uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  864  		ctrl_eds->rkey = cpu_to_le64(reg->rkey);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  865  		ctrl_eds++;
> 4c0ce9416cd06e Guixin Liu 2024-11-06  866  	}
> 4c0ce9416cd06e Guixin Liu 2024-11-06  867  	rcu_read_unlock();
> 4c0ce9416cd06e Guixin Liu 2024-11-06  868
> 4c0ce9416cd06e Guixin Liu 2024-11-06  869  	put_unaligned_le16(num_ctrls, data->regctl);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  870  	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  871  	kfree(data);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  872  out:
> 4c0ce9416cd06e Guixin Liu 2024-11-06  873  	nvmet_req_complete(req, status);
> 4c0ce9416cd06e Guixin Liu 2024-11-06  874  }
>

