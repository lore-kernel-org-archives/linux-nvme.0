Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB3C4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Apr 2024 19:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uk1Peb2tT+6rsFfGn+tzZBoBNaYEE2YnKLl/x0Wgv8k=; b=yqSsDRQjy1IrIgfM/kM1QI5q5+
	luFVWdDg3IRmZKsBYtuHAHn83zAeUsjC16QljXfLS5bos2MT6Tj6IyfSjeH2DW/8Hxo5T0AkrFV3E
	X7ZEFREt2NXuYbRCH4ElyO+iUQAXZdR1lCOUOmNfPhsDx9BgNwL+Bo/PmovUQU2puxBSZIdEGy4st
	GD9i4MwwNANXwTCgLg8UUYRc7nd+eSHo9hT6YKLYWtIOVKp6gOruaschourmFJIQlk8yIKrGXbkPk
	IsZEmJGyC5e8+pnDmsyoCu0jZ58ZjxKBPXe5EkYicg4nESnc3Ge8XD2inMylKRQDXaRDpBW3/Y3Id
	A/lJk3dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv027-0000000Dsqi-2BnG;
	Thu, 11 Apr 2024 19:24:27 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv023-0000000Dspe-0yeu
	for linux-nvme@lists.infradead.org;
	Thu, 11 Apr 2024 19:24:25 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72A7B3788F;
	Thu, 11 Apr 2024 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712863461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk1Peb2tT+6rsFfGn+tzZBoBNaYEE2YnKLl/x0Wgv8k=;
	b=zIyfBCwuvZllsglabxUow9Zy0mWD+R5CXlhV/mkOV8g98qeNVN9lcm5Xo2wbcoYgtnPqtB
	F/8vxhXdjuS1zu9oqtkvvA9ppYrCEQg8P9Px9aBM46nj3aj8PC8k4OzHP/GD/Z4XoF7ZCR
	62lnmj/mPZpF/ghyU+GKUr+AaKnIM14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712863461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk1Peb2tT+6rsFfGn+tzZBoBNaYEE2YnKLl/x0Wgv8k=;
	b=mn/qx25Mu4A3bwlqmeUB13JfwtmpMKK5ur8xkXUbeNa8R8Q3fSVloTZ56lYWvNBtG0fyRQ
	f32CvAlI94Kit5Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712863461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk1Peb2tT+6rsFfGn+tzZBoBNaYEE2YnKLl/x0Wgv8k=;
	b=zIyfBCwuvZllsglabxUow9Zy0mWD+R5CXlhV/mkOV8g98qeNVN9lcm5Xo2wbcoYgtnPqtB
	F/8vxhXdjuS1zu9oqtkvvA9ppYrCEQg8P9Px9aBM46nj3aj8PC8k4OzHP/GD/Z4XoF7ZCR
	62lnmj/mPZpF/ghyU+GKUr+AaKnIM14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712863461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uk1Peb2tT+6rsFfGn+tzZBoBNaYEE2YnKLl/x0Wgv8k=;
	b=mn/qx25Mu4A3bwlqmeUB13JfwtmpMKK5ur8xkXUbeNa8R8Q3fSVloTZ56lYWvNBtG0fyRQ
	f32CvAlI94Kit5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EF3013685;
	Thu, 11 Apr 2024 19:24:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y4vNFeU4GGYmJgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 11 Apr 2024 19:24:21 +0000
Date: Thu, 11 Apr 2024 21:24:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Is idenditfy ctrl cmd supposed to return a 'result' for RDMA?
Message-ID: <gzutb6z3rv377tazt3evxetc3w3uggw7gx52p3edoiubzgry6j@hcfmkjj3iodp>
References: <pdazbshqj2kqkhtmdp4m4qtaqexu7bfio2ccampteskuugqmkf@srgzsimaj3bn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pdazbshqj2kqkhtmdp4m4qtaqexu7bfio2ccampteskuugqmkf@srgzsimaj3bn>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240411_122423_454876_EF735E33 
X-CRM114-Status: GOOD (  12.97  )
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

On Thu, Apr 11, 2024 at 12:51:40PM +0200, Daniel Wagner wrote:
> but got a bit lost in the RDMA code. So I am not sure, is this supposed to
> happen?

After reading up in the spec, it doesn't seem so. After adding


diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f5b7054a4a05..a297020f4bea 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -486,6 +486,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)

        kfree(id);
 out:
+       req->cqe->result.u64 = 0;
        nvmet_req_complete(req, status);
 }


the problem goes away. I've also noticed that many other commands return
a lot of 'funky' results as well. I haven't understood why setting
the result explicitly to 0 is necessary for RDMA yet.

