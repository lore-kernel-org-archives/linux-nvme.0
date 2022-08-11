Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6344FC19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 20:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjaE3hL83gAUXTDTaK4CfIjw2PBYC3Lfb/0xOKyoJko=; b=lQ/L3qVq+0aNUuTG5AuiYl8nYD
	4gieUBHG1U9aFvqH51Cf882DpJRS/0OUirQ9CEdnnX0W8lyxLY5DrLB2amI5QK3srp2Y9qfhL5woY
	wLmg4mCkh1a7ttUQ7J/VNHWFYheAFiaYS286Bkwy2jzkES4q/1+9v3sjRZUS7JjjEou6kTmDoNTyY
	5cIYv7Dne/JOaJvIpcSx7Tmx0OvK3iZ0EdEI7Jp0tdNXxj7hEjpB08Q/t4hAZ/dN4+6C7X9aGIE8r
	5hqaV7+Xeo2twO+uoOBKfpz6Ki10OYaLZ698DfExqP5unb5yLuxUD5mLhwzLb/+Do+sTGCr5YDRki
	zul88e7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMENF-004rr7-OU; Thu, 11 Aug 2022 20:01:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMENE-004rnq-1e
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 20:01:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CF44261283;
	Thu, 11 Aug 2022 20:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8511C433C1;
	Thu, 11 Aug 2022 20:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660248102;
	bh=gjaE3hL83gAUXTDTaK4CfIjw2PBYC3Lfb/0xOKyoJko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKUWzl7W1wYIbpGlu7IHlGdIqizI9Vn12eremDkxgYW+CqZBlzlsKy7Fyod9HQakk
	 +WwfHTOTbs5P5dtObhQSiEcUtigN9INE9HAEnn2B3tw0R9L/y1rdCnI7PTAHZgxAz2
	 4/sPwORI1pjXTfsrHB14jhi73j0ydElYIfXOnhRXHzsQmGrsQb2D7uHdSNgXCkWPgW
	 fKhe/+tey79jlCfkmAOEiT7TiGgYX5dJKeVgKLkfImY6EX31+1bqyeB8NLHiFnkQy6
	 my/mJ/VzMzIZU1PZHuUOTR1iCmIbIRY2l4sl7OpI2nvdEhtXBH+HCKd4H8ebhr20TV
	 25RQggJKE8f0A==
Date: Thu, 11 Aug 2022 14:01:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: do not update kato from a dsm io command
Message-ID: <YvVgIzRXRv6EKk98@kbusch-mbp.dhcp.thefacebook.com>
References: <20220811192608.3387239-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811192608.3387239-1-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_130144_157800_88CE51F4 
X-CRM114-Status: UNSURE (   7.19  )
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

Actually please disregard this. We don't reach the effects_end on io commands
as it is already.

