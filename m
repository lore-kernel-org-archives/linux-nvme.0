Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1313DCD6E49
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 16:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxl9Cd1ekcjiytj6Bw9vuKytspEwY89flUAtcmDugAw=; b=mgRFB+lEqcWoukm86tmFFiBmgf
	HTT/pEkklMxV2ahYTPLxmVV6d4+f/XcAZs/0l16SRzHrvaZ6WMAlnCB2cv8T2a6ggmIFAm1r+YvSR
	6JTmVHCXFA+ywPoiKo5wVIcCaty8SXMEKpubD9L3a/f3cWv5DB+o4ndGx/YthPibYNmvoiymr88/j
	kMMWTUYyhbRltx9LGfcscgWEE9Ei1VIOpnqPwQO5q5ZAHz0csHoO9k4Ig9FOGwQHafYymQzs4mSdv
	+7w/JdRz39+OMdOzXhyAjcrltMuFD2QsusOzYSA1bzWLQjrHuH0drKBRbaZq8gcEvTiCz8xPd53qV
	q/ATMUnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSzlw-00000007qX0-05K9;
	Fri, 29 May 2026 16:09:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSzlu-00000007qWn-0WnA
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 16:09:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 268E2605CF;
	Fri, 29 May 2026 16:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780631F00893;
	Fri, 29 May 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780070956;
	bh=jxl9Cd1ekcjiytj6Bw9vuKytspEwY89flUAtcmDugAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mPiZKmOrsXkaUctu8xLtcMIMerVGh5L/JbNZT2E32PEowB7APOvhQ8Q2Hl9fU9CAy
	 S50d12OD3vgSmWXKW9kqsOGTsjjSObfQLsiyZ9pRtfEtpK8OEk9MpGqYMZo0VF4fvC
	 hMrX5veA7TrrclNKe6ki+lndFKOqAyl42T/5eLnyYxNC1gcnBU+tuS7UaX76ybHtT4
	 hPf9lwIj/Yk+Vm/IIAIOchlyyWVzc0NRKG5SW66k2wzjkU6jDixq58O1H0fl7l7nie
	 Yv6vsPOWFzO6EjIicSkH0xGnJAUfI1l0BZhIXBeTaBjPgv48CLyc/oVEAXKSnOUQhS
	 TOtOOOFktGz0Q==
Date: Fri, 29 May 2026 10:09:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: hexlabsecurity@proton.me
Cc: "security@kernel.org" <security@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [REPORT] nvmet-rdma: integer overflow in inline-data SGL bounds
 check -> pre-auth kernel-memory read + remote crash (candidate patch inline)
Message-ID: <ahm6Ksr3rfGdnOsN@kbusch-mbp>
References: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LM21QIR-1-qJb7PViyJKCnGBnUzizeiNJVWQ3wb7ZwGezodjgKg3f-iobqOyequ-sT1jFCKJImfqNO_BKU3KO80xFITnaI5GTV_GxLUNDDc=@proton.me>
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

On Fri, May 29, 2026 at 06:52:13AM +0000, hexlabsecurity@proton.me wrote:
> @@ -847,6 +848,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
>  	struct nvme_sgl_desc *sgl = &rsp->req.cmd->common.dptr.sgl;
>  	u64 off = le64_to_cpu(sgl->addr);
>  	u32 len = le32_to_cpu(sgl->length);
> +	u64 bound;
> 
>  	if (!nvme_is_write(rsp->req.cmd)) {
>  		rsp->req.error_loc =
> @@ -854,7 +856,8 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
>  		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
>  	}
> 
> -	if (off + len > rsp->queue->dev->inline_data_size) {
> +	if (check_add_overflow(off, (u64)len, &bound) ||
> +	    bound > rsp->queue->dev->inline_data_size) {

Since you don't use "bound" for anything other than the final check, I
think we make this simpler without it:

	if (off > rsp->queue->dev->inline_data_size ||
	    len > rsp->queue->dev->inline_data_size - off) {

Thanks for the report.

