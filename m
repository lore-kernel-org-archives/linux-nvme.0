Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69295C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7we8VZqpt5bvv4fCMScH/dfnBcNzoraoGlG3vw+TivA=; b=JWrY3miX/Kdnhr2Qa4iWXYRmZj
	z+yjTINjYWhyHij8yTFX5f/qQBY8Btaw8cAw0MdZjTtY9r/kKQ7Kjyjn59aZ5c8glsbljnmkWA6bh
	DxpSqfFOC4KAfzfmuGnQwg0zLSUAaNBt5PFXI3Msh59itEWt7DclIkQiQoZMvudj7oJYEGLGUZGZB
	M73h81/cXhzn5yJvac/7sRpz5fk1KsknJFp1vood3qh/0KVkzPHU0x0MZrEn/6+QenIaE+6DbCQjl
	DVdYdJhtLXxPRCmdtPO1C/DumABc5ECoT6FVy72cfVzhXJmn88JYPUw9dLfn5gni7+Jv/NIWb3T5J
	tWBVMUjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6hj-000bYp-A4; Wed, 19 Oct 2022 10:53:43 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol6hg-000bSZ-QH
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 10:53:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4131020455;
	Wed, 19 Oct 2022 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666176817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7we8VZqpt5bvv4fCMScH/dfnBcNzoraoGlG3vw+TivA=;
	b=sAkUazrLiPPzpfNNDB/19ihQDxux0btCO1ILtUDv85ZpXhuZFg339lqyE70YKEcOz1ZbG4
	Y7xUdhDX2aKwzNuRFKQcqLbVMoRea+ZJLabHjxSkiKU1XMUdqPF111yZAQGMcE4q5Sb05t
	9wFjEPymViLAQB7fcZM9FSDnLJsKD9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666176817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7we8VZqpt5bvv4fCMScH/dfnBcNzoraoGlG3vw+TivA=;
	b=HDEn7TeyXRWtyGgcb5r4Vh7wSK8CDiGfKMTA40p4aXxwQzTNOl+1zB40S/4eRttZicOhHc
	8gHXhv4OqHuEHEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3425413345;
	Wed, 19 Oct 2022 10:53:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kUm3DDHXT2ODMwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 10:53:37 +0000
Date: Wed, 19 Oct 2022 12:53:36 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Pankaj Raghav <pankydev8@gmail.com>
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH nvme-cli] tests: Update license to GPL-2.0-or-later
Message-ID: <20221019105336.n37oq5u7gbgynrqy@carbon.lan>
References: <20220517061456.7623-1-dwagner@suse.de>
 <20221019070321.ra5wns3sc3dv3r74@carbon.lan>
 <20221019085004.54mtkhi5qoix5ef6@quentin>
 <20221019105302.tcvfxn4z7nzkit5d@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019105302.tcvfxn4z7nzkit5d@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_035341_018692_5242931C 
X-CRM114-Status: GOOD (  18.26  )
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

On Wed, Oct 19, 2022 at 12:53:02PM +0200, Daniel Wagner wrote:
> On Wed, Oct 19, 2022 at 10:50:04AM +0200, Pankaj Raghav wrote:
> > Hi Daniel,
> > > > When I reviewed the tests I asked wrongly for GPL-2.0-only. The
> > > > project is using the GPL-2.0-or-later license. Relax the license
> > > > requirement to GPL-2.0-or-later.
> > > > 
> > > > Cc: Arunpandian J <apj.arun@samsung.com>
> > > > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > > > ---
> > > > Hi Arunpandian,
> > > > 
> > > > Sorry for the mess, but could I get a signed-off-by from you?
> > > 
> > > ping?
> > > 
> > I heard from the team that he left Samsung. Do we have any other
> > alternative to get this patch in?
> 
> Right, the mail was bounced. I think it would be enough to get a signed
> off by any Samsung employer

employee obviously :)

