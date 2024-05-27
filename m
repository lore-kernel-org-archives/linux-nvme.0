Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08FCC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 22:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U69OwetF99dmNMp+cBKkE+PyH6iLkIktRMTKrMi3lqw=; b=ij15Zoi1XlazJrXBmwhFKLO/hF
	M1umjaltiMLupu0zeVnsWXoeNVq3JKCMu0M5ZasgKnySn6bWRBWelnQUKF8wK4Jjlgbs5T551OURc
	OEzcA3FzYe2UCOiYjeCv/qzG1VOuJPfqxWBQ1O0TCWmqlJ1PFQzspHZdrxBxI3pDbazDet/h4tVc3
	+3q3X8x6IBNNhyWJ/zFWUeDvEtNqWPP19qyycajwEYiK5z3nLu8n32pedCUf6wNc7uS4gnP74Zknp
	Ye1wJiGl/UrbZdXdtheNFrbrbQeEnpW+6Dbt/EPv8TRPM1qnhesCVbrkpwAzRGe9fDzc3bOSxcTPa
	pC2Apebw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBiZi-0000000GSHx-0GZD;
	Mon, 27 May 2024 22:12:14 +0000
Received: from mx.ewheeler.net ([173.205.220.69])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBiZf-0000000GSHR-2ZRD
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 22:12:12 +0000
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id EBEA287;
	Mon, 27 May 2024 15:12:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8prv4BcT0aEo; Mon, 27 May 2024 15:12:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id F181948;
	Mon, 27 May 2024 15:12:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net F181948
Date: Mon, 27 May 2024 15:12:05 -0700 (PDT)
From: Eric Wheeler <dm-devel@lists.ewheeler.net>
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] dm-crypt support for per-sector NVMe metadata
In-Reply-To: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
Message-ID: <206cd9fc-7dd0-f633-f6a9-9a2bd348a48e@ewheeler.net>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_151211_679446_3E3D9D42 
X-CRM114-Status: GOOD (  17.95  )
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

On Wed, 15 May 2024, Mikulas Patocka wrote:
> Hi
> 
> Some NVMe devices may be formatted with extra 64 bytes of metadata per 
> sector.
> 
> Here I'm submitting for review dm-crypt patches that make it possible to 
> use per-sector metadata for authenticated encryption. With these patches, 
> dm-crypt can run directly on the top of a NVMe device, without using 
> dm-integrity. These patches increase write throughput twice, because there 
> is no write to the dm-integrity journal.
> 
> An example how to use it (so far, there is no support in the userspace 
> cryptsetup tool):
> 
> # nvme format /dev/nvme1 -n 1 -lbaf=4
> # dmsetup create cr --table '0 1048576 crypt 
> capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256 
> 01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298 
> 0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'

Thats really an amazing feature, and I think your implementation is simple 
and elegant.  Somehow reminds me of 520/528-byte sectors that big 
commercial filers use, but in a way the Linux could use.

Questions:

- I see you are using 32-bytes of AEAD data (out of 64).  Is AEAD always 
  32-bytes, or can it vary by crypto mechanism?

- What drive are you using? I am curious what your `nvme id-ns` output 
  looks like. Do you have 64 in the `ms` value?

        # nvme id-ns /dev/nvme0n1 | grep lbaf
        nlbaf   : 0
        nulbaf  : 0
        lbaf  0 : ms:0   lbads:9  rp:0 (in use)
                     ^         ^512b

--
Eric Wheeler



> 
> Please review it - I'd like to know whether detecting the presence of 
> per-sector metadata in crypt_integrity_ctr is correct whether it should be 
> done differently.
> 
> Mikulas
> 
> 
> 

