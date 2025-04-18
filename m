Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9381CC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TsFYuLGh8xNnT8t0lny4A6t6txQ0jUe2g78tYPIMlyM=; b=oe9zg0FtvnWzAyn/wVeAEbKkpt
	qQ/emfEJ1fqZ90N07uC2jpoR0NJRf5Odkblsye6JMa+vVbmtLGYCp19BGa3dEKnFqcfuP6wIdgczm
	Ph3K9Uf8d0g5FiwNHFtWvCGiTRmUb+q7lN6MMEvNghmW5dgXlvmTPD7aOlNWJgMdS4e87bNWBv44N
	zR2hBoYhCqGBWAwfb0uoiqO6w3ODSjI2brfSUUw3linr6OQnn9Lv0aqprTSUTWB6FDQAvrl+/RCjG
	w+P2HclIaNlf+OFyBqqzXc2SXSxNLpTADeqjuV1gfn/8di59kLDgXj8v4vi8K7M9vIPzEShdfCwVd
	N7HVybIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ptL-0000000HKak-2oA0;
	Fri, 18 Apr 2025 17:52:43 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5ptJ-0000000HKZ5-20kr
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 17:52:42 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-30332dfc820so2331261a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744998760; x=1745603560; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TsFYuLGh8xNnT8t0lny4A6t6txQ0jUe2g78tYPIMlyM=;
        b=Ze6eHFlseARkB6Ec3XtSSou0Oh9vD1EmbUnvpsElXpNXdTRbcXLlIhWsutrqMufd9m
         G4J3ZdZIexTNxCCX4Vykmaft1Nnf/RFRoXP3qBnLmeKx8yFlEwTD+fdafPtCoITYesFD
         Rhmc8ZHjOhlkRQMU11x2JGTRui+EPlhyHTYiiio+Y4/CrOEdMycQsPACaz0OsostDGj6
         VLnSdCPJnLuTOc8HFivk941kTyZBPzR/Au+GN5Po6qLpRKDsT2kvuCjllrDHNoE4J5re
         QWkusp09KElcolfIWHzl2MwN8qjzcghiKfJEPR1FJGh+w2yI8egZGbpqbsRLFBOiMhPv
         1gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744998760; x=1745603560;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsFYuLGh8xNnT8t0lny4A6t6txQ0jUe2g78tYPIMlyM=;
        b=WF04Bnsi85TQG+jszimJi8BGZjei8v6ZzN1PakWK0e15bs3OEQRqMq3iBroPX5PBvI
         4eSRWp2jpOsO4Z0uAHPqcbSDB7rK6ghPwKR1QRPUp+l8Rako87YeS7qukGMxQsQ8F+ne
         YiUTC0OiQq02QVi5aRJYbF7GMOEzt/OTkEsb5pDNPXsl5RQ/Yf9+7OwYflaGaXL3x47t
         rUpx4sna3bJcsE9hlxkNsg3u5uaLpW853EFTJGi0j4S9VCfFp0uX6+9iklFVXIeXL7mf
         nNIbWNS+ogyZHKfZ1jd/gQQz5UMS5Oryoi4kbhjxYcyqMwI6Bgbv4Oat4VlOj3pBeaNp
         lKug==
X-Forwarded-Encrypted: i=1; AJvYcCVHu5qK5WwQOCgbno4WFuy9bckTZDJGVAqQdlkeGiqJGsjcihmrxQy3YXxlzrf8Dk2S2bFDFaG7IMGD@lists.infradead.org
X-Gm-Message-State: AOJu0YyATKQk1YmkIx7c7HIzwS3drke49w9Q4kCFqgaZvv+iVE78ZQqn
	hnwNVpjQf3auvwYlqJfRvmb+BF/FFF1nwWGAqJcne2shRlrnTMU1Q/aDL9O1+CU=
