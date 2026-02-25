Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440A6FD45F8
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bvdy/DlUHdaxbtTijB09/n0t23eVX0/FRyO4/MCxOhs=; b=WZVTRdjtHjBOWz5+U32vhDjb99
	K8ea/I393Xx6y+dxj1WRmQn3i6lV4Ib8Koz+q736MIrDvX6mSTrEZbLJTL5D8tCJwgKxDHLGTOEk1
	IQk2XcdizBSaMs0kAZYA0x8b9HeoYJLUyO6nvySf+EpZj/M6VDmupWHZgzVAikC8pFdwCRTME7A1s
	lClnbFXSUS3NtUYE0QTmLTbIjMgsGPcmhI/LkZ9poIwn7YDdxVFYCGnl7yrzg7cBnp0nbQ9D5V/cT
	Zm9cA0DpMu7xm71p86nFb9OLwgW+1YKXlwHJWLRVi3lq3dUwz73ap1PI3W+WeOvOTQBLzr3Sk33bb
	PyBU+O3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMmV-00000004xfc-2wNZ;
	Wed, 25 Feb 2026 21:50:55 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvMmP-00000004xf5-0bYO
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 21:50:54 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-46391f4c1f9so132322b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Feb 2026 13:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772056247; x=1772661047; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bvdy/DlUHdaxbtTijB09/n0t23eVX0/FRyO4/MCxOhs=;
        b=DdaZLY5Jtdx2p7FjArPkw4wnP2bA8lMLC3QvUma5strE5RsngYAVnpnoHDZq4pKhSe
         1+6gYlRajXmj00Q9WtxMdbhx01HgfA/I6pkfVCLG2IAfKxJGRgPyTkS4WvPCewde++Hh
         +82Ks34jN0XHGI+oUYtq5Lbo7apWcSKFZQu/AtocoqI+WOhpJzKcQOHKLdBSq380oizW
         uw/Z1p2k0rll+FRnYAToiECmre06SJNnJRDKV7Jn27S1OyZPt2ylJTLIqTc36iYFObqK
         pwxAs0KzL4IoL7SeFTEDoaY/WX1qIT6RD3LyGuJ5AJWOk0TsMbwqeXG6RBPPUHWUP62A
         GPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772056247; x=1772661047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bvdy/DlUHdaxbtTijB09/n0t23eVX0/FRyO4/MCxOhs=;
        b=Gf4F/VyiJJlMqLQWL9hj3wZ9GoUqyeVKqLzh73af03WrKaNnbNUZkeSYkXIwOuAmyX
         fDnyWsXH3REfrLoox13ll7FeVC7WkLhkuDvZhlfTA0ZjoRfNbyk8YGcb/Cm75n/LKbBx
         5iFIWN4aU0w1e1D5yJnYvvF7q56dU7Jy+EajzcvRqkiWRe8CvT76bby+nnQW/7TTsmoF
         uEfcblakboG/cxafrTUQQx+WXY/xVhdgtoBnDnwZL/f1eEZKU24CabsaH92UNcFys3W3
         HlixjfolQqsSifVjfd3lhx/fL+LTj8ibQjL5j9j/ulMo/yymnejo17qCaBPpqkXovcW8
         v4qw==
X-Forwarded-Encrypted: i=1; AJvYcCUv+NFvwmKV5vyUvcDmUVo/6cjqjAYjNWMGDeE5gjw5mF+eC3o+5wSkWxF33jGWF+yQEP9yzrfWdpl/@lists.infradead.org
X-Gm-Message-State: AOJu0YyY1i7aa2cXz/Aj3uvDWpYl/munmqVIGJE3N4qspXnYbOAwJLrk
	OvX7EYQ4q8GSoWfl39oy8WkmmW6nuHMl2SsL0qyGMJ/cbM0+LxUvHUB8ZFbUyy7O
