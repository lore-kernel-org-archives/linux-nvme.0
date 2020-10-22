Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E31C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:25:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379B724631
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 22:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrEuH9aA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="jPpvxa5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379B724631
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hpABCQ0tMF1+phwduQSoJVsGrLx4fOjzAMSKlGkjPog=; b=DrEuH9aAk82f+pNQ3ZkQWj/Mc
	F9xl8D22Q4uZdLi0l8vLerhR9vxPws9764YWxTL7GwamN8clFKY7V54mBVA/F8yfJLbWyhLZyUJZo
	OooUnJDaiGflfbOBgzkkTpovCL7Lob/BFYsd+ZbdecvTovI7yqKrK0yhKNgnrtB48yh9+OO8AlM1S
	4Bg5LeFqRtmgBCBi85NebO2xwZvrJVrCQOxA9fSLnO2Mx4sgYVobfDsk/JoUpQZ66RadIRWPJojWu
	21WD2eidSibSgTXCV18vI0vp3oHQOi8DPwnIoToOZuK1r1DVsKy0lDwmCckxxJvCjJbcqh5ecDNTH
	mFVqWFIjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVj1b-0005GG-Co; Thu, 22 Oct 2020 22:25:35 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVj1Y-0005Fd-94
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 22:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9KIyS8u6oc8AJBGGp4mSeBUZ13SZ6CgKdsvjS5de0m0=; b=jPpvxa5eG3kzWlYlXtiz1X4dc/
 Adl1lVrJTuKBGIugrXCImIFLT9quV6T+xOIPTOvfmCPOAMwaGODftAnwqJpEpNnBxZj6Kr08CZPhS
 bvmvAk9EnawxMM+C/xPOI01S1cWelqbPIzonpIJJcviO5TydPxKW3d/OjsK91/Vd38/As+w0TcA18
 SY7WMtKiV/SZGG+YU/U9JYHap1LzYCCB0O7/4ytWBhUzBNddhqe4XDGFH8qkK2babve7fXMT/rBW9
 sj4IIqJIgysrBZ/JFCfJD9kid8dGJeNvE+2r2YT3Cz1QGgInYzkUxVmUHUybPrl8JgZLJxoAiGiYE
 mXryL6dQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kVj1T-0005dE-Gc; Thu, 22 Oct 2020 16:25:28 -0600
To: Omar Sandoval <osandov@osandov.com>
References: <20201008164024.12546-1-logang@deltatee.com>
 <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
 <20201022220412.GB1006674@relinquished.localdomain>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <088efbf6-efb4-5a0f-2295-cedba2c150ea@deltatee.com>
Date: Thu, 22 Oct 2020 16:25:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022220412.GB1006674@relinquished.localdomain>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com,
 sagi@grimberg.me, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_182532_344187_BAC01A1F 
X-CRM114-Status: GOOD (  13.62  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-22 4:04 p.m., Omar Sandoval wrote:
> On Thu, Oct 22, 2020 at 12:45:25PM -0600, Logan Gunthorpe wrote:
>>
>> On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
>>> Hi,
>>>
>>> This series adds blktests for the nvmet passthru feature that was merged
>>> for 5.9. It's been reconciled with Sagi's blktest series that Omar
>>> recently merged.
>>
>> Bump. This has been around for a while now. Omar, can you please
>> consider picking this up?
> 
> There were a couple of shellcheck errors:
> 
> tests/nvme/rc:77:8: warning: Declare and assign separately to avoid masking return values. [SC2155]
> tests/nvme/rc:278:7: note: Useless echo? Instead of 'echo $(cmd)', just use 'cmd'. [SC2005]
> 
> I fixed those up and applied, thanks.

Oh, oops. I must have introduced those very recently.

Thanks for fixing it up and merging!

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
