Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A4CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K7h+3nOuifYY/l5k//6Rty40ad6QCW78uQV37XDLOcQ=; b=KWsknsayb774kJ6e2ZdV/a+6z/
	eTPbzLwXGZMCMaaj+roznwSFcFdsqGMpCAfIRqzgURaTZYTi5jeCCMDTH6hD49CY6OYQiepa/D+p0
	Wuz0B7Weio8MvUkgpXD/QB2pL6MJ50ng/+/HXBWcwR5NBf828xQNv70zPi1dtZUtHzcs8AP1zj2L2
	5iiJPFCdK2mO3/CtY1W13EFk97ysWyWbjuxd80owbELKRDRhbPq8BU5GwtxGNmaDJ/4332inW+7JJ
	woc51zMwo0DD8ftKQ00eEOpmqP94RzGANi5fpEcdN3VXsXECK3WPghI8xVcw8Nbfpg6KtX/Or0MdY
	BpbrhscA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPTGn-000000030S3-1cVm;
	Tue, 19 May 2026 22:50:37 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPTGg-000000030RZ-2qzX
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 22:50:31 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1843612a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779231029; x=1779835829; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7h+3nOuifYY/l5k//6Rty40ad6QCW78uQV37XDLOcQ=;
        b=oiFKI1ML2XhQ7npuVMOn2sAgZwHk1n2CGRalCh55ZSZ07Rz+X6qxZG/MAv70lEXyfA
         HW299dAN+C/aEInGB86h2+FnDcd8BOPfYhOMzyubg9YJ6t55vE7Q29yCRNmubCu8JJPP
         JH5UViK9353br4e4LujM8G8dVFVvD8lzeFcWtB6ktyf6oVXvnen9uBI8wmprB9EIRpq8
         tCpY2ids33+fzy5qWvZnCq2L3Ei8fH5ZwD49YiF5asalYvlybaA5ct4ILNh44/cISo2A
         RedJwcdvKP01D7RwThtJAejOYyeowEG3n/5zsSjHYthvjRqXjO5L4GPTrWH1EQp02IWj
         2xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779231029; x=1779835829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7h+3nOuifYY/l5k//6Rty40ad6QCW78uQV37XDLOcQ=;
        b=lLM0j81YkmaWra8s3B17JUM2tsvwJAfrdChJtd7yKSyBRgXZkIbWI87Nnacke4uoT0
         b8Kkfaw2Y428K5/8u2rVMa8qgsaFq1ydhslZDH9rn+oMXpjB0tyG32edrqMBvi+kGFPJ
         VMZ7KgGiyBhBcQFrefv0C5XTZSVSEmIsalHMmDLoPvI5jDq3hYkm4loMyDfJYvNxOebZ
         uUzhsOcB+/QweHzIiTcwBllBHkfX06PiRkR1CAPIp1vmcosHY7Wwy+D/syRgTXkMcjpb
         oKIwueSpbEI/BOFtkdmgeu8X59GEk2FXGvZN6JmctVXa6flm5knr5OD7jfpvUizLaMsh
         YAjA==
X-Forwarded-Encrypted: i=1; AFNElJ+2bEypFrnJ994z2ZYzZkbShxrsnLoGDRoswBFTfb7oJlYFNXcUzVQqT1QT7KE/t5utCOihLi01faAZ@lists.infradead.org
X-Gm-Message-State: AOJu0YzhCQiVUaYRWrMZ/7vfmbtxCE87FF1SXqEEZIdrVhnOeBKWzdkF
	QGDGM2xPue/ntVQp1ug+Yol23/MDSN9mNfrwKVQRTjDdL7taGoDgvrTW
X-Gm-Gg: Acq92OHTuMeavuKNa+74A/W7Oyx0NTro8UV8HV221i5+C1GfUkhqjJ8CfgOCOtLTH8h
	835pXI2tgLuhPchIpWaHZxe9wTwlcDX0MdxDBbCPQS8Nnz4375msQneLGrEMD0vudKtP2BFJlxf
	p629iXGIesAfWkBPK0qcqImS0JcdlErq6ckpc01WQSV5loCszg78CpRJJafoWYVIzD6CuEahpzm
	snKbQP7p/dJFoHPlwx4rTAj0Hn3fdgrEVsQ7+3KiznInC1tt8hxGlaLgS3+0qUbMoum6C4BtwYE
	d+SdEnYgQeqtw4BL1Qb9UKFxLych5mi3vIIt2z3aWH8Lov1288L+t+shzyzcdHNWxKPDrvB4Agk
	sGD2x5p8eod1kOnFEXaawmqpyaISKa0xYSptlVyfxVqHlxbAzw1NIroxSmH3qLW7RY1WDWL3Kon
	w0frbuRHn3jb++pPxR8ytDeXrwJk8IMQ0BtabslyM+wotaEQl6pBUHbdxJh9Dlw9ZZCP+Y
X-Received: by 2002:a05:6a20:560c:b0:3a8:2af3:ce8b with SMTP id adf61e73a8af0-3b22e72fb16mr16926497637.14.1779231029282;
        Tue, 19 May 2026 15:50:29 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:b7a8:3b19:9ae5:8bc3? ([240b:10:2720:5500:b7a8:3b19:9ae5:8bc3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0ff0edsm18221065a12.20.2026.05.19.15.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 15:50:28 -0700 (PDT)
Message-ID: <7e688c2e-7fa5-45d2-9163-a81e1fd8c9f3@gmail.com>
Date: Wed, 20 May 2026 07:50:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-cli] nvme: check MUD support before firmware commit
To: guzebing <guzebing1612@gmail.com>, linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>, Guzebing <guzebing@bytedance.com>
References: <20260519134542.1841435-1-guzebing1612@gmail.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <20260519134542.1841435-1-guzebing1612@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_155030_725064_1B87EE4C 
X-CRM114-Status: GOOD (  10.71  )
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

On 2026/05/19 22:45, guzebing wrote:
> From: Guzebing <guzebing@bytedance.com>
>
> Firmware Commit returns the Multiple Update Detected value in the command
> completion. nvme-cli currently identifies the controller after the
> command completes to decide whether to print that value.
>
> That post-command Identify is fragile for immediate activation. A possible
> Linux race looks like:
>
>    nvme-cli thread              nvme driver AEN work
>    ---------------              --------------------
>    libnvme_exec_admin_passthru()
>      -> Firmware Commit succeeds
>                                 nvme_handle_aen_notice()
>                                   -> FW_ACT_STARTING
>                                   -> nvme_change_ctrl_state(RESETTING)
>                                   -> nvme_fw_act_work()
>                                      -> nvme_quiesce_io_queues()
>                                      -> wait for activation
>    fw_commit_print_mud()
>      -> fw_commit_support_mud()
>         -> nvme_identify_ctrl()
>            -> admin ioctl passthru
>            -> nvme_user_cmd*()
>            -> blk_mq_alloc_request()
>            -> __nvme_check_ready()
>               rejects user admin command while resetting
>
> nvme-cli then prints "identify-ctrl: ..." after the successful
> fw-commit output. The extra error makes it unclear whether Firmware
> Commit itself failed, even though the command completion was already
> successful.
Seems the changes good but to make sure let me confirm below if possible.
   1. Is this failure really caused?
   2. Is there any log or issue report information?
   3. Not necessary to care the case as the old firmware not supported 
MUD but only the new firmware supported MUD? (I think so but let me 
double check.)


