Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E19EC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E58FF61260
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 23:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E58FF61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zK22md40uOtYWOsUBZfHgF8ZUippYhcuXLGuEsGrTk=; b=K+8VCKBtRZEkgmQRtGGj+/ZYa
	NIApOzGg1Mod0TPqTfHZv+4JbIzaZHdZF5d4HfP7PlvBpZDat3rtRjvljspIQVowoKf92QtVETxLl
	lW7t1Ap88WgIYP4dAivV7lrqjtTre2ErmxUuhSQR7AqLvb6iGzQlaYCjbzoYkqBemmytuLP3POTDI
	E/rAR2zgmQNVjQEHbX61Zbc6IlG7M0WVQEqobJJ7z/tbOQMvaPdzQCaOhLMBn3FP3CVDVSYMbR1HH
	9qAx1y7RKjglDE3T+WaFP8BhgDMgzIGBcEVKTCjfNY4tX+BveAbyFDwUk0yPnkQ0dQcr8Q/ukg2zQ
	gpsc30fbA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUHjX-006Iz6-6X; Wed, 07 Apr 2021 23:37:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUHjT-006Iym-01
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 23:37:12 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F00661242;
 Wed,  7 Apr 2021 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617838629;
 bh=CWCWPEeJScKlRD0mDnjomkiBY1E1hPeHqQ+rM1tMgKk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Dmsju92uZbEJbFsToJXM9XWXIlEZN8I/Y/47FqtfwarDsymD7dHA+cQsMkwozUE8l
 H1TmafsFNTHHDiZJfOMoi8PJkluOlnBSK2EGBek1HdCnyM9ZvdL6rznGEE98mr/0vw
 wel8JtMIyIRHZQxg8hxFvk88rqoU2M3pcLbvX7G4+iaZvx+He8bjiY3rHvbu28uaVP
 Bp6nWYcYu5BPGG6dQogb+0EMx7+wLN5aSUPqPLZD1AlFgMKTN6eSo+fZAj+whTnBCc
 QIyusgii6aZA2o87+B1k21kBkj+CUJMfAR0M5YfHKMuxQ27ujIkJ2ddqk8+Q94eSq7
 QtebfJY2rWarA==
Date: Thu, 8 Apr 2021 08:37:06 +0900
From: Keith Busch <kbusch@kernel.org>
To: Padmakar Kalghatgi <p.kalghatgi@samsung.com>
Cc: Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org,
 tasleson@redhat.com, tbzatek@redhat.com, prakash.v@samsung.com,
 d.palani@samsung.com, javier.gonz@samsung.com, k.jensen@samsung.com,
 mohit.kap@samsung.com, krish.reddy@samsung.com
Subject: Re: libnvme questions
Message-ID: <20210407233706.GB32309@redsun51.ssa.fujisawa.hgst.com>
References: <20210312161824.GA3953@redsun51.ssa.fujisawa.hgst.com>
 <CGME20210407123854epcas5p48217db953741a57d651a8a8bf240ee23@epcas5p4.samsung.com>
 <20210407123806.23253-1-p.kalghatgi@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407123806.23253-1-p.kalghatgi@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_003711_252997_5A41F08E 
X-CRM114-Status: UNSURE (   7.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Apr 07, 2021 at 06:08:06PM +0530, Padmakar Kalghatgi wrote:
> Since most of the companies who develop SSDs, use MI(sideband) channel, we think this will be a good enhancement to the existing functionality which the nvme-cli provides.

Can we even use this from a Linux host? I thought the sideband channel
was typically connected to the baseboard management controller.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
