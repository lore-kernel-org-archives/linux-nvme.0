Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CE5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A8160E08
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36A8160E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mY3HvuFU72gU+bQvqx24tiZDFRftGXRiQe3j8AwoXVg=; b=A3OhV/A/JtFK5TAsFiZkA6Xidj
	sHBzc8VupG76dSIPcus4WaYca3xbxKWH1ZVjJAviXSF5PUK7/Lu5d2xmNkNDgU8W3L3HvhxzcQCMI
	pzb1GEMSJ96Gfj9ahUSGF60UV6u0yh3VY/K1g8xTmjlFOhJHUTTERgq3Xze0HsEE4TjJZHLFRWNsr
	pxzKTvwIyO/0jyWGEDvtXbJUcuLoFy+L7JOWTn56YYU8GuJzfEdkkwOw3Xoi7zPzzFtEAp1Frx0JW
	JAgrkGgbQTn6RSLVHIrD9+M6Frs+mHdzZhGG0qESFxKUlAR4ioh3ii6d2llA3tt63DmMQg1PpjMc2
	WrkA/MGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi3zg-003cNW-T9; Wed, 03 Nov 2021 00:19:08 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi3ze-003cMn-3k
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:19:07 +0000
Received: by mail-pf1-x430.google.com with SMTP id g11so578621pfv.7
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=mY3HvuFU72gU+bQvqx24tiZDFRftGXRiQe3j8AwoXVg=;
 b=ZdgqtWQ3GkIClgJF9Jb1KjVCQ/t9a18ZoBgS/MNow/ChTuILeA2jADiOcIeT3Nh+mf
 PDcr8Xv/p4zr3YeFhVhhjBgy27TxaZISAjCBPG4qI8V61cRNG1RlapkbVMMeWnDoiGVV
 kAIHFdHjyfhS+I2Dg7xpOyIHW7k4b1wzs7TuRJe+CJVcGE5wRqRMhJY2pQ/Vq03dMdmQ
 qPhoqyXjGUDwl6XT2kYZHF7fjrX7H4urzr5WCZ5LGLy6Sviw87FNkJOOC2cSqTgKc4TM
 yzY9rZSDh42mBOaJ6nGwD4I6iQZuMgEh8O/cVLwNvsJYpYuAspkslhE/iiqedoglrseb
 4JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=mY3HvuFU72gU+bQvqx24tiZDFRftGXRiQe3j8AwoXVg=;
 b=mp/lCeoQJkYqjYI/wVWR1fo6DfNntcZ9el0G7QC6kACfW8tCrAw+UfyLLHtFcbSMoF
 TYOenZGMsxSz6VomTyayoKTY22RQx+4EwmeXU+jMUCdIN9T1qjj9bQlq/CqpLP4Ukbvm
 twxxUrJXbqPqYxJ/UkaV0OAdhm7iDm9R3jEzg93GDXNKMEb5WZmBYucVKgeBQYMLoa9d
 gcCFW9VLyb8ozFxpaFzOqnCTUp0eEdtKnEI4ymuXi2PAvdWJPbnidtfymx+RC7QPJBxO
 cOvjonqnqLn4YYu9l5MsbLdi70SP08Bw3I2MRsJOta918cQQcG1dGeJzAe+fpv01/qJc
 VXnw==
X-Gm-Message-State: AOAM533DPiL8Rs9JRecyhKed/YWrRvKYC+nd1CjFfdYlc8o7QKKbKyx0
 UHXwZlQRSbfitFdi85WAHak=
X-Google-Smtp-Source: ABdhPJy3QxBmOES+KKXkt0kWFc/A+cESDR0YWBzAwa66okmhmzA/8lVJY2RDQyiYOP6/M7PvcqijBg==
X-Received: by 2002:a62:ab09:0:b0:48c:2ee2:7dbb with SMTP id
 p9-20020a62ab09000000b0048c2ee27dbbmr2798858pff.10.1635898745101; 
 Tue, 02 Nov 2021 17:19:05 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h15sm280250pfv.212.2021.11.02.17.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 17:19:04 -0700 (PDT)
Message-ID: <f5d6baad-72de-aee9-ffd5-8c0ea51afc7c@gmail.com>
Date: Tue, 2 Nov 2021 17:19:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 07/10] nvme-fabrics: add nvmf_init_ctrl/nvmf_uninit_ctrl
 API
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-8-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-8-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_171906_188133_A90A0C94 
X-CRM114-Status: GOOD (  10.40  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> Centralize the initalization and un-initialization of fabrics specific
> settings. For now, only used by RDMA and TCP fabric transports.
> 
> Also, convert the reconnect_work and error_recovery_work to be static
> functions since they are not used outside the fabrics driver anymore.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 20 ++++++++++++++++----
>   drivers/nvme/host/fabrics.h |  4 ++--
>   drivers/nvme/host/rdma.c    |  7 ++-----
>   drivers/nvme/host/tcp.c     |  7 ++-----
>   4 files changed, 22 insertions(+), 16 deletions(-)
> 

Looks fine...

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


