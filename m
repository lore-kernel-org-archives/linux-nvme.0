Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDB4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 14:38:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E88B64F4B
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 14:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E88B64F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7GbXKkwfvgA1CIDkYtM7ladkT4N28cJIYljz8EQ9Hcc=; b=Te6+7pvMysNKDRnENspG6QB2+
	oLqst+nvko6Iighk5p9bJDK5OuAr0LPf3aD4SyURhKhakBqMnMWiTTZ5oem9rHDUcRCFMjP4EqK+7
	ZZOyWpXow0wliLKlt6RfhkrwekdC6Qh6n/2X/1HdZ8Pb9lo5gCY7HK4Z9/LqxSyGgG4t1QY6SGp0z
	WnzXZcMqNjfI0ZTVjUgZ8N6cqthBFd80mCuTxVrUV2Ibnbfjw9gPXogj+RSe0P4ZPxtKC54XW2/4D
	oSpeODGKKMF7mwrHmSh5ilRSrArBDT4d5uhq9FtE+97fDf+wR3G5gmwvIkC8qQs8WYXo3xrEQeUf/
	Oepwn7gZQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHp7g-008vGM-7s; Thu, 04 Mar 2021 14:38:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHp3u-008ukb-LY
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 14:34:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F2C2EAC1F;
 Thu,  4 Mar 2021 14:34:44 +0000 (UTC)
Date: Thu, 4 Mar 2021 15:34:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCH 1/2] nvme-mpath: delete disk after last connection
Message-ID: <20210304143444.c3dxu7qgw67fw7o4@beryllium.lan>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-2-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005124500.6015-2-hare@suse.de>
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

On Mon, Oct 05, 2020 at 02:44:59PM +0200, Hannes Reinecke wrote:
>  # cat /proc/mdstat
>  Personalities : [raid1]
>  md0 : active raid1 nvme5n1[1] nvme3n1[0]
>        64512 blocks super 1.2 [2/2] [UU]
> 
> Now delete all paths to one of the namespaces:
> 
>  # echo 1 > /sys/class/nvme/nvme3/delete_controller
>  # echo 1 > /sys/class/nvme/nvme4/delete_controller
> 
> We have no path, but mdstat says:
> 
>  # cat /proc/mdstat
>  Personalities : [raid1]
>  md0 : active (auto-read-only) raid1 nvme5n1[1]
>        64512 blocks super 1.2 [2/1] [_U]

Shouldn't there be nvme3n1 still listed?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
