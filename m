Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D84AC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G9sVbSBtrpJrpGrm17blPxeWE7F934yVoF9UaD/wuw4=; b=fXeBdgB8HWVoWw5XmhFbpl3YQA
	gLsZzsXRUdgZvoOt+L+ZbGWB1opjS63pOFwFPgObe4B33ABxI0EM2jCUemlhqDS6uwr2xxPGAM9rb
	3Vt2ZvIwpinWbmPRfoHLyRPs9+A+3BwgU/uix1ljs14G0I7iGIUnt4mhJ0ia1sCXEDBi6tkGDZkcX
	Vt7KgROO4BcWh7UMf+Y4XYgXMBNTmWkaPRMIp5z552LhonmlWEJmhIVNPZK16cvOTebU9SogDhTLT
	OU5yPBHj7sD0Z+s5xiBt0Owz8FwjkdjYHtkE8wL7/nlW/J8UzyeaAFpYWGvuYLoSR5AVrxA9Kr2fX
	80C2TYVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScqB-003NMD-1g;
	Wed, 24 Jan 2024 12:58:51 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScq8-003NKy-2J
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 12:58:50 +0000
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c8a40371bso382877a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 04:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706101125; x=1706705925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9sVbSBtrpJrpGrm17blPxeWE7F934yVoF9UaD/wuw4=;
        b=EP8t7WZYwJCSVMDwHuzvr1wUiJ9OrhpYzBQASypFtBhchO2yKDITLd2hC5p90PgbK3
         VKMrMcl4bwtlk33hhuAvm9GQBMHJVuhNhy/U77vYiiEXHS89uyxwF48cejI7os+wk4em
         ReVKWI/B/vHcFXoabYRcvrP8J2c1VYqUMtyeHWDnGld7btydTDOQUKo5kA+uvFr6Xi4T
         3hDKTKgMfnY5YIYjSt7DzCKzwbgkXIVfFFH4zw++21BVJotqq6rP77w926qc0HA7ha8L
         RIE3dCTf1JX3qvwHJrgQWgrP1rFdRO6ZjFcheqrxXn7VpXXOLMYvLdBYhDfl4fo9dbtD
         nitg==
X-Gm-Message-State: AOJu0Yxu0g23g4iDi/z8VY7mnhLegWePMPF/0vvI6R9vOLXnQUPAczpA
	M15iEYWJD+VsdDi10fZOOSA/51pHL2UFseru5nec2K6mV/anbKW3G65taqoV
X-Google-Smtp-Source: AGHT+IFFUNING7pfsUYSFKf2gVLmXRgBOjnf1bqY5qihb0CrHchQkjfrZaODIZQbzC4pQbPy9HBkhg==
X-Received: by 2002:a17:906:3046:b0:a2e:8a6b:6904 with SMTP id d6-20020a170906304600b00a2e8a6b6904mr8356900ejd.0.1706101124832;
        Wed, 24 Jan 2024 04:58:44 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id un5-20020a170907cb8500b00a2ceaf80bcbsm13804805ejc.204.2024.01.24.04.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 04:58:44 -0800 (PST)
Message-ID: <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
Date: Wed, 24 Jan 2024 14:58:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240122145659.5574-6-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_045848_753911_9A454AD4 
X-CRM114-Status: UNSURE (   7.51  )
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


> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>   		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>   
>   	if (ctrl->queue_count > 1) {
> -		nvme_queue_scan(ctrl);
> +		nvme_queue_scan_sync(ctrl);
>   		nvme_unquiesce_io_queues(ctrl);
>   		nvme_mpath_update(ctrl);
> +		nvme_kick_requeue_lists(ctrl);
>   	}

I really don't think its a good idea to block ctrl start
like that.

