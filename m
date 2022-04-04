Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74849C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/SbAzH3xxHfsnOuEfuoDs7VQok5qMMxv9ZS9+FtaRqs=; b=qzdwrg20sH1e5xQqG/RQ6pDOYh
	0bUCdFIxOZP9atrSBhlodvG304YYrPrnhrK5tnsVEruVE62cZnMTbivh/aV+wYV3ivjdDVwf4VdHG
	XJon+ihzNELkgiyybLjz1WAgKXn9KWtBsb9H9e5Ct/ZoMOdl07qeK8KCXgkKRolGHwNmJ/jJ75z8H
	qc6BQNfgP89bvs0FV2zg5uBy2mKokd1nddMMVimJABGOmtXvu5R0CbMtmsWmhlq08FlmBh4u0QnSH
	dDQUjysZjHNtv403CZkY7HS1TJezEgJH7qvdvD8kS0Eo1JBM1fiP9PK15EmcGUJeN/vf0q8JUjUoW
	AttjSaog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbNJo-00FGGK-HG; Mon, 04 Apr 2022 14:04:32 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbNJl-00FGF3-Sh
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 14:04:31 +0000
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-de3ca1efbaso10729591fac.9
 for <linux-nvme@lists.infradead.org>; Mon, 04 Apr 2022 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/SbAzH3xxHfsnOuEfuoDs7VQok5qMMxv9ZS9+FtaRqs=;
 b=n3MNB9JA16J1JQj8A7WXDMqRIqAKP9AbCjODGm/XgtwuQry6UG17h92DVxby/QEbvf
 kO/Pjo4UlA5UVFueaweJ4uQsxUjXPkreja5974FnkSi4YDogMo5PXgTYVkcG34IM9653
 Ubl7CzZFe+O5f192kVNkOs0gzxWpBsnkRPgrX1wXmu7ZKUuUZxMcjpvKA0XgyZDOy5O4
 hzn+4I/VM2aPcEjGKMZnfnRx6JrJgy1/XALZtLpreIuDYkxvOWkvu3QzUfxNnplnam0/
 hL7Z1h6Bp5wTqD6t3hz1NLVcjKoxnIElrKlQoRw2+IBP4tzZPvreH27bbBAJ5yDZghIw
 vtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/SbAzH3xxHfsnOuEfuoDs7VQok5qMMxv9ZS9+FtaRqs=;
 b=wlbYKAdxa4NKujRUyYJtrQZsodRyZBxOWria/rZg4HypRuh+M3sUj1KN3sKzuKIOMU
 RxBEA8vFoFdqbY2i0GH4SIi533PQc8rhzw3mHx9hZwTH3lCYvskpfAXBxR3FzezYimZY
 poruetlb43yeFBY5RosVLKBmjEFhbZUWYjAL6Zefq+LqIVJ/GyJFHrxImlXpPoPHMyKV
 fNiHT17ccRHx26CfWuX8wv4bvAkono16ZzWkcLyfP0gHIL/bGc2yKy13dtDbewKvoDQl
 oPB7zZ3gmLjQfk+pebYNIkgfRczQj5iurfLHVYYKfUaUmxm8wx0jhKlw22KlQpTO9pXV
 7SrA==
X-Gm-Message-State: AOAM532xAeWsvdaHlv2x8HnVP4/CObwGZPArmTVZnU8xxqzFaWvwK4Qu
 0w6sn736bjwxeTL/7Ope+WPHs4chbkccAf8yKR0=
X-Google-Smtp-Source: ABdhPJw++xsLKeC4RPlQi91nltgMnj8F1eq4rOEJG5SkSUXjqjki4+76JjU6juaE5GXsqxhQhjZX+rQTXp2TyrKBGE0=
X-Received: by 2002:a05:6870:d18b:b0:d9:f452:be90 with SMTP id
 a11-20020a056870d18b00b000d9f452be90mr10461898oac.15.1649081067354; Mon, 04
 Apr 2022 07:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110836epcas5p37bd59ab5a48cf77ca3ac05052a164b0b@epcas5p3.samsung.com>
 <20220401110310.611869-5-joshi.k@samsung.com> <20220404070747.GA444@lst.de>
In-Reply-To: <20220404070747.GA444@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Mon, 4 Apr 2022 19:34:03 +0530
Message-ID: <CA+1E3rLPRJmDVuNeRQpbJ9svsKawOCSYg8cLeHjjOYZUbYDD4g@mail.gmail.com>
Subject: Re: [RFC 4/5] io_uring: add support for big-cqe
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>, 
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Pankaj Raghav <pankydev8@gmail.com>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_070429_976168_FDB355CA 
X-CRM114-Status: GOOD (  13.08  )
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

On Mon, Apr 4, 2022 at 12:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 01, 2022 at 04:33:09PM +0530, Kanchan Joshi wrote:
> > Add IORING_SETUP_CQE32 flag to allow setting up ring with big-cqe which
> > is 32 bytes in size. Also modify uring-cmd completion infra to accept
> > additional result and fill that up in big-cqe.
>
> This should probably be patch 2 in the series.

Yes, indeed. Thought (for the next version) is placing this
immediately after big-sqe. And make uring-cmd infrastructure to be on
the top.

