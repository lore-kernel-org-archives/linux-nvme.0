Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F212FCF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 12:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RIVzmuwJodWKk96hP3oag6BPz1zEXGS42tyhYgozQwk=; b=sOz9LjCBxaU4jzFponiYw/ktBI
	JHnz+vtjctUz4D9CX9N0MFE9euS5lpbmXXhMqBtjyOQ+HIf0s+CtZOl4UwY39hC3EukR/VXRXSeVD
	8xJ/EreQPUGSoCmzsIVoc2iDJcn2YtLfo5EiEyZdIBCpGrrpE0M7XO1uqq/qD3z7EuT4grJ5fR+8f
	l6FaZYCCE4Tot0FJ0h7i5pOD3c/CQP9/13zk4cO4eXJ+XNVZIJDvLrO4zmAagt4qcEVdeBJ9+mHqd
	0UMTjEF0KjPHW4ug2RkAjWLtU5rwGMt1g0E5VHN8TIVsmXRGuu+oGyB2iMqPl6EwPySI4pmTIri+G
	/xKjHnoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st58n-00000002NWj-32jX;
	Tue, 24 Sep 2024 12:59:41 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st57u-00000002NRB-2r6E
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 12:58:48 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com B037EC0010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1727182721; bh=RIVzmuwJodWKk96hP3oag6BPz1zEXGS42tyhYgozQwk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ToJTW2BDDMz/0frGBb2UuhnHWHYtJrxiMlP1axFFeSFbGR4/8afkbT9ONE2WOx1Ym
	 gLlSeMA2E+oHEaoXlKi8w/3XVz7ZYfnh7jdbFYfFUcur7lxym+7AlUGuED0VHVKWlE
	 5bXlk5U0poJ6a/YCqgHhTmft7ktpMGsv6Ff+M7oTWVcREtIE2KAhHxFo6jn7S+H3IK
	 mXi8DnaEazd8dbs+vpewSC3Ub+31HWBQUMvLH7+mGvQ1NqFKWyUdQaLa4OrXGt5PHG
	 v2f78YQAn9wqDq6ST/UMsqyFfUTt2bW6w6wmMmQLdZvIgT8Wi4pg0qL5Vg8ze6yKJ6
	 rI/H5E5rH93kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1727182721; bh=RIVzmuwJodWKk96hP3oag6BPz1zEXGS42tyhYgozQwk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=h8hQP1Ixto8rGACFbbDyKqEhh+gmGEk31kwI36Kz3zeN696xrtV9oMSL6ASWCZLbU
	 TaPeYL21uCPt/6ByqtE/79lmj0xz6XW0p15QlYhMJPZIJb86z9B4j7qK66XuPC7NT8
	 yWk9ox8vgFHmgnLazhxf3to0UH/mA2BKel0ArddRW0tGRmnGHHNXOtM5+N1xuEAN9y
	 bX9TJGQ46VPnUOxH0fXV8IbNaeZ8tjILSOga+mAR5Nx6WzNkpJfkJaqC88+K+MjnXh
	 tXtaoS0eZ8CaOjjjC96GL0QKAKTSUVAITl0qHmwkvptPPci768F1SlVOHIrzEvWdrP
	 nrk56Il4y7asw==
Date: Tue, 24 Sep 2024 15:57:50 +0300
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v9 1/1] nvmet: support reservation feature
Message-ID: <20240924125750.GG22571@yadro.com>
References: <20240923094708.42445-1-kanie@linux.alibaba.com>
 <20240923094708.42445-2-kanie@linux.alibaba.com>
 <20240923163228.GD22571@yadro.com>
 <114ce6b1-13e7-418e-bd23-8ab32a7b4c8f@linux.alibaba.com>
 <20240924055433.GE22571@yadro.com>
 <3b315daf-76a6-4360-aeac-65def22aa196@linux.alibaba.com>
 <0cddf902-9e60-43ca-b138-630c5485efa0@linux.alibaba.com>
 <20240924082425.GF22571@yadro.com>
 <68e3d62e-0f35-4b1b-9d46-b8e7ff0110b5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68e3d62e-0f35-4b1b-9d46-b8e7ff0110b5@linux.alibaba.com>
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_055847_443605_AF126606 
X-CRM114-Status: GOOD (  17.06  )
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

On Tue, Sep 24, 2024 at 05:45:12PM +0800, Guixin Liu wrote:
> 在 2024/9/24 16:24, Dmitry Bogdanov 写道:
> > > I take a look again, if we set self new holder before call
> > > nvmet_pr_unreg_all_others_by_prkey(), the
> > > nvmet_pr_unreg_all_others_by_prkey() will
> > > 
> > > not unregister self, so this will not goto nvmet_pr_unregister_one()'s
> > > calling nvmet_pr_resv_released().
> > Yes, and this is a reason not to try to fix non-atomicity (anothter my
> > comment) by setting new holder before unregistering.
> > 
> > Regarding this place, here nvmet_pr_resv_released should be called for
> > original_rtype !=*_REG_ONLY with a note that _REG_ONLY handled in nvmet_pr_unregister_one.
> > 
> > Please, do not take my suggestions "how to fix" as a direct order, it's
> > just suggestion.
> > 
> I'm a little confused, if we dont set new holder before unregistering,
> how do we fix the non-atomicity problem?
> 
> My opinion is that setting current host to holder first can not only
> make sure that during unregistering other host can not access, but also
> ensure that nvmet_pr_unregister_one will not unregiter the new holder(In
> nvmet_pr_unreg_all_others_by_prkey, I exclude current host),
> so that we dont need to worry about doule call nvmet_pr_resv_released.

I didnot mean that that will not fix the non-atomicity.
I was worrying that in that case you will miss the existing logic for the
changing the reservation - that reservation released notification in nvmet_pr_unregister_one.

But, looking into that now I see that keeping nvmet_pr_resv_released()
here and setting the holder before unregistring others will actualy
solve both my comments.

BR,
 Dmitry

