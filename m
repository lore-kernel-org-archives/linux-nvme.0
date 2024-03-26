Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43ECC54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKy0ytBoBvxsuuzIrTgcghJljKr7UqN/RXzToToyWvg=; b=rcyq9bU8nTcAcoMbfByikqjWMz
	aCE2XVlWb2BNGOubCSI3BjG4OtF1myfOwpljDN9QJMl5Bz9JZelEhIq31ErvCVza5nm9RjWoBPhS1
	mK9cTx4//QzhorcZ48rhRXTbuzsCbX9fQECO0a3WGnO172BoN1wgcN9BfybiDhsTBTBfAVli8fz1y
	VoFY55XzHipAJJLd7CpFL1prdI1Kqcn9GcBqkllr6QQIatShWY6SVR0YRagusyq/VSXfNeF9GI9bn
	f5/HhxGJ3exp1cFUKX56gLSSDt7KR0KKCNCiClnMcKW84U8V+NoBahbY0Fn030qU+9+ZpPJCJODbC
	+GAHxgJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp23N-00000003a8x-1suF;
	Tue, 26 Mar 2024 08:21:05 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp23I-00000003a7z-38pc
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 08:21:01 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ecdffd9e7so1011238f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 01:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711441259; x=1712046059;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKy0ytBoBvxsuuzIrTgcghJljKr7UqN/RXzToToyWvg=;
        b=Afdl42A7YuAmvGPFvtKK5WyYmXYMctc6C4g+lJyrNAiCq3MNpPHQJbQWmBRQa89H3G
         lEskuXcFmVc4PF+L2XgqrQ2uqQKUuhFVRZSougi/i5Wz8iRWkBE1JSnWB/PkqXv3r0Nn
         oVTPyJCIajO35MuOw8RZ76YXnpaaWxHxoD6wk8qJSlocJ2GRmgX4YHLZLFzjMJXD2zHS
         Tu21ci3mKRnYuYBUJJp673ZS2HJkXiCoRU6ZFR4lNKjDBmZyTnAZZSdW//wGyqJ4L0jy
         qISrhrm5NTu3nS3zWR6sno0inrYj/Ic+LD8Hcf86vfqOngGFSIhXGUg50NoarXJrl2Ed
         U4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCW7eqIERm55JXAvI6dDfl6yQ03oUUpZ1VWi+PTb+6Jq1qpB2GzvXRKkz6dgn/lPYih6Bo1bUmJmdSlJHhQeb5X8BLYAKqHdWa7Q2q/edHk=
X-Gm-Message-State: AOJu0YwezM4hnBpFPz8xKG5KUb4ViFyY6j/PReQCp5KZ4D2+1kl5ZAk3
	F6MJS55iJVL+ixax0uiRWAnRbQ1ZeCYpm+tjhA1CuNpxOCt/q4PHb/LsPu69
X-Google-Smtp-Source: AGHT+IElORtNTntZSRjJfbNopFvBiFBpe4gUqCHHiV5dKFSi2AlxPNvAeyw803h9+KS8tqSPjmRiQQ==
X-Received: by 2002:a05:600c:1d06:b0:414:8fd8:3a10 with SMTP id l6-20020a05600c1d0600b004148fd83a10mr401029wms.3.1711441258692;
        Tue, 26 Mar 2024 01:20:58 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id o32-20020a05600c512000b004148a5e3188sm4718474wms.25.2024.03.26.01.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:20:58 -0700 (PDT)
Message-ID: <b7eb8b26-70bd-438f-90c6-e8165440be5a@grimberg.me>
Date: Tue, 26 Mar 2024 10:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
Content-Language: he-IL, en-US
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
References: <20240325154503.11510-1-ikegami.t@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240325154503.11510-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_012100_809530_E90E3B5B 
X-CRM114-Status: UNSURE (   7.84  )
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



On 25/03/2024 17:45, Tokunori Ikegami wrote:
> Currently nvme_identify_ns() sets the data to NULL if failed.

Where? Nothing sets id to NULL in nvme_identify_n(), what am I missing?
> Also the data is not freed if the function returned failure.

Where? I think you may be looking at a different code base?

--
int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
                         struct nvme_id_ns **id)
{
         ....
         error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
         if (error) {
                 dev_warn(ctrl->device, "Identify namespace failed 
(%d)\n", error);
                 kfree(*id);
         }
         return error;
}

I don't see how this patch makes sense...

