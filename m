Return-Path: <SRS0=VOor=J3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F597C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 16:21:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59DE61029
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Apr 2021 16:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59DE61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ct/haPzqexZar5EByNmC5KGaYkuPAMuXTiGEN0s5ccc=; b=CrQd4TPEmiE3rulPvbMtPzndV
	bUkxS1cat38XVkxwdGt1DynlbRwRCcIxXc3IfTiarMQN1/kd+eX6C5G0GboWOOxrB+TdIDGQCdq+B
	nX1vAs2xe5S1DJYhh58l/hh38NwCCR63mFn7HAAvEOTQsr0wOs3xjdcEyeLiS+NLjMuDNQNd1DViy
	iLhxxF7PdnR16XPIoDHLEG5nw7Vl7bpEQ0JtDGi5Ux+Evs9yXqLGo2VGkKyC0AeEQUVdkeWcxNuiV
	urOecPiyshnFGUuwvsDLpCCXHjUOKj7L/eiCE05Xs3ByRnbAq2kx6kjbozfUKHGuu6ELndiD3hZoq
	o+g7LZe9A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lcVtH-008BBF-A5; Fri, 30 Apr 2021 16:21:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcVt8-008BB4-In
 for linux-nvme@desiato.infradead.org; Fri, 30 Apr 2021 16:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jCYMpKh+KqyH7pS0WRH6lF6z70J6SkoY6uBPOzQA3II=; b=w/6uQgavjfehIvAIrQU2KbIjJ9
 KStHkESnaPe4+w7psRlGB5c9DGc02jzfKGwOvhC+bMfoSxjQQ0hcPLtN/bL90pMMPf2M5ZFOxpTXn
 R4IouWzVqkI8MutYnkY6/Wf+aPH36DccMJQa6xdxGRh/jqZ/HGdEUKbio5VWueChw3M0L98h6LxFG
 gpJxwNbqV604G52VcQEYwD3F0p5PGod/0oHmzUnxaD//gM7MzAS30fIVYwtfgLPwz7u2GLgb0YEuU
 EuesUSHVNoPXRKRaO541jwTDzl2KVRK6FgxTeE9KJPviJKec97MO1y1le1dIqoir9Pg/6SmWERJWL
 qGWchSJQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lcVt6-001VqQ-1d
 for linux-nvme@lists.infradead.org; Fri, 30 Apr 2021 16:21:09 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D14361466;
 Fri, 30 Apr 2021 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619799667;
 bh=YKHpMiKuim02tepqx41HbzRMxnqfRrhL5c2PE9fzh6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c+ao+lS5q52sKD6SupeBX1mly45CQxnTICW1PCP3MhtsP++kNSBecunAcQvTneIzq
 NiVwZaGzqOx4Q9cKcMPpxtR1I2Af9NXQFASOi0cTx17c+IuqSmVnIfneKTCtd9tVu3
 jamHB367IPNjMaPuE1DK/1Mx+13VYhZ6TwyIPmIpRc26eMSgk9OAElRnkx3mFo++GG
 EXQdBMAekPdN6cG/2CfILX03NhITNjDlUs771hd57StFqXoGJqNQT5s8gkgOENi/an
 z4jOuHFAo/VgXjksnv1ve1WvB1YzDWpxL1zDXDyiEqAr0gKFjLDlFsuWFAbKg9LEJw
 YxXxWSp6svRlA==
Date: Fri, 30 Apr 2021 09:21:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Rao, Vinay" <Vinay.Rao@dell.com>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Message-ID: <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210430_092108_145953_D277E50C 
X-CRM114-Status: GOOD (  12.32  )
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

On Fri, Apr 30, 2021 at 05:14:55AM +0000, Rao, Vinay wrote:
> + Madhu
> 
> Hi Chaitanya, 
> 
> Some of the AEN's like ANA state change and Name Space attribute change events are of interest outside the NVME driver. 
> 
> It would be good to consider these events to be propagated up to user space. I am not yet convinced on how propagating this above to user space is problematic.

The namespace attribute change event pairs with the Changed Namespace
List log, and reading that log will change the result for a subsequent
reader. User space racing with the kernel on a log access when there are
read side effects creates non-deterministic behavior, and that is
problematic.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
