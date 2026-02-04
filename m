Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FD7EA794A
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xbOXQsfxbvg0IUmFm5mESMyDQHyXAvo1CLII4tReRCc=; b=fia5KsUinO4CKaOLbfEIdpFRPo
	yMeOgghQC2c3/bMy0WaWELMxlKddK8XW96ZMFNCBSH283youHfZTKO5Hb6FqaQ1S/DCsfmI4rL/HG
	1q/i4Z7CK+gj4pT84Wq24tm83+qm41f29pR1l5VdsgAb7TTs5WIm1paYZRwmh54r+nxnif8AjZY7P
	ktAi25vpt/o13b5V1hQT40Wk4Aiz2YNKKeDuwM5PBvs6H5Sr/+3aq4Z01XRpDsyYdpExzh6Sm4siz
	bt0/jkP/jSLtTt3+KoxvCDiCSNNFosyUFDt7mqGvJb8e/o7LdWVOIP+UiVmFAkfBWXiFWv//Ukxmj
	3sMulh8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmlO-00000009CZ0-27jP;
	Wed, 04 Feb 2026 23:58:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnmlM-00000009CYu-4AJR
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 23:58:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DB44A600AA;
	Wed,  4 Feb 2026 23:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309FDC19423;
	Wed,  4 Feb 2026 23:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770249503;
	bh=2cV4UVjiC81EBWIuek7KsBae1DF6Y5C0da9AAPdyTq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsA0d1ixdQtdwzh2FlT0UUVw7EubhQmyvqGdpi3JfJj4St22XKtFkf9+FrDZYBSJU
	 Kp0hvNsFz7h6B4lLwEW/TOsb4k1IUdSEw/VYb7PctxhcYQKBOTdXp50FGtLWVXtcHu
	 2SCPd9DbkX9O/e25wXFaU4ldSb764sIahmurnuNNH7bthLuLKfYQNmhlky/dvAujW+
	 r682F6sOL8GXg3DevxUAH9UnxXvLQvgkhxRTSSK9uuespZHfW2yQcJUfWUooNtxaT3
	 gIVEkRafjzcY6bnHUg7tTiPhw4fYAdELq/gyCUX8z59KXrnAm2bezVzuNwQO2Q3YlZ
	 2OaNjbpmgmSlQ==
Date: Wed, 4 Feb 2026 16:58:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
Message-ID: <aYPdHYvuLeIevwUJ@kbusch-mbp>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
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

On Fri, Jan 23, 2026 at 02:19:44PM -0800, Bart Van Assche wrote:
> Adoption of zoned storage is increasing in mobile devices. Log-
> structured filesystems are better suited for zoned storage than
> traditional filesystems. These filesystems perform garbage collection.
> Garbage collection involves copying data on the storage medium.
> Offloading the copying operation to the storage device reduces energy
> consumption. Hence the proposal to discuss integration of copy
> offloading in the Linux kernel block, SCSI and NVMe layers.
> 
> Other use-cases for copy offloading include reducing network traffic in
> NVMeOF setups while copying data and also increasing throughput while
> copying data.

I'm interested in the topic. I'm just not sure about the approach. If it
doesn't support vectored sector sources, then it's much less
interesting. From the host point of view, I'd like to be able to submit
arbitrarily large bio's to the block layer that can be split and merged
for optimal alignment to hardware limits. The two-bio approach looks
overly complicated with respect to that.

