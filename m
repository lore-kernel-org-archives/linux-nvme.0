Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D5BC36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 21:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dffV1L61lSKvHP+naQW229RneaojE7BGB9VPXZP7TKc=; b=WikWsYjxf7IlGeDnAUkdjDXNzd
	c6YAyoF6FxRzps6zYn/47HVEFfI3xsL0vb3T2XQn17F5vlaPsHhEiZ/bfrKhTYgdA2yyXlCjLVdcR
	HYAgj+hqz+jE2w6CMrDPhPI9HpXIfeuTH4zaLb0/JxH+xv/kvOKTaNmQQGVINnPuXO4lO/PCpgjih
	Dw9F13Lm0z/jAWsjNGNX1n4igLniAWtsgO97DD6IoZYQ2g3LHBDa96jcOPAnWYwaRs5r2sG9tk7rt
	5gXsIngKSvnEyD8Q6uCnPoOxA30VaZPNVlE+6C2cNaI2NF6NDGbcRyccKoZ7VGeAVSqa7KsrI3/aB
	vsJZJ5kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1uJQ-0000000257h-2qO9;
	Mon, 07 Apr 2025 21:47:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1rk6-00000001juE-26sk
	for linux-nvme@bombadil.infradead.org;
	Mon, 07 Apr 2025 19:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dffV1L61lSKvHP+naQW229RneaojE7BGB9VPXZP7TKc=; b=UDzznplj7l+a8ZDdQewSvd1tz5
	yZbpnMoz9aVYPSB9yZ74SpV8+DfttddJxmEkNYLT4iXOp4IEpLb857Xe3fTn7Dj46lKuys8L/cFOD
	2mvIsamhPL9iG+ZfprnlNCTjRtsrOHVJR88lE4kUUuVV9C2nF4GrC0zjjLKreoudedcINzB8qfgFp
	/aQPo70iVksofNjQtSOImgzskbjHYr2KipHbc1d02YNBQJA5uvlJHZQKEK17srMZHeqsoax4nlSid
	Uk726GMb8o+nGjq/KN8wDgFG4jt191R5lTaI333D9B7GOXkSonx/mN3P8cWdqXzMI04Pz6iTmxyoH
	UbQc7OYQ==;
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1rk3-000000086xC-1F1k
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 19:02:45 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-af5499ca131so500161a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 12:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744052560; x=1744657360; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dffV1L61lSKvHP+naQW229RneaojE7BGB9VPXZP7TKc=;
        b=KgdSzgEWZ/F59+B2bDeqCCYIPBCyIxm+9cq5gwGO3KPHs0eR9yVUHgJZ+kqqqWoRbS
         iYb1hac5E6w4BJwNviMHvEoPKzOsBsLnsTAVcVKuqPCNNj+JeWwyqiyhZg5jrKJSH3Tl
         oqQVBD352xmOMYw2E6cAt6aPUUB/+Y2PmxE0Bh1d+wbm2S73ZEGEZiCNf1B/u8YCCd7V
         9ho3gcWAYK3QK3RlmycCforfQKt/trFQ9pLHOspMQP9iHaps36gKYguVvOJYC2TD2WxL
         g8RBvcNC67yzkpY0ZIUpdwlT5Dnx4DAxis1J/OsNIlwassQdSS3VMu8Y2Jo1IJM4ijjC
         lOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744052560; x=1744657360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dffV1L61lSKvHP+naQW229RneaojE7BGB9VPXZP7TKc=;
        b=AX+FV5WfTMu0Xowu5fY2qXYSTnEMIC/w2Hs+1kqQlsMCVVj0QdIpd+s73Kxp+SfDOe
         LzDnMpvYeiXQMS8oQK9/QU2dM9GXL4N30y54xeIejNi0eNWc5JRI0pUivinuG2X9o/vB
         4LUnp31B6KPTHgd8UTN/NawrAvpTE1F3hwnaZdH55VX6cSv2Ddo3QeHA1Zykz6/Au3fi
         vogwlvezgktQTqXA+wYIk1Uq60+Kh0RVEqL+M9LU873EL9whm7h3boL0wJblZBfgNaEa
         pMEZPqHpWZVWkMJxnWptpQHfi3ciaqC1vZ6CbbJxmPjU8ny3nIUIVEsVbGWIM3OEae//
         sVUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdrRsDDUhSVLRR4fF2JZDat8sCfdlmrNMYZU/IY1/4rJ4Bk2Gqed8yUod8MAr+DIPROF3L/ZqO4IYN@lists.infradead.org
