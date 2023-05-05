Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF22C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 22:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sqnccyk/dMZ2wf4F3TQE4sRZTZA9O4nCyO6tYuFcb+4=; b=H61v0C1TuG4qlPqWGYbXv238ik
	Mj4F46AR3+EnUPVGAqtvq0FuYIH9s4axsJjaEO9u0tDX/vmXjTgw8Zl2ekwBcH0YBDQoiPQaWj0Iz
	gieo5znp7IXjMh1H/yoTDxbZXlHaoG2MRo98psSGZDE34z4JN/B38ZjpqEvf8JDL4zkeddvuh/bfR
	MlU/WzREUWrLuIFfoYNFZ5l46Z3DoXkywuV+umyWY9nW1lEZnsXs8m8pdxJ3ZgNnp8ZggNk9CATC4
	KTS5TOPCjtFeID/lZT+PtZ2ayUSoffzOpk63GS0Ko2BkjUYihEIt5aGrBrIHuNif0IuuPVPueaPSc
	EyAhg78w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv3Xg-00BwUO-07;
	Fri, 05 May 2023 22:04:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv3Xd-00BwTk-1O
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 22:04:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E73FB6411F;
	Fri,  5 May 2023 22:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A297C433D2;
	Fri,  5 May 2023 22:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683324280;
	bh=f1jvZDrF9Qn33CLcZ4WNk/v3Df+AvMJXxv7DwWGW0QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkpKowf89TZVFXs+kZPV9yhxvlS1WPcn+RJAUjhk+F+NdGsM3DowjGujTCVspntEk
	 cjONoTzL+Mbd5t+9AKB6wfFG/v2mMcL4zUbTCd68MALmZ0bvdAsdyqB1NiUPsHURQx
	 Pb+EiF47Gw2FrzOLU0+uch5xJIwNkrwQ88DqtgRjz2heN6tSAyMM3taWJ6o/co195G
	 InfdsysxEKZtg6MGDEsuLv05bAtcsJBM0d3KZPxDWL0S6H+Cc+wgMhp3zHymC2qu4N
	 b7tWMZGshPp0ERKEWKp+Mkk6aHJZ+zyeGly/ASTr+Ej/LlVg2ok1XVQwXyBr+Dr0m5
	 X42vWMe7zA2bg==
Date: Fri, 5 May 2023 15:04:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jejb@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20230505220439.GK15394@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
 <20230503215846.GE3223426@dread.disaster.area>
 <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
 <20230504224033.GJ3223426@dread.disaster.area>
 <644fe4aa-cb89-0c14-4c90-cc93bcc6bbc2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644fe4aa-cb89-0c14-4c90-cc93bcc6bbc2@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_150441_554776_A6511D7D 
X-CRM114-Status: GOOD (  26.47  )
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

On Fri, May 05, 2023 at 09:01:58AM +0100, John Garry wrote:
> On 04/05/2023 23:40, Dave Chinner wrote:
> 
> Hi Dave,
> 
> > > No, not yet. Is it normally expected to provide a proposed man page update
> > > in parallel? Or somewhat later, when the kernel API change has some
> > > appreciable level of agreement?
> > Normally we ask for man page updates to be presented at the same
> > time, as the man page defines the user interface that is being
> > implemented. In this case, we need updates for the pwritev2() man
> > page to document RWF_ATOMIC semantics, and the statx() man page to
> > document what the variables being exposed mean w.r.t. RWF_ATOMIC.
> > 
> > The pwritev2() man page is probably the most important one right now
> > - it needs to explain the guarantees that RWF_ATOMIC is supposed to
> > provide w.r.t. data integrity, IO ordering, persistence, etc.
> > Indeed, it will need to explain exactly how this "multi-atomic-unit
> > mulit-bio non-atomic RWF_ATOMIC" IO thing can be used safely and
> > reliably, especially w.r.t. IO ordering and persistence guarantees
> > in the face of crashes and power failures. Not to mention
> > documenting error conditions specific to RWF_ATOMIC...
> > 
> > It's all well and good to have some implementation, but without
> > actually defining and documenting the*guarantees*  that RWF_ATOMIC
> > provides userspace it is completely useless for application
> > developers. And from the perspective of a reviewer, without the
> > documentation stating what the infrastructure actually guarantees
> > applications, we can't determine if the implementation being
> > presented is fit for purpose....
> 
> ok, understood. Obviously from any discussion so far there are many details
> which the user needs to know about how to use this interface and what to
> expect.
> 
> We'll look to start working on those man page details now.

Agreed.  The manpage contents are what needs to get worked on at LSFMM
where you'll have various block/fs/storage device people in the same
room with which to discuss various issues and try to smooth out the
misundertandings.

(Also: I've decided to cancel my in-person attendance due to a sudden
health issue.   I'll still be in the room, just virtually now. :()

--D

> Thanks,
> John

