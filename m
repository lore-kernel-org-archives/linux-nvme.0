Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F037C43331
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB96C2083E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 18:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nd1OfRGd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0MFRh6Tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB96C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TkbBgXjIszPkhQYDFFuVqhpHiIxxPS15ewu5hV5MJQI=; b=Nd1OfRGdDCnU77
	3NVVaigh79ehCo09CtxknZKB+EWOvNMxDTeru0WaIRxiWqcgJKFDABbq/APLckGU8XHpuUojDkmpd
	MyOFJtCwwPFIldet4b5BwW2LVmO+UlYwXoIPJN04qmdqpW9B72vy3b+cHKkSFIgBOgm240wNtKxe6
	8pLpPocAetjOc3vy5W3Bcv+ptS+rtxMt/+bQaJoL6QkPaaRGPHrkK8u7xLkks0jaWcg2XSmITVwXa
	MRNj0Z+cjbhlkdv5uy0ZnNOdmJQdC0we+MOAJSCL+wApdSRGXVQ/CQVs0wIzPqB4Bas+kVNmOYSlW
	TdiW+XZnrhPwyCXpdO/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHtYy-0002yh-6f; Fri, 27 Mar 2020 18:18:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHtYv-0002yM-Li
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 18:18:34 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EFF742083E;
 Fri, 27 Mar 2020 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585333112;
 bh=nD1ZASDin7IOUe/665O+N3wleArI2IiupnuXq6p37/A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0MFRh6Tqf32c/CY26P6nrLMdJDOc6f/E8tygCg5stx2gYsuuEOpUS4B+rYa563rkI
 EeQfyM6ZB1JpwQkM72ZyTSn8teCyqqVAtimB3Ziln92WNuBiUGaqPVTo2g2o2vrJh4
 P3ZF85J5gqJepjB2WMibEM8sfNyZI/gKEbAQ8QVI=
Date: Sat, 28 Mar 2020 03:18:25 +0900
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
Message-ID: <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200327_111833_743590_DBC4FC63 
X-CRM114-Status: GOOD (  14.09  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Mar 28, 2020 at 02:50:43AM +0900, Tokunori Ikegami wrote:
> On 2020/03/25 1:51, Tokunori Ikegami wrote:
> > On 2020/03/24 9:02, Keith Busch wrote:
> > > We didn't have 32-bit max segments before, though. Why was 16-bits
> > > enough in older kernels? Which kernel did this stop working?
> > Now I am asking the detail information to the reporter so let me
> > update later.  That was able to use the same command script with the
> > large data length in the past.
> 
> I have just confirmed the detail so let me update below.
> 
> The data length 20,531,712 (0x1394A00) is used on kernel 3.10.0 (CentOS
> 64bit).
> Also it is failed on kernel 10 4.10.0 (Ubuntu 32bit).
> But just confirmed it as succeeded on both 4.15.0 (Ubuntu 32bit) and 4.15.1
> (Ubuntu 64bit).
> So the original 20,531,712 length failure issue seems already resolved.
> 
> I tested the data length 0x10000000 (268,435,456) and it is failed
> But now confirmed it as failed on all the above kernel versions.
> Also the patch fixes only this 0x10000000 length failure issue.

This is actually even more confusing. We do not support 256MB transfers
within a single command in the pci nvme driver anymore. The max is 4MB,
so I don't see how increasing the max segments will help: you should be
hitting the 'max_sectors' limit if you don't hit the segment limit first.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
