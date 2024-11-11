Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9101BD2E9D1
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JkJz7Vtx33IWQ/FbsMvhDuknhNQdiPskHnhrYja0V98=; b=J5H3qpXHJ/K7r+sIgaUk/BQES6
	qRjuT/dH2NiVx2vvm+BlGz+dJat6hu7jDOI1/xAYe9knsH2N0gFIPmH0TdkBljIxtnDs48vB7hzIM
	ANeS3Hl685URnEv2zN366k4OvdJBbpANalyAzxRoDDMTpjJA5sC+bkSvzdIXM2xpEMTenbUiq8oSy
	CosUjLrmE7KfKB/3nblIkRMnyOVA642a18KsHA0VQoiJv61kvSncXoxnHJsb4A8mynbibSZGDK178
	esBzZmTSoBrR1piIzXCz7NwdkXvbw0fWXGegzgiXFJMlYLmW0O+LMbaA4S6xsgkq6wi/wyqeQ4FXr
	4diOJsSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAREc-0000000HCjG-32Cr;
	Mon, 11 Nov 2024 10:01:26 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAR1P-0000000HAYu-20dV
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 09:47:49 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so753764766b.1
        for <linux-nvme@lists.infradead.org>; Mon, 11 Nov 2024 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731318466; x=1731923266; darn=lists.infradead.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkJz7Vtx33IWQ/FbsMvhDuknhNQdiPskHnhrYja0V98=;
        b=cFhQJLJhbrC4Udch/JIWc2WnZD6Y/o6AAXV2k4ZQqJ+P7Qo/n82Dsjkr5oXfZsT8ao
         PtPDmMTmm680oileK6MWB4rcHsWx6bzlLSq0HTDnB150wDdQuHewopKky2nQ+kky5kXJ
         yizpqBaI/R1FM7hzHx456akPgw+44FKql54dKJ89ooXfjtIVhL/6HKmc/M5H9bjnncVi
         /LLrhIKQEyKgyf/qiKCMktHL+VYFoI7iVhX8aIqt9vUScTbrI2ILYKeQPjmhAfyCoYCI
         fQYct66Zbs2GnxdtJKIfqkRIK1M5e8EEMiEJ/8B4YeKhd+nNPVUGh4y+Tukk5WpxDRPN
         5ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318466; x=1731923266;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkJz7Vtx33IWQ/FbsMvhDuknhNQdiPskHnhrYja0V98=;
        b=cPJDh2BWRTndHKH/IbC/rVhC2zTaawywVuEMtFE/nZ/xfWvYGCX/aAQT+QjG+lKN36
         MpVK5CGJ4G+5LuiZi4ZFjLnoKwZI3vfcMDtXzCAq7wyzEi+XXP3UN5d8OyePmZdJuHD6
         Jm1f0aO60jW4f+2UjGIKElP1NiMFacFSDac/6l0kqY+E1epKrNUr7wxC8X3MHo05wKJI
         VmqBiK7VezcOrBtFmb/5XojAFTL8YKIJwd4RL2YPWHFTuY1WilJ2l+mnUCrNhwO5YX34
         I5GpfP9G/KETcj916jr3W/A25V927JA5hEiSdrbO41afJftxFKjQ5zw+0k3BaXcAvbyl
         wObQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcF971+L5ee4SpgRDQm8QVDuIaSi/MvbOngX8Y5/E1KEom7uRteC8fJrI/UTzzEC2mmKHNdPwmWlVg@lists.infradead.org
X-Gm-Message-State: AOJu0YwX260zdEVV6Sg4RQTDN1PbVyHbnJgVO7ug732eM12N5zTR0nXE
	+sK7W59+wK+n2rRpRPneWH6a+7Mrc47ds8R0jm4eM0/0naNm83JYs5ZEEU1fdno=
X-Google-Smtp-Source: AGHT+IGsq8EjON+rP2OVtt9iLFlIq2jH+I5Ii92nliEf8BTTGnn5CC3vbCltiddot8IsnXDQqpKGYg==
X-Received: by 2002:a17:907:60c8:b0:a99:89e9:a43d with SMTP id a640c23a62f3a-a9eefff0af1mr1148526266b.39.1731318465847;
        Mon, 11 Nov 2024 01:47:45 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee3c906d6sm547557366b.49.2024.11.11.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:47:45 -0800 (PST)
