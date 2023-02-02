Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BBFC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 18:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=61Py2E5UozwXVn3n6QEUGPWLXlAH1Uh9+fZqJDGOGlY=; b=PyLd9F+qMFoviWf5rOXUxEHVbz
	h4Oag7vppqBa8xWB3NCy7UZR3nwAB+eRE8H0GjhcCoX+fBlcsB+ir7s8NzXrwI9ZTAVQydwZrKWzC
	Hwrqm5mznlfGxpnAewidVV5OS5FrZNsnDF3dIM8Jv92y/jT5YwescNU+8pMpUiJQCXPAYQKGszA15
	jLnX+poX+5rcSOrtjqd6h/mKCa2fHoh/6j3F+Zecw91fk8Yx13boPROL2DKtdPVPI0d739Vz4cFln
	xerDstvjHHLLVWXEZk0Kf3ykl0vg76PkmA1XGjruWctmdu/HwmRvirSGkvpTcEocgPJlwhu3KbT6n
	3zlxLf0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNdvH-00GtkS-IB; Thu, 02 Feb 2023 18:02:59 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNdvC-00Gti4-HR
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 18:02:56 +0000
Received: by mail-il1-x12c.google.com with SMTP id l15so1088577ilj.5
        for <linux-nvme@lists.infradead.org>; Thu, 02 Feb 2023 10:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61Py2E5UozwXVn3n6QEUGPWLXlAH1Uh9+fZqJDGOGlY=;
        b=7SNY7ay4YrvT8Is9sIQlCa+8sXeYX2dSBODoUv+ho7Z4IfxsR7rRarm9bv/vTFMxDk
         h9FcaF1dxOhFQhR0gvnCF98yPkw5abfHzuDUW8n2QS7JxZsaUy8GgQGz2vG9c/k+t/7E
         VmFBMI2nALH2Hdt+xmde5E+2i65mZ5Qoxf+7MZr9Q67+rxedlKOlovhzjiP1jM+dWsc5
         sWGnqPfvKsn37BLReQEqAXuFEpUs6nuI56XGytGICVsIK8FOZfTy59isrRIjV1lEpEXz
         NyIgoXHdx7p+jQX+qLzRHku4bDz8Oy+tkT1miSDXrhQMYbfH5BkupzmGvRYSo3aZC5qc
         cZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=61Py2E5UozwXVn3n6QEUGPWLXlAH1Uh9+fZqJDGOGlY=;
        b=6YkUaVNRtlb81GiQWtBUhsCyhVraQuS6VZXilUF9SuCKCx8WC1gaBWPLqZHYsOlf7/
         r/4b0Bg0d6iGT4spu4rYZa8jNXjyo0kqyKoDkidAzsKzlbBySpmMegRFC9m1VITve0zv
         QwAS8u58LSealSVA/9It9j4/QMmoCQEVdvJan4/s6JGNlNJL1kdyz9ZR0TrOhN970Md6
         Ciei1RUGLLguvJ1o1GpDh/KkJ5cyfwy6l1S4IXR44kWxp3Oy4MWXMcraNBEaFYb72gsV
         GzyW4PtwpZfDxQDcFttWUtE6pdbL7ZmN3/sUOUWbcS9odwWO9Q1NZI6N9D/veYgLutTF
         O6nA==
X-Gm-Message-State: AO0yUKUa1lMEW5frsYukJk/h9ieSalf/Ok6BGFfbEYaZg1mMx0Gh4x5z
	BPN8JDlONpjKBJ10F6+7Z+8xLQ==
X-Google-Smtp-Source: AK7set/yfIhv/Oi6OxFfVBHz2pDNxC9HPzPif0jzoxB8LofSxgmdNCc/mer0rLYxwbswollEKKAC/Q==
X-Received: by 2002:a05:6e02:152:b0:310:cc70:a152 with SMTP id j18-20020a056e02015200b00310cc70a152mr4740179ilr.2.1675360971573;
        Thu, 02 Feb 2023 10:02:51 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q8-20020a056e02106800b00310a599fd43sm91722ilj.46.2023.02.02.10.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:02:51 -0800 (PST)
Message-ID: <7607afd6-b26e-a2be-81c2-2d6ee20cc555@kernel.dk>
Date: Thu, 2 Feb 2023 11:02:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y9vVXvMeTgA4bC2R@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9vVXvMeTgA4bC2R@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_100254_825082_41558B32 
X-CRM114-Status: GOOD (  12.87  )
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

On 2/2/23 8:23 AM, Christoph Hellwig wrote:
> The following changes since commit 81ea42b9c3d61ea34d82d900ed93f4b4851f13b0:
> 
>   block: Fix the blk_mq_destroy_queue() documentation (2023-01-31 11:46:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-02
> 
> for you to fetch changes up to bd97a59da6a866e3dee5d2a2d582ec71dbbc84cd:
> 
>   nvme-auth: use workqueue dedicated to authentication (2023-02-01 16:11:20 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix a missing queue put in nvmet_fc_ls_create_association (Amit Engel)
>  - clear queue pointers on tag_set initialization failure
>    (Maurizio Lombardi)
>  - use workqueue dedicated to authentication (Shin'ichiro Kawasaki)

Pulled, thanks.

-- 
Jens Axboe



