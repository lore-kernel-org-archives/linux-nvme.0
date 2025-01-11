Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCB7E7719A
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjQkZi4zps2qO659Nymq4eDgoTAWt/QYOpExvse4F/A=; b=B6Jy8Mba4eI0I13ipX9ahP+W+7
	MG36tpLxelJHKyWTMYaV373fJFBPgm70NrThLuVDyZWus1M+50FT3ElG+fl9se9zhDAWBqPf4oyys
	/xYRlRtQCugqGJJVLZP1Lf94an2mW2BTHftHvcEKbNjA6EDYIjoV5dU8FA0FKdKmP5lQxY7Gp1ZWW
	TKnmZS3YkISktNa1ig2GQI0iRmyrtw4+cyQrIBB9uuktnrjjpNdsF5w99eAUObY7/1/9rc4ILUJ8+
	7CS0mgLlDbr+TCu6yEK/BBRCJlLmA+nt10cQQHRoBOP5pxaP7ZwWUO1w58xi6sSNGTiwS6Al6h/nj
	xCxmjTxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSc4-000000006XR-0d10;
	Sat, 11 Jan 2025 03:56:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSc2-000000006Wz-0F6F
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 03:56:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0D1A35C547F;
	Sat, 11 Jan 2025 03:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F18C4CED2;
	Sat, 11 Jan 2025 03:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736567796;
	bh=soyVSdFkoTh24s5Q7X4C0TFJ3U/RHATlqzWvjQRJ6Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpEktYnlHj8FtQzDQUNnpyICqBbfDLdWoYpNlTYw8N8OI++0yyOo5N9XPvcnTxlgM
	 95o9/9r6+uTIjuMca1g8ByosFs0Hd4ADbnGQuStobU12cKf/ny8AlzhKS/3Lo+jyLF
	 eAsYpWoEmWo4x/qs8teeQu/4GuXCbxi67ybfNJ6vpbWRITCdjbinKoOZUlBvP7iJvA
	 i42cRMo2lpQYvKUPgKV/IkDaBOsqN7+e3WDOtjDPUb2+ZIJ3rgQVzig5HydjtckBJU
	 hHrDz7v6B5z6ISX/HalkLASn+dReeRN++vfWmrfcJ8hWEAt3Y43wxkCFjMqI0asarR
	 fIFmCE071HFnA==
Date: Fri, 10 Jan 2025 20:56:34 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add error path for xa_store in nvme_init_effects
Message-ID: <Z4Hr8lLFENnedjzx@kbusch-mbp>
References: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_195638_142004_081668F5 
X-CRM114-Status: GOOD (  10.70  )
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

On Mon, Dec 16, 2024 at 04:27:20PM +0100, Keisuke Nishimura wrote:
> The xa_store() may fail due to memory allocation failure because there
> is no guarantee that the index NVME_CSI_NVM is already used. This fix
> introduces a new function to handle the error path.
> 
> Fixes: cc115cbe12d9 ("nvme: always initialize known command effects")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>

Queued up in nvme-6.14, thanks.

