Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15ECA0FFD
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2024 14:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fHNiualElTZbkW62YORDgoqg/gftXC6dzu81r47cno=; b=eZ6NTAW43s3zjg4D9VBansf6pK
	NzytfUyiXyzpTnuNYer3iGq3oGPz02ObOUgcNJduWDBOPb5E/56GZJXQAJfsp5p9OLCzoiZOF7wBP
	9Jwwj1/94Tvcy+sCLWV8cXT1Z76+19OfA0706EtnVm9/VZCW3lnxIMjzd2xSA7s1RLRkoM8njHSmC
	B3J59biO9cu9+oiBXtpo+FdPXPeGFrjRjRX/u67M6bPR8sxouSk5XMWskwnfK70ZZXGnV+02tJFtJ
	qxRjmV1JLAJ6NzIHuIYIF/VaeZqRGu4cqxhTi2siqrn6+y+l0X/VFTWeOWZwZbfghLk1KmAuL0BVq
	mfLz+7MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2jg-00000006dPT-1WNP;
	Fri, 30 Aug 2024 14:36:24 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk2jd-00000006dO1-1MGd
	for linux-nvme@lists.infradead.org;
	Fri, 30 Aug 2024 14:36:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id A4DEAAE2CD6;
	Fri, 30 Aug 2024 14:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B766C4CEC5;
	Fri, 30 Aug 2024 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725028578;
	bh=/fHNiualElTZbkW62YORDgoqg/gftXC6dzu81r47cno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+LPSHhDM+s0phVpjVJhzjZ2HxbljrPDPz6R/xO7TwyBOWOEQ49kLWXw0xtU1Fdmi
	 mjzjjlYPTBv1HZH6TQwRq+PHyVyNNoc2n91k70IiuthPBZQHPI6D1nbMWdqkt3uAn8
	 C9VeXX+kMnWncdhD56fx0lmu9bavucqIOLE0H566hTGiAteqQR+TsoxAvF7OvDwedZ
	 pQMfdONro3zA4dQ2PCtlGw/wZ9t8wy0XBW8Mw8exvBjvfUeQVYxt9JnxR5dM9XO/CQ
	 DVIvuMteMKgUfthe7/l5HdzpzB+OrpwCQARg88ajmnzbKsh7l3P0sqTkB5Z41W7216
	 +Z5B3twORDC9A==
Date: Fri, 30 Aug 2024 08:36:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, kbusch@meta.com
Subject: Re: [PATCH V2] nvmet: Identify-Active Namespace ID List command
 should reject invalid nsid
Message-ID: <ZtHY4G9Cyqej_zfr@kbusch-mbp>
References: <20240829095214.48915-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829095214.48915-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_073621_548445_0A148775 
X-CRM114-Status: UNSURE (   7.29  )
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

On Thu, Aug 29, 2024 at 11:52:14AM +0200, Maurizio Lombardi wrote:
> nsid values of 0xFFFFFFFE and 0XFFFFFFFF should be rejected with
> a status code of "Invalid Namespace or Format".
> See NVMe Base Specification, Active Namespace ID list (CNS 02h).

Thanks, applied to nvme-6.11.

