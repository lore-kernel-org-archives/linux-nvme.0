Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C21C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqTupFHdWOP7XknPjNhQ1+otLO26YLnn5ZSEsxhj8Do=; b=AxRjUKCLYC+yVij79F0ZCr24JC
	ZQXFY0qogupeLl5Rj1VN3yNGwGYDY8J03AXcb+fNoayW89lwghwpfET7uqYIL87ozCNV9PPSTFcqp
	AaNaG1sdKmGBTze0XRoP/mhKHcjybOcP6dgmnCEHQT9xGNjexxoEu8rsBXt69pYFYNEETCci5UuEN
	JpOAc0RXuShge1ssN4HaU8DO1nStDHRDhFS2p9Vru1JPSOIz9SqmOsS2sqY8eRPTbss2qldtkI+vN
	4k9n5lv3vb0DDcbLNu3CHMBq/zWTghrmVX8w3Qj8RcdjzpfTOl8pR8K2JpXdoQa01KdOhHyTPE6Sq
	kJqzY3yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTrb4-00000004HS8-45cI;
	Tue, 24 Jun 2025 00:33:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo3Z-00000003x5A-41di
	for linux-nvme@bombadil.infradead.org;
	Mon, 23 Jun 2025 20:46:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=fqTupFHdWOP7XknPjNhQ1+otLO26YLnn5ZSEsxhj8Do=; b=SZy/nLP/3c+QnF2BTKRl/kNQxj
	AvTwWK7ITnnOpj9kUWgxUlM079YiCqRv0XrRCWrbvBJD5o+xeJHfeGBxMjmGCMo5Q9PL2GlbGG1Q0
	tyK3+41KZT/bFOsIW7hZMPLaFHzdHZlEfm8Y/N/APALXsPWLteRNWbKKDXl0KeGw4XRqdyl5hGbhb
	Uft+5d1Cn7kgwT7dcOiafFVnKG8KIOukX+wiqgbPtU6v6oHcJoRZVn2DNKyRuoei2Tgadhp9YyK1I
	hz3maER1osGsNiIUlG6+mCtitDdFDjwIH1BvYjrLeIBXOTb10S6jhTuBoag+fnD+HZgOFi1co54Lt
	0Df6ep5w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTo3Y-00000004ZHA-0h2U;
	Mon, 23 Jun 2025 20:46:20 +0000
Message-ID: <ff61ff8e-d20c-444e-988f-6d97a197e070@infradead.org>
Date: Mon, 23 Jun 2025 13:46:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nvme: Fix typo in status code constant for self-test
 in progress
To: Alok Tiwari <alok.a.tiwari@oracle.com>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, nilay@linux.ibm.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
 <20250623064036.4187788-5-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250623064036.4187788-5-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/22/25 11:40 PM, Alok Tiwari wrote:
> Corrected a typo error in the NVMe status code constant from
> NVME_SC_SELT_TEST_IN_PROGRESS to NVME_SC_SELF_TEST_IN_PROGRESS to
> accurately reflect its meaning.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/nvme/host/constants.c | 4 ++--
>  include/linux/nvme.h          | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
> index 1a0058be58210..dc90df9e13a21 100644
> --- a/drivers/nvme/host/constants.c
> +++ b/drivers/nvme/host/constants.c
> @@ -133,7 +133,7 @@ static const char * const nvme_statuses[] = {
>  	[NVME_SC_NS_NOT_ATTACHED] = "Namespace Not Attached",
>  	[NVME_SC_THIN_PROV_NOT_SUPP] = "Thin Provisioning Not Supported",
>  	[NVME_SC_CTRL_LIST_INVALID] = "Controller List Invalid",
> -	[NVME_SC_SELT_TEST_IN_PROGRESS] = "Device Self-test In Progress",
> +	[NVME_SC_SELF_TEST_IN_PROGRESS] = "Device Self-test In Progress",
>  	[NVME_SC_BP_WRITE_PROHIBITED] = "Boot Partition Write Prohibited",
>  	[NVME_SC_CTRL_ID_INVALID] = "Invalid Controller Identifier",
>  	[NVME_SC_SEC_CTRL_STATE_INVALID] = "Invalid Secondary Controller State",
> @@ -145,7 +145,7 @@ static const char * const nvme_statuses[] = {
>  	[NVME_SC_BAD_ATTRIBUTES] = "Conflicting Attributes",
>  	[NVME_SC_INVALID_PI] = "Invalid Protection Information",
>  	[NVME_SC_READ_ONLY] = "Attempted Write to Read Only Range",
> -	[NVME_SC_CMD_SIZE_LIM_EXCEEDED	] = "Command Size Limits Exceeded",
> +	[NVME_SC_CMD_SIZE_LIM_EXCEEDED] = "Command Size Limits Exceeded",
>  	[NVME_SC_ZONE_BOUNDARY_ERROR] = "Zoned Boundary Error",
>  	[NVME_SC_ZONE_FULL] = "Zone Is Full",
>  	[NVME_SC_ZONE_READ_ONLY] = "Zone Is Read Only",
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b65a1b9f2116c..655d194f8e722 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -2155,7 +2155,7 @@ enum {
>  	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
>  	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
>  	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
> -	NVME_SC_SELT_TEST_IN_PROGRESS	= 0x11d,
> +	NVME_SC_SELF_TEST_IN_PROGRESS	= 0x11d,
>  	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
>  	NVME_SC_CTRL_ID_INVALID		= 0x11f,
>  	NVME_SC_SEC_CTRL_STATE_INVALID	= 0x120,

-- 
~Randy

