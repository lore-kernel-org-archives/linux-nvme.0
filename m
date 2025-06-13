Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABBFC71148
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDVwqas2rXItWPJI4kzl+sOUaiKLDBMeeiQvORFiFt4=; b=oTEsO+j/j4g/zlD8GUcTWNiqCu
	z2b1Hy7cMS7fBkwxNzvdJjHetaPJxxuG44SOVc8JV1N3z2+Eqb80HYOKqAoTKj58oj9EWdOuj+viz
	gzrxpIYVWpZQoho+evA3OJyUK7zKRx1Q/CaVKfqdEobRtkB1oSavYXR6z+IXyvvC6oPiaSlOoRjr7
	+LSXrhFPumLZma2UB6juYkJ0zQiFo6Vs739pAGMQ7DsjXM90QocoK6riColiUyNhAsQXGfzGkPcxD
	HmdVwx1D4T9PoNjPpbFiFa5qNMqs7PoA7cK0DcDXcm+PxwSvAKqUi3cD0th72yz9WXnUH3tDzn9Od
	mcaV0mmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQA11-0000000HSG1-2mrb;
	Fri, 13 Jun 2025 19:24:39 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQA0y-0000000HSF7-2mUa
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 19:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XDVwqas2rXItWPJI4kzl+sOUaiKLDBMeeiQvORFiFt4=; b=gcnYpAAK+a4AFF0G61kumeLRKk
	cW8/VyBH1nG7R9TNwvI9dC8FE9M50dSssPFwUp/MZUUFqltX3duMp57nf8kW9daItghZPAjXcCKes
	/wqEO0/WSPbABuQ1415ySgPZSGTRIgt60fCQwYOu9SJ9ZBH5TnZfMW8Ci2tLU33Aon1k0bG05rQBv
	HI90/SIWx4N5G8FH6BbcK/6Ip5IRcZI0/Vy/i6VD+iU0AirERXsMINbBqtKsK7Qn3rc+o/8w3facQ
	2n7Rcf0pw5ekqNk/lMBT13H7NaEk3JUlxpcYMpid0fv4dRS5RWt9GUjtL2bW7wdd5mqsnoh5GDL3F
	nDTnnRMw==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uQA0p-003Avm-Av; Fri, 13 Jun 2025 21:24:27 +0200
Message-ID: <f0b5481c-2a0f-4343-80ed-8e7e1f081767@igalia.com>
Date: Fri, 13 Jun 2025 16:24:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme-pci: refresh visible attrs after being
 checked
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 Eugen Hristev <eugen.hristev@linaro.org>
References: <20250613192102.1873918-1-andrealmeid@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250613192102.1873918-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_122436_701125_69FE56BF 
X-CRM114-Status: GOOD (  20.70  )
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

+CC current Eugen mail address

Em 13/06/2025 16:21, André Almeida escreveu:
> From: Eugen Hristev <eugen.hristev@collabora.com>
> 
> The sysfs attributes are registered early, but the driver does not
> know whether they are needed or not at that moment.
> For the cmb attributes, commit
> e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
> solved this problem by calling `nvme_update_attrs` after mapping the cmb.
> However the issue persists for the hmb attributes.
> To solve the problem, moved the call to `nvme_update_attrs` after
> `nvme_setup_host_mem` is called, the one that sets up the hmb, in probe
> and in reset_work functions.
> 
> Fixes: e917a849c3fc ("nvme-pci: refresh visible attrs for cmb attributes")
> Fixes: 86adbf0cdb9e ("nvme: simplify transport specific device attribute handling")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> This commit was reviewed a long time ago but was never merged. This is
> just a resend rebased on top of v6.16-rc1.
> 
> v1: https://lore.kernel.org/lkml/01020191b7b7adc0-bca16d06-b051-4ce2-bfee-c8038a62462f-000000@eu-west-1.amazonses.com/
> ---
>   drivers/nvme/host/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8ff12e415cb5..320aaa41ec39 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2101,8 +2101,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
>   	if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
>   			(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
>   		pci_p2pmem_publish(pdev, true);
> -
> -	nvme_update_attrs(dev);
>   }
>   
>   static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
> @@ -3010,6 +3008,8 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (result < 0)
>   		goto out;
>   
> +	nvme_update_attrs(dev);
> +
>   	result = nvme_setup_io_queues(dev);
>   	if (result)
>   		goto out;
> @@ -3343,6 +3343,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (result < 0)
>   		goto out_disable;
>   
> +	nvme_update_attrs(dev);
> +
>   	result = nvme_setup_io_queues(dev);
>   	if (result)
>   		goto out_disable;


