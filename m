Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D05FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNxnqQ7rZG3cGJWA2o5KdVb6sUkVnJvPYlcNIa1PdPE=; b=Rmc0BOXgW8mLd434phLNTRyUYr
	JQeHNPLzudRSg36Lw+ccUI2ebuqQxLZCGjKg4jjgMPA94Kog6OJfTIyvrEhuVQZ/8b36/J3sBctn4
	Nt18UYmtrAoBeGeOGlTDsyblhLxKkth+EBezumGF7xwDFj4e2C13OgOHF7RuFY6MtffwYD6tcO7bI
	dS6jfzTlFCYrD83UW0rQFX1qg4BXT5cttE4a6HJYKDtjSOaMDCXnI6J2DTGpBvGA3HH6oXwM/ZSdA
	5+tIMCUVzmciwXwkNv3FCkN79YE1k4XEtgLjtuWitBDAbMpPLXdMftfDrkrF/lMoi6tKkkKPcIj8u
	+oLJus5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5im-00EEoP-JM; Thu, 27 Oct 2022 16:27:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5ij-00EEnz-SV
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:27:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5C7BCB826AD;
	Thu, 27 Oct 2022 16:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77CFC433C1;
	Thu, 27 Oct 2022 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666888023;
	bh=jNxnqQ7rZG3cGJWA2o5KdVb6sUkVnJvPYlcNIa1PdPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cL1KtHVOaWJC0+uScVcO9gKrwLxZm4+8Xhb3T0sjO2mwBsMdt/0jrqpJd9EHkuvPm
	 K6XoFWFWqAv6cuXL59mHWVLlRi/Qf/8D9dDR3n+nzWnurk1DvDB4JUVJjFzD292K0N
	 59Dh0iTsMywJ2MDhV4f1OnDIaCRmWGOUPYSDQ9+gnO3VxljjegftW5L+fCSN4n3rPZ
	 8PKBBnr9Axcyoh5uuzEZtckwNF9wzoJqOUaUIFDsW1JrPgbBnZ7FfK813H7i7mpUss
	 cOCg4H52/Rxu+C1e4/bwjhBwTTN4Cngk7G05SLSKLd3PSVgzQU9n4brHweTIdo7lif
	 aXDeCNOxZQBjw==
Date: Thu, 27 Oct 2022 10:26:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com,
	p.raghav@samsung.com
Subject: Re: [RFC 1/3] nvme: Return -ENOMEM when kzalloc fails
Message-ID: <Y1qxUXuqDHYi+LO+@kbusch-mbp.dhcp.thefacebook.com>
References: <20221027155724.1161670-1-j.granados@samsung.com>
 <CGME20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed@eucas1p2.samsung.com>
 <20221027155724.1161670-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027155724.1161670-2-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_092706_083119_78A400D2 
X-CRM114-Status: UNSURE (   8.92  )
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

On Thu, Oct 27, 2022 at 05:57:22PM +0200, Joel Granados wrote:
> In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
> failed. This patch corrects this behavior and return -ENOMEM
> Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

I'm pretty sure I had this returning 0 on purpose. We can proceed
without this optional structure.

