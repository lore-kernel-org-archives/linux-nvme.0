Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5F0C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 13:04:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB486109D
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 13:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB486109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fused.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-ID:Subject:
	From:To:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T1Z3aljYiO/ScLIJjy8V6TEkaEJ3jquuogoTXCZYkrA=; b=41dTG0AhvVOSkX
	A9PDKbIy/xFkroqXQYb+n6X3Psxcvzpbif8l49pteIVtcZjKz+oQSMNKf2IyPCIta3h7OZvJtVNba
	CnwFMKWkJf1CMqSqFKMO0do8oob6tjMsr43qv/7ZaCbD5YaRmEjnj+os6FOxKksnQ32TO553SmSbq
	e/Nc/9djADUfj+rSxbnaNaiJ+TIO3AVQLgokXaHMpNW0ipTvQ4mBqW88S8pXQL2gMukOL5jfislGG
	2haEqxuAR5qFl/ZRCFCBRFOgqc7ZkSTiPhiXeY6MwV7l4qeW8tcQ1hQlvghCgRd5EYaiApuDo/YvI
	TGXT4OL2F54ywmYvimyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSIyP-001ip9-I1; Mon, 20 Sep 2021 13:04:41 +0000
Received: from bb-3.out.fused.email ([69.162.149.152])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSIyM-001inv-Jg
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 13:04:40 +0000
Received: (Haraka outbound: OUT) with LOCAL id
 91AA6BBB-1D43-4D93-BC1C-901F7CE42D59.1; Mon, 20 Sep 2021 08:04:38 -0500
Received: from in7.smtp.fused.net ([10.77.1.147])
 by out-2.smtp.fused.email (Haraka) with ESMTP id
 91AA6BBB-1D43-4D93-BC1C-901F7CE42D59.1
 envelope-from <ylkml@fused.com>; Mon, 20 Sep 2021 08:04:33 -0500
Received: (Haraka outbound: IN) with LOCAL id
 CE31FBF3-E8E0-49D5-A027-4F59CE6EA2D6.1; Mon, 20 Sep 2021 08:04:33 -0500
X-Haraka-FCrDNS: static-52-119-46-66.at.fused.hosting
Received: from [10.50.1.10] (static-52-119-46-66.at.fused.hosting
 [52.119.46.66]) by in7.smtp.fused.net (Haraka) with ESMTPSA id
 CE31FBF3-E8E0-49D5-A027-4F59CE6EA2D6.1
 envelope-from <ylkml@fused.com> (authenticated bits=0)
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Mon, 20 Sep 2021 08:04:32 -0500
To: linux-nvme@lists.infradead.org
From: Yuri Arabadji <ylkml@fused.com>
Subject: lack of security
Organization: Fused
Message-ID: <da4d6647-7c05-676f-e37f-8b245c66bf19@fused.com>
Date: Mon, 20 Sep 2021 16:04:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Language: en-US
X-Haraka-Karma: connect: 9, history: 1199, total_connects: 1965, pass:auth_user,
 headers.pass, skip:penalty
Original-Authentication-Results: in7.smtp.fused.net; iprev=pass;
 auth=pass (plain)
DKIM-Signature: v=1; a=rsa-sha256;
 bh=DuLodjqbybNd8rBtWZlz4S7sVfvLR7GuXBSNAJU1uU8=; c=relaxed/simple; d=fused.com;
 h=from:subject:date:message-id:to:mime-version; s=default;
 b=h8GPFLXd0jJ2jbMm0ZW/5oCyGTOh/yZVM4EiVCDy1/5Ozeic5qRj5r+fGWimRm82exuKMWu6+4Ps/BSgolePiCcrQ0Jwu8cObc2yH+R2AgfKWUzfTsQPzLbALhJC5uaoWAoVD7AzRftDuXxwsSiZN+P3LNrlJWMe/1ATS+0awivFUM4gJBoi5V4zDGFAJGW0T5K88rS4mbqAFQRjuVQiaMDWh35L5xejE3JRLYlZCyuNW45/adwLX76rtb9a+TmvUj44sle78XykSLq3vLdYaUoAMS2xU8wQ+Sxce0FWIgaVpWwn4Uu5LbqoWLN9E/l9aLmx/AWGMfIlEKjh+PBVrg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_060438_797959_2A801726 
X-CRM114-Status: GOOD (  13.20  )
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

Hi.

First of all, this 1980's era maillist should be ditched in favor of
GitHub-like collaboration for users. I wanted to submit a bugreport, but
instead had to go and adjust our mailer to suppress the greylisting and
holdoff ehlo timer because somehow yours mailer wants to show off his
manners. Set something up like bugzilla or github issues. Leave maillist
for coders/old people like yourself.

Now the issues I'm actually after.

1. Lack of security

With iSCSI, I have to supply a user and password.
With nvmetof-rdma, the only "shared secret" is the host nqn. This is
totally fine with me, except that for discovery, it automatically uses
that special nqn and with target configured to accept the "shared
secret" nqn, you get (as expected) the following on the target:

nvmet: connect by host nqn.2016-06.net.fused:node1 for subsystem
nqn.2014-08.org.nvmexpress.discovery not allowed

All guides out there suggest configuring nvmet wide-open. This isn't
what I want. More than that, I'd like to point out the current trend in
which companies started to prioritize security over performance.

This needs to be fixed in some way or another. Possibly allowing
discovery nqn to retrieve the directory, but denying connection to a
subsystem (or how do you call it -- I don't know the terminology).

2. block sizes wrong

# on target, an LV:
NAME                ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED
RQ-SIZE  RA WSAME
fused-random--disk0         0   4096      0    4096     512    1
   128 128    0B
# nvmeof on host:
nvme0n2         0    512      0     512     512    0 none      128 128    0B

As you see, minimal, optimal IO, physical sector size are all wrong. I
don't care much about rotating, but I would really care about optimal IO
as that's a hint to queue scheduler I guess.

There's no attribute to adjust in /subsystems/X/namespaces/Y to manually
set the values.

3. feature request.

I also wanted to store a custom string "attached" to a namespace, to
identify the blkdev I'm working with. I could get off with a serial, but
that's so UUID. I wanted to have something more humane.

Thanks.

--


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
