Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA07C48BEB
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Feb 2024 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdNiqR94XdKRLVz+UnIF0xVb0mc+BTJ4sVoFD9fzPTE=; b=Qc1daPj47g5Vys5gsHEwzCMYfu
	y+Ojpo1sL3uNu4Uf+oHS6dVzSEP5e0edCAWQrEjUGepupeOXWuEKOFrv5ZfGbF2c2AY0voCT/kNHy
	TjBhYpWfn9XyV3W10QINnFkt+tMjo4brw4brtq0ZX2kaguJocUmX4wI4PdCEo4I4aH828IG/YdhI0
	0ljO4VdID5Bc6kk4usKhT74hCCVoBGLpAE1Lr6HXruQvuLK82lXw6AlT62Vd0MeuEcZVx6eoMffcm
	b4zxf5di9mnmka4YcOOP1NL/JYL1br8ZlhU0iBhjzAMVRIU6SaUXFXAlgza1h4kSJd49rV787x61H
	B1neCU9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3EC-00000003mEZ-200l;
	Thu, 22 Feb 2024 07:10:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3E5-00000003mE0-18m1
	for linux-nvme@lists.infradead.org;
	Thu, 22 Feb 2024 07:10:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC46761729;
	Thu, 22 Feb 2024 07:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB6DC433F1;
	Thu, 22 Feb 2024 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708585836;
	bh=ehJxGfsAI6x77Kpzx66U6ws6VdAWkR1Sdx+/AOqqlzs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LThS3IwNuaVT8l/FEr3X0WlskZC1hHuKXvi9IQpXxZ2wRT0FZv0KcZNIFW+HFQHiB
	 43Xw9oROO1cIISuPEE5dFDTRjPfdEUUsymyQSDA4jY2uZVdoO6AQMsnsXGsl35SVVv
	 bgiRFv4LKzXBVkaJiNZkkXi4Je0nDbacTUkV1vsGt+xqkGHk6hh9PUYqaCu3CFQ9cA
	 FNBBU1p6VjLUYQi8ZIllA4tRvyX7f/U6xAG0Gs0C3HSHalLej1jFjixbH9UBdtR1Dj
	 n6K3L2xtYG/wqb+UCwjveSGfp52IN+ksSXBonKh3wEMtTXycJoRzW5txN5Hans36Ju
	 T7WdWrFSBxTvQ==
Message-ID: <53d746b8-a24e-45ac-ab70-c0a0cae6f4eb@kernel.org>
Date: Thu, 22 Feb 2024 16:10:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Adding NVMeVirt to Kernel mainline
Content-Language: en-US
To: Jaehoon Shim <jmattshim@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-nvme@lists.infradead.org
References: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CABj8AyhLjBkQUhp4CFY+xV4_GwDAyzU251St+BMoYUKCjj7M9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_231037_393572_F71461A7 
X-CRM114-Status: GOOD (  14.70  )
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

On 2/22/24 10:38, Jaehoon Shim wrote:
> Hi all,
> 
> My research group has recently introduced NVMeVirt, a software-defined
> virtual NVMe device implemented as a Linux kernel module. Upon
> loading, NVMeVirt emulates an NVMe device that is recognized by the
> host as a native PCIe device.
> - https://github.com/snu-csl/nvmevirt
> - https://www.usenix.org/system/files/fast23-kim.pdf
> 
> Advantages of NVMeVirt are:
> - Deployable in real environments (not virtual)
> - PCI peer-to-peer DMA support
> - Low-latency device support
> - Multiple namespace support (each namespace can support different command sets)
> - Multiple device support
> - Various command set support (currently supporting ZNS and KV)
> - Accurate performance emulation
> 
> What if we can simplify NVMeVirt and add it to the Kernel mainline
> just like the scsi_debug in the SCSI driver? This would offer an
> accessible tool for developers, especially when NVMe devices with
> specific spec are unavailable, to develop and debug the NVMe driver
> functionalities.

Qemu emulates nvme devices fairly well already.

What is the backing store for you kernel module nvme emulation ? Memory only ?
files or block device ? If it is the latter, how can you do "Accurate
performance emulation". And what does "Accurate performance emulation" mean
anyway ? Different NVMe drives from the same or different vendors have different
performance characteristics. So what exactly are you emulating here ?

> 
> Best regards,
> Jaehoon
> 

-- 
Damien Le Moal
Western Digital Research


