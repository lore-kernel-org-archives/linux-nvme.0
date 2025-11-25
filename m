Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD718D0E6F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h9FyoFHzLBxYwycQk9/joEEebSniALO3/jYxtaMuvc4=; b=IQO5B3wa1fGULD1K7oMeLguSW0
	9B79qZ9gyV80gwOi2AYY8Zymy9NbzxpTmRBXGvNZgQ78nMVk2q4UbJ/5YzytQUowGChOthrotFpYc
	18Xz2+NrXJp5tQrZSkjW1ZtDMTlC2N/sfcHuJQXn51RHi1jtdnhtxrontHVD27F6dSLRZ7RrTZjZ6
	s2l68vVTNq7tcnSKfqu0mTI3+PXMx+dFNn790iMruCR+BRiiTogFYyVN2oPOnPLLy/Q/tqALQKJVS
	+3xUmvNVBKEeKNHlybym9ofbWg0aL9Enre5X0V9PwvvEfpP8+b4Pt7DIaxoNECWeVQ6UuDfSXHY9N
	2MJ7vJ2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuT4-0000000DT6M-3rWb;
	Tue, 25 Nov 2025 14:56:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNuT3-0000000DT6D-0Wau
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 14:56:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 34A0260159;
	Tue, 25 Nov 2025 14:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E087C4CEF1;
	Tue, 25 Nov 2025 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764082591;
	bh=h9FyoFHzLBxYwycQk9/joEEebSniALO3/jYxtaMuvc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfrLXgboNlPHYPzJRhHYdAFelRXWRLlguZI2AvILWk2xvksOGOlYbeEC9OwUslKx5
	 Rf6VD6c+JObizOUfvK52HIoBOpSAN+qbBH3dgautmDjjNodrDOBFsGlR58O99G2rYw
	 Iug05eQyM+vDd2x3wZCZ4x+ctgUNlPFEmaIZOCb3ykgsZMaAa5CCZjnhqz66HB4YIB
	 hUMuyqxfUTkYtQqw/CNJ5bG8EUtw/exUy3KCYRxNPCjHQG7kOIIpcPCU3C61vzICTJ
	 2vqDwgZyxmNv4ZVV5Z9+sI0uUrFlOiG3M7vk8WFkljvXGuhvYFB4BnQGy6LlIdPkV+
	 R/ryUkjNYxM+Q==
Date: Tue, 25 Nov 2025 07:56:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
	linux-raid@vger.kernel.org,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
Message-ID: <aSXDnfU_K0YxE07f@kbusch-mbp>
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
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

On Tue, Nov 25, 2025 at 09:42:11AM -0500, Justin Piszcz wrote:
> I am using the latest Asus ADM/OS which uses the 6.6.x kernel:

It may be a long shot, but there is an update in 6.17 that attempts to
restart the device after a pci function level reset when we detect it's
stuck in nvme level reset. For some devices, that's sufficient to get it
operational again, but it doesn't always work.

