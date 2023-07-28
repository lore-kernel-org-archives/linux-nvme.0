Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2CCC04A94
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S5giWyTtDSEtQi4DuN3fhPiwQDgrsnA/JVYekHS77BM=; b=kIw4+exwysjbUrrZ9RG5Y14hqE
	0NqFLLbclYU7SxO+AKq2xN9FN67a5O6GccNIr1/WGyUK3by8h9PkWy2LMI3Rm59l04H3qJYFHoYHc
	oluwN65DnDSnQkeIhhvijVXf0XDQfFRsqRVlPK3fzMT+ApP9UxB4FIVBZJR94EuEXxIzTlJGdzN90
	KqeoDIYhCiqbiFumtLzvaMHdXkJ5B2CAeXtfc8dHF9P0CBdUYFKKYkXdOdZW1wTtRAKwK3Cgzns1e
	fvtZjHeGCQZIGuWI9ED3SDs7a970IStt1IdB3XtVyIgIV1xVagjqZ338x4tvM39iUoLUsZHczohFb
	2vaqvEng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPHFS-001wFu-0H;
	Fri, 28 Jul 2023 06:46:50 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPHFO-001wCz-2a
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 06:46:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0EB851F8A4;
	Fri, 28 Jul 2023 06:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690526803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5giWyTtDSEtQi4DuN3fhPiwQDgrsnA/JVYekHS77BM=;
	b=TuKomdKprX/dXy6LnQsmLi4pdePyGUA9YUZ/lkylC2nTDmu3d2vuJUUOX3Lhm75Ir2zr20
	c2GzyFmGJmH9pRurEZNJibeJDpQaPuKSDtbYHun7N3OTGiwxDgeQOsOHYw0b0H5BMl4V+7
	3B9CAVdQQtsCxzx6VEddm7zLHkC7CBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690526803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S5giWyTtDSEtQi4DuN3fhPiwQDgrsnA/JVYekHS77BM=;
	b=vIeNRmLWyLkE+kz4IiPq/HPCVYiMYqLwabVHnbSigZ/gVVho9Q3eTx7eykScgN/Y/R36Zj
	4rRvJTnwADSfWQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F390B133F7;
	Fri, 28 Jul 2023 06:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id bfSQOlJkw2QVNQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 06:46:42 +0000
Date: Fri, 28 Jul 2023 08:46:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Message-ID: <mg3z32g6kzxhlazrq6akjdm3ggbdqswz4jfeetazwuzcdfrfug@63a7rd47q32v>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
 <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
 <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
 <ky32xyzyii2c5fr7kknyx5z6fikvh674v4sw2s4yux52l4vu7w@4nqmrmyxkwmw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ky32xyzyii2c5fr7kknyx5z6fikvh674v4sw2s4yux52l4vu7w@4nqmrmyxkwmw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_234647_004116_A7CFBB27 
X-CRM114-Status: GOOD (  24.23  )
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

On Fri, Jul 28, 2023 at 05:06:34AM +0000, Shinichiro Kawasaki wrote:
> On Jul 27, 2023 / 08:18, Bart Van Assche wrote:
> > On 7/27/23 00:11, Daniel Wagner wrote:
> > > On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
> > > > On 7/26/23 05:46, Daniel Wagner wrote:
> > > > > Group all variable declarations together at the beginning of the
> > > > > function.
> > > > 
> > > > An explanation of why this change has been proposed is missing from the
> > > > patch description.
> > > 
> > > Sure, I'll add one. The coding style to declare all local variables at the
> > > beginning of the function.
> > 
> > Isn't declaring local variables just before their first use a better style?
> 
> IMO both styles have pros and cons. Declarations at "beginning of functions"
> helps to understand what the function uses as its local data (pros), but the
> declaration and the usage are separated and makes it difficult to understand
> (cons). Declarations at "just before first use" have the opposite pros and cons.
> This style is easier to read especially when a function is rather long.

FWIW, if I keep going with the refactoring (providing helper function to
setup/cleanpup the complete target in one step), most of the tests will be very
short. Thus there are far less variables to declare anyway.

> In the past, I preferred declarations at the beginning functions and requested
> it in my review comments [1], but I learned that this guide is not so widely
> applied: xfstests scripts, or even blktests 'check' scripts have declarations in
> the middle of the functions. So I think both styles are okay at this moment.

Okay, I wasn't aware of this.

>   [1] https://github.com/osandov/blktests/pull/99
> 
> More importantly, this discussion maybe going towards "too strict" guidelines,
> which will discourage contributions. Similar topic is [[ ]] vs [ ]. Once I was
> requesting strictly to use [[ ]], but it did not seem productive. Now I no
> longer request to replace [ ] with [[ ]]. In same manner, I suggest not to be
> strict on the local variable declaration position either.
> 
> As for this patch, it is not required to follow guidelines. Does it make
> Daniel's refactoring work easier? If so, I guess it will be valuable.

IMO, this is the case, because you can way easier identify odd balls in the
large bulk changes where I have to touch almost all tests cases for a change.

So ideally, after these refactoring most of the tests will be shorter. Thinking
about this, I could first introduce these helpers and update the callsides.
Though I find this harder to review because all the tests look slightly
different. But hey there are more one road to reach Rome. I suspect this
approach would reduce the code churn a bit. Anyway, let me know what you prefer.

