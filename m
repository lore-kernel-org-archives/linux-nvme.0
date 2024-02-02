Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F77C48286
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 01:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PuNdMCz/3u0LmX1O+oprpf21ZLS3VGZDHlfTCGzuEOM=; b=dyQbpXLU4ujvUfdZM+1ysO41kH
	ippBC/EMktewGijWQ6RswnQF7dR0m0hY89caUS1Lf9A+BCUgYNBpY2lz3XX6hx68NoHH+J6ObyTCf
	DdvOuRgnrxOaBv51bI+en81c5eLRi8VOoo9GF0YFz8FegdAr80LQbnGvLfWmD15Xw2ZzQ/maZElR4
	zTvRyFDooho0A4YbLREvm53NnN0UwX1/n+S4R8Qi8+uL08ZdHwBSC5QatB4T94SZiEaHPA+EMxBeY
	bfRPm9oDiWq3dlUs2hJ0l0/a5sktHzEHcvgTdIZmCvJH8I9l6Rg+sicOcI4nZjuNzIbZwSY2wEjxm
	TIh6W1FQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVifb-00000009qFP-1PLp;
	Fri, 02 Feb 2024 01:48:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVifY-00000009qEz-1R2J
	for linux-nvme@lists.infradead.org;
	Fri, 02 Feb 2024 01:48:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3852F6226A;
	Fri,  2 Feb 2024 01:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC85C433F1;
	Fri,  2 Feb 2024 01:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706838518;
	bh=84Yxq+mWiZiusLUfa/Yw2cNdfgp9qzzsrIy28zW4cHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZxCamIEH/SjwSKbOuexnhPyPeB60iRmPK2lqXOfLJF+qA+7dKx58JYBovFg7yxAs
	 p/XfFJLzg5WkHBzWrRVfROrCnheiMo121HvMaX/QweNs+ZIpMApJMA+VSgiLzDFeAc
	 /kOBZvvdrWnH+VPQEN43EPHU6xhIqYAdmcL+kbu2SzFwbv9p//bGFO6iPWJeA2YuBI
	 1W6OkwUHPh/G38uzR3RAgp0RRnxN5Jg34I4xuLq/UXRh2CL0ctXS/ZSFfTX25goBpX
	 kRBa6zR7rISyf10gVSfye1bFa7J14N0ItsyGd7gaLQYtAo5jwbDQgJJ4GkCIOWtR8U
	 HhqLC1I0CC+tg==
Date: Thu, 1 Feb 2024 18:48:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: dwagner@suse.de, hch@lst.de, Niklas.Cassel@wdc.com,
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-host: fix the updating of the firmware version
Message-ID: <ZbxJ8xAbCVNAldd1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240118114854.672748-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118114854.672748-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240201_174840_442201_0013084F 
X-CRM114-Status: GOOD (  20.57  )
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

On Thu, Jan 18, 2024 at 12:48:54PM +0100, Maurizio Lombardi wrote:
> The original code didn't update the firmware version if the
> "next slot" of the AFI register isn't zero or if the
> "current slot" field is zero; in those cases it assumed
> that a reset was needed.
> 
> However, the NVMe specification doesn't exclude the possibility that
> the "next slot" value is equal to the "current slot" value,
> meaning that the same firmware slot will be activated after performing
> a controller level reset; in this case a reset is clearly not
> necessary and we can safely update the firmware version.
> 
> Modify the code so the kernel will report that a Controller Level Reset
> is needed only in the following cases:
> 
> 1) If the "current slot" field is zero. This is invalid and means that
>    something is wrong, a reset is needed.
> 
> or
> 
> 2) if the "next slot" field isn't zero AND it's not equal to the
>    "current slot" value. This means that at the next reset a different
>    firmware slot will be activated.
> 
> Fixes: 983a338b96c8 ("nvme: update firmware version after commit")
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>

Sorry I missed this one for this weeks pull request. It's now applied
for nvme-6.8 as the first commit for the next round.

