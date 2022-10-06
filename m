Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C40C433FE
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ENsN90teNsuQpmekN7b+hdYLbg48hC1jdG1eR+cyBQ=; b=vCgeLwB4nLys7kEdJiy1S7Oepe
	f86NOqYec+2EPwjz2D7nU4ebB3xXhtC74PwZ+ugY+oTrP88jgP/AvGHa+ZNJeAyFOU6Mg0gqcY3LM
	22OSi1Ma9DLVKgd0RbOnwHZFwX/SI4vF6KE0HBAiKG/uuWPUq6D9BV3qhh28CqnsMdeuLPyWOPes9
	tE27JoOwMY4LzTQjSFfFvgNIGYcttES2mDXVTUczsLuX99jGgMdngnDTnS9OyTwSbLV965xUXgWb+
	nHx7edt0lktjxmNxDo/XBk8wdbin19UPh3ocIyAKRAnUAMgHGDdJZJAG88Qg/1dV+KriLYPMBfRrg
	y1tYv6dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogSOe-003CQM-Bt; Thu, 06 Oct 2022 15:02:48 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogQZb-002WeS-5p; Thu, 06 Oct 2022 13:06:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665061559; x=1696597559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FGTLdaiXSBCapn2JjYMa8Pm3byrwndmRCKrokbx26S8=;
  b=k0VxN2CUddDkOjizs4TP4N7jytwzUt44QuTUvwLzER1gqZHQ1v6ocZIM
   BkZv1bDIQzW/a89qvQCtHU7mvHx8GCe12navTH0iUbcLPCvzRFK1gblfr
   0z98UvJyTcPO0W9SBj3O8EUCZdZAY5aYXoMXoNdKDns2w8MHafzIn/ZQc
   gcdmNAHZHNPfCERh/ZBdtwLjzgjJ4qJT7oZSCjMifS5a3CGHGnF7CZQng
   imtAPtvqwgwPGdPZ/xyI2QtUdunoydlF0ti/RHRPvOmelMaEMY2ChBWaP
   uNr0XJyQxzS9896bwDYgOlHzw9cLHp0NmDiICoyrfyVjYgZIsj5ABoLbp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301036980"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="301036980"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 06:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="575816142"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="575816142"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2022 06:05:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ogQZ0-0039VB-0C;
	Thu, 06 Oct 2022 16:05:22 +0300
