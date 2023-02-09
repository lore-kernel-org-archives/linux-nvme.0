Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BEAC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PDb/mD0FNcuvevCtgRwjkKj+UfK+Lh+rlPz9oXE0/s=; b=pjgVyqEjirXU4j7bN4Wza8kjGU
	L52SCj6mdB5BmR6RquCNW6yO2ZVMLboFudmK2CACQDqUSYg4G1nOPW6ewx+oQDjWF4Oih+bISrbO1
	NsRB664mb3XThPuU3uU23CLJA8o84/qnsQL57KiYXSITbuAFNdBbdagE/1aErwPSHBRn4ca96l3L1
	FqtssXIIRWcN264wrbjrT+33yGCH09yiElU9yfakpjMUQxYl+jH61L4MUCRYMOESHLpW6bIIr1vwU
	1qJkIiddRulG0W8jsqWF/V88WEO6tP36tLCOtRgsu6BZGEFKQsblgX3yPp8pWKYKD8IM868sI4QTS
	igHX+kkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ8bE-0027kz-Ct; Thu, 09 Feb 2023 15:12:36 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ8b9-0027ic-Ng
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 15:12:34 +0000
Received: by mail-pj1-x1029.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so6550679pjq.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Feb 2023 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PDb/mD0FNcuvevCtgRwjkKj+UfK+Lh+rlPz9oXE0/s=;
        b=vLNKvMiy5n65JggsJYN5SAT5Mnwr2BIypMeL0NGLQkhSzBiL5FT37klJ85/bdysSYq
         8FBwnhmn6VF/Qjrf0v8i7zoC0U/DXfWvz+HwV+7lZySswUYZynnSsiWYOKr+cnMcH7iO
         BiSEQjvwvHYAVc/sQMJ1cQlBXmlqLPdFgxoYv9lV6pFF4PZXK3j+8g60qVIYNDO0cKZ/
         PPO+MJl71h/JgzU8AxTEkFguunRkIkiTQ/zhMUZ/JVpvGl0nxZFPvPahDagXs2k0vodU
         gBfh3AW2GHZiRcIZ30JYrofz5teupArrO8v5Y/eQENUprngvIV9ZbO/hYQ0B96UGacfQ
         br4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PDb/mD0FNcuvevCtgRwjkKj+UfK+Lh+rlPz9oXE0/s=;
        b=1kx3P3dXynOY5qQRZz447V/gMiSNyJdq1zCcwRhBzw2NGBE8J4ycQceCcNh8gDUeZl
         BlJN9WZY5w6PiiJqdHHQSrkM/99JWqYoMG7O2Qt113yvJsTcyIIAUvv5EybDXr+dIL5f
         ePnjFvFZD5egCm8kzSC99Gwy41ohzSEjFlOWEKEQGrYtdHvEAoElYKP81CP7uqOs610/
         2vevWAXhyNrUWRi1qlciCJAW/tnPtEQuIfRdYSckdkUZ5uAsO2PvOXZWMAZlLWy2HWQF
         iJ/jT3r432IjTm4oyGd/9vnyN4anuDN9K+bjU/HYx327jHw7nV02fmwvpxyyoQicONv/
         zbRg==
X-Gm-Message-State: AO0yUKVb6M32iBcJ6Jv8XFBsYzqSUagLzHNZT+5ESQiOSlKUWKzSU18q
	B2Sml/juCiXIN7VzhE9mmvhdLw==
X-Google-Smtp-Source: AK7set/Hp3peKbU9cWTP3s475Gtd1sd1IlOQINVNvjhBZ08vSzPAfn4wRTyIrfsIK67VvLsCOx9V4g==
X-Received: by 2002:a17:902:680b:b0:199:3f82:ef62 with SMTP id h11-20020a170902680b00b001993f82ef62mr7912671plk.5.1675955549810;
        Thu, 09 Feb 2023 07:12:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001991e4e0bdcsm1593336pls.233.2023.02.09.07.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:12:29 -0800 (PST)
Message-ID: <d3529d65-f505-a76a-7f3c-db1d8d2578a3@kernel.dk>
Date: Thu, 9 Feb 2023 08:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y+SAN97vxJtL/l4G@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+SAN97vxJtL/l4G@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_071232_024557_0C9DBF75 
X-CRM114-Status: GOOD (  12.12  )
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

On 2/8/23 10:10 PM, Christoph Hellwig wrote:
> The following changes since commit e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:
> 
>   Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-09
> 
> for you to fetch changes up to 70daa5c8f001e351af174c40ac21eb0a25600483:
> 
>   nvme-auth: mark nvme_auth_wq static (2023-02-08 07:28:16 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - fix a static checker warning for a variable introduces in the last
>    pull request (Tom Rix)

Pulled, thanks.

-- 
Jens Axboe



