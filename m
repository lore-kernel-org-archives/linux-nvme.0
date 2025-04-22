Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E9FC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGzF1BfsJBbf/8QVFHMdGiOuMyzcPji1pxZT5HE/7G0=; b=UkikPyVONIYmQeCrnM3TOFJLFe
	9j5sXQ7IMPt6H7YMU/9Nx+a9HcqxalqtkAnqKwaDBCNBxR+XQo0BttbQkNAcc82i1HL19ps4cfXKR
	SGSy880XzfzPT3RWbRCZflE8bTmsmxy5UkTYbRYxyHF+z6Fp9gB+GtKm10ZrXR8zYUGjP6HMqze4p
	EfJbd2sq6MzqvdBqHI53vveF4Dqav5HpubaMYDv+CcMLIBQN5EtxXwZCELUhCB0vYG5SySDu1mOUP
	P8o8hcEoiqpLXyyinPeWIXSS6tnQk0eXar6+Hih1AQ++75jwXr+lSAlI4N8PrrJV5zfTqErui92tv
	fNkJs2Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7B6z-00000006okY-3FeJ;
	Tue, 22 Apr 2025 10:44:21 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7AZ9-00000006h15-1MA1
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 10:09:24 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F3241F38D;
	Tue, 22 Apr 2025 10:09:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508BC139D5;
	Tue, 22 Apr 2025 10:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BKKzENBqB2i0cQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 22 Apr 2025 10:09:20 +0000
Date: Tue, 22 Apr 2025 12:09:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
Subject: Re: [PATCHv2 4/4] test: extend sysfs tree dump test
Message-ID: <e0ede3ff-d9f7-42a8-8179-ecba47b756c5@flourine.local>
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-5-nilay@linux.ibm.com>
 <949760d8-c279-4899-bf4f-62290d78fee6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <949760d8-c279-4899-bf4f-62290d78fee6@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6F3241F38D
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_030923_505488_01F5A32C 
X-CRM114-Status: GOOD (  10.32  )
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

On Tue, Apr 22, 2025 at 08:28:48AM +0200, Hannes Reinecke wrote:
> Not a big fan of having tar.gz files in git. Can't we create it on the
> fly and only store text files?

Creating is not really an option, we could just store test data in the
tree directly. I don't expect that the size of the repo is increasing a
lot as the objects in git are also compressed. My main concern is that
we have a lot of new files:

$ tar tf config-pcie.tar.xz
sys/class/nvme/
sys/class/nvme/nvme1
sys/class/nvme/nvme0
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/uevent
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/cntlid
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/address
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/uevent
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/ext_range
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/metadata_bytes
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/range
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/alignment_offset
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/diskseq
sys/devices/pci0000:00/0000:00:06.0/0000:0f:00.0/nvme/nvme0/nvme0c0n1/power/
[...]

Currently there are three tar.xz files. If the general mood is that
there shouldn't be any tar.xz files around, I am fine to get rid of them.

