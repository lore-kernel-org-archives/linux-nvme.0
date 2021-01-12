Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270FC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:33:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2519D2311B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2519D2311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vJ93sQICUzApTgK0Ul+fzROwP2mJmPbcs4XPc/+sTrg=; b=ypvKqsYgDC0kSqw8WjwXw4AIG
	U6W8N9jkWhu9ySzNj4BW8sdbrF1zW9uqcG5vS6DgEajtPlAapjzPNjuUfQaxkJ5G3Zfofvz8+bQm1
	CGsVsxO15Vkx1khWQS8uv43X57eNx8I+aQe1d6ikW9Rpimo7g60/EKCCZbE6msgETwt+/TI2BT/Q/
	ztAWJUbmKE4iXb92uRY39ihtBBJrVYOyRB7Day5MDPgaQhXbqi5f+n7nof0VQtP9AvX2kYU8GRDI4
	8+/SHVdcVhgMFDZmv5JDkF/op6Pwbx8keYoshKMregJYQ9Mtv7Fg0Ue1BtTgAp3ET9dhO4DMcwHz6
	FrBOsz8Ig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzOTf-0001tx-9v; Tue, 12 Jan 2021 18:33:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzOTa-0001rL-Uk
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 18:33:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B153D67373; Tue, 12 Jan 2021 19:33:03 +0100 (CET)
Date: Tue, 12 Jan 2021 19:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112183303.GA5050@lst.de>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
 <20210112183055.u3y34tfxh4d5aeue@unifi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112183055.u3y34tfxh4d5aeue@unifi>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_133307_150344_7416846C 
X-CRM114-Status: GOOD (  10.89  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 12, 2021 at 07:30:55PM +0100, Javier Gonz=E1lez wrote:
> I have not implemented multipath support, but it should definitely not
> crash like this. I'll rebase to 5.11 and test.
>
> Christoph: Is it OK to send this without multipath or should I just send
> all together?

We're not in a rush at the moment, so I'd prefer working multipath
support if you can spare a few cycles.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
