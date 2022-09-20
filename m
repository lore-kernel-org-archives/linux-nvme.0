Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D77FC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 19:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=objdZhgcOcflhVMpKMCuN1Vt3tRRIwEy58078Re0NFo=; b=MhU/Q4uH2QnVhxDTvdz18YpvNf
	1tqEG2tVgW761fsAyyg0MrI1KOVEpA25Ki5D8dn0QV0GKt77yP0OSOqgJop5pZ9jx6koQDHYZCoB7
	BwRkkpX2xAvQCSNGO0a7LMdXWXABqX7Ue2IToDNLL/8SMp8Ig146sgDF9OFen1+eFmGcReezZjYjQ
	VejCebt3Viy9NndlIt9FShb57HEhFBGhlNJIAvWbzVNXdTGTvZzTr04Xu49fr36t1EV8WgqKBjwdB
	XQ2pdHPNAOYxJx9A8400yGHb++X7+t3E6U7oAIdnfu3tjJ66IE5gtz1AcVCVK88Mx49RUrJxgX6d+
	L36sQFuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaj8x-0065oF-31; Tue, 20 Sep 2022 19:42:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaj8t-0065mu-Se
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 19:42:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 502B96240C;
	Tue, 20 Sep 2022 19:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005B0C433D6;
	Tue, 20 Sep 2022 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663702969;
	bh=rOHwkJTvEHevCDzzxNM57UGO9g7dNZiQ0eoIxjajoVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dn7Ivcj7fxjCMzQeqpCaPYykJuWiia6JjSO3ZnOf+4RSRxXUfIaaPqCboJqt1Vfvt
	 dWaS0kfSlehtdbmy7NiZHPpaL+YBvgEH7K9qOMiWZ5tKWrfMYS5XycbvEcEqAESfvy
	 KbF6y9YoIQVbh7axD6k/Sb96NW6OvKqFZrjmX558nO9aRLTk3KjPkUW+7VVsdSQVtH
	 Qx5w/P05gfCK5YIUCC/pJvdylyIVoH56XrijAGMwiy+nutqO+S0ZkVcE2w0NBsJEnt
	 2WEcjdAQXTa8vhjMW6GccBaIXnvB+9J2+5fvcUWiXe7/rwxndJw8p1dKgkiRD97H6L
	 gR5Mlz149YblA==
Date: Tue, 20 Sep 2022 13:42:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "Sironi, Filippo" <sironi@amazon.de>, Christoph Hellwig <hch@lst.de>,
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	"Greenberg, Aviv" <aggreenb@amazon.com>,
	"Dutta, Soumyaroop" <duttaso@amazon.com>,
	"Priescu, Valentin" <priescuv@amazon.de>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc. NVMe
 SSD Controller" from 5.19.y (issue bisected)
Message-ID: <YyoXtuHvGzCB2ZNT@kbusch-mbp.dhcp.thefacebook.com>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
 <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
 <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
 <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_124252_000538_D8B76D9B 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, Sep 20, 2022 at 11:41:58AM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> On 07.09.22 11:58, Sironi, Filippo wrote:
> > Adding more folks (Soumyaroop, Valentin, and Zorik) involved in the investigation, which is by now concluded.
> 
> Has any progress been made to get this regression fixed? I might be
> missing something, but from here it looks like nothing happened since
> two weeks. Thing is: ideally it shouldn't take this long to fix
> regressions in production releases, as explained in
> https://docs.kernel.org/process/handling-regressions.html

This is a device bug, not a kernel one. The ideal fix will come from the
device's vendor to bring itself into protocol complaince.

We do work around these types of problems when necessary, but we usually want a
statement from the vendor that they can't/won't fix it before we create new
quirks to maintain. The vendor has said they are investigating this and will
update with their conclusions. As far as I know, the ball is still in their
court.

