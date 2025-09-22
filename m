Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA4FCAC5A7
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXMvpMq58nS03DvE2S3/m0yXAtWD8SrbI9ESKcoR+jE=; b=pIV2W1j52MAecJqEOFPdT4N8c1
	WQMJkmkteMwMj0VjGi4sygEAbmxUvpHlNk/EZZSB5nqPQfBiQXgMhF+izCRmGvpe6tES9OfpSb5MZ
	R2N4e7I4xzExVhz3+5GpA3roPSsJAby0u+RauX1IIWAG4kVrqGM5Go7pVMyygsgbKYjcTyPlGHlvT
	doc9sah0DkOW+I7QlFi2kBBfsDH6/SxXErAIuT47hIxvrdjtXbnx6rGcTHvVQpvGLT/lg/36lRBaq
	WIaPktsD+W1RReGO00H9x8rFaGWa2Jy0XXKrJFqRIgQAz93NljH4nRJ0WrwyUlz8zrMmvrBWMbI0o
	F/21e0Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0d3L-00000009uwP-0lMP;
	Mon, 22 Sep 2025 09:41:47 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0d3I-00000009uve-0UdV
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 09:41:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EF08D1F79D;
	Mon, 22 Sep 2025 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758534100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMvpMq58nS03DvE2S3/m0yXAtWD8SrbI9ESKcoR+jE=;
	b=b+0KaA/3dadrDVkAiZu6hHaK/GPrp96jda1zT7lK3uuJO9LvadLC8zZwiXilLKNMIwbbgX
	GeihpoRPlvjFY0CQL6sH6iKqv+ULSWejvYulV28sVipVxSo5FsFCy7N8nCXUixmThGGSGZ
	3OBt95Squy75G2Ixs8LwvS8YKVgpTWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758534100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMvpMq58nS03DvE2S3/m0yXAtWD8SrbI9ESKcoR+jE=;
	b=6xiX9mqi+vq/RAbnqWbWnCjSEF/PVE23Q/qAcemcLjz+iYrBsR37Vtc7NdjXlHsOVZ/O3G
	ngdkjhzh/OKMWVAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758534099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMvpMq58nS03DvE2S3/m0yXAtWD8SrbI9ESKcoR+jE=;
	b=IvISOTyrq8k9xtshe752kfNWMgBK4DVAhEewcDp2jG1pCKMTBHRdXQdxc4AVc82AfJLqrx
	26QHnoDwBvsrHhvpKTiDyTbXSNfHDlhgThWxnjy+fyPloWDr7oW+a9A+kgLjvY+0IJYUQ+
	QFQHXNIaNTWmmTxZ2/swY/a81NxgEpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758534099;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXMvpMq58nS03DvE2S3/m0yXAtWD8SrbI9ESKcoR+jE=;
	b=p7wOyiyfeGfYAN5LGj1pO9keswt6IdwOgUZMxEVMZ/QV9EuDqYa8stAkKKUIBE8aFtsrB+
	eyEMJ4EtfncJ39Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08D713A63;
	Mon, 22 Sep 2025 09:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AOHRNdMZ0WgrLQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Sep 2025 09:41:39 +0000
Date: Mon, 22 Sep 2025 11:41:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hare@suse.de, kbusch@kernel.org, gjoyce@ibm.com, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv3 0/4] nvme-cli: enhance the visibility of multipath
 using show-topology command
Message-ID: <4c705f5f-84d0-4070-88af-0e4033f77f17@flourine.local>
References: <20250904175654.1183750-1-nilay@linux.ibm.com>
 <8ade15d7-9e73-4f29-a482-283991667499@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ade15d7-9e73-4f29-a482-283991667499@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_024144_306686_A762EC3D 
X-CRM114-Status: UNSURE (   8.79  )
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

Hi Nilay,

On Sun, Sep 21, 2025 at 05:41:59PM +0530, Nilay Shroff wrote:
> A gentle ping on this patchset. Please let me know, in case, if you've
> any further query/comment/suggestion for this patchset.

All good, I've applied the series. FTR, the tabular output looks nice:

nvme-subsys29 - NQN=nqn.1992-08.com.netapp:sn.44ede5aaa52511e8abb200a09890f5bf:subsystem.nvme-svm-dolin-qla-subsystem
                hostnqn=nqn.2014-08.org.nvmexpress:uuid:31333937-3136-584d-5135-323430365637
                iopolicy=queue-depth

NSHead   NSID NSPath      ANAState      Qdepth Controller TrType Address                                                                                                    State
-------- ---- ----------- ------------- ------ ---------- ------ ---------------------------------------------------------------------------------------------------------- -----
nvme29n1  2   nvme29c11n1 optimized       0    nvme11     fc     traddr=nn-0x200200a09890f5bf:pn-0x203600a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     2   nvme29c29n1 optimized       0    nvme29     fc     traddr=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     2   nvme29c30n1 non-optimized   0    nvme30     fc     traddr=nn-0x200200a09890f5bf:pn-0x203700a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     2   nvme29c31n1 non-optimized   0    nvme31     fc     traddr=nn-0x200200a09890f5bf:pn-0x203900a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     2   nvme29c32n1 non-optimized   0    nvme32     fc     traddr=nn-0x200200a09890f5bf:pn-0x203700a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     2   nvme29c33n1 optimized       0    nvme33     fc     traddr=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     2   nvme29c34n1 non-optimized   0    nvme34     fc     traddr=nn-0x200200a09890f5bf:pn-0x203900a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     2   nvme29c35n1 optimized       0    nvme35     fc     traddr=nn-0x200200a09890f5bf:pn-0x203600a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
nvme29n2  1   nvme29c11n2 optimized       0    nvme11     fc     traddr=nn-0x200200a09890f5bf:pn-0x203600a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     1   nvme29c29n2 optimized       0    nvme29     fc     traddr=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     1   nvme29c30n2 non-optimized   0    nvme30     fc     traddr=nn-0x200200a09890f5bf:pn-0x203700a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     1   nvme29c31n2 non-optimized   0    nvme31     fc     traddr=nn-0x200200a09890f5bf:pn-0x203900a09890f5bf,host_traddr=nn-0x20000024ff7fa448:pn-0x21000024ff7fa448 live
  -->     1   nvme29c32n2 non-optimized   0    nvme32     fc     traddr=nn-0x200200a09890f5bf:pn-0x203700a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     1   nvme29c33n2 optimized       0    nvme33     fc     traddr=nn-0x200200a09890f5bf:pn-0x203800a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     1   nvme29c34n2 non-optimized   0    nvme34     fc     traddr=nn-0x200200a09890f5bf:pn-0x203900a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live
  -->     1   nvme29c35n2 optimized       0    nvme35     fc     traddr=nn-0x200200a09890f5bf:pn-0x203600a09890f5bf,host_traddr=nn-0x20000024ff7fa449:pn-0x21000024ff7fa449 live

