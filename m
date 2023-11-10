Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D03FC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Nov 2023 06:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBAjKQAagp85y8dwN4jl/DtlnXYFyVjaHB0W4evQhAw=; b=KlEsyR/CRIcavUPMrrBhhzibRH
	2oR2JBmse6w+AUK/TInD0GahC0RzFul/R96CokesGJJBxIiOUZII6dTFbP2yjmFJCCctJ/dMGv6/0
	i2HE6IG/1qKntVxwjCuS/nU8ERtZp0jP56DmoToBJnD/u71zxThkDkjUJZc5wGMVGcZuey5jUOWr6
	5ceV2U71QCBnztO79TKboe4LgGXgC+n0BpyXyESB2tnSplcVmDKDD1cYt0OlkhOJh0/ZXAiyfRtfG
	AdbtJs2xfmqoJuBJC1MrFUC55z0AjVuqsqyzfL82tQ5NBJqARgfE8hrOApByjtLb84CpFkJj6lCLE
	njkvdkCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1L1b-007xlV-1H;
	Fri, 10 Nov 2023 06:29:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1L1Y-007xku-2w
	for linux-nvme@lists.infradead.org;
	Fri, 10 Nov 2023 06:29:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6FB5467373; Fri, 10 Nov 2023 07:29:44 +0100 (CET)
Date: Fri, 10 Nov 2023 07:29:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org, Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH 21/21] nvme: Support atomic writes
Message-ID: <20231110062944.GC26516@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-22-john.g.garry@oracle.com> <20231109153603.GA2188@lst.de> <ZUz98KriiLsM8oQd@casper.infradead.org> <20231109154619.GA3491@lst.de> <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b25fe8-22ae-c299-3225-ca835b337d41@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_222949_090787_4522503A 
X-CRM114-Status: GOOD (  20.40  )
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

On Thu, Nov 09, 2023 at 07:08:40PM +0000, John Garry wrote:
>>> send a write that crossed the atomic write limit, but the drive wouldn't
>>> guarantee that it was atomic except at the atomic write boundary.
>>> Eg with an AWUN of 16kB, you could send five 16kB writes, combine them
>>> into a single 80kB write, and if the power failed midway through, the
>>> drive would guarantee that it had written 0, 16kB, 32kB, 48kB, 64kB or
>>> all 80kB.  Not necessarily in order; it might have written bytes 16-32kB,
>>> 64-80kB and not the other three.
>
> I didn't think that there are any atomic write guarantees at all if we ever 
> exceed AWUN or AWUPF or cross the atomic write boundary (if any).

You're quoting a few mails before me, but I agree.

>> I can see some use for that, but I'm really worried that debugging
>> problems in the I/O merging and splitting will be absolute hell.
>
> Even if bios were merged for NVMe the total request length still should not 
> exceed AWUPF. However a check can be added to ensure this for a submitted 
> atomic write request.

Yes.

> As for splitting, it is not permitted for atomic writes and only a single 
> bio is permitted to be created per write. Are more integrity checks 
> required?

I'm more worried about the problem where we accidentally add a split.
The whole bio merge/split path is convoluted and we had plenty of
bugs in the past by not looking at all the correct flags or opcodes.

