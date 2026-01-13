Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F75FD30CC2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 21:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNAPAiGZfGs2J+k3DDfhzmYbuE875cEmT0iHXRnEOkM=; b=0g1idOKN5UD2pb9xesOIbARA/5
	0U/ugWQww+Bw1KbcS0cGZcMSuaR8MjNQasVz6jAveJhQp+0EVHZgVMorWtXKh6H9mp0gx6M+Fzj10
	yzak3hGZpoNzcZTzMT8nSlrbi26W9mx1sM11wYAJEgvkHC7mYFpMOTEOD7kxAu7AIVWM7V3HsZT8b
	dLm5e+Ur+na0TycJ+u/b5+mQy5fG955dC8VmgrCG2QkMXViqID2W7lBf3G4/SEP1LS3fDbJKn49QK
	pNbamI/1xft65EnpNVI2932wDCSmrw/cFKNmRZIqlWqHTMZbiLbWicU8D3ORDJ34YSfSSz3SsjywM
	FWOx2jAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfmI4-00000007mQW-0INK;
	Tue, 13 Jan 2026 21:51:04 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfmI3-00000007mQO-0AG4
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 21:51:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 296CB60018;
	Tue, 13 Jan 2026 21:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A72C116C6;
	Tue, 13 Jan 2026 21:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341060;
	bh=pNAPAiGZfGs2J+k3DDfhzmYbuE875cEmT0iHXRnEOkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMJNy5lKhNS+/6sVCo2acVtwOZmcgQp2gPZoddVeb1lMyzZQQ0HDlQRMqkRzen+dT
	 2etQlrAOv38k9YX90pfVqwWsSd2VEGjbe/FlfKtCfGrV6uhipu8w9bacXRWKDCOUfO
	 9y+YLCgIccu3Uncghd4FCE9eDqSv3shfgGNxrZgKzskvmzQ1Vm9249JE0MYQ8/HhhE
	 iSnIdFW8Y1+Ktx0gpNhVdq6LKMiq8G1MSk1ZHDCJlTwvdrHIxWIo0FJlB1cHVIPlxH
	 A62b1zOLqzd/oFDe4g8lSVObVwOgFbz1PEEtxiPJ1h9v5IZmzsreYAwKcHuiuqr/Nd
	 RVuafU+h0KD3A==
Date: Tue, 13 Jan 2026 14:50:58 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH] nvmet: do not copy beyond sybsysnqn string length
Message-ID: <aWa-Qnrggz2IbZ14@kbusch-mbp>
References: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
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

On Sun, Dec 21, 2025 at 04:37:14PM +0900, Shin'ichiro Kawasaki wrote:
> Commit edd17206e363 ("nvmet: remove redundant subsysnqn field from
> ctrl") replaced ctrl->subsysnqn with ctrl->subsys->subsysnqn. This
> change works as expected because both point to strings with the same
> data. However, their memory allocation lengths differ. ctrl->subsysnqn
> has the fixed size defined as NVMF_NQN_FILED_LEN, while
> ctrl->subsys->subsysnqn has variable length determined by kstrndup().
> Due to this difference, KASAN slab-out-of-bounds occurs at memcpy() in
> nvmet_passthru_override_id_ctrl() after the commit. The failure can be
> recreated by running the blktests test case nvme/033. To prevent such
> failures, replace memcpy() with strscpy(), which copies only the string
> length and avoids overruns.

Thanks, applied to nvme-6.19.

