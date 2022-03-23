Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7315C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNnHp5P4nEjX7nU1x/5Y1Dme2dErZ8E1NHIpLaf71HM=; b=1rZ5Gig62ASd+gfLPWvNn6PM6z
	fKBuqjThBX91GgUC4ECNaevg6vdAwdj24qwPRa0loXN2EGv0I5kFct5fhH229lXnL0YSCAAJOdfuW
	f/atlM7qASHXlPxRj1yz7vztX4AqVtxPPHsjHKcm5F+CwzvEh+/gAHbgOyh4tHpF5PLLyzrRvDgqO
	EbK4n6cE/W5JNU7Ulc7RPzUstKQjPPvcjFmwwWdqlfS3FDE+0BdAl5PoBJiXYXyywK/lxcG1J0Jun
	PX+NwgdH27EV7pG8wLCBUBfEUS7x18MgySdutYoENvl+toI12UjXKp0bPLU7qqZeH9CE0jW3I8fw2
	HgXKCtGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX3vE-00EGKO-34; Wed, 23 Mar 2022 16:33:20 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX3vB-00EGK0-BK
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 16:33:18 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 bi13-20020a05600c3d8d00b0038c2c33d8f3so5690461wmb.4
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 09:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YNnHp5P4nEjX7nU1x/5Y1Dme2dErZ8E1NHIpLaf71HM=;
 b=QBwxxJzzBO9+tZIQD3XPmYjX62dkJB4CKgklIfESfFL0DkcRtq97rytO7qV/Q20FK/
 ONT2fFwVmuVgs/w11RmsSADraXjmPKFvqPfbExBCRQNl1kKM+5r7z4GY9DKYoCpIeA3l
 2C8+VR9b/0+KY8SawPxKIrF0Y00Pyu2zECj4A5n87n1coXGsNuSn4lIgdDUXJfP13nFO
 6Jg44m54pC3m/b6ICr5ksJrhjobdFLZTwVynhEvs/ftblSVvU1+y+kq0s7dkoFbB0r1K
 VYPl1kmAd9AoesVsCkLf40+vDbegKkGEtXKPbBIT6YRZOpT/6TkONxM0FOYMdHmuYRe6
 +h9w==
X-Gm-Message-State: AOAM530B2AXveHs9AkzNx5EctDd++O7YxTh8yW8Vx7hX9N8rVAyRcr3r
 4M8SsI8oMPNfvSNQyGsHdu8=
X-Google-Smtp-Source: ABdhPJwdgQCQe4eZ9YnxVd1gOZjE1TDOGIwZLASWfvo2j6kIzd5FmUeKP+qrYClgi6YyTVhzla6ZfQ==
X-Received: by 2002:a7b:ce84:0:b0:37c:52fe:a3ff with SMTP id
 q4-20020a7bce84000000b0037c52fea3ffmr10026873wmj.48.1648053195267; 
 Wed, 23 Mar 2022 09:33:15 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c358f00b0038cc046cb2esm370133wmq.32.2022.03.23.09.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Mar 2022 09:33:14 -0700 (PDT)
Message-ID: <9c747632-2cd0-3096-40d8-e3df40b95679@grimberg.me>
Date: Wed, 23 Mar 2022 18:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [linux-nvme:nvme-5.18 4/5] ERROR: modpost: "nvmet_wq"
 [drivers/nvme/target/nvmet-fc.ko] undefined!
Content-Language: en-US
To: kernel test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <202203240012.gJehzedI-lkp@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202203240012.gJehzedI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_093317_424627_BB154932 
X-CRM114-Status: GOOD (  13.56  )
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


> tree:   git://git.infradead.org/nvme.git nvme-5.18
> head:   84db0c76f3bda283a82c0e883c8f3171048a30bf
> commit: ade7dda8539580e02c9004f124783f320924709b [4/5] nvmet: use a private workqueue instead of the system workqueue
> config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220324/202203240012.gJehzedI-lkp@intel.com/config)
> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
> reproduce (this is a W=1 build):
>          git remote add linux-nvme git://git.infradead.org/nvme.git
>          git fetch --no-tags linux-nvme nvme-5.18
>          git checkout ade7dda8539580e02c9004f124783f320924709b
>          # save the config file to linux build tree
>          mkdir build_dir
>          make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-fc.ko] undefined!
>>> ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-loop.ko] undefined!

Damn... patch slipped:
--
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 18444eaf35ab..dbd528061857 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -18,6 +18,7 @@
  struct workqueue_struct *buffered_io_wq;
  struct workqueue_struct *zbd_wq;
  struct workqueue_struct *nvmet_wq;
+EXPORT_SYMBOL_GPL(nvmet_wq);
  static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
  static DEFINE_IDA(cntlid_ida);
--

Christoph, can you fold it in or should I?

