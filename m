Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E62C41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psj6vHZTsE5ixwjTanrLO2bS4Q1cSGBfPcUX7A4ZUvI=; b=3MmGlsYi4chMTXkGLes7J0qGrz
	uRmbliyZn4WJpsfIQQsizpjxvlmBPqSAVJ2eHImaDPFx8swwnVW0X8kysLEhdYqPTNGprOQpKcU26
	KfxZYLnbMhqGNEvLeEuGNzjMh7pMJJsk+npI/kC1Eee6RagLQTU/8144yp4ZDfAldYOkbdemL0fxu
	bbhzPM/Dkckae0df3nv6UwRexDtKUK6E/eh3cZBMnu5QHgqCvIueHnYSAwtUng8WW2uRp6ZQ1LMgs
	R5B9vY+5EKFI9UThq3SRkJc7ZBimbuNib5/2Vg+JPESUsGh3KYKDJwCMcIQNLot6ZoF1WpA+t7YwL
	0YdXs9aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdtr-00EwR0-26;
	Tue, 19 Dec 2023 17:28:59 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFdto-00EwOS-2i
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 17:28:58 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D877D1F7ED;
	Tue, 19 Dec 2023 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703006934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psj6vHZTsE5ixwjTanrLO2bS4Q1cSGBfPcUX7A4ZUvI=;
	b=oAvDcdssSFxjg24ngaMSDvm2XXV1WOTFdkAWa+DgOCTBoRbGzQ1aY5wq6Y6OMGUtaePbvn
	V4Ts693+UMcJDxvLrOWmFS7uTTzN1ZeddHkaRyg6wGuAQDJpfG345BZtWtT+/WikRMNcOE
	t2sCBx+0pp8H9xHgzZIcV9wFKKxS3t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703006934;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psj6vHZTsE5ixwjTanrLO2bS4Q1cSGBfPcUX7A4ZUvI=;
	b=ShHgnMbiM6/cVDJ2tMIozJKWpNqzCTVomiOBO2izr3tebuquai0RoHy9I9Ph1XSj9e0J6t
	czfOh4W8zIxZ8sDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703006933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psj6vHZTsE5ixwjTanrLO2bS4Q1cSGBfPcUX7A4ZUvI=;
	b=BgvqBJB83kp5Ux8ntrqtyOKHiBSo8iaLa9Bd3DHREX3xwDNCXn7OTjJMY0dXhRL8oJqsUP
	m9b6Spgn86UfvJR8spnI0TqgrmqyzKIC3MHpIdeQ9eIFKuWOCNtAUmyL5N84wRJzO1ZpuU
	Qe0setjreTvQvx6OQFbEHDa6X3hzzco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703006933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=psj6vHZTsE5ixwjTanrLO2bS4Q1cSGBfPcUX7A4ZUvI=;
	b=zWE81ltfl59WHb5gzVNmIQDZxL7ZS9d4z1oiD29ZPzYQqi+Rwfl1GIVcbBI5hDqYFdemUr
	QVFkncrE/QkWzsCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AEB8F13B9B;
	Tue, 19 Dec 2023 17:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jvr6J9XSgWXAHwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 19 Dec 2023 17:28:53 +0000
Date: Tue, 19 Dec 2023 18:28:48 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: ioccsz and iorcsz check failing
Message-ID: <hqha2fmtutg2p3daqjz7g4ozlkl25orvkirgyq4tibq6c6e7k6@losspn6rhbgm>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BgvqBJB8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zWE81ltf
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.48 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.17)[-0.831];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: D877D1F7ED
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_092857_039977_C17109FC 
X-CRM114-Status: GOOD (  28.66  )
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

On Mon, Dec 18, 2023 at 06:04:46PM +0200, Sagi Grimberg wrote:
> 
> > > Is anything else in the identify wrong, or is it just these
> > > fabrics fields?
> > 
> > So what I am seeing on the wire are a few fabrics commands (connect, get
> > property) followed by the nvme id ctrl command (opcode 0x6).
> > 
> >   nvmet: nvmet_req_init:962
> >   nvmet: nvmet_parse_admin_cmd:1011
> >   nvmet: nvmet_parse_discovery_cmd:359 opcode 6
> > 
> > This calls then nvmet_execute_disc_identify, so adding
> > 
> > --- a/drivers/nvme/target/discovery.c
> > +++ b/drivers/nvme/target/discovery.c
> > @@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
> >   {
> >          struct nvmet_ctrl *ctrl = req->sq->ctrl;
> >          struct nvme_id_ctrl *id;
> > +       u32 cmd_capsule_size;
> >          u16 status = 0;
> > 
> >          if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
> > @@ -289,6 +290,17 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
> >                  id->sgls |= cpu_to_le32(1 << 2);
> >          if (req->port->inline_data_size)
> >                  id->sgls |= cpu_to_le32(1 << 20);
> > +       /*
> > +        * Max command capsule size is sqe + in-capsule data size.
> > +        * Disable in-capsule data for Metadata capable controllers.
> > +        */
> > +       cmd_capsule_size = sizeof(struct nvme_command);
> > +       if (!ctrl->pi_support)
> > +               cmd_capsule_size += req->port->inline_data_size;
> > +       id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
> 
> Yes, this is the culprit. Nice that it exposed a bug.
> 
> There is no in-capsule data for discovery controllers afaict.

Okay, I have no idea. I stole this from nvmet_execute_identify_ctrl().

I tried to read up but couldn't really find a proper answer. And I am a
bit confused about the TCP transport definition. If I got this right
then a min size is not defined either for fabrics commands or responses
depending if it is in-capsule or !in-capsule supported. But never are
both values are defined at the same time.

RDMA is a bit more clearer on this topic and says for admin commands
these value are fixed is in line with your statement

The PI check is kind of useless as we only deal with admin commands
anyway.

Anyway I am fine by just dropping the inline part as it doesn't seem to
impact the functionality for the discovery controller. But I suppose it
would be good to know why this is the correct thing to do.


  3.3.2.1 Capsules and Data Transfers

  The capsule size for the Admin Queue commands and responses is fixed
  and defined in the NVMe Transport binding specification.


  7 I/O Commands

  The user data format and any end-to-end protection information is I/O
  Command Set specific. Refer to each I/O Command Set specification for
  applicability and additional details, if any. Refer to the referenced
  I/O Command Set specification for all I/O Command Set specific
  commands described in Figure 390.


  7.2  Transport Capsule and Data Binding: Fibre Channel

  [ no public documents ]


  7.3.2 Capsules and SGLs (RDMA)

  The capsule size for Fabrics commands are fixed in size regardless of
  whether commands are submitted on an Admin Queue or an I/O Queue. The
  command capsule size is 64 bytes and the response capsule size is 16
  bytes.

  The capsule sizes for the Admin Queue are fixed in size. The command
  capsule size is 64 bytes and the response capsule size is 16 bytes.
  In-capsule data is not supported for the Admin Queue.


  7.4.3 Capsules (TCP)

  The NVMe/TCP transport supports a message model. Data transfers are
  supported via a transport specific data transfer mechanism, described
  in section 7.4.5, and optionally via in-capsule data. NVMe/TCP capsule
  sizes are summarized in Figure 62. The size of capsules is variable
  when in-capsule data is supported and fixed when in-capsule data is
  not supported

  Figure 64 (size in bytes):
                               !in-capsule    in-capsule
  Fabrics and Admin Commands:  n/a            64 - 8256
  Fabrics and Admin Responses: 16             n/a

