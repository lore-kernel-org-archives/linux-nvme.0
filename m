Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C1AE7AD66
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j5EC01ePkdkVNX3nDSKOcSuhVJygES9lIvbPYyKJrtk=; b=G1A/Y23UKpHcNmxz8PKcS8JPtg
	lFnaIXL9f6CrqXewKzLI8zJQAQ8EV3xQseu5ClYqqguUauD6q9d7WNM3vrU2oPoghebheYQfJARLU
	9es0nQWO1iKSNCPxq+WdZXMCFHRPe/w4kf3Rpi1SJN9x+gGCAngJUcNcF5VKyzlispv9kHn1HHKhT
	qZtZCAUls2hlYEip6wcElx00rrmlE6iYMJd5f2H57Y00IT7nHkCe7eDfr5U+f/RPCXQUchMLB1iiF
	OBbpAwGN2rxkPzHVLN4Qe7LvY09qdSXKNjgIartgGTi5qOsoKM1Bp30tyFvy10ZSjQMsShGM8ZoJ1
	rfZ1jNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYpDf-00000000Zht-2GU2;
	Thu, 25 Dec 2025 17:33:47 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYpDd-00000000ZhU-20Q3
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 17:33:46 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-29efd139227so89711215ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 09:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766684024; x=1767288824; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j5EC01ePkdkVNX3nDSKOcSuhVJygES9lIvbPYyKJrtk=;
        b=ee0+BaVoT59V55yTgz87kjkFy3nnRqBPfBjTvd9uNd5SmRn5VAEi/DD9ctWhoeUXmr
         vNpUF9xE24rFtoiRkrRh/XyWpZYc342XNNMk54aRfOqAusw2g27Nw22dTGLOk0ybXZfS
         AwX1Ad9kIgpN1JDyjidVZwfvjfCW1WJPOfHongo5Ea2CBh6FZse0vCQxBkUDYb/4Ogxl
         Z0rtZ1hSWOB9opdi3nqiausjqV3TfzsPbHsRtwOC9ZO7ybOLcwZFDUmOfDggFPV/AmQJ
         DMvilCPF5iTUP6a5r0p/0VjBW/QkTPLX2jSWwWOb9HiuwjKD+APay+o3a6nZ2A75l4Pb
         Xumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766684024; x=1767288824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5EC01ePkdkVNX3nDSKOcSuhVJygES9lIvbPYyKJrtk=;
        b=iTSIxzx3POCcJ/J/gHssnxIHlgbp0JmlAyjAvzbLWv5inU29V1y/UG4uQgW17SfAZl
         oVZ3+kfsdNQb21/Gfd7aEgtL+PlnIN62Nrflyd1R/xXFrquYG02hlva1OseV8YwVZ7KI
         +MJUqCAjoUAXMxkdfAsi1CkwSMcjWQ/nRs9JSCqkC0XLgvc1tCF7N7046lyu0tECnc2L
         XNtXXfPAgZwUaWygyoeUgOiyHuL5JuaAERqZTk2KtbG8r5M6m6vCypz/aGLBtLBicpV+
         jI3ieVLaBe+nQBLEiIc/wXbTPwB+EeMQxH06ZMp2iOXCN+E+gI2fsYJrwVvb/byC61gI
         x6Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW4fXKSYboyQZ5NNcWZM0Rey5CK57RPEimlKbX310aoqLtrVdZdYlR70UZD0/fi2L2AEd2sbxfaNGOp@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9vcw1fdKKW3fPNmXHgSMF8EzTYZPBH093w/6xsf/OLOTqMero
	p7P1FEQMePaAmM8qo3U144CseD0mzVi5nWxar01HL1gpwiOAm/iKZzlZKzC9mZbTlzU=
X-Gm-Gg: AY/fxX5pcDEmv+A24bz6uMhJMsN25kYlyxw2o6Qn5MnpGh1GiFKTa8GW4tgAV4qXgND
	6wy2J3VdXrH76jAN6LxK0qjSG606sSKaH+M1EVwR4iQjBwbtiNwoo9r0qXNSapFzJMZQaBuR1SV
	L7RtGLoRZVVZ6lxV+zyg6do0+qt3JuCgsQHhxYpbrQdo2kRSxo3AfY5riP1OrhGFplrARBVQdmu
	FYmcTMXQlyYY1Bi0vsC1wKn5VqDm2zyoKfDAooD3bxbxjUXBpdCjCDWvBx5K4IUp17WERmMkVbd
	XrAi0hmDGqBlQgG4UqzHC1cmwdlBb/HgIUzicMwdS8DkHb4y+/I1J96ii8PIs+OId26QQZIzKT6
	PGadc/phpcv7wJcnpk4vD0cNo65mZLqydjJAd8Wsy6/XBRjBjB0o2N7rO00K6ZGNWHYlYENHD0B
	Rp47G6ZupYo9JjRh0=
X-Google-Smtp-Source: AGHT+IHvDPVi7MfkxykM6GkuJHP8TD2suiOScF3/pn4zZdLHiPPU1gilWhZbMT9py8BRxehOWyMs7g==
X-Received: by 2002:a05:7022:eac1:b0:11d:c91e:3b58 with SMTP id a92af1059eb24-121722e9e26mr17987214c88.39.1766684024292;
        Thu, 25 Dec 2025 09:33:44 -0800 (PST)
