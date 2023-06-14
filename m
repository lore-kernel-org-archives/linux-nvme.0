Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A44EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jun 2023 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zCkFcuH5V3+ixyNrEx+x4s202aKT5K0biw4wgrkN7c=; b=kUDHtzEPuiQ6kFp4wQSkLVdbJA
	q5j8gScESSs7l4yjQrPQJr2m2KHkiE2gEHPGEof7aeGNMpu2D7WJQ3od3WyxtEMH/UccFtSRnS3oF
	8B7wxkUE05eelDNMQAGZpailbhbRNIzFZRDBhOkplurmUOV4zb/k/x9248y1hBz9ybQIBw3QI3Zey
	oSN/qXpzuixomZsC8ih5LbD74i3pCtW6tduv97jEne1FivJ2K9+LG3s292yi6urUvHsVjozL+llqq
	5xfTz0bGa3quOjDaGt7Am1iT9JxsmMTplwDobJj56SQNn8JkIjmMQYteqK5h84PyUki6MYWfG/GRk
	aYRj5ELQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Oel-00BTgz-25;
	Wed, 14 Jun 2023 11:27:19 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Oeh-00BTfi-36
	for linux-nvme@lists.infradead.org;
	Wed, 14 Jun 2023 11:27:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 560E11FDE8;
	Wed, 14 Jun 2023 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686742029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zCkFcuH5V3+ixyNrEx+x4s202aKT5K0biw4wgrkN7c=;
	b=A1MGXFq6nMXpnW2Nosaw5wN6bmzdHfG2kqIoTnAL9ONeTvIMtfvmM90TI+ZW+POI86mRTr
	8ZzPhbfVueeIfKb096QSKytI+sTW4nL9EUJRrwdtWCCNA/pFma4OwcXJdF6CEjSytCXzvS
	P+uGCD2i9KXeLDJ5MG2N9n8OA4jlhTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686742029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zCkFcuH5V3+ixyNrEx+x4s202aKT5K0biw4wgrkN7c=;
	b=KO36a14+CsniCI/P9YQL2GDK52el3+x98Bduq6FFp8m9GYeBrNHYZ7r26C7zjYF58Zgdaw
	zvRsgyYDu2UVptBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47CEF1357F;
	Wed, 14 Jun 2023 11:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RJbOEA2kiWRXGgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 14 Jun 2023 11:27:09 +0000
Date: Wed, 14 Jun 2023 13:27:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1] nvme/040: Free loop back resources
Message-ID: <pzgf2abc2piophrwt3m3elaeb3vrrgrvxyq437ytpmah6rnxf5@m4gfyw4bcmxo>
References: <20230612142945.10969-1-dwagner@suse.de>
 <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bsbx3i3ut32zbatwrpn3t2vjbjdmttqul2jt7opd3s4mipo6pj@5ojtsv7aunbn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_042716_170895_F4A7C463 
X-CRM114-Status: GOOD (  17.35  )
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

On Wed, Jun 14, 2023 at 11:13:18AM +0000, Shinichiro Kawasaki wrote:
> On Jun 12, 2023 / 16:29, Daniel Wagner wrote:
> > The tests does not cleanup all resources after it has finished. This
> > leads to rm not being able to remove the TMPDIR cleanly:
> > 
> >   + rm -rf blktests/results/tmpdir.nvme.040.m2J
> >   rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory not empty
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Hi Daniel, thanks for the patch. It looks good to me. Now the test case leaves a
> loop device. This patch avoids it. Good.
> 
> Question, I do not observe the rm command failure in my test environments. Do
> you have insight why you were able to find the failure?

I am running the tests inside a VM and I am sharing a part of my host filesystem
via NFS which contain the blktests. If I understood it correctly, the NFS server
is behaving slightly differently here. I can't observe it either with xfs or
btrfs.

