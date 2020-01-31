Return-Path: <SRS0=aqmC=3U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B78C2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F8820CC7
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2020 00:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l282ABGx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFHhH0r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F8820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6QwygBX+lywBklDS+urKynC9mV4ENTc+nmFwWZIHlT8=; b=l282ABGx6CNl06
	S+q6oy5sq9x0Lp0hXgZe+6sZSsffOaXewYLtV8LZlaKBmE4MrP8vs/8wLG6bVL1c4LFld5HYsRPNE
	+TCkE6fsNDbR5zOfR5nNaM2Wtw7mfjKq0vGpDaharncVI12v54ZAtre7RqdbkOagw1jicUcFoOmsm
	a7r2nLH0i66SzEBgNJxbMMnWuaGd/jhxABZOIDni0aaAZzS+CZCkQwFI3y7Ma/jIpyTiR7PzZcZ0q
	FiXWL+eEFfOjzqz0miXPXo7s7GA7snkRgtyA8Hywy7r/tVenewXSJwliZiq3MImGyIy6Ok0HbZAcG
	VjDoGW46LptVaVGn3LVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ixKTc-000737-Fs; Fri, 31 Jan 2020 00:48:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ixKTZ-00072Z-Dk
 for linux-nvme@lists.infradead.org; Fri, 31 Jan 2020 00:48:02 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D3FE2082E;
 Fri, 31 Jan 2020 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580431681;
 bh=jMDUj9pCId6R8yBXK+eT1TGw89WTlxMPppzAwwUFjUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KFHhH0r2R0Qh4SSpw0hz94n8RKtbGm5aoI/XyCETRKWjBKLggWNzqKr7l3yNfPEc5
 iXmtGkPD1V4D7Vz0RoNsuwtxYN1VusB94eLRm1IuSt7edPKyLcWJSTXAjkGXrI59N8
 EfmaAbEpqfJ3j0LiBltOvFYYk33dXe9YMtKbAWuI=
Date: Fri, 31 Jan 2020 09:47:58 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 0/4] nvmet: misc model, ctrl-id and AEN fixes
Message-ID: <20200131004758.GB8673@redsun51.ssa.fujisawa.hgst.com>
References: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200130182934.6109-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200130_164801_476023_90404B6C 
X-CRM114-Status: GOOD (  10.38  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 30, 2020 at 10:29:30AM -0800, Chaitanya Kulkarni wrote:
> Hi,
> 
> This is a small patch series that allows users to configure the model
> and controller ID. Also, patch #3 has a fix for missing sscanf check
> in the nvmet_subsys_attr_serial_store() where patch #4 provides a fix
> to clear out the async event for which AEN is not generated.

Thanks, applied for-5.6

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
