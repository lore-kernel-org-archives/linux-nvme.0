Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF97CD74941
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 21:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uo/Grnf1xDkukUPN+lDT1TFP7oP3wm+fEsYVMRQ1ey4=; b=XPW5OtTOCPWgFXftt9QiNJvc0f
	mtrKhIq4HeI8otlFJaUNmyOEcfszRR8qhbPEa+hUqQBBHXOaooXFVp/NhVM2B7R2Js/yTSxXE9DL1
	l7+d4SPdwbUyo1BuhHODs25MAbZvjEyYUHZSPUtm+c5KvycbnCcsFxOVWAtrqJyGDaE++njW56gSj
	SnVwRkmX9PG1fmOr5jAYIZ+1Unp+qROwFlVMehYu1RN7q2TsuwbfhzcAV7bgcjnYL//JUNQ3tk1rK
	bsDruODNX6LDVEAYJVOoWqVVc0eVj+X58jt8OQI5dZs7MN2UGKqJPZlgk1hhX+Z/81cnWrtqxxqYa
	fYEUG5eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5u8v-0000000FzVV-3nVT;
	Tue, 29 Oct 2024 21:52:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5u8t-0000000FzUH-1TOE
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 21:52:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9267E5C1028;
	Tue, 29 Oct 2024 21:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FE7C4CECD;
	Tue, 29 Oct 2024 21:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730238766;
	bh=aQ4snfpqU8/cP5h4360AM/aNhQUoNlVkuZ5R6R5m2QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jd9mHMteIVmcMbTaE3uwEugAGddfJddGcYP16SY3RjAJbJTHVVyuEpJoA8haaDdeV
	 MbpBDStbLtcbFjfL+MfXyB4/Wyb8YVufy6WdIfNab2QLmbU1tL3LJSOs2qc6rNkqVt
	 3NnEe9/aLQ9mOc0zUcM6jmP3Yw+nLMsDtFELguWmSjqBZZhbCicBnV6i7tbgdZ3bMW
	 uGbGq64Z02SpC76xDyfd8h36MIz7LoAinxHMf06p91m/K5FdUvuT9S27GwXg5rsHke
	 L73fnEIM2MuntOef2uFX5WwjmlpJFgbIo8kfAtEf61LFPxGux4oAaCTkyGa9ty1zm0
	 uYl6HV1LYpUiw==
Date: Tue, 29 Oct 2024 15:52:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v5 10/10] block: add support to pass user meta buffer
Message-ID: <ZyFZKmM5ALFaFGRd@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029162402.21400-1-anuj20.g@samsung.com>
 <CGME20241029163235epcas5p340ce6d131cc7bf220db978a2d4dc24c2@epcas5p3.samsung.com>
 <20241029162402.21400-11-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029162402.21400-11-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_145247_451900_7513D074 
X-CRM114-Status: UNSURE (   7.60  )
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

On Tue, Oct 29, 2024 at 09:54:02PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> If an iocb contains metadata, extract that and prepare the bip.
> Based on flags specified by the user, set corresponding guard/app/ref
> tags to be checked in bip.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

