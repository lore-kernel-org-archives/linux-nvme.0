Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38018C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5xG7fHkgrGR5tgOHafwG7T4K3Ym7sMnppLoHfjyBVs=; b=cNBmwLHExof0415KjoYz005Y4x
	CdQsudl58YUEiB4mknL7TVSGJqQ7CovG5seuQ6l9Ij07afThOzS1gjfWyh0wJeUidEaBZ6IQI/Hm5
	KsOqBYbDwrTDE0TF59Iv47qKWZnSgO6pLh5GDIXGXDa2cSjmOFdPpfQJl/Ud7QeORgXouxJN25RoV
	WHxvWmWmRMdJ9ncJRHlm9f5x1hLfTB7Mex8jAQ7c+jdK964vyiGsWpQPEXuZRvxof6fesre52oNBa
	d82YYirWC4Ic86frxF2FKEjEpUd+KWmIl54uX2UBtedAUyxqFK7uWD0xVahyTb4fByS9B6gp7huNx
	hSUtCrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAAm-00000003siv-0Uld;
	Thu, 07 Mar 2024 09:36:20 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riAAi-00000003shV-46oj
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:36:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e4ff2e95fso117528f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709804175; x=1710408975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5xG7fHkgrGR5tgOHafwG7T4K3Ym7sMnppLoHfjyBVs=;
        b=R34QZwv4iydpy5/z/ybQv6jS5jmyzrHO3HLncndorzAqZc12Xm2oSFLzWK7iuFYmMV
         kAtN5gJzNWKQquR4lU2SmvmrRlsiuY9E5sYx4h5lMLi7FarabWTVYgPxB2Ov8/mfkPmi
         MhnfdYlajyQsq4nzwyL2iuAI5FWZCP1j+Jmt9bFpuc30GNo59KM+clGiF4/McRwrXfBs
         GFzZVMa1eVUIcUldFF4vzFGlpA2LJCKkLuCEm68Oian6v7BtwYagHSfcFPcuDjvfal+D
         aeEURhPB9CxD0ReQYHRjZR/JkdginsyXpICTm5PB/fqhi9KGEXVn0Pd8mrtpHuEvHgV2
         qI2w==
X-Gm-Message-State: AOJu0YwWgtL7Bx/ih7b4cGDGrFnQzzSD6kRQq3Dkof3TR7yjwkadGt0l
	qFmvzA8jiJXEtLfeXGIeqRLJJy+w+jZQF9zGZJtX5ZutZxkZJUBB
X-Google-Smtp-Source: AGHT+IER5fyyCEGeRHzEBz5P6KXRMAXSoOMMr+MyscX0gh0YKIWcM9CMf7/EyUieT8NaEzsi8E5+RA==
X-Received: by 2002:adf:e883:0:b0:33d:9e15:12bf with SMTP id d3-20020adfe883000000b0033d9e1512bfmr4090018wrm.3.1709804175143;
        Thu, 07 Mar 2024 01:36:15 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm7451170wry.66.2024.03.07.01.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:36:14 -0800 (PST)
Message-ID: <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
Date: Thu, 7 Mar 2024 11:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix reconnection fail due to reserved tag
 allocation
Content-Language: en-US
To: "brookxu.cn" <brookxu.cn@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240228091417.40110-1-brookxu.cn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228091417.40110-1-brookxu.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_013617_062411_FC6D3CED 
X-CRM114-Status: GOOD (  14.46  )
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



On 28/02/2024 11:14, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
>
> We found a issue on production environment while using NVMe
> over RDMA, admin_q reconnect failed forever while remote
> target and network is ok. After dig into it, we found it
> may caused by a ABBA deadlock due to tag allocation. In my
> case, the tag was hold by a keep alive request waiting
> inside admin_q, as we quiesced admin_q while reset ctrl,
> so the request maked as idle and will not process before
> reset success. As fabric_q shares tagset with admin_q,
> while reconnect remote target, we need a tag for connect
> command, but the only one reserved tag was held by keep
> alive command which waiting inside admin_q. As a result,
> we failed to reconnect admin_q forever.
>
> In order to workaround this issue, I think we should not
> retry keep alive request while controller reconnecting,
> as we have stopped keep alive while resetting controller,
> and will start it again while init finish, so it maybe ok
> to drop it.

This is the wrong fix.
First we should note that this is a regression caused by:
ed01fee283a0 ("nvme-fabrics: only reserve a single tag")

Then, you need to restore reserving two tags for the admin
tagset.

