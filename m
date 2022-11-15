Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB79C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7juo2FoT4miYQDNoa2XkhqNtIZm9eHKB/9DZ7kVhm0M=; b=NxlgVA3iB6G/DTz56dwpWAmNIc
	4opc94E5Q+QyG6JSMtPtqx9toACTbFnkBp1bQTkbsmrwYoRlwMFvuwLjd5t+AyvQhlBW9VI7ZIWS2
	AN302QISOnMFEhnvisRaHiHFBXETsfdW555Q/Fr2UgeQz5YY/SajDINfY+wrtpPXjRAuOHlkQHQbf
	s8mhkkLmD1C4DGybncPickunYddAYxHgQ/3Ezxp/nsB3UwaxQ6lLXvkcqecCqUj4QcKuQWHRFKhKh
	QDPzCzByKhZAPEDDQki8+lZYUktcIxZyS3B61hFCB+Z2NvbyUTH+4SnfnfpZau7Q46YgB+o9UJIQo
	eR+hRrZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzXi-00DOzI-ER; Tue, 15 Nov 2022 17:16:14 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzXf-00DOx2-SX
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 17:16:13 +0000
Received: by mail-wm1-f45.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso10750704wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 09:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7juo2FoT4miYQDNoa2XkhqNtIZm9eHKB/9DZ7kVhm0M=;
        b=oygXXJpEb2rb6WbLJ+9urv/fgd2mmAtMCdgTJhycItZoAaRyJYSBcisvETKsH1Dhtn
         q84mJNXpo4tnXc3xW5QLTLtv2ijuUWAf09DN6iADVQY2hFWnYYnfw6Mrq+sdvZSuhs3v
         HZS8ARJPPRycTNCC8/AnPu3ZiDFSOC03nSyp+pHfaeqczl0Y6zQ8H4/zSO88CNe9VKc6
         xaRmZEpXJ0VqqnJ6xDCtO1pHKjE7PYa2iaAAsc2wsbDFfTrlAr8tPrV1wknmZFBivA2m
         17L0cjKrbOW6b9ftcGCADeg1soF0dVI0eqyrL+CRUYlVYyg5PnuypcGl5d4Y0C02RASS
         qymQ==
X-Gm-Message-State: ANoB5pnQETS+7h5FsAfgAXTgXyqVAZHoaat6XSXUHP660dTm4uWHdlIM
	kYP5MlRZPnmw5IuDI4IUJ6M=
X-Google-Smtp-Source: AA0mqf60l9fSFKwJqJfSNq4xWLwxfeVNuxNQW1LBIi1bBHUOmxy58IlUZnqXV4GuDJZsWiosWty2Jw==
X-Received: by 2002:a05:600c:3d12:b0:3cf:92cc:9e5f with SMTP id bh18-20020a05600c3d1200b003cf92cc9e5fmr2255898wmb.181.1668532569222;
        Tue, 15 Nov 2022 09:16:09 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b3-20020adff903000000b002366fb99cdasm12853245wrr.50.2022.11.15.09.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:16:08 -0800 (PST)
Message-ID: <edda71f4-9912-d336-6d5b-0e1e102d4bfe@grimberg.me>
Date: Tue, 15 Nov 2022 19:16:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/core.c:5122:6:
 error: assigning to 'int' from incompatible type 'void'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <202211160055.rbjs32vH-lkp@intel.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <202211160055.rbjs32vH-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_091611_949591_ED9A46D5 
X-CRM114-Status: GOOD (  14.39  )
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


> tree:   git://git.infradead.org/nvme.git nvme-6.2
> head:   e2deb6d1a5b2dcff71f429a64fb516186aa0382c
> commit: c1658b482f1bec9ebafa49eec69a29aebbc23556 [26/41] nvme-auth: don't ignore key generation failures when initializing ctrl keys
> config: i386-randconfig-a016-20221114
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git remote add linux-nvme git://git.infradead.org/nvme.git
>          git fetch --no-tags linux-nvme nvme-6.2
>          git checkout c1658b482f1bec9ebafa49eec69a29aebbc23556
>          # save the config file
>          mkdir build_dir && cp config build_dir/.config
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/nvme/host/core.c:5122:6: error: assigning to 'int' from incompatible type 'void'
>             ret = nvme_auth_init_ctrl(ctrl);

Christoph,

Can you fold this into the offending commit please?
--
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a50b0743728e..273f4f95f425 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1063,7 +1063,7 @@ static inline int nvme_init_auth(void)
         return 0;
  }
  static inline void nvme_exit_auth(void) {};
-static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
+static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
  static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
  static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
  {
--

If not, I can send a patch to fold in.

