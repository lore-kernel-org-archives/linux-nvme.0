Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299EDFD9E0A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8o1JNecTz/67qidTlo3xSpBMPNRej6TqsQ4eRKw7JE=; b=snW6sCY9ya42zXsynU2g+kgoif
	ZaimlJviH4CTqgqIlIP86aE221DvfbdDYM7copiZLAUN43QsI9cwHiV0z5bWwGrLW3t4cY8DWtI9H
	CAdh7XdZ+rYmvxmJKEgffMplWWVjXomF9NuWIbQmS7dWv7HGW/1MwkR5nd27oz9afxp1YAw6evUd6
	Ri/28gr307Yk/OD1XK46G9t+9TK31ZNfUUiFLwzQUTIaP3EAKXpPZn4fAa9QlKbM3UgCOaNHZ5cJo
	N+vZjO0jYU9vg3ItMwnNpnj8VKDa86TzYu64J3Cx516nuQLkO8FtXs2bl2HUTkqIvjUAwOWqD5hl/
	hj54RCcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvimE-00000007EXE-14Y9;
	Thu, 26 Feb 2026 21:20:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvimD-00000007EWx-1Qlo
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 21:20:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 65BD0600AA;
	Thu, 26 Feb 2026 21:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B8C116C6;
	Thu, 26 Feb 2026 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772140804;
	bh=LcL/r6T0bwMo65lkXjTX40Fej57IPijPz0S5OcvY14A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcbecYNxyD0Arty+tjaqDKnyQYiFGrH+9d7j3f1EcmyVIxuEVg/qOGLQSs7KCwf4h
	 yfu4H2IZT/tx8LGFZAbBMMydQCW4DqGd7pamXr2AssEsiT+Lputy0Er8VWBWy0XdE4
	 SZgkXwjbXrdpQ+8YJ5beTsTBsSdT5cPbw+p8YD86om+FP2vjccOCW8T1mQsDc6oRad
	 qsXWL1tw8eB/60peuIvDVsxPGdpDHFEd7vMsYtKpTFM8UZMVEZ0LNs15OTSmqDaF70
	 6w871y3QEgmKvq+H5EsNTHFkP+dmheB3iSicMfZe4w7r69jnh5TtP26Mg0C2zEcUw3
	 gWoaSzSqSUfag==
Date: Thu, 26 Feb 2026 14:20:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <aaC5AkJyqKZJSidf@kbusch-mbp>
References: <20260226190416.297725-1-csander@purestorage.com>
 <20260226190416.297725-7-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226190416.297725-7-csander@purestorage.com>
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

On Thu, Feb 26, 2026 at 12:04:13PM -0700, Caleb Sander Mateos wrote:
> +	if (optperf & 0x2 && nvm && nvm->npdgl)
> +		npdg = le32_to_cpu(nvm->npdgl);
> +	else if (optperf & 0x1)
> +		npdg = from0based(id->npdg);
> +	if (optperf & 0x2 && nvm && nvm->npdal)
> +		npda = le32_to_cpu(nvm->npdal);
> +	else if (optperf)
> +		npda = from0based(id->npda);
> +	lim->discard_granularity = max(npdg, npda) * lim->logical_block_size;

I suspect some controller could report a very large npdal/npdgl such
that the multiplication result overflows the discard_granularity type,
so let's check with a fallback:

	if (check_mul_overflow(max(npdg, npda), lim->logical_block_size, &result))
		lim->discard_granularity = U32_MAX & (lim->logical_block_size - 1);

