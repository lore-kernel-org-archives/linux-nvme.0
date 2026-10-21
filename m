Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FB606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AcVj3cqo;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=KlcI4dG7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mxq8kuo1w0yT9pwlujpaWDKFUlFP+9O+MLIpqh9/Bfc=; b=AcVj3cqoYl0XUuedkZhEu8uAWz
	WOTxXd5kRwH0IlwIZwHsXWJw03IB2tD8UWZv6LHS6VFd7lvZZebuqRDL/KNIUaoun+i/lavzTyRjC
	yn7FAE/PUmMyML9b+ytBcbTEbTQQ+2bDBTcHjj7X21ZoAulOXEu8k1HtvW+rwclntospux5dNtgrS
	IqdVFunuiKFfAgGBV+TJhEW9p7KIWVr6oxo4Ed2P4BazrxRqw2GCtOfxvmnBxdOp16WnX1KTzSEq+
	G12pCtz9JSc1qM3kz9Ft6rXaKopbWzpxdcZzCWdQ2rQW+ffzwhxopRreTZC91EpWOXE2DWInRYobU
	+ImUBDVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJT84-0000000BYWs-4668;
	Wed, 21 Oct 2026 10:01:04 +0000
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJT83-0000000BYWO-2CDp
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 10:01:04 +0000
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-35f1f76ea84so756560eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 03:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1792576862; x=1793181662; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxq8kuo1w0yT9pwlujpaWDKFUlFP+9O+MLIpqh9/Bfc=;
        b=KlcI4dG7b6bvoyUeIEj5g70OoHHnCKAPHmTpyyMSnlpMYY/21LP4g+EOT9aBpgtkcV
         jrfL1Gyl8Bdm3Fb/bPXDKHd4ZhXpgGEKBCveMsIR7FUTFR0ywIhNKKLpaNCqXTRVCKTJ
         fIIKocYFhqGJNCgZvYyyPoBiuFg9EFnX0kYBJiiHhZ/bT2cpv0/ESnYgtJ41UxUmG5eX
         mnFUohYBRZavHP/s/9h11X8jVW5S4VhMEhhVCMdwDqhD/0qUb1Ap5voOGbj9WMjCX3ye
         ZR4bmH/NzrLtqDa8nCU/Y6+ZUsl1kWm/xeovMfkYlvtYLeeDbGWFfDxO29ONZI3Fq8Qm
         k7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576862; x=1793181662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mxq8kuo1w0yT9pwlujpaWDKFUlFP+9O+MLIpqh9/Bfc=;
        b=u2hchtvVfH3LdrBX0lP2m189F3S23LvsRZrdumniiEAuhQjE7B/v4CcxvpULYRdm9E
         Jw/xygme5DSgnIIXAI0jaDTa8AoGIj7SmwNffb53Z1MT6lt5FpNAEQZ8btCujb2myMs6
         RHBZpoJ9XZMmC22mSvC+SfbmbrJkuoMfIfnCimVmuAnnEOkR8kz3M7rQzO4Afiaatilm
         CGfx6qD3V4V2FebXXm0E28ySjzzhjiMfI+DI0WqwyeEhNyv71Xbf/Z4xUOjvuuEgSU81
         usmbMNQGDFT4FOPU/b+cBRFsObYR2vAW9wLGWFbn1VCAb2IhyLrW1KDPGagj0sGkVA0E
         8tLg==
X-Forwarded-Encrypted: i=1; AKwUvBxrip1OpVD1vE6IMBvJoVyMA+SzsqoGCl/vurrXPjL/r0jtr+LhxsSm5Q3YncdCoWnfmb6D0czwhlUO@lists.infradead.org
X-Gm-Message-State: AFq9FYIk8KMPuEDijYmtkhdG4Ap3u0QOPYrFhJjGzVctXPlqY1pFWUh9
	xZo1+DRfPpAZVzjKPA9sVeAglydtJ8NPsFuJ2Wu6oXZIpXzbkRYVygQ2AZNKQx7AUeCgOzn2MjP
	FFSBmR14=
