Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABA4C369AB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 00:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1BeglVl5V4o/Bv4MNYA8HZfcp4/8kdwxBCW7kEmm38=; b=sWNiRYDaDwOLzuCA+07jkjF3Sm
	61t0uuLfPBHCp+XslhfoPo0qOFlURzQhMQoUBJq7Y0j8kwq7FoadVmCnn6kHV1Ndo7a31lnSH2/40
	vleB0NzHUvryn97TIJj6pw8JiO6OzTacqFIqytiDbp2aoSfAodz7Qw6HIlt+Z2nt90uRQSvs556dW
	sOD3rSIJGmuOepcujdNrpBzZ605sIqFzrZ8WPOzV9e1mOJRZb075Dv95NAQj5Owulgooq4ItU25xS
	vzN4txFCqu9XZbi+2t1Ri0+0tEYZ+fHoJU0nUAVeWyByVmH+UpgOzQ5uwYJp2DqltbWuAlS2CFp72
	HzVOtbnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qWN-00000007da9-3k9g;
	Wed, 16 Apr 2025 00:20:55 +0000
Received: from omta38.uswest2.a.cloudfilter.net ([35.89.44.37])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4qW0-00000007dTe-2sTa
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 00:20:34 +0000
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 4bJ3uGV6EAfjw4qVouCR56; Wed, 16 Apr 2025 00:20:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4qVnuRRV9UxvT4qVouphgZ; Wed, 16 Apr 2025 00:20:20 +0000
X-Authority-Analysis: v=2.4 cv=SqKW6uO0 c=1 sm=1 tr=0 ts=67fef7c4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=CpFGIHgWpZrg6UVlTl0A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=s1BeglVl5V4o/Bv4MNYA8HZfcp4/8kdwxBCW7kEmm38=; b=Tus3AVpuBOJzRWt/kY+9xi+3BS
	WhuaVT6hUU4KACDczFzoFwIJK44rC7YwdfOJbU9gCRQgBIeFCTvroZclz0p07WxBBUI1TFNKmoPFS
	bR16XKnSjc/ZkF6RzKcGjW1nBNgWFbeRxGlUNjMpicjR/rwBPqyAaJq5I7rA6LeXUdpsoiFoELjSy
	BMXW+8zHq0VtzNdeelXjytqQ6wasRoH8i6AQx9YpOWy4KMVm/mYvP++CQaGPCjcv+llWZVxHVK8G1
	6vKx3knYXo3D+tTBj0tr/dC4ShqcQ6DLIH8263qVeZcEvVIgRErNsEGPpQuQriS9mtp+M/NCoqk/z
	QnFbtNrg==;
Received: from [201.172.174.147] (port=56116 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u4qVm-00000000nFf-2h71;
	Tue, 15 Apr 2025 19:20:19 -0500
Message-ID: <a1c6fd4e-69b4-4698-bc5d-ef02cf7312e4@embeddedor.com>
Date: Tue, 15 Apr 2025 18:20:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] nvme-loop: Avoid -Wflex-array-member-not-at-end
 warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <Z-axRObjXYjIHGQC@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z-axRObjXYjIHGQC@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1u4qVm-00000000nFf-2h71
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.147]:56116
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF0dRLC9EP72Ehw5CF2xn/tz2iJXLY+qtkPg8pnWdLzZfgOxatteAUylZdVjPFlJoySqUT+DYOhkctyJaDAno0l3XYLkOTYNu45bZc0WvjGk3ZgvNkSF
 8Ywz3eFkJa4Um+L9BNbe+DV30hshehWI/XrJ0Z/aWWv09QE3+Ro4QLJZJ983oVILW5cPSoD3oYo3+simkk/BgRUjXGZLTJnXFJTVERUo5+VpEMvc6u8Xou9t
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_172032_791733_1EC6F4EC 
X-CRM114-Status: GOOD (  12.58  )
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

Hi all,

Friendly ping: who can take this patch, please? :)

Thanks!
-Gustavo

On 28/03/25 08:25, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct nvme_loop_iod` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> Fix the following warning:
> 
> drivers/nvme/target/loop.c:36:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/nvme/target/loop.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index a5c41144667c..d02b80803278 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -33,10 +33,12 @@ struct nvme_loop_ctrl {
>   
>   	struct list_head	list;
>   	struct blk_mq_tag_set	tag_set;
> -	struct nvme_loop_iod	async_event_iod;
>   	struct nvme_ctrl	ctrl;
>   
>   	struct nvmet_port	*port;
> +
> +	/* Must be last --ends in a flexible-array member. */
> +	struct nvme_loop_iod	async_event_iod;
>   };
>   
>   static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)


