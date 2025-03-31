Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB25C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0We8BeznJdH5CBNtgCtqPVy1TYloLhcYkL5SfUrTOt4=; b=n70RBXx6ZtrleylKjcyfTmsFWA
	CjOPOuAcWDRNWmrHjopYBYWBK5jdlWY9qqEcFIOhjAkPXfB4J9VaKb5c/fY9QWG7s8r11z+TqiXZM
	iWZCGr+MYZ8g0tRVbqiaJUfHIDVK4l2JCNuj5KZeADxFdb5JOeoJ/mgfynpUu3wcdIxpAxA4MvV9T
	44aDCW396CI9yYJOuBF0OL7v96VSPSNCNNKcIM53XR3WUdxZNbdYxxrfBcY7TKJP6BZt6OfyYcdvv
	9wrhXyfxu7WQT8v9pyRHh55kAqrZ9McbbNbvkDYweJBh94/ttIeQ5d80RCHz0taq/z+On7K5nof7g
	Ic/HBL2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzIGp-000000010g5-0Wkr;
	Mon, 31 Mar 2025 16:45:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzIGn-000000010fm-1pSB
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 16:45:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8CFDDA4369C;
	Mon, 31 Mar 2025 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EBC4CEE3;
	Mon, 31 Mar 2025 16:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743439552;
	bh=0We8BeznJdH5CBNtgCtqPVy1TYloLhcYkL5SfUrTOt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r46a2it/PNwuKvqoom1gNWkD2FXC1mNKHkKjKsOH2oZZCzScH4AORyVk0s+7Mvs7n
	 pHu4EuGiJchM0plRTNIRsRHWq9zs7xsPWB2zlnYsrNvn9nnKYdk8H91wjKS34XLTsX
	 fVHz/e0px3irhmPimx8jVrnWOUVQCl6VpP4rtTBzT+9ifydIB9SAUpux5W/fTzH0Bf
	 pebl0IlXjxQLXdFTTXEvD4WvGKPEP9dyZDDghrDiLZAo3tVBx2RrenfVf72ySpkFgc
	 /YzT3Q2ugX+f72ydeocS0Y4ESRDt+AQiH8H9WnUTJeNP5mulabeM7s3AExXYIRk8vj
	 4w7JY9vp+yaQw==
Date: Mon, 31 Mar 2025 10:45:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@kernel.dk, mikhail.v.gavrilov@gmail.com, hch@lst.de,
	linux-nvme@lists.infradead.org, mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/1] nvme-pci: do not call nvme_write_sq_db() if the
 commands list is empty
Message-ID: <Z-rGvbWveFLWcqkM@kbusch-mbp.dhcp.thefacebook.com>
References: <20250331162859.1407725-1-mlombard@redhat.com>
 <20250331162859.1407725-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331162859.1407725-2-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_094553_546035_EBA7D75D 
X-CRM114-Status: UNSURE (   9.69  )
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

On Mon, Mar 31, 2025 at 06:28:59PM +0200, Maurizio Lombardi wrote:
> nvme_submit_cmds() should check the rqlist
> before calling nvme_write_sq_db();
> if the list is empty, it must return immediately.

I believe that could cause the driver to write the same value into a sq
doorbell twice, which is a spec violation.

Thanks, applied.

