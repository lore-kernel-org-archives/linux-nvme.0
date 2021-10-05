Return-Path: <SRS0=bdbJ=OZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9584C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 12:39:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D5E61872
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 12:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80D5E61872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UavjXEZkkxq/dyBMqnGAGu1anjw+QQ+sYtAhc5DdI5Y=; b=Fk0R3cXKtqDSJgZquAeHWdUeCe
	siJT3voW4nK55iOjHilRm1fGL9Li6H3GgAPMlAw9N4XVKQIxWsNR0umw+IF5Oz96VX9uJWZtQ1T5F
	aBPbOaorlfeU5GnNjDt5zyDdAtmjRIPkSndeFUME84aTPgepRWcPyeiCKZWcTMp6Mds/Iom17rbfL
	OU8fNE/i9AeGnqoVHRucZV1M5xSFHCqvsSjFXuYM1imb5WeXgk91I3zVyybLFss6UwT5zRla5xWhd
	MZhU6OADfGywU9dYY//zLbi0SpHH6tcLeGWe+Ia855+StNM8PLxDTB1ba6/6po2z74g4ojJkw2Jsv
	nOsEmOSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXjid-00ASne-CG; Tue, 05 Oct 2021 12:38:51 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXjhv-00ASlW-QY
 for linux-nvme@lists.infradead.org; Tue, 05 Oct 2021 12:38:09 +0000
Received: by mail-ed1-f48.google.com with SMTP id r18so77842843edv.12
 for <linux-nvme@lists.infradead.org>; Tue, 05 Oct 2021 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y1yYpKnm27mAgTiPO6O2C9KQEiROAk/pkmzPnUflbls=;
 b=2oW2lkbJ50huUBuvcjVVOL1Y0hR3vMawtjDaSlma7+0coQoM3mtIoBIElBBFaa5EEn
 vBSkOYdBFB0JWow+kNo8ceOAVijCWnfOd8Na+Eig35lem8UUEJxsZV5eM7GAbL8yB94X
 aRx3913uj1Fam4hltD0o7UwVdVXxhhanYiWTq3LHNKIerOVz7//8enS/7kFFbbkVAd8D
 b1quiRXemex+4PT2bEu6fvzhTVEPBfV6F36cOeoSz0FB8/P5vIDqvvqi6Rd3CrwcfXV+
 3/YfNsN5BEr8ZQAx/vDiMIIA06/7BTWlofGBXOpzRNeZXwI+kQSxH8uV9OIUPJR3dGAM
 uPIg==
X-Gm-Message-State: AOAM530EiFyglkrJRIwL/WmfzHefAhs4L0FI585CumQ58katOF2E/B7t
 yBq/7G5rN8CM7uhTFa0UJ0+XcXdIQEU=
X-Google-Smtp-Source: ABdhPJzK2w0PuoxhaVNoLHrti3zZUad0JxTy5iVLm79MnAEzMUb1tpvwqQmgHim9adthUkLg/p8W6Q==
X-Received: by 2002:a50:ccc4:: with SMTP id b4mr26231441edj.83.1633437483475; 
 Tue, 05 Oct 2021 05:38:03 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id bt24sm7752124ejb.77.2021.10.05.05.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Oct 2021 05:38:02 -0700 (PDT)
Subject: Re: [PATCH] nvme/mpath: fix hang when disk goes live over reconnect
To: Christoph Hellwig <hch@lst.de>, Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@fb.com
References: <20210918215729.388968-1-anton@lightbitslabs.com>
 <20210920063534.GA26999@lst.de> <20210920145336.GA489494@anton-latitude>
 <20210921071527.GA24837@lst.de> <20211004164612.GA1475751@anton-latitude>
 <20211004165725.GB21511@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6dcfff91-3973-3b2d-e289-38533463cfb6@grimberg.me>
Date: Tue, 5 Oct 2021 15:38:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211004165725.GB21511@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211005_053807_901070_40340D20 
X-CRM114-Status: GOOD (  22.25  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> How do we proceed with this fix?
> 
> Please resend with the suggested updates.
> 
>> I believe error propagation here is not wanted because:
>> 1) A failure to fetch or parse the ANA log should not be considered
>>     an error in ctrl initialization.
> 
> We must handle error that are due to a controller failing to initialize.
> 
>> 2) Such error will not cause problems in teardown.
>> 3) The same failure is possible in ANA work and we do not take
>>     any action in such case.
> 
> Failing in a workqueue is different from failing in the initialization
> path.
> 
>> 4) Adding support for failure to nvme_start_ctrl() adds complexity
>>     and does not look useful due to the above 1-3.

The feedback here is that this patch is changing the functionality
as before we failed initialization and now we don't.

What is the issue in propagating the error and then modify
the call-sites? Shouldn't it be simple enough to do?
--
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..d86623b90eea 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3158,8 +3158,11 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)

         ctrl->ctrl.nr_reconnects = 0;

-       if (changed)
-               nvme_start_ctrl(&ctrl->ctrl);
+       if (changed) {
+               ret = nvme_start_ctrl(&ctrl->ctrl);
+               if (ret)
+                       goto out_term_aen_ops;
+       }

         return 0;       /* Success */

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82492cd7503..59bfdd72a51a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2827,7 +2827,10 @@ static void nvme_reset_work(struct work_struct *work)
                         &nvme_pci_attr_group))
                 dev->attrs_added = true;

-       nvme_start_ctrl(&dev->ctrl);
+       ret = nvme_start_ctrl(&dev->ctrl);
+       if (ret)
+               goto out_unlock;
+
         return;

   out_unlock:
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 042c594bc57e..9e9e34a012e7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1141,7 +1141,10 @@ static int nvme_rdma_setup_ctrl(struct 
nvme_rdma_ctrl *ctrl, bool new)
                 goto destroy_io;
         }

-       nvme_start_ctrl(&ctrl->ctrl);
+       ret = nvme_start_ctrl(&ctrl->ctrl);
+       if (ret)
+               goto destroy_io;
+
         return 0;

  destroy_io:
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 10b164f02b5d..22199281ad17 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -923,6 +923,11 @@ static void nvme_tcp_fail_request(struct 
nvme_tcp_request *req)
         nvme_tcp_end_request(blk_mq_rq_from_pdu(req), 
NVME_SC_HOST_PATH_ERROR);
  }
@@ -2045,7 +2052,10 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl 
*ctrl, bool new)
                 goto destroy_io;
         }

-       nvme_start_ctrl(ctrl);
+       ret = nvme_start_ctrl(ctrl);
+       if (ret)
+               goto destroy_io;
+
         return 0;

  destroy_io:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0285ccc7541f..3fa89650c0d1 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -490,7 +490,9 @@ static void nvme_loop_reset_ctrl_work(struct 
work_struct *work)
         if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE))
                 WARN_ON_ONCE(1);

-       nvme_start_ctrl(&ctrl->ctrl);
+       ret = nvme_start_ctrl(&ctrl->ctrl);
+       if (ret)
+               goto out_destroy_io;

         return;
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
