Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76156C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:53:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFCF2087D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WixMXiaI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzjMXRuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFCF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s9wmWQFuDU8bHqPkbz+cxYaG/fLkFHZ6h9F509DXYhc=; b=WixMXiaIsDzQRWd7AQK4SaUUu
	uI5ye0UeIxEvotcZ5LhtfpicNYXp0Tt8J6uAvS+VCZ9nzTaitTEtGi+QxRVHBabGWri3djcNb202t
	qIlP+SLNgLjTgPigWn39JF8+5Bt/mmcPn/BbstVifEeaM85ynpRGAt+MsusDFyZlXtarOuV/z9CIE
	bbj+yxc+AioN+6OuM5Ynhr9ULadbGeJ8sdXefCv1M2zEHOwpKuqzPKyRn03Pe9dGRzPK9RwmRoccA
	dPGCJkI8t1+G79PSbJjb31TeVyg09vdC4/vLmny+36lm0A8wBsyZIrZXAlrQc2pk7NInpkX/U5NXd
	4aQk7Eqxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBKDk-0008S8-ND; Thu, 27 Aug 2020 15:53:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBKDi-0008RL-Ij
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 15:53:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5391F2087D;
 Thu, 27 Aug 2020 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598543625;
 bh=cAUDK1SdlCy+xUVLawAb3vnaUxbyZbOqmE4XsQ4fyXE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KzjMXRuIKafR5Rq1QxXJjaFvQLiJDAAqwDbhwMFY6OJHQrXU6p8vcXyt/so+aq6Cu
 /Qc0QxpSh6yx0t1MfHC9cSwasU8nNWLem9Skuz0NZ+SBjU7ouEhByeg/6rMsS3T5vO
 NLjpxFBpCCtPYOXAfSquqz2b9LzDauJVlbgQteaQ=
Date: Thu, 27 Aug 2020 08:53:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Message-ID: <20200827155343.GA2784469@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <yq1bliwm72c.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1bliwm72c.fsf@ca-mkp.ca.oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_115346_785483_6F92B448 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 27, 2020 at 11:48:21AM -0400, Martin K. Petersen wrote:
> You used "unusable" in the patch description above. Did you mean that
> here too?
> 
> Maybe something like:
> 
> 	"namespace%u: ignoring unsupported I/O boundary:%u\n"
> 
> to make it clear that this is due to a kernel limitation and not the
> drive reporting garbage.

Thanks, your suggestion definitely improves the clarity. I'll use this
for a v3.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
