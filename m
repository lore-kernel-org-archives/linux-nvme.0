Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E6CC19F32
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4i0GoYGir/9v+8oUXhoL089EGgJ8oe69PF12ReJouY=; b=VAeXEsUT+8tDLGWWv3vhFX7V3G
	1Fna1mbBQTzZuf6xTKchzS2BlsRrlcZwbf663qbLPpmwwFEVTIAVOCnpcM9ZMD+3aFXj+Pt34iBcK
	LNIP8+aUIV5u1/SBY+vqi9KwGMzdFFsqkrJ/hWvnOfvMrut4BPkLoXrgRH6oXimnZvNaNRqofguU/
	AvEwSi6eJ+DlyQFT1U6ZNU8WKe+82iSG6LlSEM9VZaK3zDexRLptkx3Txd77rTB9/sXqcQWRgDLZH
	fKCKphdD7v23bcN/wV33e1YTp8Css6limxiPYaF3pS5rtgdFAOFD4TbaoOD3JNHjCzTgXuoMt7rmU
	zCVrSlxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqSUq-0000000DTJF-0FeT;
	Fri, 07 Mar 2025 07:51:52 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqSUn-0000000DTIp-2N1V
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 07:51:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1993CA4554B;
	Fri,  7 Mar 2025 07:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CDEC4CED1;
	Fri,  7 Mar 2025 07:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741333908;
	bh=F4i0GoYGir/9v+8oUXhoL089EGgJ8oe69PF12ReJouY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=he2CqXxxR59UAosj9afHZ3nolMw9a64/Zp2ka+qPjetjig80Um1x52nhRNs6nb4kl
	 /626mIS2lebzdjHFWznHlgpbUnospoo9bfGE1UdmSFqq0tGS8JBZg56fZcZq1IZr2J
	 qeIMZpjLNS2xpu3eDaQB2iCWFN9/EgF2NAOgUyX1gZq4MdiWVbFj3AocY3OWKOr6Fi
	 93OZHLEzivxYHiqs2pO1WGU2GTxUpb2BYmzlSHoVywAhN4GyFvyhpy3m6bFMFjaHEu
	 gjgGNlJxhsD/KD692kjxp1ougMVIvY9xkYA9usFwNqMoDOzxr2+zx/za2J8ik+Oly7
	 KWxG6GZrD0Hww==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>,  "Christoph Hellwig" <hch@lst.de>,
  "Sagi Grimberg" <sagi@grimberg.me>,  <linux-nvme@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] nvme: fio workload hangs on 16m random read
In-Reply-To: <Z8oKvwPd4UBY1awm@kbusch-mbp> (Keith Busch's message of "Thu, 06
	Mar 2025 13:51:11 -0700")
References: <87a59x6g5u.fsf@kernel.org>
	<6xoneGEavSMtUAvjbGdIem8Ul_-SpUQR6-PIpxUTiVpN2nyo_pMM7ytxJJ0gejZpCZGvXeAN3MfI0TwfcP3SbA==@protonmail.internalid>
	<Z8oKvwPd4UBY1awm@kbusch-mbp>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 08:51:35 +0100
Message-ID: <87r0395ldk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_235149_688822_CF31E99B 
X-CRM114-Status: GOOD (  11.28  )
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

"Keith Busch" <kbusch@kernel.org> writes:

> On Thu, Mar 06, 2025 at 09:46:37PM +0100, Andreas Hindborg wrote:
>> Hi All,
>>
>> My CI system has found an issue for the following fio workload:
>>
>> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme-core.ko
>> root@debian:~# insmod /mnt/v6.14-rc5-build/drivers/nvme/host/nvme.ko poll_queues=1
>>
>> "fio" "--group_reporting" "--name=default" "--filename=/dev/nvme0n1"
>> "--readwrite=randread" "--blocksize=16777216" "--direct=1" "--numjobs=1"
>> "--ioengine=io_uring" "--iodepth=1" "--hipri=1" "--time_based=1"
>> "--runtime=3000"
>>
>> fio will hang, some times immediately, some times after a few minutes.
>>
>> I observed this on v6.14-rc1 and v6.14-rc5. It is not present in v6.13.
>>
>> Can any of you reproduce this? I was able to reproduce this on real
>> hardware and in qemu.
>
> Could you try adding this patch to your kernel?
>
> https://lore.kernel.org/io-uring/92b0a330-4782-45e9-8de7-3b90a94208c2@kernel.dk/

Thanks Keith, at first glance that seems to solve the issue. Will
restart my CI with this applied.


Best regards,
Andreas Hindborg



