Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9293BC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:18:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97966192A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 11:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97966192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nrr26z7kUN3DCMg0ZZpU5IlVgr0z1bQ55uqOQ0IA2tg=; b=oFYmZ5slSvfd1UkMMbtmbdYTu
	Bh/bOUe/il3snRV3DjXHp6ZfH+7POHF0d5zOwMbeEo9Io7fUW8LIitSjIwgJrr9AZTnk+Xcgf0d0g
	H4xUoor89ssPBd8f3lmnycaPGkeAGsQ5YyueJ0K+tR3KNZBdbA4aR24NKQdO6NVxU/qL18h6xF2Wd
	k1Kxj2kQKtesVX0+cFlM6Q/oYxizZf+3buhUeeHpVd4SlD6/QWuGxzfBARVkDnsxDa2aLBi/1EV9q
	HDDtjrM7Sav7o0bEWZDom5z7Jb+y8rHrmBHpudQ65xIP67FZ8IRAXZw2/3uq6xmX/peKx3mcfEXjK
	yKYigV0pw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgQP1-00H6H3-Ca; Tue, 11 May 2021 11:18:15 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgIdm-00G9MZ-Cx
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 03:01:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=w2zXoyKFVFZOKOeLCjd0THqCEufaJ0exHCwDWKSiLlU=; b=ImN3ptUnUALvEv19nU0rCm/c1V
 XA1STXCcRB4mSEn4hrt5/A3ec2J7zl7mv9fl8Y9EHxPdUoaA6qoi5GlGDxk2CeUaJ7kwPS7/LQU1m
 8gFbL/2yJ027YCfOA5hxF1Ka73J99w74dDt7a9IXdz4TeKVofm9vBhiBaKQbkYirDJ4TMW1F7PavQ
 MxBKVx7xBA6EOozz2WRG1eLmarAbsV6CZgCrfV3bpB0DBEtFLN6NiKwEiRu0r1w9skJtVInuMjL4v
 qOQ/ey06Davrkt5QRk1Hxf26T6BLDtIHcevNPtA1BUpumSpD3BKMK17BGbMnJUTTrbgd5dV7HoAbR
 v7e+nhGA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgIdh-009Glh-QS
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 03:00:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3232C61448;
 Tue, 11 May 2021 03:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620702053;
 bh=t7m/bt4IN50ODxxcB+23WX00yj+n/Z07UWXdh117wHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vKcwNH06kKx+sGG6QMVqym6aY2oSSHb5iXVxLjx1TNS4bX7RcUrVzB1F6APC+jeMV
 VmT+D45o7YdkhWIDnK+nZLB2Ys94NPhzj/JStPN8pLAa7k3p75z7BsF99dVVW5++jy
 YV2ZCRVCN0fA1VuhbIDMfxdFmsHWadsvk9RZ0XgMGbNTmZO2MxAXIw1uPONxHFNQA0
 VWXH44LW4E34qxsYWlm2JYHKoyy6Dn8wD7RLoJX0SLZbJ3dan5JyYopmReZTg7OXf9
 ZZ8t2dZRH70fRpQru7Yk3tD9tj53t3IWPl5OU0fTDirvEw37nvGQj+G/K/KDH3FSOe
 OBmxPIkSMMS8A==
Date: Mon, 10 May 2021 20:00:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210511030051.GD1857448@dhcp-10-100-145-180.wdc.com>
References: <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
 <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
 <20210510180633.GB1857448@dhcp-10-100-145-180.wdc.com>
 <6838b8da-7e05-a08d-b67f-1fe28b0d880b@grimberg.me>
 <20210510183040.GC1857448@dhcp-10-100-145-180.wdc.com>
 <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9a6fed85-2f8b-8398-1e8b-cd44e6004f40@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_200053_896734_EF60EE91 
X-CRM114-Status: GOOD (  20.44  )
/bin/ln: failed to access
 'reaver_cache/texts/20210510_200053_896734_EF60EE91': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_200053_896734_EF60EE91 
X-CRM114-Status: GOOD (  16.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, May 10, 2021 at 02:07:47PM -0700, Sagi Grimberg wrote:
> I may have a theory to this issue. I think that the problem is in
> cases where we send commands with data to the controller and then in
> nvme_tcp_send_data between the last successful kernel_sendpage
> and before nvme_tcp_advance_req, the controller sends back a successful
> completion.
>
> If that is the case, then the completion path could be triggered,
> the tag would be reused, triggering a new .queue_rq, setting again
> the req.iter with the new bio params (all is not taken by the
> send_mutex) and then the send context would call nvme_tcp_advance_req
> progressing the req.iter with the former sent bytes... And given that
> the req.iter is used for reads/writes, it is possible that it can
> explain both issues.
> 
> While this is not easy to trigger, there is nothing I think that
> can prevent that. The driver used to have a single context that
> would do both send and recv so this could not have happened, but
> now that we added the .queue_rq send context, I guess this can
> indeed confuse the driver.

Awesome, this is exactly the type of sequence I've been trying to
capture, but couldn't quite get there. Now that you've described it,
that flow can certainly explain the observations, including the
corrupted debug trace event I was trying to add.

The sequence looks unlikely to happen, which agrees with the difficulty
in reproducing it. I am betting right now that you got it, but a little
surprised no one else is reporting a similar problem yet.

Your option "1" looks like the best one, IMO. I've requested dropping
all debug and test patches and using just this one on the current nvme
baseline for the next test cycle.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
