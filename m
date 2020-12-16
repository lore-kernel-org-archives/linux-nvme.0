Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9464AC4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:52:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA8A2333E
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 05:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA8A2333E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aiXbDAIdzxcjdj+fRMRIs30S93jZ44CdGD17zrx5Bv0=; b=1ohprIdnmGDoOOfoaw3VHOLQ9
	3nn8EER6nRdzC5x3/+Nt+EarQ6OCJJxOnZPGKLiQGWInS4K9rX7lWxIHuhqNAO6xPPBYni71t75Vk
	ns1uH856/8n4rlKgNBVzcJf9FSTRsA61T7Xo5GnIgMYAYFDEPU2hK8yh0muKG2s44F7ApN3RZKEjm
	HTsk021/1QwPgFTlW3zO7K4IhFp5rZIAaOj63VpmPgBpI4S6nbOSfq1QnHP7igrZBMtSKmkFGu2lS
	qEzD9VBlET5VtmAso0hjvlFNx/rKoKkypnIOjhYv8QcodgPPQQ+VK12JdURKU81XgIdcseO37rqQj
	g2jQmNTig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpPjG-0000rQ-2C; Wed, 16 Dec 2020 05:52:02 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpPjD-0000r4-SK
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 05:52:00 +0000
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0BG5pOY4003292;
 Tue, 15 Dec 2020 21:51:24 -0800
Date: Wed, 16 Dec 2020 11:21:23 +0530
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Request timeout seen with NVMEoF TCP
Message-ID: <X9mgW4AxRpQsetN1@chelsio.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_005200_068266_B59CAD0C 
X-CRM114-Status: GOOD (  26.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Monday, December 12/14/20, 2020 at 17:53:44 -0800, Sagi Grimberg wrote:
> 
> > Hey Potnuri,
> > 
> > Have you observed this further?
> > 
> > I'd think that if the io_work reschedule itself when it races
> > with the direct send path this should not happen, but we may be
> > seeing a different race going on here, adding Samuel who saw
> > a similar phenomenon.
> 
> I think we still have a race here with the following:
> 1. queue_rq sends h2cdata PDU (no data)
> 2. host receives r2t - prepares data PDU to send and schedules io_work
> 3. queue_rq sends another h2cdata PDU - ends up sending (2) because it was
> queued before it
> 4. io_work starts, loops but never able to acquire the send_mutex -
> eventually just ends (dosn't requeue)
> 5. (3) completes, now nothing will send (2)
> 
> We can either schedule the io_work from the direct send path, but that
> is less efficient than just trying to drain the send queue in the
> direct send path and if not all was sent, the write_space callback
> will trigger it.
> 
> Potnuri, does this patch solves what you are seeing?

Hi Sagi,
Below patch works fine. I have it running all night with out any issues.
Thanks.

> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1ba659927442..1b4e25624ba4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -262,6 +262,16 @@ static inline void nvme_tcp_advance_req(struct
> nvme_tcp_request *req,
>         }
>  }
> 
> +static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
> +{
> +       int ret;
> +
> +       /* drain the send queue as much as we can... */
> +       do {
> +               ret = nvme_tcp_try_send(queue);
> +       } while (ret > 0);
> +}
> +
>  static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>                 bool sync, bool last)
>  {
> @@ -279,7 +289,7 @@ static inline void nvme_tcp_queue_request(struct
> nvme_tcp_request *req,
>         if (queue->io_cpu == smp_processor_id() &&
>             sync && empty && mutex_trylock(&queue->send_mutex)) {
>                 queue->more_requests = !last;
> -               nvme_tcp_try_send(queue);
> +               nvme_tcp_send_all(queue);
>                 queue->more_requests = false;
>                 mutex_unlock(&queue->send_mutex);
>         } else if (last) {
> @@ -1122,6 +1132,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
>                                 pending = true;
>                         else if (unlikely(result < 0))
>                                 break;
> +               } else {
> +                       /*
> +                        * submission path is sending, we need to
> +                        * continue or resched because the submission
> +                        * path direct send is not concerned with
> +                        * rescheduling...
> +                        */
> +                       pending = true;
>                 }
> 
>                 result = nvme_tcp_try_recv(queue);
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
