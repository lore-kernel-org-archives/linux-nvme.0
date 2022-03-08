Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA9E8C43217
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptzPQS+XpoqPPO8Bmja4+SZXWJB6Ws5mYlmhEBelCBI=; b=X3jLQmITCyq05okk4jBllH5Biy
	prT1kys0UFnGL2q8P96j744P+8vSk+fBV0wgG1kjgPsXOb8rLVMpZKp1GnkaeqevxyRVI+Me8kxny
	gmG7z1q4zwYr5QuW+bZoq1jzK8lQNGVJ77cz4IW5kVWlIWi8A4bmd4Jk94y5VS0mDi1Osq8BPoF8H
	akD+E20soLESt8rfBKGVIFKGlp59bzcw9s3Ue/ibiauaUwfx0C+6VAFdfYdewhW5DIPZ0ZnPLVHUA
	yaCWcp1ZnUJQ9aCw/+1ahYqqcLyvKYbcN4U4+CWaL80t+cdjBBIhslp3Bd+Ck2P+0QkuGsvwfmVdi
	poSCc3Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRft3-0064Nn-3V; Tue, 08 Mar 2022 19:52:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRfsw-0064MA-7T
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 19:52:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6FFC61768;
 Tue,  8 Mar 2022 19:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0905C340F4;
 Tue,  8 Mar 2022 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646769161;
 bh=n/AjvFrptUEVT7Q6B+5dhmXeozCmGfY5zA17v5nHqu8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GtFj9EkbK8RqqSsKTdviLzkzzyhZcKYbBK8adR3TXn2wqKproKcNGv00YaKe5Xl5B
 +aWJvRgF1i/EZBc1+jqNm1WPDD/N/X3Ztnem/u80AulWY/cUL6t5yiRUmLfmy8PBQU
 J/u8/oo5nfC99Mxir/dbJMumRAuDyNKSgy82hSkBmV9zkFaszgBd44ZSxwA8vtRrkB
 M4IGH+XMYWGGxBy8FVu7gj82Md26J8nGMn0mYMRbFso9nKJf51yTCxSXqyaqDa1Y1i
 oX11ambyoaODYIFg+2dw6BZHR0l/wJUb30S2XE7F7Rq0yAHnlSoEoSHYXX/nhOd4az
 FoTMh/JRzdNcw==
Date: Tue, 8 Mar 2022 11:52:38 -0800
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Ming Lei <minlei@redhat.com>
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_115242_329176_18EA11CA 
X-CRM114-Status: GOOD (  23.90  )
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

On Tue, Mar 08, 2022 at 05:45:20PM +0100, Maurizio Lombardi wrote:
> Hello,
> 
> I recently received a bug report complaining about disk corruptions when
> issuing a NVME_IOCTL_ADMIN_CMD / IDENTIFY ioctl() with cmd.data_len =
> 8192 bytes and the buffer address not aligned to the page size.
> 
> This is the C program that we used to reproduce the issue (tested with
> 5.17.0-rc6): http://bsdbackstore.it/misc/nvme_ioctl_512.c
> 
> simply run it by passing a path to an nvme device:
> ./nvme_ioctl_512  /dev/nvme0n1
> 
> It appears to be very unpredictable. Sometimes I hit disk corruptions
> after a few tries, sometimes it takes hours. Sometimes the ioctl()
> returns success and sometimes it fails.
> 
> We suspect that the root cause is that the nvme-host driver doesn't
> enforce the 4096 byte limit for the IDENTIFY commands as the
> nvme-target does (see the nvmet_execute_identify() -->
> nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE) code).
> So if we pass a 8192-byte buffer not aligned to the page size, it will
> need 3 pages on archs where page size is 4k and the nvme spec says
> that the data buffer may not cross more than one page boundary.
> 
> Does it make sense to you? What's your opinion on this?

You are telling the driver to prepare a 3-page PRP, so it makes a PRP
list. The device knows it's a 4k payload, though, so it thinks your PRP
list pointer is actually a pointer to the data destination. The device
is corrupting that memory, which could lead to on-disk corruption if
that memory is concurrently used for a data-out command. Observing that
type of corruption is probably not deterministic.

This was an unfortunate pitfall of nvme's PRP method: the transfer
length is implicit, so both sides need to agree on that for everything
to work. If either side is mistaken on the transfer length, then you get
corruption.

In short: don't do that. If your application misuses the ioctl to break
it, you get to keep both pieces.

