Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C9EEB2700
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTHbTUA8gqoLAorCfcF3d9LhgsN8Y1afMEZg2UqN9SQ=; b=EjZRJ+bII8+B7GvXSjhDGXnfuQ
	Ot2gJTVzjkJPczsSLNdK1l0nKg0hjCQmkSLJFhTylk58eN50SmbMVOJmCMuiQ0ng90OSNgK5ApCMT
	l5cbYfdzhZ47zdi9zJM5doJlQrkLDqOWI8jDnhz3v7I1isuFDo1arLqQljvXC1CHbvuhs42YOk8Fp
	flhg9P9rNyKklGPpMkvghe0IcT2WHdHRFBAoFuzofGXa2Vd1Z2rV1LRqlyST9oZMcOIYuFsC0hwor
	OjtSs3+cgE8GbRzQrOZFbJpkm6mwm1Mc4l0eG0O53XYVXZ8L0v8NPwSaoFKJn/Kq1Ren6+dsOBdEx
	leLtPs1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpvyA-0000000HY2m-1cBy;
	Tue, 10 Feb 2026 22:12:30 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpvy7-0000000HY25-3L66
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 22:12:28 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-124afd03fd1so6928295c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 14:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770761547; x=1771366347; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTHbTUA8gqoLAorCfcF3d9LhgsN8Y1afMEZg2UqN9SQ=;
        b=kk0oSPtlUBxBv6ISqRNxyjPXtTk3MCGItgrltbC+XxlgehsjnjBVu9MFy7TmlFdYqd
         OIDwLVenjXiTTh7uk7T9S2YdWh/YMpy0/NROU+rJVE9hoEMMFuFlCsRfbXjp0HkDghUo
         3Z4pwiXEiggCvvJs2Wt1ydJQN3xUTZAe9TqmfgFOn94YTZEgNYDhSmYXmr8e7IcOWUc7
         wUBf3RFo3wZ5hXKnENS8DVXDk1FbH2Wqxm+8b1nrCphi/mc8er/XiO8r49uARQQtb0L2
         QxNb3NLZk8cs1GusIttgNufogFL9uSRuCheGc1jwystS+7wT41ggBLcJS2S5SChdhLbF
         aWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770761547; x=1771366347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTHbTUA8gqoLAorCfcF3d9LhgsN8Y1afMEZg2UqN9SQ=;
        b=K91y1hG7jMW5xJSjWilwvju8tiPMZ3wwPwp7QRMDi0+GzI8Y7YvvZ0h9G61FAlO2lv
         /lKneTbfcwMiK09SQmumjDnpSbHkga/Ak6zq1dMJyWaEH+/yRmUoICsqrN9+fMGmpCte
         4vi5xi3PU1SRQqN3ueRdvG5V0K7osSnfU7Yg3D7NHM9ieSIEN5nQ5utbBsLhQt0x1NyW
         JIPB8IDlb7ttq8UtjWuQjS/tjcfssxvhDz3L+U/v4xX1qQ5jUsG+788EXQHZ4XIabyC0
         UvkjeiHAk+0BKWMuuAY8UOC6EiBOL1AuBDLoXk6bpbSWbBGkkoseEgAVzJYVcZCmSTIS
         Knog==
X-Forwarded-Encrypted: i=1; AJvYcCVil2fS0vmOLM0BustrfVdTNYezy+MjRWcKCWUYTCqGRRl3j5EYGRqk5HLA+lA/3FbEOVQ1BMCXWQbk@lists.infradead.org
X-Gm-Message-State: AOJu0Yw66A96HKvp/hGiM2X3d6AYxpFv40dbBNt5rnIVZs7HCk07nLuo
	ColJHZTw7sFkjrggfh4MkSh7oP1HL9BNbovovCLpv1zJJlfu7QufqOe8
X-Gm-Gg: AZuq6aKsDte9PFrQQKvt0fZELxZiW9SyAeqPBnVTV5VlQaDkupYuxeVGCNAI1IuQjTS
	R8TAWchqcOOF6MO2hYUsMl0LzAwBIbgcV7E+VFW7CsystpoB80kty81dibZ4BCvwxXFJqplEMzh
	8ld6bj3y4aP62c/6+iGB800IAJzVpfpzo0Sy1s7ITcGN9DYqvrAS9VvugiGfPWdlAZPfHonlTyQ
	ilGqjKVbnjWJoRIBMSXES4dlg19cz6f2A4Z1DExl7LSpn7hqMmN1H9h8UnE7ccF+jGdrlDOuqCH
	LVhwOIVpRFUg6NuaMYYG6fCHTAduxJ5MCbq2odueV9JYsNMUGM5b866zm2RQmCPfrqbS5kJbHNa
	YkRZ9+paKFl6Lr/eR9hQTNQNoLFHMTdsLpkXV4aR7QesxE/y+MDC1vwdUbMtjDP+VzzS/Whbv3S
	N+xeeBjLLt/OzmWkwEX45XvdnFqacHvfc/Tt+q7PAv+Cs=
X-Received: by 2002:a05:7022:521:b0:11b:9b9f:427a with SMTP id a92af1059eb24-127299516admr299212c88.21.1770761546718;
        Tue, 10 Feb 2026 14:12:26 -0800 (PST)
Received: from [10.69.50.72] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270433abdfsm12369438c88.12.2026.02.10.14.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 14:12:26 -0800 (PST)
Message-ID: <864e0ce2-4fa0-4d89-aaaa-a552977781a3@gmail.com>
Date: Tue, 10 Feb 2026 14:12:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] nvme-fc: Use CCR to recover controller that hits
 an error
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jsmart833426@gmail.com
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-14-mkhalfella@purestorage.com>
Content-Language: en-US
From: James Smart <jsmart833426@gmail.com>
In-Reply-To: <20260130223531.2478849-14-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_141227_839084_56B1F4CC 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

On 1/30/2026 2:34 PM, Mohamed Khalfella wrote:
> +static void nvme_fc_fenced_work(struct work_struct *work)
> +{
> +	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
> +			struct nvme_fc_ctrl, fenced_work);
> +	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
> +
> +	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
> +	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
> +}

I'm not a fan of 1, maybe 2, state changes that may silently fail. Some 
trace message would be worthwhile to state fencing cancelled/ended.

-- james


