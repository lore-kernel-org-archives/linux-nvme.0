Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7180BD2CE0D
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1VSEwcWkZUm4cUXiXeATw8HAkD3oh2L9egSoF1acww=; b=EMfn5zhJwlslBNcwc8Ai4jzgDG
	PBV5O/YkACW82mMJ+2ptvaPpsXpiO4yGKelShitPtqK8XzF05YO3WyvwfGXbPg1si+K91DKMw/gYP
	FhlnO5nIC4v2g3wA2eIm8LDQX4uNXDb4CYb2H63CP9LNcSRmhR///8XxW426j0H2hhjHtsftNKvoy
	k1tOxKqpvdbkX0BOL4Hy+UiwuicsDce6+VRh2knkzLF2ge1m/JKVmGVGEBYibL7p2hgbbn/+sI5p0
	VegkrtHJ7QyJRcrI6MHmOH1d+tk2TFtoS+B/8lfCCUPNmkOuAOXZ5TaxBViw+hwFIidngTMg5r7PP
	2lL07L3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3J8m-0000000BkTb-20RE;
	Tue, 22 Oct 2024 17:57:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3J8U-0000000BkPc-21t4
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 17:57:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 82F65A4446B;
	Tue, 22 Oct 2024 17:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4E3C4CEC3;
	Tue, 22 Oct 2024 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729619857;
	bh=m1VSEwcWkZUm4cUXiXeATw8HAkD3oh2L9egSoF1acww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J/xf9q4yrBFFw3jWO+Ih0oF3p5kQB1EoG/MFBSVEWDK+spZ+xMzlZdv4uqDCumVT7
	 XudyyE1UrbAzYM0PeHgu1UgAt4+RHPQxyZpNG8K+8tsyIrkNu7McpQEuoJeSDHcPsE
	 ep3XIY54QTVsqv+I6G5gA0yQBzQbpE3dB1uUahnHIEIeLwlQpNI4KVWl1iKh7hMYXJ
	 IOsvMnm6PAh8AvmHuEZS0jphpMOucHc86Pyra0UKmYi6YWw7Bc87LsD8YRg1uEHNN2
	 OiRgSaBCqf0GHmYFG17+lwYp++s9nAHrOalTg3ItcOHbmaTJK09xJF3GRVD7NKIxyS
	 5h0JVj3Wf5Szw==
Date: Tue, 22 Oct 2024 11:57:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
Message-ID: <Zxfnj3HwRjZpHTHa@kbusch-mbp>
References: <20241022163504.10738-1-ikegami.t@gmail.com>
 <ZxfY2IT15o_2vTZq@kbusch-mbp>
 <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
 <ZxfiADxyL-uZYgBf@kbusch-mbp>
 <d38404e8-e01e-4dad-99f2-7bce3a68bba5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38404e8-e01e-4dad-99f2-7bce3a68bba5@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_105738_613411_D74C81AB 
X-CRM114-Status: GOOD (  10.00  )
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

On Wed, Oct 23, 2024 at 02:51:16AM +0900, Tokunori Ikegami wrote:
> I see. Thanks for your explanation. To make sure let me confirm again below.
> The nvme_ns_has_pi changed does not use PRACT as mentioned but still is it
> not okay to change the function only also? (I could understand as
> nvme_submit_io() uses PRACT then it does not work correctly as mentioned.)

The function name could be better. It's just reporting if the namespace
format supports inserting/stripping metadata, such that the host doesn't
need to provide it.

