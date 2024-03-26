Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05527C54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r4/J+Pu45QBu7SN6sR4JDNejy1FBX+4sp45pF8IF5RI=; b=0awVUOaugz6C/oJWpT34ACTWCi
	0qIzlEx8bzWmt2UoSmyoIP3RZwCjs1b4UE6ApZhS1brZah01KlHohyRYXjhjEzj+9ZTCFt3WSu1HB
	zWuwa38DAgMdxbX7BnYhivxxyJNXAAikMsSJ7KvIIe542DDzalDx6ujLWdJRXoDoNE9Hi8qMJw+Ym
	9HF6Pv8/A80eSeqLAitiHZdZfM2tCH9qjSIEA09EeZeQHAFgJ5mDvtZIuyiGz6BuzD+DWfTToM1uP
	c7QkaiGclr3uDr6S4B8u2k5wI5ufCbx6WiALmJrdNXRGDGp3EAaFA2RsLIYFsbF4O6SwNF6BD5b+m
	NBFFbNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp13D-00000003PPn-3Ehe;
	Tue, 26 Mar 2024 07:16:51 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp134-00000003POC-3K8K
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 07:16:48 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB135D243;
	Tue, 26 Mar 2024 07:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/J+Pu45QBu7SN6sR4JDNejy1FBX+4sp45pF8IF5RI=;
	b=DW9haQrEEYcK6nkjxraW+3rrs+Hoy10vIJ5qaSB4am71Z/KbDGgyy/0094Awdo1+5rwt5u
	d2m6DxpHQdF9dENiYhPv0oIc6phmpgrLOeeUcbNFkvlDgVeAF3n6lvSHC7QS9x6Cbvdn86
	DQydtafyLkAMq6N73olrHL3+M2rLxTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/J+Pu45QBu7SN6sR4JDNejy1FBX+4sp45pF8IF5RI=;
	b=a9z2D6HppbOgPVKV6IHo6BartPqDSul6MYjkuTPpyB1wCQfHtW7COwgJzg0AEeIysfhSLp
	+hdOLknWUmgH1QDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/J+Pu45QBu7SN6sR4JDNejy1FBX+4sp45pF8IF5RI=;
	b=DW9haQrEEYcK6nkjxraW+3rrs+Hoy10vIJ5qaSB4am71Z/KbDGgyy/0094Awdo1+5rwt5u
	d2m6DxpHQdF9dENiYhPv0oIc6phmpgrLOeeUcbNFkvlDgVeAF3n6lvSHC7QS9x6Cbvdn86
	DQydtafyLkAMq6N73olrHL3+M2rLxTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4/J+Pu45QBu7SN6sR4JDNejy1FBX+4sp45pF8IF5RI=;
	b=a9z2D6HppbOgPVKV6IHo6BartPqDSul6MYjkuTPpyB1wCQfHtW7COwgJzg0AEeIysfhSLp
	+hdOLknWUmgH1QDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BE7613587;
	Tue, 26 Mar 2024 07:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id X8IpDVl2AmZYaQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 07:16:41 +0000
Date: Tue, 26 Mar 2024 08:16:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Message-ID: <nh4wsng527vedqejgsorrn7g6xxmwjxymzx2cz67ne56o3dbux@s3qccpsokxvh>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
 <26556198-2be3-4a73-b435-bfe3c72d7870@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26556198-2be3-4a73-b435-bfe3c72d7870@grimberg.me>
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_001643_228970_7BEBD9E9 
X-CRM114-Status: GOOD (  22.95  )
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

On Tue, Mar 26, 2024 at 12:39:16AM +0200, Sagi Grimberg wrote:
> 
> 
> On 25/03/2024 20:18, Daniel Wagner wrote:
> > On Fri, Mar 22, 2024 at 08:03:26AM +0100, Hannes Reinecke wrote:
> > > +static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
> > > +				      size_t count, loff_t *ppos)
> > > +{
> > > +	struct seq_file *m = file->private_data;
> > > +	struct nvmet_ctrl *ctrl = m->private;
> > > +	char reset[16];
> > > +
> > > +	if (count >= sizeof(reset))
> > > +		return -EINVAL;
> > > +	if (copy_from_user(reset, buf, count))
> > > +		return -EFAULT;
> > > +	if (!memcmp(reset, "fatal", 5))
> > > +		nvmet_ctrl_fatal_error(ctrl);
> > I'd like to use this also to trigger a reset. This allows to test the
> > auth code a bit better, e.g. after changing the ctrl key on the target
> > nothing will happen until a reconnect happens. Currently, I have to
> > set the max queue count which triggers a reset. Also it would make the
> > 'support real hardware' series for blktests why more generic.
> > 
> > This here should does the trick in my local testing:
> > 
> > --- a/drivers/nvme/target/debugfs.c
> > +++ b/drivers/nvme/target/debugfs.c
> > @@ -157,6 +157,8 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
> >                  return -EFAULT;
> >          if (!memcmp(reset, "fatal", 5))
> >                  nvmet_ctrl_fatal_error(ctrl);
> > +       else if (!memcmp(reset, "reset", 5))
> > +               ctrl->ops->delete_ctrl(ctrl);
> >          else
> >                  return -EINVAL;
> >          return count;
> 
> What is the difference between fatal and reset?

nvmet_ctrl_fatal_error() also calls ctrl->ops->delete_ctrl() eventually
but also logs 'fatal error occurred'. This works also just fine for what
I had in mind.

