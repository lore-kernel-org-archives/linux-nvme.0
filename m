Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2CE776E9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 01:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryilhvn2NwsqlzE716oXqoFx5LNv9PYSQOslNalU2W8=; b=dxVKq/RBdrFf+KtxHqzhWBp7Rj
	8swpgBanNJN4+lETXg5t711vfNws1kgQB/4UbRWGasnGATOmbwWNxvVoxZ3QVCRQebwdADfFfg+mv
	5ypXz0PqONsL7MD5r/46PzYC3I+UN+wIKesWfrULsrsNgFCAxO3wI5tWPAvXkvtn8yLucfOtmY9Nz
	I6wtmg1D3yZ8fMWvb+yrV7cQphlgwVzHfVE+H1CbliT3Kzb0cxXuvKRA5bMbHxcwSvOlWx8zAUyux
	jNuAlsbUWdgI88nq+nEBN2Zv1qvsurfkdaAhO7k4IwfTUlcxW/k9Q53g4pUnKQGzjLYItLUiJFIXA
	kWrjs0Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnUZx-00DeBs-0O;
	Tue, 03 Oct 2023 01:52:05 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnUZu-00De8N-1L
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 01:52:03 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69335ddbe16so297558b3a.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696297913; x=1696902713; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ryilhvn2NwsqlzE716oXqoFx5LNv9PYSQOslNalU2W8=;
        b=pNY0v5fvSw/F39BrAagg59bggGrN2fJ1qmn3GwiVVsikWi7EWKp8GX0hiaNpUp87+d
         /+SGEJD3XPqAwUYwWGiywNE9NrQhhtqpJy/AHGoZMJZFDkgzHIDmIDmPYJarp3235uOs
         EqF7G9m73Q4ZYcbz+fFOAzFaHutj4ADDnAvAwtIC5uok/2pYfmj2FQh21XbtAQS69su+
         vp302EnpVXMvsmL0qfKZkHtFKYSHdJOLzb2IKDvvYY831GdK22Rjv6ZRorfvlrzGI8f9
         v2nyWpZNc+JQv+mAll3Eg1jr2pfETFZng8Pvuu2v7cFsVD+CO/3+1VGfU/+B3SN5nqq6
         7zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696297913; x=1696902713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryilhvn2NwsqlzE716oXqoFx5LNv9PYSQOslNalU2W8=;
        b=UtEnT/E87cpGWednth/MYm6O2plaITz+QORZx7quGKen4D42BD9VI0dLe0Hm7Rsgxb
         JpCmzl4k5vesQlCd1tdUSFhPDHu3tGYh0D6QEzKbLzYe+OGlmcF62CtwZ/slmctr5mHd
         jqM4FEqAIv5HjDJW/1IxRxk6Ooe/4904tB47yw5igHzU0E+UG36PwkEWo0XUjX/+UuZQ
         uTuUpn2Jvg16MphMbGkcvfp4VKFyyI1PlJGls0xmkFN8cEuiMMOqnItjlWHBqbNr8rSq
         J568jcDrNEQ5iFQI5T+hEA3whk/ONWer1BV9CZpzF9tadqZ9hvrFuXWxThS5C8EAd6bA
         dY9A==
X-Gm-Message-State: AOJu0YyTHR6we+xXRIY9X5MfNL6me7ahoacUTLIX8P+r5CNd139Tf3TY
	aY91/rnTiIl4QpfRZjJSKXD4+A==
X-Google-Smtp-Source: AGHT+IEtTWVWyP4SpkC8z1hoWBSmgGgWtpEEGbSrB1vJsTjGxcQSPIpPK5eSkJU5QkXOcYPJ8oQPAw==
X-Received: by 2002:a05:6a20:7f89:b0:14c:d5d8:9fed with SMTP id d9-20020a056a207f8900b0014cd5d89fedmr14193403pzj.54.1696297912959;
        Mon, 02 Oct 2023 18:51:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b00690c7552098sm154707pfn.44.2023.10.02.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:51:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qnUZh-008huh-38;
	Tue, 03 Oct 2023 12:51:49 +1100
Date: Tue, 3 Oct 2023 12:51:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <ZRtztUQvaWV8FgXW@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_185202_460252_D5289EB1 
X-CRM114-Status: GOOD (  24.78  )
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

On Mon, Oct 02, 2023 at 10:51:36AM +0100, John Garry wrote:
> On 01/10/2023 14:23, Bart Van Assche wrote:
> > On 9/29/23 15:49, Eric Biggers wrote:
> > > On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> > > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > > index 7cab2c65d3d7..c99d7cac2aa6 100644
> > > > --- a/include/uapi/linux/stat.h
> > > > +++ b/include/uapi/linux/stat.h
> > > > @@ -127,7 +127,10 @@ struct statx {
> > > >       __u32    stx_dio_mem_align;    /* Memory buffer alignment
> > > > for direct I/O */
> > > >       __u32    stx_dio_offset_align;    /* File offset alignment
> > > > for direct I/O */
> > > >       /* 0xa0 */
> > > > -    __u64    __spare3[12];    /* Spare space for future expansion */
> > > > +    __u32    stx_atomic_write_unit_max;
> > > > +    __u32    stx_atomic_write_unit_min;
> > > 
> > > Maybe min first and then max?  That seems a bit more natural, and a
> > > lot of the
> > > code you've written handle them in that order.
> 
> ok, I think it's fine to reorder
> 
> > > 
> > > > +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
> > > > supports atomic write operations */
> > > 
> > > How would this differ from stx_atomic_write_unit_min != 0?
> 
> Yeah, I suppose that we can just not set this for the case of
> stx_atomic_write_unit_min == 0.

Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
filesystem, file and underlying device support atomic writes when
the values are non-zero. The whole point of the attribute mask is
that the caller can check the mask for supported functionality
without having to read every field in the statx structure to
determine if the functionality it wants is present.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

