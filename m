Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C0BE74AC1
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 15:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wMbVmQ9mamTxH33OPQEZTLbeV7xw1b2GByNuBNqM2Ag=; b=XrM/w30dN8WLzgfVFiHJaUhMJY
	ZfnBQeA6aGWNv4QxHkiK7hqwpQ2LVbA5rBV9cLhOXOgpVv5FWLvRjqpudkpauM0KS9HsEryv+WqzP
	tDY3TuMA8L3IFAWzFq8fVewpAnbAuLOc1CGY2jb7cU5gI1QA3E/ZB6PFoRvCoiHAcf6tsr5cH6b7t
	loMgpA7n6cIlvNzL/dn7Ua1rWyIeZrhAUggB2aheqTKlwWMPNxxtzd7WYFUmQXwhdtz0r3oxYuOkn
	rINcTJp3RwQguokxlyqB8gR9OHZMpIcQBNpPrDDfHRzMZxUhjDPKAhIQjUGOWFYSx3Xb/CaXrDeUB
	mfEj3CVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVEH-0000000A0WX-27SW;
	Tue, 03 Dec 2024 15:54:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIVEE-0000000A0VU-1ylh
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 15:54:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 82E835C6766;
	Tue,  3 Dec 2024 15:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B46C4CEDA;
	Tue,  3 Dec 2024 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733241261;
	bh=wMbVmQ9mamTxH33OPQEZTLbeV7xw1b2GByNuBNqM2Ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBZ8fQvX0sLOUkAim7uNlDSruq5/AeuBCx0y6KCzLLMlXkHAxDqKfkngNzdVq4PiS
	 O3n3Eh6Hjlnx3aX97rl0SpygHa1ehHpegtIkKzuWzBfVU9cssVm4zKiF/afX1WB8nK
	 TCBKSE+3fFBE8e61gVtV1V74RtaugsmCB3I7sNoXPVihhavwqKlLKvx204qh9pcmkD
	 hhOg/bvFfyaUGvjWLamnXCWD8/T1SsFAppUCbw000Dm7acD668vfMACsuDZ16XIrZA
	 /85u1JozZ8FeDY6zDRd3SBD0jqogE1DFuaL4TQtpRek4jcVRxPgaaaAK/kxk0uqSQn
	 3WlKvgIUeRhDQ==
Date: Tue, 3 Dec 2024 07:54:19 -0800
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: remove two deallocate zeroes quirks
Message-ID: <Z08pq5V66r6U3YR_@kbusch-mbp.dhcp.thefacebook.com>
References: <20241202175410.1207643-1-kbusch@meta.com>
 <20241203003435.GB6890@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203003435.GB6890@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_075422_553746_8D3F75BD 
X-CRM114-Status: UNSURE (   9.22  )
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

On Tue, Dec 03, 2024 at 01:34:35AM +0100, Christoph Hellwig wrote:
> I guess we actually do need it for the other two can can't remove it
> entirely?

Right, the other two are 1.0 spec devices that don't support the write
zeroes commmand, so leveraging dataset management to get the same
outcome is still desirable there.

