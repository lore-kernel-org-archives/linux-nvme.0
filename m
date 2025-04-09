Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B13CC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vNCVzBog8Omp4Oqezj8MvziD1wityuVSvOikSLa7org=; b=GzzWxUHkEC/qPu5LxZ9wYmfPC6
	MZbPFbUDPffPtIgQukyb0T7CrmmlWc8UkrXpplkOHc6OSbQznBgLFqaaP1KlAPucANOV1nuF5gOxJ
	g7gcD9kOFHTmBRXrGIc9I2y/iOduBPfpr2HyJlZjlvykUO8ELrXUL1+6/JvLzfLGG3BqbNf2kstuU
	WyaZ/mMfKoCeHIeIe/Fk2xekPYLQEY2JZI6BX78KxqhkyKR786cAipMxnM/MZlbA214U9livvd2Od
	IxLJKzH4O1upF08LYxD0/E/5LxHttrtd1TUIVAJPd9eQ8HLYr010+yCJGYxEFlYIliMYCd/IHL8E4
	uxtGFizA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2SQT-00000006nny-3WCt;
	Wed, 09 Apr 2025 10:12:57 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RMy-00000006f2O-3HEp;
	Wed, 09 Apr 2025 09:05:18 +0000
Date: Wed, 9 Apr 2025 02:05:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: alan.adamson@oracle.com
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Message-ID: <Z_Y4TFTqriOTxXsO@infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
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

On Fri, Apr 04, 2025 at 03:42:50PM -0700, alan.adamson@oracle.com wrote:
> When dumping the awupf value with nvme-cli, the values match what was setup
> in qemu, but when each devices atomic queue limits was displayed, it didn't
> match its awupf. Currently the awupf is saved in the nvme_subsystem, but the
> awupf is specific to the controller, not the subsystem. Two controllers in a
> subsystem can have different atomic parameters.
> 
> The commit 81adb8633491 ("nvme: set physical block size and optimal I/O
> size") added subsys->awupf.
> 
> I think the awupf belongs in the nvme_ctrl structure.

No, that would be extremely dangerous.  But as NVMe has not explicit
language to forbid different values for different controllers (even
if that is really stupid) we'll need to reject adding controllers
that have lower than the initial value to not break setups.

Sigh..  I'll also reach out to NVMe to see if we can ECN this, but
we'll still need to work around this.

Alternatively we could stop supporting AWUPF entirely and require
NAWUPF which must be the same for all attachments of the controller.


