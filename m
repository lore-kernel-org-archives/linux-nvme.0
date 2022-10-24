Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F09C67871
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjWpAANwPNZjtUKvR16WK7gE84+rHJswgLJFm9JkI64=; b=bHb0Qvwj4ujdMmHWtaLLgD/gSy
	W/jUPTn34RKPYTSvv8bEmHJ8YnjSxTk6r3lgfR7CycNCWsHP5d62y+W71Ijwv2+3TS3H1D5qvDNaI
	VeF/I3pT61n571wUEDZ903IkkO5FhJ0ns2j/zHN60Sx9MypJtTx2i6BYtj1KFxGGFzNT9OFraYCOG
	i6cmhXKgJpGC0RSxfEpjma40LtWoy1RLLoNWSNEOBp4N+qIzY6c2A4jkm0ckN0pHcFhqNfQMd1aJF
	hVYNlMeUicoZ+xbqLbj9EhVjcA+SZO5HrLcesbBqoTm1RwexWShqE/Qopf3uQZ1d/ivCd9qrT3yRE
	7t6qb7oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on63h-003IKw-RC; Mon, 24 Oct 2022 22:36:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on63f-003IKH-N3
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 22:36:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E10F3B810F4;
	Mon, 24 Oct 2022 22:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55864C433D6;
	Mon, 24 Oct 2022 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666650991;
	bh=j1ZM/J+8OlxNCXWaEscjbZJJ9+rwG1+AoJcYGpSWI8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOZrRB4BnkZDLXlufSRcCbtJq+zX0dursT23orXQaPhprW0jDGxTB8tzG7TGfLH65
	 z24HQaEbZlk1/WhMtZ3hDT62Tp1BhoI+A+zGpZ4f/1r5/hS0y67XdL1bfLORt8sqGV
	 FRqLnbNek44cCWoWSCFHuaV9puHGYRWtJuWUYWNu5StQw/TnNYsbG2ewJP4RlivAQy
	 7R0U75KShIbxtkR7R5P0y3X3FfCLgt+fo6g4Uf6dfjailvBmqw3+sdenbqKP1lP6pO
	 otzjuSodm3kFTSYi3sqpSW7IqXd2Iy2pOkBGMWaYdATPYgVTcBaE9pJXZW7QEFAgkM
	 Aq5qpgykWBFVg==
Date: Mon, 24 Oct 2022 16:36:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: way to unbind a bad nvme device/controller without powering off
 system
Message-ID: <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_153635_938735_3F953B6D 
X-CRM114-Status: GOOD (  19.20  )
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

On Mon, Oct 24, 2022 at 05:40:30PM -0400, James Puthukattukaran wrote:
> Hi -
> 
> I'm seeing a scenario where what seems to be a non-functioning nvme controller/drive where the IO transactions are timing out and the controller is not responding to any controller commands. The controller seems to be disabled (nvme_dev_disable called via the nvme_timeout) but we're still seeing the nvme_reset_work thread  blocked and not making progress. I tried to remove the controller via the HP sysfs interface and that also hangs behind the reset thread waiting for it to complete. 

If it's in a hotplug slot, then just pull it out.
 
> I thought the the disable controller path does not talk to the controller and simply unblocks the queues and cleans them out before unbinding the controller from the device. Not sure why the reset thread is still stuck then? Does the reset thread have to finish its course even though the controller has been disabled? trying to understand the flow here.
> 
> I guess what I'm really looking for is a way to simply unbind the device from the driver, kill any threads and allow the device to be powered of via the hotplug interface (trying to avoid rebooting the system to remove the device).

What kernel are you using?

Generally, the default timeout is really long. If you have a broken
controller, it could take several minutes before the driver unblocks
forward progress to unbind.

