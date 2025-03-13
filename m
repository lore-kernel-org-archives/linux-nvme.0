Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA71C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cBbgyyBa850Qp01vBLPD5xwNXctix52gzE1qJrnZPKQ=; b=RJ/MMRz2WBSsgDykvVbDdqjB7L
	zzc8BDtsJSEC4uVoR15TCWW9+aT8gXrXn7VgXmU1nlUDFkiaGKInFUDXeRlTLvul5z2K0C0g4+IA8
	+64f8c76JhWWdRkHwKIBtKCefZ392zBJeHFUTutAmUDk7cpe6Eini2AYBPS1oC3wEXL/j52O9J7iy
	/ajglaNb2JqAYoaFtaLzIOMXsJ+siFz2P293os6+X04X8zaJ0ykJuTD7080qYWJB8fIoJTHsjwyP3
	vLxtKYv5bhz2DcgorPXBhfDjxfL9mHRg5y8G6rJ1mRlp0o8r/FEmwJXGh9Bsd0Qv0n/QAl05scN5v
	nanuvzmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsmEq-0000000C1YC-1EYh;
	Thu, 13 Mar 2025 17:20:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsmEo-0000000C1Xl-1q73
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 17:20:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AEE29A4781A;
	Thu, 13 Mar 2025 17:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FDBC4CEE3;
	Thu, 13 Mar 2025 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886453;
	bh=cBbgyyBa850Qp01vBLPD5xwNXctix52gzE1qJrnZPKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/jrhUYXta2sBj/ckAfoA57+L65tutUS8B7dWw6+MkN2J2TlzExjftLcpobV0uQI1
	 6x/ngk4qV2e91a8iC1f4MLB39dy94awIri8vhy9qVpDKDn9ZQqCW6pcluBDKSneyFY
	 OYAYWVISEKbREWuAwjwD65oN/7NapByGHEoPyrLf1sjGYMeXhEDe138OKvA4vNLYhY
	 SCRKq47Dlm6ZcAcJdk7twAoNdvAocOcEw+bV2N/xgrR1rm73xy0j9aF55FG7cBMd1S
	 oA9iqQNu9GqJzdsawArqbfdpdJqE26qiEyvkS/7m1yxMXDUTK5lq09aUSSuXPMwvss
	 m8/S9KgO/WrFw==
Date: Thu, 13 Mar 2025 11:20:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 01/11] nvmet: Remove duplicate uuid_copy
Message-ID: <Z9MT8iYqHZjsmp8y@kbusch-mbp.dhcp.thefacebook.com>
References: <20250313052222.178524-1-michael.christie@oracle.com>
 <20250313052222.178524-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-2-michael.christie@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250313_102054_536703_68AC971C 
X-CRM114-Status: UNSURE (   6.38  )
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

On Thu, Mar 13, 2025 at 12:18:02AM -0500, Mike Christie wrote:
> We do uuid_copy twice in nvmet_alloc_ctrl so this patch deletes one
> of the calls.

Thanks, applied patch 1 to nvme-6.15.

