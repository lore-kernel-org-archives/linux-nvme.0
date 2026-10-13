Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3032FCC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3Mn6xLnHu8em3WFtyZnSUaeibjcFUHYkzfz3p3MghI=; b=zvhNcBCE4pWaGcttguFyvDPW+O
	ltKFvtEXnyK5GlBQN8SZrBBUkSvyti1A/OklFW64C0eww819Iy7qBoJKo99xVamGyUbZVS1hZEoma
	xllt8aKzGY/kJqQuNwGdK8blossmnmKW7xRjNESN/XjVk4A9T+W3bmvSX4DcooRD/nMUppUj3qRZy
	WXD/QVBnf4l4qtD4p0ud6frU/plLH0EmlyeGKF86GZwazrIU8hsg4CW60hwKfBPv2sWjF/4QJhR/x
	8Eo+SCpw2d0eqQVqbpfFCF7wCcQCQi4em1alKjQIXPR06h2k4UqovZDDwPsBaUpmEhaOv7k13oq9M
	oDYYct0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeVg-0000000DMAW-3a7f;
	Tue, 13 Oct 2026 15:33:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeVf-0000000DM9b-2iTm
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:33:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2A2360A52;
	Tue, 13 Oct 2026 15:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513131F00898;
	Tue, 13 Oct 2026 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905626;
	bh=u3Mn6xLnHu8em3WFtyZnSUaeibjcFUHYkzfz3p3MghI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RjPVyDoQrUuXp45G6Yc40x975pWRT7PbYcpk0R79ZrxWLBGIsue+tSV222VGc67jA
	 BRFIUlgnL+1+cSdOMcRhbr//bwJK3eYfPO6JV+GpEUaesjMrj3t9KkEo+IZIE/pfwg
	 V+JRkbGTRh2MBh265MRHE4C2Z/zi8yyza/3wOSgL3nX1XnUXs9B68y+7y1G8PdHpgR
	 45G3HpCRx8sMUgYEgHjxD3GqowGfQHEJ/gdrbSuHWpvfb1eSWKbzW2M2/dKQYqUDos
	 ma3eLKwCFoBVkgVP0a5vNfxKeBFLneQYFGUR2/fN31QL++ZfF+4Dzpw5mOB9ClFC/Z
	 dAr2z4HFZApKQ==
Date: Tue, 13 Oct 2026 09:33:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>, linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: Re: [PATCH v2] nvmet: Add traffic based keep alive support to
 configfs
Message-ID: <as5PWLBhghebm1Gn@kbusch-mbp>
References: <20260923202003.1776271-1-jtaubepe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923202003.1776271-1-jtaubepe@redhat.com>
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

On Wed, Sep 23, 2026 at 04:20:03PM -0400, Jesse Taube wrote:
> Add the ability to turn on and off tbkas (traffic based keep alive
> support) via configfs. This is useful for testing and debugging.

Thanks, applied to nvme-7.4.

