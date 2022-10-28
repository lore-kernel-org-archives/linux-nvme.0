Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D626EECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Owj3EFsEPKAgbsD23p3/VjNfi/cJgkg0hwTTfp+pTE=; b=0NNquQuavqDE/AJIDJBvwug/P/
	LWCx4XWGEDxYoaSNw/Gv+YV7y3r6DnArnxZkFNerAwDyVxYJzdsj/A/KQAdpD/N4w6BdEAskxMmpZ
	5dokQY6HCMXtxFfBSZqvi8r4HvqFSktk1CPKHmGnh/33Jw9j8s3jSD/BWbYFo9M/4Pd70gKm6g7S8
	fRCrLwy+1y3FE0oKa2bE8mrhY8uscpDdbywV8Bs06ESpsoKEKs95O+FzMmQhaO3v6cfEm9lghzFMl
	gM10hsq2v47HP9yW/rvtg7IF7wOpx7BBnv8Jr13JptAwNNJNQH3LNqD2AEK1kPs5FkIc+HCsdwmKu
	CdnDdKjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooRYe-000csB-Qp; Fri, 28 Oct 2022 15:46:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooRSo-000aAa-FI
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 15:40:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6259FB828BB;
	Fri, 28 Oct 2022 15:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2994CC433D6;
	Fri, 28 Oct 2022 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666971603;
	bh=8U47bXZSo7ZN6OiQ3u1CAVeisNjC1lkAQ5nUDGbMgHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vOGLXaWjVf8q4XM/QSQWOrJCgQMK2r2UZpR8ou7Bk13Tiw2bxK9ORkybsf7mNWRBv
	 JwKbriSVgYKnGp4xxQKXLSeh8boi4OIkH3PZ08HHnWVQqNXvAcStNT6/gGMWd1M2aG
	 msAluQTGfuHfgXE58JAI36pQvwDaTBeHq1kVhBw3ADyPYIRNSrB5Rql+C9iNzIh1RY
	 k82fAxRZ1l8SOW2A2wiY9Npna+VhlRFXZaU2tf4l2+d7b6WEg7FLp17++2FOwFLjXK
	 JvEsWWP7JXVXKNtrW4uSBYS8sep00gRNT/a+XvWLvxyxViH4BW+LtRWC/TrIr0nOmc
	 J7XUsNHae+GNA==
Date: Fri, 28 Oct 2022 08:40:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shai Malin <smalin@nvidia.com>
Cc: Aurelien Aptel <aaptel@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, "leon@kernel.org" <leon@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>
Subject: Re: [PATCH v7 01/23] net: Introduce direct data placement tcp
 offload
Message-ID: <20221028084001.447a7c05@kernel.org>
In-Reply-To: <DM6PR12MB356448156B75DD719E24E41DBC329@DM6PR12MB3564.namprd12.prod.outlook.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-2-aaptel@nvidia.com>
	<20221025153925.64b5b040@kernel.org>
	<DM6PR12MB3564FB23C582CEF338D11435BC309@DM6PR12MB3564.namprd12.prod.outlook.com>
	<20221026092449.5f839b36@kernel.org>
	<DM6PR12MB356448156B75DD719E24E41DBC329@DM6PR12MB3564.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_084006_835581_CAED1B7F 
X-CRM114-Status: GOOD (  21.15  )
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

On Fri, 28 Oct 2022 10:32:22 +0000 Shai Malin wrote:
> > It's a big enough feature to add a genetlink or at least a ethtool
> > command to control. If you add more L5 protos presumably you'll want
> > to control disable / enable separately for them. Also it'd be cleaner
> > to expose the full capabilities and report stats via a dedicated API.
> > Feature bits are not a good fix for complex control-pathy features.  
> 
> With our existing design, we are supporting a bundle of DDP + CRC offload.
> We don't see the value of letting the user control it individually.

I was talking about the L5 parsing you do. I presume it won't be a huge
challenge for you to implement support for framing different than NVMe,
and perhaps even NVMe may have new revisions or things you don't
support? At which point we're gonna have a bit for each protocol? :S
Then there are stats.

We should have a more expressive API here from the get go. TLS offload
is clearly lacking in this area.

> The capabilities bits were added in order to allow future devices which 
> supported only one of the capabilities to plug into the infrastructure 
> or to allow additional capabilities/protocols.
> 
> We could expose the caps via ethtool as regular netdev features, it would 
> make everything simpler and cleaner, but the problem is that features have 
> run out of bits (all 64 are taken, and we understand the challenge with 
> changing that).

Feature bits should be exclusively for information which needs to be
accessed on the fast path, on per packet basis. If you have such a need
then I'm not really opposed to you allocating bits as well, but primary
feature discovery *for the user* should not be over the feature bits.

> We could add a new ethtool command, but on the kernel side it would be 
> quite redundant as we would essentially re-implement feature flag processing 
> (comparing string of features names and enabling bits).
> 
> What do you think?

