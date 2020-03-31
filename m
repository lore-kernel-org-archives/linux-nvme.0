Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03543C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:53:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AEA20714
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GjX1eyyq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tw7d+Lts";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0DkkzLU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AEA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F7dfpzt5Uv9sBdi11xJpLipVYNghCUcQp9xaXR9AFms=; b=GjX1eyyqrC9vnP
	eFRdrnzGkKWhhcVARgbS1QrnSHxUwqn/cwzVZ2C7bkbkxZP6BThoc4HOIOS/zxGrTMwX68tpzxSD1
	Kv+/pPQgZ3xywzCjNuGEf86XzcRH70Phu9XrYhAFnd7YpvSC8pAJV+qR5VEkTRE7J17ZaNz8mkhY8
	2kcvez80Znd4dbIMfZvF5vhAn3aoGC23lUE4cNtrHTfwL1RzM3/eLNsvQtpyQqKkx31ob1o2MANVJ
	qbDmkfvmyu+PgzB9iVGiR6Avl05NKSwIRZ+eKUwybJLcZ7bFPWxOGPjjkDpeEtVUCAu+fsJbYMd4a
	SxhgjibULeLkIAMz9siQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJJCv-0004DV-IH; Tue, 31 Mar 2020 15:53:41 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJBG-0002pj-9Y
 for linux-nvme@bombadil.infradead.org; Tue, 31 Mar 2020 15:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WjVDI71xjB9QcyRMITLjQiiHIpdqJGelPGPABA93i9o=; b=tw7d+Lts3Yu7uO9aWO7fsrXyKg
 hIqovvk/160WTrno13TmCNqO6EkOFF5o88eGdIs5DK3NeQ3cn3omwdgbI3jcSSMwITazH+eY+3Bwg
 aNrHAVZ4Aq+VU+HoIs9XYJtHNHeCIZ5lnYIjZu/4uEkuAM8prjBk/L5TGASabOG+pDFnFVM8crmcP
 ZBLFFWJxD+4SWYN1cPjjdKwvP7iX8hEEUadWLHrM8sLmGWfLuA1MMqTcnRN7PXMVdHUzPU19aKVuJ
 xtTiOhVJ4gaJmkRvAfbyzMrIK7tPkuEn/5qK83D5KG0965ZfLZmmt4kVwNMGAEHm6myFHvbzlT7MQ
 Frg0mAIw==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJHwh-0003f8-Gj
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 14:32:53 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 06E722071A;
 Tue, 31 Mar 2020 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1585665163;
 bh=x7hdBy1G/gH3BpgVORSnhNkjE5iIBZe1J180qnL2CH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0DkkzLU9AByf4i/c4ZLvLg+VvK9XF6W0M3r311XvzkY8jK0eD2SpxNTCOx2opUljj
 NMCMhLPH9GmMK9JyuHDLKsw1cF5Tud63whdP1JhAkx2vyu+oqYVwXbkUmBSbGzwcZD
 jjYfno92tqx3++lYt0SRURL4Iz/FMv8sukJNLDjc=
Date: Tue, 31 Mar 2020 23:32:36 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jeffrey Lien <Jeff.Lien@wdc.com>
Subject: Re: NVMe-CLI issue on Ubuntu 18.04 Kernel
Message-ID: <20200331143236.GA30875@redsun51.ssa.fujisawa.hgst.com>
References: <BYAPR04MB5656BC5528D84371D1DECB3FEAC80@BYAPR04MB5656.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5656BC5528D84371D1DECB3FEAC80@BYAPR04MB5656.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_153251_893305_40CE59C8 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: Kenneth Burgener <Kenneth.Burgener@wdc.com>,
 Randy Bates <randall.bates@wdc.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 31, 2020 at 02:21:01PM +0000, Jeffrey Lien wrote:
> We are seeing the following error message when executing the "nvme list" command on Ubuntu 18.04 with the 4.15.0 kernel:
> root@lmt-store-17:~/.src/nvme-cli-old# nvme list
> Failed to open /sys/class/nvme-subsystem/nvme-subsys0/nvme0/address: No such file or directory
> 
> It does not seem to effect the completion of the command; it's just extra noise back from the command.  I'm not sure why the address is not present with the 4.15.0 kernel, but also not sure what it's used for by the nvme cli code.  It's referenced in the scan_ctrl function in nvme-topology.c part but I don't think it's used by any other functions.   Is it ok to just remove the reference to the address attribute in the the nvme cli code?  Or is there a better fix for this issue?

I think we should suppress the output in this case. We don't need the
'address' attribute, though it's nice to have.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
