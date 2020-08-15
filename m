Return-Path: <SRS0=fF/j=BZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D82C433DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:01:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E73621744
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2020 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DZUA65f5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gx5eNYOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E73621744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pssTBf9YDQeet1gYyZWGlv3sOLyLCuS3NpFceGf9v5A=; b=DZUA65f5pwASvMzY52XTQJgwo
	S9V3xNbSJQfbcj84YRCR9ssRl/AroM98qk6IwvGsU9soZXM6umeGVNNzysaFAbKovJ42upoeWLDJm
	bp0oM38d5j2Jk/xetw1x7mlu9mQkNVsd1mGf590fTEKS0/sT8sS3P5ay2GShCZgEAX+0xhhWaOM8b
	iNyuKQLjT/Ehllmi4vi1R05Xe83Oa4Yyw+3o/XHWOC9TkkS12X0Cg3KCHt8LPR+Cu3WZkoE9dgT6k
	OHcbenvl+TtLf8dY/nZO0iCfZubYqB/IoYjTW4Lj6Z6kOtxjTeGsjD1SKGALdYLNeJ0rlD7lcSTPx
	QhrYWmPsA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6qC9-0005k7-U8; Sat, 15 Aug 2020 07:01:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6qC8-0005jv-BD
 for linux-nvme@merlin.infradead.org; Sat, 15 Aug 2020 07:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=XkkiwYq1cuVeDANYE9l/FNzsA2d1iJbOf6KTMrLsunE=; b=Gx5eNYOlEKquwDZGFCCmBFWX77
 iDkkcUHDilMjUq+GOhm5pNx466IevrH8a4nSv9Cg6WzyLiZo0/pvMj0FQLQIKVtOx4dGAmIFcUBvy
 qvIn9b9A1nKz8IlTjs28i99buck8FRT3zesxUTviTZBjcEaxTUxnxv+jnamcJ4BqpqC8051i5v1R0
 7K2eJP095eQ94RPxK66YtixMtlPA2XYKW6oFCqacR7EQbWqclKbTHoBQsMQ6lbaHr3WXXau2bZUpm
 Nci0VVntN6voW3FBBfNEwyXvk53A9xTTw5ZUpr3PKjA3K985NSGo3XHt6BU/J4ZKyAjZVHFX7qKMU
 1Vkt0HMA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6qC7-0005UK-0i; Sat, 15 Aug 2020 07:01:35 +0000
Date: Sat, 15 Aug 2020 08:01:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200815070134.GB20460@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
 <20200810124036.GA25070@infradead.org>
 <MN2PR19MB3005A46208EE2B65E5F9B330EE440@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200810154846.GB4159317@dhcp-10-100-145-180.wdl.wdc.com>
 <462babf2-7cde-af4a-8bf9-a5b230e282b7@grimberg.me>
 <20200814082015.GB18371@infradead.org>
 <20200814100911.GA9975@infradead.org>
 <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <83dbae6f-01a0-a9a4-9271-de8c1cf06c66@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 "Engel, Amit" <Amit.Engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Anner,
 Ran" <Ran.Anner@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 14, 2020 at 11:29:57AM -0700, Sagi Grimberg wrote:
> 
> > Amit,
> > 
> > can you try the branch below?  Pretty much hot off the press, but I
> > think this should address your problem:
> > 
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-pr-fix
> 
> I like the approach, but I think we'll need a bit more path awareness
> like we check for available paths if we requeue or fail..

If there is no available path, nvme_find_path will fail and thus we'll
error it.  This is the same mechanism as used by
nvme_ns_head_submit_bio.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
