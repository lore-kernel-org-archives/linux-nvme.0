Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2202E10F995C
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=; b=zWmHQXgkpiunJt1ETsSb4mog1S
	Ut0Yhi7WVXfr+Q0CMYH7z2Lgno7h2DDsN9WVHSZCTRQynBtK4+56lSsE388EQJVaW5Y9agHzr6bMm
	WRohHkIizV+2JybWFLmW9y4CAnyQh7NG11f/CoRuZfpuR6eLjtvjQzn1zKljRtp0Q567PxDlXcobQ
	7kA0ERXCjh8+EfOxWef0xbjc5vonof3VN0QZZPEASjJxHb++ZOor6iiVMRmU/b6egOABR1tsAizJ0
	Ly/UP5zqeZWaGUgVIUPixVvaolZ2rauB5gWZjDVA2Ju9fbMXLcJSoTm+QksNNB3nOoAelcd5wvHZl
	PZyRUkbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAW7O-000000098fg-32EC;
	Wed, 08 Apr 2026 16:51:06 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAW7K-000000098fK-2dsg
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 16:51:03 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43d23305225so16692f8f.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 Apr 2026 09:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775667060; cv=none;
        d=google.com; s=arc-20240605;
        b=fA7SEKAQbVy88xrZpG7uLLkMP6E/7NSrVGegD4yxNC6UQSOc3/2s6G/f2bB8hszt2W
         tz3Aniv4V984D6AQefqmw8h2EO7TJTRGlEWzeVvCZ2OMw7BPTCRwYGWqI6Yctt9LylFK
         759pWJXInBRNUGOdPoOdd35nFvMnFmQusnhHkAd+cvjdmm5OnUbokj6G2m/sDrx0+kM/
         1VvSWo7I7z7RRpE0flvo8vsZcBAyJyG1lbcW1GNIGMp/pxyTMN4qtrRpawS5vHlGjcPn
         phqA/7HI7wBqjYOTPOChLOLwT1kmr5Dh4GPwwLGlX/wOHNyeoJuTw73UVkkYoDXWCIh7
         L3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        fh=8kinEdnbwekvYCoVDNDMYmCLjq+65Tj4xzyPWoy/aRc=;
        b=U95SrvBFOlM5en3LBtAoUTq3TDrQpKXc6lAwThBY0NAKQCYqjfM5aizq+osjREqMzM
         gT/2f3FDWPoujhJRnOu5CNyvcFwvxksT7jKmgjfw9UfLyEaYzZqbVgQrF3q/fArt+/d4
         FGzwQyIQ1i3Uvly4apLfmtx06hlXedlj9k0h2S8KSJknAuOmg8OPh5aC62pK7jgh3ufC
         PHrfGG1xNFrrHxfYyXHXIjySXbGCYy3RnFU7zyz5joXKuRaweO017+INaTbx2BuxXY/N
         +kjxbRwXDtz848/vsux7QbkotSejoDvf/Ers7OODBgtnpQ0tlJkPVHbFCY9/WQt6vLOS
         1yIA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775667060; x=1776271860; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        b=aCnDwCV6aJv6Ej3CFaD/qGrA/5I1HcCzTd3TNQEUl4Zfc1usfhAcNfeSaY1y+0OYVs
         sEjZ54WmJpH89wX462dBfQt9v0BY+coK4y18YKiYWz74wsDqhWifHJajpifAUUSbAJhk
         6Fl1utblVOMYr3QtOAi3XJSvYvvIdNNU8XJHMJRqXOk4VF6ci4YU9pQkYV7uWB4r80Ey
         BUApY3H+qJigGyhYJ1gS4pLBIitge29N3FvwgB+Ms5MQA25LIH8fY/uL7iPQVyMElINf
         GvpH833zJDeofJoJPKE3/+RijQ9/ZbMcU8TS9YhMG10/uykaZmI4jxtsPuXOFDeF5aGR
         04wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775667060; x=1776271860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuGzISQhn4e8gmKsfNeQIVwGu7MLjzqdvdYg7l0TjlM=;
        b=bbu2+BmOKsXLhANsN5YfuusvviRlPv+4vJ0CHnMxa8Mu608sjVXQ8vGEvnnYgLFvDT
         h8Myz5x/bdDSjpmb+JZkrnn7RPC2GP7Xid15EVQDhYrF2dvm/hq3ME1FgmZQzNUtyXRr
         x+IXfEAGFCC24dsMLgkCg/d37E8N/TiFsy9w6utABwjVxPAfzfSzcLUlr6DPICTZosRY
         GgQ9RAE4ZCGePmHHljIEZQaqcMUodjUiBQJHKQXWHFGZnXFryB5Y2EfMem23sGdLjBUZ
         NAhRBd9LZ+ZFzODPWxx/XdQa5ESoqu1tG6Ro7gygT95nBXDS7Kejq9X7jWcD0T2+VIQw
         oUqA==
