Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3386C43216
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711D960EFF
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 16:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 711D960EFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zEhdYvtX2MUawRix0DywEIsVPUSSvnM9dFnS8CP+uuo=; b=VUf9/eDQfmXkxJ0AABrx4fQa9z
	TG9q3LYEanXWwSmElSOB0elmNlh2j7OPa/O6EvV0PjmRUuMnvevBmINrjtHtojUaibgpeqgnVsxKP
	EoqrbHACCxQPO76XyaQujnkGaxqF5xcu6eS60tK1ZRjSLiqItkfZpWSnI+OodfIw7tbvIWmK4SUW2
	EvMZg/YkspAPBnriwi6BOwdiHgxgcZlK+gmM7cTixxpZAvg/E2aZksj+6GXvzWTcmkURm6YxlcEwC
	06pzfie2YoEW2kniviFxtnd8B0hqTxyjpp1YcLmsrYm8A5xn65wMUOQrk6aG2jiMaAn2y+a0c8AkP
	ZgQndSkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFfpZ-00HU1F-KY; Mon, 16 Aug 2021 16:51:21 +0000
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFfpV-00HTze-De
 for linux-nvme@lists.infradead.org; Mon, 16 Aug 2021 16:51:18 +0000
Received: by mail-oi1-x22d.google.com with SMTP id o20so27585366oiw.12
 for <linux-nvme@lists.infradead.org>; Mon, 16 Aug 2021 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
 b=2M7PsQmoW0m68H0tIVJvrAROv1UoWp/uy48nnzobRrc03mo4J/lqcPLEQEF1kpJUHw
 HQBa4gX5fuTsQap76AZD/5O7VV8iT7vusfHhUAUKN78fP0BZSnTbz5bFFrpuEHica0IG
 vNOnPFWucI7QTNpQA0kxldWWTEaok+vCXtpMF9OBhganoAYTPaU0jWc3pk2ipYfiP3qw
 KJv7dYM9ZKsD48MEvHmMnjHIhntqyqYB/aLy5wa1Nk3VqVwfnK6sD7DQ+glML2iy7RW5
 8bKOFtNVZE+7XBNUsAmXKRXSN7yXiZDUd4eqzd5A6g+KiYc52tKP/BJj3qVXfxUmmZ/Y
 b/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lkHKKxx6E91blWpox1bXj/LIePIAFS6deUe/aal8ts0=;
 b=EHSdXTYbPIYXQz+XHvYa+dCQoNiDrje9JPd4giStUs1ozb6PI65rZ0xABrpCuP0Qg3
 8xLghS6qoptRbKgofIYYgM/MAh+u17DRue6ir1Jmu24Oq2NXEsugXRGEhWe6K4D70IJn
 ca1579ZKdwzvhVE70tLg+V3sSge4lr17ojqOfYDvF8mZmDeihv0xA0BppdG2QxQ28sXt
 ep8RlsEhkSN1XS0lsijfIWv1FAMVfVILV34+KtlY+9uXz1/d+rnNQb9C1Hlc9Gg5t8aM
 +h25OOmOmFIvyK8nOLH0+fYKronem6K/1KprmrShjJs+ECgsCg7nP+0dste1HJCWbbBA
 7+ZA==
X-Gm-Message-State: AOAM533IGpJ6AOeeQFVmZvJaLArYeoEwlq0nm9HTftxqB/JpCVC+iveY
 ke15EyqtKG95B4CSjsHaXkClrA==
X-Google-Smtp-Source: ABdhPJwPiJZucbHV+gTb5R7I/kfPLblHKKXb+EIub7hcvBOP41sFKxi/Q6epHu0YRXyVvO62JSl/PA==
X-Received: by 2002:a54:4619:: with SMTP id p25mr42850oip.5.1629132675579;
 Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id u18sm2018498ooi.40.2021.08.16.09.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Aug 2021 09:51:15 -0700 (PDT)
Subject: Re: add a bvec_virt helper
To: Christoph Hellwig <hch@lst.de>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
References: <20210804095634.460779-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4e321dab-188d-ca0a-a98c-4a587e7b5f27@kernel.dk>
Date: Mon, 16 Aug 2021 10:51:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210816_095117_540780_44F1B511 
X-CRM114-Status: GOOD (  15.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/4/21 3:56 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series adds a bvec_virt helper to return the virtual address of the
> data in bvec to replace the open coded calculation, and as a reminder
> that generall bio/bvec data can be in high memory unless it is caller
> controller or in an architecture specific driver where highmem is
> impossible.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
