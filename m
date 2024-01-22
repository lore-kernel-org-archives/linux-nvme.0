Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381D8C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 17:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AV78cR9m2qlhfCoSuhDhh+nRWS
	y7fRk+2+Qrh6ADUwcOMxW2a3xduioPsL7Ii3B5X/FxQtbWRneIGIxGYD2Vm3S/iWzD8+LyJnthG7B
	PwY7N8pp3H2GtmiLCghvvd/cBYAiQPCPQWdWBn1GNWu8vgJIN+P1Oz5UBm2SOZsEJ364DCTm2dD4A
	kYj8W1JZyhr7RTTSeFGh8YUPmJ1f5nHrEiYajVk+egaHMmaQHG1YBRlybTxHIG2mUjQjtirrGEzPb
	bYUQYuzXW6mnLiOZPXKl23ZdXDo/jQyTUoHDBHOOr/6kekrb0Lzys0VF91tSU7sK0R1556+VI1woW
	dOiP5jgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyLm-00DKKf-0Q;
	Mon, 22 Jan 2024 17:44:46 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRyLi-00DKIB-2n
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 17:44:43 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e79299da9so567937e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jan 2024 09:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945481; x=1706550281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=b16hgChhqJDQXuMn797XVweGoxzUofJjb01jgesWQ6T8XsXdJuZxtfHqfaU6BLYdjt
         aAvtAc4cgchDknzIiBGdIDrINYdgqKHYz5ZpgjDSPltp0DM6FDGyZaGTfkDLhVwjhyb4
         OJ9aJWmge1Z+Xu0W9yalpU8gA0XagtZKdmCQpdXXuU+ljUvRQdT4sCVkQzBtvIMOBM6X
         QvoFgj5efkxS4bZHErHZwuyWYfHUixhRp6ciLMN+NjQvNmZ30onYgGe3fo0GiTM+fWg+
         k3pVr4sxnnZBNrWSJKGUWPfaTS4b9dl8BuaFCCS2uqdAlNHN2M9Vp9gssrMmJCApB3Sw
         RIpA==
X-Gm-Message-State: AOJu0YxN2IOVe85lDiFZu043eOkbumazTS0u5nWwo7dVnvZ65clTiwKE
	Gdax2T7qu1tecvQGDyo2wDohlV15sTJvU82mzM7LYDWNGr1JVaMW
X-Google-Smtp-Source: AGHT+IFlxMM52+DewtXcm4pTht5ik0QU+l58zaSOxFS5aRUZBX+r+l4NQbKU/PxV7PzaMq2MN70vGg==
X-Received: by 2002:a19:ca45:0:b0:50e:337b:f316 with SMTP id h5-20020a19ca45000000b0050e337bf316mr3836426lfj.1.1705945480765;
        Mon, 22 Jan 2024 09:44:40 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040e4733aecbsm39744487wmq.15.2024.01.22.09.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:44:40 -0800 (PST)
Message-ID: <2d86f3cf-055a-4c04-b11e-98326024d76b@grimberg.me>
Date: Mon, 22 Jan 2024 19:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] nvmet-rdma: set max_queue_size for RDMA transport
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-9-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240104092549.25721-9-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_094442_902803_54DF69B7 
X-CRM114-Status: UNSURE (   4.81  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

