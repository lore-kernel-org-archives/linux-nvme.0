Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D1EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Oct 2022 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zga/kwguXOa9tZGzF2X+ZLpnzxGRszRa7j7kheBbr2g=; b=IBtMTjlWKS+HE3eRnzHGzAty5H
	b1F8Kg4qP8gJ9YmhvY6zS6dDGvPa+3bd6E8ILC48ae83Wq/77BYwOZC7G4WcjrRFUFLxbpjHmvFzN
	4dYFZsFj7g383r8jsq0WjZPSq7IebJgJXrtUpI6omCuBihOPNkpDcJqC9UBMPG4b3lucXzBxDb0u0
	kYm9z78hroC6lfW4LlikAEpJ698zimYx02QpIoQoqT1rzaSX6RJ/fFZgPlRgzzwHjLF86MChGPSgB
	kQAIrMyBBufO146gW/rMZ5xD9QfLtsh74trXkWbFJfSC6E/BnhZs7+hm2NTVrErC/hXOAiuWKSdVn
	1coz6EBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogKOK-0009r4-Lq; Thu, 06 Oct 2022 06:29:56 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogInt-00HSl8-5L
	for linux-nvme@lists.infradead.org; Thu, 06 Oct 2022 04:48:16 +0000
Received: by mail-pl1-x62d.google.com with SMTP id n7so709314plp.1
        for <linux-nvme@lists.infradead.org>; Wed, 05 Oct 2022 21:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Zga/kwguXOa9tZGzF2X+ZLpnzxGRszRa7j7kheBbr2g=;
        b=VDYXzBjTmlsVIl+Y4iF0uyvrgTLR7zDCDitOOtRhnnkCI+cj7BOAV+jXORmkdJC8NR
         kLVeoGGmNjWIzbs7ngaNL2av6vzDETZ5xNshsjkA6+Ddrv+XZy7wZSPrRI2h/WYQMveo
         FOjR6IXNtLQ2MzWVWNTzoDYr9QH87X51UPqiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Zga/kwguXOa9tZGzF2X+ZLpnzxGRszRa7j7kheBbr2g=;
        b=Cx8HKX5OaxxSjXabduqjShJDq1rZgN8RducjzqddGbgOw5QJ5Hks1lllpLVKBFSCq+
         On4DOdDawpZdE/ka/Y50qARSR4i1O36t4myrhLxtVJY94tC17NFciY+MoMeUYv2IFt1G
         Zuxb9h8Wg7Yen/muvot8+mK8LDcC9PqStgZ/zS8ycrA6Aju06VlzngCupRMK98npzUNl
         tuX6RxJyFa3UFmTNubmrCbVgfTPaGGxvassV9TcJcZLjNfuDBfjru9afP/S9C3TJgiI+
         dX+ZHEDpyb0afUSqBDAureD5nJQfOSgHnsg/HYN12yEOcVA8OI+BXEzCbO+2r11lrnfd
         nXRA==
X-Gm-Message-State: ACrzQf0tVrKGBCxiVMbQ4grDW/nw7e/WWi/W8NdZ36NAkcv2NB7Y0wt9
	Dt+JqtAt73fZOTI4uX9JNqkNcw==
X-Google-Smtp-Source: AMsMyM5noNd8dF5/8fuBkrlB/HNbt95GlgliJJ8jYtlN4mBVQXEji+jNlD1vk9tphNCBxko7f/llIA==
X-Received: by 2002:a17:90b:254b:b0:200:a860:5bf9 with SMTP id nw11-20020a17090b254b00b00200a8605bf9mr8436942pjb.176.1665031691628;
        Wed, 05 Oct 2022 21:48:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902dcd400b00178a8f4d4f2sm11197475pll.74.2022.10.05.21.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 21:48:10 -0700 (PDT)
Date: Wed, 5 Oct 2022 21:48:09 -0700
From: Kees Cook <keescook@chromium.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, Jay Vosburgh <j.vosburgh@gmail.com>,
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
Subject: Re: [PATCH v1 4/5] treewide: use get_random_bytes when possible
Message-ID: <202210052148.AA3C7BB@keescook>
References: <20221005214844.2699-1-Jason@zx2c4.com>
 <20221005214844.2699-5-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005214844.2699-5-Jason@zx2c4.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_214813_238325_9BA3563A 
X-CRM114-Status: GOOD (  17.22  )
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

On Wed, Oct 05, 2022 at 11:48:43PM +0200, Jason A. Donenfeld wrote:
> The prandom_bytes() function has been a deprecated inline wrapper around
> get_random_bytes() for several releases now, and compiles down to the
> exact same code. Replace the deprecated wrapper with a direct call to
> the real function.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Global search/replace matches. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

