Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A3CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQMf8+8GyQVTXo3xXbPfc1g+fRfcqxRLy6DfrK9d7iI=; b=Ch5h6gx8oDEqVLplbPFNwQh7o3
	0iVNpuXTZc9UjnY6Bt5BhZA1tgtPf4fm0WnqjZLVweUg4snP7wZYRhGDwr90Zrlva04dyqj7t7+q3
	gRwKexQxlQe4l7Oq6kV2qb50rLGhTCXX/3nNlp1wr/4nBSD/Tlg3EYY6dCDS/KiAM9mKyCAmEI1Et
	66qfJkj5gyh1Jus2hXgAod4eGtU3UnyRaDGe1K0ktJgx42/ssbDfEX79Pv8zIf9DBDv2S4QUp20+W
	C6LJznn7KXFilbPH4Om4KNRiH+Yiyf7Az251gCv92qdciaugMsIoaAe/6WXxnFjrdvOGDc2jSIJuZ
	r+yjntPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMYtJ-00Ay5F-8s; Tue, 22 Feb 2022 17:23:57 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYjr-00Au5G-E7
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:14:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 9757ACE13B3;
 Tue, 22 Feb 2022 17:14:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DEC340E8;
 Tue, 22 Feb 2022 17:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645550048;
 bh=pOnp3BaYtRbX0M0xYcqxRNX6l8nMGv0iXHu57bH+yus=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BJCfR5l4U/FM0e0GUHw5+t3G1EQOOCK+jxx4D7bDsxLYFdKHsH7mI8veiIlnck3/s
 DDRd3DoIk2n0E/qkAJWdER/tKtDzmhWnWzo/JQwW723Uq7vqKNeS9xUsFwpLRS9vGR
 Tgp8/Jdn0tLsbYmM84qPvrdS0T6+rrUFp/GIONHYNWdh923rhdqAflrt++XDnl0ssn
 S16KxCsO7vqILLPUHtgQdd+ruqKQWCTSRvCpIC/vijupUxoJrz1+M9UsOaArLIuiIx
 5VRyriMgMJViyy3eXiqPCmXfxfZqcKIo9UvZWuayz6qQOJ02Drg6CortH5VNv4N/IO
 cd/SWFA1Tmypw==
Date: Tue, 22 Feb 2022 09:14:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCHv3 10/10] x86/crypto: add pclmul acceleration for crc64
Message-ID: <20220222171405.GA1782521@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-11-kbusch@kernel.org>
 <a7e806ed3c074534a24b74f827bcc914@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e806ed3c074534a24b74f827bcc914@AcuMS.aculab.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_091411_669286_02C18425 
X-CRM114-Status: GOOD (  19.47  )
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

On Tue, Feb 22, 2022 at 05:02:16PM +0000, David Laight wrote:
> From: Keith Busch
> > Sent: 22 February 2022 16:32
> > 
> > The crc64 table lookup method is inefficient, using a significant number
> > of CPU cycles in the block stack per IO. If available on x86, use a
> > PCLMULQDQ implementation to accelerate the calculation.
> > 
> > The assembly from this patch was mostly generated by gcc from a C
> > program using library functions provided by x86 intrinsics, and measures
> > ~20x faster than the table lookup.
> 
> I think I'd like to see the C code and compiler options used to
> generate the assembler as comments in the committed source file.
> Either that or reasonable comments in the assembler.

The C code, compiled as "gcc -O3 -msse4 -mpclmul -S", was adapted from
this found on the internet:

  https://github.com/rawrunprotected/crc/blob/master/crc64.c

I just ported it to linux, changed the poly parameters and removed the
unnecessary stuff. 
 
I'm okay with dropping this patch from the series for now since I don't
think I'm qualified to write it. :) I just needed something to test the
crytpo module registration.

