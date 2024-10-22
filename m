Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CFACDD0CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 19:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=75IL8ZX4tMF+3T1yPhL1Yo+KCTqeKUDUa3naMAaRYkc=; b=1pELwkcWWyqwm7nWiUfpuy4zWB
	PlEyy/GqvKtFSoi7Vl0NomZswML3d4WOxyZpE3qxgZL765pGqi6QMWe6oPw90Wz3f9fLEDxoHhVck
	Kt2BvsEOACkrEyIr5s7UzA4RfYNIcO0sykaQ9L8dj6eb3ggaD0kpMiA2q4OIYKW75N2MEtgSmte7l
	NpWPhxl6KXso4AKl/vNDAJdI/AzSUATFZQdIsaKhy5vBXT6ExOLxO23WXdlXRsV9/kUnyXSXCMGN6
	LysgejacLvBMy/j2FzER41bl/5WfFcyeiyWBf/Kvi9ELlU5QOrC8urheLFCVGdKHASTtNiqXVKMY2
	9vYM5nbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3KR0-0000000Buyy-3mAc;
	Tue, 22 Oct 2024 19:20:50 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3KQy-0000000BuyD-0iAu
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 19:20:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 30DDBA44549;
	Tue, 22 Oct 2024 19:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F05C4CEC3;
	Tue, 22 Oct 2024 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729624847;
	bh=HuJzc9MeJN7eu8hCvqReOH8KCdLp8zuJAlUygDRT6xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq9fZY17NfaPa9BouzsGJqjtcG7GyPhQpMQFZiu3/zBtgDjnNIYUqOspvMM64Gj+A
	 Fo4Rhqbxwmg13khBF6axK06UVJ0njvB9NeTzZjcDHmSa+TeaObhzmuMsO8q/44/Cp0
	 4uVbEYjE7cLPdqRv/w4n/b7T+yHuwrr4FVRRJcQW4Dmd3JdYGtw8GIva6FufJx0dFX
	 RRVrYPnpWB6PfhEZI46WF8ZvJ9IjrftXNzz7jIqpEHZOtuNFc67NZ0KndDH2tBsZmI
	 ySUBfSmZq9vM3ZoShFNmAv7DNuNYFMrKJJg5hgL6FEWUJ48lESsGhdkKulgdbY9/Ne
	 NpC5IYMMB7pbg==
Date: Tue, 22 Oct 2024 13:20:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme: fix nvme_ns_has_pi() to check PI size if
 metadata size or below
Message-ID: <Zxf7DJ-BTW9odH7M@kbusch-mbp>
References: <20241022181132.19871-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022181132.19871-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_122048_290088_1608553F 
X-CRM114-Status: GOOD (  10.79  )
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

On Wed, Oct 23, 2024 at 03:10:54AM +0900, Tokunori Ikegami wrote:
> The PI is the first bytes or last bytes of the metadata.
> So its size is not equal to the metadata size only but below also.

This is still wrong because the only users of this function are with
respect to PRACT. If anything, you could change the name from "has_pi"
to "supports_pract", or something like that.

>  static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
>  {
> -	return head->pi_type && head->ms == head->pi_size;
> +	return head->pi_type && head->ms >= head->pi_size;
>  }

