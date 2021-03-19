Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4783C433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 15:22:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1FA6192B
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 15:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1FA6192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bX+NgPRpC/3pO1Qqg8zkYfqPlxDHZQChw/PUaM6lBUM=; b=dCroIN/Jy4GjvzxzHMtdFXqZ8
	T8Gh1s6+mL6b1uazMZp+U83X1wbwtAAlslzXIFcJw6YDLYeAuPtEtjG0O6VxkouWZaeeqfqFg7qLv
	hEFmHdONOI+hVrBinBmTsUyE3QCwZMVzapH34SjgvWnQ8qvnJUn389Ngih8NnfezOETR4kslGBwlH
	PlDA3mVOTBVb/Z1wFp1VAaNkEEPcgx0og+Om8uDl0K5Z5CqjEUYZhUkJDUQTEhHLwIEjXch2zdoLR
	nd+mGLVpyvknEpK9e/K8HieX8qebblXqcpXutFdAZLHpA/j211ACa34AED4NbriFMAP1DmCwA1rTJ
	JWophuKNQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNGxO-007chh-6f; Fri, 19 Mar 2021 15:22:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNGx6-007cfh-QS
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 15:22:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B16826192C;
 Fri, 19 Mar 2021 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616167335;
 bh=l6HGEjH6jciETuilMvnxDi+rDwTUxFqhLutPzh8goqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ojvo4t+GZx/i8Bufdlpl7xDvDOrVCadTCqwqijlbbQeKAR5wW/4/XGxWwZ23oBJ3Y
 BcSwFVFBSMzM8W6Vrzuzz/ECULFFTWg0XCslHL+Xtw1sgzK9FfMf5ByGK7XrL2sjUy
 sxOtolMn+UspYxjlDw+t9CGHetEjXhjjkLCaarwHTHox6Vn4fReeELr/w+ahnleWt5
 DBGSu/dt7FHLYbZhNR7aB1gsCOtakzREE8ioVBfQd/5FOeVlo+wZe6xZ3A8yB2i0Ad
 FGIpSqCep3Z2GaADnw6erC7fimT8jZso85XjuctPyUiWl04ct/u7zjdTN2MdKYvCdl
 ATOvuC8uB5Xcw==
Date: Sat, 20 Mar 2021 00:22:08 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Alan Adamson <alan.adamson@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Message-ID: <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319065158.GA11263@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_152217_039554_239FD80A 
X-CRM114-Status: GOOD (  16.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Mar 19, 2021 at 07:51:58AM +0100, Christoph Hellwig wrote:
> On Thu, Mar 18, 2021 at 12:46:53PM -0700, Keith Busch wrote:
> > I don't think it should require user space modifications. Just mmap the
> > current resource as-is but let the driver allow read-only in the
> > precense of CONFIG_IO_STRICT_DEVMEM. The below is a rough idea of what I
> > had in mind (compile tested only, and a proper solution should restrict
> > access to a specific address range)
> 
> I think this is a horrible idea.  Userspace has no business touching
> registers even read-only.  MMIO reads can have side effects as well,
> intentional or unintentional, and we also open up a whole can of worms
> of mismatched memory attributes.

I was thinking the driver wouldn't opt-in if there were read side
effects, but yeah, it's too fragile. I withdraw the suggestion.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
