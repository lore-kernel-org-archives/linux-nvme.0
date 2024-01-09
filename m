Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ABBC47077
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 23:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GVskAbFQn1uVXaOO+q7ZemcnAH1k41TKnSXZBeHYzrY=; b=SeP+tCc+hd22ZU2I+X2sGfwWiN
	DAPnd/09WpdyCc2MV7EGRjpgf5C+RZvzw+y+F9ZyqN54Ax4qmHU/qWUlEJYXf3cwFetbuVuZDIu1X
	O1rwvoH1kWdWBGsMTRFeHIa1+cy3fONsGfDgnjs6gaBQDqV4m43vtBUL6/CMj5oGZB96KCUu+70Nl
	2/LOX5kU+t2YzN4HKbm9fJV5iuG2hA8LOTPflnutKbxO634sCO/2s7Am7DWdT0RH/Ml4Im/rfvUUN
	zZoG2CzO71UDi0Iz5TmiIb9fum+7vQJoImFIv/O1nONmvb/j7xIdfP7rJbVhLupgG8/ukzMN+vGqQ
	IBR2UlKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNL8j-009lmI-2F;
	Tue, 09 Jan 2024 23:04:09 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNL8f-009llH-1K
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 23:04:06 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6dad22e13dcso2169908b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jan 2024 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704841443; x=1705446243; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVskAbFQn1uVXaOO+q7ZemcnAH1k41TKnSXZBeHYzrY=;
        b=tb5RlcsLEw3WU/ewmG+uZgwoInpwjCssaoOa569ydZL89ftY5NcZsDrAdZssT/7fvK
         QhA8Lz36KZzhDRR2UqTJxp5Zcv+JHeygLRPv/G+2y8B+gquma7/MaH4/NmtCSKUWp7Bs
         Rb7Xvqt9gyKBBQ3XSkH1fSDZvZ46GbIV30IiDOYomFWp8Te602nEtjSa/ajseSWNj1Jf
         nSu9BWEO/E1+zfYHu96TlnbiQKcMPJWD2ZknlcfvndXcTz0sCZfTazCTfIV56afhWmIo
         N1d9mkD+9jdnutZIILVOQICuJwZgMz+30ewPPf7bxlLr4sHa+PAsAr6DGjmuM1TxvHCE
         3REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841443; x=1705446243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVskAbFQn1uVXaOO+q7ZemcnAH1k41TKnSXZBeHYzrY=;
        b=WK4VKChwtObyHCbX0MGVvegVjpRb+6RTABCZE0m4EYZv5W3qO8vGeQUIoKBayXbeaO
         XdBw1mxo3revTbBngwpKGKOaXzFKMfELJ9iqzp23gLEE/2oZApGkKHW5fDlqlEy1TLPO
         OhDR/66Hm/+HSQH72j4FvQ+cZ5YzKiigNHLsDPBAGuhwlZjAEdU22xt7K6OTHP7rmW3X
         iKaKLTQiDZIwN8A05FgyqRXvFEDNTWfhwMfPNSzcv609eQjcKHxtrHK0niQBA5pB8Asr
         OOOiaA1lij53y2K9u3GB5U3Yyf4pDon+ydJH3FVienhFztKQhut7skxjtjsatv5IvD1Y
         yIqw==
X-Gm-Message-State: AOJu0YwRLnfohi0ECRTceaSkeNBsKbsen356msjCsMre81UIw63zGfjF
	22x+t9jg/GhaZowqrwUJFXj+ESQczuHWlg==
X-Google-Smtp-Source: AGHT+IEzELO00cjbdQ5MoAae4PmrX2wGL2oSaAb1TtprT5iO1eenc3qlgGb6zh1GdAb8Vowe9WZkyA==
X-Received: by 2002:a05:6a00:a01:b0:6d9:b8e3:9137 with SMTP id p1-20020a056a000a0100b006d9b8e39137mr245785pfh.10.1704841443394;
        Tue, 09 Jan 2024 15:04:03 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id fj1-20020a056a003a0100b006d9b66f3d07sm2241185pfb.95.2024.01.09.15.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:04:02 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNL8a-008GXv-15;
	Wed, 10 Jan 2024 10:04:00 +1100
