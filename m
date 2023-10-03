Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED02AE8FDC4
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Oct 2023 01:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ImoiuXHkkzYBkG9LKuEgSe16wxZXend4hMS2gVLnqeU=; b=TL5WV5FcdDhnBqOtis8HLRiZCX
	O7XnREiXY79revRJg9PZU2axbTQMCH4SmkDyPJOK21mLKpsWcWvxe5zEUE92H5IhOiJ7iV3dL17Av
	K4RsVb0U8jNaZPTMX6La428GxBpCVLZ2lURQGbM55hPlh2Ve+O5Aa1ieq8KwD0MIHCPHiQKpTvL6I
	wfWW5CNgLOIINZOOy+DtL7E2YNS/hA/iavsIpLmy3K7lWd8s7inOPunBnaUzqILv6cM/85STtgshH
	/vEwLiC37utTJgBseajbgpQF95cgP03OiCDWniZ0OGfSUwAEDL4C3ZPkkpi+/kKEtwZ7E0PNF3E2T
	1Y8zlAqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnqx6-00Fjp5-1n;
	Wed, 04 Oct 2023 01:45:28 +0000
Received: from omta036.useast.a.cloudfilter.net ([44.202.169.35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnqx3-00FjoG-2T
	for linux-nvme@lists.infradead.org;
	Wed, 04 Oct 2023 01:45:27 +0000
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTP
	id npJ5qY89VNWIenqwpqHTBi; Wed, 04 Oct 2023 01:45:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id nqwoq2vb6rhMnnqwoqa8Db; Wed, 04 Oct 2023 01:45:10 +0000
X-Authority-Analysis: v=2.4 cv=WLps41gR c=1 sm=1 tr=0 ts=651cc3a6
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=Q-fNiiVtAAAA:8
 a=Ikd4Dj_1AAAA:8 a=JfrnYn6hAAAA:8 a=NEAV23lmAAAA:8 a=cm27Pg_UAAAA:8
 a=VwQbUJbxAAAA:8 a=0yL73Cyy68KADmUz8mEA:9 a=QEXdDO2ut3YA:10
 a=Fp8MccfUoT0GBdDC_Lng:22 a=1CNFftbPRP8L7MoqJWF3:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ImoiuXHkkzYBkG9LKuEgSe16wxZXend4hMS2gVLnqeU=; b=Ub75atfzUGXufNj+3tjZebWBx8
	Crenc6HJ6Yl/4YCNWrD0qflFAMM0WdKD2DxyvfKpjk6idLxTSpJrZ13D7INnqMbF7FxnMsM68mmz5
	dVb6fJ4snbVd6ANUBT+Ouwek6qAgeNcYAk5fwkyhSI2AtttDKbezk3RvUbxeJSTYbO3DryQMI/YH6
	d9PL+p6V6cCcMI0lQ+EpnSvVnxKnaGE091zU7nookkT9KArJwZARY4H6BaU+VIsPm7CGQ2FlrRhEP
	YCFxAF19FBXDPDAv740N9cxlo9gZEz+/DWvFSOc14o79yum/wICE772FHji9KnyFE94fgkguBxqzW
	Brsn+lTA==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:58730 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qnp1W-001Wx8-2Y;
	Tue, 03 Oct 2023 18:41:54 -0500
Message-ID: <e2bf83bf-7832-aa1c-bf7a-bbc0d311b25f@embeddedor.com>
Date: Wed, 4 Oct 2023 01:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
References: <20231003232511.work.459-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231003232511.work.459-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qnp1W-001Wx8-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:58730
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpFU2Dn3wD/f56guTZwR28yKu6NciC8gP5Wq3c8Sn3QxkUg84NE4euEObz++tEm1mEQs1G4lyDjMiGfm1X0r1xhrjbJiC4u2uojJd2c+NLpGN2l0+ew
 fGnoF8JSotLY+kLRT+gsTCaWk717XMFo8IaJiG6KMkWtmto5HW3paNcNKkgmJtzNTUhmqrdBphkROm67qDXeGAw84Wa+oF2tPYUFdRcsdLisTAQv0DUC2/RG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231003_184525_892025_07BBB852 
X-CRM114-Status: GOOD (  13.96  )
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



On 10/4/23 01:25, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nvmet_fc_tgt_queue.
> 
> Cc: James Smart <james.smart@broadcom.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: linux-nvme@lists.infradead.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/nvme/target/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 1ab6601fdd5c..0fa2d658cdeb 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -146,7 +146,7 @@ struct nvmet_fc_tgt_queue {
>   	struct workqueue_struct		*work_q;
>   	struct kref			ref;
>   	struct rcu_head			rcu;
> -	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
> +	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize); /* array of fcp_iods */
>   } __aligned(sizeof(unsigned long long));
>   
>   struct nvmet_fc_hostport {

