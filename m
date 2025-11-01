Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39A5CCF9F8
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Nov 2025 04:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayTIfD7whzLPYpUkvuktFiUFcv8ZvLt1DjOdUhKwweU=; b=PzpNdqgsmrULBsvRS7YegptEY0
	3iC6F/C3QCEE7qDLm+TTtETJVvfjrdE9KNSG/Sb0yoKdcyNM0wHje/cZd/no7o3qtTY4ghNybP5aW
	LHt3rBzo/B+WVdw/gkAxlAfa8wek7JMRvHFSc5PG35IymzVkdXUubAw60LJazyXBsP4S/h0GP3McV
	T4/kNZcTlMndaIoVPh4Lng0b7ikE/ZnyDRYhjQHpTPIyTx9y95s6coBsF3JS+Gb83mdu9qDNOG6Cm
	9jQxECz42mi/aRWgX7mX52JhE0XobOm8H3InIyKS/FhgfYQ9nhyzNdc/mm34aEOa3DoYuWpN9adu/
	2q83CNFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF2w7-0000000739S-2KvW;
	Sat, 01 Nov 2025 04:09:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF2w4-00000007392-2GEN
	for linux-nvme@lists.infradead.org;
	Sat, 01 Nov 2025 04:09:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 67CE04325F;
	Sat,  1 Nov 2025 04:09:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB93EC4CEF1;
	Sat,  1 Nov 2025 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761970189;
	bh=vIzIpGr+Y0KCqjEMshY9/Fa+K5rSJIBw2Btho9NZx94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BUybZAkrmZfEv7OYCM/DQB6sLpaells0D9RK8FedH5j5ONj6Zc5Wf7hVGuEMiJ2sp
	 /4HBi8fOxSJ0Oc20nFFr/ao8OIzmN2b/2KTE4JE3Yfp+OaWrfx/t5tmQrw/tYlJU+H
	 8+6CzSZTVaoSPbpAL8gNFj2ZcLurm3NnLnIIzKBI=
Date: Fri, 31 Oct 2025 21:09:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org,
 xiubli@redhat.com, idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me, visitorckw@gmail.com, home7438072@gmail.com,
 linux-nvme@lists.infradead.org, linux-fscrypt@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-Id: <20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251031_210952_650423_0BD81B3E 
X-CRM114-Status: GOOD (  17.10  )
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

On Wed, 29 Oct 2025 18:17:25 +0800 Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> This series introduces a generic Base64 encoder/decoder to the kernel
> library, eliminating duplicated implementations and delivering significant
> performance improvements.
> 
> The Base64 API has been extended to support multiple variants (Standard,
> URL-safe, and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes
> a variant parameter and an option to control padding. As part of this
> series, users are migrated to the new interface while preserving their
> specific formats: fscrypt now uses BASE64_URLSAFE, Ceph uses BASE64_IMAP,
> and NVMe is updated to BASE64_STD.
> 
> On the encoder side, the implementation processes input in 3-byte blocks,
> mapping 24 bits directly to 4 output symbols. This avoids bit-by-bit
> streaming and reduces loop overhead, achieving about a 2.7x speedup compared
> to previous implementations.
> 
> On the decoder side, replace strchr() lookups with per-variant reverse tables
> and process input in 4-character groups. Each group is mapped to numeric values
> and combined into 3 bytes. Padded and unpadded forms are validated explicitly,
> rejecting invalid '=' usage and enforcing tail rules.

Looks like wonderful work, thanks.  And it's good to gain a selftest
for this code.

> This improves throughput by ~43-52x.

Well that isn't a thing we see every day.

: Decode:
:   64B   ~1530ns  ->  ~80ns    (~19.1x)
:   1KB  ~27726ns  -> ~1239ns   (~22.4x)


: Encode:
:   64B   ~90ns   -> ~32ns   (~2.8x)
:   1KB  ~1332ns  -> ~510ns  (~2.6x)
: 
: Decode:
:   64B  ~1530ns  -> ~35ns   (~43.7x)
:   1KB ~27726ns  -> ~530ns  (~52.3x)


: This change also improves performance: encoding is about 2.7x faster and
: decoding achieves 43-52x speedups compared to the previous implementation.

: This change also improves performance: encoding is about 2.7x faster and
: decoding achieves 43-52x speedups compared to the previous local
: implementation.


Do any of these callers spend a sufficient amount of time in this
encoder/decoder for the above improvements to be observable/useful?


I'll add the series to mm.git's mm-nonmm-unstable branch to give it
linux-next exposure.  I ask the NVMe, ceph and fscrypt teams to check
the code and give it a test in the next few weeks, thanks.  


