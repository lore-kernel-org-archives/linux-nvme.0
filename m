Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B411C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqqL0wzb/cn536XtYZtFOaEpIM6uV5P9yYi1coZmPF0=; b=ANYb+jCfqn4fhSaUveELozHv0J
	M3PGVA0qzkQ5ZJnXCg9/dHgeiaiwyHK4onMRDlAqzYFEPiGlBk02trsDU1NE+3xJLhuyQ+cM07tv5
	UWGudS9tDjN4Hh4Se5nvlf8y/EYUI6JZLRhCxwqywaL32RsSaYEhI0bFDmmENuFTwfDZdUMlj0cv3
	xvNd6wpC0C0oGqC3poyvogV3l/cElOEEqtMoOdUsG2c1noUXNRXMXIULPWnGSPYgTdgTiGNtej0mZ
	YNf9TTGOXLNMWcpilWdR7QdbhX0fbCMlMXCitSzaHryQ05O7HWqTsXuLoPYTOesNpDPjeIYcAUQix
	HPzAuTQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2aEG-00DTy5-No; Tue, 06 Dec 2022 15:51:32 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2aED-00DTlr-2G
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 15:51:30 +0000
Received: by mail-pg1-x52c.google.com with SMTP id v3so13743255pgh.4
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqqL0wzb/cn536XtYZtFOaEpIM6uV5P9yYi1coZmPF0=;
        b=jp4VKKZJHmW9e+5o/XYsQYVzCWhlkU6zVHLYGWRQ6mL5NGoTJWhwjrvshgFBiI+mEZ
         hVt7JXaTWLM2BeUl+D0v+YiBr92Tfo/1eDlAmvK8unPQIMLXxTdQcEXHU7VcsOz6MymE
         gRhL84a73vXFw9Kzv8cmUMxo2gVtuR+sr+dL3bKLc50/L/IVfG4X81uc8EdEf2f935mh
         X1AffDI3sVE53IzMXO9e1awFVOLUYoOQV6+I5I7KcekR8ALznMH6UQKfKYU/rqJOs/vw
         kQif/TsZvMyXAftVb/QSfMwuKlHFJRLJHZZsLXPhluYpkqoOQjdNvnxlRGSCe921fY1g
         uZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqqL0wzb/cn536XtYZtFOaEpIM6uV5P9yYi1coZmPF0=;
        b=c2u8HT35lh0XwwKeKNGGKOAiEYD1QRLRivzd/1+9WDmCAAKZuXgGEP/+LlTvw5S+Kp
         Ok+qeFH9jA3RzaA19TASBayd2F0qIHxOEU7AY6s4YwY4pdrdgW/Yeuuz7sh8nDWMOFnT
         Jcnek4TuxjjcIXN1MbHquowCJeqJJ3+oNineieDD+rDubiG+cFusT01aYuj8WOPyvyKK
         5JXuNg9ESTKtYVPwSJW3r/TFnkC/F48CT5ZnK4gH3APk6I3CPcVVny3C7aTF2JVuIR46
         m6POF8wCNbHR9cqn9TIFMl67vxezGVyHWH1YDgnm7euPtpq3bDgzRHU4tk8BCxr5lOg4
         cEyw==
X-Gm-Message-State: ANoB5pl0hDEAcoTIliLmdjv74nOHRFk22QCKBap4Jjsargp8nD4vhLYA
	UeQzh1CPaIk3IdvBWoQ9lkkMLQcEjW+pHWnH
X-Google-Smtp-Source: AA0mqf5jC2zZ88Ayk24fAnxs48LFANriRWQeqtUtGoqg2h+a9ISznENi3o6AcV6fLePCR9fGgUE6Fg==
X-Received: by 2002:aa7:8207:0:b0:576:7440:2478 with SMTP id k7-20020aa78207000000b0057674402478mr19328949pfi.51.1670341886129;
        Tue, 06 Dec 2022 07:51:26 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090a480400b001fe39bda429sm10974521pjh.38.2022.12.06.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:51:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1p2aE7-004dDy-Um;
	Tue, 06 Dec 2022 11:51:23 -0400
Date: Tue, 6 Dec 2022 11:51:23 -0400
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
Message-ID: <Y49k++D3i8DfLOLL@ziepe.ca>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-2-lei.rao@intel.com>
 <20221206061940.GA6595@lst.de>
 <Y49HKHP9NrId39iH@ziepe.ca>
 <20221206135810.GA27689@lst.de>
 <Y49eObpI7QoSnugu@ziepe.ca>
 <20221206153811.GB2266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206153811.GB2266@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_075129_141216_2A30C34A 
X-CRM114-Status: GOOD (  17.87  )
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

On Tue, Dec 06, 2022 at 04:38:11PM +0100, Christoph Hellwig wrote:

> > We have locking issues in Linux SW connecting different SW drivers for
> > things that are not a PF/VF relationship, but perhaps that can be
> > solved.
> 
> And I think the only reasonable answer is that the entire workflow
> must be 100% managed from the controlling function, and the controlled
> function is just around for a ride, with the controlling function
> enabling/disabling it as needed without ever interacting with software
> that directly deals with the controlled function.

That is a big deviation from where VFIO is right now, the controlled
function is the one with the VFIO driver, it should be the one that
drives the migration uAPI components.

Adding another uAPI that can manipulate the same VFIO device from some
unrelated chardev feels wrong.

There are certain things that need to be co-ordinated for eveything to
work. Like you can't suspend the VFIO device unless you promise to
also stop MMIO operations. Stuff like FLR interfers with the migration
operation and has to be co-ordinated. Some migration operation
failures, like load failure, have to be healed through FLR.

It really does not want to be two different uAPIs even if that is
convenient for the kernel.

I'd much rather try to fix the problems PASID brings that try to make
this work :\

Jason

