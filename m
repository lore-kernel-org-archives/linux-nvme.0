Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586A0EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESJqWxt7uiB3LV1kjg0VulHWYuyUdwqSy7vW/FZvKTo=; b=1ae953im8txIuSox21leZPAZ0N
	Ppf5cf6p0cZdJEF6ZYv2Sx9zoXx0M/jsGNmQsPSyqvlvOU1N1pOdymfNT3k6mhPWSv7Q3xzTdmeI+
	bkn0z/8zD9ruu7nKkiqG4zRBTgTgVb0pdnBTCm83NIkXBK+ioDZFu5w21PZYoe1yNJ72vPFXVSY28
	b1Fhu51AbvBwMXROIEKNOKR+K2jUvxq1ULkBippy6Gk0Hati8XuErCa+FFpX+Y+OAqIBKvBVoSIJV
	MhO+FvGidulLhbFPqmEymc/WdCLyF+EX2fmNP6ATp/KvpXGrw+QB44UsAev5sx9z07Nv5EroPCR8M
	JsqbpRQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7vJ-00DzqL-2o;
	Tue, 11 Jul 2023 07:36:37 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7vG-00DzpO-2U
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:36:36 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fa988809c0so12240105e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060992; x=1691652992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESJqWxt7uiB3LV1kjg0VulHWYuyUdwqSy7vW/FZvKTo=;
        b=TQgCaZLn3VDo17oc66Kg4RmnJj9B+Xs0JjRNTBInbwSLrY0kN53HuN+bAVJTAz64Wm
         RrbwDw7aj1JQwhlK88cuRTKwgnPV6ts03DcrBn21Odk+K6Yqc2+T7jL4B7z9LaEV0mGE
         VN+4+dyB9fKY4zqcR2SOwjuypxTxGuLOj2CqXl0q+k/NHASCDXkZLd9q04KpZqjo9PVm
         poqp7N7Zb6do1jg7YE39CFhsN5hImNRi0jXE11Bx1IOlFo8rn/PjQm9euQS9ZcNOAFdc
         5mnOY8KssQg+mXao8cPPkrIYQdGIsqxJbdkB1A5PTrrVHn6Dbs73woL8HF8k+lv0r6XX
         iKFg==
X-Gm-Message-State: ABy/qLabd4lXYaCO2nUIg8QSBm6bDjWzgoZZjuwGTgfv/PbEGGOy7xfk
	xoT3Btr7HkEFKD51/JJrBnYZRR8Bqq8=
X-Google-Smtp-Source: APBJJlGYLuUEBuM2WFUZtPT/olKx0SP5LZIA3ALJ7vUmcs6eZwT+qMA9vC2LzUCDtXtwlAACfgJ5Fg==
X-Received: by 2002:a05:600c:5186:b0:3f9:9a6:eb68 with SMTP id fa6-20020a05600c518600b003f909a6eb68mr14746786wmb.3.1689060992319;
        Tue, 11 Jul 2023 00:36:32 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003fbe36a4ce6sm12189163wmc.10.2023.07.11.00.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:36:31 -0700 (PDT)
Message-ID: <60ba6267-8e31-09d3-ed55-e165835c4ad8@grimberg.me>
Date: Tue, 11 Jul 2023 10:36:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5/6] nvem: tcp: move start freeze into
 nvme_tcp_configure_io_queues
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-6-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230710153555.1766438-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_003634_808358_3034B888 
X-CRM114-Status: GOOD (  23.45  )
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

Hey Ming, a few comments,

1. s/nvem/nvme/g
2. prefix is "nvme-tcp: "
3. Can you please phrase the patch title as a bug fix?

On 7/10/23 18:35, Ming Lei wrote:
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) freeze and unfreeze are done in pair
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant

4. I think we need a "Fixes: " tag for the commit that added
the freeze functionality. IIRC it is:
2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")

Similar comments on patch 6/6.

> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e68bf21af348..798bfc29bc88 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1868,6 +1868,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		goto out_cleanup_connect_q;
>   
>   	if (!new) {
> +		nvme_start_freeze(ctrl);
>   		nvme_unquiesce_io_queues(ctrl);
>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -1876,6 +1877,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(ctrl);
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -1976,7 +1978,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
>   	if (ctrl->queue_count <= 1)
>   		return;
>   	nvme_quiesce_admin_queue(ctrl);
> -	nvme_start_freeze(ctrl);
>   	nvme_quiesce_io_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);

Can you please separate patches 1,5,6 to a separate series as these are
bug fixes that should go to stable.

