Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEDFC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 08:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7mac4GHjl99eXA8LNnAtC8T6tPnDlc0EwNfk7/4lGSk=; b=o462a6RBejTObIW3E9icANP6CB
	gW+Ri5GEBcoOfmzCesexOzQkNPb7VvYst450tcF8+g5FXxJmr19yRp5oik7cznZ6zNSPXJVu24I+n
	mk2RsKkCna7nEYVWrHYryxekG83qGLaQ2M2fajaBNChsxNgC/7Y4/afq0M0B9dfF4SCCnRVD4U3Ro
	BT8O0teLoFSHDoc2mBz0OTbQcTTDijH0jfjHSsnmv/rrXXKloTQRRZknqvlg7JXIhYqnWri0n88Rb
	yjWXHe4aLRIR2AyB32g4Ay024eEL6MUUkFQvL0QBKsvaXSlnwcHZr8v1W5d5YZGel1eW5y2PsBlOM
	4fr7aKdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO1A-00000005vGg-3jmV;
	Wed, 26 Jun 2024 08:28:40 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMO17-00000005vFV-18qb
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 08:28:39 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4212b102935so5726575e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jun 2024 01:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719390515; x=1719995315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mac4GHjl99eXA8LNnAtC8T6tPnDlc0EwNfk7/4lGSk=;
        b=FqxTN3cPBELKnskKawbdqu6P/XCxYji4mdRuajQK3KvNtypW0TqOrv0PfkuHijpvOf
         hU60vFgkKzpew25hUMXEA1v8hOUuom6NwRT/HxX2CxDjayT3J4QaDdM/LC61I8kUvzLO
         jXrYRxxtjKMXqT2+FLBk9xs5MPNk0OA3wRhq/0Fgz1TtcEL5d1GS6qQlLCopGPJKqit4
         iV09HEwqcamZznTOy9XEsUyUblhdBhhTEgaDGfugZH4VFInA88ddT4cdB0fmwoOGEuR1
         DE+u9kp7sai0Pm0YzOvE/hIM8b59TXocIgkuh0g+K1EzjNeGF3ZHUCDKC59+pJNGxfM9
         /9dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs8zJmfPLulV8af1+9c8JUpnmC0fayn5A5s/RYNCrRp04lBBgHwpWXt9Q6o8cyqjrgECFSpuqztPBoBEf+hea9QE76t/A4jbsRbMLiGdA=
X-Gm-Message-State: AOJu0YwZFjChlUaep9sWBiH8ahsjJ9UdCkh9bXZ2ykmSz7SA92Xb/hwG
	sCgAXCi/YL1CBj6ooEVv+4Au9pV152MhcPTXP89hHaoqe2DyQOj7
X-Google-Smtp-Source: AGHT+IFmpLh2xb+YachKHHeAma7YS7RzOJvzpkkrQz2BdKIrha1s8iaFNwoIE3eoS3Wxn8MelxGKWQ==
X-Received: by 2002:a05:600c:3b88:b0:424:8c1b:f873 with SMTP id 5b1f17b1804b1-4248e3fe70emr68259195e9.4.1719390515230;
        Wed, 26 Jun 2024 01:28:35 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424bb91c9d3sm16981945e9.0.2024.06.26.01.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 01:28:34 -0700 (PDT)
Message-ID: <cdf73c47-ec71-4c8f-a127-891d7215bf4f@grimberg.me>
Date: Wed, 26 Jun 2024 11:28:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] nvme-fc: fix race with connectivity loss with
 nvme_fc_create_association
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20240611190647.11856-1-dwagner@suse.de>
 <20240611190647.11856-3-dwagner@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240611190647.11856-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_012838_720039_EE93CC77 
X-CRM114-Status: GOOD (  23.05  )
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



On 11/06/2024 22:06, Daniel Wagner wrote:
> We are racing with nvme_fc_create_association here. We wouldn't have to
> do anything in nvme_fc_ctrl_connectivity_loss IF
> nvme_fc_create_association would reliable detect that the setup failed.
> In reality, nvme_fc_create_association is able to return success even
> though some of the operation fail during the setup (and this is even on
> purpose):
>
>   nvme nvme10: NVME-FC{10}: create association : ...
>   nvme nvme10: NVME-FC{10}: controller connectivity lost. Awaiting Reconnect
>   nvme nvme10: queue_size 128 > ctrl maxcmd 32, reducing to maxcmd
>   nvme nvme10: Could not set queue count (880)
>   nvme nvme10: Failed to configure AEN (cfg 900)
>   nvme nvme10: NVME-FC{10}: controller connect complete
>
> Thus we transition to the CONNECTED state and don't start the reconnect
> loop. Thus we should unconditionally schedule a reset.
>
> If a reset has already been schedule it's either a no-op or we observe
> back to back reset. But we can't really distinguish between host side
> double scheduled reset work or a connectivity loss event right after a
> reset. Thus we have to live with this corner case. The system will enter
> the correct state eventually.
>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6ff28d59b169..10dc456928a2 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -169,6 +169,7 @@ struct nvme_fc_ctrl {
>   
>   	struct work_struct	ioerr_work;
>   	struct delayed_work	connect_work;
> +	struct work_struct	fc_reset_work;
>   
>   	struct kref		ref;
>   	unsigned long		flags;
> @@ -779,6 +780,14 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
>   	return 0;
>   }
>   
> +static void nvme_fc_defer_reset_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *ctrl =
> +		container_of(work, struct nvme_fc_ctrl, fc_reset_work);
> +
> +	nvme_reset_ctrl(&ctrl->ctrl);
> +}

I'm not entirely sure I understand what you're trying to solve here,
but scheduling a work that in turn schedules a work looks bogus.

