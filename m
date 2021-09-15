Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C42C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 12:37:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF5661101
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 12:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AF5661101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cbm7QddLTzJOChHTmvXn5SLF6xPwWNUKSrwPkiWFPzA=; b=G9d1XYcxSnabfY
	JrmM+ngYkbbVgW/hqWObIGVRpKwZ2SSlVPWgpBsoj9lP1HwjZMi/FY5NRzOrpMHsX6FsLhSEBg+G2
	55g5xSZ9TzuCTRgy4iO4Xrm/h585ia9lbIMaOyCffnzNDpi1EHGc7iRO13FL8gyjqV+brledo8SIa
	SEPgDXVpVw4dVpnZOrRRjqJvYp4E6GYGKRhU80CC0kK2LLHWER+1+WpE6cynsbbxtDLaeeuTP6Qr8
	ae9o2hSXvnri3qT+i/NwMoVGUhd9+92h2H2QVMRIDJvhLZh+M78bhk3hEl3mSZMm24KhgE3pD0LlL
	chpKeYRIbke6/WRLporQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUAX-0093XJ-6z; Wed, 15 Sep 2021 12:37:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUAU-0093Wh-KG
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 12:37:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA03B61101;
 Wed, 15 Sep 2021 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631709458;
 bh=rE8PWmvVS+glJFHMygVNmUpb0AXxMOphGngA5+Db46M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JQkgbVoUVKEJuMqriCDacV8QTgQ8RNgtRTqwDpQ1VLDEIaCP3kqn85kihWRj0RBj0
 87NTM55VHB629C7NFlbFCpXprKtmo5pj0SongfGwcD2f3YlhxZ4c+zcUfosaOUn+oV
 LpCkNNOq0fhFGh4rUfZPIn+I6ov/Kn3mvwRC0u9a8i4bHpxfE1a8CPkDMbYD/uju4a
 0lfKoT/kgSA7ooIeoBbnZNGiMtupZvQoPk7o4pFGMkbwDmvLaqbtckfsdFwZ30L0md
 yTlNEIFdTgzqidTrpW3l0Ff8Shbn43DEwcLT550MnvqcftQWX7gV/ebNVTl/3N10UC
 pegpvArmdUGrg==
Date: Wed, 15 Sep 2021 05:37:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "anton.eidelman@gmail.com" <anton.eidelman@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
Message-ID: <20210915123735.GB3778445@dhcp-10-100-145-180.wdc.com>
References: <20210915072006.956307-1-hch@lst.de>
 <DM6PR04MB708140E359AE0511803F1346E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM6PR04MB708140E359AE0511803F1346E7DB9@DM6PR04MB7081.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_053738_730658_23795DBD 
X-CRM114-Status: GOOD (  13.20  )
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

On Wed, Sep 15, 2021 at 07:36:04AM +0000, Damien Le Moal wrote:
> > +static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
> > +{
> > +	struct nvme_ns *tmp;
> > +
> > +	list_for_each_entry_reverse(tmp, &ns->ctrl->namespaces, list) {
> > +		if (tmp->head->ns_id < ns->head->ns_id) {
> > +			list_add(&tmp->list, &ns->ctrl->namespaces);
> > +			return;
> > +		}
> > +	}
> > +
> > +	list_add_tail(&ns->list, &ns->ctrl->namespaces);
> 
> I wonder if it is worth checking that ns->head->id is not equal to the ID of the
> first NS in the list. That can only happen for a very buggy system or device,
> but that is not unheard of...

We would never be able to hit the condition of two heads with matching
NSID's. If the controller was broken and provided duplicate NSIDs in the
namespace list, this driver will just recheck the first namespace rather
than allocate a new one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
