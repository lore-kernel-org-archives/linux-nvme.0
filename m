Return-Path: <SRS0=IF7s=7D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB813C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 13:54:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C28206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2020 13:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGx57tm8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MadH9FDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C28206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4nRYB1vRP93heWt8oxWn/Cun/R5IuD3mpv49x5srJ+k=; b=eGx57tm8cGzKFO
	H9ZfvCoyZiJKsB770kepz+3HiP+ypSJUU71hKB9jpXuZncBn6EJHCp/TqLI0o+BEg4xcOzKm8nvds
	INfl6uYyu6x5dnwN1+9Z1cR12bmdIgggrrBWxP8XcIKMurYuLVntJ8TBcxkrTPVbWOrHgurZV+FPg
	eaV3/wY32cwMO2opYCQMQn3SDYqs4vLTSt5H6sCvGBE/nbAVm1yHAfKOPl3wQHwLgj4ZfFhY9/5Ct
	v4c4cCsCFoYZRNJVnwC5PsiXpSW2LYmw8OfUiV2tqQkacdD25gCTpvf/6cuPLfXxbQxw5/AQ5USha
	hbGLQzb3ObQAq/oIeXVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbleu-0001cl-1w; Thu, 21 May 2020 13:54:52 +0000
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbler-0001ba-33; Thu, 21 May 2020 13:54:50 +0000
Received: by mail-qt1-x843.google.com with SMTP id a23so5529134qto.1;
 Thu, 21 May 2020 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=4AWH1AUEd7Au/qvsJAY3f3OpE4viRwDzW+yF47F593Y=;
 b=MadH9FDDGvoxe4fUbjh7p4mwB3ng32aoog6jBUA4hFSZAKoaWEKqesMpS8Mdgd0nR2
 mDTgZteXtTpdXw8EluT3/45VBYy3VnVHtEsyutIuba5pFOT1ONq06EfpFZxfbAM+uqBt
 ivy6cbOcjc9wKcedTtgupAWJ4hGHRK6MDbC5Mf63igyieBqM3YqmiNMYpXIlyth7uy+c
 dK6YjZCUy66fZodoZfuNm2c+b7Jy5HP8GX2o3qqoiVU9U/KOnqcAZfrpq9vj9G7eqhyl
 9Xb6Y7o7onhxN0YVZPLVzb6piACyAq9ppSHsg5oJrX7hlGZSAgGYua7uGRRSN/cVwcZH
 Oc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4AWH1AUEd7Au/qvsJAY3f3OpE4viRwDzW+yF47F593Y=;
 b=Q4b+7CViN88AMKxy9XHzvRN43lh0k2E6p3mq40E3lXAixiVEyA4oAZgeaMbvk0paC0
 XKocvBmYKznggL3XdCE6gvSFNcyV0QJimghsOl7LUlrVIuFGRSDqgMq1RCXWY30454/M
 UmeyOE44yN+ZtuJ1S0HP+TbAwMd4l0i32RY69eYmJS9m4anqZrK6Nvkw/c8p1s6SQyDi
 WLzbO5YDW9cOiaMINLJ3tQOz1yg4o5OjOvEKIVVG751kuKbz7xVdO/J7SBdJugE5sUTK
 T65Ja1cjt5w7MRqfDUUFNca5L3wBngOnjUMQckeIAjRsTjAPGfs7kGYoir5DURMo/oyE
 aksA==
X-Gm-Message-State: AOAM532X5y3OM+CCaf5k8i4mLYy50PN6CdYgPLN3BahufqI4899JuUAi
 4bE1hhSFRsLH+u5jtFpgSWw=
X-Google-Smtp-Source: ABdhPJwr1XLsFhpL67QfydZyYFncpQXNqgVtdQK2lUSy7K4tdF1oTZiVeuf1ITYdnePhr53SYWBElg==
X-Received: by 2002:ac8:4c8b:: with SMTP id j11mr10385232qtv.58.1590069286825; 
 Thu, 21 May 2020 06:54:46 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.225])
 by smtp.gmail.com with ESMTPSA id n85sm1682417qkn.31.2020.05.21.06.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 06:54:46 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
 id 7AEDAC0BEB; Thu, 21 May 2020 10:54:43 -0300 (-03)
Date: Thu, 21 May 2020 10:54:43 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 32/33] net: add a new bind_add method
Message-ID: <20200521135443.GY2491@localhost.localdomain>
References: <20200520195509.2215098-1-hch@lst.de>
 <20200520195509.2215098-33-hch@lst.de>
 <20200520230025.GT2491@localhost.localdomain>
 <20200521084224.GA7859@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521084224.GA7859@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200521_065449_131919_E6795199 
X-CRM114-Status: GOOD (  20.98  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Eric Dumazet <edumazet@google.com>, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, target-devel@vger.kernel.org,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, cluster-devel@redhat.com,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Jakub Kicinski <kuba@kernel.org>,
 ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
 Neil Horman <nhorman@tuxdriver.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 Vlad Yasevich <vyasevich@gmail.com>, linux-kernel@vger.kernel.org,
 Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
 "David S. Miller" <davem@davemloft.net>, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 21, 2020 at 10:42:24AM +0200, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 08:00:25PM -0300, Marcelo Ricardo Leitner wrote:
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	lock_sock(sk);
> > > +	err = sctp_do_bind(sk, (union sctp_addr *)addr, af->sockaddr_len);
> > > +	if (!err)
> > > +		err = sctp_send_asconf_add_ip(sk, addr, 1);
> > 
> > Some problems here.
> > - addr may contain a list of addresses
> > - the addresses, then, are not being validated
> > - sctp_do_bind may fail, on which it requires some undoing
> >   (like sctp_bindx_add does)
> > - code duplication with sctp_setsockopt_bindx.
> 
> sctp_do_bind and thus this function only support a single address, as
> that is the only thing that the DLM code requires.  I could move the

I see.

> user copy out of sctp_setsockopt_bindx and reuse that, but it is a
> rather rcane API.

Yes. With David's patch, which is doing that, it can be as simple as:

static int sctp_bind_add(struct sock *sk, struct sockaddr *addr,
               int addrlen)
{
	int ret;
	lock_sock(sk);
	ret = sctp_setsockopt_bindx(sk, addr, addrlen, SCTP_BINDX_ADD_ADDR);
	release_sock(sk);
	return ret;
}

and then dlm would be using code that we can test through sctp-only tests as
well.

> 
> > 
> > This patch will conflict with David's one,
> > [PATCH net-next] sctp: Pull the user copies out of the individual sockopt functions.
> 
> Do you have a link?  A quick google search just finds your mail that
> I'm replying to.

https://lore.kernel.org/netdev/fd94b5e41a7c4edc8f743c56a04ed2c9%40AcuMS.aculab.com/T/

> 
> > (I'll finish reviewing it in the sequence)
> > 
> > AFAICT, this patch could reuse/build on his work in there. The goal is
> > pretty much the same and would avoid the issues above.
> > 
> > This patch could, then, point the new bind_add proto op to the updated
> > sctp_setsockopt_bindx almost directly.
> > 
> > Question then is: dlm never removes an addr from the bind list. Do we
> > want to add ops for both? Or one that handles both operations?
> > Anyhow, having the add operation but not the del seems very weird to
> > me.
> 
> We generally only add operations for things that we actually use.
> bind_del is another logical op, but we can trivially add that when we
> need it.

Right, okay.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
