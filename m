Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2723E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPg5sYQm9+jmtOYCZMxCByTJ/7TJMgPN4aH+b4uuEsA=; b=fYSOj7c0sZh2NdN7/xniMUmfp0
	SAWK06lmoCCYIzGbJ661mpJFsUorWC9pk8CjSnvFCc+k+yGZLz852+BTI2xDN6SLEnik43Np/FPMZ
	n8QQy6TOBqHlqyT7wNPx30Op0TqLYVL2KHFFsk/FKCFC/nq2h/m7bys1mlSghywiiG/vb1QMfNfFh
	r+uFZI0ioEh149w4oAqGaPl1jAhDTrTZWJp312jX9oYBIu3UNwuILgsE2sgyqioAIizy5TWGeNQlI
	ODxHahLnkOIynjGb+6n02PDnMEHIWk+gVLfzenBa078gW7fG+TvQnIdxokKGtcMB9GzTmVXsdQZEc
	HPrEj5Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBoV-0000000Eqw4-133P;
	Fri, 10 Jan 2025 10:00:23 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWBms-0000000EqiL-449q
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 09:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cPg5sYQm9+jmtOYCZMxCByTJ/7TJMgPN4aH+b4uuEsA=;
  b=tEEO6rKC4QfDmhqbFuybh68EbcKj8jI1CJ4Nxx9qFFZfEmQtWb32rHeo
   4hs3zowvKfh0phL2/LzXc9FB9obrtQM7IuwRlA26KYavXO2IzFUYrQqiM
   2HKpGRPh2UNrM6+JzZQntqR5WRGg5CRNahp7DL9zEe8ViBVzAVhayKdJP
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,303,1728943200"; 
   d="scan'208";a="106000245"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 10:58:35 +0100
Message-ID: <0452bf0e-ae67-4a93-8f00-10c3e82d49f0@inria.fr>
Date: Fri, 10 Jan 2025 10:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: Add error path for xa_store in nvme_init_effects
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20241216152719.17923-1-keisuke.nishimura@inria.fr>
 <20241216154916.GB23786@lst.de>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <20241216154916.GB23786@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_015843_400717_60784D74 
X-CRM114-Status: GOOD (  13.06  )
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



On 16/12/2024 16:49, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 04:27:20PM +0100, Keisuke Nishimura wrote:
>> The xa_store() may fail due to memory allocation failure because there
>> is no guarantee that the index NVME_CSI_NVM is already used. This fix
>> introduces a new function to handle the error path.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


This is a gentle ping. Please let me know if there is anything I can do:)

best,
Keisuke

