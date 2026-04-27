Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E3DFF8861
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gNryX4fS9Nb22S2hkLEfhkpWNwntegLckN4oiq+ykw=; b=bc2OCclHV3z/4L1pf3VKeQj63T
	u3Bk9XqqjHhOm7SRC7ottBIJGOa3NZxNwEI9YEMooHlq/IspH3med9mVrA7q7OIHUGdjklsljBFVb
	9H7vp3Uoi2lnKM0PmAVFgcXWpnsPCPwYPUXXy3WMgoUotvmCPNTTQp1+3F9/9S3Zuv399+nb65nHr
	+QFgyo9YJYXGh1xidfZUPeTamiknZgplllSYqLLKWHewLxhQYyVNCYuLeDw1fqeEoCcX7ceMjm6QM
	BrDavOCT7IqMqg8215v46bz7nmfkDf1yVYvKYXAHIsGKfm6IlRafY7A/lfhqxcqW5FVxyPAI7XFv9
	wPJR1O2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI2K-0000000GY2K-2SsP;
	Mon, 27 Apr 2026 09:13:52 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHI2H-0000000GY1f-2RwC
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 09:13:51 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id d1800f8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Apr 2026 11:13:44 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Apr 2026 11:13:43 +0200
Message-Id: <DI3TM2S46GYN.38E7GIF26O7GD@arkamax.eu>
Cc: <kbusch@kernel.org>, <mheyne@amazon.de>, <emilne@redhat.com>,
 <jmeneghi@redhat.com>, <linux-nvme@lists.infradead.org>,
 <mlombard@arkamax.eu>, <mkhalfella@purestorage.com>,
 <chaitanyak@nvidia.com>, <hare@kernel.org>, <hch@lst.de>
Subject: Re: [PATCH V3 4/8] nvme: add sysfs attribute to change IO timeout
 per nvme controller
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-5-mlombard@redhat.com>
 <d776e448-461d-4888-a685-a9af79c61d9c@flourine.local>
In-Reply-To: <d776e448-461d-4888-a685-a9af79c61d9c@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_021349_959904_9E87A29A 
X-CRM114-Status: GOOD (  11.32  )
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

On Mon Apr 27, 2026 at 11:11 AM CEST, Daniel Wagner wrote:
> On Fri, Apr 10, 2026 at 09:39:20AM +0200, Maurizio Lombardi wrote:
>> Currently, there is no method to adjust the timeout values on a
>> per controller basis with nvme I/O queues.
>> Add an io_timeout attribute to nvme so that different nvme controllers
>> which may have different timeout requirements can have custom
>> I/O timeouts set.
>>=20
>> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
>> ---
>>  drivers/nvme/host/core.c  |  2 ++
>>  drivers/nvme/host/nvme.h  |  1 +
>>  drivers/nvme/host/sysfs.c | 47 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 50 insertions(+)
>>=20
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 6dc3d273623c..1b676fd4d454 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4197,6 +4197,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, =
struct nvme_ns_info *info)
>>  		mutex_unlock(&ctrl->namespaces_lock);
>>  		goto out_unlink_ns;
>>  	}
>> +	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
>>  	nvme_ns_add_to_ctrl_list(ns);
>>  	mutex_unlock(&ctrl->namespaces_lock);
>>  	synchronize_srcu(&ctrl->srcu);
>> @@ -5136,6 +5137,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct =
device *dev,
>>  	ctrl->ka_cmd.common.opcode =3D nvme_admin_keep_alive;
>>  	ctrl->ka_last_check_time =3D jiffies;
>>  	ctrl->admin_timeout =3D NVME_ADMIN_TIMEOUT;
>> +	ctrl->io_timeout =3D NVME_IO_TIMEOUT;
>
> Should this be initialized with the defaults from the module load time?


Yes, note that NVME_IO_TIMEOUT is a macro that depends on the
"nvme_io_timeout" module parameter set at load time.

Maurizio


