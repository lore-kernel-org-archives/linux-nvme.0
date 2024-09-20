Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D4CF9C5E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2024 16:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vux1iGVLFRUpxMdRpXk85mVBY83A8yejWu/B1g7YPi0=; b=mRCRqjsyvrmE+uGjQ8U9iGvaOu
	9udfScr74JpfOXp2rlc51OMpxTsTV7HxsdLnDp0mkAwhS2vXKkj2T7jDnYXrotZwI3dFxpZeEjJiY
	t5TrDg4TPpRgQh9JDwLBPDvYmC4K+Mu97LpDZ47jukjchMaonckYBfDuH0e40YiSD0bJnAsAs5q6j
	SIR+sw0NkwoyEE6POknI2VdlL+oXrUCeEEl/XxmSh2oH+YKA4BEdMTZeAmA2HsudJ4bMVGZ8oO5S1
	eQQtfUijHUcMXXNmAWWFqKEWBlYsPy/rR22dQzLWtXhMmPIJ020ZUsU9aUflEQ8+2jnKIkGi+h+5z
	2U7+nQWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srgpX-0000000Cdhx-2L4b;
	Fri, 20 Sep 2024 16:50:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srgpU-0000000CdhK-2VQ6
	for linux-nvme@lists.infradead.org;
	Fri, 20 Sep 2024 16:50:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 934C75C3E7D;
	Fri, 20 Sep 2024 16:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5483DC4CEC3;
	Fri, 20 Sep 2024 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726850999;
	bh=O8WP9/2xvCb+8d3VQu/Xx543FDUFsAdNSAJWH56mSXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CP9WjkDGLh+qr9OlVdhdmDE7fpi8wy9NXREYtsWRPA4Qm15nBwmbP2DDVyfdinjJJ
	 swLaRnqrlKbvmbopxQTz8B08ZaoayfaB7AKdirEWffgnRbGvXZj3gm+4eeTn2szGt9
	 NqQcUcTBCSWzkztwWZ+ZOb6sJVEoZSf6Thoy/PPMUNFs7gq4CSer8slTZdVkFK+Vi1
	 GanwPij/ueKPNV4J6b3MV10ARPQPNTJablmJgsxpJxmjFDFPHKZaO09jlXMENjaDgz
	 pxQuAuSt1vtb791RoXIl8i8hT8/Hig6r1xfDWmtGdom2EU6ildhGbBr6fm3dEROPXD
	 ausd7TXEAsdGQ==
Date: Fri, 20 Sep 2024 18:49:54 +0200
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH] nvmet-passthru: allow nvme ns-id descriptor list to
 clear EUID/NGUID/UUID
Message-ID: <Zu2nslMqpfPR9j6f@kbusch-mbp>
References: <20240917085112.155173-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917085112.155173-1-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240920_095000_722886_EA444CE4 
X-CRM114-Status: UNSURE (   7.76  )
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

On Tue, Sep 17, 2024 at 02:21:04PM +0530, Nilay Shroff wrote:
> @@ -547,7 +543,11 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>  				return NVME_SC_SUCCESS;
>  			}
>  			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
> +		case NVME_ID_CNS_CTRL:
> +			fallthrough;
>  		case NVME_ID_CNS_NS:
> +			fallthrough;
> +		case NVME_ID_CNS_NS_DESC_LIST:

I'm pretty sure you only need the "fallthrough" statement when you other
statements inbetween the cases.

