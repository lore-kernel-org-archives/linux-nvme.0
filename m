Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECAFC28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQdaH+y51iTAZBH9HoOQfzAnclEGsM3F+rfp9wcD55I=; b=t0wXKdVNxlXMOJKndRICW1NEzd
	8cgxo+QUFVkbOdjqhXHl3uYvX9g5faNI19i05fnvvUD7kWMa49zrJoWrqpK9MeYZCEf97wTUnWwVA
	VLNzJIpmV+/e5pPLyljTWh1kr8g2dkvdxFyFc4toUuxig9QhqCY84eXp5BrmWc1btbChUkD22cx4z
	dFCilbcCAjsO5izhG7uPsCH1AYcpWbeUyAo/Bm6GRquCyyxsxUyBSoSH/IQRg9WqBdKt7XYt8NsHk
	kKuQFBuDYsG9lNlqgMMpS+7W+98/n2e7aRyAnKjYEWCTarmOBv1qJuMSL5bh1reQRhC6946E0DUdo
	01EBclcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ5CR-007rO9-Me; Mon, 22 Aug 2022 11:02:31 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ5CO-007rG1-P2
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 11:02:30 +0000
Received: by mail-wm1-x335.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso7539132wmh.5
        for <linux-nvme@lists.infradead.org>; Mon, 22 Aug 2022 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KQdaH+y51iTAZBH9HoOQfzAnclEGsM3F+rfp9wcD55I=;
        b=BJEMwh3q/lfpdveUKLdRQd8P7/Yinf5jUaTsExSR07VwplkT4lTrfHlNFd16/hGYN4
         nFnI9glnzwdWUAN9h0Nx2GnBmno9+rbKqPQ3/aYUCSGsnXJd5cciIHK9XCM4hF4KLZyi
         ScoRM1EMREdLURYBWVQm6pMADh9NoOUFRi9kTgFHWCTtS5REufvZEswZWsrr0mWpTp7u
         bbLh10jhXdkTJ9D7C1+PRAYuaMglgZzC8rxpZCF/fXtCP6aHu1G/2Yy8UGC71kyWbVK0
         91RPAH/UQt2f1peUuW2on6ihtZXVEsV4OvgOSSNkP4+jY+KYIUGE27MPCcEhNhk/Nrpv
         mZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KQdaH+y51iTAZBH9HoOQfzAnclEGsM3F+rfp9wcD55I=;
        b=2V7JNMPgUoSmeTnABBXien7zUuwpzJ5w1PJqrFKRiP3VEQmoz6ZRLVjmXESeWusprU
         K+5/EvbI3YzCudnDygo2kpluKknvExe/G+42IeDntwmXREnTLXQ9nT2WhWg3vfwd3oW5
         bMq6vM+2Hw4CIURy7BmnZdRINQ1SgzVyitCvoMmGaFE4JU3olMApfoypD63f+wkTv1xO
         86sW0sMFnqrQrUS5uv4Iip/nFU61+HennDO/HtELfvmISxINERw4C0z8dxB1B1ll+t1/
         O8ePueRK6FqCFTHniLk9xbXAnb/JWmSYaXmpeYMa/01UOpky5stSlFseMYbWyCjAHSip
         WQgA==
X-Gm-Message-State: ACgBeo2zDJTc5pFCcDLPP8VOrEuimX4Nrd+9fheUYQfGcPJUTFOvtMsr
	3cf5N+1UMbNYxbYrIYKpgvJsNFecugQ=
X-Google-Smtp-Source: AA6agR63qfL/hLf7eY7bLV5bv3fgRsHmScWk0OvZL+qsmIwKAtBhtx7zsPhdTvFy1A8XLNRGyrun1g==
X-Received: by 2002:a1c:7916:0:b0:3a6:3540:5b3c with SMTP id l22-20020a1c7916000000b003a635405b3cmr8858346wme.178.1661166144340;
        Mon, 22 Aug 2022 04:02:24 -0700 (PDT)
Received: from [192.168.8.198] (188.28.126.24.threembb.co.uk. [188.28.126.24])
        by smtp.gmail.com with ESMTPSA id a17-20020adffb91000000b002207a0b93b4sm11302657wrr.49.2022.08.22.04.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 04:02:23 -0700 (PDT)