X-Forwarded-Encrypted: i=1; AJvYcCVDH7xD7p6jx07TkoAZ2nh5GXTswHVcuBmihiIO0+F47dc+6+9VZVFxfc28YmCd8ZUrseEYp4p0t6ge@lists.infradead.org
X-Gm-Message-State: AOJu0YwW/mm+tPbz+s9fNRuP4QI0IGwW+h8j3bLOEZEQ9Kyts9nNKvxd
	U3Ch+/nIqOw/JA7y644aCGZOaA96WQnsq8QJ7L+n4DsohMqj4IQUl7oOphxT7D5sd8z0iBma/JO
	yQUvfE95sfeGYPq7KN64FEy2uDH7ULzY=
X-Gm-Gg: AeBDies6xsMwFek4emwAgeQUPCR7zcxglXgxCRIGUok98LIwDR+UFUdH6VqYRfRWO7g
	ucm1Dy7oiMm/xBwDj090bJGBOx7D7o6GD4Kf5U3uBpx0DGAlXEXQgA/6ZiLp3c0S7GC9JNAsPxg
	IhU7vT5DVpdqOayzERgRUJGnuzoJsFrHJlm5EL9nil2xPo9aStWtZxJwM9uB6ngqKCcWE0L/R8s
	KGuCvajgWQLixSg8Y+Om9/SkJUgPQfOhtmp22nFvjb2tUB2I9/odXY+NZ7exzm0dV4WJvP6/zI2
	fsIdSCtncg==
X-Received: by 2002:a05:6000:4010:b0:43d:1c7a:8b59 with SMTP id
 ffacd0b85a97d-43d292df72cmr33870067f8f.40.1775667059574; Wed, 08 Apr 2026
 09:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260408075131.6221-1-kch@nvidia.com> <BN0PR01MB7007C5B4178BCD8619FC5D91C85B2@BN0PR01MB7007.prod.exchangelabs.com>
In-Reply-To: <BN0PR01MB7007C5B4178BCD8619FC5D91C85B2@BN0PR01MB7007.prod.exchangelabs.com>
From: Shivam Kumar <kumar.shivam43666@gmail.com>
Date: Wed, 8 Apr 2026 12:50:47 -0400
X-Gm-Features: AQROBzA63XUlo-BPA0YXAQEH4HZEsU1binjgE78_KDKkT5vFyUJeW05ZWH4g0AU
Message-ID: <CA+ysrS+6MdeKv0snUNcQ-2CJCmKbBAMaFCDvv-9nKBHSfoNfmQ@mail.gmail.com>
Subject: Re: Fw: [PATCH] nvmet-tcp: fix race between ICReq handling and queue teardown
To: Shivam Kumar <skumar47@syr.edu>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, kbusch@kernel.org, kch@nvidia.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_095102_729864_717A9D13 
X-CRM114-Status: GOOD (  35.58  )
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

