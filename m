Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD17C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5qDbXPyCsMlE6Y8Zk8ff5orbjWcj79X3Eawxk6wVPE=; b=wf+0a4VkTdO5QCGzqnLMx+AC17
	LO0knMEN5ZLJo8tWeFVZiEIjkvxxFKCVdi8fDVpln1NkdDBEBFtig50+ah1RgPhZUwN4bAh0WTMNp
	A6Esx6O+y38KaYblmKoPaD6hS6uXCR/Rkpivrb9X8yDaLVvWe+OjfL6nqyoLp0jiCwWIAOYxjtlFv
	XLV0419+39ZdzMiozLizCdp22bHO/p0wJfJjNXR6ZTZWCb4OiD6fHvQfkyiCxfk6x/uDF/OmAjgLM
	WUxRmVX+Ztp+G5JbB0t6deiD7lLjCUVfro3aRic3l2MqBxHf+dhyK1UMRyflQ7ENHbCPHBbBmbbns
	Gzh4jD4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7gA0-003Cw3-2G;
	Mon, 27 Nov 2023 18:16:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7g9y-003Cvc-20
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 18:16:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 621D6CE1253;
	Mon, 27 Nov 2023 18:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F414FC433C7;
	Mon, 27 Nov 2023 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701108999;
	bh=ZknOUBLMKSnRYUPIRq8z2I449mev8BtispzZPXU/eig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kewa8/8Vl2ljXIy4nV+J1uPW+QaBzWTnojvmc6n1wZ0fh8aYVd1FF+Wa+ehCU6cCb
	 Lm5wSwE9Mqww/+ERO2mqVTWzX2Q6sKal5D5DQT9vhIGAD+FywKW9LaPs0uDLWMYIrT
	 Ovbx7TYwtMv98xvd2Ub5hZhc8qXk9sTeGxLJ3/uTFNdU8n+6M3WT32Ch5Mihc/8KG4
	 ay7Dcqo8FGMK82ajk5emkwHnU48rwI6XSreZWEXOsrlQlsY+LxtaGll1dxtSvOBcjn
	 7A8NwlWiclO/3Cy0ESIWpAn/M5j1VoVqfM/a4mNPZbu5P67MVzwTGRrq8fEh1NeBRC
	 o0GPJy50udFhw==
Date: Mon, 27 Nov 2023 11:16:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
	david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] Merge tag: Fixed an issue where it takes more than 20
 mins for SK Hynix BC901 to switch to developer mode on Chromebook
Message-ID: <ZWTdBKLU32mEc70A@kbusch-mbp.dhcp.thefacebook.com>
References: <20231123100642.40923-1-jim.lin@siliconmotion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100642.40923-1-jim.lin@siliconmotion.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_101642_891407_D5C21AA2 
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

On Thu, Nov 23, 2023 at 06:06:42PM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable wrtie zero" can fix this issue and Sk Hynix has been verified.
> 
> Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>

For the changelog, let's abbreviate the subject to something like:

  "nvme-pci: disable write zeroes for SK Hynix BC901"

> @@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
> +	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
> +		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },

Could we get an "Ack" from the vendor?

