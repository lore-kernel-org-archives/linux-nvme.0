Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B06E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 11:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iYa4iUKxanDPrA2BK7M4kRo+YewYRaYm6G+NxrHHhmw=; b=TeTjLaDs99moVR3bP2lrDqgvYu
	DIl5nhSIvYVUw/2/gR2JVDABH0Cv5spgqroCx5C5deKSXdQ88cVfTBMygDJ+5AP4DZFUkVp5iGWG0
	5b0E98ej4SAkMp4kvzOWTNX+sHAyfVxS2eleB3zd+Z9nXUaXT59RkC+sD0mqp037YFduhGqC8YaUA
	WRbj8L9uu8dn2gJf6t7TdoRtzGOlR8hr83kY0AgpPebwKhj297IRNTJuVoWQwF5xoq9mMYhMRZTLr
	s9ro8wo2ws88WsgNBUTpDZlm7TTf3QNLOPVD8PdHMMNUmUAcuwKsd1qGgxZGP1/of/MNFLb++nm1z
	GGbdry/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tObWf-00000004pGj-1JwM;
	Fri, 20 Dec 2024 11:50:37 +0000
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tObWb-00000004pFx-3cPp
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 11:50:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iYa4iUKxanDPrA2BK7M4kRo+YewYRaYm6G+NxrHHhmw=;
  b=b60p9KvKJ+iUORaED+Qvz4GesRRfG+uJK4iKuXkAlg15glb1Ajio/zA6
   sjXcqCPRCGijrLONKFKgBzndoMGRIeZUQEWxS+PtHACAERwZATQ6C+gTM
   jEMNxQRiLHb+MKzbMRw7tNF5jCv+QAhhkeoGcQCkBoB8Uagg9Ix5j0ni1
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.12,250,1728943200"; 
   d="scan'208";a="104871699"
Received: from dt-aponte.paris.inria.fr (HELO [128.93.67.66]) ([128.93.67.66])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:50:26 +0100
Message-ID: <975c1801-4e92-40a6-ae91-80ca2833c01e@inria.fr>
Date: Fri, 20 Dec 2024 12:50:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Allocate memory for xa_store in advance in
 nvme_get_effects_log
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241202124239.49894-1-keisuke.nishimura@inria.fr>
 <20241212062749.GA5718@lst.de>
 <d0b96f78-7538-4bf9-acec-711e3b0b912d@inria.fr>
 <20241216155229.GC23786@lst.de>
Content-Language: en-US
From: Keisuke Nishimura <keisuke.nishimura@inria.fr>
In-Reply-To: <20241216155229.GC23786@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_035034_307404_AB6C427D 
X-CRM114-Status: GOOD (  14.80  )
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

Hello,


On 16/12/2024 16:52, Christoph Hellwig wrote:
> On Mon, Dec 16, 2024 at 02:06:50PM +0100, Keisuke Nishimura wrote:
>> Without this xa_reserve(), if xa_store() fails, we cannot store cel after
>> calling nvme_get_log() which can have side effects. My intention is to
>> ensure xa_store() succeeds first and, if not, return early before invoking
>> nvme_get_log().
> 
> While reading various log pages can have side effects there shouldn't be
> any for the Command Supported and Effects log page.
> 
>> But I am not very familiar with this code. If it is okay to check after the
>> nvme_get_log(), I will send the patch soon.
> 
> I think it should be fine, but I'm happy to wait for more opinions.
> 

Okay. I do not have any other opinions on this:) I am happy to follow your 
suggestion and leave any further decisions to the maintainers of this subsystem 
if needed. I will send the patch to directly check xa_store() soon.

Thank you.
Keisuke

