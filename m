Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8533CC83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yortp8DQM9h5jDV4ktt5QS/yckQSk8w9yRRz0+aBy+M=; b=U/c5xrEtVB2OYxqk6apxu5NaXM
	ssPJuepTHXCzAWPkZ9Xad34PSKwocRVFsY8PKDmNHZxOOWg876DgC7gTdxjmb7viFu2Nn4MhDZOji
	Aap6LjY7v8TP7MahQFhtqKHSPUGROZ0mmu7PDc4qMlgLe1s+68LpKKQEU4f5h7Bwcbetpd01SytC+
	5iaFZu9DpqZKU4HaeIqyujFUPmr8BtrJZFcpXrvdkB5e/9OWwBa3ut4e8FQ8lEFb+a3F28LH25HaP
	hMDSHljNOxobLz2xyF4HbiHw+HBrAemWX/iQa95huhN2ACrm6yaIhFasMRPBgn2FybZLVo8QP6dpR
	N2JWDUIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJGK-00000002Int-0HDC;
	Mon, 14 Jul 2025 13:30:32 +0000
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJAH-00000002HQd-0G73
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:24:18 +0000
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56EDO7e7018267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752499449; bh=Yortp8DQM9h5jDV4ktt5QS/yckQSk8w9yRRz0+aBy+M=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DoHGCDv+9rVd2QhBf+0OhoGjwL2U2lmnZSH52o3YUvcZ6qr3TxSlyLmoBycjlgtuB
	 WNc6hlhXqqdKC1c7/Xk3EYFyXXY9y1ynDrLeYfMd4PilNwa2R39BiTv4Qculs5q0Fg
	 p27zYogMsXy3Hwx/WvnXUKsfcnwZ589FnCVrxUvuFyO3LR3LRCVRTaaLusvekH95i4
	 1whCZhhWHetpFI9k/JHoiX4IPhT52CP0Jr/LCkEfMz+99ORY5C6lDnXIFPd9YSNqUX
	 Bjh8wr8NByRGkVFNm+oOxa5tZEFg5j++MBNNjAT+OSPFa9Fd0MIxsA/E67iaVq5c2v
	 6XMnJA7EKO9Xw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 30C412E00D5; Mon, 14 Jul 2025 09:24:07 -0400 (EDT)
Date: Mon, 14 Jul 2025 09:24:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250714132407.GC41071@mit.edu>
References: <20250714131713.GA8742@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714131713.GA8742@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_062417_339889_ED422EAF 
X-CRM114-Status: GOOD (  16.49  )
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

On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> I'm currently trying to sort out the nvme atomics limits mess, and
> between that, the lack of a atomic write command in nvme, and the
> overall degrading quality of cheap consumer nvme devices I'm starting
> to free really uneasy about XFS using hardware atomics by default without
> an explicit opt-in, as broken atomics implementations will lead to
> really subtle data corruption.
> 
> Is is just me, or would it be a good idea to require an explicit
> opt-in to user hardware atomics?

How common do we think broken atomics implementations; is this
something that we could solve using a blacklist of broken devices?

It used to be the case that broken flash devices would get bricked
when trim commands would get sent racing with write requests.  But
over time, the broken devices died out (in some cases, when the
companies selling the broken SSD's died out :-).  It would have been
annoying if we had to explicitly enable trim support in 2025 just
because there were some broken SSD's existed a decade or more ago.

	       	  	      	      - Ted

