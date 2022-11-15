Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D97EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qY6nRVloPMu0a9o0f6TK0ayYypeD2+K8gsrO+p4X8nM=; b=ffF2N5olj0WvLD/ReO+Sdsr2KM
	HA37SD+9lX1+M4FDnfRUIGuFMfmzTS4B6QhQkThWMX4+EvD+HT8Hlu8TJH4iQ5bCTxFLM2jLAD8ex
	Ap02WYefDqSe8WuX0rLkmoK7f42ivue09lG4yqRKkc9GasR0fq3SbVBeG7WcjDTB3ZUX7X3GL7prW
	Korbewjj4qLC9GO+oyS82JbCCj9YXOAboDmAzH0v/gv700SHHU4FC/Mq4iIaaYdDjDV2/1iEAQhnD
	y6z0LZ7pNW4tsID4YcFMAKO0YHmqLyBeWY/YP3D8NTJFuJzvVJNRemHxSIaLKXRgknIQb8vRVxY6r
	C9UMRQtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov070-00DaKV-Sy; Tue, 15 Nov 2022 17:52:42 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov06x-00DaHZ-Lp
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 17:52:41 +0000
Received: by mail-wr1-f44.google.com with SMTP id w14so25578370wru.8
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 09:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qY6nRVloPMu0a9o0f6TK0ayYypeD2+K8gsrO+p4X8nM=;
        b=OPOdo/DYhjMCiuD54s4j/t2SMezKGF37/tC3347SJkyvtri3CXgtocya09QZyRKnXp
         E9+udzlewNQym4MarWWQ/tdosnvKnZYMTWbfhN9HR115KCSNIQ154uyWg0+5Zmor5m2a
         ds2IXBwk/qcsjrnMDfVI8SOBDxfhaWBTBPeizJ9twxs/XmX32y6yEc9lNOzUQIKVhKpA
         NaHDIruvTxQEEchIcRHeeIgUlgbBqGZ/+bS+deuJKW5o2gn0uhGy47z6TQ+2ctEC/xov
         rZDisILM3fD4IiYCeVyjFX0u7xw1sybko+yjBfkX02/fjK4Akfh/zQp4o19+I7mTzSHq
         voSg==
X-Gm-Message-State: ANoB5pmiZI9TRsDQ5FQnSW9xucLZHl3X5yYNAgtFUQQMTiYp8hKRoJS3
	QDe050cXaJt6zt8yJua5JvY=
X-Google-Smtp-Source: AA0mqf5lHeNocUoDpqqafZ5+2xlzWcWsctgjNGvtBrkjBSU9GL/Yu+kTRaxpDwH0GXyOJuVgfkYUlw==
X-Received: by 2002:a05:6000:1b86:b0:22c:c8cb:486f with SMTP id r6-20020a0560001b8600b0022cc8cb486fmr11198619wru.402.1668534757934;
        Tue, 15 Nov 2022 09:52:37 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm13077761wrb.93.2022.11.15.09.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:52:37 -0800 (PST)
Message-ID: <5d14f4b9-5c1d-9caa-e70d-576bac98abc3@grimberg.me>
Date: Tue, 15 Nov 2022 19:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/core.c:5122:6:
 error: assigning to 'int' from incompatible type 'void'
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <202211160055.rbjs32vH-lkp@intel.com>
 <edda71f4-9912-d336-6d5b-0e1e102d4bfe@grimberg.me>
 <Y3PLZxNwqioynAtw@dev-arch.thelio-3990X>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y3PLZxNwqioynAtw@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_095239_742232_57770362 
X-CRM114-Status: GOOD (  12.00  )
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


>>> tree:   git://git.infradead.org/nvme.git nvme-6.2
>>> head:   e2deb6d1a5b2dcff71f429a64fb516186aa0382c
>>> commit: c1658b482f1bec9ebafa49eec69a29aebbc23556 [26/41] nvme-auth: don't ignore key generation failures when initializing ctrl keys
>>> config: i386-randconfig-a016-20221114
>>> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
>>> reproduce (this is a W=1 build):
>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>           chmod +x ~/bin/make.cross
>>>           git remote add linux-nvme git://git.infradead.org/nvme.git
>>>           git fetch --no-tags linux-nvme nvme-6.2
>>>           git checkout c1658b482f1bec9ebafa49eec69a29aebbc23556
>>>           # save the config file
>>>           mkdir build_dir && cp config build_dir/.config
>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>>> drivers/nvme/host/core.c:5122:6: error: assigning to 'int' from incompatible type 'void'
>>>              ret = nvme_auth_init_ctrl(ctrl);
>>
>> Christoph,
>>
>> Can you fold this into the offending commit please?
>> --
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index a50b0743728e..273f4f95f425 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -1063,7 +1063,7 @@ static inline int nvme_init_auth(void)
>>          return 0;
>>   }
>>   static inline void nvme_exit_auth(void) {};
>> -static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
>> +static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
> 
> Won't -Wreturn-type flag that this function is not returning a integer
> value? I assume that wants 'return 0'?

Didn't even compile it...
infradead is down again, I trust that Christoph applied this fixup 
correctly...

