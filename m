Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63C9CF9C6C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UR+IeCjJEZwHlkYBtGkoMCOZPiyBgfCOh5KTAUCXMFc=; b=txqEFaPdSyO2nY8nWCG3cRROkQ
	sDuQUzSQW+LV9qx440D/S+46rzBop+GAGlkCbU3NSds9MnMfXowvQOIblxE1DO/Pd+p5gFIq8t/wb
	XIQNfzVAlmDCgj1SHEnLFam7vobsE9gCnvNSaFj2/TxTTiTJXKGX9b/eyUqexAxOltL9ZCqHtgDQ5
	cvq/eTTUcEWwHT14oS9660AYUIa9mSWnzyRvrsPK+75tJpZ/RNoxnmCP0q7g5LgP5+6/PGqQIB1bM
	1Rn/NmgIb0A11Vgp4f460YryXsxX6EQJTp0DUda2qHaGFeH8YkwaRj6jKVjU0P0xXL0+Ews6HeFDB
	wghbVapg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOWO-0000000FMJw-3xJn;
	Sun, 22 Sep 2024 15:29:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOWM-0000000FMJM-2HyU
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 15:29:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CCE775C4029;
	Sun, 22 Sep 2024 15:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D6CC4CEC3;
	Sun, 22 Sep 2024 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727018949;
	bh=UR+IeCjJEZwHlkYBtGkoMCOZPiyBgfCOh5KTAUCXMFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDuGVUOKmCvyfTeEFt69MpyxdWeRZ1iolKhAPUaE+jHeE9TwijnOSvrvEqeg+0ydt
	 P56QrhsBdOYE7g4GNPSH24xik6O38MxPMcRWONL1lrg4lULZEAFVoeKvrX4QN1lAi0
	 kukMwLXJaS0cX5ObXL7IwkzycnoRFSzW3RDrBLK/+zfJxWe9IpcZiMw4wZ3TZJYemg
	 5t1sH4DYtkI4I7zj9IRtqZ1de7/ppqG8jpWMQCGKAFJrzAmn5MqWoCjf9/uYgRWjvD
	 KKl3mXgP5SfL1x3htUdVsHvTzg4Vpk5xKDVoJqDy/+42dA/40xNxyhylIGQF3fdQML
	 AZv73hqR7ECJQ==
Date: Sun, 22 Sep 2024 17:29:05 +0200
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-sysfs: add 'lbaf_index' ns attribute
Message-ID: <ZvA3wZAvZlhxfepT@kbusch-mbp>
References: <20240922053850.5494-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922053850.5494-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_082910_692284_6D525ECC 
X-CRM114-Status: UNSURE (   8.94  )
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

On Sun, Sep 22, 2024 at 02:38:18PM +0900, Tokunori Ikegami wrote:
> The lbaf_index attriute is needed for the format NVM command.
> This is to reduce the identify commands to get the information.

I'm not sure how knowing this is particularly useful. You'd have to run
the identify namespace command anyway to understand the significance of
what the index tells you.

