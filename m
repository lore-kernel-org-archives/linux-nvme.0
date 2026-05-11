Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F85CD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 10:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=alCMJ7EaYclPVyNDkvysU7rOSL2BzlPE/Wbsw0FYgm0=; b=pyDTEUWCmwLtKyR5LTIHi94fCY
	jldJUGIwiRwqjD7DphK0nNHzN4qDkHAs+pLd72NAecNTUXRp1gU/3pgX9JX7vt+KVdXarsAK8m8Zb
	78ja3+6JsbLRkWCvMDh122sQyUS/luPiA7+hssvrzfbI4To7dK1OCjsfBNVkUyng39y2MCEKU/WGr
	VToHgxdao4oBGIBU6J1P3yX/rT+fbbhbEMGTBY7B5cJL6fWchQDkntKnt2jnrkbUdcKaVx/fPLY6v
	cPDjeWDKs3o8tOJ5+RzMq/UlRP4MjlM5RXYx4aATPtHrpELnhVL46lxyPqpAl7XUTlRigxS7cR9Hs
	vqt4xw9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNWW-0000000D3BG-2nkB;
	Mon, 11 May 2026 10:06:04 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMNWT-0000000D3AC-3bVp
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 10:06:03 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id a6d445df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 12:05:59 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 12:05:59 +0200
Message-Id: <DIFRHPU9XMH1.8GO0LCSJ6XDT@arkamax.eu>
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <mheyne@amazon.de>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
 <linux-nvme@lists.infradead.org>, <dwagner@suse.de>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <chaitanyak@nvidia.com>, <hare@kernel.org>,
 <hch@lst.de>
Subject: Re: [PATCH V4 2/9] nvme: add sysfs attribute to change admin
 timeout per nvme controller
X-Mailer: aerc 0.21.0
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-3-mlombard@redhat.com>
 <81e347ac-20f6-4b51-b6b3-dc25d0b11285@suse.de>
In-Reply-To: <81e347ac-20f6-4b51-b6b3-dc25d0b11285@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_030602_232479_9CA3301E 
X-CRM114-Status: UNSURE (   9.54  )
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

On Mon May 11, 2026 at 11:46 AM CEST, Hannes Reinecke wrote:
> On 5/8/26 15:33, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values
>> on a per controller basis with nvme admin queues.
>> Add an admin_timeout attribute to nvme so that different
>> nvme controllers which may have different timeout
>> requirements can have custom admin timeouts set.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>   drivers/nvme/host/core.c  |  1 +
>>   drivers/nvme/host/nvme.h  |  1 +
>>   drivers/nvme/host/sysfs.c | 42 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 44 insertions(+)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 89948d0acf18..b1bfcd0a0e5b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -5140,6 +5140,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct =
device *dev,
>>   	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
>>   	ctrl->ka_cmd.common.opcode =3D nvme_admin_keep_alive;
>>   	ctrl->ka_last_check_time =3D jiffies;
>> +	ctrl->admin_timeout =3D NVME_ADMIN_TIMEOUT;
>
> Why do you remove the default timeout?

nvme_init_ctrl() initializes a new controller, so it must inherit the
default global NVME_ADMIN_TIMEOUT settings

> Shouldn't admin requests run with the admin timeout per default?

They do, the default admin timeout for new controllers remains
NVME_ADMIN_TIMEOUT and it's applied to both admin_q and fabrics_q queues
when they are initialized.

Maurizio



