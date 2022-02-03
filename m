Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0353C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMyvXxqCDb6LDE7y3iumEmVuNT5U4aq7Dap4O63m+bI=; b=1QMTn141dPbeWWffyfL1QUpnr3
	2la3WJ4qKy6LjG8iKZdhX2p4aSgv/sv1zap+d3UIeaxAuXwDbF7u5nMBc5VfdFuduOPeQTbMNkiSC
	MkR/MxQhka1mT5uuPNG97u7nrAJ5TbRMlxy1q63ViyGKKsv6782eKZ+If+ozSJL1tIY/tfPW7xN/T
	FDWgzm+ZCO5WpxzuM2Y6khtE/jisREsHVDlPKtCLOvHKTk7P0YZElnw4xBR6aIQmaOboumYT7FSlH
	i8VUSYQAoa9w1ebR8/pbSFHYCtByxhn33ZOA921L/kn/6TPabzvJveUiw6DD+91Elb4fPHNZD5oz5
	frxBswEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFhwI-002c2w-2o; Thu, 03 Feb 2022 19:38:42 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFhwE-002c0l-IE
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 19:38:40 +0000
Received: by mail-io1-xd36.google.com with SMTP id p63so4580243iod.11
 for <linux-nvme@lists.infradead.org>; Thu, 03 Feb 2022 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KMyvXxqCDb6LDE7y3iumEmVuNT5U4aq7Dap4O63m+bI=;
 b=qXz0rS8NcYokjoLP9Ksn6b1Hl1UVTBZaVHrJZ/PkYB88MuVq1hiYtw2qHxOD73i0UU
 LZAIz6CSg/6FWHKseg91LFs9a3sWBsNjneTIV1ka2N2sTPotIZ37b52mPC1ufUe1MEeT
 QajGSxOwVsAP7PJ0z+VV3CDgduVozaWIpch9fRM0DF/8aHk9jawswO7iBt1bOcGdhgNA
 HZnB+Lv1KGi6eRTrH4AbiKjc9S9uk3nsuqljwoji6y0Xht8TDqSIrK8UzfyiaR/VXq1s
 Ut4UWgfHahOtIi5XwM1S6HOmYBqXu+8qN1NIWYlHX0QWj5Nanpja2FG2w8zun3vi5Tzy
 9SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KMyvXxqCDb6LDE7y3iumEmVuNT5U4aq7Dap4O63m+bI=;
 b=iZgXs3WBzGX0X4VIQOi10I8jrbCLuV6zfoYgIv/G2F+7D1gGfCWIqUiSbA1gHD/rsI
 K28quuF0j0I7IKovXAT22MTjo1m00dtQX6Ut31xOarnh76W5u9CrCkYpcThvhCXJdyqf
 SaZexDgsJBbopLjmiom2IJ5so2cei6ZYjU29SnVlZ7aqwZ9BYovMdgd8D4o+ZQGG2ptT
 u6ehbDJD3gLE9V8Eue4PU8S0Jy9KpaukMH2BRotY05k26YTkNxWXBsfOSggx6ckXzQza
 kUW9GcqJEqUuV6f0/e4JRW/lHB3y+ubCE0TI/WjUxnDDp3cJmm2CjsquqS//P18Wwv8i
 kLhA==
X-Gm-Message-State: AOAM532wBLP3H01e2JdQChQTLak7DWSBOs1qpGDirngfSIr4NH7kOYOa
 0wKLrDgxGJ5dVaVznkgJHIzNNwz5Yq2O+Q==
X-Google-Smtp-Source: ABdhPJzH56mqARnyv2gDESVGncDRHuJg9OxnfaW41W3OT+nVoAKMFr3MHvb0IEmtLf2ouXK/3GcGRQ==
X-Received: by 2002:a05:6638:2105:: with SMTP id
 n5mr3761688jaj.266.1643917116406; 
 Thu, 03 Feb 2022 11:38:36 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id d2sm5229241ilg.43.2022.02.03.11.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Feb 2022 11:38:36 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YfwukSSzRWJE2Jy2@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <26d483ec-e397-822b-343e-3f7e9f09927f@kernel.dk>
Date: Thu, 3 Feb 2022 12:38:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfwukSSzRWJE2Jy2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_113838_614401_96DE948C 
X-CRM114-Status: GOOD (  16.96  )
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

On 2/3/22 12:35 PM, Christoph Hellwig wrote:
> The following changes since commit b879f915bc48a18d4f4462729192435bb0f17052:
> 
>   dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-03
> 
> for you to fetch changes up to 6a51abdeb259a56d95f13cc67e3a0838bcda0377:
> 
>   nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts() (2022-02-03 07:30:57 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 5.17
> 
>  - fix a use-after-free in rdm and tcp controller reset (Sagi Grimberg)
>  - fix the state check in nvmf_ctlr_matches_baseopts (Uday Shankar)
> 
> ----------------------------------------------------------------
> Sagi Grimberg (3):
>       nvme: fix a possible use-after-free in controller reset during load
>       nvme-tcp: fix possible use-after-free in transport error_recovery work
>       nvme-rdma: fix possible use-after-free in transport error_recovery work
> 
> Uday Shankar (1):
>       nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()
> 
>  drivers/nvme/host/core.c    | 9 ++++++++-
>  drivers/nvme/host/fabrics.h | 1 +
>  drivers/nvme/host/rdma.c    | 1 +
>  drivers/nvme/host/tcp.c     | 1 +
>  4 files changed, 11 insertions(+), 1 deletion(-)

Pulled, thanks.

-- 
Jens Axboe