X-Gm-Gg: ATEYQzwm3ycTO/1wIvV4m9jGXZQ5aVfESjaeO3n/kwTGQImYvIPzyRpwEGqOVPA7kQs
	2VXW9dvzY6OScM6HpYcHUJ3t9ryBJBrxC9w3xvDwAWeZNQnrVOPcSTJ/4D86dwpqDyM9KD03mnw
	XnAyBmCbEkVcyqtQEOpViC5E+AD8VNvh6AMFlCHbkKAzxOFt1oa4M7GuinSgxtUwygGp8bIGNE8
	vENQaUyE0cU4jpDyO5Ie9I7gtHrcEDi8k6ysdgVkGnguGozULSMq7daIELhGHXZdIjeuzkctGeC
	rzBmVZvWN94Roa+xZblHAZK6gebrNP/uUflvjySN6LECwTzA9IurYlE0y2sEE0QtwQZGpbjLSIN
	/DW2r+nyV4ihbRwFZO6pmNTApf6SWm6vaS3c6Qcnxode+jsVBRKn9GIFDSo1q8GVPPNjVMWb9yd
	QpRmixejio+5k3F679GdTiAPfhf2fzVKqB068I
X-Received: by 2002:a05:7301:9e44:b0:2b8:6573:2d35 with SMTP id 5a478bee46e88-2bd7b9e86b1mr7031916eec.2.1772050018494;
        Wed, 25 Feb 2026 12:06:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1a45a58sm66166eec.0.2026.02.25.12.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:06:57 -0800 (PST)
Date: Wed, 25 Feb 2026 12:06:56 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org,
	gregkh@linuxfoundation.org, Christoph Hellwig <hch@lst.de>,
	security@kernel.org, sagi@grimberg.me,
	YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
Message-ID: <1bceff87-87ab-4ac7-9a1f-76c990171247@roeck-us.net>
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128004136.946596-1-ioerts@kookmin.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_135049_193682_89F0BDC1 
X-CRM114-Status: GOOD (  24.21  )
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

Hi,

On Wed, Jan 28, 2026 at 09:41:07AM +0900, YunJe Shin wrote:
> nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> length or offset exceeds sg_cnt and then use bogus sg->length/offset
> values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
> entries, and sg->length/offset before building the bvec.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> ---
>  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 15416ff0eac4..1a62b405d8e6 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
>  	cmd->req.sg = NULL;
>  }
>  
> +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
> +
>  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  {
>  	struct bio_vec *iov = cmd->iov;
>  	struct scatterlist *sg;
>  	u32 length, offset, sg_offset;
> +	unsigned int sg_remaining;
>  	int nr_pages;
>  
>  	length = cmd->pdu_len;
> @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  	offset = cmd->rbytes_done;
>  	cmd->sg_idx = offset / PAGE_SIZE;
>  	sg_offset = offset % PAGE_SIZE;
> +	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt) {
> +		nvmet_tcp_fatal_error(cmd->queue);
> +		return;
> +	}
>  	sg = &cmd->req.sg[cmd->sg_idx];
> +	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
>  
>  	while (length) {
> +		if (!sg_remaining) {
> +			nvmet_tcp_fatal_error(cmd->queue);
> +			return;
> +		}
> +		if (!sg->length || sg->length <= sg_offset) {
> +			nvmet_tcp_fatal_error(cmd->queue);
> +			return;
> +		}

An experimental AI agent provided the following review feedback.

 If we return early here (or in the other bounds checks added below),
 cmd->recv_msg.msg_iter is left uninitialized because we skip the
 iov_iter_bvec() call at the end of the function.

 Since nvmet_tcp_build_pdu_iovec() returns void, callers are unaware
 of the failure. For example, in nvmet_tcp_handle_h2c_data_pdu():

	nvmet_tcp_build_pdu_iovec(cmd);
	queue->cmd = cmd;
	queue->rcv_state = NVMET_TCP_RECV_DATA;

 Even though nvmet_tcp_fatal_error() correctly sets rcv_state to
 NVMET_TCP_RECV_ERR, the caller immediately overwrites it with
 NVMET_TCP_RECV_DATA.

 Does this cause the state machine to proceed and attempt to receive
 data using the uninitialized cmd->recv_msg.msg_iter? Should this
 function return an error code so callers can handle the failure?

I do not claim to understand the code, and I did not try to follow
the execution sequence. However, I do see that at least one of the
callers of nvmet_tcp_build_pdu_iovec() does unconditionally overwrite
queue->rcv_state, as indicated above. Please let me know if the AI
feedback is reasonable or if it is missing some context.

Thanks,
Guenter

