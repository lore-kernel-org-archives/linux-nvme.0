Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887CBC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8O/nuwsdKGU52NreHcZxhpgEp8dykxw7lGHzNqJuX8=; b=iVPQamYfvbiKRbV7wtHfo66EZb
	vN95B56aE6XZCQYsyH6AIpFN0sKAsRKMTDiv48VfLjJn4lByiXmiH3yCWen5nQuAWXacFA5Pzy1wh
	2Q0VkkN+gm71bR8GH1/A6PSZsc5BNecdZ6hWanZ6elT0g5DcRVGe+5skFYcbbOvB4SzleWtsu9UTT
	aXREVj6MJpY91IlzWKL3jFTP5KS9n0D/+AEcN61c+TLjdLhwFoH+5bqf4kaihyfiepFS+VlqGiK9x
	lWBF4TVrvE8bFdGO+ZiusshDE9IVslLoi4KaxF+/eQ/1j/hJDAW0s6lh+Zay6sYZzOyRKxL9OVXqB
	53SrBsew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gq2-007dCE-1R;
	Wed, 29 Nov 2023 09:26:34 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Gpz-007dBQ-2z
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 09:26:33 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so23740145e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 01:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701249989; x=1701854789; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8O/nuwsdKGU52NreHcZxhpgEp8dykxw7lGHzNqJuX8=;
        b=PL+iGDdrg6XLXb8s4dz/Sa6usgUb9nxzjPqztsbE2PcAIgWqj1thWR01fCrEXhhf+6
         3S9RSBIe/4FBR1oI6zsxKQQBgSSEP2C0vvrBEwgPprKu9gf4eiZADDVskyLqmE/ZXLSt
         jMx6rVvT505gtK6MQ05iNqoHqjpMDVnnGqSs+TXwTri3S/6MlxyqWxBtovOPU19plKQq
         IlIJOeuIr8EvP/3woVGCFG6KUA/mEPp2Ew8Bz5ecWhftA8TW8gsFJXfLOKGauL+5vDCh
         2q4qkWlrpnFh26o1PZcMF+OHNfCW3gT9wggLNcC87UcjHyPrgL5D7MDLFFTg2zZBl0jh
         N5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249989; x=1701854789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8O/nuwsdKGU52NreHcZxhpgEp8dykxw7lGHzNqJuX8=;
        b=kznz4A5Wf0tYcp68g1CN2dVLrWiTDwdiy8QWLctSxFRR+IGUI1bkVCc+DOdTNVlcq9
         9LR7A0hc9qUxqnUU9iLs065us46JmkWiNCcCXSHHR+ySXcvybpeDkZrX/Y6yXM9UzPiQ
         dSvKJQ+foIgv2a5TycSXhlgznEsOZNIbUInPZ88KCSfUEtNtT1+080ojcy0pveKFdBfP
         BKmR+kiLEUJygDexvO79WIFKD6EmMiyYVuecD7kq7KhguHquVAA//fdb886K1q7tRee6
         bfPHa7/AwsXpKvSkKe3QKPYXRhrH2YCZGc2Z20PUE8NQjrJVML/psGdXxWUhqteOZcN2
         BHfQ==
X-Gm-Message-State: AOJu0Yz4EXTYAbAbkmv1pE/TQ2LM8i/9NsnG1ry5+R2ZO1hZErwKErHT
	HicT0+WyX1h3eF3hT+8w+RzQeA==
X-Google-Smtp-Source: AGHT+IHkcagKEtwdXNV8l2UAjzC9Tph2HoH0JeWCCI53NSslDZsHp7jzdeo924Ha5Yxg7Zszd9hFuQ==
X-Received: by 2002:a05:600c:4f16:b0:40a:20f3:d126 with SMTP id l22-20020a05600c4f1600b0040a20f3d126mr11812689wmq.6.1701249989220;
        Wed, 29 Nov 2023 01:26:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d42c8000000b00332fa6cc8acsm10098442wrr.87.2023.11.29.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:26:28 -0800 (PST)
Date: Wed, 29 Nov 2023 12:26:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>, error27@gmail.com,
	gost.dev@samsung.com, nitheshshetty@gmail.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Message-ID: <0cd6862e-8037-40b3-9fde-b7f10d66e31c@suswa.mountain>
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128122958.2235-1-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_012631_964613_CB9E1AEB 
X-CRM114-Status: GOOD (  20.81  )
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

On Tue, Nov 28, 2023 at 05:59:56PM +0530, Nitesh Shetty wrote:
> This fixes the smatch warning, "nvme_loop_create_ctrl() warn:
> 'opts->queue_size - 1' 18446744073709551615 can't fit into 65535
> 'ctrl->ctrl.sqsize'"
> We don't need size_t for queue_size, u16 should serve the purpose,
> as max size is limited to NVMF_DEF_QUEUE_SIZE(1024).
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

Huh...  I'm sorry I wasn't necessarily aware that I had published this
Smatch warning.  I feel like it has a high rate of false positives.

Generally with Smatch warnings, I'm not going to try silence every
false positive.  And I had one complaint recently that I was too focused
on silencing false positives instead of discovering new bugs...

The other thing about static analysis is that static checker developers
want 0% false positives and kernel developers want 100% false positives.
I'm a kernel developer so in code that I have looked at the rate of
false positives is very close to 100%.  Only new code has valid
warnings.

Here is what this code looks like:

drivers/nvme/target/loop.c
   573          if (opts->queue_size > ctrl->ctrl.maxcmd) {
   574                  /* warn if maxcmd is lower than queue_size */
   575                  dev_warn(ctrl->ctrl.device,
   576                          "queue_size %zu > ctrl maxcmd %u, clamping down\n",
   577                          opts->queue_size, ctrl->ctrl.maxcmd);
   578                  opts->queue_size = ctrl->ctrl.maxcmd;
   579          }
   580          ctrl->ctrl.sqsize = opts->queue_size - 1;

Smatch thinks that opts->queue_size is a value that comes from the user
in the 16-47 range.  But the bug is that Smatch thinks that
ctrl->ctrl.maxcmd is zero.  16 is greater than zero so we do the
opts->queue_size = ctrl->ctrl.maxcmd; assignment.  Then zero minus one
is ULONG_MAX so that's a very high number.

Smatch is just wrong in this case.  Let me try figure out what went
wrong.  The ctrl->ctrl.maxcmd = 0 comes from:

	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);

It's supposed to get set to unknown in nvme_loop_configure_admin_queue().
The database has the correct data.

$ smdb.py return_states nvme_loop_configure_admin_queue | grep maxcmd
drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 229 |             0|       PARAM_SET |  0 |       $->ctrl.maxcmd |             0-u16max |
drivers/nvme/target/loop.c | nvme_loop_configure_admin_queue | 231 | s32min-(-1),1-s32max|       PARAM_ADD |  0 |       $->ctrl.maxcmd |             0-u16max |

But the issue is that Smatch thinks that nvme_loop_configure_admin_queue()
always fails with -12.  The reason for that is because Smatch thinks
that ctrl->ctrl.ops is NULL but the function can only succeed when it's
non-NULL.

The ctrl->ops assignment happens in nvme_init_ctrl() and it should have
been easy to track.  I am not sure what went wrong there.  I'll take a
look at that and fix it.

regards,
dan carpenter


