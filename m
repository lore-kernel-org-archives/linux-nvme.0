Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA2BFD8FC3
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yWGbhzxUV7TgieGa+6j31Gytmp3g1m5Mo28yAmv2JjU=; b=GFTeReyOiqYSgFQlQhSmzt7aNe
	4kEH5YXeytPTw/rlXt9i5E6wv+Wz1qkWodabgysHJalsF+kkejiiBlb55ixUe77IXQarFvaTkLYSE
	ie9ud+UZwNxHqENrZWU1vgXvV9LyGjApA996LAMe4FRZvrpMLx26effjMp5LQ+kpqNdpf+5CFfzdL
	agXyaIx/E1kSBZeBNWO1vuVa7TQcfsHApmhoYXT3zNACkizG8gv/PtzHDFQpL+RFiNd+uLPPfl6qH
	9DZgwMdRv2Z7WGtJz3EZ3cjKOMQqFWtn+I0x3X+6h0/p/aoGdUxo60oRmkvCLLIjmsx15EwUF6Fa1
	FSzy8/bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvczh-00000006PWl-3dfc;
	Thu, 26 Feb 2026 15:09:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvczf-00000006PWf-3bQq
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:09:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 34A9A600AA;
	Thu, 26 Feb 2026 15:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622F0C116C6;
	Thu, 26 Feb 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118574;
	bh=yWGbhzxUV7TgieGa+6j31Gytmp3g1m5Mo28yAmv2JjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kER6+M972ifhcTg/lHW10mDgV/Cxt4JZRKTGZg0FupaemYizRSEKU84DN5IGd83BC
	 ku0QbRr3zzkBLBF/vAiK8oaVaqBs4iOpLYzaWkiPvX6AREcAcTvfTWKDn1dXg0erRM
	 F9u+0UbihnpHC0EPUEH7ZBIR6qtRD8gKCDWyn9BcFr/YNtGoZrkHLKIebmigqnpI9a
	 pjI+oOIdoAMAW5nkQOiGtE4aETM9ZB4ZhPjycHN2DB0JluRlcJLcWA8dmGBY3QKoyZ
	 WXCGT2qAPhAH710ZRhM3xK9Cj95midWpqqpDP35R54O09S4E6F3jtucvk4EyB5XiIJ
	 wvhLCsgl8sjdw==
Date: Thu, 26 Feb 2026 08:09:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, hch@lst.de, hare@suse.de,
	chaitanyak@nvidia.com, bvanassche@acm.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	James.Bottomley@hansenpartnership.com, jmeneghi@redhat.com,
	emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V3 0/3] Ensure ordered namespace registration during
 async scan
Message-ID: <aaBiLNe0O6R9-Lmv@kbusch-mbp>
References: <20260225161203.76168-1-mlombard@redhat.com>
 <aZ9sjbZ3CEW_1rW1@kbusch-mbp>
 <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGOQMFJJ6K5P.3KLF45WQT2SAS@arkamax.eu>
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

On Thu, Feb 26, 2026 at 09:07:10AM +0100, Maurizio Lombardi wrote:
> With your proposal, if a user has sparse NSIDs (1, 10, 333)
> then he will get /dev/nvme0n1, /dev/nvme0n10, /dev/nvme0n333.
> On one hand, yes, they are "more stable" and more meaningful too,
> on the other hand this breaks the assumption of contiguous naming.
> This might not be a problem for the mainline kernel, but I suspect we
> will have people complaining again that the /dev/nvmeXnY enumeration changed

The bonus of using the nsid is that it will always enumerate with the
same name even after you alter the other attached namespaces.

