Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFDCC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 23:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=17ll+gDdni8FyOYneoWDF+P/cKGFRaceVETlU31dHJ8=; b=EwR1QFJxmvceBZBhcEbcTFiJ8k
	ZaKacbo086buymLW1GvkjD5knbYhIklmMwrLPKwHqa1j1TyWuqbSfsqz6aqiY5MzUbir1CNW463e9
	/CeS3Lm/AV24vYy/Ww5IuL/01EG9tuZGBBHY5GE2r+AXAMYcItGntMqMQ0Lmv8a2qwz+3ON2U4fZw
	d99Jm490fKrtrlYp0V+OYw/r4KiBMer8Bn2ToMkwjDBNim5YbXR8qQUcaQ6yCNjm5kz6jxGJqWJp0
	xWWf8/ZIoRX3Prt/g9QkqmX0MhgVD8ZwDYNc+9naJzLyJqe+v4ollHTIk1e/3zf2NfdDoUwLHWhvX
	ZefdESoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubp3c-00000006PAY-0CKq;
	Tue, 15 Jul 2025 23:27:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubozC-00000006OoP-0pwY
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 23:22:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 96E5C5C6694;
	Tue, 15 Jul 2025 23:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4044EC4CEE3;
	Tue, 15 Jul 2025 23:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752621776;
	bh=j1LB/sQmMIlG0zz2sXx8WmnMUfDTKW926uCb2WCG+s0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lPWdbcvUlzY1C+zDUKuNlaBRYqRppGCR75JNewSjs70MzRVuBJA0YZhZeojgnnUzG
	 217WE6TPyjuKgUVJcbYHC7L7jtROkocjwXrU/sGWVIxkwH5UNnlrNp3YmBKgVaCT50
	 VmnFhNydiTHs0ja5RdmKFfQZ0VozH4z24+4o1eTKOxqktakkLA8L1sazea/hd+tYdS
	 pxTNDUuv3XPT+vIcesvyYnOZNfU0bLIS6l1PmRE2Mx/lrKCubKHjwUKymFbYvGvA/E
	 6yGhYwjQjXOb/S/cREcFOfLvPZq7Cb6uxWJsEulXSovvtH8t90pEao3hW1w85jmAB+
	 ryaCAhJTjO4xA==
Message-ID: <5c038378-dd65-4a4d-9a5b-d3604769b658@kernel.org>
Date: Wed, 16 Jul 2025 08:22:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: pci-epf: Do not complete commands twice if
 nvmet_req_init() fails
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_162258_282159_9E306220 
X-CRM114-Status: GOOD (  13.81  )
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

On 7/15/25 18:18, Rick Wertenbroek wrote:
> Have nvmet_req_init() and req->execute() complete failed commands.
> 
> Description of the problem:
> nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
> e.g., unsupported opcode, which calls the "queue_response" callback,
> this results in nvmet_pci_epf_queue_response() being called, which will
> call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
> different than DMA_TO_DEVICE. This results in a double completion as
> nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
> when nvmet_req_init() fails.
> 
> Steps to reproduce:
> On the host send a command with an unsupported opcode with nvme-cli,
> For example the admin command "security receive"
> $ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096
> 
> This triggers a double completion as nvmet_req_init() fails and
> nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
> in the default state of "DMA_NONE" as set by default in
> nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
> Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
> called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.
> 
> This patch lets nvmet_req_init() and req->execute() complete all failed
> commands, and removes the double completion case in
> nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
> double completions occurred.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Forgot: this needs a fixes tag and cc-stable:

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org

-- 
Damien Le Moal
Western Digital Research