Date: Wed, 10 Jan 2024 10:04:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, bvanassche@acm.org, ojaswin@linux.ibm.com
Subject: Re: [PATCH v2 00/16] block atomic writes
Message-ID: <ZZ3Q4GPrKYo91NQ0@dread.disaster.area>
References: <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs>
 <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
 <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d03703-6c57-424a-80ea-965e636c34d6@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_150405_446568_DD854A98 
X-CRM114-Status: GOOD (  34.31  )
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

On Tue, Jan 09, 2024 at 09:55:24AM +0000, John Garry wrote:
> On 21/12/2023 06:50, Christoph Hellwig wrote:
> > On Tue, Dec 19, 2023 at 04:53:27PM +0000, John Garry wrote:
> > > On 19/12/2023 15:17, Christoph Hellwig wrote:
> > > > On Tue, Dec 19, 2023 at 12:41:37PM +0000, John Garry wrote:
> > > > > How about something based on fcntl, like below? We will prob also require
> > > > > some per-FS flag for enabling atomic writes without HW support. That flag
> > > > > might be also useful for XFS for differentiating forcealign for atomic
> > > > > writes with just forcealign.
> > > > I would have just exposed it through a user visible flag instead of
> > > > adding yet another ioctl/fcntl opcode and yet another method.
> > > > 
> > > Any specific type of flag?
> > > 
> > > I would suggest a file attribute which we can set via chattr, but that is
> > > still using an ioctl and would require a new inode flag; but at least there
> > > is standard userspace support.
> > I'd be fine with that, but we're kinda running out of flag there.
> > That's why I suggested the FS_XFLAG_ instead, which basically works
> > the same.
> 
> Hi Christoph,
> 
> Coming back to this topic... how about this FS_XFLAG_ and fsxattr update:
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index da43810b7485..9ef15fced20c 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -118,7 +118,8 @@ struct fsxattr {
>        __u32           fsx_nextents;   /* nextents field value (get)   */
>        __u32           fsx_projid;     /* project identifier (get/set) */
>        __u32           fsx_cowextsize; /* CoW extsize field value
> (get/set)*/
> -       unsigned char   fsx_pad[8];
> +       __u32           fsx_atomicwrites_size; /* unit max */
> +       unsigned char   fsx_pad[4];
> };
> 
> /*
> @@ -140,6 +141,7 @@ struct fsxattr {
> #define FS_XFLAG_FILESTREAM    0x00004000      /* use filestream allocator
> */
> #define FS_XFLAG_DAX           0x00008000      /* use DAX for IO */
> #define FS_XFLAG_COWEXTSIZE    0x00010000      /* CoW extent size
> allocator hint */
> +#define FS_XFLAG_ATOMICWRITES  0x00020000
> #define FS_XFLAG_HASATTR       0x80000000      /* no DIFLAG for this   */
> 
> /* the read-only stuff doesn't really belong here, but any other place is
> lines 1-22/22 (END)
> 
> Having FS_XFLAG_ATOMICWRITES set will lead to FMODE_CAN_ATOMIC_WRITE being
> set.
> 
> So a user can issue:
> 
> >xfs_io -c "atomic-writes 64K" mnt/file
> >xfs_io -c "atomic-writes" mnt/file
> [65536] mnt/file

Where are you going to store this value in the inode?  It requires a
new field in the inode and so is a change of on-disk format, right?

As it is, I really don't see this as a better solution than the
original generic "force align" flag that simply makes the extent
size hint alignment a hard physical alignment requirement rather
than just a hint. This has multiple uses (DAX PMD alignment is
another), so I just don't see why something that has a single,
application specific API that implements a hard physical alignment
is desirable.

Indeed, the whole reason that extent size hints are so versatile is
that they implement a generic allocation alignment/size function
that can be used for anything your imagination extends to. If they
were implemented as a "only allow RAID stripe aligned/sized
allocation" for the original use case then that functionality would
have been far less useful than it has proven to be over the past
couple of decades.

Hence history teaches us that we should be designing the API around
the generic filesystem function required (hard alignment of physical
extent allocation), not the specific use case that requires that
functionality.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

