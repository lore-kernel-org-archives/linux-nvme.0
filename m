Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB51BEB7EB5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZAY9GXUfd6KhFkGYFrLa191k2VxXA1qbEeATN+njhY=; b=TY9xKKR/TYT25k4J953KjR2x5i
	1IXFEQEw1P4XRCyJndWfl6HTKbl6twi34d/m0PhHrLNum08E6pj7QlhnO8QEuWu+aDOsUGGMIUGgb
	xj1f/Uv7wLbvsTVua6kY2qnCexBSYtG76ZEHNIU3fW9hmE8/gqYPdtXto9DniVjguhE25E0AqJHvM
	k4htoH1wpWZN25C/p1/i3vGvaCBTV58vueTw+agzW1kWh7pAbGGPwCV9A7/+WJmka2q9ZucuAh/1v
	f26lP+7rmHDjAuBpchIwXKGAP4jTFTV0IjNvnAjtE3tD2azdjNuFqHXFSJDtXvsxkmKPwlW4FLCWY
	ZQoeFUjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxiEv-0000000GqOc-3YDR;
	Wed, 04 Mar 2026 09:09:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxiEt-0000000GqN7-0hzf
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 09:09:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D7E7B43AAF;
	Wed,  4 Mar 2026 09:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F17CC19423;
	Wed,  4 Mar 2026 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615393;
	bh=fZAY9GXUfd6KhFkGYFrLa191k2VxXA1qbEeATN+njhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhLLzj7jVWtpWhVCxNAuQM4J+G0DYsFPfwsOb5VB1AGy15FE5a/ZTlEb8iZ9fNPk8
	 DLiBcbqSxEVIgwF2vc2yZOUkZXFDOdCWkanO/lvecJTi45J1nxpNECXEhb4Q172l8j
	 ETTpfdn63wwu/vXYJdLjeFEtgRyLTo0C351HaER0=
Date: Wed, 4 Mar 2026 10:09:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaskaran Singh <jsingh@cloudlinux.com>
Cc: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work
 cancel_work_sync()
Message-ID: <2026030410-unpaid-operation-bddc@gregkh>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
 <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_010955_225043_4F6BEC52 
X-CRM114-Status: UNSURE (   6.35  )
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

On Tue, Mar 03, 2026 at 11:16:34AM +0530, Jaskaran Singh wrote:
> Gentle ping.

It's been just over 1 week, please relax, we are staring down loads of
submissions at the moment...

