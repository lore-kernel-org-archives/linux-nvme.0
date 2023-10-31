Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A08C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Oct 2023 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQUwjup3tSnT/iwRY8kc84sxLDvntlu9nwX5o4zTBqo=; b=DSFKfllpjHESt3y3k/sIhavoa6
	7XxuxDDJYt3URkDOkSoOfWGPCiOg2GUwrlLEhmN7XI3EZyHENn7ImodemB0jg2HOAls0lv9rUGbbA
	WVxDtjvEMxyedEkCbpOc6rg2EcfX/EVncsaHzjn8YZwiMGfJMt3vv6/TjjGWdiLD/veQMN4o8TcYt
	aYM0P0CUwilAz0c+ACVCyPKMpBR+sjsiL9c4BZ63cpd2rGopiEIxQ8i1vA97ybsR8hkU7gJeBZrSk
	zhkoFAXCf9hICfavDSC6MbSne33BQ3KPczJBU4rayfu7iII10tmqHvmKpBqesh7XSljyqxwgnuP4o
	wHTO8Fow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxrIc-005a37-21;
	Tue, 31 Oct 2023 16:09:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxrIa-005a2W-2r
	for linux-nvme@lists.infradead.org;
	Tue, 31 Oct 2023 16:09:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 8799BB810DF;
	Tue, 31 Oct 2023 16:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9BBC433C7;
	Tue, 31 Oct 2023 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698768536;
	bh=EYfspEu3PI2rpXyzN82Cv1qtuVu6AZTOaElxhmFbG9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaNOKewa+TdgtHYvvczOhkKaAqtjDFYuwcvP57jJg0B11+7sZOBmbjRwLYRkydZBA
	 1Ik4k3+ciC4eUu4X5uSA1xlGCrhAdATJQHg+UlngQKksPJziQacmUcS5qZ6r3DHBJD
	 +5C4T5Q3yEKB6HXA4TXqzuO2cmRHWkjQ9ucQ3YlCYVWYiOTHOBBdwaA09bHoZtFK1Q
	 Da1JtQ51Zj5fEApWCpb1/uR0+IacxhOFb+rfYgyJgV7pZaADc6QTov1fdzBpyFJHkW
	 DJTAlmZ/FI3MYx1Wsq6yevm/+FkyyOyWOJboWHAOBnIH+/yR0uEy4yZB7uAF7edRYY
	 xZHplcKPYhd0w==
Date: Tue, 31 Oct 2023 10:08:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
References: <20231030160044.20355-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030160044.20355-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231031_090901_091012_CA446321 
X-CRM114-Status: UNSURE (   8.42  )
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

On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> The firmware version sysfs entry needs to be updated after a successfully
> firmware activation.
> 
> nvme-cli stopped issuing an Identify Controller command to list the
> current firmware information and relies on sysfs showing the current
> firmware version.
> 
> Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Thanks, applied for nvme-6.7.

