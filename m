Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F05EE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 07:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43HwQZGhOOSLPlaFr4xzxr8TOncaKd3jBHzEVGWUiNs=; b=Iu2hf9L505BmHze1S/eC4/Mlij
	aDEUGT+h57IVcAqVYcFuB72r1jqouint/zBJzrwGCSVlN8OxHDTYPXOtCRpjMiX190pKrkyzliIzv
	6hbe39/09zkUd72vEAFNXYaZZEQ4VmMvZBd/ykiXZ17tcT9DVaSJ+ZeK5V+oIDZX0hATOvKXiE5da
	HpPyjW29vA/0cpYQGKK7ozhWXJLB+0S3Wg8lo5WnILbsgBHhuie+5GsxaWYnCzUFdfHBvgmlWnHOc
	pvgYppYrxHT9NBC7lmdf5yR7m1a+4nUwWmF4s0ks+LEt/33ZT6fukjyuTncQMjxVz0SRQ71nzydfF
	JpJKBJNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLdnE-0000000HAvd-00M6;
	Thu, 12 Dec 2024 07:39:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLdnC-0000000HAv1-0j2D
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 07:39:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 69E915C53E1;
	Thu, 12 Dec 2024 07:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0052BC4CECE;
	Thu, 12 Dec 2024 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733989163;
	bh=5hYl/Xu1OA36+p/FnNeDP1k7XfWgUi+CZGQAOH0bNMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PndvLKtDKKLajr1UThXYQPW8d2e8aNp+Km1v5+lsPHcSv/WBr+IGXl0RUXrvS5+wY
	 k54aajjCdmnJ+TGgebancIjC4Eb/Yo3u13lVd1EYoY+GtTcs7JhpYGBesfiNoJ6eMP
	 M0T85pCsUPeQqDdP7eCsSJvNGQd/is/dz30jF3s6UXoZKjhiC8MXOhd/5fRApy2P7b
	 A9v68g8Wu0zbpom2KUgwll5fKh75oXVQrGfCcxdrSlVcZlqas2VnUrbO16YkPN3J8s
	 wnbUUU+jImu4pvxsohyZ0sPC29gXvrqs5PJQKM+58Wpv5rXLtiOlqRMQhZtNAumOep
	 cKOT1QI+ZYHHQ==
Message-ID: <3ca32224-2978-4590-9fb7-152ede734fc1@kernel.org>
Date: Thu, 12 Dec 2024 16:39:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] NVMe PCI endpoint target driver
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241210093408.105867-1-dlemoal@kernel.org>
 <20241212060648.GB5266@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241212060648.GB5266@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_233926_268891_E4ABF90A 
X-CRM114-Status: GOOD (  10.11  )
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

On 12/12/24 15:06, Christoph Hellwig wrote:
> FYI, this looks good to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks. The kernel test robot signaled a build failure that I need to fix (not a
big deal) and I have some typo in the documentation too that need fixing.
I will post v4 with these fixes.

> 
> But I've closely worked with Damaien on this, so a look from someone
> who is not too close to the work would be useful as well.
> 


-- 
Damien Le Moal
Western Digital Research

