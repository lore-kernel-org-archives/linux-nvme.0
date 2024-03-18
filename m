Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2672DC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fO7m3Bg9tYA5WiGswIBNsdbsR1fJqjRfTzVE1rxBNqA=; b=dniKWVEv6kYxT+ktHQZFFdZsSB
	3FXa2+AKh4jx81LchgT/gk0suhUkJCoNvb7xWxFZaeOQbZRaIJ0Cvabw0pvUdkZ3+e3jQgZ5nJJP+
	1C83kYH09G9F2SA4/F9MRQnSRQp1IbyZHzup6cxTK1kcx1ZpJ3Tv1WE+X8++AahAz7rickV/EvZNf
	Iq2jw28tFEk98V02nptV+uVb9vFp3WFIklw+pU+AUlJh4o4xCcxm8brFCEXjyzt18XuqI7y6FK2s4
	BrTE0Peth8dtTUQCW1PKatZ1C8xHQPkmvyp35nEIcXasrsgdXXQMjhj3+qEmYGwQ8xheP+pOyrPew
	RvAopP8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJkq-0000000A3D5-2bBR;
	Mon, 18 Mar 2024 20:38:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmJkl-0000000A3Cb-2X6w
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 20:38:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C29AFCE0B4B;
	Mon, 18 Mar 2024 20:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848B7C433F1;
	Mon, 18 Mar 2024 20:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794316;
	bh=q4WLmhu28x58xZ4DZAEo0ZfSLiDCHD0gVl59UgFzn5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvMHB99Zi8UWGTiGwVwNkjhGa/f8xkONpGPxsNlMA6WNkX6HDAFJSW3wPK0MwlHUS
	 NCEXy5KF8yTXG6/5FAuUx6/KY4uXbsYDIF16vGVCxD+w0aPGuVZjDCBKZpXRBncQYy
	 4xZIWOhprLeIAZ9Qn1XGwnCD49qvEKMw7QP+q3K3duIJ/c54fyL3lyxVpJEOCt/gSL
	 9v8xgTnadPJ5o50DBL6BaVrqdJNL5FnXQiukAMY6GW5+S7VcIAW5KEt/wyEhgQjQH9
	 OQSfEtBTC+Ffa0FU5OFYPpKz+Byml38d0ibzLTZsXI++AlLf/PmjVR3adGY4ltR303
	 /wBDbRCQ1Bpxw==
Date: Mon, 18 Mar 2024 14:38:32 -0600
From: Keith Busch <kbusch@kernel.org>
To: iBug <i@ibugone.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Message-ID: <ZfimSElFZMQYB1j1@kbusch-mbp.dhcp.thefacebook.com>
References: <20240315192747.1749119-3-i@ibugone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_133839_842738_53C64D4A 
X-CRM114-Status: UNSURE (   7.61  )
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

On Sat, Mar 16, 2024 at 03:27:49AM +0800, iBug wrote:
> From: "Jiawei Fu (iBug)" <i@ibugone.com>
> 
> This commit adds NVME_QUIRK_NO_DEEPEST_PS and NVME_QUIRK_BOGUS_NID for
> device [126f:2262], which appears to be a generic VID:PID pair used for
> many SSDs based on the Silicon Motion SM2262/SM2262EN controller.

Thanks, applied to nvme-6.9.

