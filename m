Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D49E8FDD6
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Dec 2025 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DDTiCnZQ6smKTWnFgxriN+TfOrHRWC8abygsINgYKgg=; b=FMGcyzlBpMZ81q8rbFYcRMZMCP
	Mvyysy0QJBpZh4rOCN9RgxkJilk03gPlP9uocsKxZwZTP3Mq7OW1luit93dqua3przU003ewSB6RR
	qxAEEMfP/2EeKigga+Q2DCxs0Nao80qL6ozQ8+7YN0Em4FiJInJqRWATqErgs9CeuJfDzFnj6ZHEp
	9g2I74lrNK23m3woCCiBzV/k+C1+NyZI0NDe/gju97mHIKM2t28DzZScqt76UPWfAzZXhclbuUGd5
	rzMyT7K0g0pGCoNXMGttxF2G77LrLO7cx/l5vPF6glAEE5FFoW59uET288vv8x3Oe1UII/uUT3R17
	vt+xTlgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQmI-00000001pig-0UgU;
	Sat, 27 Dec 2025 09:40:02 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZQmF-00000001pi5-0nQe
	for linux-nvme@lists.infradead.org;
	Sat, 27 Dec 2025 09:40:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430fbb6012bso6474226f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 27 Dec 2025 01:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766828397; x=1767433197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDTiCnZQ6smKTWnFgxriN+TfOrHRWC8abygsINgYKgg=;
        b=OvugPP8LAYDPW9KmkMXQqmWpoqRvl8ySHorqxhkyaHWyp3N/MkbPC6jxdP4HKABbTp
         nEmTMC3UnaIcSzmDRVCiZ0JaenFiWt87ZT1lwy+j8dNe0ZLLTo7QIY7FfysZ11PGFoI/
         2JZtfW5/fQk6shIlRbrBr4z9tS1bWT0FG1dCceVKCucrvZ41LZ5gpk3YXw2pcigXCkqD
         rmRJR1DzZEykuPoImO/EYMbTYb+EHqBi2WneVMVC7ekv9yNUPwC0w+36LAsMTXlJE4Pv
         cJPkP6zwO8szQYinOGhRtR9b40v2hLLjaJ4oBjvdR8MQ9DRyClZkcHxhYBo9UKncHxG7
         91vA==
X-Forwarded-Encrypted: i=1; AJvYcCWn1svTpQ5C9KCAkWsS3tQYAfU58i53LF8oLNH7g+ahCMLpvswI7niMQySZoWsNw7sYbeJOunuA7IRP@lists.infradead.org
X-Gm-Message-State: AOJu0YzDSx0VdSP+rk6Vp2MAmLmUqsMO5Zmo0sf+M4oMVuVHagvaG10S
	mhJXANk3LhTAWsARZo5jFWyUjmsYq1FE9EsTUEeNi1r3kbUWjOSTIoud
X-Gm-Gg: AY/fxX6IHUqz+1lvsQgGzAsr37pP9dH8ZtV8yndYGsVf1ypRZFjXgSGmTnVGZgDDNuz
	IVFLl9ZuYRtEISsGGXASDgZHSr2GYX5/rhJ6w6QyCUDstTL8MTmCZP71T0QxJ50vb3nNIJvJN9s
	5hk7isWrGwAS+r/hXOyuPOZdrM/zzgkf+hNXUJL9lKlxU1uIL+O0W6LyMbMhCHDfceATTOma8a7
	EkKdAP/KlucVS7D44doyTVeK8VKu8CJ/zAPNH+Q85VuOdgrVmezMf1x8jLXubnuWB6WugTCaRUT
	iiA5xbdAH/N7P6LBcHXdhy67v3+HfXgKLt0ZbHARUlXGgO6Pj9u/fD/viK5BgL2BdQCYqZpfmch
	K4ZmKWTSMesWDaMEE/oDFPj3E60p8dRUNou/u/r0Gn9D1MA0zeBoAOssIjgdeqX7HwhcPn+7tyG
	v+FFLBXpFpMrb6Dt/5f+hLifEhYpHTOaKmTTfOFyCv7NI=
X-Google-Smtp-Source: AGHT+IFWvt5k1s3eZPFq10ZRlZROF3b2e7neUuaCF4JfU6JmY/DqDn/QqS9KNCg4nl5QB3USsPaAPQ==
X-Received: by 2002:a05:6000:2383:b0:42f:9f4d:a4b2 with SMTP id ffacd0b85a97d-4324e4cc3ecmr26805102f8f.19.1766828397021;
        Sat, 27 Dec 2025 01:39:57 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm50704107f8f.35.2025.12.27.01.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 01:39:56 -0800 (PST)
Message-ID: <eeab9242-6968-4d44-b765-d4876b353b62@grimberg.me>
Date: Sat, 27 Dec 2025 11:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-4-mkhalfella@purestorage.com>
 <3f2c8a9e-2e1c-4cb8-b296-8f61ab16b03a@grimberg.me>
 <20251225173342.GB8129-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251225173342.GB8129-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_013959_243130_F66B0CD2 
X-CRM114-Status: GOOD (  12.92  )
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


>>> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
>>> +{
>>> +	struct nvmet_ctrl *ictrl, *ctrl = req->sq->ctrl;
>>> +	struct nvme_command *cmd = req->cmd;
>>> +	struct nvmet_ccr *ccr, *new_ccr;
>>> +	int ccr_active, ccr_total;
>>> +	u16 cntlid, status = 0;
>>> +
>>> +	cntlid = le16_to_cpu(cmd->ccr.icid);
>>> +	if (ctrl->cntlid == cntlid) {
>>> +		req->error_loc =
>>> +			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
>>> +		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>>> +		goto out;
>>> +	}
>>> +
>>> +	ictrl = nvmet_ctrl_find_get_ccr(ctrl->subsys, ctrl->hostnqn,
>> What does the 'i' stand for?
> 'i' stands for impacted controller. Also, if you see sctrl the 's'
> stands for source controller. These terms are from TP8028.

Can you perhaps add a comment on this?

>>> +	new_ccr->ciu = cmd->ccr.ciu;
>>> +	new_ccr->icid = cntlid;
>>> +	new_ccr->ctrl = ictrl;
>>> +	list_add_tail(&new_ccr->entry, &ctrl->ccrs);
>>> +	mutex_unlock(&ctrl->lock);
>>> +
>>> +	nvmet_ctrl_fatal_error(ictrl);
>> Don't you need to wait for it to complete?
>> e.g. flush_work(&ictrl->fatal_err_work);
>>
>> Or is that done async? will need to look downstream...
> No, we do not need to wait for ictrl->fatal_err_work to complete. An AEN
> will be sent when ictrl exits. It is okay if AEN is sent before CCR
> request is completed. The initiator should expect this behavior and deal
> with it.

Yes, saw that in a later patch (didn't get to do a full review yet)

