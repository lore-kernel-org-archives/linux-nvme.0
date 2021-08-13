Return-Path: <SRS0=sV58=NE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5268C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 09:33:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC3460FC3
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Aug 2021 09:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8AC3460FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u98YNhdFSsQJL2v3TEz1LVQiR5xmWVnhWeP5WWg2Hkc=; b=JfQxlta87pmUMF
	0w+lFl5mCLjkM81pWYt35sym6fSf7KgUeqk+M6asd+nzgCzXNpsUyZIKqp9izQgewixaOD2es0NNi
	h/HlKkXKiofQyNkitpUJHH/W/DcrKvROBGXhO+QTm9vokyfinAXDSEQeXg6uLCnPWGY3N9b7S6F5J
	5g6PPCDvvPdlfAfRCU1tsmCtCX+Xp11Mlg0RBJ21dnWX7X1Ahkom/gwL1nFVzM7xSEhBtH0HFotpn
	C9n/jJnmjaeYajZH6UKAYehthl3AGEkAAev/2YK16C7B/MdCTv3EubpHP03MVMB7rKE74zWHeEvID
	BM+zR6op5uAtNiXMQT4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mETYT-00CLxj-SJ; Fri, 13 Aug 2021 09:32:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mETYN-00CLx7-8n
 for linux-nvme@lists.infradead.org; Fri, 13 Aug 2021 09:32:43 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 366691FFAC;
 Fri, 13 Aug 2021 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628847154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vym3QX3qGOX0DYb4CLu+fvsfBUH5ZnbBYaiIHhsMm/o=;
 b=ZiwtRH2PczQLghKIER4JM6LYfTfqLw6HRi4oOV4JOrrvooa6CgIMzb1Gon7F6Gq9bJaII4
 uPUWCcMkwLeBK5AR5FlEwFY4+FuJaMdnvZGUQ5pARtk5q9tBUGJwjwTLb4j7RNR+fsbx/1
 oxwhtwrw7GwLU7VqqH9FgDl7lR18uDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628847154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vym3QX3qGOX0DYb4CLu+fvsfBUH5ZnbBYaiIHhsMm/o=;
 b=j3bNAIfeMlnDKEZCdEw7qUtJ8h3D4lvZVISGm4cdZcwES/968+p7MRLDagmktMT3z1psKL
 m/udnGIwQBVBPHCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 283C4136A6;
 Fri, 13 Aug 2021 09:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id bPPCCTI8FmHZSgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Fri, 13 Aug 2021 09:32:34 +0000
Date: Fri, 13 Aug 2021 11:32:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Mark Ruijter <mruijter@primelogic.nl>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvmet-tcp kernel crashes consistently when doing 64k rw with fio.
Message-ID: <20210813093233.7sz7w7dq3wtgoijd@carbon.lan>
References: <B1598542-53C3-4887-919C-79D60A90181A@primelogic.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B1598542-53C3-4887-919C-79D60A90181A@primelogic.nl>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210813_023239_505305_89BD9FE2 
X-CRM114-Status: UNSURE (   9.74  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Mark

On Wed, Aug 11, 2021 at 07:58:28AM +0000, Mark Ruijter wrote:
> messages-20210720:2021-07-19T16:06:40.084138-06:00 gold kernel: [ 3402.950671] nvmet_tcp: failed cmd 00000000dcb0e105 id 10 opcode 2, data_len: 65536

I've tried to reproduce this with the current nvme/nvme-5.15 branch
(this was the kernel I got running) and was not able to trigger it. So
not sure if it is fixed or my setup is not able to reproduce it. Anyway,
I'll try to the 5.10 stable tree.

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
