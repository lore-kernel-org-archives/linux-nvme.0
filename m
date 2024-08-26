Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98D8C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9HwPO85MKwT1iym/B3AczU9X5MEh/By3P01Vp8F/KSs=; b=CwE4/rcU4P5VnmkDWSpZxgAIxZ
	7pJq4tLf07aX9Iki1C/eVn8+/u9HZuv8v92vWbDXhXc213cqRZ2D/Pe+0vxGnFvrDmK0mnzkFW+wg
	bMXDToOll3FGTlLzlVp6Ea6k8CApS7SfcWVCq6UMVA/shoUKM5BAPG8wijz+w59j9zH2JwoDRI6xi
	3+YC5KlMKKZuZpJs3/p1QAY6CgkxaG/LyMJ/H0yoU3jBJwbEaRDlIvA6fjYuRersNr0wGBx8VstJj
	6yHc1GYmw0fGTPI1l0rYQ1LS7gJmM6c+mWoFyF67WXvY1L8O+4hyWoK1xcj1e9/BigJmaM8lUQCQD
	686ROS4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidO2-00000008B2X-39kL;
	Mon, 26 Aug 2024 17:20:14 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sidLv-00000008AgP-0dqi
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 17:18:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7D706CE0F15;
	Mon, 26 Aug 2024 17:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FCEC4CA41;
	Mon, 26 Aug 2024 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692680;
	bh=9HwPO85MKwT1iym/B3AczU9X5MEh/By3P01Vp8F/KSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tr2ZzOhKCfYhEN8K75IRT/WigW1mbbJF2nyK/nnkh3h9LAp+cUbWmILli41qKSlqt
	 Idl/dcJUIw7j/xeOe6zGH5EwOMl9+Ub9SA0DK/rVhXAA972EbEiM/wKbmjYY0Sq4ej
	 jMGurP4mnWYZsP5HZ+J/krk/gOQSmoVmHftG5UAcg3KBz+WhAyqVQCDNiGx9yyG3sL
	 ixGtV+68c+PhhZq85mzVOt0kmmhlJcbG7aJExvHrHJBlKpOXV14B4UQZX2kDHWaLuS
	 PYEXTo/PiscYnrz3pS3NijHMfmdj0T017vaXInfKSrHHgu2SbOImp/OPQWtu5AGmvz
	 3m97rsAJkqhtg==
Date: Mon, 26 Aug 2024 11:17:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
Message-ID: <Zsy4xXsmBr57p6Jn@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com>
 <20240826103943.143962-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826103943.143962-1-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_101803_486489_026FE432 
X-CRM114-Status: UNSURE (   6.81  )
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

On Mon, Aug 26, 2024 at 04:09:43PM +0530, Anuj Gupta wrote:
> Rename apptag and appmask to lbat and lbatm so that it matches the field
> names used in NVMe spec.

Thanks, applied to nvme-6.12.

FWIW, the previous names were set before NVMe spec defined those fields
that way.