X-Gm-Gg: ASbGncualAtp2ccejDCFePL7ap4sIy3l8nsCoBsPFvVEuzc9r7Ssdd2r0E4ZVpgXXgv
	7QUxRYwBOlqkzgvBX+pmDmNhBLhLfGKLRNVxMhmbJ3FVbuHzP/6CpGrACTM383c40cl2Rs4qfIx
	gCMBbYCjXwGLaFGsrWYJTEUJjghf8h+06HiHE0P+bsh8WnqFTu8SKgvP0T7yh3ITaO/eJCaDKKQ
	TdL+FeKrwkegKVXRdMn39nzo1D8FXNPIawW3ZxTE+mO1t8SgfbXeqXfwur/DrS5Q+/tl8prmcjH
	fw0dbIIeD0PKVb0Z0T1f6l6hoW2Jvp2qfpyckyQf6gdkPV5AIlk9LS8RsHM=
X-Google-Smtp-Source: AGHT+IEBHa67QvFzFQWm2yneuLwm8SwQ0zB337f+xHQo9e3mbRKUfgTmVGCA972hVNU/U2G8mQE2CA==
X-Received: by 2002:a17:90b:1f90:b0:2ff:6ac2:c5a5 with SMTP id 98e67ed59e1d1-3087bcc39b3mr4166935a91.26.1744998760049;
        Fri, 18 Apr 2025 10:52:40 -0700 (PDT)
Received: from purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e0feb21sm1525744a91.32.2025.04.18.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:52:39 -0700 (PDT)
Date: Fri, 18 Apr 2025 11:52:32 -0600
From: Michael Liang <mliang@purestorage.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250418175232.7mxlokunrackcjbn@purestorage.com>
References: <20250417071359.iw3fangcfcuopjza@purestorage.com>
 <acc46429-6228-475e-8fd8-bc3d43c7f710@grimberg.me>
 <4683e355-166f-4b9a-a3ea-529f7b058a84@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4683e355-166f-4b9a-a3ea-529f7b058a84@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_105241_566096_E9CCC907 
X-CRM114-Status: GOOD (  38.88  )
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

