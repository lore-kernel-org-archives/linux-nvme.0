Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7692BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:58:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3362D610FA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3362D610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FYNgUdKVWYhC9NzmUk3chjaVstG7N13GfV58PT0EjXg=; b=fTsPRN42vnj2Nxu0gB/7dBZK2
	zUYiyHQN1S/OMfiJuPZvQacrT0fB5eQGYuJOaDLdQUcPaml2bghZUognQ9fXjXVoVTt2JRiq6mWdg
	+w+Pyb0UD80cwtunE7kIVIDCse5SAAXCJM4ZVkTot10+xVZNJ0rDOcvtiQlCR/JI6MdYOTxgBluCW
	uDFfdvYGGl/fGGHATKAsmjLSSuNEEuZ1nDKnMvcciTEzr0XFOW3jy0Eh7SZjedmW9jbUOk6KG/+La
	mFQJKkxX7laiwFp7DPuw2uLeqW5nZr6/PcxL+j9j1357hqJTIHSVdV5dq/s3GiDNdKLkhffmIIF19
	fnoVykbSA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXAwP-00HayO-3v; Thu, 15 Apr 2021 22:58:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXAwN-00Haxt-0g
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 22:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=euur3iWmoX+WYrwVjIbjjQx73bKKaZVxhcKJ4oFEBKw=; b=Ht2cUU9jEEvGOaA64v1Q2p5Q2N
 bWAvcZ5Mr0Ka6bttTh9p+UD1aRrIghnYg7SqqfUQQn/oismf+ggyEiSQjPvq88CQScMxq9oxb4RmM
 PE2RLf96vxQJ+Xntp9+P9RgmlaAS1Y12c37G20RvP8U+9hck43mZD/dzum9J6fF3iIxU8OVad2bIa
 HgoPTGBUdnNsHS+x0Wo5dirGhSLgrIkYiBwl383Rk3EU85zSjSNgKlLMtN45Dt2R9wdE1WzDbfi4/
 IHMvfv1kEZsvSn7VXgInutnSVF6FALYnQhMctYHu01B53ZERY1cEYv5tTvRy2B8IwMd6lBFwACtr5
 8zul233A==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXAwK-008xMV-Ip
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 22:58:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E216610FA;
 Thu, 15 Apr 2021 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618527503;
 bh=YcFVD7TBPt/VtGm7ohne5szlkkkPTIHaamrgAN9MRRQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iT9ZOdxnRT1VomaVgnPCyZ++ue4QuQ6pS4Pv/FuQFHfiIsfvgQsaCIlm17s6iaGh3
 E22m3X6pKcS6O+IIgvnZyNSbjJ2n8ZG6t3VNbWzsirxF460FxzBnODKpHbxLlRHbxO
 2vUVdXckRWR8FQttYQwxGosCBE5RUwhasoZ+8pK/PTjnV47r4QLefU3JKoTlFeeL5D
 95HAZsp6v0Lac/plxc4pi8DYwAKrCOutgrEj5u/DAY48vCmFMIb5PI0Culf0MuLllM
 DspBIPxMfKrd9DDAcV2vscThH0H6XAg3Fh8IkPJxaMxEd698h+heg4rED2QarvRowY
 wDvaK/sTOhSeg==
Date: Thu, 15 Apr 2021 15:58:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yuanyuan Zhong <yzhong@purestorage.com>
Cc: Chaitanya.Kulkarni@wdc.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCH v2] nvme-core: initialize status to NVME_SC_HOST_PATH_ERROR
Message-ID: <20210415225820.GA2760266@dhcp-10-100-145-180.wdc.com>
References: <BYAPR04MB49656BC34E2C7AA4E3324DF2864F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210414170833.24929-1-yzhong@purestorage.com>
 <20210415193030.GA2452080@dhcp-10-100-145-180.wdc.com>
 <20210415201726.GB2452080@dhcp-10-100-145-180.wdc.com>
 <CA+AMecHdnFg73z8LkjTDzT-5y0dcApV9X-vJ9cDRMGBhkNrNtw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+AMecHdnFg73z8LkjTDzT-5y0dcApV9X-vJ9cDRMGBhkNrNtw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_155824_662363_2ECA40AB 
X-CRM114-Status: GOOD (  18.04  )
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

On Thu, Apr 15, 2021 at 03:11:13PM -0700, Yuanyuan Zhong wrote:
> > > It doesn't look like these types of errors are unique to nvme. Could we
> > > not just have blk_execute_rq() return an error instead?
> Looking at history of commit b7819b925918 ("block: remove the blk_execute_rq
> return value") and commit be549d491154 ("scsi: core: set result when the
> command cannot be dispatched"), it seems scsi code no longer have issue.

Those happened when 'struct request' carried an 'errors' field that a
caller could check. The struct doesn't have that anymore.

> > -extern void blk_execute_rq(struct gendisk *, struct request *, int);
> > +extern int blk_execute_rq(struct gendisk *, struct request *, int);
> Changing blk_execute_rq() prototype needs tree-wide callers update.

Callers aren't relying on an error now, so I don't think this suggestion
requires a tree-wide update. It might want an audit to see if existing
callers are susceptible to the same bug you found with NVMe, but
changing the return as suggested shouldn't introduce new issues.

> While it could be a fix, I'd wait for maintainers to chime in.

Yes, this does require concensus, but Linux is usually adaptable to
changing kernal APIs when it makes sense. I *think* my suggestion makes
sense, but I appreciate any feedback.
 
> I don't quite like initializing the status for every nvme command. However for
> such a long standing bug across multiple stable releases, I think it will be an
> easy backport for stable-tree.

Your proposal is easier for stable, however, the mainline fix doesn't
necessarily need to consider that. We can always deal with a back-port
if the mainline approach does not readily apply.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
