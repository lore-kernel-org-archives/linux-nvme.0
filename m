Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC12C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w35zRG0OkIERKykJ3kLK7OfAU358MYkVuEuaVMXaJrM=; b=lHRIWo8WBI8CtD98qMjwXRgVRR
	AYOAQEBEa3Dguo2+zAh2R4sfKcPS6IdTFK0ZJu/OZtqU09rGKtFMLxgGOX7zr5sPnesS24pOvx1Kq
	779VN06ak9wBNqVnjgDmha0xYbMvvGYCOGqhGDdJ0h/ExfCd40vdJh2NtLHyTByyiGA2fhRe26X8z
	xt+WGJFhb5pcgSvPTqEUhd4qn5oIo+8kyNHa40qRD6YDkkthr/JTl/sLfitzEpucY5ENF1jfDG2N9
	pDS4sOZJBy9tu0mIBEmNqRmGoVL8vIAakszdBxUBJCW55PM22LDG+uIxoLcx35cSkAe5EjO/YLRcV
	qxivAJJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWIeY-000000037GM-14ll;
	Mon, 30 Jun 2025 17:50:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWHc6-00000002yWz-2j51
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 16:44:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DFF1943FF2;
	Mon, 30 Jun 2025 16:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B614C4CEE3;
	Mon, 30 Jun 2025 16:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751301853;
	bh=w35zRG0OkIERKykJ3kLK7OfAU358MYkVuEuaVMXaJrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ye6IAhKe2WrY5D2u5d480ouBb3uIrG2P7P3w8CJoSB3ZzGAYJxlcHLmOKNEhRiSnT
	 9GoMUXmbRWvclwanj8P7EFlb8lcfoQouwFaDylZQufYoxx4hF21HwfcStkQkIEXusL
	 OymvDjIgPAPiWf3S4v1BHwhVlIrqkzJxNx8/utP4HlEnTOEMgi9DuGjNQ+s+JTTkdv
	 mYTCDVmldyIihsaAYJjuVMlhNBwRN9D4E7QUAsfLZLd0FEuHSHpVdaAdNtlDRW1o5D
	 tofkZeKQeeew3qg9iPuui5mt0qqczDEba6ugS+LopumPxpPny0ChFwgidrMGwmXuo1
	 i/L9/l8Z3qeQg==
Date: Mon, 30 Jun 2025 10:44:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, alan.adamson@oracle.com
Subject: Re: [PATCH] nvme: fix endianness of command word prints in
 nvme_log_err_passthru()
Message-ID: <aGK-28n4bhw7EVAr@kbusch-mbp>
References: <20250630162153.4040149-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162153.4040149-1-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_094414_709424_C075E44E 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 30, 2025 at 04:21:53PM +0000, John Garry wrote:
> The command word members of struct nvme_common_command are __le32 type,
> so use helper le32_to_cpu() to read them properly.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

