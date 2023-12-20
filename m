Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B69C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XugWTmukybyU7es8QjD+7uIuHLgaQAyehpCutf0a6tw=; b=qiScS3oxo4XUDbXpXQndjRdM2F
	WYI8oCkLk3MGWrLLqgP7aa476Hf2s534l9fywF+7LyQBbxl3/qyqqk2sP+eYHN/WoKSpRKGZJBRZG
	8vf8S7sJMnCxe34caUoo0t6SJCqslfdwRw6zlO2nZv8GqQt5aOKjpqwSvUpQXTq/mEtcyJw19buNe
	ueZo12vJm1IQPkNkFrArlS8iI8RYUwdXt3oVKP/HbPBWjSn/oekxajxiADkjnkOsxnzdUY6XzrVL3
	aEUpfQWcb3EXQpFBhihpA1ybnDirdxlcEwj28S/BLw+pn3hHfT147bmRp5+FsPxWl1bLui1GdmgXj
	eDXW/1PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFsV5-00Gg1v-1F;
	Wed, 20 Dec 2023 09:04:23 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFsV1-00Gg0r-1w
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 09:04:21 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FFCB1F81D;
	Wed, 20 Dec 2023 09:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703063054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XugWTmukybyU7es8QjD+7uIuHLgaQAyehpCutf0a6tw=;
	b=PLUqVx1S5aJ6iDOeCr5jQWnsMaEL8YxoEFSf0twbjA9A39fRoKHxuh9LXl5gVgN5o1jFry
	oDYb0mgPlx2NpDWfXol8coLX03iz2H296On6Dx+4+1niO2Gt/EeyMuO2Lrf4+ow4Z15auV
	cy8mUehqPJRfZWnJP2CZcauOt3RkkzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703063054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XugWTmukybyU7es8QjD+7uIuHLgaQAyehpCutf0a6tw=;
	b=igg0hrFkhWixniUN7DqNMyu6LUI3htIlotFv7qHBkv1NtOI/XU/1hM4jw0gQURKIhXcRr7
	yBXO07n9zsWHOTDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1703063054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XugWTmukybyU7es8QjD+7uIuHLgaQAyehpCutf0a6tw=;
	b=PLUqVx1S5aJ6iDOeCr5jQWnsMaEL8YxoEFSf0twbjA9A39fRoKHxuh9LXl5gVgN5o1jFry
	oDYb0mgPlx2NpDWfXol8coLX03iz2H296On6Dx+4+1niO2Gt/EeyMuO2Lrf4+ow4Z15auV
	cy8mUehqPJRfZWnJP2CZcauOt3RkkzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1703063054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XugWTmukybyU7es8QjD+7uIuHLgaQAyehpCutf0a6tw=;
	b=igg0hrFkhWixniUN7DqNMyu6LUI3htIlotFv7qHBkv1NtOI/XU/1hM4jw0gQURKIhXcRr7
	yBXO07n9zsWHOTDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9057813927;
	Wed, 20 Dec 2023 09:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fH1DIg6ugmWHVAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 20 Dec 2023 09:04:14 +0000
Date: Wed, 20 Dec 2023 10:02:00 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: ioccsz and iorcsz check failing
Message-ID: <jdd6gayqq5ysuhaaidhwngtc4ba7wecwoyxpqtw36j4bpz7bhg@jgcuumcgzjpm>
References: <6ib6nyftuap3ubf7uryt6sndmomfif47nkforsitadbda2pdkb@ie35lozrsiqf>
 <ZXyWKKhaDUpyOXsK@kbusch-mbp.dhcp.thefacebook.com>
 <74327ed0-63f6-4e9e-9d7c-2bf0eaf264d3@grimberg.me>
 <p5sosvqw3z4bajhhobw2eng73dfk6drbjgste4hrik3te4wie4@wxytk76vjlim>
 <0efbe093-6f9e-4026-92aa-3442bde68e7b@grimberg.me>
 <d2754a5a-8162-4e66-89ba-466127eb7d3a@nvidia.com>
 <c566399b-04cb-4aea-beb8-230dbdc9ebf9@grimberg.me>
 <af03a48b-1084-4049-8cf7-a48088b3e5e2@nvidia.com>
 <a4ec22ae-c7b7-4583-a41d-52755eb5f301@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ec22ae-c7b7-4583-a41d-52755eb5f301@nvidia.com>
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_010420_647950_AE1A6B95 
X-CRM114-Status: GOOD (  18.75  )
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

On Wed, Dec 20, 2023 at 02:10:42AM +0200, Max Gurtovoy wrote:
> I just saw that Caleb also noticed that it shouldn't be relevant for
> discovery controllers. The mail got lost in the mailbox.

I found it also in the spam folder.

> Anyway, I believe the initiator/host code should be updated for 6.7 and must
> ignore these fields as the spec explicitly said it is reserved.
> For the target side, I prefer to keep it 0 for reserved fields since this is
> the convention in all the specifications that I'm aware of.

I've tried to figure out what our testing storage servers report (NetApp
AF-700 and a Dell Powerstore). Though I can't access our equipment right
now due to recabling activities in the datacenter.

> I have a small bug for above code so please use:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ee2e4c49892d..b218ac88fcf8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3068,14 +3068,14 @@ static int nvme_check_ctrl_fabric_info(struct
> nvme_ctrl *ctrl, struct nvme_id_ct
>                 return -EINVAL;
>         }
> 
> -       if (ctrl->ioccsz < 4) {
> +       if (!nvme_discovery_ctrl(ctrl) && ctrl->ioccsz < 4) {
>                 dev_err(ctrl->device,
>                         "I/O queue command capsule supported size %d < 4\n",
>                         ctrl->ioccsz);
>                 return -EINVAL;
>         }
> 
> -       if (ctrl->iorcsz < 1) {
> +       if (!nvme_discovery_ctrl(ctrl) && ctrl->iorcsz < 1) {
>                 dev_err(ctrl->device,
>                         "I/O queue response capsule supported size %d <
> 1\n",
>                         ctrl->iorcsz);
> 

With this blktests is happy and connecting to a remote nvme-tcp target
(Linux 6.1) works fine. So if you spin a proper patch feel free to add

Tested-by: Daniel Wagner <dwagner@suse.de>