Received: from medusa.lab.kspace.sh ([2601:640:8202:6fb0::1305])
        by smtp.googlemail.com with UTF8SMTPSA id a92af1059eb24-1217243bbe3sm81422741c88.0.2025.12.25.09.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:33:43 -0800 (PST)
Date: Thu, 25 Dec 2025 09:33:42 -0800
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
Message-ID: <20251225173342.GB8129-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-4-mkhalfella@purestorage.com>
 <3f2c8a9e-2e1c-4cb8-b296-8f61ab16b03a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2c8a9e-2e1c-4cb8-b296-8f61ab16b03a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_093345_521779_C095D0C8 
X-CRM114-Status: GOOD (  26.06  )
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

On Thu 2025-12-25 15:14:31 +0200, Sagi Grimberg wrote:
> 
> 
> On 26/11/2025 4:11, Mohamed Khalfella wrote:
> > Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> > Reset) command is an nvme command the is issued to source controller by
> > initiator to reset impacted controller. Implement CCR command for linux
> > nvme target.
> >
> > Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > ---
> >   drivers/nvme/target/admin-cmd.c | 79 +++++++++++++++++++++++++++++++++
> >   drivers/nvme/target/core.c      | 69 ++++++++++++++++++++++++++++
> >   drivers/nvme/target/nvmet.h     | 13 ++++++
> >   include/linux/nvme.h            | 23 ++++++++++
> >   4 files changed, 184 insertions(+)
> >
> > diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> > index aaceb697e4d2..a55ca010d34f 100644
> > --- a/drivers/nvme/target/admin-cmd.c
> > +++ b/drivers/nvme/target/admin-cmd.c
> > @@ -376,7 +376,9 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
> >   	log->acs[nvme_admin_get_features] =
> >   	log->acs[nvme_admin_async_event] =
> >   	log->acs[nvme_admin_keep_alive] =
> > +	log->acs[nvme_admin_cross_ctrl_reset] =
> >   		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
> > +
> >   }
> >   
> >   static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
> > @@ -1615,6 +1617,80 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
> >   	nvmet_req_complete(req, status);
> >   }
> >   
> > +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
> > +{
> > +	struct nvmet_ctrl *ictrl, *ctrl = req->sq->ctrl;
> > +	struct nvme_command *cmd = req->cmd;
> > +	struct nvmet_ccr *ccr, *new_ccr;
> > +	int ccr_active, ccr_total;
> > +	u16 cntlid, status = 0;
> > +
> > +	cntlid = le16_to_cpu(cmd->ccr.icid);
> > +	if (ctrl->cntlid == cntlid) {
> > +		req->error_loc =
> > +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
> > +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
> > +		goto out;
> > +	}
> > +
> > +	ictrl = nvmet_ctrl_find_get_ccr(ctrl->subsys, ctrl->hostnqn,
> 
> What does the 'i' stand for?

'i' stands for impacted controller. Also, if you see sctrl the 's'
stands for source controller. These terms are from TP8028.

> 
> > +					cmd->ccr.ciu, cntlid,
> > +					le64_to_cpu(cmd->ccr.cirn));
> > +	if (!ictrl) {
> > +		/* Immediate Reset Successful */
> > +		nvmet_set_result(req, 1);
> > +		status = NVME_SC_SUCCESS;
> > +		goto out;
> > +	}
> > +
> > +	new_ccr = kmalloc(sizeof(*ccr), GFP_KERNEL);
> > +	if (!new_ccr) {
> > +		status = NVME_SC_INTERNAL;
> > +		goto out_put_ctrl;
> > +	}
> 
> Allocating this later when you actually use it would probably simplify 
> error path.

Right, it will save us kfree(). Will do that.

> 
> > +
> > +	ccr_total = ccr_active = 0;
> > +	mutex_lock(&ctrl->lock);
> > +	list_for_each_entry(ccr, &ctrl->ccrs, entry) {
> > +		if (ccr->ctrl == ictrl) {
> > +			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
> > +			goto out_unlock;
> > +		}
> > +
> > +		ccr_total++;
> > +		if (ccr->ctrl)
> > +			ccr_active++;
> > +	}
> > +
> > +	if (ccr_active >= NVMF_CCR_LIMIT) {
> > +		status = NVME_SC_CCR_LIMIT_EXCEEDED;
> > +		goto out_unlock;
> > +	}
> > +	if (ccr_total >= NVMF_CCR_PER_PAGE) {
> > +		status = NVME_SC_CCR_LOGPAGE_FULL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	new_ccr->ciu = cmd->ccr.ciu;
> > +	new_ccr->icid = cntlid;
> > +	new_ccr->ctrl = ictrl;
> > +	list_add_tail(&new_ccr->entry, &ctrl->ccrs);
> > +	mutex_unlock(&ctrl->lock);
> > +
> > +	nvmet_ctrl_fatal_error(ictrl);
> 
> Don't you need to wait for it to complete?
> e.g. flush_work(&ictrl->fatal_err_work);
> 
> Or is that done async? will need to look downstream...

No, we do not need to wait for ictrl->fatal_err_work to complete. An AEN
will be sent when ictrl exits. It is okay if AEN is sent before CCR
request is completed. The initiator should expect this behavior and deal
with it.

