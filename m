Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCB5C761A6
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfECXt8bNaVYM4tKyF9mO8CdmCA7wkkWZHbs0YjE3zg=; b=Ab872EvqQ0eSEq1RvDlx9skCVC
	2WVquLUvnb61B7mtK7uH/UCvFvpKL0uwRpXPfNV5RPOqsO/6zdzSB+q8DdY8ENPogX90DYLXMjeyt
	0iygQxhXzU1liMFN3TWHFybovlOMsFlZxUIfyUfEL7u2i36BcnKQHmG/jE5M/m14PhO+zqohLvue4
	SmlYhi7BFx3ZU9A1Cd8qL2sSoQanVmjvmXcN1nTJA0vjIyxjNsW9PWXzC0OlnVSq9cl6jcpfmLvtO
	QQSSI0JNR8a5ZdCBTM4SX09gxYUEah/g4/rr8FogXcCkEpSWmDNwqVwyrw6RJcFGgfaduPK7m6aFK
	22u8oafQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXgN-00Blxv-2F;
	Tue, 21 Mar 2023 08:49:27 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXgK-00BlrX-2j
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 08:49:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F04301FD6C;
	Tue, 21 Mar 2023 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679388557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfECXt8bNaVYM4tKyF9mO8CdmCA7wkkWZHbs0YjE3zg=;
	b=eTkJxFVoJZEcByTaO1WsSuEwIHnuz3rbhiTZaEHgS1GpubAONnSbfe/nJRJg1LyEqA8W3D
	xQlnZwWnYhpsaThGGV7+bB3OrqcNDDPwycMnzyY/qJqMfKCF5H2+lFhoA4ebtmK8i8OCwv
	QXvYSEXXraI3CEaHQCXdfemKQDfKTJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679388557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qfECXt8bNaVYM4tKyF9mO8CdmCA7wkkWZHbs0YjE3zg=;
	b=IZVYFNxekbTxtS9UPJUmpQrBAF8cgVeIer8OdpBAIjnFKhhqsLEumSFjmU95GQ2RYvWLMx
	Lh4ET0o//dPiCQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E158E13451;
	Tue, 21 Mar 2023 08:49:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id g6v4No1vGWQ/VAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 08:49:17 +0000
Date: Tue, 21 Mar 2023 09:49:17 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321084917.s5xqklrttauxilnx@carbon>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321082308.n6ed7ieu5jdb2gj4@carbon>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_014925_035596_84254DA8 
X-CRM114-Status: GOOD (  10.96  )
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

On Tue, Mar 21, 2023 at 09:23:08AM +0100, Daniel Wagner wrote:
> On Sun, Mar 19, 2023 at 03:10:40PM +0200, Sagi Grimberg wrote:
> > Thoughts?
> 
> It still crashes in the same way with both patches from this
> disucssion applied.

annoted the __nvme_submit_sync_cmd:


[  210.019050] nvme nvme0: rq ffff8881122a0000 bio ffff88810d8cdd00
[  210.022653] nvme nvme0: rq ffff8881122a0200 bio 0000000000000000
[  210.023571] CPU: 4 PID: 15752 Comm: nvme Tainted: G        W          6.3.0-rc1+ #9 d97c09c311a99b3c39b25760658850e8f66ae67b
[  210.025120] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[  210.026224] Call Trace:
[  210.026679]  <TASK>
[  210.027069]  dump_stack_lvl+0x5a/0x80
[  210.027695]  __nvme_submit_sync_cmd+0x518/0x750 [nvme_core f2d2b58d969ec189999606e54c8a53895e280d91]
[  210.029076]  nvmf_reg_read64+0x14f/0x2a0 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[  210.030331]  ? nvmf_reg_read32+0x290/0x290 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[  210.031669]  ? nvmf_connect_admin_queue+0x381/0x5d0 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[  210.033031]  ? nvmf_reg_write32+0x260/0x260 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[  210.034329]  nvme_enable_ctrl+0xcb/0x580 [nvme_core f2d2b58d969ec189999606e54c8a53895e280d91]
[  210.035589]  ? nvme_wait_ready+0x2f0/0x2f0 [nvme_core f2d2b58d969ec189999606e54c8a53895e280d91]
[  210.036882]  ? nvme_tcp_start_queue+0x87/0x360 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
[  210.038156]  nvme_tcp_setup_ctrl+0x210/0x1690 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
[  210.039439]  ? nvme_reset_ctrl_work+0xf0/0xf0 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
[  210.040692]  ? _raw_spin_unlock_irqrestore+0x32/0x50
[  210.041452]  ? nvme_change_ctrl_state+0xec/0x2d0 [nvme_core f2d2b58d969ec189999606e54c8a53895e280d91]
[  210.042805]  nvme_tcp_create_ctrl+0x71e/0xa80 [nvme_tcp 8413e4e242b091568613e66c1cbb42a8845a3aa7]
[  210.044080]  nvmf_dev_write+0x498/0x790 [nvme_fabrics a56b21f9a9f011a785bd0916f38d0deca6de166d]
[  210.045325]  vfs_write+0x1fc/0xaa0
[  210.045895]  ? n_tty_read+0x1250/0x1250
[  210.046530]  ? file_end_write+0x1a0/0x1a0
[  210.047164]  ? vfs_write+0x57f/0xaa0
[  210.047758]  ? file_end_write+0x1a0/0x1a0
[  210.048406]  ? do_user_addr_fault+0x747/0x8e0
[  210.049096]  ? __fdget_pos+0x51/0x250
[  210.049703]  ksys_write+0x128/0x210
[  210.050285]  ? __ia32_sys_read+0x80/0x80
[  210.050929]  ? syscall_enter_from_user_mode+0x2e/0x1c0
[  210.051714]  do_syscall_64+0x60/0x90
[  210.052302]  ? do_syscall_64+0x6e/0x90
[  210.052929]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  210.053693] RIP: 0033:0x7f7ef9f06af3


It looks like the register read/writes are the ones without a bio.

