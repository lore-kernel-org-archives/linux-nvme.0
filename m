Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D269EC3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 09:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDQeNAKllsd/qysAfNvbxnNz50iLV8y+/qrXjd4uuSI=; b=yLpamf1HP26xuovoi6JWh6nbDh
	ksibNfcF57s/4KNkl+JCkgLK3+ZfG8sa9EfXLjoBNwebG+m8Ame7vQrT8x44y7Y/OclmNBs5LUOri
	uO1IULr3J0kSln1cSb028qsy/+uI+cV8Bhr52ijKy1LVYY0OLLL4ztBq2Lv2O29ospT5LUazMMB8e
	qmsHDxqG+Y6lrys5qWnTuOIQCZdQ5t/FlEHkHpGLlrYdaLfGNtPciuZ2rSZW9gjbiCBd8vD3ajG+b
	uE4yL3kJ+4ywug2x9inFUhdw+oXwx9rn3BoWbUTDRuGDR6eN2+uhtkSyWHpTC66vkVpB6bzRPNSS3
	dk7dmGiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPJdP-008TmL-1a;
	Mon, 15 Jan 2024 09:51:59 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPJdM-008Tjr-10
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 09:51:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e412c1c58so10572575e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 01:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705312314; x=1705917114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDQeNAKllsd/qysAfNvbxnNz50iLV8y+/qrXjd4uuSI=;
        b=IJmq1cmv2KTXX8xpjt7TdHqp02d/DChuGQFcU3MckMDe50iJ8tUrKdhePIdmBc/WWX
         YLI60s+2VBP0MyaKMh8wZ5pVe+i2NozslcDp+NBBABUyPGLuy5pXSWUQiCh9uNzuAJT9
         q5clcnAnPMQ0Rcz7Tw7GMd0WiBjRLUgOjQQLBhKjOlfszSadNdMndokKZnhvmPZrsYVM
         P0wgyn4zy09AVYUPaAeNoWlU/JCyBX9QP7NUkeM4lLDN+l7tbLNnpH8aZpxva1Zd1ClJ
         SyO5PIaAf2YCDnv9st+lWRLtOAF+MYJpgF6M8gfWDg/qtzrPyDoKJz5/HDPEyr606Vqs
         EQTQ==
X-Gm-Message-State: AOJu0YxCT6z+npZmk3Tpwx0+qUYPECsWTZcj6UQKAXEAW0wWjiSdkYpC
	4OnGRZMvgfK0Aqup2YqlJm0=
X-Google-Smtp-Source: AGHT+IHW2/d1VmwhRLri9iqcktBDaUuwOXC/KEjuT47jhYNXNCkq7BLLKRea0b6tKOar53am5qmYeA==
X-Received: by 2002:a05:600c:3c99:b0:40e:4023:4da0 with SMTP id bg25-20020a05600c3c9900b0040e40234da0mr5963632wmb.2.1705312313514;
        Mon, 15 Jan 2024 01:51:53 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u14-20020adfa18e000000b003376d4248a9sm11495344wru.71.2024.01.15.01.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:51:53 -0800 (PST)
Message-ID: <6a120866-715d-4300-bf3d-4da5ce6a7d8c@grimberg.me>
Date: Mon, 15 Jan 2024 11:51:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/3] *** Implement the NVMe reservation feature ***
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240114092314.63694-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_015156_354110_4C779F69 
X-CRM114-Status: GOOD (  31.48  )
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



On 1/14/24 11:23, Guixin Liu wrote:
> Hi guys,
>      I've implemented the NVMe reservation feature. Please review it, all
> comments are welcome as usual.
> 
> Changes from v1 to v2:
> - Implement the reservation notification report, includes registration
> preempted, reservation released and reservation preempted.
>    And also handle the reservation log page avaliable event and send get
> reservation log page command to clear log page at host.
> 
> - Put the reservation check access after validate opcode. And remove
> opcodes which nvmet not implement yet check.
>    Now there is no admin opcode nvmet implemented needs reservation check,
> so I dont add reservation check to admin command path.
>    Next we need to do reservation check includes the situation of nsid is
> 0xffffffff at each admin command path, if it is needed.
> 
> - Add reservation commands support in nvmet_get_cmd_effects_nvm().
> 
> - From Chaitanya, change the local variable tree style to make it cleaner,
> and add some comments about NVMe spec.
>    And also change others advice from chaitanya.
> 
> - Put the nvmet_pr_check_cmd_access and nvmet_parse_pr_cmd into reservation
> enable check warp.
> 
> - Remove kmem_cache instead to use kmalloc and kfree.
> 
> - Change others advice from Sagi.
> 
> - Add a blktest test case, this patch will be sent before these series of
> pathes.
> 
> Advice I dont adopt:
> - From Sagi, use rcu instead of rwlock.
>    I need protect registrant_list, holder, type and generation simutaneously,
> the rcu can not protect multiple units.

I don't see how the generation needs the same protection.
As for the type and holder, perhaps we can find ordering that
allows us to relax the dereference? Or make it a member of the holder?

All I'm saying is that nvmet_pr_check_cmd_access() is dereferencing
ns->pr->holder and ns->pr->holder->uuid, so the proposal is to update
ns->pr->hostder with rcu synchronization such that the IO path will
simply do:

	rcu_read_lock();
	if (!rcu_dereference(pr->holder))
		goto unlock;
	if (uuid_equal(&ctrl->hostid, &pr->holder->hostid)
		goto unlock;
	rtype = pr->rtype; // or pr->holder->rtype ?
	rcu_read_unlock();

Nothing prevents you from protecting anything else on top of that.

> 
> - From Sagi, use blkdev's pr_ops if it is exist.
>    The backend is unable to distinguish connections from the frontend, If we
> use the pr_ops of the block device, the block device's target would only
> recognize it as a reservation by the nvme target.
>    Could you plz give me more information? Sagi?

Umm, won't nvmet register the same key as transferred by the host? Not
sure either how it should work.

In any event fwiw, if we can make the data path access cheap enough with
rcu I don't think its a necessary optimization...

> 
> - From Keith, use nvmet_get_cmd_effects_nvm to see if a command would violate
> a reservation.
>    The information is missing in effects, for example the flush command should
> be checked, but there is onely a  NVME_CMD_EFFECTS_CSUPP flag in effects, no
> LBCC.
> 
> Guixin Liu (3):
>    nvmet: support reservation feature
>    nvmet: unify aer type enum
>    nvme: introduce pr_work to handle resv event
> 
>   drivers/nvme/host/core.c        |  47 +-
>   drivers/nvme/host/nvme.h        |   1 +
>   drivers/nvme/target/Makefile    |   2 +-
>   drivers/nvme/target/admin-cmd.c |  14 +-
>   drivers/nvme/target/configfs.c  |  27 +
>   drivers/nvme/target/core.c      |  53 +-
>   drivers/nvme/target/discovery.c |   2 +-
>   drivers/nvme/target/nvmet.h     |  33 ++
>   drivers/nvme/target/pr.c        | 887 ++++++++++++++++++++++++++++++++
>   include/linux/nvme.h            |  54 +-
>   10 files changed, 1103 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/nvme/target/pr.c
> 

