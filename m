Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B709AC636D3
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Feb 2023 03:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Xzk8rCnK/lia/MG8x9fGYAjpAMfeN1/A2lUOkk5H2c=; b=OznDj96Eao8HKRVN7UFFNSgaBt
	2J5+9EsJ+WFV0hGH2c8QkFFJUjp+AB+Te4aIvDyXDMIw34gdU6GbwMHSyLjOkD2BGKIszvaobLWbg
	n2OT22ky1Tic2xCwGD6xrsXgsHeWaDKC+M874grTDmie2gpNPfMcKDDDFGYdjJvJ+lZMDnxZ+2czD
	Fv76gkRxazyvWatwkCoi++fMxcgSnSfLg7YsZ/IBfgH5tnuz3e6jcRBprQayIlEHkVEk+sw7S6eSh
	/oTh8ltQKZck0FNiiMs3tEWCys72ctzUK4RSAxMycn53g9mUkFDQmFA+7qsEqmz84RSsYXIBMsx4x
	XNElHHQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9Qr-004Mp3-2B; Sat, 04 Feb 2023 03:41:41 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pO9Qk-004Mof-VE
	for linux-nvme@lists.infradead.org; Sat, 04 Feb 2023 03:41:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5645761FD7;
	Sat,  4 Feb 2023 03:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA88C433EF;
	Sat,  4 Feb 2023 03:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675482092;
	bh=WsWgBt2tH++JXkyXB7EIAp2Z20LWTwYRMHcAOAtdqHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=byULJ6++AfNCgms6UR2Y7h6Cwd1itpSfnRNAP8TkUbntTeSSmUl1RVxu+UT3A2Hn2
	 sp4vUBqQnU21P2vY0sng0YJk9R1IQoUNn2xurhVminQAVEXpp/SvYTqFtX//UcmbUL
	 U1m2dZJfZ8lV1hChmGtVWboJxvoT+fFccP54+DLyOn3iTw5R/0Bagg917X7LQO3W5L
	 4uzWlzESw4BCcmij93zSWCSrDqPLniaXxfULEAd6QpvvZ55dBaswOWCL3BFqNrBHEb
	 JuwTCRCCHUePSLRkhXGaZeNy/Nz92ZwEEVYCUn/bkPlw1yOHqr9t4oqjBIuMKNU5hV
	 2rXiQExvWrbyQ==
Date: Fri, 3 Feb 2023 19:41:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v11 04/25] Documentation: document netlink
 ULP_DDP_GET/SET messages
Message-ID: <20230203194131.52b8c904@kernel.org>
In-Reply-To: <20230203132705.627232-5-aaptel@nvidia.com>
References: <20230203132705.627232-1-aaptel@nvidia.com>
	<20230203132705.627232-5-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230203_194135_076347_98CAAA94 
X-CRM114-Status: UNSURE (   8.82  )
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

On Fri,  3 Feb 2023 15:26:44 +0200 Aurelien Aptel wrote:
> +      do: &ulp-ddp-get-op
> +        request:
> +          value: 44
> +          attributes:
> +            - header
> +        reply:
> +          value: 44
> +          attributes:
> +            - header
> +            - hw
> +            - active
> +            - stats
> +      dump: *ulp-ddp-get-op
> +    -
> +      name: ulp-ddp-set
> +      doc: Set ULP DDP capabilities
> +
> +      attribute-set: ulp-ddp
> +
> +      do:
> +        request:
> +          value: 45
> +          attributes:
> +            - header
> +            - wanted
> +        reply:
> +          value: 45
> +          attributes:
> +            - header
> +            - hw
> +            - active

If you need to respin for other reasons - you can drop the value:
entries here. I had to add it for the previous command because of
the discontinuity in IDs but if you're just adding subsequent entries
- the value being previous + 1 is implied.

Acked-by: Jakub Kicinski <kuba@kernel.org>

