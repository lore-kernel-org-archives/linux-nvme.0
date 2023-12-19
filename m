Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B50FC41535
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=; b=Pp9POPN5rI+EZpBQmSIzVtM9eN
	zT/pWvTyntGSAVgQaKb+IJorRT1ljkuHo7w8We/X5339U8kDXdTXnKpD8DwVmKIZp8tf9MQNV5NAy
	XEPUNBm/g3aPz+gigszV3zAUsvSaojoZLelXdd0vN2ZNFFO4OymNyVcWCDu6/pO5HEtRrKyiNnU3v
	rz4BFDV256IrbDUcIpMQp5hrkt2HZ899nNbv4Is+3YYrO9XFxCrdLVkVq/K09CeE9f5/BWWqXiMSv
	gSgcNTafOT6SPhGgKvT/E47i1uTMays2GmNm5DUUr+dQrwOBOiTi8Ol/sdFJuGVJ1Rxnno0LMdm5S
	7yVpdCog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFboJ-00EWEN-0h;
	Tue, 19 Dec 2023 15:15:07 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFboG-00EWCe-39
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 15:15:06 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AF4E1F7C9;
	Tue, 19 Dec 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702998902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=XccugP6V9mOSqAF3XMjc+FNyX8RyzRFKXkiS9xTrx3Kk3dsKooTXU1QtJyn2fsn9yNn6x/
	HY7gu1MzDv/mNjDyNSepFtSpZjyT53Q0kSB3Yw5og6bzY7uS1SfZxsmOl4UmBgwv1XKpkk
	Ors64/EJkLoNClSQR+pIf4V2IsJOheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702998902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=548TD8ANtNA0cf5N0kK6iobtEySQVB71WWm72LLAHrEeJs7oaNoruMJp/y99lWtmEnxe27
	8LOM8Cdn9GNVpjCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702998902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=XccugP6V9mOSqAF3XMjc+FNyX8RyzRFKXkiS9xTrx3Kk3dsKooTXU1QtJyn2fsn9yNn6x/
	HY7gu1MzDv/mNjDyNSepFtSpZjyT53Q0kSB3Yw5og6bzY7uS1SfZxsmOl4UmBgwv1XKpkk
	Ors64/EJkLoNClSQR+pIf4V2IsJOheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702998902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7e5XCCyINAJ+NzY1e0bqdj0ZqmCV70DZ2zp5UsU/L/o=;
	b=548TD8ANtNA0cf5N0kK6iobtEySQVB71WWm72LLAHrEeJs7oaNoruMJp/y99lWtmEnxe27
	8LOM8Cdn9GNVpjCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 36DF013B9B;
	Tue, 19 Dec 2023 15:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9vLjC3azgWUyfgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 19 Dec 2023 15:15:02 +0000
Date: Tue, 19 Dec 2023 16:15:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Message-ID: <zxwj5jupg7rlbtdrqloecw3ta4oybfguue5hrdlf2j3o35xusv@wp6kq4kujfli>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-2-dwagner@suse.de>
 <e0eb22cd-9959-44cb-b913-4c1be9a2a2f6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0eb22cd-9959-44cb-b913-4c1be9a2a2f6@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.96%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_071505_172071_4796DE85 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

On Tue, Dec 19, 2023 at 08:24:58AM +0100, Hannes Reinecke wrote:
> > +	 * Disable in-capsule data for Metadata capable controllers.
> > +	 */
> > +	cmd_capsule_size = sizeof(struct nvme_command);
> > +	if (!ctrl->pi_support)
> > +		cmd_capsule_size += req->port->inline_data_size;
> > +	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
> 
> Why the division by 16?

The unit size is 16 bytes:

  I/O Queue Command Capsule Supported Size (IOCCSZ): This field defines the
  maximum I/O command capsule size in 16 byte units.

