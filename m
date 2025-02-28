Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED04C282D0
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XHssycxqLJgmND4jb+rHtN9cF1uNrijUlm8EYL33Vho=; b=Y4MB57MT9lH0BBdF7aIdmjzMtf
	LOPj8Ul/CzcHxTHfFydsPIntaR3DKPcRnB9BD2+Ig9sPXp/IxFOxlJwT71d6gyo0GGJ99bFsxKMvG
	MdhQ0DMjkTca6bzBIiGy5zSCmDNe610wuMjoCFqqyFlMYnVY/YzUTQ7Er2Y0TAsu9ilGPQ1pZQYsm
	G2wTDg18bL7FBnHlPnMaNgJAUDt4cmuwMV6jScBg1IHERW9MFrdrS3l3zoCAJtBtf1UrTd1wpMUpU
	0GZcPn76hKQW7Q2PZm+b1HsSJ0sCnyvDs9hY7TDvhcsgpxjOEyYKpeSgDK3A+8C09xhGNFwxKv7b7
	VrDZOBmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to4dQ-0000000C2oi-0hPa;
	Fri, 28 Feb 2025 17:58:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to4dP-0000000C2oT-1Vz1
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 17:58:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0850261148;
	Fri, 28 Feb 2025 17:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01B3C4CED6;
	Fri, 28 Feb 2025 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740765530;
	bh=0jsoPlPso4OHZ8H+4K2ZGmFrOnqHnacsQ/7Q3/VBGYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwkPHFj1Rw9ArId3DDIoofcMi+zHhZWkCRhLLo34qNxFg1+f9dWY4G2Xhy0dFMDHS
	 sWklWU5kbrmx68u7ioIsXhi37M028gspeA5tYr8xg1L1YHfYpjjkNGsIF1h6QJGYUf
	 qdcSDFR5czSc/iFOdMePZtrZEO5wMHu85V9uzFlJ3lxwd0ZVNtRRDoLl4vh9TBHsAR
	 WH5bn9PPeEMOE6g1xsBJ8xDyt1y+2FZHcGEfRZ9PZFl2XxbynecEf7ly21lLQRPLEp
	 UI5QqVGgMIw+6RsCXp1qrO+77SgwlFnOc69j/QFb2geNFiprha6ytOacQX5Zsat2/a
	 iQsB1qnmw+IAg==
Date: Fri, 28 Feb 2025 10:58:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvmet: remove old function prototype
Message-ID: <Z8H5V6Qn_CSnPaJF@kbusch-mbp>
References: <20250227190005.895342-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227190005.895342-1-mlombard@redhat.com>
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

On Thu, Feb 27, 2025 at 08:00:05PM +0100, Maurizio Lombardi wrote:
> nvmet_subsys_nsid_exists() doesn't exist anymore
> 
> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

Thanks, applied to nvme-6.14.

