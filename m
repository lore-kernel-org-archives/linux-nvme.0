Return-Path: <SRS0=Tdqk=DE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8A5C4346E
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 06:07:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A44A239E5
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Sep 2020 06:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DoVbB9Du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A44A239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jLb0cg8Sdph8rzAHN8YFRazxJmcdt0pJXqQuriyKgR8=; b=DoVbB9DuK6MfPdC96KxKewGuV
	qcMQHirINSFvkjYRf+9SgO5w8i+y5UWXgEFh3wlV+5HM1Ag+NtFtCMIjJ6hB+9jLz6knbxvmiiI2o
	CS4XpHziHutUPBivU6ArD9XvyEFBMVfQj26C3qFjMqveIC9462ExL91cjWJBLzD9YzhtiGhx1XjM7
	lhkRlpUDoYvMLXPTaAGnHRMzdB7jwKt8oILR1NcULf9oMWob9vWh8HaSspa5ZHzSh/8xzVI125ObY
	aJO7stuEYGpQ4wRVPAM1GO0Tb/iFUstjldmPCrWB/ZNTm/D3Q59lMnTiIKspUw+80meLeTkbOEtwe
	D03R4l81w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMPq9-0001Jk-1g; Sun, 27 Sep 2020 06:07:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMPq6-0001JM-P1
 for linux-nvme@lists.infradead.org; Sun, 27 Sep 2020 06:07:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AD66568AFE; Sun, 27 Sep 2020 08:07:09 +0200 (CEST)
Date: Sun, 27 Sep 2020 08:07:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC] nvme-mpath: delete disk after last connection
Message-ID: <20200927060709.GA24024@lst.de>
References: <20200925213819.224198-1-kbusch@kernel.org>
 <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f8fdd99f-84da-bf68-a07b-7a6200cc02ab@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200927_020714_924543_AA338733 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Keith Busch <kbusch@kernel.org>, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 26, 2020 at 01:16:51PM +0200, Hannes Reinecke wrote:
> I'm okay with that in general, but then again we might run into situations 
> where an 'all paths down' scenario is actually expected (think of a 
> temporary network outage on nvme-tcp).
> So I guess we need to introduce an additional setting (queue_if_no_path?) 
> to be specified during the initial connection.

The original design was pretty much intentional as and all paths down
even usually is temporary.  So any change in behavior should be based
on an optional instead of a change in default.  And I think the right
way to do implement this would be a timer when to take the gendisk
down, with the default remaining infinitity.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
