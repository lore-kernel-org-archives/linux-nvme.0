Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA086C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pA8UwcaEH1EIaWBd+j+3kMQvSGVLEaIn/zvGprOy4bY=; b=dt/W5gdhw7+wHb/F81TITHhJfc
	Up/VNIaHN2cFkOtf6SxiF8wAH95YNQyuvTRs8gB9qWV68J0RdF4v4GF+e3Xmi7IYAK3wj62jKUUxx
	Y3MKLzc/fRTAslM5L0PkIxYgiIPhRqy7n9o/m4EMi8s9A2MF/2GhBMYOG8RRu6Venz0SA5iHTUKjc
	vLxXFLe1jMVQJh5THrleLzCpkdUDqYyDbN9Br4WyTAr+YQKbU1Jko9z6cujsKBmhd6ojHn3+ldakF
	ebVn3HvAK+/cP3X2sWVZYDB3sDS7f/KKJEKEeD9Ygdp4fc8JHhH9ySFecSvLu12Jus6905EaUgOn/
	dTBrjcjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogSOt-003CVW-HT; Thu, 06 Oct 2022 15:03:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogQa8-002Wtx-R5; Thu, 06 Oct 2022 13:06:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 583F96199D;
	Thu,  6 Oct 2022 13:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5120C43142;
	Thu,  6 Oct 2022 13:06:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AuLKX8Dr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665061583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pA8UwcaEH1EIaWBd+j+3kMQvSGVLEaIn/zvGprOy4bY=;
	b=AuLKX8DrexCaNcujtUc0wUOn6ZKYPxocCGUtsQ/xLo5zn9UlWE+se5mcJ1GdJKakmd68Cu
	zFNfO+H4CDBOx88U2U8iDMf5m8nlkrM8e7vsoJOojyzr28eChFXzvAHcN4AVzZnJW4K0oJ
	BdT+U8NEjgfOf1F1bQBHV1MnZd+JA8E=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id db77e84b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Oct 2022 13:06:22 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id 3so1924427vsh.5;
        Thu, 06 Oct 2022 06:06:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf2FdUVfoSNUdWKMK5lpcOZ6Bx8pvxN8k16upAS23nzdmPCr1lg2
	7j0lpEHHBSIlYQDRdla85q0oAC5vWyYHh/ltT9U=
X-Google-Smtp-Source: AMsMyM6FGZA2PC9dWVIDS+xWc3c+LtiQF9tezH4UggVMiZNKZxhMdBw8vpoz5pzuUaEI5CnlY9d0+H7OwJQF18qhy/U=
X-Received: by 2002:a1f:e0c4:0:b0:3ab:191d:e135 with SMTP id
 x187-20020a1fe0c4000000b003ab191de135mr2112405vkg.41.1665061560263; Thu, 06
 Oct 2022 06:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221005214844.2699-1-Jason@zx2c4.com> <20221005214844.2699-4-Jason@zx2c4.com>
 <Yz7OdfKZeGkpZSKb@ziepe.ca>
