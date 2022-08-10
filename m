Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA8EC19F2D
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5i03jgjkWaZvxg0nblLGh4AzdGknJkreLHPAvQ/p134=; b=giX/efrkSU9kgsAmhz9pMfdOSh
	W0BQB5v/snnSqTbTnbLBHcHmM69poXBv5a8KpjngChBrX0yNI3aHQMPSJKUrU382bckoMNeWu+ob4
	DJOsqaShJgQ43MNpBAWTDWEYCj9RmSK8C1Tvk2lrrgTUgCa/FlO0gSVX+T0wW8ynGXQtrgVk+lF68
	ofve0C2+VN1EX1nBD+6UxgS8OQOYG0PBk42q/29UGOPIO58pMEoILckTHFOaDVlG3WOIrssgKEvgq
	QYoqUBWLRabXj+5OwzCB1FnE0GxyRqt2K5wc6Sx3yiYicXwaDpYwvvfnDyWbUDHbvadcuwuD4LzM/
	9tSCJTGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLcDw-008gkb-3d; Wed, 10 Aug 2022 03:17:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLcDs-008giG-S5
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 03:17:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EBC8D61314;
	Wed, 10 Aug 2022 03:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA2C433C1;
	Wed, 10 Aug 2022 03:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660101445;
	bh=vjEy3DMtbLrahHsziT5da3Wwqjeu8cAWr/76lzTo+6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ntmHLs9lVYa79wSbXJueCgmc0cWbs6zVaI1xE3DLv/orAm1A9Vvsd7U6saAbatStx
	 qCSjT3rfGmNVX+BxgDBq2AIfSJvq6OOZaDFGgeXnhDXetdck9F77JsKXUxhf8LEjqz
	 VmEhLFJdbKBh9ncKjY+WX09JsAXBM/Dl/19tdQfWtvhU0FP+x7Os9sUHg9kp4I52Qe
	 mq/eA4o5L7wznNYjd1dEbWTr0oxGalYz/vPD80JOP0I3uP6WTnqYHFIi3Y+TdsNaOJ
	 bIo2WUadkHl0nVPeVEtYkSMfVWs2E/g4g/TFCdcqud/blhMwfFZx2Y+XtU422IRRlU
	 8zLnRJpeaKxfw==
Date: Tue, 9 Aug 2022 21:17:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	"bvanassche@acm.org" <bvanassche@acm.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"james.bottomley@hansenpartnership.com" <james.bottomley@hansenpartnership.com>
Subject: Re: [PATCH v2 09/20] nvme: Add helper to execute Reservation Report
Message-ID: <YvMjQSlFKJE8Cp8w@kbusch-mbp.dhcp.thefacebook.com>
References: <20220809000419.10674-1-michael.christie@oracle.com>
 <20220809000419.10674-10-michael.christie@oracle.com>
 <12b99b10-8353-0f72-f314-c453a4fc5b6a@nvidia.com>
 <YvJ0Xh61npH+M9HP@kbusch-mbp.dhcp.thefacebook.com>
 <5f55a431-31ce-185a-6ab0-db701b878d82@oracle.com>
 <a0184a51-ef30-dc80-412e-6f754c4d9476@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0184a51-ef30-dc80-412e-6f754c4d9476@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_201732_973475_B7FE6EB0 
X-CRM114-Status: GOOD (  17.36  )
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

On Wed, Aug 10, 2022 at 01:45:48AM +0000, Chaitanya Kulkarni wrote:
> On 8/9/22 09:21, Mike Christie wrote:
> > On 8/9/22 9:51 AM, Keith Busch wrote:
> >> On Tue, Aug 09, 2022 at 10:56:55AM +0000, Chaitanya Kulkarni wrote:
> >>> On 8/8/22 17:04, Mike Christie wrote:
> >>>> +
> >>>> +	c.common.opcode = nvme_cmd_resv_report;
> >>>> +	c.common.cdw10 = cpu_to_le32(nvme_bytes_to_numd(data_len));
> >>>> +	c.common.cdw11 = 1;
> >>>> +	*eds = true;
> >>>> +
> >>>> +retry:
> >>>> +	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
> >>>> +	    bdev->bd_disk->fops == &nvme_ns_head_ops)
> >>>> +		ret = nvme_send_ns_head_pr_command(bdev, &c, data, data_len);
> >>>> +	else
> >>>> +		ret = nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c,
> >>>> +					      data, data_len);
> >>>> +	if (ret == NVME_SC_HOST_ID_INCONSIST && c.common.cdw11) {
> >>>> +		c.common.cdw11 = 0;
> >>>> +		*eds = false;
> >>>> +		goto retry;
> >>>
> >>> Unconditional retries without any limit can create problems,
> >>> perhaps consider adding some soft limits.
> >>
> >> It's already conditioned on cdw11, which is cleared to 0 on the 2nd try. Not
> >> that that's particularly clear. I'd suggest naming an enum value for it so the
> >> code tells us what the signficance of cdw11 is in this context (it's the
> >> Extended Data Structure control flag).
> > 
> 
> true, my concern is if controller went bad (not a common case but it is
> H/W afterall) then we should have some soft limit to avoid infinite
> retries.

cdw11 is '0' on the 2nd try, and the 'goto' is conditioned on cdw11 being
non-zero. There's no infinite retry here.

