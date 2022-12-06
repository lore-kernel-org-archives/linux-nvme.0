Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94C9C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UU8AMEdCApUKn2yCNu179y3IuDBUbfO2XN1Qp+qLAs8=; b=jmjmI0w2uygQFlCQWdovMqzHiB
	5eMcOhlU2sAPV+wyT/7CdljZze5PVaUcW2/qwXFWPKzthF5E2XK1S/OTBYHqhmKJdX9AjcpM06ipB
	Zci9Ian/6EiHQs2EjOXgukkyIviTVBzQt5LAh7R90hgdw6i1nN04of0JwK+AGLW9xTEZFYbmTIX+G
	uIVtcuFj2cgaYMSFPGS3p2aN6JvgMr/xUhEn9ej1A0JgvUPgL5vgpWOEYRJ1O8JlIljrPWVga8Nbe
	fCIxtWXwy/Rku1a4PXCBIietfA2YUDV7FVz89wM4B/QkqR8UAM5bmHOFAaBAH/bcXv3Sp8lzc44dt
	JqjXZbZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZqW-00CNzK-SE; Tue, 06 Dec 2022 15:27:00 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2ZmG-00CHRK-3v
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:22:37 +0000
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so6378621pjj.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UU8AMEdCApUKn2yCNu179y3IuDBUbfO2XN1Qp+qLAs8=;
        b=jG3sZcdZjSQIRjZkl/f7DOP3dlw758+HEdK7GWWq8fnj9XOdoNxOkBB2jC/8fB14wx
         9FNJy2pQnOLNPshZ0wncMGcgTjWilHuX1Bof33jsFVE2FkTXuTJbGdHUPK3/27UaGkvK
         M5eCBf9DWrA3/swfuE4dabHXjTiAR1WKAKwpHstU30D9ufiWl2NcIxhMoypIVrjzmYCl
         spyYHwWMmjSH6fjzFZEmEiwvpNMjodZFbFQeR2MIYjLq4JYYpySczgRZTnLObyGe9JnD
         k6I7+5uanHUHMcum9tuQsR/k+FU6BcxcU7gl4DPlzzQZx8dB4g0Mi3WATLONu2k2T3NX
         tEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU8AMEdCApUKn2yCNu179y3IuDBUbfO2XN1Qp+qLAs8=;
        b=rqVJX4R1gSMwpOUhkWrWyvkE5YPQg3iJJKxm96vz/Ejol60cHJNVvFhORhluKdzdAH
         B11mxBdKhiNgv7gmZlldPBTOOHs41FtEtCvnsp4lwH0V01N0z0ZUH/2Hl9BeK8QWK1M1
         u0rdcMPutJ7QT5+1Du+EMxR2qu4ALaazE3Z4g1dNdnfJumZvNnd59G7SXZ2yLeXvbGNQ
         nhnJhopi+t8iBcYSlhdbXFa2RAVLabzYt8PvM9HLRzi+FJhEyTrbIOHg//JDUAsc/Zp6
         ba9d+j5722Z0QzQAI5Rb/18i3tY9ioqlAhYjWURUHeP4HI6TcRR7Kf6jEQC7xTduNL2m
         DdgQ==
X-Gm-Message-State: ANoB5pmhxgkebEdNVIJc7pkAIZEBNHjetI2FkmJK8I8/9HFq7sVTxtsD
	ikPWJehXDA3PRrUGwnmg5oK9qw==
X-Google-Smtp-Source: AA0mqf4Ycm0ZpEHchEyW5wHkELYu+0YMn7TsJMJRfE0+nFFPq8XQvhmYhp2h5imhee7dmv/YvgeI/Q==
X-Received: by 2002:a17:90b:2544:b0:20a:f341:4ed9 with SMTP id nw4-20020a17090b254400b0020af3414ed9mr98991840pjb.11.1670340155171;
        Tue, 06 Dec 2022 07:22:35 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902d2c300b00176b84eb29asm12790880plc.301.2022.12.06.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:22:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2ZmD-004cnQ-5r;
	Tue, 06 Dec 2022 11:22:33 -0400
Date: Tue, 6 Dec 2022 11:22:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Lei Rao <lei.rao@intel.com>, kbusch@kernel.org, axboe@fb.com,
	kch@nvidia.com, sagi@grimberg.me, alex.williamson@redhat.com,
	cohuck@redhat.com, yishaih@nvidia.com,
	shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
	mjrosato@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org,
	eddie.dong@intel.com, yadong.li@intel.com, yi.l.liu@intel.com,
	Konrad.wilk@oracle.com, stephen@eideticom.com, hang.yuan@intel.com
Subject: Re: [RFC PATCH 1/5] nvme-pci: add function nvme_submit_vf_cmd to
 issue admin commands for VF driver.
Message-ID: <Y49eObpI7QoSnugu@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206135810.GA27689@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_072236_560358_6487DC48 
X-CRM114-Status: GOOD (  13.50  )
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

On Tue, Dec 06, 2022 at 02:58:10PM +0100, Christoph Hellwig wrote:

> Most importantly NVMe is very quiet on the relationship between
> VFs and PFs, and there is no way to guarantee that a PF is, at the
> NVMe level, much in control of a VF at all.  In other words this
> concept really badly breaks NVMe abstractions.

Yeah, I think the spec effort is going to be interesting for sure.

From a pure Linux and implementation perspective a decision must be
made early on how to label the DMAs for kernel/qemu vs VM controlled
items at the PCI TLP level.

> controlled functions (which could very well be, and in some designs
> are, additional PFs and not VFs) by controlling function.  

In principle PF vs VF doesn't matter much - the question is really TLP
labeling. If the spec says RID A is the controlling RID and RID B is
the guest RID, then it doesn't matter if they have a PF/VF
relationship or PF/PF relationship.

We have locking issues in Linux SW connecting different SW drivers for
things that are not a PF/VF relationship, but perhaps that can be
solved.

Using VF RID / VF PASID is appealing at first glance, but there is
list of PCI emulation details that have to be worked out for that to
be good. eg what do you do with guest triggered FLR? Or guest
triggered memory disable? How do you handle PCIe AER? Also lack of
PASID support in CPUs is problematic.

Lots of trade offs..

Jason

