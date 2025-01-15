Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9369AC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 06:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=; b=x3RDwxkHFI9R5pa2AdjXV/rECd
	szhSZI5XfBQgbMdxe2VCSeWhx8p0XNgvXXemrMsmZiiph/2F0CMqR3hzNMdiyxPem3/+4pPCqxCMr
	z+ne+KP6QtKZLnrMo3FEsd6AYvstmN6p7VUtHZWDQkKyrcerRKxfTCc4adICPAsDy7uuNw3V0WBV1
	9gFJaK/n58b4vR652o6z9WrCLGETlcraCFHtosoLPrCnli+Z5bdMj8IrVtstC1C3njN5cxWg2f6eV
	hB/bJSF1FHPrUT0+wWW15Hg5cWEk5PLgeScKuET+LSxNt4E+udQyV4wEtyLSLrP5qCG9mIMB7PtSw
	PUxrTNcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXwtO-0000000AmsZ-1w7B;
	Wed, 15 Jan 2025 06:28:42 +0000
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXuEk-0000000AWcX-2KYz
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 03:38:35 +0000
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e573136107bso7889786276.3
        for <linux-nvme@lists.infradead.org>; Tue, 14 Jan 2025 19:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736912313; x=1737517113; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=Qs8B8VtRv7o1eP/nXie8gFVQydI7ofaS8XZ+M1e11kI7a47gMFR911IH9NKvPaV/co
         3r8//Td682g6vWBeZWn3uA4Yp08l2CmQskImNYo9jp2LcRmSqPKdodorYDkZH6DGV29N
         iis489tkxx74d+2qkgUFYywglhMJY2wDODVQjg7tuXt5h+FjBj0rUHd0TBil9evp/bd5
         gfdEf7YCTC3mCf68e/AkIxahUXx/QxJzhxyvQp/AJ+S25IeCwvF0YzA37ra3TAgTNJBm
         K3SyqVUdHczmtBMekW0NhSi27Lqqe+I/f8HnT8vf/SY2N7z20G6XlBi+0SQOBxpJc1NF
         gPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736912313; x=1737517113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggG1Vuf9tiZ0JKZNDTMJJvN8O1nAUNZ5coZeOdFCGi0=;
        b=tRR7eCukMGIYhwUudtiiCSu3/b+ejGdXIn/gxiD3/PWccGXuFX1UpGU0yQaDAkj03h
         hfHCnrPqYSiqBfrqdZ6AzZmHl3rWie4QdoLQiYrZdiOejcDk7DUQ7YcgBZAUkHw4AoHT
         ynN+FnmQbBQVlZ/0P0PHhkhprpZBIhxJ+7edsn8B9n3dIrUAN4vNLNJhuYr89VuqoRrL
         P7HEJySbNVD6w3qb/sB35+d9paVcng5b+NFIZ3Mr+rZmtXu/3q8gVPragsz9jUHN+Smh
         E5F9xxmeTGMmbqzsP2oV5Kv8J1N9iu8A66UAma7q0D7Bk3KYX/xsaVhQ+7WOoIrIa+en
         q6ew==
X-Forwarded-Encrypted: i=1; AJvYcCVY5zhVnR6XL8KFJYUfB4H1BbK5Vzv5rtq1I1BaW4cxJTdPOtXWnoeDArmIYVbeLM6rGvog6AANypmI@lists.infradead.org
X-Gm-Message-State: AOJu0Yzm8AQLZ2K7tdlU+EFq3JCKkQexJ8SfpguBBF+pcfuWk4I+lGmT
	oiPFooIdP97C7uPwxKp+j/TEXrjkSNmSTK91zpKfuIgCq0+QDJFs
X-Gm-Gg: ASbGncuR2r1H7fBPe51wAXwQQJnah3q/bWnWKcAylvM2bXSqksaPQQhtppXqAn7IF8N
	+a0uBHwf5qVLsYnr+hboCGnd91+BdE81cQKr+K2l21TGFML3KWWrysvPWE5zzLyOI3skQlJGL6G
	Vl/rCFrHxia8ayfykoBunJAAz8AvAft9qs/S42J61EWJabY/jc5ROXVSZQYgHfPT3Fdw4VaCid9
	9uYnd/KUhy6ywZ/RA8dhvdiFe0i7nld+/2v9+p75tXCrxHQ5VBNiRhj
