Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36322C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:04:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00151207CD
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOKShwIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00151207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UJBbXOFUkBljMuD5bi38jYYALODGA+o9CljeRhyT2Vc=; b=bOKShwIRuU+qQiXfntMn2/fbU
	z9y666O14F9Pih1UupANHKRaTEREyv0bryfcpn0NmBrelWOl6c72Ta1EpyFL6Q5cltZGNbmycEdqH
	HoNkGt9MNg11hWJ/u2RYBHuG4Lmuw+YNcpQU4MbPIkfJ3dSSq/1W5cTbPWSH1CyTAO4vgEwlNroNo
	vQJ6ISpXYgCX5LXrxT7JSqKRsYSe0RK6EqmFWtzYRnTRjQncCLcMyRydvn/0LcNCb5mwr9oScbJoo
	ln+4PZYmvGuozl3vrM6PlGpXmkwJEANKxeDnlDm9K28osKXORrh6Fxg/g1AX9rGxAuG+LZn/F+kXe
	as/UBgQJw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvIjp-0001gc-Vb; Tue, 14 Jul 2020 11:04:42 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvIjn-0001g3-WF
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 11:04:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 81A0A68CFC; Tue, 14 Jul 2020 13:04:36 +0200 (CEST)
Date: Tue, 14 Jul 2020 13:04:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v7] nvme-fabrics: reject I/O to offline device
Message-ID: <20200714110435.GF16178@lst.de>
References: <168ed5d66eae49ac8b445478b1bb362d@kioxia.com>
 <ca82af03-0cf7-bb71-cf55-caf88c278dfa@broadcom.com>
 <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fee0ecca-3d31-a04f-af7c-7a3aada9d6fe@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_070440_167043_21A4DC90 
X-CRM114-Status: GOOD (  12.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "Ewan D. Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 09, 2020 at 09:50:13PM -0700, Sagi Grimberg wrote:
>
>> Looks good to me.=A0 Only nit I see is - why are we checking ctrl->opts =
in =

>> the xxx_failfast_work() routines ?
>
> Which brings me to the question, is there any desire to have this
> behavior in pci as well?

Where is this discussion coming from?  In generaly if something is not
transport specific I think we should support it for all transports.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
