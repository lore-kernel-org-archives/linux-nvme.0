Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AECCA0EC1
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W0yEvHJzIIygppAqC/bb9H1APUAWTsQUKKo+j3/mbbo=; b=L7ymhGPde5pd//9OPXftL+WsOf
	IKeGem4zNGTS9PBDyhPBv3W8d+ChVoklcTIhzOsSiBdCZIIUTZu4stEx/593tk/iDfJGs8OpDA2Eu
	DZpKRypKEFvCjKNd96A6CeqjLkR1nzowda3ApmfZWt5jZmseZrpOeaHYuB6IbeqSNIwaKa2oRsW6V
	ssN+CT0lYSnVJ0/y1oKaTMiIieWpvHnEW4k3I4v/MbI6y7HnbfQDv5vegVb5KCvQP5lc3iEnY8aR4
	y2Ibkwk0zsbFcw/qiKoWki87QJW1JLNdPMeOsOcvhKOagibiSrwU7c2CUDuoQQhN6aDdFeZLiZoNw
	GNQpKVxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXY0-0000000EOyq-0iKs;
	Wed, 06 Aug 2025 06:22:48 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujXXx-0000000EOyD-1Q0f
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 06:22:46 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 2eb86fed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Aug 2025 08:22:43 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 08:22:41 +0200
Message-Id: <DBV4NAR2A6N2.1LFJCYHLTHUN2@bsdbackstore.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>
Subject: Re: [bug report] blktests nvme/tcp nvme/060 hang
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>, "Yi Zhang"
 <yi.zhang@redhat.com>, "linux-block" <linux-block@vger.kernel.org>, "open
 list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mailer: aerc
References: <CAHj4cs-zu7eVB78yUpFjVe2UqMWFkLk8p+DaS3qj+uiGCXBAoA@mail.gmail.com> <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
In-Reply-To: <DBV4IHEMUOQ8.28P7LBNP9EHVK@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_232245_713360_2BD2B905 
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

On Wed Aug 6, 2025 at 8:16 AM CEST, Maurizio Lombardi wrote:
> On Wed Aug 6, 2025 at 3:57 AM CEST, Yi Zhang wrote:
>> Hello
>> I hit this issue when I was running blktests nvme/tcp nvme/060 on the
>> latest linux-block/for-next with rt enabled, please help check it and
>> let me know if you need any info/testing for it, thanks.
>>
>> [  390.474378] Call trace:
>> [  390.476813]  __switch_to+0x1d8/0x330 (T)
>> [  390.480731]  __schedule+0x860/0x1c30
>> [  390.484297]  schedule_rtlock+0x30/0x70
>> [  390.488037]  rtlock_slowlock_locked+0x464/0xf60
>> [  390.492559]  rt_read_lock+0x2bc/0x3e0
>> [  390.496211]  nvmet_tcp_listen_data_ready+0x3c/0x118 [nvmet_tcp]
>> [  390.502125]  nvmet_tcp_data_ready+0x88/0x198 [nvmet_tcp]
>
> I think that the problem is due to the fact that nvmet_tcp_data_ready()
> calls the queue->data_ready() callback with the sk_callback_lock
> locked.
> The data_ready callback points to nvmet_tcp_listen_data_ready()
> which tries to lock the same sk_callback_lock, hence the deadlock.
>
> Maybe it can be fixed by deferring the call to queue->data_ready() by
> using a workqueue.
>

Ops sorry they are two read locks, the real problem then is that
something is holding the write lock.

Maurizio

