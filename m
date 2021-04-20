Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE67EC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:16:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D92613AF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D92613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YZYIDDXn5/XbEhqsOobvKANo8q6dVLsrB5xosGIaJIY=; b=cxWaKqpi1pMRAR3lRFd7SAbjq
	TADJiye+OylX1FKhPLoi3Zlnu/cvYE8U4agBlBCvwZgjsHuukMyIRtiu7jYpcjPdnuayNzwbVext3
	6wD4cDLv7WVo7QQDyPOr9WhNjSeNy/fK9oFao5JR9bsyK0lW2D1riVz0IJTC9zsdSHQ8057J4+UzS
	Si1iNgAnr5EX5kG2s8PwUeoGSsa3iMjF1W2N+oyVq0IlgEPDOGkLMi2zoOt5sYPu9V01XJ/ybSvOR
	PXtJBiEM6XSe2Kv10McT9VrSCuzufxybkjZgkgvIVCMH51toYobrWxnAOA8/3+pAGU8EmwjB17YIn
	KeaP7jlow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYrAp-00CJbF-KL; Tue, 20 Apr 2021 14:16:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrAn-00CJab-1r
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:16:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2DyieZBbjjCwP87oQVQSHYBMRkahr2e3kcKuxyB+zIk=; b=zwlbRI9/HYQbRDrcCbWNBQCPfT
 Az3UXJXlv7lEd20NuzUKVde9tf1AD+0kw9e39hvdc3kf6bugeYCOgybYdbE+FWmLHNQ5b35Z8YosF
 YGSobTdltGRMQIbH9FP9x80xk6KeQfqAQDvNGkvFeFQfam4EpWsDjZSoaP8J7TP744HOzZ5B9jZ3x
 sW1P6wLLCOAFfySW2Fj0UPb42d+Wcx+sXALnZsNjeP55iaPq71s6rtYzpb3KfBP9mssiDQ3akwwex
 pDnFQLHH/TEQo6uEHsT3dSh57IRNKUr0fANdZd62XaOv8xW0RtYfJHi9XXHCDch8InfxgTTN6NKqy
 UKTHPOgg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrAk-00CBWg-H4
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:16:15 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1863613BF;
 Tue, 20 Apr 2021 14:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618928173;
 bh=bhA3j3sAKQVP0juhZq+9bt88o+0/caKB8E3Yc/tOXhs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KpSH/3S1AVbKBHRH1thejaiQV3Ne5AK3IuZg7wD500O7Rkrnoh6pyQ9G4/jbEEog+
 cwy0rnL+qxMqIaZPWLyUwqOedXtSQ+NYebdregPriRL8TQZkL8xvakn9eYI+bu7oet
 CoJwptDT3USAC8uqht8cWf1vc6Gtk8r70lLRpObXbR8bnJcn04FnmFSIuKDVG7YUHZ
 EcAjtooyb8nJfeEuHsqg0dRWv9VftIDL6EIxhxpTjF7DnRwD/dB4GwGkjfwNg0R6MG
 D0pYQTCUcTUcivbzcPqaC2+C8coMz29AM/kzTomQuMc3J2mN/1OxtDKFZm9/+DSjbK
 505MOb12a06xQ==
Date: Tue, 20 Apr 2021 23:16:10 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
Message-ID: <20210420141610.GB14300@redsun51.ssa.fujisawa.hgst.com>
References: <20210416062411.47958-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416062411.47958-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_071614_630239_E2017230 
X-CRM114-Status: GOOD (  11.41  )
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

On Fri, Apr 16, 2021 at 08:24:11AM +0200, Hannes Reinecke wrote:
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
> 
> And this is reported to cause a problem.
> 
> With the proposed patch, the following messages appear:
> 
>  [  227.516807] md/raid1:md0: Disk failure on nvme3n1, disabling device.
>  [  227.516807] md/raid1:md0: Operation continuing on 1 devices.
> 
> And mdstat shows only the viable members:
> 
>  # cat /proc/mdstat
>  Personalities : [raid1]
>  md0 : active (auto-read-only) raid1 nvme5n1[1]
>        64512 blocks super 1.2 [2/1] [_U]

I think there's a copy-paste error in this change log (probably my
mistake). The first mdstat should have shown nvme3n1 was still there,
right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
