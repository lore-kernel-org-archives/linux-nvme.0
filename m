Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88078CD343F
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 07:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	Subject:Cc:To:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52DzbEHzEBNbbaVo2O/gpb2Tqel0TxNOY9C7jkDJOUU=; b=4/b4+rgVJ0WQhuSMIClRu+6qLc
	6xRe2b/GN4uu07u5x4NM/x3zhcBls8OsqCNJdBDOpKJDS4iVqeFWS9wKDGQrOasbvKnv0fvvQcH9R
	lk5tva2+bICtIluMrrQBJixz6uERPHusRuUrDJCUXE0eSiCR5MTNsMeO7bLu7h+0I/kwiatcNPadk
	52mJD89hhanu/Zjqk6mGLKBE1G9cXf86Hxid5zabx/r8vOZfWDafzZHhdb/TGVP7dze2vOqPYubqL
	qteyuOLRD0391tH5tnxcVtsVc7eMAr0QjVag80sESV4zb+sCabJE/HVrh0Mh40Fex9E2qaDr7qjNc
	zJ3UiJSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPy86-000000070R3-2p5e;
	Thu, 21 May 2026 07:47:42 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPy83-000000070Oa-2p8U
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 07:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=Q7JlUr20XxkXkx
	bgEb4n3pZYQJPq50GYEkIt7lW1QxY=; h=in-reply-to:references:from:subject:
	cc:to:date; d=arkamax.eu; b=H8DBzIXhrF+G5Jbv2P47PJ867d8bO7dv70PYqLBcpM
	nxfy2SDYyCvAtfalWJg6ywhEajEMFzc8Rx029k7RZ32Yot1JrwGu0Ts6xyvgCXwiFq4i9O
	B7z5OvIUuUdAISVPKePKIzp6BI5s3Nrq8Ex9TXi7ugX6kINJJX++QMLjGs/Yl3Mmbd/qMm
	/hNF1Ddp4ACGIZPXABXTubXJOLs6n0Ts7VL/5YYXK7jItZ8AYc1juOAzVRlwXwX0ocLBKu
	nxPWm8wugYeYpirEW3GugbdXgYqTmMlV0yvI1JfEwpnK+2ghrWPJaPyQ1lkxm1CuvHkdCT
	rkmRixH7smc+tBTJoaRQ==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 714b2eac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 09:47:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 May 2026 09:47:33 +0200
Message-Id: <DIO6T626SKY5.2B5MK3VFURQY9@arkamax.eu>
To: "Dan Carpenter" <error27@gmail.com>, <oe-kbuild@lists.linux.dev>,
 "Maurizio Lombardi" <mlombard@redhat.com>
Cc: <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
 <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>,
 "Daniel Wagner" <dwagner@suse.de>, "Mohamed Khalfella"
 <mkhalfella@purestorage.com>, "Hannes Reinecke" <hare@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>
Subject: Re: [linux-nvme:nvme-7.2 2/7] drivers/nvme/host/core.c:5259
 nvme_wait_freeze_timeout() warn: 'timeout' unsigned <= 0
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
X-Mailer: aerc 0.21.0
References: <202605211257.STzj2Ujv-lkp@intel.com>
In-Reply-To: <202605211257.STzj2Ujv-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_004740_074166_F0C7514E 
X-CRM114-Status: UNSURE (   9.88  )
X-CRM114-Notice: Please train this message.
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

On Thu May 21, 2026 at 8:43 AM CEST, Dan Carpenter wrote:
> tree:   git://git.infradead.org/nvme.git nvme-7.2
> head:   00d7b33351aac0ea55d17167561e12bbeca73138
> commit: 23b6d2cbf75ff15647efbb7c0e5c03bd7ed1fe1a [2/7] nvme: remove redun=
dant timeout argument from nvme_wait_freeze_timeout
> config: s390-randconfig-r073-20260521 (https://download.01.org/0day-ci/ar=
chive/20260521/202605211257.STzj2Ujv-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> smatch: v0.5.0-9185-gbcc58b9c
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202605211257.STzj2Ujv-lkp@intel.com/
>
> smatch warnings:
> drivers/nvme/host/core.c:5259 nvme_wait_freeze_timeout() warn: 'timeout' =
unsigned <=3D 0
>
> vim +/timeout +5259 drivers/nvme/host/core.c
>
> 23b6d2cbf75ff15 Maurizio Lombardi 2026-05-14  5249  int nvme_wait_freeze_=
timeout(struct nvme_ctrl *ctrl)
> 302ad8cc09339ea Keith Busch       2017-03-01  5250  {
> 23b6d2cbf75ff15 Maurizio Lombardi 2026-05-14  5251  	unsigned long timeou=
t =3D NVME_IO_TIMEOUT;
>                                                         ^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
> This is unsigned.  NVME_IO_TIMEOUT is 30 * HZ.  Can the &ctrl->namespaces
> list ever be empty?

I already had a patch for this, I am going to submit it today.

https://lore.kernel.org/linux-nvme/4be04295-1b86-4dc3-abee-7d59c6c67ae9@flo=
urine.local/

Thanks.

>
> 302ad8cc09339ea Keith Busch       2017-03-01  5252  	struct nvme_ns *ns;
> be647e2c76b27f4 Keith Busch       2024-05-21  5253  	int srcu_idx;
> 302ad8cc09339ea Keith Busch       2017-03-01  5254 =20
> be647e2c76b27f4 Keith Busch       2024-05-21  5255  	srcu_idx =3D srcu_re=
ad_lock(&ctrl->srcu);
> 6d1c69945ce63a9 Breno Leitao      2024-11-04  5256  	list_for_each_entry_=
srcu(ns, &ctrl->namespaces, list,
> 6d1c69945ce63a9 Breno Leitao      2024-11-04  5257  				 srcu_read_lock_h=
eld(&ctrl->srcu)) {
> 302ad8cc09339ea Keith Busch       2017-03-01  5258  		timeout =3D blk_mq_=
freeze_queue_wait_timeout(ns->queue, timeout);
> 302ad8cc09339ea Keith Busch       2017-03-01 @5259  		if (timeout <=3D 0)
>
> blk_mq_freeze_queue_wait_timeout() returns 0 on timeout and >=3D 1 on
> success.
>
> 302ad8cc09339ea Keith Busch       2017-03-01  5260  			break;
> 302ad8cc09339ea Keith Busch       2017-03-01  5261  	}
> be647e2c76b27f4 Keith Busch       2024-05-21  5262  	srcu_read_unlock(&ct=
rl->srcu, srcu_idx);
> 7cf0d7c0f3c3b02 Sagi Grimberg     2020-07-30  5263  	return timeout;
>
> This returns is nonsense.  ;)  >=3D 1 on success or empty.  0 on timeout.
>
> 302ad8cc09339ea Keith Busch       2017-03-01  5264  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


