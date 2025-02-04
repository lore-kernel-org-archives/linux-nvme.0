Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DDBC0218F
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 05:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmLeAhdHEklpDbbrCNixb8SyFo9yuVTbEhpv7okyZi0=; b=i95PXg6MDviWI/YN92mzHmEpdb
	mn4S6oo6xPFd1wzWtOyZC8KPhigi5kumBpgHwtdBxs7dicBCnjEiFMhVV8UyEYSXOSyQGeq7N1X4r
	71zHSpWnCerPxaoIVT2nog+F64fqC3UWYM4hYnNb1FbTfFmRC4GM71xWrxd8+QGetb+3UyQTWd35K
	Y2s3wMpZqwp1Td2db7DWmwiDyg3IscOOPfEXo1DnEO7PpVVg4t0z50wnnZNZzkD9bI2uDAiWKsZGK
	vUpReMdfK8UvxmcDahF2vxk7xpUzNPwXtmpvarr7M6wolrTc8dOWWJLfv3C422r3Vb4gqq/JRkdLR
	1pb4a6OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBec-0000000HIGH-14cI;
	Tue, 04 Feb 2025 05:39:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBeZ-0000000HIFu-3Ozw
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 05:39:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D43FC68AFE; Tue,  4 Feb 2025 06:39:14 +0100 (CET)
Date: Tue, 4 Feb 2025 06:39:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v11 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20250204053914.GA28919@lst.de>
References: <20241128112240.8867-1-anuj20.g@samsung.com> <CGME20241128113112epcas5p186ef86baaa3054effb7244c54ee2f991@epcas5p1.samsung.com> <20241128112240.8867-8-anuj20.g@samsung.com> <20250203065331.GA16999@lst.de> <20250203143948.GA17571@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203143948.GA17571@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_213919_991321_A12DB4A1 
X-CRM114-Status: GOOD (  10.99  )
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

On Mon, Feb 03, 2025 at 08:09:48PM +0530, Anuj Gupta wrote:
> +	if (bi->csum_type == BLK_INTEGRITY_CSUM_IP)
> +		bip->bip_flags |= BIP_IP_CHECKSUM;

I don't think this part will work, but it's a bug since day one of
the nvmet PI support:  NVMe doesn't support IP checksum, but in this
case we'd expect the remoe side to supply it.  So the setup path
needs to check for a support csum type.  I can look into that as a
separate fix.

We'll also need to set the BIP_CHECK_GUARD flag here I think.


