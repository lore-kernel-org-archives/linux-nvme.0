Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B38EC5AE49
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=scjAjNYJHmMqtXhSI92HHNhA5a6GQ753vBZ+DR3SYHA=; b=RQjJk7f2ZXUT/mpoqfMnM+or+5
	6oenNUsczgfC3FXcgymTRK7S/SScVYYAwDjcAGqF+Da6CtqMKGlmdYM1oOAo/U6j57mxEJY+29a85
	d18hH3DnctdkJfgpy7OOaLD0pm7EziwCNqXezOefl4LHOBHhjWk8ARMuzwwF7lBbqrmh09wz0E9et
	wWhIrXj+pkbGtCo2WUEtpmH7c3WYGHUZjGteOW8GqF/JNUAztbudO1KthVkcULE6N+V//WxQpOO+1
	3R4uTxxZkB+lbw4dvLabCiTStWm/bIP5PxvuwwPtr7JgBYb07p7W7Rulb5WLG1mkGc2lFtI/MjVCr
	+zBb1eQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRMG-0000000C6R1-1ZQj;
	Mon, 10 Aug 2026 14:52:08 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRMC-0000000C6Kp-1erZ
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 14:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=scjAjNYJHmMqtX
	hSI92HHNhA5a6GQ753vBZ+DR3SYHA=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=TQQLJMIkUbiCKCVndPiysf7+0H7Z1LApLHdGH
	VrRw25N+sS4aYwAkpDmuwo96MS2sFlVL9Cx5CmOY0wL2FCMwxcrAlDSvd/tnwfBkqciX22
	ypuVhEf4qF3D0O/atZA16219NN1LIGk7D6xHHLu7UgKqsVqK/vbNpnqdZWNXHs503VBLFU
	pz4VHWA9UygnLiKtEyCb2cdXdW+gLtPzFOOoJOgC+34ITFkSuOBfx38r+wXvC+41pvYuDp
	4BSl6mbonHOJruoVkjTfNglmiiSa1bPZivnPEghSc25IU99UJ5xFpLMibZK1WXpklbJeqV
	WJ3K3XaZEnhYbF/2l5r3ZdYpg==
Received: from localhost (<unknown> [193.207.122.165])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id b34ec963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 16:51:57 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 16:51:56 +0200
Message-Id: <DKLCK85AD8M0.FBLMPSDT21Z0@arkamax.eu>
Cc: <hare@suse.de>, <hch@lst.de>, <dwagner@suse.de>,
 <linux-nvme@lists.infradead.org>, <mlombard@arkamax.eu>
Subject: Re: [PATCH] nvmet: fix max_qid race between configfs and controller
 allocation
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Keith Busch" <kbusch@kernel.org>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260810133301.52537-1-mlombard@redhat.com>
 <annggXmP2yS47QN4@kbusch-mbp>
In-Reply-To: <annggXmP2yS47QN4@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_075205_064312_6D980EF5 
X-CRM114-Status: GOOD (  11.50  )
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

On Mon Aug 10, 2026 at 4:30 PM CEST, Keith Busch wrote:
> On Mon, Aug 10, 2026 at 03:33:01PM +0200, Maurizio Lombardi wrote:
>> Fix this by protecting the queue allocations and list insertion in
>> nvmet_alloc_ctrl() with down_read(&nvmet_config_sem). Because
>> nvmet_subsys_attr_qid_max_store() acquires down_write(&nvmet_config_sem)
>> to modify the attribute, this safely prevents the configfs writer from
>> modifying max_qid during controller creation.
>
> I think there's still a race in nvmet_check_cqid() such that a command
> can access an out-of-bounds index if the target side changes
> subsys->max_qid to a larger value and the host sends a command with a
> larger cqid than the array was initially allocated. Should the max_qid
> be copied from the subystem to the controller that allocated the queue
> array?

Hmm I see, considering that changing max_qid triggers resets
to all of the controllers, copying the value to the controllers'
structure should indeed fix all these unsafe accesses.

I will submit a V2.

Maurizio


