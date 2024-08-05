Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30D6C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Aug 2024 11:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w92A5DSLMtWgFu3PG5e7V2aasOF9qr2/85zMzlFL76I=; b=z/zVwE/+2jSHICcpCwU9v2h65p
	XhT8IJ04BdCWsB5lRQ3KH8yLdS920gT0IgORiOw2s/Mmiu6ZX8GgjwD7pqI3s+/4Ik3wYYZonQaAr
	zRct3Xa0C+VXgTiCoZDU8dOhuAK2LGCFlWSmGt+doq9A2MUoeMFdxRWnPbTH2GL+LdP5e+iu6Jg4d
	M0f7Z5V/vKSD5kkLVpRe65FzdWxR4cbFZdOfE8Jx0WTGYD/p5YXaFKdD6X/Ljvqyo3ptZH94MTqZj
	tKuvHpUdAuM3DLGRoPmrjXw0Fhz5lnTG5BdGWcMI/x7+hlvJZ6Ovd8LGbYboB5zuSzh82PKmLZt7e
	7etkiEPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1savTJ-0000000FcJ4-241x;
	Mon, 05 Aug 2024 11:01:49 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1savT2-0000000FcDs-0Yy4;
	Mon, 05 Aug 2024 11:01:33 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5bb477e3a6dso1378204a12.0;
        Mon, 05 Aug 2024 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722855690; x=1723460490; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w92A5DSLMtWgFu3PG5e7V2aasOF9qr2/85zMzlFL76I=;
        b=TW0Bt6V6JJjOA3vJJUveyESRaVBlRMswSYAbZ5dwgkqQlt3S3Z8z/aUmINJ7LpXLai
         IfMaE4SjK3DzKWRpJJ4WFZAuAOwmkvp5/q8Jm9ug6uzmJDmyUx2DNnlKsaknQi3kl113
         Fjk2VTwlsM0gfsRyOs24lgEwGXQHXBq4wLljkBl/C7pWngnIID7vZNEwAGXNeA57mNb0
         mnlf8DR8JrfHV/6jG6oesQ77xUr4NWDQD84yk50rNZKZ6kehadyn5R5aD62ahClel0CU
         K2LuHmJXfQfDpzOvegocpOs+/3AOXwLVG7XT+CzurfO7KCNB2grBGL8RjZtPRFmzjv26
         fWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855690; x=1723460490;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w92A5DSLMtWgFu3PG5e7V2aasOF9qr2/85zMzlFL76I=;
        b=WAwoKw/haB+FYOA0TlYYrH19JxHydx0xcmglCSZA4/iE2fe0zj6zh443Bu12znx0kw
         Ae7XD99rjAyFxXODsZFNOiR7+qU8n6DMZt/ZwsWNkFnKDT5cJc4hrjhHdGNG4oaIOLup
         iqNfx0BhyuytOs0x0erCG3G3X0ZtbI3pGF+I29V9NvwMYCMMsbmBN7AU6gHBFPbOM3rq
         k44mOpXrkorC1kBBA8OKlpaP0TdH6J9z9bEDV8sabn8UAPvZEzO+Bb6X0pu9rLf5OKeX
         8+BrW+Xko3Ia9VJ0r/nbT12sCDJFWO88WmcnXarIUkBrJy6gwed+xYUqR3onCFxq3MH+
         eEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVsFUOQU/ysdvs9J7QWA9od0mOxdvcKrEEYBiZdO3grGqON83rpwlQpZRGoUP9Psnu8kPs31r7pCjfGVSesOMZj580Px2uPPSQWUAOXNKXFjgEiqV3PE5UsnjiyRbBrJpUhYIolDDlhJdcvV7eF
X-Gm-Message-State: AOJu0YwrPWjHqYd2GabVllqxqlIWEed+/r2z6eCrw5ha9EEMRarLajwt
	5A5PDNUOSlg3wf15GWltaOxSQaIMSAlasQdUtORPyVLknJZGdlTm
X-Google-Smtp-Source: AGHT+IG3bgoM32LacSe8Aeid35LCdMXycqCOoZj2eJ0y9sS0Tr1FkiYG5HntASlHWcu+NtMPW2GNSg==
X-Received: by 2002:aa7:c50e:0:b0:57d:456:e838 with SMTP id 4fb4d7f45d1cf-5b7f57f6c52mr8123532a12.31.1722855689903;
        Mon, 05 Aug 2024 04:01:29 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-255-112-66.business.telecomitalia.it. [95.255.112.66])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f34sm4805088a12.56.2024.08.05.04.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 04:01:29 -0700 (PDT)
Message-ID: <66b0b109.050a0220.93681.d015@mx.google.com>
X-Google-Original-Message-ID: <ZrA-9btkfLnpPip-@Ansuel-XPS.>
Date: Mon, 5 Aug 2024 04:54:45 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
 <202408050612.Ya1m6REu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408050612.Ya1m6REu-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_040132_205683_E68DAE8E 
X-CRM114-Status: GOOD (  23.83  )
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

On Mon, Aug 05, 2024 at 06:52:04AM +0800, kernel test robot wrote:
> Hi Christian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on linus/master v6.11-rc1 next-20240802]
> [cannot apply to mtd/mtd/next mtd/mtd/fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
> patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
> config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
>    drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
>       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>          |                ^~~~~~~
> >> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
>          |              ^
> 
> 
> vim +33 drivers/mtd/parsers/ofpart_airoha.c
> 
>     10	
>     11	int airoha_partitions_post_parse(struct mtd_info *mtd,
>     12					 struct mtd_partition *parts,
>     13					 int nr_parts)
>     14	{
>     15		struct mtd_partition *part;
>     16		int len, a_cells, s_cells;
>     17		struct device_node *pp;
>     18		struct property *prop;
>     19		const __be32 *reg;
>     20		__be32 *new_reg;
>     21	
>     22		part = &parts[nr_parts - 1];
>     23		pp = part->of_node;
>     24	
>     25		/* Skip if ART partition have a valid offset instead of a dynamic one */
>     26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
>     27			return 0;
>     28	
>     29		/* ART partition is set at the end of flash - size */
>     30		part->offset = mtd->size - part->size;
>     31	
>     32		/* Update the offset with the new calculate value in DT */
>   > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Mhhh somehow I can't repro this with instructions?
-- 
	Ansuel

