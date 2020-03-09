Return-Path: <SRS0=ldP/=42=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89411C10F25
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8C224649
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2020 22:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FLPm6GHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8C224649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qvHmIZHsJqL4Iq0mMYm43cgjdez21u9fGtewOOap+BM=; b=FLPm6GHXyZ+hZxgBmUSRNvNZN
	+O6d4WcTR5noABU6AlrI8/IyUcz2+vWk3sN4OxgxexVRMv8l2bpuQJQlE07rZfvctTx1CscKp94fs
	kGCAUPX+M0Cb2yzdhUPmn5bZo/2LOrnNdpGnp8WRj0Q1a45yNhFxhNy0zSuXSHtbduHePXc2GAvCN
	aB1hpgrJbqwHYCpzNxM2T0gmzQx/IqQqwgmsfaf8PP8AehzZkcAtdHnELiBJscRMQdO0U5y5pKTI4
	pQvznJVU0tmj7nJEjajn/0cjPy3XuodBmP+6ILF54ZXY2edjlWNgUGmANYB07DZZHjVtkyOuwll0v
	S5Ca+weEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jBRDc-0007yX-9h; Mon, 09 Mar 2020 22:49:52 +0000
Received: from mail-ot1-f65.google.com ([209.85.210.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jBRDY-0007y1-Mo
 for linux-nvme@lists.infradead.org; Mon, 09 Mar 2020 22:49:50 +0000
Received: by mail-ot1-f65.google.com with SMTP id s15so3095599otq.8
 for <linux-nvme@lists.infradead.org>; Mon, 09 Mar 2020 15:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7b1wp+2C3BhcyyDBRacHmhXfAi43o2kbpUQ/e49ZJMg=;
 b=nkmBz4EJfKnhbGuj7/HNgXlKOYMvx6kFGC1PJkQGsbJGXRg1TM20M1cgvS8RxmkdoJ
 TTkhjLKeIkqf4s6cVs9mORR03b4Yx6kMHhx++DqGtqYAlhgJYI68YFq13UGinvrh7HRm
 uo/qjEDck16chalVsExBm0cny6u2/iuTNd2IAfQD65H8HwjJU8EgjOuN5iNKBLuQHJdd
 BBk3ydF2IvVHwvkh3DwOY57TVpBTQDecMl0/AUNWDydFLqgU2sekAA3EePsThCJCLxa3
 X1r323m3cZlI6/SwEIhyTIb5iNUX8EB2hAXbWvIoKYQL46a7xNqgD2Qfk9QrRHpatvOU
 yAwg==
X-Gm-Message-State: ANhLgQ043Ex/kjFFLofXFhj2lm1tQ9uKWmg+ERhUhBW5t9gl67uVk4g5
 w2qdyQa6e7O3VkoHx0ebxXk=
X-Google-Smtp-Source: ADFU+vvQd+3cgwgw6ai+7j2AOtGaRBqRuVhlsLzjVNF1zDAgQ0EYMZwLMhuEWIJ1lqeH18pzgSiLsw==
X-Received: by 2002:a05:6830:108d:: with SMTP id
 y13mr14914780oto.241.1583794187615; 
 Mon, 09 Mar 2020 15:49:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id s12sm3576582oic.31.2020.03.09.15.49.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Mar 2020 15:49:46 -0700 (PDT)
Subject: Re: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
 <CY4PR11MB1351F639D6B6582D5EEBA74DE5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7ad247fc-4c42-2712-c324-d257505eb0d0@grimberg.me>
Date: Mon, 9 Mar 2020 15:49:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR11MB1351F639D6B6582D5EEBA74DE5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200309_154948_752469_C7B2CBB1 
X-CRM114-Status: GOOD (  21.82  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> There is a problem that I see with nvmet-tcp target usage of msg flags with the SUCCESS flag optimization.
> 
>> Does this patch solve the issue?
> 
> This does improve things.  For queue depth of 1 now see ~49K, but the rate is not constant.  FIO output will at times show the IOPS rate drop down low then back up.  Also, a test run for queue depth of 32, and batch of 8 shows lower performance now vs. without this fix.  Before ~287K, now ~249K.  This got me thinking why would this be, in relation to 'disable_sqflow'.
> 
> Because the send data frame could be the last in the batch, much like the response or r2t frame, it made sense to integrate into your suggested logic for setting the flag to add that for 'last_in_batch'.  So modified to be the following.  This results in a good steady performance for queue depth of 1, and what appears to be a slight performance improvement for larger queue depths.  All good!

Thanks for testing Mark.

> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index cbff1038bdb3..7b2027cdd715 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -525,7 +525,8 @@ static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
>          return 1;
>   }
> 
> -static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
> +static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd,
> +               bool last_in_batch)
>   {
>          struct nvmet_tcp_queue *queue = cmd->queue;
>          int ret;
> @@ -533,9 +534,16 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
>          while (cmd->cur_sg) {
>                  struct page *page = sg_page(cmd->cur_sg);
>                  u32 left = cmd->cur_sg->length - cmd->offset;
> +               int flags = MSG_DONTWAIT;
> +
> +               if (cmd->wbytes_done + left < cmd->req.transfer_len ||
> +                       (!last_in_batch && cmd->queue->send_list_len))
> +                       flags |= MSG_MORE;
> +               else if (queue->nvme_sq.sqhd_disabled)
> +                       flags |= MSG_EOR;

Is the MSG_EOR necessary here? Can you check without it?

> 
>                  ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
> -                                       left, MSG_DONTWAIT | MSG_MORE);
> +                                       left, flags);
>                  if (ret <= 0)
>                          return ret;
> 
> @@ -670,7 +678,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>          }
> 
>          if (cmd->state == NVMET_TCP_SEND_DATA) {
> -               ret = nvmet_try_send_data(cmd);
> +               ret = nvmet_try_send_data(cmd, last_in_batch);
>                  if (ret <= 0)
>                          goto done_send;
>          }
> 
> --- Mark
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
