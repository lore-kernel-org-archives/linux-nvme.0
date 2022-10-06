Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB47C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PDyor0OPorRMVekuFSJiAglRmrxBh1riIl1rICqIsks=; b=qL1C9b7pwDEBx2CmtZ0kCmij6N
	PxITBZkc6hTXxn7n1m4tR3icFlKkXH6AIXJj1/yk/rFrCuK/se1yEzpJF2XP0eYHUnIIMlFUI4x8J
	57DMiwk/DG5uNxAa+3bHemlRhrFwmzoCOzyYHMpTijJDjgR0pirKsJ5NQLEBuwhdKqLOr5ixANh23
	dM9q+ChLj99n66YT83OsxxmpLDQBuaJ35jKi1cOwgHCebDushUZyQaCKURuz95J2aiE0mzXRw1iu5
	dn3y+EUH96QzgYU6SfjHxS0J4p2qmuod7Ncgg8b0e3YlZBEGqrxLRAIZuiSAtF8RulaJUoPAInMNY
	SBB4UAWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogSNq-003C5h-Qn; Thu, 06 Oct 2022 15:01:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogQ4P-002JnD-3R; Thu, 06 Oct 2022 12:33:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD8A6189D;
	Thu,  6 Oct 2022 12:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CC2C433D6;
	Thu,  6 Oct 2022 12:33:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="boaVkmFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1665059607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PDyor0OPorRMVekuFSJiAglRmrxBh1riIl1rICqIsks=;
	b=boaVkmFeWj/P/2mwQH9q1gX7LNlMIfDuuF/jF0E1iusdkGap18NZ9sMOKKXCenUfGu1kBs
	OsFuQiM99GfLC9GZQ0iQjPl+iTbCo2UXzxz3nN8lhLRAzO97rrmctM7VRTQNz+DRBcdhZZ
	cSGHfymmDp55cC4uDg3E8k04jFUD4XI=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2c48390d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Oct 2022 12:33:26 +0000 (UTC)
Date: Thu, 6 Oct 2022 06:33:15 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Lunn <andrew@lunn.ch>, "Darrick J . Wong" <djwong@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-sctp@vger.kernel.org,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Andy Gospodarek <andy@greyhouse.net>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Rohit Maheshwari <rohitm@chelsio.com>,
	Michael Ellerman <mpe@ellerman.id.au>, ceph-devel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Nilesh Javali <njavali@marvell.com>,
	Jean-Paul Roubelat <jpr@f6fbb.org>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
	linux-nfs@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Andy Lutomirski <luto@kernel.org>, linux-hams@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-raid@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	linux-kernel@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	netfilter-devel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	linux-media@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Sharvari Harisangam <sharvari.harisangam@nxp.com>,
	linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Song Liu <song@kernel.org>, Eric Dumazet <edumazet@google.com>,
	target-devel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Stanislav Fomichev <sdf@google.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	drbd-dev@lists.linbit.com, dev@openvswitch.org,
	Leon Romanovsky <leon@kernel.org>, Helge Deller <deller@gmx.de>,
	Hugh Dickins <hughd@google.com>,
	James Smart <james.smart@broadcom.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Pravin B Shelar <pshelar@ovn.org>, Julian Anastasov <ja@ssi.bg>,
	coreteam@netfilter.org, Veaceslav Falico <vfalico@gmail.com>,
	Yonghong Song <yhs@fb.com>, Namjae Jeon <linkinjeon@kernel.org>,
	linux-crypto@vger.kernel.org,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Ganapathi Bhat <ganapathi017@gmail.com>,
	linux-actions@lists.infradead.org,
	Simon Horman <horms@verge.net.au>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Hao Luo <haoluo@google.com>, Theodore Ts'o <tytso@mit.edu>,
	Stephen Boyd <sboyd@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Florian Westphal <fw@strlen.de>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Jon Maloy <jmaloy@redhat.com>, Vlad Yasevich <vyasevich@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-wireless@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-nvme@lists.infradead.org,
	Michal Januszewski <spock@gentoo.org>,
	linux-mtd@lists.infradead.org, kasan-dev@googlegroups.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Xiubo Li <xiubli@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org,
	lvs-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
	Yury Norov <yury.norov@gmail.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, KP Singh <kpsingh@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Keith Busch <kbusch@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Franky Lin <franky.lin@broadcom.com>,
	Arend van Spriel <aspriel@gmail.com>, linux-ext4@vger.kernel.org,
	Wenpeng Liang <liangwenpeng@huawei.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Xinming Hu <huxinming820@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jeff Layton <jlayton@kernel.org>, linux-xfs@vger.kernel.org,
	netdev@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Amitkumar Karwar <amitkarwar@gmail.com>, linux-mm@kvack.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-f2fs-devel@lists.sourceforge.net,
	Jack Wang <jinpu.wang@ionos.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	rds-devel@oss.oracle.com, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-scsi@vger.kernel.org, dccp@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Jason Gunthorpe <jgg@ziepe.ca>, SHA-cyfmac-dev-list@infineon.com,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Michael Jamet <michael.jamet@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-block@vger.kernel.org,
	dmaengine@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jens Axboe <axboe@kernel.dk>,
	cake@lists.bufferbloat.net, brcm80211-dev-list.pdl@broadcom.com,
	Yishai Hadas <yishaih@nvidia.com>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	linuxppc-dev@lists.ozlabs.org, David Ahern <dsahern@kernel.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Vinod Koul <vkoul@kernel.org>,
	tipc-discussion@lists.sourceforge.net, Thomas Graf <tgraf@suug.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [f2fs-dev] [PATCH v1 3/5] treewide: use get_random_u32() when
 possible
Message-ID: <Yz7LCyIAHC6l5mG9@zx2c4.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
 <20221005214844.2699-4-Jason@zx2c4.com>
 <20221006084331.4bdktc2zlvbaszym@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006084331.4bdktc2zlvbaszym@quack3>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_053345_248219_606B94D0 
X-CRM114-Status: GOOD (  25.34  )
X-Mailman-Approved-At: Thu, 06 Oct 2022 08:01:46 -0700
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

On Thu, Oct 06, 2022 at 10:43:31AM +0200, Jan Kara wrote:
> The code here is effectively doing the
> 
> 	parent_group = prandom_u32_max(ngroups);
> 
> Similarly here we can use prandom_u32_max(ngroups) like:
> 
> 		if (qstr) {
> 			...
> 			parent_group = hinfo.hash % ngroups;
> 		} else
> 			parent_group = prandom_u32_max(ngroups);

Nice catch. I'll move these to patch #1.


> > diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> > index 9af68a7ecdcf..588cb09c5291 100644
> > --- a/fs/ext4/mmp.c
> > +++ b/fs/ext4/mmp.c
> > @@ -265,7 +265,7 @@ static unsigned int mmp_new_seq(void)
> >  	u32 new_seq;
> >  
> >  	do {
> > -		new_seq = prandom_u32();
> > +		new_seq = get_random_u32();
> >  	} while (new_seq > EXT4_MMP_SEQ_MAX);
> 
> OK, here we again effectively implement prandom_u32_max(EXT4_MMP_SEQ_MAX + 1).
> Just presumably we didn't want to use modulo here because EXT4_MMP_SEQ_MAX
> is rather big and so the resulting 'new_seq' would be seriously
> non-uniform.

I'm not handling this during this patch set, but if in the course of
review we find enough places that want actually uniformly bounded
integers, I'll implement efficient rejection sampling to clean up these
cases, with something faster and general, and add a new function for it.
So far this is the first case to come up, but we'll probably eventually
find others. So I'll make note of this.

Jason

