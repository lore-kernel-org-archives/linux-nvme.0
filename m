Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF7BE77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y6etkxpDUicIs/nPuVka7b5IJhhjIk8dVUqK5iKKriA=; b=1OtJ9voZucPOU5HG8RhNB/agao
	EpxNmB35vgc2seGmhSQPoXxxnkOrJj64vEDQmcQNarqJhnGexCHL8R5LJhiHx9e6DjybrcHGyuT3v
	lHKZOkACNQYhGVGW2ZvWNAT82QeUxlY7OfMJCI3ShQBcu3XdJcFlc5Qvry9xUjmQN+cItRrP38b5o
	DNVIMoF2U0sRoRFrqCsut1tSGzko6NhRkaun2+cttZQsluGANMOnQB6qn5BeiweCM/dt+g8Odx5+l
	0RqIb8f6wOaeDg8ZsAk8xb01s51aAKswIyoVBG/VaLXlbxjGrMGytNsSm1vl023z+NFvdfQYslNsv
	WPkiE/nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbav-00000002FPF-42Un;
	Fri, 06 Dec 2024 16:54:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbZy-00000002FCE-2XDp
	for linux-nvme@bombadil.infradead.org;
	Fri, 06 Dec 2024 16:53:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y6etkxpDUicIs/nPuVka7b5IJhhjIk8dVUqK5iKKriA=; b=mitovi/awzVJZWRgjYG9cXvUJM
	5iWj1/G8teIKtHY1Csq/Zq4pMEg3pDEvIPH9yBDbUWC7JwXb5LQtyCZFMYsGIkx/eSxA7eqx/H5FB
	ZAoxUaF7H7kkfn2zkkOoYvQZyZSkH6MF9kzMrchFp+6NIj+7bnaKRUCYE+g0YKalBr7FBTIwYGD6A
	3aG9tn/OMUU7Z3j/RV9gttIosQFeD+G/4ck9bVVALgpjLhQtRjUpAPWCC+ktsLsMSb1itLn5/agBl
	KUPhuXVvK0bMTWTZx9qCU4qxNl1ubc8YppRt1q4IdAW5n8oIWrVSTkBRgeSrrEe6/bjsC0SuRiqrh
	9IV3H/7Q==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJbZv-000000037Z1-3f5x
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 16:53:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 247725C5D90;
	Fri,  6 Dec 2024 16:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A8C4CED1;
	Fri,  6 Dec 2024 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733503996;
	bh=E4OmwzABQyPH64Cigqh7KGY0PBH7U5WPajekdK8ToSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OrmGSzWuLCUiSHe1eGmiA7DgbCZLdxqtps+bnCCJlChdAeuyqNmidVJz6Gew5u3sI
	 rY/UqZPfzKkKhtIfUFzJCQV5RVMrNDnW6WzxcFFhnHwg8JHG97+NZ+TOwpxLlz3HPe
	 bwI6zM6yDHq0103ngcU/ffITezcW009p7F5K9R3KQYedMsNjdTuWBlCiJ59YkFyEIf
	 bOQ3PAZbuFg7sE43mq82XhHKr8+9ycvChGIF1prNCRjDYW6mBZSDXo+65Tq+XHd0xK
	 +eVU/vsg7XxNMPDXNByKGhZj2HnalWHHHz369KspkTMHKXMlQNwUhJZbGM7kcojDJN
	 0/JOVR9T2oQgw==
Date: Fri, 6 Dec 2024 08:53:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	sagi@grimberg.me, asml.silence@gmail.com
Subject: Re: [PATCHv11 03/10] io_uring: add write stream attribute
Message-ID: <Z1Mr-rcFOVW2eS8-@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
 <CGME20241206015353epcas5p174318c263e73bfe8728d49b5e90a14e8@epcas5p1.samsung.com>
 <20241206015308.3342386-4-kbusch@meta.com>
 <bcfd9c63-797b-4f6b-aa6e-0e639247003b@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcfd9c63-797b-4f6b-aa6e-0e639247003b@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_165320_148892_4DA52362 
X-CRM114-Status: GOOD (  20.25  )
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

On Fri, Dec 06, 2024 at 06:14:29PM +0530, Kanchan Joshi wrote:
> On 12/6/2024 7:23 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Adds a new attribute type to specify a write stream per-IO.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   include/uapi/linux/io_uring.h |  9 ++++++++-
> >   io_uring/rw.c                 | 28 +++++++++++++++++++++++++++-
> >   2 files changed, 35 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> > index 5fa38467d6070..263cd57aae72d 100644
> > --- a/include/uapi/linux/io_uring.h
> > +++ b/include/uapi/linux/io_uring.h
> > @@ -123,7 +123,14 @@ struct io_uring_attr_pi {
> >   	__u64	rsvd;
> >   };
> >   
> > -#define IORING_RW_ATTR_FLAGS_SUPPORTED (IORING_RW_ATTR_FLAG_PI)
> > +#define IORING_RW_ATTR_FLAG_WRITE_STREAM (1U << 1)
> > +struct io_uring_write_stream {
> > +	__u16	write_stream;
> > +	__u8	rsvd[6];
> > +};
> 
> So this needs 8 bytes. Maybe passing just 'u16 write_stream' is better? 
> Or do you expect future additions here (to keep rsvd).

I don't have any plans to use it. It's just padded for alignment. I am
not sure what future attributes might be proposed, but I don't want to
force them be align to a 2-byte boundary.
 
> Optimization is possible (now or in future) if it's 4 bytes or smaller, 
> as that can be placed in SQE along with a new RW attribute flag that 
> says it's placed inline. Like this -

Oh, that's definitely preferred IMO, because it is that much easier to
reach the capability. Previous versions of this proposal had the field
in the next union, so I for some reason this union you're showing here
was unavailable for new fields, but it looks like it's unused for
read/write. So, yeah, let's put it in the sqe if there's no conflict
here.

> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -92,6 +92,10 @@ struct io_uring_sqe {
>                          __u16   addr_len;
>                          __u16   __pad3[1];
>                  };
> +               struct {
> +                       __u16   write_hint;
> +                       __u16   __rsvd[1];
> +               };
>          };
>          union {
>                  struct {

