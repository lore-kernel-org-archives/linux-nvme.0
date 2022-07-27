Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FEAC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLvvCmY980ke3qXwdBWhEivVQbQmf48lkfZgSdFBdCc=; b=YVobpDoDneZEV6AAfGQRqs46QF
	zZhpmmyMtRwsCHUiJQXkAA3vh0OWj2J3lw7AsHiWa3QVEWbhd7iP12IoMYqe0rzSSqeKGd8a+XaEV
	2zqbHjRGQxYZer/nTCvmWnQOHrlH5Y/dqF+uAqe5RbuC4u9gwjxfcvsXB2mxqOxS1O5NoEQU9xztA
	PaJ1gd8cWCCDOn4N7jS+8YZtjQBpOH5VoFzoyiC6L5MsSQlYfcxKe2wVdgOi9pCKOW8TGh/ENZeoP
	wCM0qBheviDnG+SN/2k9JYew4+7z9sXCHeG45j8GxM6unW7S/AoSgjJWzMqIBf/b/GXCVJ+lwHQMZ
	JmSYOwjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjWy-00FLCT-SS; Wed, 27 Jul 2022 16:05:04 +0000
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjWv-00FL92-Mf
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:05:03 +0000
Received: by mail-il1-x12c.google.com with SMTP id r6so377202ilc.12
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 09:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FLvvCmY980ke3qXwdBWhEivVQbQmf48lkfZgSdFBdCc=;
        b=7T4QUrjL05HMgFQZwAeL7dZUImdN4NAYuVkD8S614ZkwSekLpzJ82NCCnrNJdaM6m4
         jdYIUJOo4yc8wouK5YV/7AO71+FNXRkFXndzF9xBKsoHQsNrLDE+9WdEAgtTGapNZJ98
         bzR6TdHYOrng147HgqShbNU/6YStn93aYN0wMJvWp5Dn8L/yQXlOcjjPwgThxhhak0wX
         cicXNtG7LZwMqi2TgFGiZtm9yw+jBFppQrEk/iAj3ZodQWKg9VstMabqaRwZMieKsgdP
         b+RNu4ymgJEFL+p56S205Did6Yr9rx2OPyPoBfazQByKTYtY9NQT3hCBPhi4UMdE5lfR
         2SXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FLvvCmY980ke3qXwdBWhEivVQbQmf48lkfZgSdFBdCc=;
        b=RzDQ4pO3okbnvXwF5Gy9MaCqd0IsCNd1nmW4CND1voUWayQU9pFbsBH1al+0Ue2ffH
         kE5ihhhtmJbnzJWlaa7b5IvAPNZOpRyxFy2f50DmR7pecqO6r4qHua/S9q8XH+HC31Lk
         qr9w8uaXudl2MGA8XfTtQ2+3cJE8jywCe2JM8or13vH4tYXl4h2ci+/8m8UX81CUsh9f
         WDGa6G7XfjhkMF0IFQpLOgls715Bx4KzHfryUlYy290ZSZe3MsSXeuYKhuJOkehU2LE+
         f6zwVS9uVxFiESr8EzyJVnmBFRshaSYOByqrGwZv0W3uchiu4C86Odkx1MK8++qSst2t
         MowA==
X-Gm-Message-State: AJIora/Wf14G5k2FSV1LmlP/Bee/IoGmDzQjurIWGFHcEPQrAr85cA+X
	cgmIMZeFEwnsZXlZKyTGcZS1QQ==
X-Google-Smtp-Source: AGRyM1vDTLyoJ4cgfiftHv/tnoo9CIEYn/60l1ilMS9uAYdCf4K0AbP+qQCVqlkA5UuQXONT+uf9Og==
X-Received: by 2002:a92:b08:0:b0:2dd:af17:f72d with SMTP id b8-20020a920b08000000b002ddaf17f72dmr2722554ilf.196.1658937898884;
        Wed, 27 Jul 2022 09:04:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m13-20020a026a4d000000b0034161ed8fadsm8007093jaf.150.2022.07.27.09.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:04:58 -0700 (PDT)
Message-ID: <db5b57db-d395-5ea9-8708-845a09ab4c7f@kernel.dk>
Date: Wed, 27 Jul 2022 10:04:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fix for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YuFftyWcAMRP/NC5@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YuFftyWcAMRP/NC5@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_090501_757245_93676B43 
X-CRM114-Status: UNSURE (   9.39  )
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

On 7/27/22 9:54 AM, Christoph Hellwig wrote:
> The following changes since commit 82e094f7bd988c02df27f8c8d81af8f750660b2a:
> 
>   Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-27

Pulled, thanks.

-- 
Jens Axboe


