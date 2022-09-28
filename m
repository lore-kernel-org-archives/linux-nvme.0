Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F535C6FA8E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=; b=IrcipnZFS5PQIplueyiwnnDftK
	5UBMZgCroLSdiDWiqd/l2LuBVTeicD2tVO4j2OY8XiH0vF0KlV0nFsT58G99x4flYi3wiHkPVIRZA
	YKK9PUo/1rEAho6Lr5WEg3kmWeOtMrzS3AHhoDaP+7gsX3bxMgwcMtpq1m7TVpfLsTNajbiZXIuBq
	SK/ylU3bynJtXu98yI9nsBafymQnZ+ytnDLZGXJISmZf2fMvdKrligSe5vkCD/CSL57kB2e9x4Mni
	dwLox6gwHFpdwX8FAQDwT8+6phbUB4gR6+zFjy1MbkL2Yey6beGe5H3FAB19nPBIjfLZDxj/j5v9B
	lZjSR8/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaVF-00HGPL-BH; Wed, 28 Sep 2022 17:05:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaVC-00HGOU-7p
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:05:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C873C61F42;
	Wed, 28 Sep 2022 17:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CF0C433C1;
	Wed, 28 Sep 2022 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664384741;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDgKAr6Cw8wkQ/wI7lEfXnYGOfcCSdu7c9xghoTABGB1xiSss1RLGDAPU3DlQAyEY
	 i+q/2lIILYrV8XVcgzQNNxLgNqVsJ/Gd61DXg6tKxU/A3jPhsZhN/i6/i65lMNr9ER
	 YU/tYAXrviHWVjWjKQ9YQrDg1ENN6AlbHO/NjgVoIkheZvU3aewIm0GjQEI/LTH4bm
	 u8NN/T/dAOSv6yhJNmBNejex+1DRh6o9h+K2VVNU6YkXfZhrMCdeFophjOJbXz6An7
	 n5enakffflHC1vGL2lMeZ896OclKXGTjf0cf34T5P/+EsEELoAhP6Zq90trD9TlDwt
	 KkkSVa/bz6Pog==
Date: Wed, 28 Sep 2022 11:05:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHSET v2 0/5] Enable alloc caching and batched freeing for
 passthrough
Message-ID: <YzR+4mVQCnI26Ew2@kbusch-mbp.dhcp.thefacebook.com>
References: <20220927014420.71141-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927014420.71141-1-axboe@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_100542_337869_6D928B99 
X-CRM114-Status: UNSURE (   6.89  )
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

Series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

