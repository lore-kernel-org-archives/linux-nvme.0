Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B15ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fq7Hbr7SVsAkwlB8p7RXUUzk64CLPge+dDhLIyEvg0Q=; b=AbKuECIGoHfUYN1+byVnSFkLZe
	C7DhBIRXcTKLNLxxH4ngJCtepGCwn/CPpZ2aG764RygQfw/Vu6qES+u+hm8oexE9nkQ0RVcqRHSh3
	9p8eXCL1XaFjLL1NCdpXPEal6Ql9Br0DFQlgrKZAvETG/cnksnNPG3A0yBqCanYDRY2UHxq8Xpw3b
	HeQPTLRy3VABHENgUJKB4jFNrFeUHEENnRFMOZSr32arg6TYRej260NaqtLdYluCrHpeGQBnELkAT
	g0bBwHg3Z4dD20cCrpFu7WmCQsEKiLclrA0V1rmrxh0TW5BS6ipRYU8ICyDZgjW7r9iw/kne4m1il
	8NDUYxRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWhKB-000Vyr-T7; Fri, 09 Sep 2022 16:57:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWhK9-000VyF-Up
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 16:57:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AC8B561FB0;
	Fri,  9 Sep 2022 16:57:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FE3C433C1;
	Fri,  9 Sep 2022 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662742668;
	bh=bbFYwkLLoUMZOOVbfkzv45rrSoUFxFojJLHItk4wNTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDNLW33WQsDjmhrd4BNKYC4kF93gijOMoAQ+ZHpV0PNEsk/AOjHGYIw32alXmH1Wk
	 QneYXCoj78UTWHYvNAfGMHG2qf0JR2DezhoFNt060tMpEVjh8kchusqZi5gfbBX+YM
	 C73wV5OAnS+33zNUMILHL3yQc5UtF02iR4J7+g9/r5mkSw8UhRN2YWIgcVjxIiUS7l
	 tyG41bO6VzTogyjYMZa5BojD61OuRosVmqwu16u5wrzOq8yRP2f9T8oWIWmVJpLPiu
	 90IzSLR8RPFS1sqUz85oRSEA4qCqM89U0jhkOwjkTBWdX7T1oBsR6JKy4Fn5z2rm5y
	 NHFFlmCxi9IOg==
Date: Fri, 9 Sep 2022 10:57:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [RFC 1/2] nvme: add whitelisting infrastructure
Message-ID: <YxtwiDE0amT5DuNt@kbusch-mbp.dhcp.thefacebook.com>
References: <20220909163307.30150-1-joshi.k@samsung.com>
 <CGME20220909164318epcas5p15d022bfc15bb4f22dbe4fb424576243d@epcas5p1.samsung.com>
 <20220909163307.30150-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909163307.30150-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_095750_075271_5C2F5BC6 
X-CRM114-Status: UNSURE (   9.48  )
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

On Fri, Sep 09, 2022 at 10:03:06PM +0530, Kanchan Joshi wrote:
> +bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
> +{
> +	/* allowed few read-only commands post the mode check */
> +	switch (opcode) {
> +	case nvme_admin_identify:
> +	case nvme_admin_get_log_page:
> +	case nvme_admin_get_features:
> +		return (mode & FMODE_READ);

Some log pages have read side effects, like Namespace Changed List or anything
latched to RAE. That opcode seems a little more dangerous than the others in
the whitelist.