Message-ID: <3294f1e9-1946-2fbf-d5cd-fcdff9288f72@gmail.com>
Date: Mon, 22 Aug 2022 11:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH for-next 2/4] io_uring: introduce fixed buffer support for
 io_uring_cmd
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>
References: <20220819103021.240340-1-joshi.k@samsung.com>
 <CGME20220819104038epcas5p265c9385cfd9189d20ebfffeaa4d5efae@epcas5p2.samsung.com>
 <20220819103021.240340-3-joshi.k@samsung.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20220819103021.240340-3-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_040228_873489_6B10F43F 
X-CRM114-Status: GOOD (  22.02  )
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

On 8/19/22 11:30, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Add IORING_OP_URING_CMD_FIXED opcode that enables sending io_uring
> command with previously registered buffers. User-space passes the buffer
> index in sqe->buf_index, same as done in read/write variants that uses
> fixed buffers.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>   include/linux/io_uring.h      |  5 ++++-
>   include/uapi/linux/io_uring.h |  1 +
>   io_uring/opdef.c              | 10 ++++++++++
>   io_uring/rw.c                 |  3 ++-
>   io_uring/uring_cmd.c          | 18 +++++++++++++++++-
>   5 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> index 60aba10468fc..40961d7c3827 100644
> --- a/include/linux/io_uring.h
> +++ b/include/linux/io_uring.h
> @@ -5,6 +5,8 @@
>   #include <linux/sched.h>
>   #include <linux/xarray.h>
>   
> +#include<uapi/linux/io_uring.h>
> +
>   enum io_uring_cmd_flags {
>   	IO_URING_F_COMPLETE_DEFER	= 1,
>   	IO_URING_F_UNLOCKED		= 2,
> @@ -15,6 +17,7 @@ enum io_uring_cmd_flags {
>   	IO_URING_F_SQE128		= 4,
>   	IO_URING_F_CQE32		= 8,
>   	IO_URING_F_IOPOLL		= 16,
> +	IO_URING_F_FIXEDBUFS		= 32,
>   };
>   
>   struct io_uring_cmd {
> @@ -33,7 +36,7 @@ struct io_uring_cmd {
>   
>   #if defined(CONFIG_IO_URING)
>   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
> -		struct iov_iter *iter, void *ioucmd)
> +		struct iov_iter *iter, void *ioucmd);

Please try to compile the first patch separately

>   void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret, ssize_t res2);
>   void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
>   			void (*task_work_cb)(struct io_uring_cmd *));
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 1463cfecb56b..80ea35d1ed5c 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -203,6 +203,7 @@ enum io_uring_op {
>   	IORING_OP_SOCKET,
>   	IORING_OP_URING_CMD,
>   	IORING_OP_SENDZC_NOTIF,
> +	IORING_OP_URING_CMD_FIXED,

I don't think it should be another opcode, is there any
control flags we can fit it in?


>   	/* this goes last, obviously */
>   	IORING_OP_LAST,
> diff --git a/io_uring/opdef.c b/io_uring/opdef.c
> index 9a0df19306fe..7d5731b84c92 100644
> --- a/io_uring/opdef.c
> +++ b/io_uring/opdef.c
> @@ -472,6 +472,16 @@ const struct io_op_def io_op_defs[] = {
>   		.issue			= io_uring_cmd,
>   		.prep_async		= io_uring_cmd_prep_async,
>   	},
> +	[IORING_OP_URING_CMD_FIXED] = {
> +		.needs_file		= 1,
> +		.plug			= 1,
> +		.name			= "URING_CMD_FIXED",
> +		.iopoll			= 1,
> +		.async_size		= uring_cmd_pdu_size(1),
> +		.prep			= io_uring_cmd_prep,
> +		.issue			= io_uring_cmd,
> +		.prep_async		= io_uring_cmd_prep_async,
> +	},
>   	[IORING_OP_SENDZC_NOTIF] = {
>   		.name			= "SENDZC_NOTIF",
>   		.needs_file		= 1,
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 1a4fb8a44b9a..3c7b94bffa62 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -1005,7 +1005,8 @@ int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
>   		if (READ_ONCE(req->iopoll_completed))
>   			break;
>   
> -		if (req->opcode == IORING_OP_URING_CMD) {
> +		if (req->opcode == IORING_OP_URING_CMD ||
> +				req->opcode == IORING_OP_URING_CMD_FIXED) {

I don't see the changed chunk upstream

>   			struct io_uring_cmd *ioucmd = (struct io_uring_cmd *)rw;
>   
>   			ret = req->file->f_op->uring_cmd_iopoll(ioucmd);
[...]

-- 
Pavel Begunkov

