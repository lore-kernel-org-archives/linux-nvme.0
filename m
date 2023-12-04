Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFBFC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=; b=zjODGmKtfq0KmqO3uYHHFTYT5n
	P85LcWRs5Ossq4tkjlNA4vnr11vxgUSQ3ki7S9rNyU0dmUwBxyNcQiLOQZwnGRnXkBLRcZEXnC9h7
	tVznoZm8LhdoDNveE3Z3Gcm/WFQLiA8xueP6Xuaiki2GGeSaO+xr42FI2xGk4/IE4d91j8dqDWadR
	Jv9pNFraiURh/565FRDa3DBibwBDX9sosvvq5kctRxOFQx64+mzEpOeHZuEuDdr6R4nhAJPkkt0wX
	hHTpJPeChtmCxO4m8i3OM4votPBb+0yLvgG9c6xFy0t3uNiyqUEbM7oieUD0xaA3CUTSRToG/rB0N
	XurEzKrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rABzI-00574w-2P;
	Mon, 04 Dec 2023 16:40:04 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rABzE-00573w-2j
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 16:40:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 893CDB80EE6;
	Mon,  4 Dec 2023 16:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155FC433C7;
	Mon,  4 Dec 2023 16:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701707998;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADzcMsE2i2UTU0caND6AJ48een6qtYHlZ08l67jA0rbDO38592PF1AwSIHbq9u+mo
	 ow8TN8FJDi+dzAyGAVDDxle3l6DQVZMho5WFM2iRWEIOvYnVAzOUGVSdHlm67vsIqn
	 9k8TevJrjx6uyj7saxRakfzewKhWKDgTZwevmt7we8wc1lWSE1I/Szg63K/PtriTUX
	 SnxzKimq/C1yaLP4nlPlEInd9YM06LTzARJYd0nqRtnGZb/fv9r3Zh7ePdlmwqrxMY
	 T5yS1VYsVwRdizmdD+/Op/rSxAUrfmueViSQeNdbyZwQrBpbxzIYxKiuQmHaM0SJXy
	 JEIQMRPSQ7SkA==
Date: Mon, 4 Dec 2023 09:39:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: sagi@grimberg.me, axboe@kernel.dk, hch@lst.de, kanie@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix deadlock between reset and scan
Message-ID: <ZW4A27UR95CqtlLt@kbusch-mbp>
References: <c47a0edd-7437-4c21-b7cf-f969ff85bf78@grimberg.me>
 <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701310417-301-1-git-send-email-yaoma@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_084001_124105_E70EA153 
X-CRM114-Status: UNSURE (   5.77  )
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

Thanks, applied to nvme-6.7.