Date: Mon, 11 Nov 2024 12:47:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Guixin Liu <kanie@linux.alibaba.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-6.13 7/7] drivers/nvme/target/pr.c:851
 nvmet_execute_pr_report() warn: potential pointer math issue ('ctrl_eds' is
 a 512 bit pointer)
Message-ID: <61ac311c-ca48-4ab7-9b77-32164288cbaa@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_014747_549926_7AFA5C0A 
X-CRM114-Status: GOOD (  10.79  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.13
head:   4c0ce9416cd06e9ef0e049f7a9226707c3786b1a
commit: 4c0ce9416cd06e9ef0e049f7a9226707c3786b1a [7/7] nvmet: support reservation feature
config: i386-randconfig-141-20241108 (https://download.01.org/0day-ci/archive/20241108/202411081457.mmSUxHMU-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202411081457.mmSUxHMU-lkp@intel.com/

smatch warnings:
drivers/nvme/target/pr.c:851 nvmet_execute_pr_report() warn: potential pointer math issue ('ctrl_eds' is a 512 bit pointer)

vim +851 drivers/nvme/target/pr.c

4c0ce9416cd06e Guixin Liu 2024-11-06  803  static void nvmet_execute_pr_report(struct nvmet_req *req)
4c0ce9416cd06e Guixin Liu 2024-11-06  804  {
4c0ce9416cd06e Guixin Liu 2024-11-06  805  	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
4c0ce9416cd06e Guixin Liu 2024-11-06  806  	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
4c0ce9416cd06e Guixin Liu 2024-11-06  807  	u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
4c0ce9416cd06e Guixin Liu 2024-11-06  808  	u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
4c0ce9416cd06e Guixin Liu 2024-11-06  809  	struct nvme_registered_ctrl_ext *ctrl_eds;
4c0ce9416cd06e Guixin Liu 2024-11-06  810  	struct nvme_reservation_status_ext *data;
4c0ce9416cd06e Guixin Liu 2024-11-06  811  	struct nvmet_pr *pr = &req->ns->pr;
4c0ce9416cd06e Guixin Liu 2024-11-06  812  	struct nvmet_pr_registrant *holder;
4c0ce9416cd06e Guixin Liu 2024-11-06  813  	struct nvmet_pr_registrant *reg;
4c0ce9416cd06e Guixin Liu 2024-11-06  814  	u16 num_ctrls = 0;
4c0ce9416cd06e Guixin Liu 2024-11-06  815  	u16 status;
4c0ce9416cd06e Guixin Liu 2024-11-06  816  	u8 rtype;
4c0ce9416cd06e Guixin Liu 2024-11-06  817  
4c0ce9416cd06e Guixin Liu 2024-11-06  818  	/* nvmet hostid(uuid_t) is 128 bit. */
4c0ce9416cd06e Guixin Liu 2024-11-06  819  	if (!eds) {
4c0ce9416cd06e Guixin Liu 2024-11-06  820  		req->error_loc = offsetof(struct nvme_common_command, cdw11);
4c0ce9416cd06e Guixin Liu 2024-11-06  821  		status = NVME_SC_HOST_ID_INCONSIST | NVME_STATUS_DNR;
4c0ce9416cd06e Guixin Liu 2024-11-06  822  		goto out;
4c0ce9416cd06e Guixin Liu 2024-11-06  823  	}
4c0ce9416cd06e Guixin Liu 2024-11-06  824  
4c0ce9416cd06e Guixin Liu 2024-11-06  825  	if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
4c0ce9416cd06e Guixin Liu 2024-11-06  826  		req->error_loc = offsetof(struct nvme_common_command, cdw10);
4c0ce9416cd06e Guixin Liu 2024-11-06  827  		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
4c0ce9416cd06e Guixin Liu 2024-11-06  828  		goto out;
4c0ce9416cd06e Guixin Liu 2024-11-06  829  	}
4c0ce9416cd06e Guixin Liu 2024-11-06  830  
4c0ce9416cd06e Guixin Liu 2024-11-06  831  	data = kmalloc(num_bytes, GFP_KERNEL);
4c0ce9416cd06e Guixin Liu 2024-11-06  832  	if (!data) {
4c0ce9416cd06e Guixin Liu 2024-11-06  833  		status = NVME_SC_INTERNAL;
4c0ce9416cd06e Guixin Liu 2024-11-06  834  		goto out;
4c0ce9416cd06e Guixin Liu 2024-11-06  835  	}
4c0ce9416cd06e Guixin Liu 2024-11-06  836  	memset(data, 0, num_bytes);
4c0ce9416cd06e Guixin Liu 2024-11-06  837  	data->gen = cpu_to_le32(atomic_read(&pr->generation));
4c0ce9416cd06e Guixin Liu 2024-11-06  838  	data->ptpls = 0;
4c0ce9416cd06e Guixin Liu 2024-11-06  839  	ctrl_eds = data->regctl_eds;
4c0ce9416cd06e Guixin Liu 2024-11-06  840  
4c0ce9416cd06e Guixin Liu 2024-11-06  841  	rcu_read_lock();
4c0ce9416cd06e Guixin Liu 2024-11-06  842  	holder = rcu_dereference(pr->holder);
4c0ce9416cd06e Guixin Liu 2024-11-06  843  	rtype = holder ? holder->rtype : 0;
4c0ce9416cd06e Guixin Liu 2024-11-06  844  	data->rtype = rtype;
4c0ce9416cd06e Guixin Liu 2024-11-06  845  
4c0ce9416cd06e Guixin Liu 2024-11-06  846  	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
4c0ce9416cd06e Guixin Liu 2024-11-06  847  		num_ctrls++;
4c0ce9416cd06e Guixin Liu 2024-11-06  848  		/*
4c0ce9416cd06e Guixin Liu 2024-11-06  849  		 * continue to get the number of all registrans.
4c0ce9416cd06e Guixin Liu 2024-11-06  850  		 */
4c0ce9416cd06e Guixin Liu 2024-11-06 @851  		if ((void *)(ctrl_eds + sizeof(*ctrl_eds)) >

The parenthesis are in the wrong place so it's a pointer math bug.

4c0ce9416cd06e Guixin Liu 2024-11-06  852  			(void *)(data + num_bytes))

This is wrong too.  I'm disappointed that Smatch doesn't catch this.  I thought
it would...

	if ((void *)ctrl_eds + sizeof(*ctrl_eds) > (void *)data + num_bytes) {

4c0ce9416cd06e Guixin Liu 2024-11-06  853  			continue;
4c0ce9416cd06e Guixin Liu 2024-11-06  854  		/*
4c0ce9416cd06e Guixin Liu 2024-11-06  855  		 * Dynamic controller, set cntlid to 0xffff.
4c0ce9416cd06e Guixin Liu 2024-11-06  856  		 */
4c0ce9416cd06e Guixin Liu 2024-11-06  857  		ctrl_eds->cntlid = NVME_CNTLID_DYNAMIC;
4c0ce9416cd06e Guixin Liu 2024-11-06  858  		if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
4c0ce9416cd06e Guixin Liu 2024-11-06  859  		    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
4c0ce9416cd06e Guixin Liu 2024-11-06  860  			ctrl_eds->rcsts = 1;
4c0ce9416cd06e Guixin Liu 2024-11-06  861  		if (reg == holder)
4c0ce9416cd06e Guixin Liu 2024-11-06  862  			ctrl_eds->rcsts = 1;
4c0ce9416cd06e Guixin Liu 2024-11-06  863  		uuid_copy((uuid_t *)&ctrl_eds->hostid, &reg->hostid);
4c0ce9416cd06e Guixin Liu 2024-11-06  864  		ctrl_eds->rkey = cpu_to_le64(reg->rkey);
4c0ce9416cd06e Guixin Liu 2024-11-06  865  		ctrl_eds++;
4c0ce9416cd06e Guixin Liu 2024-11-06  866  	}
4c0ce9416cd06e Guixin Liu 2024-11-06  867  	rcu_read_unlock();
4c0ce9416cd06e Guixin Liu 2024-11-06  868  
4c0ce9416cd06e Guixin Liu 2024-11-06  869  	put_unaligned_le16(num_ctrls, data->regctl);
4c0ce9416cd06e Guixin Liu 2024-11-06  870  	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
4c0ce9416cd06e Guixin Liu 2024-11-06  871  	kfree(data);
4c0ce9416cd06e Guixin Liu 2024-11-06  872  out:
4c0ce9416cd06e Guixin Liu 2024-11-06  873  	nvmet_req_complete(req, status);
4c0ce9416cd06e Guixin Liu 2024-11-06  874  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


