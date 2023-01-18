Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229D5C6379F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 07:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kT9JLnHNM2TkFpmwX74T8K9Vx7Co8BPCp+r3Yxy2zqY=; b=dU8W49fY9k1yNm6YK8NxkrVO2W
	d68w2hxBGBdOXjO2sOblWgPmY6wMVO8mB6Rm6ZmOSGA+qyDNrRSMPbSPqKZeikLvOMbvszLEnCDz3
	R4OiaZbVWK13eaRK2OQxeaXXo53PbsiBAQ6cYE3UeiJswkVD+lyn63QBW5t0jhVYdv2fovTUbSxvv
	OUdU8SywSENr5hYxULqGntq/ZMx8kqocOyMmvyoGRHbGGwNry9cxUP/E5V5DJJhB4sXBwKiusWM6j
	p13OSkl5UJJ5hX9U23BRE8XLVGE1IrYAxTx61Gpo3xqaibd0qNjgD23G/oDWV6DaKAA63q3sIrMIw
	MyJuDQvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2hG-00HAU9-4C; Wed, 18 Jan 2023 07:17:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI2hB-00HAQj-M0
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 07:17:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3E9F1616CE;
	Wed, 18 Jan 2023 07:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB21C433EF;
	Wed, 18 Jan 2023 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674026236;
	bh=TPFbez4kRFQWTS4pIsn2TRE2Yeh3bO7Q6hZYSQ1W6pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBE1GvKyWgekNTYsa39JH90glVPf/zresTYnQ0oYxuizvsX6fM5mfbTi+0R6Ij98l
	 YyaDFKnsM6lTyQmL6e2hpKrsC5rvStWq4oOvBnVVT0o/wKzFhIVItTIkr2TYxKT23l
	 7rqy5WkpcyR27VdIF1yTxHowykDskkvhjoUUG53ZfOQR2moXA8Jxhb1pFtb7BfhQWW
	 P0tpyi+0OtQuTEKt00PruI9rK9RKu8zppqgEd/TVL/h3TTTQsh2MB7hpZmsviYbo8P
	 vLSJorCADin7THDqDQl/r4t7iaa9cPH75VNP1IT+BlbB2MeyX2Jv7uPewvM9XoZFkR
	 ObUnV48z0C9Bg==
Date: Tue, 17 Jan 2023 23:17:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Bryan Tan <bryantan@vmware.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Israel Rukshin <israelr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vishnu Dasa <vdasa@vmware.com>, Yishai Hadas <yishaih@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Message-ID: <Y8ec+vUqitvvLKHL@sol.localdomain>
References: <cover.1673873422.git.leon@kernel.org>
 <Y8eWEPZahIFAfnoI@sol.localdomain>
 <95692a47-09e7-0055-2006-46d085b2eadb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95692a47-09e7-0055-2006-46d085b2eadb@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_231717_820717_8154720F 
X-CRM114-Status: GOOD (  24.88  )
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

On Wed, Jan 18, 2023 at 07:14:30AM +0000, Chaitanya Kulkarni wrote:
> Eric,
> 
> >> Notes:
> >>   - At plaintext mode only, the user set a master key and the fscrypt
> >>     driver derived from it the DEK and the key identifier.
> >>   - 152c41b2ea39fa3d90ea06448456e7fb is the derived key identifier
> >>   - Only on the first IO, nvme-rdma gets a callback to load the derived DEK.
> >>
> >> There is no special configuration to support crypto at nvme modules.
> >>
> >> Thanks
> > 
> > Very interesting work!  Can you Cc me on future versions?
> > 
> > I'm glad to see that this hardware allows all 16 IV bytes to be specified.
> > 
> > Does it also handle programming and evicting keys efficiently?
> > 
> > Also, just checking: have you tested that the ciphertext that this inline
> > encryption hardware produces is correct?  That's always super important to test.
> > There are xfstests that test for it, e.g. generic/582.  Another way to test it
> > is to just manually test whether encrypted files that were created when the
> > filesystem was mounted with '-o inlinecrypt' show the same contents when the
> > filesystem is *not* mounted with '-o inlinecrypt' (or vice versa).
> > 
> > - Eric
> > 
> 
> I'm wondering which are the xfstests that needs to run in order
> to establish the correctness/stability apart from generic/582
> this work ?
> 

See https://docs.kernel.org/filesystems/fscrypt.html#tests.

- Eric

