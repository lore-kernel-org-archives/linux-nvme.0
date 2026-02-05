Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991A0EA7950
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 02:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a4ZrmbIrj7yiYceNmxkDL4IaQgUWpX/wSLBeRDcQ4qs=; b=uEQuiMbgGP6IN2+ho4Vz5aXP0Y
	Z0N/xCRWtLGBBRi2AwBBJlIIkp/MU7ajjLFvSaaV3kUknZHoorev3qGnCd1ciZN/vG19FH2MOWOGJ
	uIsVBZqWea0BVto5kslwY0MxVqRG7by9BtrrL1G+Up+DH235ACTrTVM3jveXYbKb226qQtpTmoFBj
	ft51PYLqTQ9bGEus2PUgctZ5rgMFUwWoaxYFCPg2pf7qB/q5bbAmhMWief5HuYLjy+Px7lIZHJnlJ
	2EkXX0C9QUh5N1f/5M1DM7n1fZILlICaEMBWCxbkCCTvQPRETGs9j2vbHr8HZY9NQ10XpSZ9RaKPO
	IYg92+Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnoop-00000009IgB-0Ovj;
	Thu, 05 Feb 2026 02:10:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnooo-00000009Ig4-0Al2
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 02:10:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 126C760010;
	Thu,  5 Feb 2026 02:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F03BC4CEF7;
	Thu,  5 Feb 2026 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770257404;
	bh=BnHgOlvPZc11r0A/CNMqLP+zlqzs4h//HZ2R0UmErDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTC4QlQZ5VgEA3C9GhxHeslqUvTAiPMuXw70W5e0LP6lSISDgbf7RYKVdYwJ/Dwve
	 p2vEUz/dcAr0WnbepCpvWNmokZNWe1DiWLfseUEWU2N1Wf9sx6Y4Zb2oLcmiu4W1il
	 qOViDGB4GezqzOpTL29HSc1Wvh75tjpLL26XNwPaXbPjPmCqb7iyI3GUuB5rBitU19
	 eMGVJYATCFa3YZXZciLWEMitNSS1U/vQp0n2zEdzsll47NHAqL4HvyyduSebRPmPWw
	 6IgxG88apQluLPHLLmDit5M534dF0BJ3gmfCBgfw2UiAbmn6V+0Ixjuk61572tZn1g
	 P2O35p4x6Luyg==
Date: Wed, 4 Feb 2026 19:10:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, dwagner@suse.de,
	hare@suse.de, jmeneghi@redhat.com, emilne@redhat.com,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH V3 1/1] nvme: add support for dynamic quirk configuration
 via module parameter
Message-ID: <aYP7-r3gdSjImhg4@kbusch-mbp>
References: <20260204105555.173661-1-mlombard@redhat.com>
 <20260204105555.173661-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204105555.173661-2-mlombard@redhat.com>
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

On Wed, Feb 04, 2026 at 11:55:55AM +0100, Maurizio Lombardi wrote:
> Introduce support for enabling or disabling specific NVMe quirks at module
> load time through the `quirks` module parameter.
> This mechanism allows users to apply known quirks dynamically based on the
> device's PCI vendor and device IDs, without requiring to add hardcoded
> entries in the driver and recompiling the kernel.
> 
> While the generic PCI new_id sysfs interface exists for dynamic
> configuration, it is insufficient for scenarios where the system fails
> to boot (for example, this has been reported to happen because of the
> bogus_nid quirk). The new_id attribute is writable only after the system
> has booted and sysfs is mounted.
> 
> The `quirks` parameter accepts a list of quirk specifications separated by
> a '-' character in the following format:
> 
> <VID>:<DID>:<quirk_names>[-<VID>:<DID>:<quirk_names>-..]
> 
> Each quirk is represented by its name and can be prefixed with `^` to
> indicate that the quirk should be disabled; quirk names are separated by
> a ',' character.
> 
> Example: enable BOGUS_NID and BROKEN_MSI, disable DEALLOCATE_ZEROES:
> 
>    $ modprobe nvme quirks=7170:2210:bogus_nid,broken_msi,^deallocate_zeroes

Thanks, applied to nvme-7.0.

