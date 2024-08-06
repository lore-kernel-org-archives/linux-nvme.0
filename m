Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26420C3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 11:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Subject:Cc:To:From:Date:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IVejJhSSwefbToNWC/vMSJDYdMIZMCdNUKTcNbMdxLc=; b=cL6rG0LmYWJGHl3vlLqCFt/KvJ
	ZhLWzAcXzF6gOklGVyxd0C+rWAlaxevrt7ngeMgIjdg4qGi651oYzbI18ylPbjb9mPPYabS1i3sDe
	yvX6Egm3ZVb4RoRtmZo8UtcaEpOAtzNbORw2ZwLKJajtS4wMddaW8Pe0Oe7re5f4wGwQzUCr9/sx3
	c7Y4NPMP7TkObtv1oPev6p2yUQHAYioGC+4PdKCHMk+3L5wtBUiIjV0AcxqqBDT7G95ECa1+8iWQ8
	4vw3iNnlY1WtFu5qXD+HXHx57ghWJWo1oV2EOo450YpLginhM/IGwhJLMBcDD9goDKYlLTDNhBU0p
	0rLMwU6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIR4-00000001M3R-3VXI;
	Tue, 06 Aug 2024 11:33:02 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIR1-00000001M2p-2M8a;
	Tue, 06 Aug 2024 11:33:01 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2f032cb782dso4401351fa.3;
        Tue, 06 Aug 2024 04:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722943977; x=1723548777; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IVejJhSSwefbToNWC/vMSJDYdMIZMCdNUKTcNbMdxLc=;
        b=j+G7R14iOjrxjJ7VCEm4LqtjgxJaOWwlXM878DUJXEhzHcfEkZNsDXzttTyYn82FQO
         0FCtjHW3pQBNfNX0VFKdaEX+G8HnbreNt3hgt8LbZy+gvcaoG6I/aNtaCG0x5xULix1D
         q8qLmn6MfV0aX+EiuK8PWi2I9q+/2M7L+W5FrzJG0Zqv3I05MRkv50R7PxA2m9xdx/Hm
         NyUfvIQB7Kk6BVt/CbAKyi80yTegANuq0OkUWI+fLrvRGp4MzD7NsbPCQPsgSB4LOXbq
         wEu3Jd2OkSmfB+OWoS9yxhk4oEMp0kJr6JqLSFLx2xzibH7eNjZuWbhJdIjGJideAPfA
         bdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943977; x=1723548777;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVejJhSSwefbToNWC/vMSJDYdMIZMCdNUKTcNbMdxLc=;
        b=rqdB96Enm+ycLwH6n5emvkVn3mkDHSS3m4l6o1awVYmXO1NS/x2G9+ytHJYGbvEuX1
         tVt2WyYOAesZrYY8a/KJ1MwbIKXhf+sIHO7LgLkWLJGURI0DknKTq5d6Ah+bCVeXOd8x
         6s8/huw6Objg8vndHO4CbXiElzcoEXtP3W4xtMW7xSqvsgImoUnraxACXnSWbfm+t35O
         0JmMkX4MOojY2skfxH0+nRuaXE/8ds4HMwof6i7Pc028agL07IwcDGoST/6VQ1FCf2JG
         1bqb6NKCaXtCArSaRpZ3ihCo7bdURDIXREHl5XWmUEqGXEl6skjcxeSNy/ypT22kblRd
         HFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW14YGEfeOGRABeDbTr1RUwsDEJWTp+aaGi68iKcMb7WiM+6ZCbftKskiK+y3OD35eCAG/ViUYd9jIh7PF1ZP6JN1QUAnQt/cL9tjR8G6ykQXOaQ+6GJN1dhSEPJ7YTIM4YgbI7rQfbcNJP46zN
X-Gm-Message-State: AOJu0Ywu57kR46f2ducyRjrZrvvgGZLZAUtHaPgGQ6OptfrIc1Coj4Ec
	aCWscK2KXRlkpy8idmAXW1mZe8QS3tJwl8ZwQB7HElBkhu/pVJs6
X-Google-Smtp-Source: AGHT+IEIML1fcbxEmifD6CYWnibQGgfrmZhaChuLVp5niogHyeL8TR72e1QzDfH14JBGB+amQfws3Q==
X-Received: by 2002:a2e:8046:0:b0:2ee:7c12:7b36 with SMTP id 38308e7fff4ca-2f15aaacc1dmr104556941fa.19.1722943976887;
        Tue, 06 Aug 2024 04:32:56 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaa2esm240389145e9.25.2024.08.06.04.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:32:56 -0700 (PDT)
Message-ID: <66b209e8.050a0220.1f20c8.5a92@mx.google.com>
X-Google-Original-Message-ID: <ZrIJ4y8S0sEtDOQ2@Ansuel-XPS.>
Date: Tue, 6 Aug 2024 13:32:51 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Philip Li <philip.li@intel.com>
Cc: kernel test robot <lkp@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
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
 <66b0b109.050a0220.93681.d015@mx.google.com>
 <ZrHrn9NzeOhp+Sdl@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrHrn9NzeOhp+Sdl@rli9-mobl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_043259_643245_0D966473 
X-CRM114-Status: GOOD (  30.53  )
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

On Tue, Aug 06, 2024 at 05:23:43PM +0800, Philip Li wrote:
> On Mon, Aug 05, 2024 at 04:54:45AM +0200, Christian Marangi wrote:
> > On Mon, Aug 05, 2024 at 06:52:04AM +0800, kernel test robot wrote:
> > > Hi Christian,
> > > 
> > > kernel test robot noticed the following build errors:
> > > 
> > > [auto build test ERROR on robh/for-next]
> > > [also build test ERROR on linus/master v6.11-rc1 next-20240802]
> > > [cannot apply to mtd/mtd/next mtd/mtd/fixes]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > 
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> > > patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
> > > patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
> > > config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
> > > compiler: xtensa-linux-gcc (GCC) 14.1.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >    drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
> > >    drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
> > >       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> > >          |                ^~~~~~~
> > > >> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> > >       33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> > >          |              ^
> > > 
> > > 
> > > vim +33 drivers/mtd/parsers/ofpart_airoha.c
> > > 
> > >     10	
> > >     11	int airoha_partitions_post_parse(struct mtd_info *mtd,
> > >     12					 struct mtd_partition *parts,
> > >     13					 int nr_parts)
> > >     14	{
> > >     15		struct mtd_partition *part;
> > >     16		int len, a_cells, s_cells;
> > >     17		struct device_node *pp;
> > >     18		struct property *prop;
> > >     19		const __be32 *reg;
> > >     20		__be32 *new_reg;
> > >     21	
> > >     22		part = &parts[nr_parts - 1];
> > >     23		pp = part->of_node;
> > >     24	
> > >     25		/* Skip if ART partition have a valid offset instead of a dynamic one */
> > >     26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
> > >     27			return 0;
> > >     28	
> > >     29		/* ART partition is set at the end of flash - size */
> > >     30		part->offset = mtd->size - part->size;
> > >     31	
> > >     32		/* Update the offset with the new calculate value in DT */
> > >   > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
> > Mhhh somehow I can't repro this with instructions?
> 
> Hi Ansuel, would you mind sharing the steps of reproduce? I can reproduce this with steps
> described in the repro link [1]
> 
> [1] https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce
>

Hi, thanks for confirming that. Manage to repro, just had dirty
build-dir and config wasn't correctly applying.

-- 
	Ansuel