On Fri, Apr 18, 2025 at 02:49:25PM +0300, Sagi Grimberg wrote:
> 
> 
> On 4/18/25 14:30, Sagi Grimberg wrote:
> > 
> > 
> > On 4/17/25 10:13, Michael Liang wrote:
> > > This patch addresses a data corruption issue observed in nvme-tcp during
> > > testing.
> > > 
> > > Issue description:
> > > In an NVMe native multipath setup, when an I/O timeout occurs, all
> > > inflight
> > > I/Os are canceled almost immediately after the kernel socket is shut
> > > down.
> > > These canceled I/Os are reported as host path errors, triggering a
> > > failover
> > > that succeeds on a different path.
> > > 
> > > However, at this point, the original I/O may still be outstanding in the
> > > host's network transmission path (e.g., the NIC’s TX queue). From the
> > > user-space app's perspective, the buffer associated with the I/O is
> > > considered
> > > completed since they're acked on the different path and may be
> > > reused for new
> > > I/O requests.
> > > 
> > > Because nvme-tcp enables zero-copy by default in the transmission path,
> > > this can lead to corrupted data being sent to the original target,
> > > ultimately
> > > causing data corruption.
> > > 
> > > We can reproduce this data corruption by injecting delay on one path and
> > > triggering i/o timeout.
> > > 
> > > To prevent this issue, this change ensures that all inflight
> > > transmissions are
> > > fully completed from host's perspective before returning from queue
> > > stop. To handle concurrent I/O timeout from multiple namespaces under
> > > the same controller, always wait in queue stop regardless of queue's
> > > state.
> > > 
> > > This aligns with the behavior of queue stopping in other NVMe fabric
> > > transports.
> > > 
> > > Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> > > Reviewed-by: Randy Jennings <randyj@purestorage.com>
> > > Signed-off-by: Michael Liang <mliang@purestorage.com>
> > > ---
> > >   drivers/nvme/host/tcp.c | 16 ++++++++++++++++
> > >   1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index 26c459f0198d..62d73684e61e 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -1944,6 +1944,21 @@ static void __nvme_tcp_stop_queue(struct
> > > nvme_tcp_queue *queue)
> > >       cancel_work_sync(&queue->io_work);
> > >   }
> > >   +static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
> > > +{
> > > +    int timeout = 100;
> > > +
> > > +    while (timeout > 0) {
> > > +        if (!sk_wmem_alloc_get(queue->sock->sk))
> > > +            return;
> > > +        msleep(2);
> > > +        timeout -= 2;
> > > +    }
> > > +    dev_warn(queue->ctrl->ctrl.device,
> > > +         "qid %d: wait draining sock wmem allocation timeout\n",
> > > +         nvme_tcp_queue_id(queue));
> > > +}
> > > +
> > >   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> > >   {
> > >       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> > > @@ -1961,6 +1976,7 @@ static void nvme_tcp_stop_queue(struct
> > > nvme_ctrl *nctrl, int qid)
> > >       /* Stopping the queue will disable TLS */
> > >       queue->tls_enabled = false;
> > >       mutex_unlock(&queue->queue_lock);
> > > +    nvme_tcp_stop_queue_wait(queue);
> > >   }
> > >     static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
> > 
> > This makes sense. But I do not want to pay this price serially.
> > As the concern is just failover, lets do something like: diff --git
> > a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index
> > 5041cbfd8272..d482a8fe2c4b 100644 --- a/drivers/nvme/host/tcp.c +++
> > b/drivers/nvme/host/tcp.c @@ -2031,6 +2031,8 @@ static void
> > nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl) for (i = 1; i <
> > ctrl->queue_count; i++) nvme_tcp_stop_queue(ctrl, i); + for (i = 1; i <
> > ctrl->queue_count; i++) + nvme_tcp_stop_queue_wait(&ctrl->queues[i]); }
> > static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl, @@ -2628,8
> > +2630,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
> > { struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq); struct nvme_ctrl
> > *ctrl = &req->queue->ctrl->ctrl; + int idx =
> > nvme_tcp_queue_id(req->queue); - nvme_tcp_stop_queue(ctrl,
> > nvme_tcp_queue_id(req->queue)); + nvme_tcp_stop_queue(ctrl, idx); +
> > nvme_tcp_stop_queue_wait(&ctrl->queues[idx]);
> > nvmf_complete_timed_out_request(rq); }
> 
> Or perhaps something like:
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5041cbfd8272..3e206a2cbbf3 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1944,7 +1944,7 @@ static void __nvme_tcp_stop_queue(struct
> nvme_tcp_queue *queue)
>         cancel_work_sync(&queue->io_work);
>  }
> 
> -static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> +static void nvme_tcp_stop_queue_nowait(struct nvme_ctrl *nctrl, int qid)
>  {
>         struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>         struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> @@ -1963,6 +1963,29 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl
> *nctrl, int qid)
>         mutex_unlock(&queue->queue_lock);
>  }
> 
> +static void nvme_tcp_wait_queue(struct nvme_ctrl *nctrl, int qid)
> +{
> +       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +       struct nvme_tcp_queue *queue = ctrl->queues[qid];
> +       int timeout = 100;
> +
> +       while (timeout > 0) {
> +               if (!sk_wmem_alloc_get(queue->sock->sk))
> +                       return;
> +               msleep(2);
> +               timeout -= 2;
> +       }
> +       dev_warn(queue->ctrl->ctrl.device,
> +                "qid %d: timeout draining sock wmem allocation expired\n",
> +                nvme_tcp_queue_id(queue));
> +}
> +
> +static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> +{
> +       nvme_tcp_stop_queue_nowait(nctrl, qid);
> +       nvme_tcp_wait_queue(nctrl, qid);
> +}
> +
>  static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
>  {
> write_lock_bh(&queue->sock->sk->sk_callback_lock);
> @@ -2030,7 +2053,9 @@ static void nvme_tcp_stop_io_queues(struct nvme_ctrl
> *ctrl)
>         int i;
> 
>         for (i = 1; i < ctrl->queue_count; i++)
> -               nvme_tcp_stop_queue(ctrl, i);
> +               nvme_tcp_stop_queue_nowait(ctrl, i);
> +       for (i = 1; i < ctrl->queue_count; i++)
> +               nvme_tcp_wait_queue(ctrl, i);
>  }
> 
>  static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
> --
Yes, good idea to stop first and then wait all. Will verify this patch.

Thanks,
Michael Liang

