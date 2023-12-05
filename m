Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FB4C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Dec 2023 04:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xY31OtXpm6KSv94nmxlfIijYjDNR0HuHd+Om4l/DRL4=; b=UDuy1R6+loPgkxqCz/3PN7NuXp
	6m6opUsHhyk/if0oMai4rru0vwvvz0EyC2ZWVi/4B/7Eb/fGXp9PCjNSMzfoyV5k0Hyaf07oQFLkY
	GcpHyePC/W1nuRlwstoPYEQferBhU3K5OkU3jFZW+W6aL9wzRT8u1Np8DNfT776eRWl7YVxScX0sK
	bVU0sw57DLZ/iU8XWsAfxPncMNE7xAXOmMlWfIUxD4SqIsoDaVPxK/gulrI10pY1Wt2hNXIL+6KoT
	Czj81W3HB4G/0rn6+8TCIv+pxH+MVLx+pRO8wruWk/esdr+gzNHc9P0rEaGVvsNNXnzvAC8Ed0rio
	RFuasMwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rANTu-006GEj-2D;
	Tue, 05 Dec 2023 04:56:26 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rANTr-006GEP-0b
	for linux-nvme@lists.infradead.org;
	Tue, 05 Dec 2023 04:56:24 +0000
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B54tdZl016948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Dec 2023 23:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1701752144; bh=xY31OtXpm6KSv94nmxlfIijYjDNR0HuHd+Om4l/DRL4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ULAuEAImbbRp/EKwZ7vqMIWXT6OjmvjIgkTgGyD2NyabpELmR3xt1M7Wv5tFphTNy
	 XiZVg+kRB4tu3DD9cFnL521xALsq037uudWRmRUK7vkgoYcEoqgB+Htr4GUEL0xIyy
	 LNPjeRK8WI4kaZRcQ+8btulffIuW+dUqWHrMOgabNvPzMOdbmgmh9p5eHW3WRVb/ep
	 Yi7dzwjk72n8SsYenWwqy0BIa468+PEZe3uAIMnixXE8eMy6TAzFNehDAUg68SjnCk
	 /52qTNwdL2JoY1vDMEizYdaR4Y9c40vZA++hZxVi6HpdiFL1SvlEc/7gPguBe1Lv+1
	 /K1ac43DNI/4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 626A415C02E0; Mon,  4 Dec 2023 23:55:39 -0500 (EST)
Date: Mon, 4 Dec 2023 23:55:39 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jbongio@google.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231205045539.GH509422@mit.edu>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-18-john.g.garry@oracle.com>
 <20231109152615.GB1521@lst.de>
 <a50a16ca-d4b9-a4d8-4230-833d82752bd2@oracle.com>
 <c78bcca7-8f09-41c7-adf0-03b42cde70d6@oracle.com>
 <20231128135619.GA12202@lst.de>
 <e4fb6875-e552-45aa-b193-58f15d9a786c@oracle.com>
 <20231204134509.GA25834@lst.de>
 <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a87d48a7-f2a8-40ae-8d9b-e4534ccc29b1@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_205623_491334_59895D78 
X-CRM114-Status: GOOD (  18.27  )
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

On Mon, Dec 04, 2023 at 03:19:15PM +0000, John Garry wrote:
> > 
> > What is the 'dubious amazon torn-write prevention'?
> 
> https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage-twp.html
> 
> AFAICS, this is without any kernel changes, so no guarantee of unwanted
> splitting or merging of bios.

Well, more than one company has audited the kernel paths, and it turns
out that for selected Kernel versions, after doing desk-check
verification of the relevant kernel baths, as well as experimental
verification via testing to try to find torn writes in the kernel, we
can make it safe for specific kernel versions which might be used in
hosted MySQL instances where we control the kernel, the mysql server,
and the emulated block device (and we know the database is doing
Direct I/O writes --- this won't work for PostgreSQL).  I gave a talk
about this at Google I/O Next '18, five years ago[1].

[1] https://www.youtube.com/watch?v=gIeuiGg-_iw

Given the performance gains (see the talk (see the comparison of the
at time 19:31 and at 29:57) --- it's quite compelling. 

Of course, I wouldn't recommend this approach for a naive sysadmin,
since most database adminsitrators won't know how to audit kernel code
(see the discussion at time 35:10 of the video), and reverify the
entire software stack before every kernel upgrade.  The challenge is
how to do this safely.

The fact remains that both Amazon's EBS and Google's Persistent Disk
products are implemented in such a way that writes will not be torn
below the virtual machine, and the guarantees are in fact quite a bit
stronger than what we will probably end up advertising via NVMe and/or
SCSI.  It wouldn't surprise me if this is the case (or could be made
to be the case) For Oracle Cloud as well.

The question is how to make this guarantee so that the kernel knows
when various cloud-provided block devicse do provide these greater
guarantees, and then how to make it be an architected feature, as
opposed to a happy implementation detail that has to be verified at
every kernel upgrade.

Cheers,

						- Ted

