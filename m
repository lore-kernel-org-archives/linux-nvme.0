Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE61CC6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 08:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=EixM70x6WQOk4AevBKSJPxxWlg
	IsLjfx2ShC7GGjZwVGLZEx6a58ZUVmK6jd5Bw6t7JhTIbGZOWO1CsVKJMJcOgsV2C6XXMPpkkjuup
	gj7mrxOL1Uzp3DsjSPEvluJfgwKGHQH42Ku6gqDkngiMqjajFJO+4DvB0+Ik0J1O/XSSG7DPrGTqP
	MDyJ6CfkNN/MUzEqAXaBdSVfMzAaycKaausCHmVrYAXvz0EHQdLDx0MJ33zeXF+E/3MzOSOnPp9Fg
	oGWel0Cef+kBjQUzpi5mxFg+bqJoQkMCjtzQVl3+uisyYSTlrKDf67gnjPfKhf6ASTIH8MJgA0FHL
	wRx13R9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFyD-001DJT-1z;
	Thu, 23 Mar 2023 08:06:49 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFyA-001DGw-30
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 08:06:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so522728wmq.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 01:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558803; x=1682150803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XsGPfL4oSvmmLB3C/bknVnOUSp43x5oFj11pFCIETvTP9M0LhLeOk/ft2ByyzygzgM
         wyFc0xVfV2imtEPfMi06MpVLfjgHawDIMQOic9vihzp+1ErwKARDBqst+ooSDIakLkgi
         LcfVRdeNYSsXwi5qX+scM6775dowwbg00Ao4gVRacc0/Gd5GkTydYztUFxnL+LMP5X6w
         LJ/OyCOSx1zZrxDxT4oJN7F/KKjoDS2fUO66y4TQFlepxxgdAwHUBPLGBt8rMyWmLbZ/
         I/UgD+6yctluFqGD9SfTA6u4YneVw4AY6+D2HlxFOWLgCYXTukm8snlGuzOv2HUiKOMw
         FkRg==
X-Gm-Message-State: AO0yUKWV5Bzy4RbEBpZnz6ewXnbx1ACOUAZrKMVYr6rjNH/SbQz1vrUU
	Lqe0CAXNC++hfgSQOngka4M=
X-Google-Smtp-Source: AK7set9yl+6AmO56ielQjOSzUMbtoTJoYLZ0vO1dP7XnJoFbfxblrcanJjSEn3WYrF3QK8Egm8qp5Q==
X-Received: by 2002:a05:600c:4755:b0:3e8:7ca3:8424 with SMTP id w21-20020a05600c475500b003e87ca38424mr8513947wmo.1.1679558803038;
        Thu, 23 Mar 2023 01:06:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc30a000000b003eafc47eb09sm1070628wmj.43.2023.03.23.01.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:06:42 -0700 (PDT)
Message-ID: <a91221ba-9c43-77d0-420b-6227ed0203d6@grimberg.me>
Date: Thu, 23 Mar 2023 10:06:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 8/9] nvme-core: remove unneacessary else
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-9-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-9-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_010646_965222_C45E9009 
X-CRM114-Status: UNSURE (   6.13  )
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

