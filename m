Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D81DC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/rJC6LmS8URH4O/Q5M4bkGDIZiR2CNvUeIJd694c8s0=; b=oX0hXOyVOmWCA02G73pLp0dqze
	oi4aH7Xd31eXuy88MvImaZy92GuAgILTKGj9LDtfmTlDru0lFmWQTn/Zj++A7/y30mY+MVFjov5yu
	A/kor0J6dqRqda+djidmpX4fXZpc/zDaAPBK1r4mj4k+wQ6Ik52Qyd+Bv93e1+vSvk8nHgdH6NNYV
	YtR6VSRX7Pjd0RjPhtgYjTbf2c5ydLyQ2D63XQPNRZEpSsXnX6flL9r4axU/MR4A98O0LlpHNjFf3
	ZiCC3lmIsU6e/B2qR5YtnqvVwg0Tv3ztSO1/whQMEVH6Ru4E1FNh8sL7y7Fou5DNhA7NEf/krd1rv
	reym9t/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OV4-00000009TO7-3VNb;
	Thu, 03 Apr 2025 17:37:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OTo-00000009T9U-0gwe
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 17:35:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7BB0661132;
	Thu,  3 Apr 2025 17:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB7AC4CEE3;
	Thu,  3 Apr 2025 17:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743701751;
	bh=Z/ZbBQz2vgtvfO1SSLJK6CzJv/x2LNeWF9RJStn63L0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YI6XKvwoROMeAm3LI2ir1C8dOVuLsgQfmPtj64gaOb1YqOu5lJZsmp0oY/zfODTNv
	 YLsB7mhUMVDg8qfmqsOFgBdbsxzP1Vl684EZgtp1PHO/rPHX5LalEUYDKR1RJPDtU9
	 Up9Pd9bAjWYLdx+svJxZ1NtSir2KSgK1VXLzXF51l/micmh7hNDgYpnKon9nQFBcz7
	 +VgEf6oJmFiD9h/tX2aCaznB+NzvmpuwGdI2OcR0LXHbFZeSrasl3vaRgGyi8NXY6/
	 pYsiz75EjP/OTzHfLl+ZFOuZ7pvvYrbrzD8OtHWhKYRtzKNOZkPrLe5WKytIfGMoMJ
	 riel9+Kwj0iXQ==
Date: Thu, 3 Apr 2025 11:35:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	wagi@kernel.org
Subject: Re: [PATCH] libnvme: do not byte swap command dwords
Message-ID: <Z-7G9fQkoNFhaS2q@kbusch-mbp>
References: <20250403144315.2576523-1-kbusch@meta.com>
 <315bb015-66e3-49cd-be3d-a93b97846617@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315bb015-66e3-49cd-be3d-a93b97846617@flourine.local>
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

On Thu, Apr 03, 2025 at 07:25:13PM +0200, Daniel Wagner wrote:
> On Thu, Apr 03, 2025 at 07:43:15AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The dwords always need to be set in the cpu native format. The driver
> > will handle setting up the SQE in the nvme little-endian order, and big
> > endian is never used, so this byte swapping was wrong.
> > 
> > Link: https://github.com/linux-nvme/nvme-cli/issues/2761
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  src/nvme/ioctl.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/nvme/ioctl.c b/src/nvme/ioctl.c
> > index 18b228d9..86c2b702 100644
> > --- a/src/nvme/ioctl.c
> > +++ b/src/nvme/ioctl.c
> > @@ -1920,9 +1920,9 @@ static int nvme_set_var_size_tags(__u32 *cmd_dw2, __u32 *cmd_dw3, __u32 *cmd_dw1
> >  		return -1;
> >  	}
> >  
> > -	*cmd_dw2 = cpu_to_be32(cdw2);
> > -	*cmd_dw3 = cpu_to_be32(cdw3);
> > -	*cmd_dw14 = cpu_to_be32(cdw14);
> > +	*cmd_dw2 = cdw2;
> > +	*cmd_dw3 = cdw3;
> > +	*cmd_dw14 = cdw14;
> 
> in this case shouldn't we use cpu_to_le32?

No, user space was only uses cpu native endian when constructing the
command. The driver handles the endian conversion if necessary.

That conversion is just for the command control side. The driver doesn't
do any such manipulation on the data plane, so endianness in payloads
for commands like "copy", "dsm", or PI meatada need to be handled by the
application.

