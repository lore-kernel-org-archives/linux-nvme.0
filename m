Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC510C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1utLzmHsMkc77b/rZG5l9bAIP83HIHK1q56lBCBh68=; b=zTAik5R5qLStQ7lCyPEtq7hbLw
	YGKP+g7DoY8S+sA0K/onlNLmR6CgCpEaCgVMZBVw+SfFf6+shAf8Yzyt5eg9JMwizaHyRjL92dnL9
	zMC7GLvFl//QF1tD6OYOs1eglfHzxio450jvtiwmF3YQ1uvTVlv2J0Fkgo3LOnUfEpqnu/9g4oqer
	+5Um47M/qqHnkVcNZwcKextdH9UolNF9vBqy5RNkD3Tqtgt8rqMzJUqeVScwNYCVr4gzMszgLlBuC
	XGGU0d9bIJUFnXgjniMxWGaE67ge+cPTwuFwoe1VHVW/c7bTX7nHwuF6IfXXdLk/fBnnsDIx+w24F
	8y42D4Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsPv-0021dr-2n;
	Tue, 02 May 2023 15:59:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptsPt-0021dJ-2z
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 15:59:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D98061FD72;
	Tue,  2 May 2023 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683043187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1utLzmHsMkc77b/rZG5l9bAIP83HIHK1q56lBCBh68=;
	b=q4JE4PMVUMYIh9YxHKlcJ0852aU/Y8LMfQK9tqHPT6u+KcUYZEuYTd3DTSsp0OCw+6S8he
	qijqwFwvn5FTZfRoDfumxWOBdyhZ/cuNVBeYLMjwzJwOI5H1VTWNg8ERp4DqtEn5XmOqdi
	rB77lSfgvjxaPdWE59gSyph61eNfeLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683043187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K1utLzmHsMkc77b/rZG5l9bAIP83HIHK1q56lBCBh68=;
	b=ZBH8RB3YLCd8fdbO+LsXEvmiV5vdSBFLaWAhS9tcSvUJ9B5BEUBmC/qeXDg/Sf8j+YDr1t
	vvhaMgzhFH0nZEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA5C5134FB;
	Tue,  2 May 2023 15:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fQ1kMXMzUWSvMgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 15:59:47 +0000
Date: Tue, 2 May 2023 17:59:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 9/9] nvme: Make the number iterations
 configurable
Message-ID: <iephcaynceoq5gpcvpcjzqngyjdefockihh23fxqez3yme3syr@avykw2xnyyyy>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-10-dwagner@suse.de>
 <yuwidfmwcg2iue2fm4wqyd2p3vmzo34t6hqr7rvf3d3rkh3ag3@wvpu4f3aqhly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yuwidfmwcg2iue2fm4wqyd2p3vmzo34t6hqr7rvf3d3rkh3ag3@wvpu4f3aqhly>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_085950_110497_72457B24 
X-CRM114-Status: GOOD (  10.51  )
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

On Fri, Apr 28, 2023 at 04:12:06AM +0000, Shinichiro Kawasaki wrote:
> >  nvme_img_size=${nvme_img_size:-"350M"}
> > +nvme_num_iter=${nvme_num_iter:-"100"}
> 
> The commit log of tests/nvme/002 says that "Test nvme discovery with many (1000)
> subsystems so the discovery log page exceeds 4k.". Can we fulfill this test
> purpose with the default value 100?

I am going to drop the nvme/002 change in this case and set the default of
nvme_num_iter to 1000.

> Also, nvme_num_iter will need description in Documentation/running-tests.md.

Sure.

