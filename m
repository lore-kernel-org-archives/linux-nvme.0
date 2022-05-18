Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 12:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RKKiWskFYEO4JtJYg3y4PPO7hdCJClkCLDpQ1ZxY9IE=; b=1DmX21UkdFfk019Pd/dampRFr8
	hmGLU9OCpOKM8rGJKDcduO6CSfQhTIRIRyOgFuy4y0dXytLbcSAdVABaY3za6C8Sldq9HwmPQotrs
	qm62g2QG/5vaxEZO5m9cwjjKGclJVmh67F8pJirQixxR0uIqEZoX/FuLjpo8/2nz7OAh8LZs/xsz5
	DZ1qo4EH8iDkG4J9Og+iip1jT79MvD1U2CMH6q1wMsIH55i2ZQkQA2TKIvc8gaSYiqdUlL39mAfRG
	rytY18YTMiQUCW/izUaXHH3i6MEuO5WDEohSkkSToccuEvzFeMBAGmwthfla8XLcJy3Vs8ZsmbQ8q
	E78AoJLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrInv-0021aa-KR; Wed, 18 May 2022 12:29:27 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrInM-0021FG-29
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 12:28:53 +0000
Received: by mail-pj1-x1030.google.com with SMTP id ev18so1859606pjb.4
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=RKKiWskFYEO4JtJYg3y4PPO7hdCJClkCLDpQ1ZxY9IE=;
 b=Y/A1vUTBeIKsExnYauXIr/evTkQLOMipBRqSBbSDBFhSuULTERLwRALe4s19NvAXQQ
 4117TIqbvQmBNEoVFpuhKgKfk1woFKI2/54Mogo0XItNIGkVtT9SERSPu0TVBcAFcD8G
 IPI69QGYOSMIRcumPwOywOqIKTzkLh9IYn/jGOIugMsCXQ8TUrqiJOEi+OmzAKwyPwzX
 qwBQcaXampsct/0IAQXijOOdbtAf1Hb5y7yTLQNNePWr+737eFkOLfXmzc1626mlubLr
 CP7JmzDlq8bo1hrIpCit30BtmPpf1+P+IyPU6kTCGSV9AuqhjxhAVSELFIN/4TAsKTHh
 NpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RKKiWskFYEO4JtJYg3y4PPO7hdCJClkCLDpQ1ZxY9IE=;
 b=pGcMXc4iUQh08SijAh0XUvyjTs3CrRQvAlHgZuzG53zofx/bULqMcpT/Briqh89PpG
 SQODlRfe0H25VvpNUIbN26+obeSywChZkT/6xTXwniTXJMdfmhPHiQtDUFpEO1/UUmew
 wc/FB/2swHIuB5nXLI9oFKUFy0V3kN72/WoVwNgk5MbTq/UsY/XoClQJ7pNec54iQUUG
 lNtvN0D3cmH6Ku/DTNV4AH5KaZStVSStrqQLYRqVnA69KzH/pDbfsuJ+A1aW2cd/vUFa
 m7WJ78KjmDUYtZZiexjGSswM7V8C/POriNpr73sxMfJThWEj+wsJgF5G5x/PAfOiOWdF
 6KTA==
X-Gm-Message-State: AOAM5334BmBmfJqnnDm/w0ZWpyeeVZ0W/rFinbmfQVlXiuJV63hCiLWw
 J8keNEZA1lpGoGO4B7YiyN50sA==
X-Google-Smtp-Source: ABdhPJz61MW7jCYQilLUG+EiwA8dYn/bkzlKKTpAKcSo1M3wVYLLqNTLCMVrnqHQg8LOwFHk1Xw5jw==
X-Received: by 2002:a17:902:b18e:b0:15f:b2c:6ca with SMTP id
 s14-20020a170902b18e00b0015f0b2c06camr27066398plr.84.1652876928929; 
 Wed, 18 May 2022 05:28:48 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 64-20020a620543000000b0050dc76281e0sm1755807pff.186.2022.05.18.05.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 05:28:48 -0700 (PDT)
Message-ID: <33fcd4f2-3318-2d64-0aa1-f55fceb32bfb@kernel.dk>
Date: Wed, 18 May 2022 06:28:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoSWZoB1/38DdP4S@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_052852_149039_2B4015CF 
X-CRM114-Status: GOOD (  10.11  )
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

On 5/18/22 12:47 AM, Christoph Hellwig wrote:
> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> 
>   loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-05-18

Pulled, thanks.

-- 
Jens Axboe


