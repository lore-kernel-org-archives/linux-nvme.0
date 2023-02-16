Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39267C636CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cIuZZv8iM/NkFizmH1+gWXDdUrKjD8edb98BH6cUsto=; b=42K97a2LfjXfLFPUVO59nOkl1d
	C+qUQV02xCyqN45BcyhtYfqQs7XApGtq94Wnl6TbgLad+pRWHhPQ6W4gy/Pm7z3KoMw8Pe6n+BlDn
	nGNVqDLaFEnJFg8r5xtNPsiWJiCgc+9h+GDH4GryE8fpdxV48aIHIt1r/BEKJX9fvT0xTBngDA6io
	7Y249MPNfC6VR5QZn+8tqtM4RYuSRuhMXAgQd+iEeiGr6IgwdC5Vte6rGQ8LKvk+QInc0SHT69QGg
	JjngV6EFRMS/AQCenOaXcd5JxyF0jTMPVBM2hFe2q0yaEElgvoXM6bLST+0qJqr67n1i0+smAkK1F
	3uZ7fA+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pScmH-00A1iJ-NM; Thu, 16 Feb 2023 11:50:17 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pScmB-00A1eK-3F
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 11:50:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E40661FDBA;
	Thu, 16 Feb 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676548203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cIuZZv8iM/NkFizmH1+gWXDdUrKjD8edb98BH6cUsto=;
	b=woNFO/+rcBvTR11vdvqG449Px0/xWkE5PDY58oLgVf6jeB0wZFBGnLmKCZd+fH4FVZnAGM
	0yx7TzuzAVc5gbdVBI8Z0o/RDlgCsRdYNPvz6PPwTRyjKNEbjZHym5y3bZKbIm/33HLBkb
	AF74NYIIp5htv12etzk35UWNc6sZbm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676548203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cIuZZv8iM/NkFizmH1+gWXDdUrKjD8edb98BH6cUsto=;
	b=tvPBo68FsV0hAnte+WNjluTNImszSxAwHBq74Ai8MQ4UdtJXKjov8PbfxB6T0zzNJVQ0Kf
	CN6QijNdMEw2F6CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7586131FD;
	Thu, 16 Feb 2023 11:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lVNUNGsY7mPhLwAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 16 Feb 2023 11:50:03 +0000
Message-ID: <3d3369f1-7ebe-b3b8-804c-ff2b97ec679d@suse.de>
Date: Thu, 16 Feb 2023 12:50:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 lsf-pc@lists.linuxfoundation.org
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF BOF] Userspace command abouts
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_035011_319502_35FEF47E 
X-CRM114-Status: GOOD (  12.00  )
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

Hi all,

it has come up in other threads, so it might be worthwhile to have its 
own topic:

Userspace command aborts

As it stands we cannot abort I/O commands from userspace.
This is hitting us when running in a virtual machine:
The VM sets a timeout when submitting a command, but that
information can't be transmitted to the VM host. The VM host
then issues a different command (with another timeout), and
again that timeout can't be transmitted to the attached devices.
So when the VM detects a timeout, it will try to issue an abort,
but that goes nowhere as the VM host has no way to abort commands
from userspace.
So in the end the VM has to wait for the command to complete, causing
stalls in the VM if the host had to undergo error recovery or something.

With io_uring or CDL we now have some mechanism which look as if they
would allow us to implement command aborts.
So this BoF will be around discussions on how aborts from userspace 
could be implemented, whether any of the above methods are suitable, or 
whether there are other ideas on how that could be done.

Cheers,

Hannes
-- 
Still without a .sig on this computer

