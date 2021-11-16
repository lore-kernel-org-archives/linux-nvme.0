Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE201C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:01:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4A9F61AA2
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 09:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4A9F61AA2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woZZho7jnRD8mZOPJ5sPkwIB7WjBuX5d/9m/ADzN6J4=; b=hrxtbnByz26cE5pPCqvKgulbQk
	rzBsUcUUTR+CcePD29jgL/bXTG+qdqOTEOFJe086O+jJCUPyqO+l53c3+jepeuIj55uzNnfyx4/m3
	LltMZRuaSZQBvxRYk5XqM0k3xIrHaJwiC7GRMCOc0qEwmFlcIJFFbrNxadPyr0WA1aaUX6NQkf1Hr
	9giAPpR4vCmKreiBS3Rjq0T313R324vQo3hCfmR6Do0peufihLE+L83uzQaOskQIphr9v/giXZ6l/
	sQdaBTRClmuoKP0j00Qly7uS+iFFqS1kiNbc8nbSiQ4PNONnDkhSJ2Dt8T2/aa+bCPTIsmc1F9a+A
	MLkFifBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmuL0-000q1L-5K; Tue, 16 Nov 2021 09:01:10 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmuKw-000pzT-Jy
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 09:01:09 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso1320010wmr.4
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 01:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=woZZho7jnRD8mZOPJ5sPkwIB7WjBuX5d/9m/ADzN6J4=;
 b=k5jEvKCSvsHOahf+LNvhpOUVV1g5bF3uECBgLdhvLYHbcU3bY8o9ADtICmsMvILgHQ
 fjiSlbSJg20bRpUoBZoHkpYp1C/kyvAqmnHLtwTgLgArgok23R+owl/uIYbc3Z1Ktb2s
 u6lbF2iDrOv62W7d2DJ5jKImvr/A3tdusD8PUOdSfBdBLy+Zx6V8aIpyRIxToQ1a25Tt
 UcenraunJGmohK6ZyreMREhFSy/Ts8pdxjcG7lVPL5EKpancaevQMSfVdmmikEy4BUBU
 M9ol8165iRnKqMXb7T7daE3eLLZlsAF3m0VTwLksUCVZOPnOrJrRHPaS6Bzo9rUs7WMz
 ewug==
X-Gm-Message-State: AOAM532ErE+HCNUJYokFGdn6w6ztvrwC74b9Zd3Sv+lYWS6+xlibL+ck
 o3mjJZKB8EeXK0n2phB1EZk=
X-Google-Smtp-Source: ABdhPJzXDqtU+047WpfWqMD8r3blxdgx1Szk0hv6m22w2H/GOOYHREgcAY+1EWStZsMb0M5kUxDvHw==
X-Received: by 2002:a05:600c:4e07:: with SMTP id
 b7mr64516365wmq.8.1637053258491; 
 Tue, 16 Nov 2021 01:00:58 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id c79sm1727273wme.43.2021.11.16.01.00.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 01:00:58 -0800 (PST)
Subject: Re: [PATCH V2 1/3] nvmet-tcp: add an helper to free the iovec
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20211115163114.48716-1-mlombard@redhat.com>
 <20211115163114.48716-2-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eaeb64d3-1c55-27c3-3f22-e8f140164902@grimberg.me>
Date: Tue, 16 Nov 2021 11:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115163114.48716-2-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_010106_690050_79B19B29 
X-CRM114-Status: GOOD (  19.47  )
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



On 11/15/21 6:31 PM, Maurizio Lombardi wrote:
> Makes the code easier to read and to debug.
> 
> Sets the freed pointers to NULL, it will be useful
> when destroying the queues to understand if the
> iovecs have been released already or not.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 84c387e4bf43..9aa81af84efa 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -166,6 +166,8 @@ static struct workqueue_struct *nvmet_tcp_wq;
>   static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd);
> +static void nvmet_tcp_unmap_pdu_iovec(struct nvmet_tcp_cmd *cmd);
>   
>   static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
>   		struct nvmet_tcp_cmd *cmd)
> @@ -297,6 +299,16 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
>   	return 0;
>   }
>   
> +static void nvmet_tcp_free_iovec(struct nvmet_tcp_cmd *cmd)

I'd call it nvmet_tcp_free_cmd_buffers maybe. It is freeing
both the data buffers, sgl vector and iovec.

