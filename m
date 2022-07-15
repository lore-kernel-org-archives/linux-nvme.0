Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11981C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jujfwG01dI+nm2T9PWfBuPM/ZuQZ4xaHDU/3x3esj7k=; b=M8fMpvjA8uHFq86lN+v3WwYVbS
	dMch1J+EwpsOxu9tDxNAQsznHdMRGlwnSrFndxqG0S70ttKdAT4MB9oS7Gc4anFM/hJGXdupSNEQ9
	EDuSogNESNssvI+3q/IceaCgUkDE4ZSoa01Um2CPHviFc0kTZYSF2JOKqt0y2kPKBU/wk2cGGsefM
	WD/Vgd0QM8rM7a1uKvGH+FSp3F4Bhst6XnXcsQjzdfA0Lv1x98tIIgSmZ5jbLIY2xr2IRCQDPINdU
	H1KFWu5qU2nOelQzyqVWHw1xXTORs0v1qwnG9Nl6ON5kjRpmttQbaSBBIOg6PkeqeYbwWllm5zny1
	O9vNwE3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQaE-009bAn-Na; Fri, 15 Jul 2022 19:02:38 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCQaD-009bAK-9g; Fri, 15 Jul 2022 19:02:37 +0000
Date: Fri, 15 Jul 2022 12:02:37 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: casey@schaufler-ca.com, axboe@kernel.dk, joshi.k@samsung.com,
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	a.manzanares@samsung.com, javier@javigon.com
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd
 file op
Message-ID: <YtG5zRPFV967/y0v@bombadil.infradead.org>
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
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

On Fri, Jul 15, 2022 at 02:46:16PM -0400, Paul Moore wrote:
> It looks like I owe you an apology, Luis.  While my frustration over
> io_uring remains, along with my disappointment that the io_uring
> developers continue to avoid discussing access controls with the LSM
> community, you are not the author of the IORING_OP_URING_CMD.   You
> are simply trying to do the right thing by adding the necessary LSM
> controls and in my confusion I likely caused you a bit of frustration;
> I'm sorry for that.

No frustration caused, I get it.

> Well, we're at -rc6 right now which means IORING_OP_URING_CMD is
> happening and it's unlikely the LSM folks are going to be able to
> influence the design/implementation much at this point so we have to
> do the best we can.  Given the existing constraints, I think your
> patch is reasonable (although please do shift the hook call site down
> a bit as discussed above), we just need to develop the LSM
> implementations to go along with it.
> 
> Luis, can you respin and resend the patch with the requested changes?

Sure thing.

> I also think we should mark the patches with a 'Fixes:' line that
> points at the IORING_OP_URING_CMD commit, ee692a21e9bf ("fs,io_uring:
> add infrastructure for uring-cmd").

I'll do that.

  Luis

