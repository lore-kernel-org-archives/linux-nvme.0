Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF36C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 16:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8A3ceW2Z9e+9Zo4QCepYi7WUw+5vlYDTDEmcLB29Wg8=; b=OPVqqXG6l680b9u3v/VvDcLvAn
	WdA0WSrGMsyvsgKhpReaIEnNOQF08Sqhg1SxwAxcxxveL+kWQvvnx0U1nqwWgKC9oCaORNiTfi3IX
	QdYCLbv7s3KgIR0Us2WSyugIYjOmVuLIdBUVN51xVg4hteWK8uweX59iiB15Dif80ob0yQRmBb1ow
	/NMXr0riLCzWsJ/uoFxsTm9JoST6X/zo0dcTieOsg3yrB1B6UB05ZlJkypzu/BYoNNWTV/eIRP+Ki
	1pdmX2pPQV1SHixU2KdfNKc2sOt0KNJM6MzX7ViGK1FqY63BOf1my+3olKQ7LTf5TjjYVIy43yVgA
	7TxPO0wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97ee-00BG6Y-OZ; Wed, 06 Jul 2022 16:13:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o97eb-00BG3Y-Ef
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 16:13:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 71CB2B81D90;
	Wed,  6 Jul 2022 16:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4539C3411C;
	Wed,  6 Jul 2022 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657124006;
	bh=LA1VOdK5ORMoU+ewAB2GaJidmodmb2eFm76yDvl9Yo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W31t8Uh5Qnw6yELg57p4gOOOxvDnB0kHkcoTzmetYEh7N0irUK2SErFHh0QgM6RoZ
	 jnmwmDT4YuuBtyd1qMluR0dkX2VzqErJgrgJ7SUNuqiMihrkbDQ5ZVIIW5hd1KVxeA
	 snOohjfx6i5tQMOnUDutgcFi8zUpe9rHaXWqkqnEz8V8paX4zneI3ue0dafdsrEkaT
	 4H0cPByYmx95x/eJvEoBdz4V/mwkS1IKzcJa2t9sQao2YY4TUgLLD7sl9ADeYFpfNg
	 xroPQecRzIK8PvexI67SBvSi3ra+NBCa1lfkW1N12qvHSULQQ7ijuBvuO0rjdooS8H
	 GV7o0cu9Ws3EQ==
Date: Wed, 6 Jul 2022 10:13:22 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix nvme_setup_command metadata trace event for
 cdw10
Message-ID: <YsW0orMaDFfrHbx+@kbusch-mbp.dhcp.thefacebook.com>
References: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1657095398-114310-1-git-send-email-john.garry@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_091329_720288_C95411BD 
X-CRM114-Status: GOOD (  15.58  )
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

On Wed, Jul 06, 2022 at 04:16:38PM +0800, John Garry wrote:
> For x86_64 allmodconfig I get this warning:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘perf_trace_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
> ./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
>     __read_overflow2_field(q_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘trace_event_raw_event_nvme_setup_cmd’ at drivers/nvme/host/./trace.h:47:1:
> ./include/linux/fortify-string.h:352:4: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror]
>     __read_overflow2_field(q_size_field, size);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> cdw10 metadata is 24 bytes, and we try to copy size of cdw10 metadata from
> nvme_command.common.cdw10 into that cdw10 metadata, but
> nvme_command.common.cdw10 is only 4 bytes in size.
> 
> Fix by making the trace metadata size as 4 bytes.
> 
> I find that this warning started first appearing from commit f68f2ff91512
> ("fortify: Detect struct member overflows in memcpy() at compile-time").

Did you test what the trace looks like afte this? We're losing valuable trace
data here. The field is supposed to get CDW's 10 - 15, so that's 24 bytes. I
don't know why it cares that the address of the field being read is only 4
bytes; we want everything that comes after it too.

