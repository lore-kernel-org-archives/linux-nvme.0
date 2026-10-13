Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4554CC6B0F
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zcR3PlylQnyqBRxWX+O7qoT4qEtgWVHKV1DgLyS+mFs=; b=yWsdhRPIzwg+058z2CWQ91SdQe
	+y8jlryJVTVsVmCCYx+MAK0krDx9LvBwHSfkjI+LvtCitxwiNL3GPl4O4orXka9sU2mc5oCmfFSmU
	NXw4mrixCv179vPYf2L9OiVqjmdruVsxPJc6aIMygPAin4JfhMusdRjZ6a2OT54mgPDc/iA+zWjYs
	QOgvujpAra/eowe/aC2A7uhLSKKV/ew/L+RIeW8+GFmk1IgHgqbPiEwUaZzGknMKkn+nnj4QJ29g+
	rqOQlJKHI0JaurCRVNd+zqZy7Bqyyls1UXlGjxSOu9r3txO3LVa48u5h7XB5AWf/Dum1QWJ8bkN+d
	q0TJbBvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZ5d-0000000CT07-3ixm;
	Tue, 13 Oct 2026 09:46:33 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZ5S-0000000CSum-3wQV
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 09:46:33 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261013094618epoutp037fed63338ba67103efc211aea1f9cea5~eDbZTWKqL0705907059epoutp03B
	for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 09:46:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261013094618epoutp037fed63338ba67103efc211aea1f9cea5~eDbZTWKqL0705907059epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791884778;
	bh=zcR3PlylQnyqBRxWX+O7qoT4qEtgWVHKV1DgLyS+mFs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nUcb/E00r5cb2ogVnTS543Eg8m+GIn0dOZJlh68XOJP5lfzMtbKYsM7kA+pL+K1a+
	 pIe52jtjzQeQ7GuR9BDbUOnJFufIgwY92tjrA4/4mCoolI9orxJs/XwJnO8LEAqYd5
	 rXBsM0xUzul7t3XQ32FGV/iK4FNYMPsgWaWdAgnQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261013094617epcas5p313e0734d2c7db7bbe03c473bb234212e~eDbYth67v3006230062epcas5p3d;
	Tue, 13 Oct 2026 09:46:17 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4j3qGc5Wd0z3hhTB; Tue, 13 Oct
	2026 09:46:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261013094616epcas5p28bf84b929cf60a77eb94cdb96dda7589~eDbXPcQd12244922449epcas5p2E;
	Tue, 13 Oct 2026 09:46:16 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261013094614epsmtip224a207ec66e03df7efa597a945cf76c7~eDbVilTUS2166721667epsmtip2i;
	Tue, 13 Oct 2026 09:46:14 +0000 (GMT)
Message-ID: <66bf5def-eabb-4c9f-bcd5-0143655ffd1f@samsung.com>
Date: Tue, 13 Oct 2026 15:16:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: bound FDP config log reads to the received
 buffer
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20261008182453.1262733-1-yhlee@isslab.korea.ac.kr>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013094616epcas5p28bf84b929cf60a77eb94cdb96dda7589
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261008182524epcas5p358972aeaced27431d3c1412e88a1fae5
References: <CGME20261008182524epcas5p358972aeaced27431d3c1412e88a1fae5@epcas5p3.samsung.com>
	<20261008182453.1262733-1-yhlee@isslab.korea.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_024628_657637_CB0C750C 
X-CRM114-Status: GOOD (  26.01  )
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

On 10/8/2026 11:54 PM, Yehyeong Lee wrote:
> v3: read the descriptor fields with get_unaligned_le*() since a device-supplied
> dsze can leave subsequent descriptors unaligned, which could fault on
> architectures without efficient unaligned access.

Were you able to test this part.

> v2: allocate the log buffer with kvzalloc() so that if the controller completes
> the Get Log Page with a short transfer, the uninitialized tail reads as zero
> and is rejected by the existing dsze check instead of being parsed (hardening).
> v1:https://lore.kernel.org/linux-nvme/20261008132604.1168105-1- 
> yhlee@isslab.korea.ac.kr/
> 
>   drivers/nvme/host/core.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9bcab3dc4c118..094df0e6ed326 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2272,13 +2272,17 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
>   	}
>   
>   	size = le32_to_cpu(hdr.sze);
> +	if (size < sizeof(*h)) {

header plus at least one descriptor is expected. So this can changed to:

if (size < sizeof(hdr) + sizeof(*desc)) {

  > +		dev_warn(ctrl->device, "FDP config log too small\n");
> +		return 0;
> +	}
>   	if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
>   		dev_warn(ctrl->device, "FDP config size too large:%zu\n",
>   			 size);
>   		return 0;
>   	}
>   
> -	h = kvmalloc(size, GFP_KERNEL);
> +	h = kvzalloc(size, GFP_KERNEL);
>   	if (!h)
>   		return -ENOMEM;
>   
> @@ -2304,8 +2308,12 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
>   	desc = log;
>   	end = log + size - sizeof(*h);
>   	for (i = 0; i < fdp_idx; i++) {
> -		u16 dsze = le16_to_cpu(desc->dsze);
> +		u16 dsze;
>   
> +		if ((u8 *)desc + sizeof(*desc) > (u8 *)h + size)
> +			goto short_desc;

This and other short_desc check can be covered by extending the existing 
check below

> +
> +		dsze = get_unaligned_le16(&desc->dsze);
>   		if (!dsze || log + dsze > end) {

here, by checking that next descriptor fits completely.
Also !dsze does not cover other invalid values from 1 to 63.

Overall, something like this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7eb0f9fe6b18..9991cff5c332 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2273,13 +2273,19 @@ static int nvme_query_fdp_granularity(struct 
nvme_ctrl *ctrl,
         }

         size = le32_to_cpu(hdr.sze);
+       if (size < sizeof(hdr) + sizeof(*desc)) {
+               dev_warn(ctrl->device, "FDP config size too small:%zu\n",
+                               size);
+               return 0;
+       }
+
         if (size > PAGE_SIZE * MAX_ORDER_NR_PAGES) {
                 dev_warn(ctrl->device, "FDP config size too large:%zu\n",
                          size);
                 return 0;
         }

-       h = kvmalloc(size, GFP_KERNEL);
+       h = kvzalloc(size, GFP_KERNEL);
         if (!h)
                 return -ENOMEM;

@@ -2305,9 +2311,10 @@ static int nvme_query_fdp_granularity(struct 
nvme_ctrl *ctrl,
         desc = log;
         end = log + size - sizeof(*h);
         for (i = 0; i < fdp_idx; i++) {
-               u16 dsze = le16_to_cpu(desc->dsze);
+               u16 dsze = get_unaligned_le16(&desc->dsze);

-               if (!dsze || log + dsze > end) {
+               /* next descriptor must fit within the log */
+               if (dsze < sizeof(*desc) || log + dsze + sizeof(*desc) > 
end) {
                         dev_warn(ctrl->device,
                                  "FDP invalid config descriptor at 
index %d\n", i);
                         ret = 0;
@@ -2317,13 +2324,13 @@ static int nvme_query_fdp_granularity(struct 
nvme_ctrl *ctrl,
                 desc = log;
         }

-       if (le32_to_cpu(desc->nrg) > 1) {
+       if (get_unaligned_le32(&desc->nrg) > 1) {
                 dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
                 ret = 0;
                 goto out;
         }

-       info->runs = le64_to_cpu(desc->runs);
+       info->runs = get_unaligned_le64(&desc->runs);
  out:
         kvfree(h);
         return ret;


