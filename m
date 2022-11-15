Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51F1C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/H7+A/Xzx9ZtihVEUgBKymwZXqW8c2bByaG/vCfZHI=; b=vyERNIDZNsScGw9PRjHgJ1pAEI
	7GreiTMza1OX9VzP1wiqRR5GmruPIjmzCW+NnLN0OIPyFuIg2yzCyrCuQ4YxIbYAoGiaLX7ZJfRmV
	GyeX1nhmIHwkZ2FicCAcNA6OHWmDpgcsRNWTSJwrjh8jOfYScoHIpU1rpUwLmBtN2xOcS95sAaCeq
	d0D9MIonWc7lsxMgR1CAfGCCwJMX4itKYFAyVWUE8Atw8PuBmX3K6vYkCRWOPLwnh17UA0jScqGNA
	tpCRNNVJ6bUjyofeqFEbZQR6ByiQVqWdqq6EzNboeYtv2jBWsOpticxFAz1eT/EtVy4YMM3NKfBqk
	qux93pSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oux2v-00Bvap-Ln; Tue, 15 Nov 2022 14:36:17 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oux2s-00BvTx-RW
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 14:36:16 +0000
Received: by mail-wr1-f50.google.com with SMTP id y16so24598481wrt.12
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 06:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/H7+A/Xzx9ZtihVEUgBKymwZXqW8c2bByaG/vCfZHI=;
        b=j2HUIFQUG+6bMI87YFc28dRLCSj5gzILJFCoE0bXKvI1bzH9YFLxFgqDXwjidgwuUS
         vrbspgr5mBoA/Nat0mm1sCTqE8FIrCQScGV5PPe+5oeEpkmRFG0pwd3+8uAPmV23SEB8
         U8tpTeO6Ox0r2d+IoMxoiIGdCVzJbB50iTE+wcvZzlHbRMJ96GmgoiDBwfD6myJPRQmu
         at4JNbW+CQ+C9nt8ob6CGtQOuTXPFLwv0BAFHPvWx36iT2wkVo0E77uZ4kqDNRTn74w0
         7zkCNkA/Nrs/TFNmnT8nTBqO/cuKSenwaMlO3tKyf1P/BhRzGDoP1DZ6y0F/EvzteYnw
         NVCw==
X-Gm-Message-State: ANoB5pkscE0lN7uQMnbXiAu+20DR7hAl7Tu0G3KsQ0cp0Xb5eC3VuKYW
	IGZaSfoSstXiQosM/P0ef7g=
X-Google-Smtp-Source: AA0mqf4/mqgwZG51kecqplqf/xhaal7tsWYFae+E2p7GHuE22z1z+C3A7sGfsyxm7Cd1MPXxqaZk7Q==
X-Received: by 2002:adf:fa10:0:b0:241:753d:6018 with SMTP id m16-20020adffa10000000b00241753d6018mr10164505wrr.67.1668522970925;
        Tue, 15 Nov 2022 06:36:10 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm14211011wmq.1.2022.11.15.06.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 06:36:10 -0800 (PST)
Message-ID: <7f0a07b5-ff05-7a51-3f34-1d062ae6db35@grimberg.me>
Date: Tue, 15 Nov 2022 16:36:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [linux-nvme:nvme-6.2 30/41]
 drivers/nvme/target/../host/nvme.h:1030:12: warning: no previous prototype
 for 'nvme_init_auth'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <202211152236.4KnV3vRM-lkp@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202211152236.4KnV3vRM-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_063614_926442_AB5F24AB 
X-CRM114-Status: GOOD (  14.94  )
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



On 11/15/22 16:21, kernel test robot wrote:
> tree:   git://git.infradead.org/nvme.git nvme-6.2
> head:   e2deb6d1a5b2dcff71f429a64fb516186aa0382c
> commit: be6cfb9fa889e8c636287335d85ebe89a74f17b2 [30/41] nvme-auth: guarantee dhchap buffers under memory pressure
> config: x86_64-rhel-8.3-syz
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>          git remote add linux-nvme git://git.infradead.org/nvme.git
>          git fetch --no-tags linux-nvme nvme-6.2
>          git checkout be6cfb9fa889e8c636287335d85ebe89a74f17b2
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/nvme/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>

Sent a fix.
Thanks.

> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from drivers/nvme/target/loop.c:13:
>>> drivers/nvme/target/../host/nvme.h:1030:12: warning: no previous prototype for 'nvme_init_auth' [-Wmissing-prototypes]
>      1030 | int __init nvme_init_auth(void)
>           |            ^~~~~~~~~~~~~~
>>> drivers/nvme/target/../host/nvme.h:1034:13: warning: no previous prototype for 'nvme_exit_auth' [-Wmissing-prototypes]
>      1034 | void __exit nvme_exit_auth(void) {};
>           |             ^~~~~~~~~~~~~~
> 
> 
> vim +/nvme_init_auth +1030 drivers/nvme/target/../host/nvme.h
> 
>    1019	
>    1020	#ifdef CONFIG_NVME_AUTH
>    1021	int __init nvme_init_auth(void);
>    1022	void __exit nvme_exit_auth(void);
>    1023	int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
>    1024	void nvme_auth_stop(struct nvme_ctrl *ctrl);
>    1025	int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
>    1026	int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
>    1027	void nvme_auth_reset(struct nvme_ctrl *ctrl);
>    1028	void nvme_auth_free(struct nvme_ctrl *ctrl);
>    1029	#else
>> 1030	int __init nvme_init_auth(void)
>    1031	{
>    1032		return 0;
>    1033	}
>> 1034	void __exit nvme_exit_auth(void) {};
>    1035	static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
>    1036	static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
>    1037	static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>    1038	{
>    1039		return -EPROTONOSUPPORT;
>    1040	}
>    1041	static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>    1042	{
>    1043		return NVME_SC_AUTH_REQUIRED;
>    1044	}
>    1045	static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
>    1046	#endif
>    1047	
> 

