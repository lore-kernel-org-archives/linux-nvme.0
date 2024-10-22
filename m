Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F046DD2C54B
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8tiaXeq0kLmK2OY51mNJ1AtYi+qI5lKsYODVXDJcbc=; b=4PmGSiEKl7s1rFdDF5ny/Ugcef
	W9CFRuwkxph/kE+ZZ82nz68AvZg4+jOm9OYSxtMLcavi/pp+k1QotTL/HADwJxA9JbhWN7ifsAUCv
	EbElNgWzJtw2WU0fLJg2b0tIDgwXQxKnlUjSeuI6wG15LCgLYjN41zq5Y6aRQbngdZTGnJh3h/v9M
	bPLr3N1cCwkqFj/VAX9asVBJ91/Mt8w+lKZ8ihQLKbvO2vztXV4Ew4b2Be5eViP0/zrOqKx40cSJ7
	dhoCfhIU2ukx4jUtJYXiK/mhDL3vsd9T8v/WR0yAvd6VD7s4lqFoaz8aNuwzJI8hrlsV7Ma0+2QMj
	yR5DofhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Emo-0000000AvWT-1uHE;
	Tue, 22 Oct 2024 13:18:58 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Eml-0000000AvVK-3C2j
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 13:18:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37ed7eb07a4so2321923f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 06:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603134; x=1730207934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8tiaXeq0kLmK2OY51mNJ1AtYi+qI5lKsYODVXDJcbc=;
        b=APXG858JclGQNEv5ZQ6S5hRNETv/1q7DS6W5zgBg9a00/1IVn3mJxMdweOVw0NUqnw
         0j/I7ZrMBbce27o+cv+C4D6sjk8fcx9WKLvmMp9pK5pAmlIR8Kmlgr2SkOHKsVHxcjkJ
         zFOw3GddLdu9qtZbwkYE9DJ7kzTtAlKgAVGEjE0QirfNWrFPWmlbQfrfdvptQ0vA8Ktf
         qHKTyLjd3IZVi3n76X3ZFRHEpqOzVAMlRxsOGgIIfzdNBOiuqZ1oPlFqPfAQ9yF5CitF
         EssarlQxrnjDfoGCdBcZ+DQC/Wj5l3D1/iQ/SOukMigmsY3EFjmwB1JRR3k6RgO/6KvZ
         PsvA==
X-Gm-Message-State: AOJu0YyVmZGvYHmH3KavI9HlQ/7hc8gYwX64Kaeh/Tdad6a4Luo3dmrB
	RcLhfrgtWv2V9ApLm3eXDjdFYCXDOmLvMeOEBeuCcSslz4r7FdGn
X-Google-Smtp-Source: AGHT+IHU8vhrVO05r+nNadgrZwOMEF1cg3Z2+baPdedrqCXeJ9XDkUtdqBYtWZbkyGCRNHhiAWrplg==
X-Received: by 2002:adf:f288:0:b0:37c:d1e3:ebd2 with SMTP id ffacd0b85a97d-37ef2177ddemr1792461f8f.29.1729603133621;
        Tue, 22 Oct 2024 06:18:53 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4c7sm87161355e9.48.2024.10.22.06.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:18:53 -0700 (PDT)
Message-ID: <8dccff09-2eab-40a1-abd3-b3759ecdc1ed@grimberg.me>
Date: Tue, 22 Oct 2024 16:18:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com
Cc: linux-nvme@lists.infradead.org
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241021110331.125962-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_061856_148826_8F14DA71 
X-CRM114-Status: GOOD (  11.36  )
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

> +static void nvmet_execute_pr_acquire(struct nvmet_req *req)
> +{
> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
> +	bool ignore_key = nvmet_pr_parse_ignore_key(cdw10);
> +	/* Reservation type, bit 15:08 */
> +	u8 rtype = (u8)((cdw10 >> 8) & 0xff);
> +	/* Reservation acquire action, bit 02:00 */
> +	u8 acquire_act = cdw10 & 0x07;
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_pr_acquire_data *d = NULL;
> +	struct nvmet_pr *pr = &req->ns->pr;
> +	struct nvmet_pr_registrant *reg;
> +	u16 status = NVME_SC_SUCCESS;
> +
> +	if (ignore_key ||
> +	    rtype < NVME_PR_WRITE_EXCLUSIVE ||
> +	    rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> +		goto out;
> +	}
> +
> +	d = kmalloc(sizeof(*d), GFP_KERNEL);
> +	if (!d) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
> +	if (status)
> +		goto free_data;
> +
> +	status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
> +	mutex_lock(&pr->pr_lock);
> +	list_for_each_entry_rcu(reg, &pr->registrant_list, entry,
> +				lockdep_is_held(&pr->pr_lock)) {
> +		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
> +		    reg->rkey == le64_to_cpu(d->crkey)) {
> +			status = __nvmet_execute_pr_acquire(req, reg,
> +					acquire_act, rtype, d);
> +			break;
> +		}
> +	}
> +
> +	if (!status && acquire_act == NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT) {
> +		kfree(d);
> +		INIT_WORK(&req->r.abort_work, nvmet_pr_do_abort);
> +		queue_work(nvmet_wq, &req->r.abort_work);
> +		return;
> +	}

Is there a reason why you queue this here and not inside 
__nvmet_execute_pr_acquire
like before?

> +
> +	mutex_unlock(&pr->pr_lock);

Hmm... you keep this mutex taken and release it from the work element 
async... Not a
great practice...

Any easy way you see to avoid this?

