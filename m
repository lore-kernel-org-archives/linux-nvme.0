Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C869BD36137
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wJld8kCv/wAn4pyrxsrz1IxijYNopFAdPnO7DtnyhNk=; b=fNEXMPXhwrrPm05sx1Q3X8QnwR
	x9ZaK5LcjxiqRtmBiYHdn/jwtLCfz2uNxnsNSNsTvJ8RBjQ7TT1aUkdnJH8a2LOH/uEVDC/2Hqt/f
	9T0DDB459+PMot3z4elr1ci5j28ng9C/HBBdoheG3oKxdTVNQf7NFhfH6XzKMErEUUIY+dwDQngxu
	Wq7K0pBV3RSuAi8mT53Ohsgt7q80Y3vSynlx6DFG3uVGzoFP1/JqhRIh6PQTKLV/GxVqk+FuSrt+k
	yO3RxYLSn+p8AqESCltQHqMZYCQkSQ6h7ix5P/GNL9OZkMTksJtr1Q9ZNo2nnmFrgSDZ1qYLVhrJm
	Bi8wdoMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QC1-00000000izR-2lOb;
	Tue, 05 Nov 2024 20:30:25 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8QBR-00000000is6-30dV
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 20:29:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A383EA43947;
	Tue,  5 Nov 2024 20:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D156DC4CECF;
	Tue,  5 Nov 2024 20:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730838588;
	bh=C017ehOoVOjWagRbzE/hHKX+G2UjK855hvImU0Hf33Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Be8ie2/bUG7K/aWQd20YiQ/9m2HSjlmW9QbfBsc2WdoM2X3Ot/bA/hqDCCddnIyCc
	 gE1W8MVKhIqrHOZ/WXthYA/zYL+NzNQ7qXklHwrAfP9seQtajc0qzeAA7cVBbRdBm8
	 gLX9QThDB/38969lZeqrLEHEclHx/jneTXp5AO0wgkeNUq+jdxUtfeck+wAmhKOzw1
	 IIMklTDMJRPk1u+kK3O1gJYKjQ3ni2F166fVdyjC37V/Di5ZYIXMYagI1jlgNkot+2
	 +jQIejRrp+OBc7jl4f6Tm1yamW0eICDXXASKz7kgviI4MD3XPgCpDcpsS2LBekL+u8
	 HiX5MPVNKEZnA==
Date: Tue, 5 Nov 2024 13:29:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv3 10/11] nvme: make independent ns identify default
Message-ID: <ZyqAOWARxZv_Byvs@kbusch-mbp.dhcp.thefacebook.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174904.3612888-11-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_122950_025305_509E22B3 
X-CRM114-Status: GOOD (  11.06  )
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

On Tue, Nov 05, 2024 at 09:49:03AM -0800, Keith Busch wrote:
> @@ -4004,10 +4004,9 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	 * data structure to find all the generic information that is needed to
>  	 * set up a namespace.  If not fall back to the legacy version.
>  	 */
> -	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
> -	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS))
> +	if (ctrl->vs >= NVME_VS(2, 0, 0))
>  		ret = nvme_ns_info_from_id_cs_indep(ctrl, &info);

This should probably retain the previous conditions and just OR in the
2.0 check instead. I already made the change in my local branch, it
looks like this:

	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) ||
	    (info.ids.csi != NVME_CSI_NVM && info.ids.csi != NVME_CSI_ZNS) ||
	    ctrl->vs >= NVME_VS(2, 0, 0))

