Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870EC48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P+CWBti+xhec2I4YBp3YK16QhM5SNMxH8YTuQRDCZgU=; b=oRq7fyZhnQIi8mtwGzkKfyv/8I
	G34v33u5tcosK18hnn52jCW6Zk8dzLupU/2HR3Pig21muPxF3PGZla0hZKlzd138NmgoRoF8WaxQv
	qZORb0e0Lc8DPRG5AfsRJcbcfNYzX6omva5QXuJzq0Jyy2sTsbCFwoMDWa7vMAU/EhWu9ppIqQbMG
	Ii8Qx8FaoIGSL9dUpBEdjUw4zHfpQaDvbSdE3AluOeF2X6YoT8MNusa0PukXOlB9X431LC9ZY0Kz4
	CELLDD7vzx8xIVlyo1nMMAJEnQZW44OiDysOQECa5RxGYmnvi2EW8cFSih6SVHCzEfwmyscvX7dl1
	+oHH5COw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8j7-00000003Xi0-1VLT;
	Thu, 07 Mar 2024 08:03:41 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8j4-00000003XhU-2eHr
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:03:40 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33e4ff2e95fso99500f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798617; x=1710403417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+CWBti+xhec2I4YBp3YK16QhM5SNMxH8YTuQRDCZgU=;
        b=eZpPAg6wnnSrGDn9ZRaqPhw+FCPEhqdPp5dX1SP9v2zoJNOtAcqYyr19NP9LdyRUVN
         /Pjc6EZXjs8XO3fFDSfIcEYKLawbS8qHJhKAdJa1pvHL/A0NTbaE7xWI6bAUQ4c+DEvC
         BeVY+43PrU+6r/vd9iLyt0O5NUrviLVqUzusag6vmGS2Mr9BfJG856srg6kC7pslBWw9
         DbgwjB7eghOy7nNPSWORvzFQYVPwJgXemuBfOa+JjOTiEo41uMSTB+OURhER5NCNyyMH
         oPnTY+S4JCBxxiDSfwWOOhrdMOPTrxVX084lIbw2WpDeKmBiHpvJ6zArv6hoJxzoMluW
         W1Lw==
X-Gm-Message-State: AOJu0YxkL0B/If717jKTJE8sFu0du8lnHCK5mbI8qtvM0oW3yNmyDojl
	UaEQuMPumXs07f6vmgq752cqcFcGzXY2qlkkOMPoQffvAmA1u6kF
X-Google-Smtp-Source: AGHT+IFobunDfx0gRVzoji4aF5ul4AIqVLnO4f2Fqtlqqe+4+5xLBi1NdHwt9kwT5suzdJLSRqR4Hw==
X-Received: by 2002:a05:6000:4024:b0:33e:6a7d:41b8 with SMTP id cp36-20020a056000402400b0033e6a7d41b8mr213704wrb.5.1709798616945;
        Thu, 07 Mar 2024 00:03:36 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0033e12a67fb3sm18884841wrq.50.2024.03.07.00.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:03:36 -0800 (PST)
Message-ID: <11986ab8-0491-4e64-b503-ec1ecc440830@grimberg.me>
Date: Thu, 7 Mar 2024 10:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
References: <20240212042641.227821-1-kch@nvidia.com>
 <ZedJeFUpuogtBSd5@kbusch-mbp.mynextlight.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZedJeFUpuogtBSd5@kbusch-mbp.mynextlight.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000338_712358_FC7D25D6 
X-CRM114-Status: UNSURE (   9.98  )
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


On 05/03/2024 18:34, Keith Busch wrote:
> On Sun, Feb 11, 2024 at 08:26:40PM -0800, Chaitanya Kulkarni wrote:
>> @@ -621,6 +636,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>>   	}
>>   
>>   	if (changed) {
>> +		dev_dbg(ctrl->device, "%s %s -> %s\n", __func__,
>> +			nvme_ctrl_state_str(old_state),
>> +			nvme_ctrl_state_str(new_state));
>>   		WRITE_ONCE(ctrl->state, new_state);
>>   		wake_up_all(&ctrl->state_wq);
>>   	}
> Turing the system logs up to debug level might get you a whole lot of
> unrelated stuff. Could a new trace_event get you what you need instead?
> There's more fine grain control on those.
>

I actually think its useful here as is, dynamic debug can also turn on 
debug per function.


