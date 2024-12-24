Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BA4E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Un1QRK3Mtuw3SeHg4TzziEYwXQ3lUmtGd5ycEZTLM3c=; b=wQjAHFwxbGQy8sKpRP+aCplPml
	EFHG2Ax3h/8CXLg1RNvrtZLdCceAljo+5tt68ePEiuM0lVBOYBSkSBWgluJcHWTW91GrDzHjNyYc/
	osmxaFjBFhGsvpiR8Vtjb7WQoBnHjU+8VjHSDqB61CuCPlFAPS9Z9LKOlnHtW1S9OPiWZhOtzesNI
	L2MIp0D0iQH8IlCP5Emklu72civHl0jqE5GrW9WpP35gffC6Dw6ssbLkBisTc+/jDokT011CK9ggo
	623JbAT15jhJfBjdB2USFwHLMeYFltJ2Rlya621katen6twUgXY+iY6ke7WLRxKrvAn2aED+rAX+o
	iqAFeqew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2CT-0000000Bl7C-47GN;
	Tue, 24 Dec 2024 10:31:41 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2CR-0000000Bl6G-1vtD
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 10:31:40 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385e27c75f4so3643330f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 02:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735036297; x=1735641097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Un1QRK3Mtuw3SeHg4TzziEYwXQ3lUmtGd5ycEZTLM3c=;
        b=ecU+PLVfQjFbEB6FdBK7NG8YMvZ10xXt5sc+ZFMpKMyQXiL+VmfhyZGN5rggS8LgNc
         1U/LFRu4729alLl5swyBCrm3FUux0g60FN1ksq4HK5HlP47su44RXHbGwdPv8Xrqb0fC
         qzVCOu8Cnpk9VqQvm3QV1550CKgRmZM0EVfMZrVJCuc0IR2bSVzanKfCx5sGjmEWdheu
         MG2PSB3dqHu6Sw8VNwFKYEx2x/55Q9nNLZgHfzdzJ9ordeqdbocj5mw2hYMKBhk0TwEN
         mb/MujSaQcuyJvVFEHG8xIorxuyKbccqWjI5UB4gdY72N14bMQaPa7NLk1RcVIfr6bA3
         HaYQ==
X-Gm-Message-State: AOJu0YzkGW6UDokQiIFrCTkpOSq3VSjfcIQU9k8jyTNPZtpPXITkmJlO
	W8KVnu/n8BqmyhIZpfbc+KvkSNjheWdABspfsUS4LRYpuXZji4+9
X-Gm-Gg: ASbGncuSoS/KdrJQaT+0/StK2eK/T2qbDAU7Ait1mkth2Bbd+Ll1ed2zx6CKTKd6ODg
	WrEbjIy1q0GOGQVfmr9UQOK++LPd+J96q6/XD5KVIzC2uDnXNGZQ/htVo5vnWYWm7Do+BO46NfK
	o9xpwtQ1lxKAFIqKvHd88r/ksX6de1kyoNqGW2uAIK6Ynfc2sLRJi7VfNZQdgcT6SHlRp75T7xZ
	xyCzoGcewHpZ+2czF2dFAl/Ph5rNmDB5YagUFH0yYIhfk4jHLSNdXi3ylpRj5MMMEVdgFSpVyB7
	+OZhSDXgXnZZYxlnq+a2BAs=
X-Google-Smtp-Source: AGHT+IELhZBLifRj9VyixbpOXsOxovDC9lByi6ix7Gv6MXH6pgWyVTduZCE+m2i7IKkE/947S7R57w==
X-Received: by 2002:a5d:6d84:0:b0:385:f1d9:4b90 with SMTP id ffacd0b85a97d-38a221ea720mr14479446f8f.13.1735036297394;
        Tue, 24 Dec 2024 02:31:37 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e3d9sm13544042f8f.67.2024.12.24.02.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 02:31:37 -0800 (PST)
Message-ID: <a8c476ee-e639-4886-a2dd-6e7d08060fa2@grimberg.me>
Date: Tue, 24 Dec 2024 12:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: trigger reset when keep alive fails
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241129-nvme-fc-handle-com-lost-v3-2-d8967b3cae54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_023139_509049_9EFF1BB4 
X-CRM114-Status: GOOD (  31.29  )
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




On 29/11/2024 11:28, Daniel Wagner wrote:
> nvme_keep_alive_work setups a keep alive command and uses
> blk_execute_rq_nowait to send out the command in an asynchronously
> manner. Eventually, nvme_keep_alive_end_io is called. If the status
> argument is 0, a new keep alive is send out. When the status argument is
> not 0, only an error is logged. The keep alive machinery does not
> trigger the error recovery.
>
> The FC driver is relying on the keep alive machinery to trigger recovery
> when an error is detected. Whenever an error happens during the creation
> of the association the idea is that the operation is aborted and retried
> later. Though there is a window where an error happens and
> nvme_fc_create_assocation can't detect the error.
>
>           1) nvme nvme10: NVME-FC{10}: create association : ...
>           2) nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
>              nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>           3) nvme nvme10: Could not set queue count (880)
>              nvme nvme10: Failed to configure AEN (cfg 900)
>           4) nvme nvme10: NVME-FC{10}: controller connect complete
>           5) nvme nvme10: failed nvme_keep_alive_end_io error=4
>
> A connection attempt starts 1) and the ctrl is in state CONNECTING.
> Shortly after the LLDD driver detects a connection lost event and calls
> nvme_fc_ctrl_connectivity_loss 2). Because we are still in CONNECTING
> state, this event is ignored.
>
> nvme_fc_create_association continues to run in parallel and tries to
> communicate with the controller and those commands fail. Though these
> errors are filtered out, e.g in 3) setting the I/O queues numbers fails
> which leads to an early exit in nvme_fc_create_io_queues. Because the
> number of IO queues is 0 at this point, there is nothing left in
> nvme_fc_create_association which could detected the connection drop.
> Thus the ctrl enters LIVE state 4).
>
> The keep alive timer fires and a keep alive command is send off but
> gets rejected by nvme_fc_queue_rq and the rq status is set to
> NVME_SC_HOST_PATH_ERROR. The nvme status is then mapped to a block layer
> status BLK_STS_TRANSPORT/4 in nvme_end_req. Eventually,
> nvme_keep_alive_end_io sees the status != 0 and just logs an error 5).
>
> We should obviously detect the problem in 3) and abort there (will
> address this later), but that still leaves a race window open. There is
> a race window open in nvme_fc_create_association after starting the IO
> queues and setting the ctrl state to LIVE.
>
> Thus trigger a reset from the keep alive handler when an error is
> reported.
>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/host/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bfd71511c85f8b1a9508c6ea062475ff51bf27fe..2a07c2c540b26c8cbe886711abaf6f0afbe6c4df 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1320,6 +1320,12 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>   		dev_err(ctrl->device,
>   			"failed nvme_keep_alive_end_io error=%d\n",
>   				status);
> +		/*
> +		 * The driver reports that we lost the connection,
> +		 * trigger a recovery.
> +		 */
> +		if (status == BLK_STS_TRANSPORT)
> +			nvme_reset_ctrl(ctrl);
>   		return RQ_END_IO_NONE;
>   	}
>   
>

A lengthy explanation that results in nvme core behavior that assumes a 
very specific driver
behavior. Isn't the root of the problem that FC is willing to live 
peacefully with a controller
without any queues/connectivity to it without periodically reconnecting?