Date: Thu, 6 Oct 2022 16:05:21 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Ajay Singh <ajay.kathat@microchip.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Amitkumar Karwar <amitkarwar@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Gospodarek <andy@greyhouse.net>,
	Andy Lutomirski <luto@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Anna Schumaker <anna@kernel.org>,
	Arend van Spriel <aspriel@gmail.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Borislav Petkov <bp@alien8.de>, Chao Yu <chao@kernel.org>,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
	Franky Lin <franky.lin@broadcom.com>,
	Ganapathi Bhat <ganapathi017@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Greenman <gregory.greenman@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Hannes Reinecke <hare@suse.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Hao Luo <haoluo@google.com>, Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Hugh Dickins <hughd@google.com>,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Ilya Dryomov <idryomov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Jack Wang <jinpu.wang@ionos.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	James Smart <james.smart@broadcom.com>, Jan Kara <jack@suse.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Jean-Paul Roubelat <jpr@f6fbb.org>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jiri Olsa <jolsa@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Fastabend <john.fastabend@gmail.com>,
	John Stultz <jstultz@google.com>, Jon Maloy <jmaloy@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Julian Anastasov <ja@ssi.bg>, KP Singh <kpsingh@kernel.org>,
	Kalle Valo <kvalo@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Leon Romanovsky <leon@kernel.org>,
	Manish Rangankar <mrangankar@marvell.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Marco Elver <elver@google.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Md . Haris Iqbal" <haris.iqbal@ionos.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michael Jamet <michael.jamet@intel.com>,
	Michal Januszewski <spock@gentoo.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nilesh Javali <njavali@marvell.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Richard Weinberger <richard@nod.at>,
	Rohit Maheshwari <rohitm@chelsio.com>,
	Russell King <linux@armlinux.org.uk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Sharvari Harisangam <sharvari.harisangam@nxp.com>,
	Simon Horman <horms@verge.net.au>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>,
	Thomas Graf <tgraf@suug.ch>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Varun Prakash <varun@chelsio.com>,
	Veaceslav Falico <vfalico@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
	Vinod Koul <vkoul@kernel.org>, Vlad Yasevich <vyasevich@gmail.com>,
	Wenpeng Liang <liangwenpeng@huawei.com>,
	Xinming Hu <huxinming820@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ying Xue <ying.xue@windriver.com>,
	Yishai Hadas <yishaih@nvidia.com>, Yonghong Song <yhs@fb.com>,
	Yury Norov <yury.norov@gmail.com>,
	brcm80211-dev-list.pdl@broadcom.com, cake@lists.bufferbloat.net,
	ceph-devel@vger.kernel.org, coreteam@netfilter.org,
	dccp@vger.kernel.org, dev@openvswitch.org,
	dmaengine@vger.kernel.org, drbd-dev@lists.linbit.com,
	dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com,
	linux-actions@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hams@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-xfs@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, lvs-devel@vger.kernel.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	rds-devel@oss.oracle.com, SHA-cyfmac-dev-list@infineon.com,
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v1 1/5] treewide: use prandom_u32_max() when possible
Message-ID: <Yz7SkWBbabFQrecB@smile.fi.intel.com>
References: <20221005214844.2699-1-Jason@zx2c4.com>
 <20221005214844.2699-2-Jason@zx2c4.com>
 <202210052035.A1020E3@keescook>
 <Yz7N5WsqmKiUl+6b@zx2c4.com>
 <Yz7QN3cbKABexzoB@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7QN3cbKABexzoB@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221006_060559_266626_0240B3D2 
X-CRM114-Status: GOOD (  30.99  )
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

On Thu, Oct 06, 2022 at 09:55:19AM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 06, 2022 at 06:45:25AM -0600, Jason A. Donenfeld wrote:
> > On Wed, Oct 05, 2022 at 09:16:50PM -0700, Kees Cook wrote:
> > > On Wed, Oct 05, 2022 at 11:48:40PM +0200, Jason A. Donenfeld wrote:
> > > > Rather than incurring a division or requesting too many random bytes for
> > > > the given range, use the prandom_u32_max() function, which only takes
> > > > the minimum required bytes from the RNG and avoids divisions.
> > > 
> > > Yes please!
> > > 
> > > Since this is a treewide patch, it's helpful for (me at least) doing
> > > reviews to detail the mechanism of the transformation.
> > 
> > This is hand done. There were also various wrong seds done. And then I'd
> > edit the .diff manually, and then reapply it, as an iterative process.
> > No internet on the airplane, and oddly no spatch already on my laptop (I
> > think I had some Gentoo ocaml issues at some point and removed it?).
> > 
> > > e.g. I imagine this could be done with something like Coccinelle and
> > 
> > Feel free to check the work here by using Coccinelle if you're into
> > that.
> 
> Generally these series are a lot easier to review if it is structured
> as a patches doing all the unusual stuff that had to be by hand
> followed by an unmodified Coccinelle/sed/etc handling the simple
> stuff.
> 
> Especially stuff that is reworking the logic beyond simple
> substitution should be one patch per subsystem not rolled into a giant
> one patch conversion.
> 
> This makes the whole workflow better because the hand-done stuff can
> have a chance to flow through subsystem trees.

+1 to all arguments for the splitting.

I looked a bit into the code I have the interest to, but I won't spam people
with not-so-important questions / comments / tags, etc.

-- 
With Best Regards,
Andy Shevchenko



