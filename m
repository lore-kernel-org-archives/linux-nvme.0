Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EDDCA0EE4
	for <linux-nvme@archiver.kernel.org>; Sat, 16 Aug 2025 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/pdikyApQEkim/zQ/+RSYrn6jbhaWT8UEwMiGGMQ+hA=; b=MmD5dIfnsAbBP89iJzTOUzFOe/
	/xNaZGSbcI+IJoD/yoSB2dOOpPmOwF5siz4460VC9+nf1x6q0713pIfZ5wGe9cLLYS32YxAvzU/wJ
	vF1P8wkUZ+RZKL/+vlbNKc8f75L5r7iauLjgKjbmhv9IZ/sqrOojzmc7sDzFcVbhzuAj9NTu+o7qj
	0xIp+Gn+y2jABlD3LOucjmJ/HUKi8YbSSLmcQ2uJ3Dbo8aPAQ9VYMdkGr0+m0LZUxpcgz954ISNyx
	npZmqrtv0NyB2k/owuCdv4QQ6NbjhiAq8FYaHHSWJ56h9RxMFMhj5f7luhd7Kdc7FNiIVhwvtTu2r
	aS2Z+5yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unGpb-00000004gJO-2XfR;
	Sat, 16 Aug 2025 13:20:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unGpZ-00000004gIF-2avU
	for linux-nvme@lists.infradead.org;
	Sat, 16 Aug 2025 13:20:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 764865C5539;
	Sat, 16 Aug 2025 13:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00FCC4CEEF;
	Sat, 16 Aug 2025 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755350417;
	bh=4a4UkLWAzywoDLLPOv9OQ0BJA1ty0NVPTX6oHQuZ0/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBbPjok9HI/V7jj/NTyLShma030jGXnB0hc5RhIb7tppnfW/Yl/Ln/2omN1T4kezV
	 IYEVJCUHEXzeql3tID96H4hKbsqXUqBAoJ2DkrLFxpyTz4L4xT1mICPbdj2nX7rbdW
	 Y4M17GXRpCElKFVJ42ndQCNXOS1U4ShcM1jcrB9WZbDCq/N3shJvokL1CDN/TqYg5Z
	 wxES7Hi9nXl9+mnCRMG5COrcUnSRmbOSSzumKUvB6e1Wv/GWKINsXWAaxXqYVkzxoy
	 iFHEpknm1i2iPrHlfPn4WzJjhI6vkCVn9yZz1BVjLFiHCqS+3F2RGZyNYhmXSvjNZF
	 xYYKdmumnveFg==
Date: Sat, 16 Aug 2025 07:20:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG report] kernel warnings with Samsung 970 EVO 2TB SSD
Message-ID: <aKCFjzai3Y0RcGHP@kbusch-mbp>
References: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC3TO97G0RMI.3KKUONOCLJHFB@cknow.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250816_062021_699127_FC3B73B8 
X-CRM114-Status: GOOD (  11.11  )
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

On Sat, Aug 16, 2025 at 01:40:44PM +0200, Diederik de Haas wrote:
> Hi,
> 
> I have a Samsung 970 EVO 2TB SSD and I see these kernel warnings:

... 
 
> I wonder if something can be done to fix those warnings.

Are you talking about this message?

   nvme nvme0: missing or invalid SUBNQN field

You can't do anything about it, but I wouldn't worry about it either.

If you want to see what the driver is reacting to, you can check the
subnqn from command line:

  # nvme id-ctrl /dev/nvme0 | grep subnqn

It'll probably be all zeros. The field has been required by spec, but
the driver tolerates ones that don't implement it. It's just a message
that the device isn't spec compliant, but otherwise perfectly
operational.

