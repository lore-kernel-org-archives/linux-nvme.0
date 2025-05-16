Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E8EC3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zrrs30nrSstvDRhx2MFKBy43bS7vlZGXe/6NNvSbbDY=; b=hSWe5qq8ZN07m8n1kRuNvYE8t4
	YCpyL6nnLx3yhF68WF4s+JuoytlzclTT4CWKJPHwGBZCvUvBsplQFc3xqpZ6qEeFkJ+Vuh5QUVu6J
	3aB4pslmnnucCwwcKsyHuKCMH2JCUjgfCmE/a5RYwGtgBIS8E3Nh8y+z0uwpiXMH3N8yzixa0AWt3
	1hjhjiIlXgZPDLHxwm98U5jI9t7VkpNT2HN+lu4REX+KNq8OIdWPv93OY38jR7nC8WxNP9e4leDTe
	Bua/SMgUj+ZNjv2F+857SxDejBXoGVinhweI51F1WLU1kIVSBRdKTs70MqLUEnfLbxCFkHUXoyMUW
	QxpBlt8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFwf0-00000003mtB-34h3;
	Fri, 16 May 2025 15:07:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFwG8-00000003hHh-13WC
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 14:42:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A2994A564;
	Fri, 16 May 2025 14:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492CEC4CEED;
	Fri, 16 May 2025 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406519;
	bh=Zrrs30nrSstvDRhx2MFKBy43bS7vlZGXe/6NNvSbbDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhlKvoqLsKddToHdiqXZOTLGW2uyJi3CpatL+OJ1sxEbQ+F0WTzdB21PF3fwezIsZ
	 Bg/PHBKdWg9jFyDkMvv1GahbWqQaPkzg1MIFsV2+hx3F5O1dlHfOrjm8It+BlUT2OU
	 0RixPGFl+UIjAIeq59ztLqQriN/ErFksV3OORRwD1nLW/h/7JurWF/rAuAHLX0UQP7
	 Hn/A816Mf5ujZWMKa0YP01iYqBjxHGzvfumnU+ypBPWF/cgh7HALKFRl6EkZJdYjQv
	 y/y+QBHVNFHKIt1G0hpywXvYy8OYg6cR1YRoYZ1ao5txAp9DmzJI+3UpDUTfPICj6y
	 S49phcOyPhfKg==
Date: Fri, 16 May 2025 08:41:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Avinash M N <Avinash.M.N@sandisk.com>
Cc: Jeffrey Lien <Jeff.Lien@sandisk.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aCdOtYYT8f3lL8zJ@kbusch-mbp>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCcwqhakl4JhrI2o@kbusch-mbp>
 <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_074200_309608_F613ED21 
X-CRM114-Status: UNSURE (   8.93  )
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

On Fri, May 16, 2025 at 12:49:07PM +0000, Avinash M N wrote:
> The device MDTS value is 2 MB. The same commands and device works fine on older kernels. The testing was on 5.14.

Not sure then. You may have to trace into the kernel to see where it's
getting the EINVAL error from.

And if you respond, please use plain text so that the mailing list
thread doesn't have gaps.

