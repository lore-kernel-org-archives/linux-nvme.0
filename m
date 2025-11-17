Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F28ACEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HXOHxV7PMb8mfL/OxXW1m7Ta50IOmUkgm4ZdFbewGfc=; b=fobvobSGDMEudzTA1MleSKI4Cf
	gfiOTLLLt1CFg+30L1XeEPYNo1yRPg6QnP5fVinU1ggPbWaEdWGcgMQk0iCaXdODGY42JgnWfcbsX
	FpdgiDoMX4JLeGjWEt1TP3MoGWt6OOiSLYWvncIREPVCbgkW8t0Xt7+2XV9CN5TcJPRvDDtYacbyF
	AUYneenoBPEqQH2zAGzayzNwV0MJyz8C/m5zVToOYWImTnR/QA2lZYcuXuCzdSSavQseeKH1V4TH9
	KfHO2RRyb9aybAWJWhMTOrRg/i484YUEmwEf0SeKdG8IEQqQawpC9/2H6DeH1bh+vDaIn2+M2BzWw
	z/7Hrc4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2Zg-0000000GRXe-2M3f;
	Mon, 17 Nov 2025 16:59:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL2Zb-0000000GRXJ-0k6s
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 16:59:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 080CD60051;
	Mon, 17 Nov 2025 16:59:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C397C2BC87;
	Mon, 17 Nov 2025 16:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398765;
	bh=aeqXwPJzYn7SGONYH0iOjUdTF4D4joAXNRIjQZYaFMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmYnfFCQuaxMDkVASQVWvQAxrbw7T8d8VU1safSvtFvpVzlMlGevbV+Bk+xZD8o1y
	 Ob/aE2VXxyfl8jEGZB+KJpsc5bvL8PKbI/Hte7HjWPF/MBCrMUrWuD6ythf8JJUk+g
	 Dj73qJZVCE1hqKM01NV1scz1nfMhi+TOBEl/ZyscQ5PxUSBHAJIpAvWG4fQM9TI6vc
	 kzT1nORe0j8VW6uCg8GxAh1EI5Nk0v4MQuantPGv6PcpycCmR9hbRObXlgpO50GCxn
	 VEpfbqgrqHTc2JpLLdQ4hZ42UYTOQ2cbPJ4Ktsas15TbOVvgqWxGphsX7x4WiINFo0
	 gp2schN2ENowQ==
Date: Mon, 17 Nov 2025 09:59:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Ewan D. Milne" <emilne@redhat.com>
Cc: linux-nvme@lists.infradead.org, mpatalan@redhat.com,
	james.smart@broadcom.com, paul.ely@broadcom.com,
	justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
	ming.lei@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Two NVMe/FC bug fixes for -stable
Message-ID: <aRtUa0qhXJVFlyr-@kbusch-mbp>
References: <20251110212001.6318-1-emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110212001.6318-1-emilne@redhat.com>
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

On Mon, Nov 10, 2025 at 04:19:59PM -0500, Ewan D. Milne wrote:
> This patch series contains two fixes to the NVMe/FC transport code.
> 
> The first one fixes a problem where we prematurely free the tagset
> based on an observation and a fix originally proposed by Ming Lei,
> with a further modification based on more extensive testing.
> 
> The second one fixes a problem where we sometimes still had a
> workqueue item queued when we freed the nvme_fc_ctrl.

Thanks, applied to nvme-6.18.

