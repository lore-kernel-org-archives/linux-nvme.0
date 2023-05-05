Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41286C77B75
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCtnoETSxcB113Zij2dc92/a6FXT6zg5FXhG1u0c1nk=; b=4lm2+//3emgPzqR/VNjLRYijkw
	NbDp0fTiBnWDO7s9IPuSGOYQSXfqL3AeDX3imwlecS3s2ItSZEyvD2v6mRJnSzlngPcxNh7Z5wNjC
	NY061P+JRJdKFe4acZEkd4n2+ICW9inRYFif4WjTmUJpWuzKEJhc6ctAUjgqThTYwoasaPy+FGS+A
	beKrx4b3u2+XM1FaABv6piydGarxe4PbNWLtf5bZU96svLe12oHQo+WFqtBX+4aUCZdjr7NAYK7ml
	iWeAnmklhguyTRxLTBPa1pAAce4+zK4oBT7tZgh85KbFBJPlaM3NSYdda1tkGcZ3D6T8D+fEWVcrh
	NPBcVoDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv541-00C6Mj-0h;
	Fri, 05 May 2023 23:42:13 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv53y-00C6M4-1t
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 23:42:11 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1867033b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 05 May 2023 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683330127; x=1685922127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCtnoETSxcB113Zij2dc92/a6FXT6zg5FXhG1u0c1nk=;
        b=QusrV2Wwp2bfcRiTRr6hzIF/JXaTe4s/VrPmwKwo0KjCO5zokwC9p/TVY23qdqD/l1
         Dli2uc+0UwP0iuI3XJJiRqCCR1FgBhbsbCfs3DBsxBDA+bBTXb8II9k8UOkYruYMdXhy
         gwAAOON1JGC03tKiYjRGDxrPMDO2D458c4fsVC5Dvmbt5so6xvclSNo3u4T0qTypnasy
         eyJy1DNm0nF83oEQuDkzVIzBajW2FDDdAiEilNv9J3lj3iA93K7uz8wuxLyAqRBsSQeD
         7aahCv7qFLZjDKFH0N+HzdR7mcuioyTEBOlzKFarm+J+e4+MCHsEUXooUNe0p7ye3H6n
         fFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683330127; x=1685922127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCtnoETSxcB113Zij2dc92/a6FXT6zg5FXhG1u0c1nk=;
        b=ZqerBDkcxPmej+hcSG/oCkN/pkKtwHGDiqvjqd8LNwdLvhXTybx6X8dzkdW8lpT/A4
         aZYsKy/kd1N2TxRg2WKp8YjPsPMynxf1HGB53HKwfDf7PwB+fjdQGXJ6ShR+RkAVP8i3
         8r2vb/fhTd98tDuggeyCUfzZNn3HylcWwqcYiLqw5vnhCxa36w0X1ojyxhS8awC1zfhv
         SRcm0DV39amhDdU4Ts2AR4UrEGPfhlS0uS3uKplzernJ/ZiCXbNBnMPGHXCVtTM/tZLk
         dLzc2y0OV5cqjcbgVNZN1cOvfCvNuO6oRsPT1UD6s0s3Yo4jQmnxdUKrOPsDriv+f7D7
         6oQg==
X-Gm-Message-State: AC+VfDwYyHi81NIbbS8AwmpUNodVemey7PIMimG+Mj/uF9+GB/5HVlQu
	fcv42kA4oOcAwUs5g4MMxAJqOA==
X-Google-Smtp-Source: ACHHUZ6ZXwTvDt9dgqu5VnMU2vt75ZEwPCsWikBzLJH1LKI2sJCZP8HWyuvB09pM2j5L3woioye+0w==
X-Received: by 2002:a05:6a20:1590:b0:f6:592a:7e28 with SMTP id h16-20020a056a20159000b000f6592a7e28mr3982333pzj.14.1683330127470;
        Fri, 05 May 2023 16:42:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id x2-20020a056a00270200b006338e0a9728sm2097064pfv.109.2023.05.05.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 16:42:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1pv53r-00BpPv-Ud; Sat, 06 May 2023 09:42:03 +1000
Date: Sat, 6 May 2023 09:42:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	Allison Henderson <allison.henderson@oracle.com>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: [PATCH RFC 12/16] xfs: Add support for fallocate2
Message-ID: <20230505234203.GO3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-13-john.g.garry@oracle.com>
 <20230503232616.GG3223426@dread.disaster.area>
 <20230505222333.GM15394@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505222333.GM15394@frogsfrogsfrogs>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_164210_643601_9ABCEF0D 
X-CRM114-Status: GOOD (  22.47  )
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

On Fri, May 05, 2023 at 03:23:33PM -0700, Darrick J. Wong wrote:
> On Thu, May 04, 2023 at 09:26:16AM +1000, Dave Chinner wrote:
> > On Wed, May 03, 2023 at 06:38:17PM +0000, John Garry wrote:
> > If we want fallocate() operations to apply filesystem atomic write
> > constraints to operations, then add a new modifier flag to
> > fallocate(), say FALLOC_FL_ATOMIC. The filesystem can then
> > look up it's atomic write alignment constraints and apply them to
> > the operation being performed appropriately.
> > 
> > > The alignment flag is not sticky, so further extent mutation will not
> > > obey this original alignment request.
> > 
> > IOWs, you want the specific allocation to behave exactly as if an
> > extent size hint of the given alignment had been set on that inode.
> > Which could be done with:
> > 
> > 	ioctl(FS_IOC_FSGETXATTR, &fsx)
> > 	old_extsize = fsx.fsx_extsize;
> > 	fsx.fsx_extsize = atomic_align_size;
> > 	ioctl(FS_IOC_FSSETXATTR, &fsx)
> 
> Eww, multiple threads doing fallocates can clobber each other here.

Sure, this was just an example of how the same behaviour could be be
acheived without the new ioctl. Locking and other trivialities were
left as an exercise for the reader.

> 
> > 	fallocate(....)
> > 	fsx.fsx_extsize = old_extsize;
> > 	ioctl(FS_IOC_FSSETXATTR, &fsx)
> 
> Also, you can't set extsize if the data fork has any mappings in it,
> so you can't set the old value.  But perhaps it's not so bad to expect
> that programs will set this up once and not change the underlying
> storage?
> 
> I'm not actually sure why you can't change the extent size hint.  Why is
> that?

Hysterical raisins, I think.

IIUC, it was largely to do with the fact that pre-existing
allocation could not be realigned, so once allocation has been done
the extent size hint can't guarantee extent size hint aligned/sized
extents are actually allocated for the file.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

