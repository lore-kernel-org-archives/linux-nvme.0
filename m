Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55CFC4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203092222D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1fHrm66p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRTcNHWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203092222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NrEoIJXSxZXB1vd5n+J3iPCEkD6/iMAqVSdEyrDJFHE=; b=1fHrm66pPXPXs3+fbqRVXSI82
	Zvcpjodpukl6szaB7hPaai5yukHx8YdBFyc216JttsmOdhrf3iRfqyfuUUFUrB56h4iW6zOglgDWd
	nAJBZDOxQRswHL3RiC2sfdbkFT8BuUzFleNog5A0whFjfof2L0pTqBvh3MqQDSTowfcDrrDUdH+kf
	RLvU6+OtoeCcL8p5TBBpbpqiRRVyiq+b4yoxyO2gaOWiOog/QXCkjKmjq8AQ2tC7FN3XSeIKhCGA/
	/i1zdkFInL7WvlpppglSv7R3yJm567aa0gndVwWhL1LC15GDAJDXdUCh9he2J4RQ9fAKo0Ply1yFL
	nLZGYP2Fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUtLM-0003uv-Oz; Tue, 20 Oct 2020 15:14:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUtLJ-0003uY-I8
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 15:14:30 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 267E62222D;
 Tue, 20 Oct 2020 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603206868;
 bh=XjdUx1gsxk3zxxC14itK7Gha6jLSAuycoV/gefZJxHA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RRTcNHWQQICbbgNCbKU8JBKJSlzXDmWHxa84Y5/y5LUZRowulfJOkjzXyi9fAi8oo
 fIeUI0uGAg4Ga7GO1LiXcCxxSUG3N/aBR1w/K8+7zV8T36b+Pq6a1ITX9nbycmpFf3
 n3PFFI3uUgkSR1AIfzxKGe46Fnb4MOrQ9sd8sqQY=
Date: Tue, 20 Oct 2020 08:14:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH libnvme] examples: Add src/ into the include and library
 path
Message-ID: <20201020151426.GJ1435260@dhcp-10-100-145-180.wdc.com>
References: <20201020124531.238269-1-hhan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020124531.238269-1-hhan@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_111429_691001_C1DAC21B 
X-CRM114-Status: GOOD (  13.08  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 20, 2020 at 08:45:31PM +0800, Han Han wrote:
> diff --git a/examples/Makefile b/examples/Makefile
> index be867a7..24f8574 100644
> --- a/examples/Makefile
> +++ b/examples/Makefile
> @@ -1,5 +1,5 @@
>  CFLAGS ?= -g -O2
> -override CFLAGS += -Wall -D_GNU_SOURCE
> +override CFLAGS += -Wall -D_GNU_SOURCE -I ../src -L ../src

I guess the examples assumed the library was installed, but that doesn't
make sense if you're testing within the repo. Patch applied, thank you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
