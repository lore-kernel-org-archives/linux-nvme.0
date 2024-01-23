Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AF2C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdN4OGEpTS0uGsU1KKkjdBtCvZ45XwiePy6hOj19fSc=; b=EAbUxV+UM4ZtKqo2UZ3kqNFOnL
	LIzxSgFfPxPQfcw5ZFTO1FN4JOuj5sHq0RDTvw+bInAuhQlWHvYKzUk7d/kTFqXjcJPrIPtFiHAgL
	fT5gHW8cSm4m13BDULCeQ+GkYC2cmg1nODkiI8npDR0sMGBcmQsbyWVq1j+lRz3HMLFDJlA6X0C2I
	4xX+Qparvzosix2ZwKLeJnNikgZWBDhMS9wp7MzvZhWYgt/FS0Uajmkl+Ut8tAWoCTGvS0RnKQ+Wa
	1ldu5Ctq+BT+kmOOwQf6LydIFDfiveX/G1sttKM5nW3gaHR+M7MPzzHGEeJerkD9Rq/Jeclwb+cYK
	hGyCSVCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCf5-00FgFS-0X;
	Tue, 23 Jan 2024 09:01:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCf2-00FgEt-1S
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:01:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1105768BEB; Tue, 23 Jan 2024 10:01:32 +0100 (CET)
Date: Tue, 23 Jan 2024 10:01:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 2/8] nvme: set uniform metadata settings for ns head
Message-ID: <20240123090131.GB30773@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145659.5574-3-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_010136_633658_F97699B6 
X-CRM114-Status: GOOD (  13.26  )
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

On Mon, Jan 22, 2024 at 04:56:53PM +0200, Max Gurtovoy wrote:
> While we're here, also make sure that all the namespaces under the
> namespace head have the same lba shift size.

Please split this into a separate prep patch as it is not related
to PI.

>  struct nvme_ns_info {
>  	struct nvme_ns_ids ids;
>  	u32 nsid;
> +	unsigned long features;
> +	u64 nuse;
> +	u16 ms;
> +	u16 pi_size;
> +	u8 pi_type;
> +	u8 guard_type;
> +	u8 flbas;
> +	u8 ds;

nvme_ns_info is used for the command set independent scanning, so
it should not grow NVM command set data like this.