_______________________________________
> From: Chaitanya Kulkarni <kch@nvidia.com>
> Sent: 08 April 2026 03:51
> To: Shivam Kumar
> Cc: hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org; kbusch@kernel.org; Chaitanya Kulkarni; stable@vger.kernel.org
> Subject: [PATCH] nvmet-tcp: fix race between ICReq handling and queue teardown
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.
>
> If an NVMe/TCP host sends an Initialization Connection Request
> (ICReq) and immediately closes the connection, target-side teardown
> may start in softirq context before io_work drains the already
> buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
> sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
> reference under state_lock.
>
> If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
> still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
> DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
> allows a later socket state change to re-enter teardown and issue a
> second kref_put() on an already released queue.
>
> The ICResp send failure path has the same problem. If teardown has
> already moved the queue to DISCONNECTING, a send error can still
> overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
> window for a second teardown path to drop the queue reference.
>
> Fix this by serializing both post-send state transitions with
> state_lock and bailing out if teardown has already started.
>
> Use -ESHUTDOWN as an internal sentinel for that bail-out path rather
> than propagating it as a transport error like -ECONNRESET. Keep
> nvmet_tcp_socket_error() setting rcv_state to NVMET_TCP_RECV_ERR before
> honoring that sentinel so receive-side parsing stays quiesced until the
> existing release path completes.
>
> Reported-by: Shivam Kumar <skumar47@syr.edu>
> Fixes: c46a6465bac2 ("nvmet-tcp: add NVMe over TCP target driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>
> Hi Shivam,
>
> This patch is different than the one I posted.
>
> Posted patch :-
>
>
>                 iov.iov_len = sizeof(*icresp);
>                 ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>                 if (ret < 0) {
>         -               queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_lock_bh(&queue->state_lock);
>         +               if (queue->state != NVMET_TCP_Q_DISCONNECTING)
>         +                       queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_unlock_bh(&queue->state_lock);
>                         return ret; /* queue removal will cleanup */
>                 }
>
> This patch :-
>
>                 iov.iov_len = sizeof(*icresp);
>                 ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>                 if (ret < 0) {
>         +               spin_lock_bh(&queue->state_lock);
>         +               if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
>         +                       spin_unlock_bh(&queue->state_lock);
>         +                       return -ESHUTDOWN;
>         +               }
>                         queue->state = NVMET_TCP_Q_FAILED;
>         +               spin_unlock_bh(&queue->state_lock);
>                         return ret; /* queue removal will cleanup */
>                 }
>
> It will be great if you can provide tested-by tag on this patch
> so we can merge this fix as well.
>
> -ck
>
> ---
>  drivers/nvme/target/tcp.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 69e971b179ae..98b2ce9a70ca 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -407,7 +407,22 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
>
>  static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
>  {
> +       /*
> +        * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
> +        * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
> +        * already been consumed and queue teardown has started.
> +        *
> +        * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
> +        * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
> +        * cancels it, the queue must not keep that old receive state.
> +        * Otherwise the next nvmet_tcp_io_work() run can reach
> +        * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
> +        *
> +        * That is why queue->rcv_state needs to be updated before we return.
> +        */
>         queue->rcv_state = NVMET_TCP_RECV_ERR;
> +       if (status == -ESHUTDOWN)
> +               return;
>         if (status == -EPIPE || status == -ECONNRESET)
>                 kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>         else
> @@ -922,11 +937,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
>         iov.iov_len = sizeof(*icresp);
>         ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>         if (ret < 0) {
> +               spin_lock_bh(&queue->state_lock);
> +               if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +                       spin_unlock_bh(&queue->state_lock);
> +                       return -ESHUTDOWN;
> +               }
>                 queue->state = NVMET_TCP_Q_FAILED;
> +               spin_unlock_bh(&queue->state_lock);
>                 return ret; /* queue removal will cleanup */
>         }
>
> +       spin_lock_bh(&queue->state_lock);
> +       if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +               spin_unlock_bh(&queue->state_lock);
> +               /* Tell nvmet_tcp_socket_error() teardown is already in progress. */
> +               return -ESHUTDOWN;
> +       }
>         queue->state = NVMET_TCP_Q_LIVE;
> +       spin_unlock_bh(&queue->state_lock);
>         nvmet_prepare_receive_pdu(queue);
>         return 0;
>  }
> --
> 2.39.5
>
Tested this updated patch - the handle_icreq race is fixed.
Tested-by: Shivam Kumar <kumar.shivam43666@gmail.com>

