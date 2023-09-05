Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E0CC83F3E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HhetfFhOHSS+038oUbTRXF+UPsEC1zWgHiLgMmQPm+8=; b=RjQAKPo4Rx1d0deUXAlk3DgPlW
	4xCxCHmBM70E4uRo8zJRy+0FD8y6jfI+bE4lR5YTtqzzahooMZWXDZNXDoeJKXEwwiOU/XPAmBa+S
	TbjUd9laAOkIa6TqRqfVpQc6TpHkFcBj7IEKkxE/LUWxiRlx0HUNVsqeynyb3s8aGJL3UrBJarjLj
	VeeF6MqwUyKd7LcX3AwoIS611etHymUJLye08+7aVm3bNSCka1fj2zbSITdhrH1dv+CYJwoxP/Skq
	CV7zjIRXDQIO6WhJjoJCsQuOUiueLETWT+Ke7vTz3m12sth069PMZ6yw7M8CAsTs6FYZ+0QElhtxJ
	femqRgvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRNi-005WGU-21;
	Tue, 05 Sep 2023 08:25:54 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRMM-005WFs-01
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 08:24:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E26EF211CE;
	Tue,  5 Sep 2023 08:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693902262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhetfFhOHSS+038oUbTRXF+UPsEC1zWgHiLgMmQPm+8=;
	b=jzMKCa2yYWLNbfwAIS2rBWTr9eS6/cnY90D+QVv1bapYAGptYG6dFSlVkSCyqum2Fxg+9l
	RJGb6RUbz2TMrm+X6LJmqT7nLS0/hGP4TfVtuhisMO7X2LhUcyVU6hobe+bDbjlzFeTdmX
	bBLPIgQroN27pkm0RSTwgKr4Jy3Cx3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693902262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhetfFhOHSS+038oUbTRXF+UPsEC1zWgHiLgMmQPm+8=;
	b=3T3MucQ0R/XLFrtX5Zkf4gscLBBxnJdjJqws7kMT00NNJjtBo+zucaz+kvAY0am9tDVcJQ
	2Jt2C9QLBnlpJlCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D52EC13499;
	Tue,  5 Sep 2023 08:24:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RkkENLbl9mSoDAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 05 Sep 2023 08:24:22 +0000
Date: Tue, 5 Sep 2023 10:24:51 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 1/4] nvmet-trace: avoid dereferencing pointer too early
Message-ID: <77nt3zr7rap6w7bpvm6vfdqqf4xc46afq4tzlifsn3zlry5wvh@t2e6orslw6on>
References: <20230829091350.16156-1-dwagner@suse.de>
 <20230829091350.16156-2-dwagner@suse.de>
 <20230905064846.GA19701@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905064846.GA19701@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_012430_204044_3FBA5EFE 
X-CRM114-Status: GOOD (  11.65  )
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

On Tue, Sep 05, 2023 at 08:48:46AM +0200, Christoph Hellwig wrote:
> > +static inline u16 nvmet_req_to_ctrl_id(struct nvmet_req *req)
> >  {
> > -	return req->sq->ctrl;
> > +	if (!req->sq || !req->sq->ctrl)
> > +		return 0;
> > +	return req->sq->ctrl->cntlid;
> 
> Can you add a comment here why we have this check?

/*
 * The queue and controller pointer are not valid until an
 * association has been established.
 */

?