In-Reply-To: <Yz7OdfKZeGkpZSKb@ziepe.ca>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 6 Oct 2022 07:05:48 -0600
X-Gmail-Original-Message-ID: <CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
Message-ID: <CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] treewide: use get_random_u32() when possible
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Amitkumar Karwar <amitkarwar@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Andreas Noever <andreas.noever@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Andy Gospodarek <andy@greyhouse.net>, Andy Lutomirski <luto@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Anna Schumaker <anna@kernel.org>, 
	Arend van Spriel <aspriel@gmail.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Borislav Petkov <bp@alien8.de>, Chao Yu <chao@kernel.org>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	Christoph Hellwig <hch@lst.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Chuck Lever <chuck.lever@oracle.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "Darrick J . Wong" <djwong@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Dick Kennedy <dick.kennedy@broadcom.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Franky Lin <franky.lin@broadcom.com>, 
	Ganapathi Bhat <ganapathi017@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Gregory Greenman <gregory.greenman@intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Hannes Reinecke <hare@suse.de>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, Hao Luo <haoluo@google.com>, 
	Haoyue Xu <xuhaoyue1@hisilicon.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Hugh Dickins <hughd@google.com>, 
	Igor Mitsyanko <imitsyanko@quantenna.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Ingo Molnar <mingo@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	"James E . J . Bottomley" <jejb@linux.ibm.com>, James Smart <james.smart@broadcom.com>, Jan Kara <jack@suse.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Jean-Paul Roubelat <jpr@f6fbb.org>, Jeff Layton <jlayton@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Jiri Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Johannes Berg <johannes@sipsolutions.net>, John Fastabend <john.fastabend@gmail.com>, 
	John Stultz <jstultz@google.com>, Jon Maloy <jmaloy@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Julian Anastasov <ja@ssi.bg>, KP Singh <kpsingh@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Keith Busch <kbusch@kernel.org>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Leon Romanovsky <leon@kernel.org>, Manish Rangankar <mrangankar@marvell.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Marco Elver <elver@google.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>, Michael Chan <michael.chan@broadcom.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michael Jamet <michael.jamet@intel.com>, 
	Michal Januszewski <spock@gentoo.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Nilesh Javali <njavali@marvell.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Pravin B Shelar <pshelar@ovn.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Richard Weinberger <richard@nod.at>, Rohit Maheshwari <rohitm@chelsio.com>, 
	Russell King <linux@armlinux.org.uk>, Sagi Grimberg <sagi@grimberg.me>, 
	Santosh Shilimkar <santosh.shilimkar@oracle.com>, Sergey Matyukevich <geomatsi@gmail.com>, 
	Sharvari Harisangam <sharvari.harisangam@nxp.com>, Simon Horman <horms@verge.net.au>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, 
	Thomas Sailer <t.sailer@alumni.ethz.ch>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Varun Prakash <varun@chelsio.com>, Veaceslav Falico <vfalico@gmail.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, Vinod Koul <vkoul@kernel.org>, 
	Vlad Yasevich <vyasevich@gmail.com>, Wenpeng Liang <liangwenpeng@huawei.com>, 
	Xinming Hu <huxinming820@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Yehezkel Bernat <YehezkelShB@gmail.com>, Ying Xue <ying.xue@windriver.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Yonghong Song <yhs@fb.com>, Yury Norov <yury.norov@gmail.com>, 
	brcm80211-dev-list.pdl@broadcom.com, cake@lists.bufferbloat.net, 
	ceph-devel@vger.kernel.org, coreteam@netfilter.org, dccp@vger.kernel.org, 
	dev@openvswitch.org, dmaengine@vger.kernel.org, drbd-dev@lists.linbit.com, 
	dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com, 
	linux-actions@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lvs-devel@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com, 
	SHA-cyfmac-dev-list@infineon.com, target-devel@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_060632_964390_AD5234FF 
X-CRM114-Status: GOOD (  24.43  )
X-Mailman-Approved-At: Thu, 06 Oct 2022 08:01:47 -0700
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

On Thu, Oct 6, 2022 at 6:47 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Oct 05, 2022 at 11:48:42PM +0200, Jason A. Donenfeld wrote:
>
> > index 14392c942f49..499a425a3379 100644
> > --- a/drivers/infiniband/hw/cxgb4/cm.c
> > +++ b/drivers/infiniband/hw/cxgb4/cm.c
> > @@ -734,7 +734,7 @@ static int send_connect(struct c4iw_ep *ep)
> >                                  &ep->com.remote_addr;
> >       int ret;
> >       enum chip_type adapter_type = ep->com.dev->rdev.lldi.adapter_type;
> > -     u32 isn = (prandom_u32() & ~7UL) - 1;
> > +     u32 isn = (get_random_u32() & ~7UL) - 1;
>
> Maybe this wants to be written as
>
> (prandom_max(U32_MAX >> 7) << 7) | 7
>
> ?

Holy smokes. Yea I guess maybe? It doesn't exactly gain anything or
make the code clearer though, and is a little bit more magical than
I'd like on a first pass.

>
> > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > index fd9d7f2c4d64..a605cf66b83e 100644
> > --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > @@ -465,7 +465,7 @@ static int ipoib_cm_req_handler(struct ib_cm_id *cm_id,
> >               goto err_qp;
> >       }
> >
> > -     psn = prandom_u32() & 0xffffff;
> > +     psn = get_random_u32() & 0xffffff;
>
>  prandom_max(0xffffff + 1)

That'd work, but again it's not more clear. Authors here are going for
a 24-bit number, and masking seems like a clear way to express that.

Jason

