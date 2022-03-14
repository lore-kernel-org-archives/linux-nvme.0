Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A44C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 17:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vQGT4uZiYJ10uuigdD5nlSKxhUgslUyBNqrMBHchbnk=; b=Oun+kDDB02omKxEQ1kG4SfTLJj
	OYdVnV9AfCppfV1P2hqMeuqSBwiYmYgbLyu22WvRcitpfTBUlwJrtIKoWZ6TGDp/Rlowk4udlFK5f
	DWRY7v8uvF7SgmQ5HjsMVWukgTTTWWijMLMU69lBHKMyOIf8Qssu6PkKhDt6iUYg2UKdW58un7E2j
	5hBon8afJUewHk3Vub802TcNnrQ+1O2f1rwSmC7FRGQSOea1prXWQAmxiWhSDxMZIIXY7iOmRlv6F
	cxJsVaDps/a691rjNvhGu3+FmXZbrXG7e8yup0UGbwPaG53zOdrREtqCuS49pKcO0Ll+UiKybUYl0
	8Lofy+Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nToty-006QP6-TS; Mon, 14 Mar 2022 17:54:38 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTotv-006QNS-Pc
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 17:54:37 +0000
Received: by mail-lj1-x230.google.com with SMTP id r22so23082941ljd.4
 for <linux-nvme@lists.infradead.org>; Mon, 14 Mar 2022 10:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vQGT4uZiYJ10uuigdD5nlSKxhUgslUyBNqrMBHchbnk=;
 b=EHb+XodK5msez3q4MFWq9nUAeL42BEtNrogXwN4aoDcT13qXy5MrB+OeNyW5goZ4f/
 GZ3nvRdlbunCmOSpAoUw4dSyD8hZBqKM3MWFWp9RtO4OxCttgy/jz51DmtQNk7dEeNHY
 9c6PHgpGdRDa6P68+UMgG7s/y3qwsk7DEARadMEV25tSII3B6WfoneOa5xZBBGFyDks4
 OrbBUmdyV6PFEh8vlhpG5SKIECFn0MnKN1PQpXPLm6GvFJ6SmEsBqbLztjKS9Bdd/3Ui
 36mFvlw3A/+ltOCz62relAxoWVLk9vmV1il6FeGXaqeY9+nZgfOVbITH0CtcI7ecpgcV
 kXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vQGT4uZiYJ10uuigdD5nlSKxhUgslUyBNqrMBHchbnk=;
 b=OXuI3zXwl58kuCbUlW3SGyr9dO82ItJQWei8MKP9i/5kRAxiYqbGhzKYvd5VW14K3N
 t3qtMgn7eT4pZ1Lf40gp25GDeXKuPg0FVp3YVeStPhF9vjjhDyUf4jUWOAZ/14qcq05T
 pOpHc8BJAApRlLFOT761vlJfA6X9G/1utrpIY9YjxX2o/VOef4IFTxAXSYp1td0AWrMX
 qphbaeSutoIdZlxA0x+A/2fTH2SKL+yP+BjYiIK780hGEzKZnIJrnZM6oHYXdnoOb2Ri
 drCMvfavTw3oMN42i9h0WjHckdGCQakJWTTVgEmRarxr4v4HCXi6yyMGz/rc48sekwl1
 boEQ==
X-Gm-Message-State: AOAM5315EQ1aEhNtyBWzYl+qutVP+XGd7lgyOvZdWyGrYAaajvkJx8Bg
 1G/OpOxVxUhoYhRN1tWiNXuYl514DG+hLpQpU/0=
X-Google-Smtp-Source: ABdhPJw4whtNTcMTfHNtOrsGMruBnT4ZTg9hV4nQOM0a5ZhTl2J/DUQDmQU0wgabSW6pwqkZ4uSyCzg1NhKd2G108nk=
X-Received: by 2002:a2e:90d6:0:b0:246:e44:bcf6 with SMTP id
 o22-20020a2e90d6000000b002460e44bcf6mr15195799ljg.501.1647280472957; Mon, 14
 Mar 2022 10:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
In-Reply-To: <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 14 Mar 2022 23:24:06 +0530
Message-ID: <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_105435_852344_0197D7A8 
X-CRM114-Status: GOOD (  18.47  )
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

On Mon, Mar 14, 2022 at 3:23 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > +int nvme_ns_head_chr_async_cmd(struct io_uring_cmd *ioucmd)
> > +{
> > +     struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
> > +     struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
> > +     int srcu_idx = srcu_read_lock(&head->srcu);
> > +     struct nvme_ns *ns = nvme_find_path(head);
> > +     int ret = -EWOULDBLOCK;
> > +
> > +     if (ns)
> > +             ret = nvme_ns_async_ioctl(ns, ioucmd);
> > +     srcu_read_unlock(&head->srcu, srcu_idx);
> > +     return ret;
> > +}
>
> No one cares that this has no multipathing capabilities what-so-ever?
> despite being issued on the mpath device node?
>
> I know we are not doing multipathing for userspace today, but this
> feels like an alternative I/O interface for nvme, seems a bit cripled
> with zero multipathing capabilities...

Multipathing is on the radar. Either in the first cut or in
subsequent. Thanks for bringing this up.
So the char-node (/dev/ngX) will be exposed to the host if we enable
controller passthru on the target side. And then the host can send
commands using uring-passthru in the same way.

May I know what are the other requirements here.
Bit of a shame that I missed adding that in the LSF proposal, but it's
correctible.

-- 
Kanchan

