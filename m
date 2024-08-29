Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B6CC7115D
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 04:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nf2gbwERMDJqs8rnCKIOIi2IKem0YYz9oFEMU5wDj2M=; b=CNh3b0IPQQg/tLV0Hum0zhqnQ7
	ejF60smTPeYudKAOvuTvadfNlVbHHhnRDDTM6d4GNgItHBzEqDPRYACyZhUU7QFf4TGz7FCkyfHHe
	pM2qqyVU1Djdv6H076FNnrNaLlPEEX9u3LCuYcXTaxZPOCVEKgRW4Bbv3YVmu2qQH3AFQXDZ7G3Pw
	9F4s5+ZuNb5nP+BLwgYegiIZuU6HmH9DwM9QHz/ff5OmObhANchIPO40DfOV3pQShARj6CEYjqIi8
	v3XO1wMY8J2asIe272De5g8ls25CDJmbkYxH3Jvj0QDA0e0AFX5qlDG0ZH/GC7ubDdwcEmZYshTBo
	G2fjHq7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWQl-00000000Rf5-2Gtw;
	Thu, 29 Aug 2024 04:06:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjWQi-00000000Rdv-2LfL
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 04:06:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1047768AA6; Thu, 29 Aug 2024 06:06:38 +0200 (CEST)
Date: Thu, 29 Aug 2024 06:06:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk,
	kbusch@kernel.org, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 07/10] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20240829040637.GC4211@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com> <20240823103811.2421-8-anuj20.g@samsung.com> <20240824083553.GF8805@lst.de> <fe85a641-c974-3fa7-43f1-eacbb7834210@samsung.com> <yq1plpsauu5.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1plpsauu5.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_210640_762443_46DC9F66 
X-CRM114-Status: GOOD (  12.37  )
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

On Wed, Aug 28, 2024 at 11:16:53PM -0400, Martin K. Petersen wrote:
> I thought we had tentatively agreed to let the block layer integrity
> flags only describe what the controller should do? And then let sd.c
> decide what to do about RDPROTECT/WRPROTECT (since host-to-target is a
> different protection envelope anyway). That is kind of how it works
> already.

Yes, that should easier to manage.


