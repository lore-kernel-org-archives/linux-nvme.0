Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B13EB64D9
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tX0OhCvnYEom9wQyUBB776472LobDXtBtt3bT5sVnDk=; b=bjCwuVvMekEwyKD4bYQc+1ReW+
	Z7MMgr1uGrpAsr/p9GGRK/suaVhg31MWyazOTd3TQUX+0GqjKR5Bk/LXzFTQyeL6XdF60elslyaXC
	uKiaZXShbRVOLUJCMlZHrcIDVshuJ9qWfdwqWVAjvgnppK4n4YoN7ByJcU5R4YivYlqVosMQ05jtA
	wkG1TQmGIhEVelxnfMpZUP1rie6RcUhxZP/xZVpBuJ03v8abtiZkCNo3vCH1q/Ffe/bzfte7Zkb2C
	X2jYwdbO+jk4fxyPj/MkEdFXdN67MMGIWpCC8xKT/2GIETOx0jIVsndIoeas0vyRnqJuhppdYSr6V
	2+XCYVlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEmCp-000DpF-2N;
	Thu, 29 Jun 2023 07:36:43 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEmCl-000DnK-19
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 07:36:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAA6521861;
	Thu, 29 Jun 2023 07:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688024193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tX0OhCvnYEom9wQyUBB776472LobDXtBtt3bT5sVnDk=;
	b=AtkqT/ZvBJoU1ru8jku3GOZ/HOGFnyZ8j4vSIFwBYB4iZO3FEx5RWLrYKwngmXlK46N+el
	ruMKbJfTw20/6IbbJsGS9NR1MxCl2lXmsWkbDo61tS+Z7ukqrYz5oTCxKKquqwlNC2FQQ+
	EVRtMSPQMk3Mr/d4rHXyciQteXMxL9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688024193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tX0OhCvnYEom9wQyUBB776472LobDXtBtt3bT5sVnDk=;
	b=r0l2OTvVav/YVmGvHuM65jwliCcEd9QU30jsowNy8BC+uTL+yrATzbq7QF+7U8tcQ3ezQ1
	HGz7AkxCNa6CGDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA92313905;
	Thu, 29 Jun 2023 07:36:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sUBxKYE0nWQERAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 29 Jun 2023 07:36:33 +0000
Date: Thu, 29 Jun 2023 09:36:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Message-ID: <yqwto3tm4wjgowmavc3unucq47hf5xeeqsp5baqggtzo75nmu2@4o5pbethrqcw>
References: <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
 <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <000e3d0c-0022-c199-1f8d-97e191345197@grimberg.me>
 <d5d9bd87-1d5b-d66c-39c4-e35c0e5ddc48@nvidia.com>
 <94785130-4f40-aa29-9232-af8a8f1ca1c9@nvidia.com>
 <7d6m3ha3rqc73q22d4bsxtc4u2cqb4ryp6f4q7ajvazdpek2ko@nh6a6biyryxd>
 <0ad16fbf-6835-50ac-443b-46443c8656e8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad16fbf-6835-50ac-443b-46443c8656e8@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_003639_577100_81042265 
X-CRM114-Status: GOOD (  11.05  )
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

On Wed, Jun 28, 2023 at 02:00:57PM +0300, Max Gurtovoy wrote:
 > --- a/tests/nvme/rc
> > +++ b/tests/nvme/rc
> > @@ -14,8 +14,23 @@ def_remote_wwnn="0x10001100aa000001"
> >   def_remote_wwpn="0x20001100aa000001"
> >   def_local_wwnn="0x10001100aa000002"
> >   def_local_wwpn="0x20001100aa000002"
> > -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> > -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> > +
> > +if [ -f "/etc/nvme/hostid" ]; then
> > +	def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> > +else
> > +	def_hostid="$(uuidgen)"
> > +fi
> > +if [ -z "$def_hostid" ] ; then
> > +	def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
> > +fi
> > +
> > +if [ -f "/etc/nvme/hostnqn" ]; then
> > +	def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> > +fi
> > +if [ -z "$def_hostnqn" ] ; then
> > +	def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
> > +fi

Is there a specific reason why we want to read the /etc/nvme/hostnqn file at
all? Can't we just use a fixes hostid/hostnqn?

