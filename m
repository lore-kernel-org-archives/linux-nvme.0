Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55082C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 20:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tXnvzESxvtUiHdhbYsGHu6xaCkste6HlN8WKxYqvK4o=; b=NG09J/rSwm4C+0MnXRKTzJAs1Q
	8iVU9xwA94DeLg1xzdFV3hFG10nfTwg9BoJG2F9UxkUGnS2Rf8Vdckj3lDRFjQEM9tn2dbixakN/z
	dD7BbsEl7pzFBhA1ieO87wyco28/tKYarairTNPh16lwYPilh1Sk3iZQSfkW897kHu6XzQ/XLSqh4
	IvNK9WJa3D5PTvAxB5PlNej79aDGV7BdxAD8fF6xTO/lgBbiX/jdm5iOavDbElpaD9B+l32PwM2IY
	N2yhclOpV9YSiOUODS9WvFtmBQQScNPPD9t3FSLDyBuNiMfEe2x7vVxWI7zxKIcnn2MUAoQiwwG62
	W4PZ+mVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nugwY-000xM8-5d; Fri, 27 May 2022 20:52:22 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nugwV-000xLL-Nq
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 20:52:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 59381B82522;
	Fri, 27 May 2022 20:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F62C385A9;
	Fri, 27 May 2022 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653684736;
	bh=sOP9PXWBMk4mZfhTPdbsTyJafbjWBbSeASFLU29jWSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYJsPbkMQfGhjeJzMPCw0d49LmDEYKE67UmvThSCavfHCaML8QUgfSJ6swWwaaGMS
	 2IvB6v0YO6GgJZsc0plAat9HigK/5RTMH6szAakPvzzKVO3BGbQzSf7ViKKKwEDwKt
	 ncRa63nQB29LMPvSQ0tJU1sycB2aWjsmr7GFGQdttOJ98BpS99Kr4pO0bvN7+4Pv2T
	 AmhCE/F680Xn2iz41LvxYDvmcebStazFJy1l8aqZWqmurGDkYQl9r40XoHSMbd4Mjl
	 3sGuvXYd+W8Jtt+/k/BGsHacdTN3gPKK5yqJqqfWs3fb8BWUPlJ0nUNabGeyFv4yqR
	 LkElDgPtI9EDA==
Date: Fri, 27 May 2022 14:52:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: wenxiong@linux.ibm.com
Cc: hch@lst.de, linux-nvme@lists.infradead.org, hare@suse.de,
	wenxiong@us.ibm.com
Subject: Re: [PATCH 1/1] nvme-multipath: show wrong nvme ns after dlpar a
 nvme device
Message-ID: <YpE5/ULqJsU+kgLG@kbusch-mbp.dhcp.thefacebook.com>
References: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1653666577-3733-1-git-send-email-wenxiong@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_135219_963641_49DF7A0A 
X-CRM114-Status: GOOD (  11.18  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 27, 2022 at 10:49:37AM -0500, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> If we have an active partition/namespace on nvme device, nvme device driver
> won’t release these controller IDs/Namespaces IDs when dlpar remove.
> So we got the wrong nvme devices names if nvme device driver still use old
> subsystem id as controller id when dlpar add it back. We expect to see new
> nvme devices with new controller IDs/Namespace IDs.

It was done this way on purpose. You can dynamically detach and attach
namespaces to any controller in the subsystem, so naming the namespace after
the controller instance doesn't help.

