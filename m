Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F332C3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 22:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSQAGFwyiajhpzAPNICfjaGmKZZfduxNDIxE6aTB+zY=; b=oD6wRHeYH6pAkzNUZeQXwbbvUO
	SM63UEyL0dxZrU8U6vGDSvGE3kh6KBzFf7LA550FEOd2yXZ97VyGfxANT1T4CrS5KVvIjFmgdFLuj
	g4UVH1nHe4GEgZKQ0e9sCBVbszwY/iiBhSDFk31QFBtBbJwyvIUfzxsl0FcILGs0egrytNOb/CQN8
	06Xu2tgXBYfFvxtppsYAlQtYO+AqQxk9UPEQPntivtyANYZ3uCI0IqSLhfiNmjYH5vrylBNrLjbhp
	NrN/Vm+B2Yti4uH0/K9oyOotYNept3awsJccZ0ZzZcw1zrqD2mnc40LwJPBwln9Czo1vCcE1xQ7bl
	5L74g60A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scBRB-00000009bti-0uSb;
	Thu, 08 Aug 2024 22:16:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scBR7-00000009btC-2RM6
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 22:16:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8709FCE1676;
	Thu,  8 Aug 2024 22:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F98C32782;
	Thu,  8 Aug 2024 22:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723155402;
	bh=DUd4ALu6EVw/Dtai2nDj2kJ6PlUtXSAXf9/XkMYb8FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/jxDnBawyHEGPS/xDslhQfif4/LKiTyqpSWJYO98dIz4mRo2weAvBkhRa0msX2ox
	 skVFTBtunoEV2ZAPAyZjSU75dYl1lpgLG2ZB/YPy+7x7pQphosu4ISSd+ziD9zWDPb
	 Xigf9q1sjLr0JcFHakzi/a6uNcSwWLZGITVj3BFCkeIBvBhlNmRe2DM/Ci1OrGDhZ2
	 fIaSR5s5i5Vo7eCxTt1i/b6WAL2xgxBPQK4xgx1o5Npg5AGFyvBvkSjpn5OdYyK+X+
	 FazeQEafH2knHsvP5qSdcRV3Le/GCDMe+Fk2uE/h44P2HhuwWj2BgrEdAbqq6gzu7r
	 Qt72r9RrKoGhQ==
Date: Thu, 8 Aug 2024 15:16:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Disk Says It is Full But There's Nothing on It
Message-ID: <ZrVDyVG6ZpIkBu9T@kbusch-mbp>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
 <SJ0PR03MB65018D5649C7BEBDE4B8B75CFAB82@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <SJ0PR03MB6501FFBE1ECEFC2E3047FB52FAB92@SJ0PR03MB6501.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR03MB6501FFBE1ECEFC2E3047FB52FAB92@SJ0PR03MB6501.namprd03.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_151645_814634_4AB33EDD 
X-CRM114-Status: GOOD (  14.09  )
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

On Thu, Aug 08, 2024 at 07:28:11PM +0000, Eric Robinson wrote:
> I thought we resolved it, but one of the three servers refuses to
> change. It continues to show the drive capacity fully used. I noticed
> that the drives have newer firmware than the other servers. The NVME
> drives in the one that won't cooperate have FW 2.3.0, whereas the ones
> that worked have FW 2.2.1, if that matters.

You should talk to your vendor.
 
> Disclaimer : This email and any files transmitted with it are
> confidential and intended solely for intended recipients. If you are
> not the named addressee you should not disseminate, distribute, copy
> or alter this email. Any views or opinions presented in this email are

...

You should know there are plenty of free email providers that don't
append disclaimers that are fundamentally incompatible with public
mailing lists. This is the last message I'll reply to if it has this
disclaimer because I do not want access to any "confidential" emails.

