Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145C7C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZljMHpeWKd3SSwk6GCDRfJRptCF6irGao5A/YsylnIQ=; b=hMwOppMRXKCDVIqasXIHX5qpfz
	YMp/ayHRO91d8fh12lPQpJ0gj2SqpSkeEoxndKfvOWz3KQ8zd/ZMMZOBAD1OmUCJPDcT832GKF/cp
	Uw26nXHWvJ4Ox9AvKhf16W2HuHqn/3NKYGpoqCQMVzLIEZr9l96Qg3kMMbuOBgDO9HTYS5mx0922I
	NvmrKOmMFE6i2735nJcLwDtirwoErb13p0HqXJ0Tx3oC9B1k4lwwBhiWy27R/Q/idcx2FGFf+01ga
	GrID/bH1MgfaB7lqh5n3wh2PVUnMXiBw+O1EpBq/RdTMzAHRPDFjo1tvhTqfnLP8JCiiS4n+2IET1
	a3F3u31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzgF-00DT6Q-VS; Tue, 15 Nov 2022 17:25:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzgA-00DSwj-Qa
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 17:25:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2089F61926;
	Tue, 15 Nov 2022 17:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C9C433B5;
	Tue, 15 Nov 2022 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668533097;
	bh=CA6i1sqRTbMa1FGKZ4RFb8QPs+epwJ3N8FFNkuCpEIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5QzybH/nnyVypx9C0Kw+ctxt3SAu3y1U7PoZReYnPXJmFK8GlugnmWlM07YFoYWa
	 MFhQR44Ulo5f/Ldtak9fH/l1IROiTL2kepcaXa4K2uo1E0Kyg8YkfQSDBiKPcT+/j4
	 BFXuOvFUaxDEXTkvKXTEaEQhAYOvF/cpMR1bIoJoNirzGC6TZGlYBlVOpVHAxgUqjR
	 mEqwsnqosvmpUZtidehhN92TqbUt7h1Y+5f90zJhb5acuyMm1I/vnIUFH/BWzyECI8
	 px3hXIG+vvaPPq7W8qlEwBpsUOyboanSWfbUIgLgeczRZFz7VGHU2dkwEBBLtIreBS
	 xQ8wpLN/MDsCQ==
Date: Tue, 15 Nov 2022 10:24:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/core.c:5122:6:
 error: assigning to 'int' from incompatible type 'void'
Message-ID: <Y3PLZxNwqioynAtw@dev-arch.thelio-3990X>
References: <202211160055.rbjs32vH-lkp@intel.com>
 <edda71f4-9912-d336-6d5b-0e1e102d4bfe@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edda71f4-9912-d336-6d5b-0e1e102d4bfe@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_092458_922314_6BA0326A 
X-CRM114-Status: GOOD (  21.74  )
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

On Tue, Nov 15, 2022 at 07:16:07PM +0200, Sagi Grimberg wrote:
> 
> > tree:   git://git.infradead.org/nvme.git nvme-6.2
> > head:   e2deb6d1a5b2dcff71f429a64fb516186aa0382c
> > commit: c1658b482f1bec9ebafa49eec69a29aebbc23556 [26/41] nvme-auth: don't ignore key generation failures when initializing ctrl keys
> > config: i386-randconfig-a016-20221114
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          git remote add linux-nvme git://git.infradead.org/nvme.git
> >          git fetch --no-tags linux-nvme nvme-6.2
> >          git checkout c1658b482f1bec9ebafa49eec69a29aebbc23556
> >          # save the config file
> >          mkdir build_dir && cp config build_dir/.config
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > drivers/nvme/host/core.c:5122:6: error: assigning to 'int' from incompatible type 'void'
> >             ret = nvme_auth_init_ctrl(ctrl);
> 
> Christoph,
> 
> Can you fold this into the offending commit please?
> --
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a50b0743728e..273f4f95f425 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1063,7 +1063,7 @@ static inline int nvme_init_auth(void)
>         return 0;
>  }
>  static inline void nvme_exit_auth(void) {};
> -static inline void nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};
> +static inline int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl) {};

Won't -Wreturn-type flag that this function is not returning a integer
value? I assume that wants 'return 0'?

Cheers,
Nathan

>  static inline void nvme_auth_stop(struct nvme_ctrl *ctrl) {};
>  static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
>  {
> --
> 
> If not, I can send a patch to fold in.
> 

