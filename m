Return-Path: <SRS0=ATP1=P2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969E5C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Nov 2021 21:20:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D0E61284
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Nov 2021 21:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38D0E61284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOxRSAEdOrXagFyqm1lOCp1sO7zqGLiMqKw0bXeJJWw=; b=wHA2jUNX3erZrgTXDXbo9Y3OF9
	Er12+wdvS44LsQy9/aFU+fbL7yxViGLYjC+4OR0/elKCG+Ybuo4W0ivWY5JuVTePdrEs/iuBKDfpH
	KoBdvj5HrvmYVtkCPQACVKMQiIDYhDeTYzye1sAChjUaDPgmJkG20kAkwzMittxqRDi9D5CQ/6q+I
	hlEpmTN/KpJ5ihwNICtFObbKNGM5qTkOYMdcCone+xNwxJV3NB12p5odxpOfRaFzsPOMW19pyJV9D
	yT9Bv5xH4O5uqRdHxvmVkHdPvrGOi5oaIUb5fzrmHEkL8uhSJLH7vGV/gFcc3pAXZjebxIY2/kfyG
	HAIvRKZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mjpaI-00EwAl-Lc; Sun, 07 Nov 2021 21:20:14 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mjpaB-00Ew9d-Ke
 for linux-nvme@lists.infradead.org; Sun, 07 Nov 2021 21:20:09 +0000
Received: by mail-io1-xd30.google.com with SMTP id k22so3493888iol.13
 for <linux-nvme@lists.infradead.org>; Sun, 07 Nov 2021 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zOxRSAEdOrXagFyqm1lOCp1sO7zqGLiMqKw0bXeJJWw=;
 b=Uqwvy1WfIUYdFgdp0V3DIiFt3IRdc+TcvOHSTfQ6XLL6SyxbOEN2Hrz2woauXeIieD
 h/PvpnxWuVQDz8HZXCbBsnhxAjvI8P8K7gnLRzQ/sjJW14y3Gj7LWLEhfa4NngvQlYp1
 I6sDHoEgVl6Y1Lac6Pt1ABMy2PI7wkq4R6XC9MxfOUJCA9x81CCltvlGLPScCyt+AH+K
 Z7YfbLUArGGQSWNOJi1AMnHB6GZfP9LM9Z6IWzl+PJb4wAiGHKDSPH4Ay2+THAlixsBj
 r3sM5l/7lP5CFXpzkcxjgEhzEFYscPq6qBrfmKdKXWvhWPDXgqgSDKMVl39n5x25Ve96
 Ikjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zOxRSAEdOrXagFyqm1lOCp1sO7zqGLiMqKw0bXeJJWw=;
 b=69SD88aG9euNLcQpXThnqE1573wWoBtBus6mKN5tfTOGe7VCB8JWYAHPMscVx5mN/N
 YkqVDRw33MHZAbvMfLRgwW6Z8CudipqlNc8puB10P3uB8Kora8nHrzJ0gW1I82IwedAb
 SGDT93OyDsDY9wySM+2efMPZUIcd9LFSM+u9PBPNOBMVS0nvQt+vy8j0YCjTOFgulYx8
 /N6VQkOD2AyN3kgXg7v29URruCGlhqoajVhPHw7eXtBFD+iKLoDZSmaT/ZBxT46aTXts
 DmpnyqZ0D+voX9/5G6eyK29T2AscAW79EvsI/Ks7lig4XcwIA29/zoBStJb59a9dQ5gy
 WpIw==
X-Gm-Message-State: AOAM533I2z6L4mCtUGZ9FoYn4/vpKUm8h5D4U4dx2N8n0iIvL5rQpv8z
 GxXUZC7XZLsqoAeaVhY7xue6sw==
X-Google-Smtp-Source: ABdhPJxM16nhV8xoydrnwWRXtjuHki9c6awqX1ZziMpc6LmtrmsPGonV89lpv8rnJEQjNGgLEoEloA==
X-Received: by 2002:a05:6638:1382:: with SMTP id
 w2mr14845378jad.50.1636320004782; 
 Sun, 07 Nov 2021 13:20:04 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id g13sm7983553ilc.54.2021.11.07.13.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Nov 2021 13:20:04 -0800 (PST)
Subject: Re: [PATCH 0/4] block: fix concurrent quiesce
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20211103034305.3691555-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <364680b4-defa-a559-f7bf-53adcbec957f@kernel.dk>
Date: Sun, 7 Nov 2021 14:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211103034305.3691555-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211107_132007_742330_44427B12 
X-CRM114-Status: GOOD (  14.11  )
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

On 11/2/21 9:43 PM, Ming Lei wrote:
> Hi Jens,
> 
> Convert SCSI into balanced quiesce and unquiesce by using atomic
> variable as suggested by James, meantime fix previous nvme conversion by
> adding one new API because we have to wait until the started quiesce is
> done.
> 
> 
> Ming Lei (4):
>   blk-mq: add one API for waiting until quiesce is done
>   scsi: avoid to quiesce sdev->request_queue two times
>   scsi: make sure that request queue queiesce and unquiesce balanced
>   nvme: wait until quiesce is done
> 
>  block/blk-mq.c             | 28 +++++++++++++------
>  drivers/nvme/host/core.c   |  4 +++
>  drivers/scsi/scsi_lib.c    | 55 +++++++++++++++++++++++---------------
>  include/linux/blk-mq.h     |  1 +
>  include/scsi/scsi_device.h |  1 +
>  5 files changed, 59 insertions(+), 30 deletions(-)

James/Martin, are you find with the SCSI side? Would make queueing this
up easier...

-- 
Jens Axboe


