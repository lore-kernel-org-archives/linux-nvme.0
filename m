Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F8C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 00:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Auar1RdzlvfJJDBCRKG+lN52eMaphmhWckiEM72bzhE=; b=cI4wvxFXFO4mLvXm3UaxAhremY
	VBPt3ShHSMaKENXSVvL9u28WX4LMfxnp/aIupFBzUCff80KATEe76ZWrinv0pkKArZnND+cnIoNxk
	HqQVj6IQsBqmDdbZJUilcgsK+RXiHzUhv7mIOurSrG3ObpE5rV+QAnMtlhxrysIBATGvQ4gpICtBv
	fQ7KFNHRQtT/UAIMFNwGz8QVv17qWwrzariUoxlofOsTT/2r6YPxnjloKxRuhS4CzOvNOvhqrCt6j
	x73ewVNeYeO78xtSupMW2L9wCxf9yQp9JSO+wMzEcMvRJG1+Cfa8UdiC4I3g7yWqByHdr4H6gPVSI
	l88aCDVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q49Ol-00FZHF-0D;
	Wed, 31 May 2023 00:09:07 +0000
Received: from mail-il1-x162.google.com ([2607:f8b0:4864:20::162])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q49Oh-00FZG9-2T
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 00:09:06 +0000
Received: by mail-il1-x162.google.com with SMTP id e9e14a558f8ab-33b6c47898dso15181005ab.0
        for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 17:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1685491739; x=1688083739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Auar1RdzlvfJJDBCRKG+lN52eMaphmhWckiEM72bzhE=;
        b=Ouu+XDjCn5XyNG5qZ+K9Qlnnz2whdibKG2c/14QdZPW2CvaJMbtejTmxc3gh+qKpGu
         +rGtkNp/UzCxYsxUoqfOXViavHDWsf1EtyeGj82T8HQYvl+rHCorVS+6oomMepYFlDiw
         l1lAxDagG39IsvyLra/xHQwI34cnjDAGAU0H6o6P6EAlLF81eir2hsf4hJgt1ZzZE1Lv
         L+juH/6JZQ5dEsH7tp9qbFNFrnJeFtz+eIwMSH+WxBJk9dBqADibnebeUvTAVjBa9mWj
         Tm+oMEl3RabPVFXmxc8fQfGXHlJxdrU0r3D2Zoh9T4DjlPptmrFRY2nyAIe9USoHay9G
         wDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685491739; x=1688083739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Auar1RdzlvfJJDBCRKG+lN52eMaphmhWckiEM72bzhE=;
        b=b06RZY+npNqOEGbhhguozgska+JvYPDzDI3hueNuruITOy9U6yoFPPpjko9L3UgDsm
         A1DCNpgy9V6Ht28B7cma/ZMMkK9FqwRFx0uIdbttN38wjB9VK9/1ljZSJ/6zb8Ng9HT8
         2ObK/7WHn8qr60tz2R/eGRmoG13dcI4Rs++l6+XvHcF1rk6rMf9M1H0XYSGKoV09lbYr
         ygYy06Qd5BaGRAuquOYHAodT+7eWOQ+bW45IZbA+sz0IM8tozcnIixfrKFtrZ297MaQZ
         wQej5N9vNf5qWM5b+URILRvAbkrruyt/D3iS+nTKq8GkGUvQXFpu4DaajtDP7OpZkTip
         coTg==
X-Gm-Message-State: AC+VfDyhNxVcNWRY8WGeNhCqNO9oH3Bhxw17UBAQf+ac52Ql3EQ0uwU4
	2wrnyHXvBx2Yh+pNvChlH8xMc4zYgbjcKcqsi+dxGa2E3ORPnw==
X-Google-Smtp-Source: ACHHUZ7vE/Yb1vH7txgl8cJlV+C1ldtDqowTsVrhIURkIJ/rjDBK8dzM38j7/ku43J8fusWyW++LtBt2dnl1
X-Received: by 2002:a92:d581:0:b0:331:4f70:a2b with SMTP id a1-20020a92d581000000b003314f700a2bmr1009360iln.5.1685491739594;
        Tue, 30 May 2023 17:08:59 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d7-20020a92ddc7000000b00335c3fc1aaesm519388ilr.2.2023.05.30.17.08.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2023 17:08:59 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 95D9E22121;
	Tue, 30 May 2023 18:08:58 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 8EC87E432AA; Tue, 30 May 2023 18:08:58 -0600 (MDT)
Date: Tue, 30 May 2023 18:08:58 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-6.4-rc4-pull 5/5]
 drivers/nvme/host/core.c:1202:51: error: 'struct nvme_request' has no member
 named 'start_time'
Message-ID: <20230531000858.GA4119628@dev-ushankar.dev.purestorage.com>
References: <202305310532.V3y3hWXI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305310532.V3y3hWXI-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_170904_423744_F2CD5D50 
X-CRM114-Status: GOOD (  17.02  )
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

On Wed, May 31, 2023 at 05:27:59AM +0800, kernel test robot wrote:
> tree:   git://git.infradead.org/nvme.git nvme-6.4-rc4-pull
> head:   f041d3b83aea7e76e4dfc6591954d6dfe506dbdb
> commit: f041d3b83aea7e76e4dfc6591954d6dfe506dbdb [5/5] nvme: improve handling of long keep alives
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230531/202305310532.V3y3hWXI-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build):
>         mkdir -p ~/bin
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add linux-nvme git://git.infradead.org/nvme.git
>         git fetch --no-tags linux-nvme nvme-6.4-rc4-pull
>         git checkout f041d3b83aea7e76e4dfc6591954d6dfe506dbdb
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.3.0 ~/bin/make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/host/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202305310532.V3y3hWXI-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/nvme/host/core.c: In function 'nvme_keep_alive_end_io':
> >> drivers/nvme/host/core.c:1202:51: error: 'struct nvme_request' has no member named 'start_time'
>     1202 |         unsigned long rtt = jiffies - nvme_req(rq)->start_time;
>          |                                                   ^~

My bad, I only tested this with CONFIG_NVME_MULTIPATH set, in which case
the field exists and we don't see the error. The following change should
fix this up. Keith, can you squash this with f041d3b83aea in nvme.git?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 601dc5f9ac58..bf8d76de5299 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1197,7 +1197,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
        struct nvme_ctrl *ctrl = rq->end_io_data;
        unsigned long flags;
        bool startka = false;
-       unsigned long rtt = jiffies - nvme_req(rq)->start_time;
+       unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
        unsigned long delay = nvme_keep_alive_work_period(ctrl);

        /*

