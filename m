Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1F3C6FD20
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZKRMSuluRMc0e9BXO5+TDbgf6gy3EYC5wrIH/iS9UE=; b=MBn51NOafHH+2f+UwybXiR5/3q
	PvhchGMlBRZtrMz29A0TfA2ahPDPgWn68ztBmLAf9+hYnukrC+TzojAtvPoGRkBWDJi0W4Td2C5Sp
	3Uk1SJjJgf/BMiikB6vIZuTT8eA7mJ+E6MNNnPOOQ4gb/2pMBSxeneZdDzJEGrzpxCsFRKAfdbV4U
	Nm40cbbCJY7jMWDumgfp6lz6EpJL17LyvV5645SlTf8eRYhIiX7396PmipOG0J9p3nMN5kpu5Ryld
	ad0Y82YfNA9ig06mLs6xCsSx45cjoSTWaieKuqWkjVYtF/gi2g5p5lhjwS2b7waG8GjC5d0jEifJS
	uFeb9BHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfm7t-005Jgm-1T;
	Fri, 24 Mar 2023 18:26:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfm7r-005Jga-2a
	for linux-nvme@bombadil.infradead.org;
	Fri, 24 Mar 2023 18:26:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LZKRMSuluRMc0e9BXO5+TDbgf6gy3EYC5wrIH/iS9UE=; b=G7BhzkVwaC6a6tiClBNXQ+udvH
	hsKYDD7jSivdk51tE3YnuA7ibxQJBDFxC8Al30k/I35oHID+VzJ0Zvy0136Qk1YWwYztsxDbChaGI
	NjJFzItl9+TVU+Gk0CdEykdWbpD37WF24W27RedmQfU4pml2BnZW8HbqZ0dDLcXI2eYCIio03RIbf
	q/jWepWBoWKuTjmxtn90YhBdP1utXEquslqdiNwV66d9W/COr9I03/z6Dvy6XhupykT7jPA409v5i
	hYVXl7nZkxFxP4qOwQmMJNDBWtdU63UZfgyKOvotsAUdXj4qGSl2AYmiZvOl7wJSJCafy5dTYtY9d
	WiUHdGDA==;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfm7o-005HIS-0o
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 18:26:54 +0000
Received: by mail-pg1-f170.google.com with SMTP id k15so1594302pgt.10
        for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 11:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679682343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZKRMSuluRMc0e9BXO5+TDbgf6gy3EYC5wrIH/iS9UE=;
        b=hBOwLLucDvga93pQ5Q5qVlyYuKKvGQpNsZLu4puvxCpoMZvXRWzBhC74xECHWGdqTU
         vYPuvQZOFyCfMf0l8J9tYkVVjDB4kfkXgq83VjKBHHXyKpsC0r9NJjlAaduurbGxfgu6
         4fP3reA9/7c80/ZdC1FTHeiEHQ49pgJxc8powrA2XcwA3My4TsvOz/3BAAWEtsmRlxxJ
         icdlAjdTT8gV33bMBw47evJqBdOiaRP+UXddzvZ6r+X5iur70UUJ3VrrFGNfFAySnYu5
         O4R7NrOLp6kayItEQvZzIN1URQ3ak8Fsw1F99Evdr04LtE6MbgrJHQ/S/g5gN/i0xbc0
         XjaQ==
X-Gm-Message-State: AO0yUKUd8vGUQ83FnhEHfPEPuVl1Tvdg/rqsBw3xT3ijhWLg9Z0/o6UW
	RrO+zJDQZKC3rI8yzG51vL4=
X-Google-Smtp-Source: AKy350ZYv1mpvYBouV9n6c8TTxMkUBO8IzS9P0gDxnwkTxznstPza4O2GaiA4I+LyvTxVupCsWuSlw==
X-Received: by 2002:aa7:9a5c:0:b0:628:1347:a619 with SMTP id x28-20020aa79a5c000000b006281347a619mr4097965pfj.10.1679682343388;
        Fri, 24 Mar 2023 11:25:43 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2421:e16e:b98f:7e76? ([2620:15c:211:201:2421:e16e:b98f:7e76])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78085000000b006254794d5b2sm2401894pff.94.2023.03.24.11.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:25:42 -0700 (PDT)
Message-ID: <298ce171-8738-1cd6-bce6-a846fb6469af@acm.org>
Date: Fri, 24 Mar 2023 11:25:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 04/18] scsi: Move sd_pr_type to header to share
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, hch@lst.de,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-5-michael.christie@oracle.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230324181741.13908-5-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_182652_371923_8888738A 
X-CRM114-Status: GOOD (  13.84  )
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

On 3/24/23 11:17, Mike Christie wrote:
> diff --git a/include/scsi/scsi_block_pr.h b/include/scsi/scsi_block_pr.h
> new file mode 100644
> index 000000000000..44766d7a81d8
> --- /dev/null
> +++ b/include/scsi/scsi_block_pr.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _SCSI_BLOCK_PR_H
> +#define _SCSI_BLOCK_PR_H
> +
> +#include <uapi/linux/pr.h>
> +
> +enum scsi_pr_type {
> +	SCSI_PR_WRITE_EXCLUSIVE			= 0x01,
> +	SCSI_PR_EXCLUSIVE_ACCESS		= 0x03,
> +	SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY	= 0x05,
> +	SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY	= 0x06,
> +	SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS	= 0x07,
> +	SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS	= 0x08,
> +};
> +
> +static inline enum scsi_pr_type block_pr_type_to_scsi(enum pr_type type)
> +{
> +	switch (type) {
> +	case PR_WRITE_EXCLUSIVE:
> +		return SCSI_PR_WRITE_EXCLUSIVE;
> +	case PR_EXCLUSIVE_ACCESS:
> +		return SCSI_PR_EXCLUSIVE_ACCESS;
> +	case PR_WRITE_EXCLUSIVE_REG_ONLY:
> +		return SCSI_PR_WRITE_EXCLUSIVE_REG_ONLY;
> +	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
> +		return SCSI_PR_EXCLUSIVE_ACCESS_REG_ONLY;
> +	case PR_WRITE_EXCLUSIVE_ALL_REGS:
> +		return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
> +	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +		return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
> +	}
> +
> +	return 0;
> +}
> +
> +#endif

Hi Mike,

Has it been considered to move enum scsi_pr_type into 
include/scsi/scsi_common.h and block_pr_type_to_scsi() into 
drivers/scsi/scsi_common.c? Other definitions that are shared between 
SCSI initiator and SCSI target code exist in these files.

Thanks,

Bart.

