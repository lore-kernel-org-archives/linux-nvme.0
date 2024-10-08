Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897CECEFC38
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOxourVOrBx0+N7H6Y112bCmuCpaNPRihgwYCOIv3Ww=; b=fgg1XtS3DAl+2ffnuhjud8DA4j
	3zeqiGJlcTDt8ta8SnrV3CnE/1JLiA503NjCPVm+qiqPRBx+2HTISprslIVRs+rySc8IQtN0nf/YI
	pIeP5mOzyq+nX3yPAe3/9WUzpcAQ+/XRqz9tHyOIEHu2UTIhOu/rMG61nJcSm+uQhtda+jlnhMpXz
	VQTRuPa9eHYJFHRoGB+fGBQKyIX8RF+Pf+qwJjgiQtv3aB/j4WwdZTZ1Z0ZAceklQhAiWetW7vR9u
	NGnQJcZUoeV7GExFvvqTIyk22tQ5p/JXPgwBANxQMYmhUw631mTRkb9sVakO7GhsVES+u6ZYOVSlM
	i/04wglQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syEF4-00000006giG-3kHx;
	Tue, 08 Oct 2024 17:43:26 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syE7w-00000006fCD-210c
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 17:36:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 183C3A41D8F;
	Tue,  8 Oct 2024 17:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA93C4CEC7;
	Tue,  8 Oct 2024 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728408962;
	bh=Ti/FVy0DhThpkoWjmzXezZuIeCKRr+W6AFADbjy/DPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSIFfbsOIwnUrToRdBGUqOU3kMMy1uuXM27PbaUDcCoBoaYqQKsL99ERfU/j3bCVt
	 aFFWDrayWSCsn9NorC8uyCVCm4s5tkhFg/RXs9C3aWmjYAFFPVmFY75fKX+2yjBnLu
	 2lqk+0RB6OTLUgnUIMoj1sN2InJT5NCLBNfL+QVxa4z6rJO5C10Pn5EjqPsfDV4qmw
	 Pajwbzb32UeherZod9e3tuCiYpRN1D3/UXFMTCN6RS3wVahdp7VzbLiBYnxLxaeH+l
	 H/wjjX0hPoc0fM09acgitRmOiNReVfrrxhxuFjYPecg/HIyKxO8y/Wkh6BGQBL1efO
	 7ySzxv3RDmE6w==
Date: Tue, 8 Oct 2024 11:35:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <ZwVtf52gL1Zg_YYQ@kbusch-mbp>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
 <20241007193324.5846-2-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007193324.5846-2-gjoyce@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_103604_671544_800C28B1 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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

On Mon, Oct 07, 2024 at 02:33:24PM -0500, gjoyce@linux.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.ibm.com>
> 
> Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
> is ready and able to handle commands without returning
> NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.

I'm okay with this. We just need to see if Christoph wants to chime in
since he added the without media ready support. I never saw the value in
having Linux use it, but maybe there's a good reason to do it.

