Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB6DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 07:35:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE0F61029
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 07:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE0F61029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LMt2vzGV6i1DoA4qsg6M2tl7MTQOjl2SNWOnW0vWfl4=; b=NkYCjusadBtK1oNZd5L3Ho/+5
	VJdM0M87tJAvHLrRO4h95BGwHCsS3yNaRzPh+OQndEbd0sfKwGlFJW85F/hcyh5/mugfqHcEW2uNe
	GDkJceuSfRUjqe/MsDzJhZ7yEaAmWdE67IeIWPG/IbeiacFKjJtx63KRTMLjnU8MghWAgp1mAC66E
	0gR00mna1KImIcvlAw5l0p4188HCaZHRlwyV85t4TC+i0pyW+x4q7QCzpI6Q0u0HTe29/XEZg81qT
	L1wd//LjxpBsbYDYP8+X64mEp4chdD2XtEtVJAE5OyLI6kwzLw3OHq4bSUJ80+ii+2RKjaruxU31C
	Jg9+Eg7JQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRrrn-008nft-CV; Thu, 01 Apr 2021 07:35:47 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRrri-008nfJ-2J
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 07:35:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78C66AF32;
 Thu,  1 Apr 2021 07:35:41 +0000 (UTC)
Date: Thu, 1 Apr 2021 09:35:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>
Subject: Re: [PATCH] nvme: Export fast_io_fail_tmo to sysfs
Message-ID: <20210401073540.6tsv2ib3fapnglqo@beryllium.lan>
References: <20210331131228.131118-1-dwagner@suse.de>
 <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR04MB49658F0DDA22B253F98C6F3A867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_083542_259727_427CBB56 
X-CRM114-Status: GOOD (  16.92  )
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

Hi Chaitanya,

On Wed, Mar 31, 2021 at 08:34:31PM +0000, Chaitanya Kulkarni wrote:
> >   WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
> 
> For now keep the current style.

Okay, I thought so too. I am just wondering if a patch for changing all
the permission sets is acceptable. I prefer the the octal permissions ;)

> > +static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +
> > +	if (ctrl->opts->fast_io_fail_tmo == -1)
> > +		return sprintf(buf, "off\n");
> > +	return sprintf(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
> 
> do we need snprintf() for 2nd ?

Sure thing can do. Also here I followed the existing style. The other
store functions tend to use sprintf().

> > +	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
> > +	if (err)
> > +		return -EINVAL;
> > +
> 
> since you are returning an error, you can remove next else if, this also
> removes the extra line after above return. Something like this on the top
> of yours totally untested :-

Right, same here, followed the existing style. I prepare a patch which
addresses your comments for the existing code as well.

Thanks,
Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
