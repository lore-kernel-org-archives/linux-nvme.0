Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBB5C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 09:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dAb2K+PgipG72MjmK84bzLPK7y4KVRX8leuSR41OCys=; b=jxF1VdGpPIb+fCJh2tjKSpro8D
	Qv+P8hExs7ilbUJX/clXuc+tMnKGpdrOHHu3sa7+mRTZZHN5HUXrmbeCLKxQSSfDpcdOiCFXuJRC9
	q2Ah1t/Mybk82o0UbWMugw4st6IwjUV7QEl6+gZtC0euAwuq0xkOcbfwDw358S8C58OWm4q5ux8GB
	oJnAd0VhB9uSfl9d11Hz0XpLnuJfS8Isa2dJ7APsV4aOX+ZzxGijBNVh/D/B6F2szoqdqwtAEY6IA
	pM9j3qPU8ZibPRI5rTgkcUWwa9WtEQ7vVABPKRYo6YglDmHWn29aO2eLAp7rgIQYKDggqoPqGkYZ3
	KsCvXmZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opo27-003qEW-4R; Tue, 01 Nov 2022 09:58:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opo24-003qDK-AH
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 09:58:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 844BF68AA6; Tue,  1 Nov 2022 10:58:04 +0100 (CET)
Date: Tue, 1 Nov 2022 10:58:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes
 command
Message-ID: <20221101095804.GA13058@lst.de>
References: <20221030162906.3390-1-hch@lst.de> <yq1cza8qc6o.fsf@ca-mkp.ca.oracle.com> <Y1/kw75JaNsnt1iy@kbusch-mbp.dhcp.thefacebook.com> <yq17d0gq9oq.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq17d0gq9oq.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_025808_517237_B3F08B51 
X-CRM114-Status: GOOD (  15.45  )
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

On Mon, Oct 31, 2022 at 11:48:08AM -0400, Martin K. Petersen wrote:
> 
> Keith,
> 
> > The device must return all 0's for the range covered by a write zeroes
> > command no matter what. The controller shall not deallocate the
> > logical blocks if it can't guarantee reading deallocated blocks will
> > return 0's, so I think it's okay to skip checking the lower dlfeat
> > bits.
> 
> The spec is sufficiently vague for the does-not-return-zeroes case that
> I'm concerned about "shall not deallocate" being interpreted by vendors
> as "free to ignore" based on past ATA/SCSI experience.

I think SCSI actually has the same semantics as NVMe here.  WRITE SAME
must always ensure reads return the data written using it, just like
for Write Zeros in NVMe except that NVMe forces the 0s while SCSI
is more flexible.  UNMAP in SCSI and DSM Deallocate in NVMe can also
return other values depending on the conditions.

