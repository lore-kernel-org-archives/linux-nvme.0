Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EA9E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JW1VtRFWPaJpEt8UVihn5X8dVIfv8LC65PPfdvnNNeg=; b=ExwyufjiV+APl1pLWI+4w0ri4r
	fq+1FFpV7o8kKYJFnboc08eDVrpPHI1FQYs/q4fn3UOh7mz5EGR4jx/6VjGa1kklWRyz9N4dGcP+P
	fGN+B5bJu8dxLSFnm4zoRq0QHRaHaxqTE8qdBYQy09cOJRuSxDi/jqOcR8H54kY8NU/EhyHQ2p++d
	8harobI75mgMw/L47RnfwlWe+gxu9JR7LdkDmxBkewoR4SaFXDJ7reauYGRzXLuYC+BKgMrcyJWR3
	iiz9YTW5fziWX/TAEwYqVEDCJYUDDdZN4/cLmjk7klMNYeSGqrJiL4V2GHr2gd15Ig4/v0r+XpibL
	EFJLtdwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUlgN-000000016cD-0Ndo;
	Mon, 06 Jan 2025 11:54:07 +0000
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUlgL-000000016bc-0lJZ
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 11:54:06 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1736164439; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jpDG73bUnfpKOCVuATlRPyTP00AeskNghPD9tA9RpOeeprqmMCiENq54CdOBC2yU52a61lNyaoVdwmNqoswEW3QATCozQyHXPjuHre+0yF1l4axDHZjG6GBnyn0uudGDVGAycP2GU03tATKXFug37RXd0t0KwIS5DmEeaUk/I18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736164439; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JW1VtRFWPaJpEt8UVihn5X8dVIfv8LC65PPfdvnNNeg=; 
	b=bmetOWV/tgZ0kwuVugeFkviA8/mMrqssFLGxiAdvn4PdJlH81FnykCljzS6EyZiSNmGeTKUyfZQR073FR99dVvuz1AmCDytj4sdDkGxVRdl/IjTVKqmlHjvOaaRT1WRu8VokvfyJNt8SRYOjDK9auBjepYY+smfbFsA294b1nYA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736164439;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=JW1VtRFWPaJpEt8UVihn5X8dVIfv8LC65PPfdvnNNeg=;
	b=VLgws91D21wfIG0xsUt0ycwNXcXo2TpHocuQ69doHcv3lnrpcQErTVxN+vhvNs8O
	67jbX3xWtB07o21rJjDvMMl40g8xzQr88/7WbHAI3u1xgQy2Nl42UAItTtoy+uHhs7Y
	rC4sVeRS4n2CNCPGdZE8CBnjPyG1b1sVejMq4jS0=
Received: by mx.zohomail.com with SMTPS id 1736164437798373.2326926896716;
	Mon, 6 Jan 2025 03:53:57 -0800 (PST)
Message-ID: <2abcf14e-4b32-4896-92f0-c5a4c0b4f772@collabora.com>
Date: Mon, 6 Jan 2025 16:54:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
 Eugen Hristev <eugen.hristev@collabora.com>
Subject: Re: [PATCH] nvme-pci: refresh visible attrs after being checked
To: Christoph Hellwig <hch@lst.de>
References: <01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com>
 <20240904041057.GA13313@lst.de>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240904041057.GA13313@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_035405_298756_0C8B643C 
X-CRM114-Status: UNSURE (   6.45  )
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

On 9/4/24 9:10 AM, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
This patch is isn't present in -next. Please have a look.

-- 
BR,
Muhammad Usama Anjum

