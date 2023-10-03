Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090DBE75420
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 04:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xysvb7UXDgrvMeyvIHjhvvDF8mxwwGkkX/MDtZn8IY=; b=Mixusli5zACq+brppuAwd66Gto
	tnASAcR7fd8Ncf89N1put62A7uA+Pvq0a+ImZQLn8ZW3zIHV5Ec97x7WK8e6CMX0fYCPJrBog1bOF
	FzUPNnvsU6TF7kULCLzwcr/RFTkO/Wi+ydyoCusFOdwD/c1xzK2I8rsM/9eXtmLAZDUiQdjh2KybV
	3UjddPTPB3Y3jmLK3tAY5BdUvmyaFMzCTLORUnlu1dsRLhUqkN4e9NM7STStbpoNou5oEFo2dzgjq
	IBaYMb6doVzCyLbZfbStOQuWfBX/Gt6jPrt14CEkjbKpp8zi9OX+JPVA6sdyxCvr91QiJdHG3dGbz
	ZKXManQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnX73-00DmxY-2p;
	Tue, 03 Oct 2023 04:34:25 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnX70-00Dmwg-2v
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 04:34:24 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so3705355ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Oct 2023 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696307661; x=1696912461; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xysvb7UXDgrvMeyvIHjhvvDF8mxwwGkkX/MDtZn8IY=;
        b=iRki1J9MQ0diC0BACocGBv70lDcdKjPVAePY4T11KirQXxpdZ3WB2P6kkNcb4fAYhK
         Q8auPLVb92w3bKZ1Aw4LiJvGAC5nCiEqTTc6intrll4AE21B+qZh6jUgYtE0yFBi0fy5
         uiTBpgvCEjFC82ajEo4Dc/RU3tA2uvnuQxSUhwRnyc9QXDwjV5fSSptP626iiXnh9NQt
         l61uLtUamn3IlB08OEISJgYN3YWlgWfIj7tXMLdA1UYZAJpR1ApeuTQywI8//7Iq4AZ3
         aD8YZhM3j/zRbHtNUWu9q2BcduOhzylOSg0h7ipN4UChiBxnXtr1hV0RFPEtonhSrXRM
         9edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307661; x=1696912461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xysvb7UXDgrvMeyvIHjhvvDF8mxwwGkkX/MDtZn8IY=;
        b=xTae46d1nNKIh/1vo7eMhc7WTPFM4adoo3Xxr4loUHxVAvvJATL/oKpQq3pWHBpzPB
         yR0+/q1mJFgM3EDtmR965026x9bwZxsDTaTdaBqBoT0pn2l7j89mW/SzbsAeIwM9xDNt
         rWkt3ocrQlLdsNpoP2O5iFRoY9/0cDwBglkQxSX1sAIk3rAqA1r2s5hjcdFMMuHGAzGj
         bthB/yO9P0rYgD8MhGyryynK+CxdRZNZpxj6Z6u5AHR5PnzcbtHMf7vMUJKhmgos4A2l
         FxOJUg8VHbBJIGnDiV/Nzm2bPklLwJvGGpI4XiIAL5f1aF4E5ZO8g9s515Hlz08UatFW
         i64g==
X-Gm-Message-State: AOJu0Yz7gEehU4xOd+11j+g2Sg10Z8P6AZSMCIwmjaJW2j0mbqM//fOT
	F+J8rWVdeHeejR+io7KoXoTHfw==
X-Google-Smtp-Source: AGHT+IEM0jhYe8OIyJVgIN1aZyptyxQiXDtplBZuTljT0XzOVBrzHoD7FYZACjKGOsHLvoVZ/wOOew==
X-Received: by 2002:a17:902:9b8e:b0:1c6:845:27c5 with SMTP id y14-20020a1709029b8e00b001c6084527c5mr13417148plp.61.1696307661424;
        Mon, 02 Oct 2023 21:34:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001c444106bcasm341059plb.46.2023.10.02.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 21:34:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1qnX6w-008l4e-0d;
	Tue, 03 Oct 2023 15:34:18 +1100
Date: Tue, 3 Oct 2023 15:34:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 11/21] fs: xfs: Don't use low-space allocator for
 alignment > 1
Message-ID: <ZRuZymVoFI7EUjbS@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-12-john.g.garry@oracle.com>
 <ZRtrap9v9xJrf6nq@dread.disaster.area>
 <20231003030010.GE21298@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003030010.GE21298@frogsfrogsfrogs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_213423_255551_2C7CE908 
X-CRM114-Status: GOOD (  26.71  )
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

On Mon, Oct 02, 2023 at 08:00:10PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 03, 2023 at 12:16:26PM +1100, Dave Chinner wrote:
> > On Fri, Sep 29, 2023 at 10:27:16AM +0000, John Garry wrote:
> > > The low-space allocator doesn't honour the alignment requirement, so don't
> > > attempt to even use it (when we have an alignment requirement).
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  fs/xfs/libxfs/xfs_bmap.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> > > index 30c931b38853..328134c22104 100644
> > > --- a/fs/xfs/libxfs/xfs_bmap.c
> > > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > > @@ -3569,6 +3569,10 @@ xfs_bmap_btalloc_low_space(
> > >  {
> > >  	int			error;
> > >  
> > > +	/* The allocator doesn't honour args->alignment */
> > > +	if (args->alignment > 1)
> > > +		return 0;
> > > +
> > 
> > How does this happen?
> > 
> > The earlier failing aligned allocations will clear alignment before
> > we get here....
> 
> I was thinking the predicate should be xfs_inode_force_align(ip) to save
> me/us from thinking about all the other weird ways args->alignment could
> end up 1.
> 
> 	/* forced-alignment means we don't use low mode */
> 	if (xfs_inode_force_align(ip))
> 		return -ENOSPC;

See the email I just wrote about not needing per-inode on-disk state
or even extent size hints for doing allocation for atomic IO. Atomic
write unit alignment is a device parameter (similar to stripe unit)
that applies to context specific allocation requests - it's not an
inode property as such....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

