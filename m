Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EEEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 10:59:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A046223A02
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bAct1W/4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRN5i4Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A046223A02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/ZvXE/6v6+RN4sdw1mzx6GkiiMP6hYewNvxzMzv28bM=; b=bAct1W/4qRRhPp24b4RMrl9eG
	UlA+G+85j9dbkqM1H+B7hIx1URbSFTquoBbtxUGKJUnQhaqZ72EebM6oPAyLCH+1SJRLPTO+4VKYH
	wsZrK9lxyjHUAkVUpi/4ANW4sXmqHwvUvWB5GtbCsi0OqO/eKWXvMjo51+kf95EUVGdda92lK5hPm
	pd5YgIBGDED2sqQvILQWgmdIeuW0DKdnnpmrup/cUwfshhfUBVMJeKrpVKFBMU0DlVMdaKGcWKw6Q
	ZiAclI4TgIQyRg6iQzWd+7PUkFkbreL51a/Wl3npW8FEDU0nMtx6DcTciZipGamuQx78LlaYtZLSR
	KPg6bMXqg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jprVw-0002MK-H8; Mon, 29 Jun 2020 10:59:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jprVt-0002Lv-QA
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 10:59:50 +0000
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 51CAA239EE;
 Mon, 29 Jun 2020 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593428388;
 bh=HCf1PDcazJNTYh4cWiI0TA+wRLYx2zOnUVW+p6mgCwo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VRN5i4WdBKUaSMoop/hlajMSmJgAJZNr/jl3HvwBcyBg9DilCEaQdh9fZmgU2+CPK
 hKEIeoFT87RepeBJHlzvRrmxd/da6nWSNaQtg0ktUCqN/g8iNMjzdZE5xsXhwp/Yxn
 NpPupo37Hyu1L6DqLfAUhWr18L+3kX4TKdSOPcsI=
Date: Mon, 29 Jun 2020 12:59:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: regression: blktests nvme/004 failed on linux-stable 5.7.y
Message-ID: <20200629105939.GA3362395@kroah.com>
References: <1528690896.32343478.1593229315244.JavaMail.zimbra@redhat.com>
 <1015661434.32401219.1593424943236.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1015661434.32401219.1593424943236.JavaMail.zimbra@redhat.com>
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
Cc: stable@vger.kernel.org, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 29, 2020 at 06:02:23AM -0400, Yi Zhang wrote:
> Hello
> 
> commit[1] introduced regression that will lead blktest nvme/004 failed on v5.7.5, and commits [2] fixed this issue on latest linux tree.
> But commit[2] cannot be directly applied to stable tree due to dependceny[3], could you help backport the fix and dependency to stable tree, thanks.
> 
> 
> [1]
> 64f5e9cdd711 nvmet: fix memory leak when removing namespaces and controllers concurrently
> 
> [2]
> 819f7b88b48f nvmet: fail outstanding host posted AEN req
> 
> [3]
> 1cdf9f7670a7 nvmet: cleanups the loop in nvmet_async_events_process
> 696ece751366 nvmet: add async event tracing support

Why is this last commit needed?

The other ones are already queued up in the current queue, thanks.

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
