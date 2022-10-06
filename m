Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BEBC433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79D/+k/bRZXhGBAaempdgng3l68Zp7pbnLAWamJJEQU=; b=lRK0trYw6BRPufWKwZyI7kNqxU
	2dJlGEMNAOMGOvopzoc1ovJ9BRdgf9VVo+hdOliOWQf4gpqU0gg5oLI+KGStXeshvY5qpswbDP2c+
	d+02UY+0IZbEQNuQyddb4CHfN05syolPR53XKPWMiECjPICaZcjsdin7lsNs02Cq9q0s7YIlYcyeK
	Uk6VNKmxu+22+FtgM/shZsHbWR/jepMmX4FR5kUT7w6Hba2Co4jyEmmmrvLDa4tFrY4gijxsflOQr
	u64wR7yBUvJ433nHU+iJdN+SCwcLcd6y0DI7QLCChW7k3b0K9ePdbGPtIoEm7OZzmWKYFGw1g01Xm
	6pUUQS2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogKN6-0009Qj-97; Thu, 06 Oct 2022 06:28:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogIPF-00HLwg-DJ
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 04:22:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 11CCB61876
	for <linux-nvme@lists.infradead.org>; Thu,  6 Oct 2022 04:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE112C4FEBF
	for <linux-nvme@lists.infradead.org>; Thu,  6 Oct 2022 04:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665030161;
	bh=HB4K7E86nsfwh8pjE5w4FJpZB/dXbKFz0OtI2RFCH+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sovw+cMG1PqLu3BzWeR5UstVr29Ayo36LHZjAiDcfG20hbLu76k5LKE18tIq5krU9
	 2IlB4duW8vX1hOnpq03B41LTEc7Wa5d0AGgAs71PAR/M4iDr/bTeeDH1FloO1irXn2
	 qyxMF4VVts5BCRediQoi+Safq01SOpOrcKX0H3I19tPcIWSCoK5Dyb0UKru6HoTuR1
	 vlK/vQjlJBmjjMMWBLASnCnLuMi6HFCToTu24EHP4xItpTqpQuqDPRook7owBtQJZ9
	 IPIHGEfoZ/tk2tw3ErCHQAkeB5/XSwS75qAaOVQYfkwmkURMi6cycxAciQq4oGw2vv
	 f2vjWVjZrIETg==
Received: by mail-lf1-f43.google.com with SMTP id r14so970099lfm.2
        for <linux-nvme@lists.infradead.org>; Wed, 05 Oct 2022 21:22:41 -0700 (PDT)
X-Gm-Message-State: ACrzQf0oa09eob5jNk+ie+m24NR4cph/TpnmB3EkPv3IMqq+Yq8MwvH8
	FXYkaaozgY8G3NHPq/7xF9E4ptgv2UzzICRq2mpaAQ==
X-Google-Smtp-Source: AMsMyM4buFniz46ZSiVKh/+EZ3E6CrEv7WC+W0XWrOZd99wlz7Q68ThxnzcjqPbpKa49LlF82wYrc2S5syRYJ4jy1zU=
X-Received: by 2002:a2e:7318:0:b0:26d:fdd9:6b2 with SMTP id
 o24-20020a2e7318000000b0026dfdd906b2mr1076019ljc.156.1665030148829; Wed, 05
 Oct 2022 21:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221005214844.2699-1-Jason@zx2c4.com> <20221005214844.2699-2-Jason@zx2c4.com>
 <202210052035.A1020E3@keescook>
In-Reply-To: <202210052035.A1020E3@keescook>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 5 Oct 2022 21:22:17 -0700
X-Gmail-Original-Message-ID: <CACYkzJ6w6DitDk9uoEyyNeg+HmNHZx_tckJ_=EroqmT=CN3VBA@mail.gmail.com>
Message-ID: <CACYkzJ6w6DitDk9uoEyyNeg+HmNHZx_tckJ_=EroqmT=CN3VBA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] treewide: use prandom_u32_max() when possible
To: Kees Cook <keescook@chromium.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, 
	Ajay Singh <ajay.kathat@microchip.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Amitkumar Karwar <amitkarwar@gmail.com>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
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
	Jason Gunthorpe <jgg@ziepe.ca>, Jay Vosburgh <j.vosburgh@gmail.com>, Jean-Paul Roubelat <jpr@f6fbb.org>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, 
	John Fastabend <john.fastabend@gmail.com>, John Stultz <jstultz@google.com>, 
	Jon Maloy <jmaloy@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, Julian Anastasov <ja@ssi.bg>, Kalle Valo <kvalo@kernel.org>, 
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
X-CRM114-CacheID: sfid-20221005_212245_542934_5291EFB8 
X-CRM114-Status: GOOD (  30.89  )
X-Mailman-Approved-At: Wed, 05 Oct 2022 23:27:55 -0700
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

On Wed, Oct 5, 2022 at 9:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 05, 2022 at 11:48:40PM +0200, Jason A. Donenfeld wrote:
> > Rather than incurring a division or requesting too many random bytes for
> > the given range, use the prandom_u32_max() function, which only takes
> > the minimum required bytes from the RNG and avoids divisions.
>
> Yes please!
>
> Since this is a treewide patch, it's helpful for (me at least) doing
> reviews to detail the mechanism of the transformation.
>
> e.g. I imagine this could be done with something like Coccinelle and
>
> @no_modulo@
> expression E;
> @@
>
> -       (prandom_u32() % (E))
> +       prandom_u32_max(E)
>
> > diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
> > index 118248a5d7d4..4236c799a47c 100644
> > --- a/drivers/mtd/ubi/debug.h
> > +++ b/drivers/mtd/ubi/debug.h
> > @@ -73,7 +73,7 @@ static inline int ubi_dbg_is_bgt_disabled(const struct ubi_device *ubi)
> >  static inline int ubi_dbg_is_bitflip(const struct ubi_device *ubi)
> >  {
> >       if (ubi->dbg.emulate_bitflips)
> > -             return !(prandom_u32() % 200);
> > +             return !(prandom_u32_max(200));
> >       return 0;
> >  }
> >
>
> Because some looks automated (why the parens?)
>
> > @@ -393,14 +387,11 @@ static struct test_driver {
> >
> >  static void shuffle_array(int *arr, int n)
> >  {
> > -     unsigned int rnd;
> >       int i, j;
> >
> >       for (i = n - 1; i > 0; i--)  {
> > -             rnd = prandom_u32();
> > -
> >               /* Cut the range. */
> > -             j = rnd % i;
> > +             j = prandom_u32_max(i);
> >
> >               /* Swap indexes. */
> >               swap(arr[i], arr[j]);
>
> And some by hand. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

Reviewed-by: KP Singh <kpsingh@kernel.org>


>
> --
> Kees Cook