X-Google-Smtp-Source: AGHT+IGcxF5UAr9VMjmEWcxKQm1jPE9VpwQlX4HhGZHkGGwOlZgKnKfAZqEBywSv8uk39tmS/FGABQ==
X-Received: by 2002:a05:690c:62ca:b0:6ef:7d51:eba6 with SMTP id 00721157ae682-6f5312a8384mr216747977b3.28.1736912312722;
        Tue, 14 Jan 2025 19:38:32 -0800 (PST)
Received: from localhost ([2601:347:100:5ea0:e12f:d330:c8d6:a6b7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f546dd712esm23854477b3.79.2025.01.14.19.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:38:31 -0800 (PST)
Date: Tue, 14 Jan 2025 22:38:30 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 06/14] cpumask: re-introduce cpumask_next{,_and}_wrap()
Message-ID: <Z4cttq0dfHnapkUI@thinkpad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-7-yury.norov@gmail.com>
 <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z30r/6S8VBU8/Ml5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_193834_596823_8901685C 
X-CRM114-Status: GOOD (  32.61  )
X-Mailman-Approved-At: Tue, 14 Jan 2025 22:28:41 -0800
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

On Tue, Jan 07, 2025 at 02:28:31PM +0100, Alexander Gordeev wrote:
> On Sat, Dec 28, 2024 at 10:49:38AM -0800, Yury Norov wrote:
> 
> Hi Yury,
> 
> > cpumask_next_wrap_old() has two additional parameters, comparing to it's
> > analogue in linux/find.h find_next_bit_wrap(). The reason for that is
> > historical.
> > 
> > Before 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
> > macro"), cpumask_next_wrap() was used to implement for_each_cpu_wrap()
> > iterator. Now that the iterator is an alias to generic
> > for_each_set_bit_wrap(), the additional parameters aren't used and may
> > confuse readers.
> > 
> > All existing users call cpumask_next_wrap() in a way that makes it
> > possible to turn it to straight and simple alias to find_next_bit_wrap().
> > 
> > In a couple places kernel users opencode missing cpumask_next_and_wrap().
> > Add it as well.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/cpumask.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> > index b267a4f6a917..18c9908d50c4 100644
> > --- a/include/linux/cpumask.h
> > +++ b/include/linux/cpumask.h
> > @@ -284,6 +284,43 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
> >  		small_cpumask_bits, n + 1);
> >  }
> >  
> > +/**
> > + * cpumask_next_and_wrap - get the next cpu in *src1p & *src2p, starting from
> > + *			   @n and wrapping around, if needed
> > + * @n: the cpu prior to the place to search (i.e. return will be > @n)
> > + * @src1p: the first cpumask pointer
> > + * @src2p: the second cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_and_wrap(int n, const struct cpumask *src1p,
> > +			      const struct cpumask *src2p)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_and_bit_wrap(cpumask_bits(src1p), cpumask_bits(src2p),
> > +		small_cpumask_bits, n + 1);
> > +}
> > +
> > +/*
> > + * cpumask_next_wrap - get the next cpu in *src, starting from
> > + *			   @n and wrapping around, if needed
> 
> Does it mean the search wraps a cpumask and starts from the beginning
> if the bit is not found and returns >= nr_cpu_ids if @n crosses itself?
> 
> > + * @n: the cpu prior to the place to search
> > + * @src: cpumask pointer
> > + *
> > + * Return: >= nr_cpu_ids if no further cpus set in both.
> 
> It looks like Return is a cpumask_next_and_wrap() comment leftover.
> 
> > + */
> > +static __always_inline
> > +unsigned int cpumask_next_wrap(int n, const struct cpumask *src)
> > +{
> > +	/* -1 is a legal arg here. */
> > +	if (n != -1)
> > +		cpumask_check(n);
> > +	return find_next_bit_wrap(cpumask_bits(src), small_cpumask_bits, n + 1);
> > +}
> > +
> >  /**
> >   * for_each_cpu - iterate over every cpu in a mask
> >   * @cpu: the (optionally unsigned) integer iterator
> 
> Thanks!

Thanks, I'll update the comments.

