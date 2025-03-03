Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CA5C282C6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Mar 2025 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zA8qNblY8pt/GEGYu8CvsP0wmBr2ZcD4i21K+EPbjcI=; b=oC2vexXpcJQFVHXaVW2+mLS26O
	wwaQf3RUMYWJvMkIcfIntFShPJF9tC0jo5SPSbHqXafFZRHhNJSWBqgy/IpmLRA1EjOPSDNDB6X0t
	0Gsjo6OJxe6ci9wzvQliqGiMfkNso3VvrOpGBmNOzf6wp1XRfak3oIQdv3IcveKKLL/0lG5mplHo7
	hrHYYzO7kxJQc/y/XN3zi7Wun4xN0kPLVgJFUIjrh/jhbyRAPEv7hUdmARozMmmwnLQg+PyI3AFhH
	KpV/KexuwglwrtoUUMii125KJ4hOn1k1F3ragMRjV5tBL6j/evBDIZzN22U4MeoP+wkiwTMH+J3xE
	Rb3p18mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpApa-00000001yfh-0kz5;
	Mon, 03 Mar 2025 18:47:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpApX-00000001ydU-2Msz
	for linux-nvme@lists.infradead.org;
	Mon, 03 Mar 2025 18:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 781A05C5AD6;
	Mon,  3 Mar 2025 18:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B247C4CED6;
	Mon,  3 Mar 2025 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741027672;
	bh=zA8qNblY8pt/GEGYu8CvsP0wmBr2ZcD4i21K+EPbjcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UVqKo77FBTo04fMaV6/BtP7g4FkD9TIKFz1CltxFaAtl9zYG4xkV9u58yDHaFVB6g
	 YVfQP2Yh7NPnALjp4q1nkYkO57jpYqSg1Bgs93iyZ7/n1Al9CaVilPPjLJlZCPmhFh
	 Oa7F4+oq7GCqArmW77xVvg6g7L3quIOechauIvehef/5tuMQWIJYUKQeOoO4lskCuF
	 2uSMlM1CyrPSy3hsk8MvG86Uhmybu+78Zv98Dxj3Zy/7a4a4nfUW+ragMy2pY9kEii
	 fBNjTfXGueZOAVlb4rZgXQKPzF/evd6Uy1yOLCUDjGpPsueRuTI9b2+5UibyWmom9M
	 AAFIFCrQfqNiw==
Date: Mon, 3 Mar 2025 11:47:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: james.smart@broadcom.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] nvme-fc: Utilise min3() to simplify queue count
 calculation
Message-ID: <Z8X5VJgQ7yPfVTdd@kbusch-mbp>
References: <20250213221622.81457-1-qasdev00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213221622.81457-1-qasdev00@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250303_104755_655116_04140D16 
X-CRM114-Status: UNSURE (   8.40  )
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

On Thu, Feb 13, 2025 at 10:16:22PM +0000, Qasim Ijaz wrote:
> Refactor nvme_fc_create_io_queues() and nvme_fc_recreate_io_queues() to
> use the min3() macro to find the minimum between 3 values instead of
> multiple min()'s. This shortens the code and makes it easier to read.

Thanks, applied to nvem-6.15.

