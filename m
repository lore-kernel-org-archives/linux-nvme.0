Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B19E776F2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Oct 2023 02:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UyjxDdLQ8L1D7BuXl6m07qK11nzUfRpTIYFbsYyEs9M=; b=SIdItaKNowGtkp0fgLZKxETO24
	t7LzZ5WoDpa55MkAmtdx7w28Q0U01jUcw9FIHyT32H7Rlht/nI1B5HbD5BhoNbWOklvOHGQ2YTNLk
	RfDTcO2w7hDgVKPeVPUnqHkAbbRIJrAjFoz2xuxRxLEvS2C6pXoA6p47JbjBisCggLn5uU1XZgKyW
	DKiYxzlFbIQ/plZsgj4Dy+UpyRjHxKSmfBO6TuwhtfvFJdH2Bm+r5uF1FpOK+GIjxVoWeYunDP3rW
	5MOMnKtMmjAzUE5Cs5uaQjSI4fetB2wzHzXq6h7n9mhu1ujILkVdabJcXk6DwYU5LCJlSFl9RMg30
	Eheqdgew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnVb3-00DhFf-15;
	Tue, 03 Oct 2023 02:57:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnVax-00DhEU-1P
	for linux-nvme@lists.infradead.org;
	Tue, 03 Oct 2023 02:57:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 02430B816BF;
	Tue,  3 Oct 2023 02:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19CC433C7;
	Tue,  3 Oct 2023 02:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696301824;
	bh=VaFWFM5fxDWGkb8H1vk6Bq8dR22TjRNx4fMlMFNeYbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fcq3zcCoO8Cw3fSu03I/MN7v4SZVVerKmQLt2XdPAdd7oRhQuf/3qGM718GYYKXHr
	 XYLU3kV10AQEcShXicFobffOpIo33qy2nJhifxPjZROX1vPVEEt0c8Pz3JkK/8jbIT
	 6LVV4LblD5xEPcQDCvNh7+FXEWbywSAq5R7Arlb9QueR6vapcefnZ2kHNvdW/OyJP/
	 9eY+eZ0+4caJ2Nx2QB6+hdzRq61ZL115VvKrna6IYqrqH1D680fWp8IxG+bAtUNo7O
	 ZG4OuNPJzfpH1L6gTDg2BwvvXSB5MDg3XIwWbOQa7fnSrhQeGW/0/YK4SrYySgvCkB
	 zS58IZ7Vc1rzw==
Date: Mon, 2 Oct 2023 19:57:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20231003025703.GD21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
 <ZRtztUQvaWV8FgXW@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRtztUQvaWV8FgXW@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_195711_794873_1E0532A6 
X-CRM114-Status: GOOD (  26.24  )
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

On Tue, Oct 03, 2023 at 12:51:49PM +1100, Dave Chinner wrote:
> On Mon, Oct 02, 2023 at 10:51:36AM +0100, John Garry wrote:
> > On 01/10/2023 14:23, Bart Van Assche wrote:
> > > On 9/29/23 15:49, Eric Biggers wrote:
> > > > On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> > > > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > > > index 7cab2c65d3d7..c99d7cac2aa6 100644
> > > > > --- a/include/uapi/linux/stat.h
> > > > > +++ b/include/uapi/linux/stat.h
> > > > > @@ -127,7 +127,10 @@ struct statx {
> > > > >       __u32    stx_dio_mem_align;    /* Memory buffer alignment
> > > > > for direct I/O */
> > > > >       __u32    stx_dio_offset_align;    /* File offset alignment
> > > > > for direct I/O */
> > > > >       /* 0xa0 */
> > > > > -    __u64    __spare3[12];    /* Spare space for future expansion */
> > > > > +    __u32    stx_atomic_write_unit_max;
> > > > > +    __u32    stx_atomic_write_unit_min;
> > > > 
> > > > Maybe min first and then max?  That seems a bit more natural, and a
> > > > lot of the
> > > > code you've written handle them in that order.
> > 
> > ok, I think it's fine to reorder
> > 
> > > > 
> > > > > +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
> > > > > supports atomic write operations */
> > > > 
> > > > How would this differ from stx_atomic_write_unit_min != 0?
> > 
> > Yeah, I suppose that we can just not set this for the case of
> > stx_atomic_write_unit_min == 0.
> 
> Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
> filesystem, file and underlying device support atomic writes when
> the values are non-zero. The whole point of the attribute mask is
> that the caller can check the mask for supported functionality
> without having to read every field in the statx structure to
> determine if the functionality it wants is present.

^^ Seconding what Dave said.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

