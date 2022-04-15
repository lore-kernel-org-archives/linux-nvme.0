Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982C7C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQ6F19l4/uYVnO6D//9Bfxxz5m2KzVhnaSM18vdBJe8=; b=LIDTitgDVcE9mYIHNu06CKsjd5
	mauLguEUSkLmEy7VmZO1NC2w0HOUp+q9FYg/eUYsiKxfcCB8M97gVwBXuRiEr5wWiJ5aBq/hpwVjX
	kCIWYlTwgPe/sgURjTASSxccuSS3jKWK5aa4H4Pt+Ar0l12DmlUjIwZ4IeA8OI0qy1q/BvrNxKvrL
	RT5EjPJiLjV/QQ6fJBqX1yJMtSnU6rg4k7BxSBElfjpg4vGjkR6SvfUQlanDmBCcGjXXSidRXUXjQ
	WTOBlBVdF5ZLtsT4zeoUyOZI0hff2Vhp0R2uFWTI/vA+HqdhqbgTIWnS7F46bCt/EBu8DfEcbYnWF
	FYqZsl/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfLMP-00A7VP-Ae; Fri, 15 Apr 2022 12:47:37 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfL9g-00A1wk-4v
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 12:34:31 +0000
Received: by mail-pf1-x42d.google.com with SMTP id z16so7217288pfh.3
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=cQ6F19l4/uYVnO6D//9Bfxxz5m2KzVhnaSM18vdBJe8=;
 b=1F4+s6sjujb7jDcb3hnhuBMOTCTZhGSotTv/dc8Yjrt/Vec9m5nlnkflrH/fmLqlxo
 XOANiIY2fOQTa4ARGk6tGkmdpwcVqCU0S2WKp8aAGl2E9IVcsjYF0mAKYp2XWsK9Th9/
 hvcvJBaz2FeeHmqqZBkSySwaD2NbkQ95lvPoSpAzk1XImnG7NC3XF+5m7Kh8qVhmwbH0
 vtGGcpo3wyK5hUXd/py5rWuAazrhH+TTyfxGKWG9f7NUe9Nz3aKpqHTG/QAaukg3sbTv
 h+DNoHkTtoLqsaq8CICDRb4B4xUd0XBlF0u8oLMmZic8FNT200RZ/oiA/CIRzUZMyOyF
 dpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cQ6F19l4/uYVnO6D//9Bfxxz5m2KzVhnaSM18vdBJe8=;
 b=MJqdVliErqUSF+scll+ZSqWQ06LbFseXnvVwBQZkwBUiWwOeuaoSEV0JiQF/3lx1nD
 srTW0rqEScnl57hzbvc3EBvmQpjDlm8XqfW3Lt6c5z6c/Uf2KyHSBs/bMPgv87TEKeLt
 DeHLQ0sMiXF7zxEiGHw0yR8uff/Cw9zbB8dbpTDU9j/6bsELrpVv0PB19vhFBHEEgEJk
 V93wP7mSWOKPQisrIejbGjnj5RoF6OFg3UVWgjaycF6xEeqBDMaQmPreGq5giCi6l9js
 +9Q29T8e/2zkUEG17jwQ5j9weryzaGk3f+TmCLxKJtqbjWv/HPRn3TPQuBHYLmFMZ8ps
 JKRQ==
X-Gm-Message-State: AOAM530yXS1VrDdrVwF4ML+G9E17dX2DUrTnUEzqWliKeCDZUuHad9co
 9KK+VUcDswGHl6nC1vfaxUD4SEiOYtqjyw==
X-Google-Smtp-Source: ABdhPJzWeHJBfAtHkzC51sAv7hOn5FmqdHWT4uJJqAMo2+dMBRn3AalMPGLtf8wimOK8OQKsb2/fxw==
X-Received: by 2002:a05:6a00:14c1:b0:4fd:f3ba:e488 with SMTP id
 w1-20020a056a0014c100b004fdf3bae488mr8587179pfu.12.1650026065075; 
 Fri, 15 Apr 2022 05:34:25 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a056a0026d100b00505ff62176asm2718353pfw.180.2022.04.15.05.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Apr 2022 05:34:24 -0700 (PDT)
Message-ID: <7b96fa16-00dd-bfec-9c81-56bd40bb2f24@kernel.dk>
Date: Fri, 15 Apr 2022 06:34:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.18
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Ylj8FUYefzczGF92@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Ylj8FUYefzczGF92@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_053428_378869_238E7BDC 
X-CRM114-Status: UNSURE (   8.88  )
X-CRM114-Notice: Please train this message.
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

On 4/14/22 11:01 PM, Christoph Hellwig wrote:
> The following changes since commit 3e3876d322aef82416ecc496a4d4a587e0fdf7a3:
> 
>   block: null_blk: end timed out poll request (2022-04-14 10:16:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.18-2022-04-15

Pulled, thanks.

-- 
Jens Axboe


