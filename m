Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3E5C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE1E2074D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PHtDmrID";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BNQfSmSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE1E2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nQexjg84bOFHCMq1PzDw3V9MWuBvFSgbwxfTcE/EeAI=; b=PHtDmrIDmduDHZuz/2Myc23kl
	lBMn8w8J8WmbbLOOe0s49SoXmyFi6tF+KEutx8c41xwNLwGQtvA5x+AJSg4FGdaYF9bsaTyCinjin
	YhJNBJ20ssUzX1FeL9l5mewL2uz65LlIWk02T3zUoCIPq773mS2LKKJ4QuldZVydKffafQTvYXAYw
	vZqqzJbFmvoYL0dBB9EN16shaIVafL3m/RnepxJltFBG3KHsav5A7FCgpDMVrpb6UtfZ2udScj6I1
	5TbKc5hHx7ZtVuz23HQRfLXDlXzG2dldUYtLwN6nNDL7ghFGyuAt0cYUzMM1r03muLSCuUOP13SFM
	9jtS2/IWg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEE1L-0000eO-0y; Fri, 04 Sep 2020 15:52:59 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEE1I-0000dn-Pu
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 15:52:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P1djXWMn42vRNOqFDi+hzs5if5OiqHl05S8IjUoubNw=; b=BNQfSmSkjrFR5b9h3T/tVP2ADN
 RGBUOjLEzXEGTAMiUVE43IuRd3f+LCwIlvnBjwtrYJ/NBdb7Z0bIcDTWOVk6XPcFf7plZV1o3DZyX
 ThVvZDmf1d0NC1SXB+mj3UV1dlQtwEYo1R7ge2e2IKQqng4el5QXEvMBZPNG+9dN32vLrotiIxnVe
 Dpld3kW7NMmILNaQ6gkRxX4l7ffoDLuXhE5ZqGSjGtJejddsEUP3S5SVRGc/Q88SUpxG6p3TFzYj0
 YCFEGd+kKstYJAhbTPKFGCZnOGo+o+W4QQ4Q8iyqyexMnbGxGinwBGnStSqe7oKgX4AI+2LwBTwKE
 /nyzQRPw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kEE1E-0007o2-L7; Fri, 04 Sep 2020 09:52:53 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <862f5256-46ee-c411-425a-8bca27aad35c@deltatee.com>
Date: Fri, 4 Sep 2020 09:52:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, osandov@osandov.com,
 linux-block@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200904_115256_901079_09582D6E 
X-CRM114-Status: GOOD (  16.90  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-09-03 5:53 p.m., Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
> 
> Changes from v6:
> - fix _nvme_discover wrong use of subsysnqn that is never passed
> - move shellcheck fixes to the correct patches (not fix in subsequent patches)
> Changes from v5:
> - fix shellcheck errors
> Changes from v4:
> - removed extra paranthesis
> - load either rdma_rxe or siw for rdma transport tests
> Changes from v3:
> - remove unload_module from tests/srp/rc
> - fixed test run cmd
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3
> 
> Sagi Grimberg (7):
>   nvme: consolidate nvme requirements based on transport type
>   nvme: consolidate some nvme-cli utility functions
>   nvme: make tests transport type agnostic
>   tests/nvme: restrict tests to specific transports
>   nvme: support nvme-tcp when runinng tests
>   common: move module_unload to common
>   nvme: support rdma transport type

Looks good to me. For the whole series:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
