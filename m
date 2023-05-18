Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87221C77B7D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35wFhivmcYCWnVrRWAiYgC66ZHYrppThfjDiaL7jSDs=; b=JDvZPvb+BySMY+mCfrbuQz9z1r
	Wiru9vPEaMZGqnkJsd5k5dp1IbSFIhuQ55FSh3H8+Ocil63Bz6rFDmMhpvmi2efEPOtT2SjEM7Sqn
	5HT2zXS7unIMGNkuyEQipqwF2AueI6E7A0UpnhQ1ookEhGBDGEiOdkoqg7tjFMNiYMBRkym4Xcp9A
	ZOGMgVx9OOPuqBzjRETte0A58ZQEdWHf/srqRpqRmL+oQxYSYUW9GzSuQ4+kWeajh9VP545a2GxqE
	1vJz8dSzPYnVcGQ7jqgUZl0lf9aBU1QxlN8deiaQkL3KQ136cjk3yiq5JCo77KuBSvqMNx+6HJ2yX
	KbH+A+sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzYQv-00CG5S-0e;
	Thu, 18 May 2023 07:52:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzYQs-00CG3c-0r
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 07:52:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 199CF22618;
	Thu, 18 May 2023 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1684396332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35wFhivmcYCWnVrRWAiYgC66ZHYrppThfjDiaL7jSDs=;
	b=gNaF4FEF4sCEAoxMytxwRr24GdjT8ysJtK4mZVMdB6U7mOAaNy9+e/8ROl4bTWmVE5p2kl
	ooY4Tybp8d+N0Zie0mPzgBkdlsvfONKgCMPjMyzpz1gUj3RknDCfNKrjI3JTVeS6zUHnpB
	4yVehVoifvGbZDr8er2poJBS5RZ3/HI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1684396332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35wFhivmcYCWnVrRWAiYgC66ZHYrppThfjDiaL7jSDs=;
	b=mMuwCITDzTnnCtb0M9rvVEUBnsoij5qy+Bez40xgUbr1ldcfQWzVPwim0FVUDQ2efW9cQO
	V0qP84RymdNjyrBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08CAE1390B;
	Thu, 18 May 2023 07:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iU/FASzZZWRpKQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 18 May 2023 07:52:12 +0000
Date: Thu, 18 May 2023 09:52:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v4 05/11] nvme{032,040}: Use runtime fio
 background jobs
Message-ID: <eykbvi7lzhnbd6ft6cva6qu4lp5ryn3ha2fgigmao2553qm4bu@227ey5mv5ls5>
References: <20230511140953.17609-1-dwagner@suse.de>
 <20230511140953.17609-6-dwagner@suse.de>
 <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c50cda-23f5-b55d-a902-ce34de8498e1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_005218_472414_BA53271E 
X-CRM114-Status: GOOD (  12.65  )
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

On Wed, May 17, 2023 at 04:40:52AM +0000, Chaitanya Kulkarni wrote:
> On 5/11/23 07:09, Daniel Wagner wrote:
> > The fio jobs are supposed to run long in background during the test.
> > Instead relying on a job size use explicit runtime for this.
> >
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Is there any issue with the exiting approach for this change ?

The expectation of the test here is that there is a background job running.
Depending on the job size is an indirect way to express run at least for x
seconds. This gives a variable runtime as it depends the how fast fio jobs gets
executed. Explicitly telling the runtime is my opinion more robust and documents
the indention better.

