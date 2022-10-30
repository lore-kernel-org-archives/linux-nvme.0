Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1574AC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 00:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HEMUfMLVSAfkGsHTinQJUfZYW8AsZ7QM6NJJDNbHCFM=; b=2i5fixyWkQiCjgrwcOJfCvcG1E
	7tLeJEabvpVzuCctF6lEJnY2gbp+GmbUk1Ve3DFWN3lSPNdk3T1OYUw7XcJupROMqcnvZqbj1h3J0
	XBurbwTkC0e4TIAyaU133UkUqn2o/S3Tu7v9qzqGEqZKfON3AsmV/d1jEIiDz5SYPZfs7P9XQ74Rd
	h/M2xBa8q8zV/O9oGiy/9ENdl4U7YxSIKe6R2OA/wmC5wx/5ExFUG3X/MMkct9C9sgRgSUO147TBy
	EW8woVxnboLR/rdDd/hBqRzcbgawk9QAgM/awmnnEg7G554sxdd7Pz0b0cyZ13XUaX1PC85JqmjG7
	rTVD3c4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oowHx-00AYNs-Gb; Sun, 30 Oct 2022 00:34:57 +0000
Received: from mail-pf1-f171.google.com ([209.85.210.171])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oowHu-00AYM7-VW
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 00:34:56 +0000
Received: by mail-pf1-f171.google.com with SMTP id d10so7803473pfh.6
        for <linux-nvme@lists.infradead.org>; Sat, 29 Oct 2022 17:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEMUfMLVSAfkGsHTinQJUfZYW8AsZ7QM6NJJDNbHCFM=;
        b=yJLW3yOJfsr9B/Y8BTMHWFqRD2ZSjqy1xRDgBiMhX81z4o0vyE4ECOJhB1ckObCGxi
         hqnPlevS2ymmEIhm7wFUNPShrIua5hfSvbXXHQdpY7nk7Ud+zERYmQA1oVGilCEt+Fxh
         uFciuHhxTzG/vw2UMBv5W6mMyy2v4nRwrIavfJXmS5gQmPMivOtKTKH1AGKpL5rqr4yd
         exVo8dAcsbY2d4bCiDM/DHncQQK8a2ZKQx+JNUQc5bYB8ntJGoFZRCNhyiu8SQHlg9ZH
         M3sWPSecD26LVpYAz6ShVnnBQgIUY6M/3eJ9LWGvr38F6kZ0CiHLDa6fM9N4/xlr9eXd
         EK+g==
X-Gm-Message-State: ACrzQf1xwKMRmQ20MSHovQXrxrAIU1qDKkuuuJHrR3oWVVkWWLjxxWrV
	ZKwLj64u8c1TPYilcI3/Qzg=
X-Google-Smtp-Source: AMsMyM6sHfWrHEaUlQIPjYDTfJMPVJPxvAM9Yf6JqXOKgiz5SbTEiH7twtGhwinB1J0PRVDvvmqL+g==
X-Received: by 2002:a63:6f8a:0:b0:439:36bc:89f9 with SMTP id k132-20020a636f8a000000b0043936bc89f9mr5945904pgc.100.1667090091847;
        Sat, 29 Oct 2022 17:34:51 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b0015e8d4eb26esm1825034plg.184.2022.10.29.17.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Oct 2022 17:34:51 -0700 (PDT)
Message-ID: <adaea16a-c7cd-5d68-50c8-d56de851061a@acm.org>
Date: Sat, 29 Oct 2022 17:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Content-Language: en-US
To: Jinlong Chen <nickyc975@zju.edu.cn>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <cover.1667035519.git.nickyc975@zju.edu.cn>
 <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ebd3a47a1ebf4ab518c985cdbaa1ac3afd6dfb9f.1667035519.git.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221029_173455_065485_B638D8F9 
X-CRM114-Status: GOOD (  11.72  )
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

On 10/29/22 03:02, Jinlong Chen wrote:
> Calling blk_freeze_queue results in a redundant call to
> blk_freeze_queue_start as it has been called in blk_queue_start_drain.
> 
> Replace blk_freeze_queue with blk_mq_freeze_queue_wait to avoid the
> redundant call.

blk_mq_destroy_queue() has more callers than blk_queue_start_drain() so 
the above description is at least misleading.

Additionally, the word "cleanup" from the patch series title indicates 
that no patch in this series changes the behavior of the code. This 
patch involves a behavior change.

I think this patch introduces a hang for every caller of 
blk_mq_destroy_queue() other than blk_queue_start_drain().

Bart.

