Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF53C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 08:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EuZeiV9N6GflL4JnO8huEJEEo7JB7EtR4jCukhtNzR8=; b=Lzpm4g/IdCdghvjF4AR5P+WnsW
	PkX6/VsWQQsanrwNp5EOL14jS72iFhVF5JBkUyOuCZwYnKmouV3c9FvREHu+8w+/bai6JrWIkFdfy
	eH1dNRtTLFPGDrAwB4oBW8l/twuC3qtEUicy2VTYCh4nVrKUfMHoHhCzpvdjVoWsKOnG4vTCwP+v6
	7QLjxvyJ2BpKx4Up2KVy+gW2sDNOw95WiYBhsrM7kTSSkyO7DtxBR2XPK1kkBTtdS1aFANNce8dzR
	dsPRVM8VIZKW+4kwSUYQy5AvCzSHF9ZCXJlxlKxKM/lr3L7habr6/482HqCdJy6vdlCXUPL910/kQ
	mxhLHliA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm4i-00000005E4i-0fYi;
	Wed, 05 Jun 2024 08:32:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEm4f-00000005E3j-1UIM
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 08:32:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91D4267373; Wed,  5 Jun 2024 10:32:46 +0200 (CEST)
Date: Wed, 5 Jun 2024 10:32:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com, willy@infradead.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v7 4/9] block: Add core atomic write support
Message-ID: <20240605083245.GC20984@lst.de>
References: <20240602140912.970947-1-john.g.garry@oracle.com> <20240602140912.970947-5-john.g.garry@oracle.com> <749f9615-2fd2-49a3-9c9e-c725cb027ad3@suse.de> <a84ad9de-a274-4bdf-837a-03c38a32288a@oracle.com> <ee20a47d-3131-41c2-a2fc-39017f535527@suse.de> <76850f4f-0bd0-48ae-92f4-e3af38039938@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76850f4f-0bd0-48ae-92f4-e3af38039938@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_013249_548286_0451528C 
X-CRM114-Status: GOOD (  13.28  )
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

On Mon, Jun 03, 2024 at 02:29:26PM +0100, John Garry wrote:
> I think that some of the logic could be re-used. 
> rq_straddles_atomic_write_boundary() is checked in merging of reqs/bios (to 
> see if the resultant req straddles a boundary).
>
> So instead of saying: "will the resultant req straddle a boundary", 
> re-using path like blk_rq_get_max_sectors() -> blk_chunk_sectors_left(), we 
> check "is there space within the boundary limit to add this req/bio". We 
> need to take care of front and back merges, though.

Yes, we've used the trick to pass in the relevant limit in explicitly
to reuse infrastructure in other places, e.g. max_hw_sectors vs
max_zone_append_sectors for adding to a bio while respecting hardware
limits.


