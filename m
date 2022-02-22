Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C22C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Phktt8hpDzwiUsJkcwvdwgg+cbsDZPaFDkJkP/tSDsI=; b=ARv9KgSDr2uFgAbmo0/skVOSz3
	tCHg+m2kwyZv8Up9hsxV4+IawDTNT8RmjRfQ4bPaxYWx9MSyuzgQIRDMwXZIylgN7agSb/BZ+jBt5
	+I8qCtPtNAqWudjxwXbpHzEu1iyG2yuEO8a/vw6IrYv5iupq2Rz1+b47ziWBU0R+BpTvWjgQ6AXmp
	DOFgKZuq9sBymyscSgouTMW9mNMeUL0Fsfux4weWfmRmpB/GQMnAAgS6Ssp5e+GZuImqMQ95thXNM
	xXlZ4oGZIdcmveEYn17EyFE0P1fQfIIGEzKze+g8lVuVUM9gQ8EdbFIKw6mCc5DX/JdIHgs134AS2
	BG3+eFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMSV9-0095aH-7P; Tue, 22 Feb 2022 10:34:35 +0000
Received: from forward501j.mail.yandex.net ([2a02:6b8:0:801:2::111])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMSMl-0091LX-3H
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 10:25:59 +0000
Received: from sas1-6b94a3a85f37.qloud-c.yandex.net
 (sas1-6b94a3a85f37.qloud-c.yandex.net
 [IPv6:2a02:6b8:c14:3924:0:640:6b94:a3a8])
 by forward501j.mail.yandex.net (Yandex) with ESMTP id 70F40623A0F;
 Tue, 22 Feb 2022 13:25:48 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net
 (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
 by sas1-6b94a3a85f37.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 TFFzIUMULr-PlcCk0ja; Tue, 22 Feb 2022 13:25:48 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1645525548; bh=Phktt8hpDzwiUsJkcwvdwgg+cbsDZPaFDkJkP/tSDsI=;
 h=In-Reply-To:From:Subject:Cc:References:Date:Message-ID:To;
 b=Lb6Mw125y67hPgpYLXdhYKxHhVP52vkV9cE+ArmItEJyNVLcq90K7LHLXDDPKQhJH
 Zz44NJUVi4kcCD8mdhT8CvGk/iJClWQpGzNBWdPIqX+p1QWqtrxTJ6WkH2nXkdKX7S
 61ue8eDyyjewNoS+w0KiObJnmVafIO99c+4+TJIw=
Authentication-Results: sas1-6b94a3a85f37.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id 5tEQ5a3Qvu-PkHKXV75; Tue, 22 Feb 2022 13:25:46 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Message-ID: <7db5c527-3448-90f5-96e0-6849c00ac461@yandex.ru>
Date: Tue, 22 Feb 2022 13:25:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: parametrize maximum number of namespaces
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220222085415.292729-1-alextalker@ya.ru>
 <c400d418-8fb2-a603-d669-077b2d09f789@suse.de>
 <2c0cae51-44a5-e156-cfb4-6e00c9d0c7b1@nvidia.com>
From: Alex Talker <alextalker@yandex.ru>
In-Reply-To: <2c0cae51-44a5-e156-cfb4-6e00c9d0c7b1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_022555_545013_9C66281E 
X-CRM114-Status: UNSURE (   9.33  )
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

 > Please no module param for this, right place is configfs subsys
 > attr.

That makes sense, I agree but I mainly aimed to start off with a simple 
change(replacing macro with load-time value, unchangeable at runtime).

So if I'd add this to /sys/kernel/configfs/nvmet/subsystems/<NQN> folder 
as, say attr_max_namespaces,
what would you propose on:
1. Storing the value? Would it make sense to specify it directly as NN 
or MNAN value or the like?
2. What to do if set value is lower than the current value? Abort if 
there's greater number of enabled namespaces than the specified value?

Best regards,
Alex