X-Gm-Gg: AYBFou0PGdYOd5ziOwugyQgv6WObuzE+u7KoxLDerbtoHWa7KRm1iZ7KfGptyr7KL7I
	aNHDMWjiQz0w4hqqOpriKVDLWBmC4cfpOYobQBh9bHdejDDQ5A61wNfRtNqy8uw/TDX1wJEtUM9
	rIZ+6J4tzG+bWrXcfTvnP/VDMaQWlGuTYAolL2kUJNraTGzUi1Ea+wU1baMgsyZ/oAU4xlUSNZV
	CD0cWxb4GgVg+9vtmDpQfEyVt5wg7cN7vZBC4O4jvg4e3MRlH7VltskmCHWyTQcJePDXybH4YyJ
	leahzvglJo10C3FX7B+GeAxhq62IeFSpbFh34kjbLtpsNX2nwYG7RTPi3DmVuL8hV8mgMPaggIv
	QOR5xznHPg31zm1aUdmQtqpaEb8WDZgrDlgNcr+iOesfX7lCnGcgraEszEplZkT3o48u8XMWq1R
	mSXH+vB9Jz3P2a+W0Y/BpipipBFWAModcLcgeys0yQiQQ3iiwZcWoCGCqvuEZ6QOMts08+pmqCH
	yqRSq3Gj3MM/gCMb89ZKa708uO9TvGG3xM2dwzaIcl2fTB0BcEBesrwGHXPQ/BPl/ALdqAQY+Iv
	ZGp74SIxZfRABHSoVH1H/OVQzBEIV02E5A==
X-Received: by 2002:a05:7301:1a83:b0:360:4199:ff11 with SMTP id 5a478bee46e88-3674ce2f9e2mr2465279eec.12.1792576862194;
        Wed, 21 Oct 2026 03:01:02 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([2601:647:4381:36fd:9c31:126:4a90:466f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405edd7bsm5915070eec.6.2026.10.21.03.01.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 03:01:01 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: Daniel Wagner <dwagner@suse.de>
Cc: Saravanan D <saravanand@crusoe.ai>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	sgogte@purestorage.com,
	hare@kernel.org,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai
Subject: Re: [PATCH v5 2/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Wed, 21 Oct 2026 03:00:55 -0700
Message-ID: <20261021100057.85647-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <79b5a23a-5ecf-4e96-85c8-031b5eca2867@flourine.local>
References: <20261018010059.83120-1-saravanand@crusoe.ai> <20261018010059.83120-3-saravanand@crusoe.ai> <0ee4d281-61b4-458e-92c6-7fff3e50c0ec@flourine.local> <72fce5bb-b256-42aa-8844-f970c4480ad3@suse.de> <79b5a23a-5ecf-4e96-85c8-031b5eca2867@flourine.local>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_030103_587620_F2802F1D 
X-CRM114-Status: GOOD (  22.49  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:19:37AM +0200, Daniel Wagner wrote:
[...]
> There was a lot of discussion during Linux Plumbers on how to configure
> a system for the isolcpus case at runtime. From what I understand, the
> preferred interface for this is cgroups. Hence, pinning the CPU for this
> work is likely a target for it, though I don't think there is a need to
> figure it out right now. I just wanted to highlight this point.

Thanks for the pointer. I see the two as layers. cgroups decide which
CPUs a tenant owns. io_cpu then places a queue's socket work inside
that set. Today our control plane writes it, and a cgroup aware tool
could write it later. So io_cpu would not need to change if the
isolcpus configuration moves to cgroups.

On your earlier isolcpus point, the store only requires the cpu to be
online, so a queue can be pinned to an isolated cpu at runtime, for
example one that belongs to the VM issuing the I/O, even though blk-mq
leaves isolated cpus out of the hardware context masks.

> However, to make this truly user-friendly, I think nvme-cli should be
> extended so it is aware of this and can configure it directly. I've
> merged Nilay's --nr-io-queues patches, so this is the natural next
> feature nvme-cli should support; see commit:
>
> e170d6985797 ("news: document the use of --nr-io-queues during nvme connect")

Agreed. Once the ABI settles I'll add nvme-cli support to show and set
io_cpu per queue, following the --nr-io-queues work you merged.

> I would also really like to have a blktest for this as well.

I'll write one and post it alongside v6. It will use nvmet tcp over
loopback and check that

  - io_cpu reads and writes work and invalid values are rejected
  - an assignment survives a controller reset
  - the queue directories follow the queue count as it shrinks and grows
  - deleting the controller while io_cpu is written is safe

Thanks,
Saravanan D.

