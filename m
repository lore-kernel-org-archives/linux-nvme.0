Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBF5C004C0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 15:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pM/9GDG6SvD5jwJ3gzKShISOf3fj/ZsIM8YNaNYkaNU=; b=oDw1byaYR38mThjxRC6TJZgGmN
	kH37JH8lUxKI0XoeRh/K8vi0bnaByhy8JQaJY3KmyicUbo1XgEz6nx9zSRLwxeKD2UH8qlCj7QRq2
	orzdv8MU0BAD+Otj+4ZeFxPhEPRfr7fJ/+p3KqjczkiuEI90nUABVC5FUyXxjR2JY1PRYxbVCst8F
	cKibtlAFkEA814ZNMJrbUuWC7Qh+qFz1BjPePVHwQCQq4e7cfpxUbb+hTbX6hAWVknsgPy7gYSr80
	8NNz375HYR5NZplcSGKJtG/M58DH8tAFrgV4hn1VCJtbmTkVmL3/ArLHGzlHA58cHS+5hboivJkFH
	WsMr8PZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quwhZ-007fiR-13;
	Mon, 23 Oct 2023 15:18:45 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quwhX-007fhY-0H
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 15:18:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 3CBA8B81E72;
	Mon, 23 Oct 2023 15:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12463C433C9;
	Mon, 23 Oct 2023 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698074319;
	bh=MioXTG7udluvSetup3O78g2HsJEJGk9gLWyJfEWeILA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJx2CfV/+FJCiVWBI6EsJhxvDLnqzg/b1qllHt7cMwV3PatGJp5gmRHX6iK/jxiez
	 kRurmaMakEqIWoXrL6DvCBETjyyl0Fyy2X4MyY514jhXPyeevItuZzXmYsk2bXv4cY
	 XYCMCInK0g7H2QENhVjX8YksIEBN6OBBnK+VoB8N/fUtxE/MZzypLmDez03xQpMmt3
	 URfJbBTtg8BGWvGAo0j1BIChnWdR3OWKYg1YtQsX7AwDj5s8PpC4SGk29PWG803Y7j
	 4fzCaoz5+yk2CApd13vd9KnriggdZpxWoB/tOEuhm+3XvBqpQrfBCa2VG0UJorH4qN
	 9ZYepcPt3pwCw==
Date: Mon, 23 Oct 2023 09:18:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <ZTaOzORdmFwxCW1c@kbusch-mbp>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com>
 <20231016060519.231880-1-joshi.k@samsung.com>
 <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com>
 <ZTBNfDzxD3D8loMm@kbusch-mbp>
 <20231019050411.GA14044@lst.de>
 <ZTKN7f7kzydfiwb2@kbusch-mbp>
 <20231023054456.GB11272@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023054456.GB11272@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_081843_260690_A4BBAF5C 
X-CRM114-Status: GOOD (  11.56  )
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

On Mon, Oct 23, 2023 at 07:44:56AM +0200, Christoph Hellwig wrote:
> Yes, you need someone with root access to change the device node
> persmissions.  But we allowed that under the assumption it is safe
> to do so, which it turns out it is not.

Okay, iiuc, while we have to opt-in to allow this hole, we need another
option for users to set to allow this usage because it's not safe.

Here are two options I have considered for unpriveledged access, please
let me know if you have others or thoughts.

  Restrict access for processes with CAP_SYS_RAWIO, which can be granted
  to non-root users. This cap is already used in scsi subsystem, too.

  A per nvme-generic namespace sysfs attribute that only root can toggle
  that would override any caps and just rely on access permissions.

