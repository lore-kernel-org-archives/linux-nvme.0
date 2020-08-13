Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAADC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A07220866
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 11:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="18f0yWZI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCEx3dEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A07220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kP4ZbsZUd9x9sF9hrM+rKy/XYPZn5nWz+Qmo3UWXB84=; b=18f0yWZIkW3p9y+K5o/hFqAPk
	t0u97qO+6aCI7kbXv3Q9ZH5Qcii927OJY3LnVaGtOKQWHB3fX+80L7X+aC/fCvrvJILpszP111oc2
	ngMKQMIDAKesSJL0Unp4bZXblercMnzU3Pf+oSvAPjUy6Nci4jrqSq/Qua1IJ3xNEW6HgtBsBnSqe
	E56oje8oErKhpMTKVAKKGkwqTX3jHNr/+Fj0tc4SX/qJ0PnTHEdnzWryDFtFdIbw/MbG56NkstnrR
	b7Gz30NazmxfzPVxeMYJ6SCsNgRHMAjV5XnQ2d4EJZCBfNXx/lMDSTlIlrscczBSvaw4jcpovOpkZ
	gRRL8L1Tg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6Azv-0008N6-67; Thu, 13 Aug 2020 11:02:15 +0000
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6Azq-0008MY-Ko
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 11:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597316527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nwL7q1BwwvotEeVmc+CSbaiUfly+O7IY6Ee0/xsv+Z4=;
 b=XCEx3dEB+eBUJGtUvcIS7N+cT8fSyF+Z0x8Yd2e2CgkzpKtwm92FFoRNK2MU8SfaiWbnkB
 B/O5qZUPEW1nd3xK215IbKgZIUQajohgraNil6tCvS1xjTWPnx0Z5ouotXzMpBSUB7ZxJB
 WXnwthNsOnBHtPwgTAmAq8rqvxOK5Mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-zhypoalJOp6vop8aM4OiVg-1; Thu, 13 Aug 2020 07:02:03 -0400
X-MC-Unique: zhypoalJOp6vop8aM4OiVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1506F801AAC;
 Thu, 13 Aug 2020 11:02:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C24F5C1A3;
 Thu, 13 Aug 2020 11:01:58 +0000 (UTC)
Subject: Re: [PATCH v3 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <716a47aa-dd94-d503-80c9-6c31260de31c@redhat.com>
Date: Thu, 13 Aug 2020 19:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_070210_750291_0B2C12BB 
X-CRM114-Status: GOOD (  21.27  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/12/20 5:00 AM, Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
>
> $ nvme_trtype=[loop|tcp|rdma] ./check test/nvme
The executing cmd should be:
$ nvme_trtype=[loop|tcp|rdma] ./check nvme

Also described in
[PATCH v3 5/7] nvme: support nvme-tcp when runinng tests

> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.
>
> Changes from v2:
> - changed patch 6 to move unload_module to common/rc
> - changed helper to be named _require_nvme_trtype_is_fabrics
> Changes from v1:
> - added patch to remove use of module_unload
> - move trtype agnostic logig helpers in patch #3
>
> Sagi Grimberg (7):
>    nvme: consolidate nvme requirements based on transport type
>    nvme: consolidate some nvme-cli utility functions
>    nvme: make tests transport type agnostic
>    tests/nvme: restrict tests to specific transports
>    nvme: support nvme-tcp when runinng tests
>    common: move module_unload to common
>    nvme: support rdma transport type
>
>   common/rc          |  13 +++++
>   tests/nvme/002     |   8 +--
>   tests/nvme/003     |  10 ++--
>   tests/nvme/004     |  12 +++--
>   tests/nvme/005     |  15 +++---
>   tests/nvme/006     |   7 +--
>   tests/nvme/007     |   5 +-
>   tests/nvme/008     |  13 ++---
>   tests/nvme/009     |  11 ++--
>   tests/nvme/010     |  13 ++---
>   tests/nvme/011     |  13 ++---
>   tests/nvme/012     |  14 +++---
>   tests/nvme/013     |  13 ++---
>   tests/nvme/014     |  13 ++---
>   tests/nvme/015     |  12 +++--
>   tests/nvme/016     |   7 +--
>   tests/nvme/017     |   7 +--
>   tests/nvme/018     |  13 ++---
>   tests/nvme/019     |  13 ++---
>   tests/nvme/020     |  11 ++--
>   tests/nvme/021     |  13 ++---
>   tests/nvme/022     |  13 ++---
>   tests/nvme/023     |  13 ++---
>   tests/nvme/024     |  13 ++---
>   tests/nvme/025     |  13 ++---
>   tests/nvme/026     |  13 ++---
>   tests/nvme/027     |  13 ++---
>   tests/nvme/028     |  15 +++---
>   tests/nvme/029     |  13 ++---
>   tests/nvme/030     |   8 +--
>   tests/nvme/031     |  12 ++---
>   tests/nvme/032     |   4 ++
>   tests/nvme/rc      | 122 ++++++++++++++++++++++++++++++++++++++++++---
>   tests/nvmeof-mp/rc |  13 -----
>   34 files changed, 322 insertions(+), 179 deletions(-)
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
