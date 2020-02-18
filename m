Return-Path: <SRS0=tyJo=4G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53485C34031
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DE224656
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2020 23:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TMEchPxT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzkUrxa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DE224656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LFRv7yAcNesWkwApe0rHNsKUcInB0MJuhgZR3z4lqMU=; b=TMEchPxT75RVPQ
	ojQJs7zVYShuvweJZtPhLdsvIOffeoKIWLDpNV6S+FThNpZdTddbTzjYGr+gGWsxg8Qw4KviPmVJX
	vuDQA5YAcizUtGbcNJXdTyK5i/B8dPXAln+yneab+6Uf6CeCpGFh7tlfUpW0bz+pHAYHTKp43e/If
	Y9Weq6J9B9NEJemw97XSYYTxkV5u4kfnSCU5JEip/disk/HksacYCh4cZ2SJw3p8WbMZJtvofHEJR
	fCkqetS44gXQDW6jane4TUm3dP+ODvkl02iRz/UInmB0Juw3a5iao9RAyFcZ1XvNV0yFw+q3uauar
	w9gYKD4P/c2SS+XEz6Aw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4C0Q-00028i-1p; Tue, 18 Feb 2020 23:10:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4C0N-000287-Ez
 for linux-nvme@lists.infradead.org; Tue, 18 Feb 2020 23:10:16 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2FE8824125;
 Tue, 18 Feb 2020 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582067413;
 bh=v22+PgN7H/B4xPUCRQ1DsVyP8e4CnicZgkLDe5nMRM4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rzkUrxa0vOpSt+Rq1R5CHO5S/9jEyieSZfu0s5vYe43c2cCy7uCdSwHOEuBgDXhTb
 QdxOVQ4Qv0IcDRTxIDmGxCBWq+ILQvyIGNcSH+sMozXWeW/eiyl4ua+S/xTq5JsniD
 6j13BRytmVUpKH7tE2krnYTz0WGdseYhtxHNc6L0=
Date: Wed, 19 Feb 2020 08:10:07 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 0/4] nvmet: add set feature based timestamp support
Message-ID: <20200218231007.GA18306@redsun51.ssa.fujisawa.hgst.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_151015_607251_5B5FCCE1 
X-CRM114-Status: GOOD (  14.11  )
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

On Tue, Feb 18, 2020 at 01:43:34PM -0800, Chaitanya Kulkarni wrote:
> This is a small patch-series which implements set-feature based
> controller timestamp feature support for NVMeOF Target controller.
> This allows host to set the timestamp using set feature and read it
> with get feature commands when controllers are distributed across
>  different systems. We return the value set with a Set Features
> command for the current value plus the elapsed time since being set.
> NVMe [1].
> 
> Regards,
> Chaitanya
> 
> [1] NVMExpress Revision 1.4 (Page 220) Set Timestamp Origin -> 001b.
> 
> Chaitanya Kulkarni (4):
>   nvmet: use nvmet_feat_data_len consistently
>   nvmet: add support for set-feat-timestamp cmd
>   nvmet: add support for get-feat-timestamp cmd
>   nvmet: update ctrl oncs values for timestamp

Patch 1 looks good.

The last three ought to be a single patch IMO since those should really
from an inseparable package deal for this feature.

My only comment on the implementation is you need to initialize nvmet_ctrl
'ts' and 'local_ts' on each reset so that we have correct values to
report in case the host never sets the timestamp.

As to why we'd support this feature, the spec says "The use of the
Timestamp is outside the scope of this specification". Is there anything
interesting we can do with this?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