X-Gm-Message-State: AOJu0Yz03w9Ks5an3Cb4lAen+Up7dujDubVyxk2llCEDHY1laA6sjsuE
	cOJPTOex4+DacPGQyokzKhiAHhRTxz2UfUNnG/dRw3KgZlaPkT5o2E2QJxECrnQ39xtZY7hEcMG
	WnSXJ/iObxngDywR3V4rArmBHeS9PWT65wbKs5w==
X-Gm-Gg: ASbGnctILULhoEO/AHvQYQ+t/sDzyIJj83ppEY841IRU7urPKtsM+OCYrEHKM5mWuc9
	jrlGtE1FEBLHCe7a9SdQqEnuSgCpd7CtmsijQ9DSkPUSjypKH5Pxvs1nFSxGxbZtK3Z+5HU5rKH
	R/DXrvT/z+IDkar0+JFid0aPFht2xEFFSkEQ71
X-Google-Smtp-Source: AGHT+IHxiMtBLuE7HFtmvkPpSsjkuRidn3zZS30dHJvwFFeUSCiUjfZOrL88kgkuADRqoBm6z6E9g2rmSll++4dbQAI=
X-Received: by 2002:a17:90b:4f89:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-306a4865251mr6629267a91.3.1744052560223; Mon, 07 Apr 2025
 12:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <202504080139.KuphZ8ZZ-lkp@intel.com>
In-Reply-To: <202504080139.KuphZ8ZZ-lkp@intel.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 7 Apr 2025 12:02:27 -0700
X-Gm-Features: ATxdqUH-84qMH5h1xUTAKjO-bNIGNmH02qZY_0CIgwd8upVXFURnSidMpvgLrhU
Message-ID: <CADUfDZpvMAGheJ-k7jTa3pfjuTXCCZPt-iprnfd_HHAfS5+ghA@mail.gmail.com>
Subject: Re: [linux-nvme:nvme-6.15 3/4] drivers/nvme/host/core.c:4302:5:
 warning: 'CONFIG_NVME_MULTIPATH' is not defined, evaluates to 0
To: kernel test robot <lkp@intel.com>
Cc: Hannes Reinecke <hare@kernel.org>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_200243_521931_6867E9C4 
X-CRM114-Status: GOOD (  11.95  )
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

On Mon, Apr 7, 2025 at 11:54=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   git://git.infradead.org/nvme.git nvme-6.15
> head:   9e270930d683ff0207fed7f303988a7ad63ddfcb
> commit: a98aa32696a1a19814a2f97853400b28622c6a8f [3/4] nvme: re-read ANA =
log page after ns scan completes
> config: riscv-randconfig-002-20250408 (https://download.01.org/0day-ci/ar=
chive/20250408/202504080139.KuphZ8ZZ-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 9=
2c93f5286b9ff33f27ff694d2dc33da1c07afdd)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250408/202504080139.KuphZ8ZZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202504080139.KuphZ8ZZ-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/nvme/host/core.c:4302:5: warning: 'CONFIG_NVME_MULTIPATH' is n=
ot defined, evaluates to 0 [-Wundef]
>     4302 | #if CONFIG_NVME_MULTIPATH
>          |     ^
>    1 warning generated.

Looks like it should be #ifdef instead?

Best,
Caleb

