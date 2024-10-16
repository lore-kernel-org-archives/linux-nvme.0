Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3225D2A538
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HzzmijPoH2mtXPKps8Y0il4uE+cACVfKq2wS0Ezsuf0=; b=z8K7xQb4BDkD3n+gNbOo3rH98r
	OfOqYf/KC2eWy/01ColN2Sa3P98U6E+x5+iK4CGTzulPSPg/DDNfz9/+db6dCUVlSH8Zno+SUdVtn
	sF9k5mPZRlLhjBGd6zsgzItj6vWxOiLmcxa8kRMVRYjoUbZo+BWLCIRJBB22uvilI+0DLSZoZF6Gf
	8pr39lPJ+yEcFeX7vOf8TQxylwUUVmBc7KitJwiKKfoXlx8cWxVyUzuYhPkvlouNrcYvwixll/tdo
	80zXnTgqvPRBhCxE6lLLqXYnjYdfe98IKDRTsXOSpUqBl5xn3r3x0/v94uSL2DuTOooKKgeLctvxD
	kA5H3iFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t18NY-0000000CcxS-3c4M;
	Wed, 16 Oct 2024 18:04:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t18NW-0000000Ccwt-0qO1
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 18:04:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3C82F5C0578;
	Wed, 16 Oct 2024 18:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E3AC4CEC5;
	Wed, 16 Oct 2024 18:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729101849;
	bh=HzzmijPoH2mtXPKps8Y0il4uE+cACVfKq2wS0Ezsuf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZ1dy0JgHxNeobOvzLSy5ftVhhY1QSE3SF3ksFod3MtCVn2w3jJzGNtgWDjYWUP5L
	 LvZBXl7bnuTnvtj7JgjPfD2ftk1YDHfC4QINDHlz+TLaC4tFJEBWbTIVvbWtDQz1jK
	 7bxdu4l9KFVnMpNVOVhSHW6M7tTWmdVCq0G0kKhNiCGdu/3ZElIS38qMslcr0extm8
	 hP/tHOAO5HoFPYYE+anpFHY79BTyBqQCcUle5fVGiJKHsG5bxMvRzrKsOhMEg+ltgx
	 QT6ZFR6nzZgEkfh0Qvz95GV6x7+0iooI3XkebrslYZAgVrEvFppGgCIlF/g2XWnMG5
	 QYOdwszwvc0WA==
Date: Wed, 16 Oct 2024 12:04:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com
Subject: Re: [PATCH v4 02/11] block: copy back bounce buffer to user-space
 correctly in case of split
Message-ID: <ZxAAFnC_Y6qpU-UK@kbusch-mbp.dhcp.thefacebook.com>
References: <20241016112912.63542-1-anuj20.g@samsung.com>
 <CGME20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357@epcas5p3.samsung.com>
 <20241016112912.63542-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-3-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_110410_303346_F1F3BD05 
X-CRM114-Status: UNSURE (   6.68  )
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

On Wed, Oct 16, 2024 at 04:59:03PM +0530, Anuj Gupta wrote:
> Copy back the bounce buffer to user-space in entirety when the parent
> bio completes.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

