Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD37C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 23:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fh8rqO+rqZeioGW3d78+iJ6QUriFl8owv2AvhmJ7Smk=; b=VKgYBlh6CtZ8xAPCUYyFBF4LZG
	zMIdYGIhAA7Fv7MChFWTbVlnR+CgTgahUF2fdBguPg234wqWtNV2OXuh22OtzeQZh3t6qP/YUxhbo
	9SPXoscSCf79dktB7O1A68metqW+Wh7XFi8kqgrIDLYSckiHzIi05yO2BB/fZJDyQQxC8+dvCfz2X
	bblCokPkd+rfSykipKkRgT+P2plXrjbR4pLqjSyxJKsXWi1Pa+B98F5JDRgqQGN8JYWIP/PT8Umc2
	55DMub5FwFkfGuK9wFdLmlECSIH7mLkUI9DUddsdFDzVGqF9ATwMBK+weYIdw0A2Wu0P/xlOLC28p
	McdM8q1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov5Pt-00Fixa-3d; Tue, 15 Nov 2022 23:32:33 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov5Pp-00FiwG-Bf
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 23:32:31 +0000
Received: by mail-wm1-f41.google.com with SMTP id o30so10745108wms.2
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 15:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh8rqO+rqZeioGW3d78+iJ6QUriFl8owv2AvhmJ7Smk=;
        b=6WN0qwZ1XuQktB+DC3uHQyuVp56Mxo5o6SfqQ3qUC2ozwUUIv+kTBnI9JPFqYqnYhc
         xNHyse+Pp2Qog/UhboVk1MXuBlikl5LAm6cwTSkBEQkAhxsLetvdbRwP39MEqo4KVOZo
         3B1GaBeyUMv4gZ2yzJPHicA6cPZIujciAOiFGnpfrlrPlabP61wxSrZxfZoZj+O3VEBJ
         hhxpbabIekh7/u5vJ5K5rcyKzek9o5vwwpPoYXOOCkfpDp1b36cEiRehA1Pps2fQrT26
         /+3bbE5ooyJgrENx5ymU847/GfUnhSr+4FV2a9qRIWO7TtOtsWdnjgmQfRNXzUu8Bb0q
         f8Zw==
X-Gm-Message-State: ANoB5pm8Tk5hp+siO1JrDv4eJEMOHtbaIRsWD5s/XR6U53pv/Pi1YYbu
	J1caAxJf0RmVFCLJYju0hiWDPgB+tS8=
X-Google-Smtp-Source: AA0mqf4USUhf6605rzyKJYxvSLon61sIrE/GNTbQRY3KsthhyThfPlHkwwyWG4h3CWz0g6VBjIB8Ow==
X-Received: by 2002:a05:600c:54ec:b0:3cf:8443:e4a with SMTP id jb12-20020a05600c54ec00b003cf84430e4amr374814wmb.27.1668555146689;
        Tue, 15 Nov 2022 15:32:26 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003b497138093sm139971wmg.47.2022.11.15.15.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 15:32:26 -0800 (PST)
Message-ID: <9c9e54d2-7ed8-0ecd-0742-4bc5e6ef7739@grimberg.me>
Date: Wed, 16 Nov 2022 01:32:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/nvme.h:1030:1:
 error: non-void function does not return a value
Content-Language: en-US
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <202211160745.7DFOlBj7-lkp@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202211160745.7DFOlBj7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_153229_435888_7311758E 
X-CRM114-Status: GOOD (  15.70  )
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



On 11/16/22 01:27, kernel test robot wrote:
> tree:   git://git.infradead.org/nvme.git nvme-6.2
> head:   26309879524a9136be01c23a3d7f7eeb94cb0264
> commit: 1b05a0bbfb31a9c1b8e3e9abcb527301ced6d418 [26/41] nvme-auth: don't ignore key generation failures when initializing ctrl keys
> config: hexagon-randconfig-r013-20221115
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 463da45892e2d2a262277b91b96f5f8c05dc25d0)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git remote add linux-nvme git://git.infradead.org/nvme.git
>          git fetch --no-tags linux-nvme nvme-6.2
>          git checkout 1b05a0bbfb31a9c1b8e3e9abcb527301ced6d418
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/nvme/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/nvme/host/fc.c:13:
>     In file included from drivers/nvme/host/nvme.h:11:
>     In file included from include/linux/pci.h:38:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __raw_readb(PCI_IOBASE + addr);
>                               ~~~~~~~~~~ ^
>     include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                             ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>     #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                       ^
>     In file included from drivers/nvme/host/fc.c:13:
>     In file included from drivers/nvme/host/nvme.h:11:
>     In file included from include/linux/pci.h:38:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>                                                             ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>     #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                       ^
>     In file included from drivers/nvme/host/fc.c:13:
>     In file included from drivers/nvme/host/nvme.h:11:
>     In file included from include/linux/pci.h:38:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writeb(value, PCI_IOBASE + addr);
>                                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                           ~~~~~~~~~~ ^
>     In file included from drivers/nvme/host/fc.c:13:
>>> drivers/nvme/host/nvme.h:1030:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
>     }
>     ^
>     6 warnings and 1 error generated.
> --
>     In file included from drivers/nvme/target/loop.c:7:
>     In file included from include/linux/scatterlist.h:9:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __raw_readb(PCI_IOBASE + addr);
>                               ~~~~~~~~~~ ^
>     include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>                                                             ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>     #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                       ^
>     In file included from drivers/nvme/target/loop.c:7:
>     In file included from include/linux/scatterlist.h:9:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>                                                             ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>     #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                       ^
>     In file included from drivers/nvme/target/loop.c:7:
>     In file included from include/linux/scatterlist.h:9:
>     In file included from arch/hexagon/include/asm/io.h:334:
>     include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writeb(value, PCI_IOBASE + addr);
>                                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>                                                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>             __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>                                                           ~~~~~~~~~~ ^
>     In file included from drivers/nvme/target/loop.c:13:
>>> drivers/nvme/target/../host/nvme.h:1030:1: error: non-void function does not return a value [-Werror,-Wreturn-type]
>     }
>     ^
>     6 warnings and 1 error generated.
> 
> 
> vim +1030 drivers/nvme/host/nvme.h
> 
>    1019	
>    1020	#ifdef CONFIG_NVME_AUTH
>    1021	int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
>    1022	void nvme_auth_stop(struct nvme_ctrl *ctrl);
>    1023	int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
>    1024	int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
>    1025	void nvme_auth_reset(struct nvme_ctrl *ctrl);
>    1026	void nvme_auth_free(struct nvme_ctrl *ctrl);
>    1027	#else
>    1028	static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>    1029	{

As pointed out, this needs a return 0;

>> 1030	}
>    1031	static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
>    1032	static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>    1033	{
>    1034		return -EPROTONOSUPPORT;
>    1035	}
>    1036	static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
>    1037	{
>    1038		return NVME_SC_AUTH_REQUIRED;
>    1039	}
>    1040	static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
>    1041	#endif
>    1042	
> 

