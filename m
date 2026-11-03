Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CE606A32E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mOY2sAYF;
	dkim=pass (2048-bit key, unprotected) header.d=sandisk.com header.i=@sandisk.com header.a=rsa-sha256 header.s=dkimnew.sandisk.com header.b=EPhCnT0p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Es+iUNXb2N93UImwfSO2oOUm0ra/6NQPCq5iI5VuFgY=; b=mOY2sAYFD6FUCK
	TX2wnk7mwjm5gtSk2VWUMI1dwLZf8eNJGRI0ThOWIan+GLRVIt9zvRvwP88z3o5kqSpQK0BaXQi6o
	JxiaZb5pQqt62hl5t7U4BlsIe95GFG4GqQLEwvprqHEoc05aUx2knrpX8a/l96A5K33lpbB3wk6bd
	SdJShHAMvT85oC2yu6rSruJ3s886ZcebhwMXU6eHCGHMMyu3R5cPjEHunxuCJBX62GHc5w54hBbkI
	q+MaNRZ8zRa6gdnwNFx52h80oTBRF6CZnfVtQWBAM2rQHECdOM/ZFV4+EP67ol2fVas/kJGVe1NEr
	/KDxh1UWg5cR4ny+6OGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAyl-00000001ltA-1t3I;
	Tue, 03 Nov 2026 09:38:55 +0000
Received: from esa.hc6817-7.iphmx.com ([216.71.154.88])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOAyf-00000001ls4-3KTj
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 09:38:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1793698729; x=1825234729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gILW4913DJmhe6Xf2zy1YvOrI0lTdtkeeHEK4vy7j4=;
  b=EPhCnT0p+OwvdNreSZ3jlA1jKtXNRLm7ntnW+4jbh0v66Q5YgHF4EIQr
   8grgXRL3WkOnm73/kyFTOb+a4iiekD8ffo4LBnuT0Un/yonnw6ZwIMKth
   S683hjz/y5jfU/55dFfz5Zd+JEoqb/RL56WWdWwwNZl+dK9GU09N3J9JA
   7SJ0+Ws/M2aSH19WUFz/E/5UyKNeVqrBPFDQQxA5fOS5JgE4XlvnLDZfG
   Wz8P87L22nFvQdIu3sQEkOP3h+fznLhS1irl95JlrGntvRM4SBAyL3TwN
   bfWdvBRiB2j/z4fHa6+y/+wfAuyKlVxdCvwemEz4cdtt/sKLkr/6Lg6Yj
   Q==;
X-CSE-ConnectionGUID: 1B2cvIPRSeOZv23ZLMUa1g==
X-CSE-MsgGUID: bHcXkV4MTL+xnzcr4/dRvw==
Received: from unknown (HELO uls-op-esaep03.corp.sandisk.com) ([129.253.192.43])
  by ob1.hc6817-7.iphmx.com with ESMTP; 03 Nov 2026 01:38:48 -0800
X-CSE-ConnectionGUID: g7tjfEXBS++Pw7w0fEZP8A==
X-CSE-MsgGUID: 3Ga10EZlRKGzidr53AAUoA==
IronPort-SDR: 6ae9aba8_B80L7VrKN8NIPLnk1ght+erPcoNfU/XLrnpZGtbcJEpNqS+
 VGRewwBNM+7TGfMEfiialNypBU+sutlIYErbUNQ==
Received: from unknown (HELO uls-op-esaip04.corp.sandisk.com) ([10.15.0.10])
  by uls-op-esaep03.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:48 -0800
X-CSE-ConnectionGUID: AqC0UPcGQtuzuCT5q0QjBw==
X-CSE-MsgGUID: f0yvLvy8TYWlKwC8Ag5LTQ==
SanDiskIronportException: Internal
Received: from ulssdxvpxsnip.corp.sandisk.com (HELO WDAP-ez2C89klLd.corp.sandisk.com) ([10.9.34.160])
  by uls-op-esaip04.corp.sandisk.com with ESMTP; 03 Nov 2026 01:38:44 -0800
From: Arthur Simchaev <arthur.simchaev@sandisk.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Andres Freund <andres@anarazel.de>,
	Pankaj Raghav <pankaj.raghav@linux.dev>,
	GOST <gost.dev@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Avi.Shchislowski@sandisk.com,
	Alex.Lemberg@sandisk.com
Subject: Re: [PATCH RFC 0/2] Support for Multiple Atomicity Mode
Date: Tue,  3 Nov 2026 11:38:39 +0200
Message-ID: <20261103093839.203841-1-arthur.simchaev@sandisk.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
References: <20260929-nvme-mam-v1-0-48dcbe79cece@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_013849_879616_1E26241A 
X-CRM114-Status: GOOD (  17.29  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 29, 2026 at 01:17:10PM +0200, Daniel Gomez wrote:
> While I think this small feature is worth having (hence this RFC)
> for users sending atomic write commands that are contiguous, the
> question I'd also like to discuss really is how to also expose clear
> MAM semantics to userspace for users who can send larger commands,
> so they avoid syscall overhead [2] and splitting, and still get the
> atomic guarantees in the LBA subranges. RWF_ATOMIC currently exposes
> SAM semantics, but I think MAM may be confusing for users, as it's not
> simply a larger atomic write but an atomic carrier. Thoughts? What can
> work best to leverage MAM from userspace without conflicting with SAM?

Hi Daniel,

I agree that RWF_ATOMIC should keep its current meaning: the whole write is
untorn. Letting it accept larger writes on MAM devices would silently weaken
that guarantee for existing users.

If we want userspace to send one large write with per-piece guarantees, I would
keep RWF_ATOMIC unchanged and add a separate opt-in flag that describes the
guarantee rather than the device mode, for example (names are placeholders):

  pwritev2(fd, iov, 1, pos, RWF_ATOMIC_CHUNKED);

  - statx reports a granule G (e.g. stx_atomic_write_chunk)
  - the range is split at file offsets that are multiples of G
  - each piece is untorn; nothing is guaranteed across pieces

If G is tied to atomic_write_unit_max, a G-aligned piece never crosses an atomic
boundary, because the block layer already requires the boundary to be a power of
two no smaller than unit_max. A SAM device could then implement the flag with
one atomic bio per piece, and MAM would only be an optimisation underneath. Open
questions would be the semantics of partial completion and errors, and how
filesystems keep each piece mapped to one contiguous extent.

Before adding a new flag, though: with this series your fio example (io_uring,
iodepth_batch_submit=4) already sends four 16k RWF_ATOMIC writes as one 64k
command, so a single large write would only save per-I/O work in the kernel, not
device commands. I understand real MAM hardware may not be available, but that
cost can be estimated without it, e.g. by comparing host CPU usage of a batch of
small O_DIRECT writes against one large write of the same total size on any NVMe
device. Even a relative number (e.g. % CPU per GB written) would show whether
the remaining overhead justifies new uAPI.

Regards,
Arthur

