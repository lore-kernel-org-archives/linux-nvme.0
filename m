Return-Path: <SRS0=ZTQI=NK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C764C4320A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 10:16:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4968660EB5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Aug 2021 10:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4968660EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jJt9znc/b1Vo20D1ty/ximRXwDryCd3zWImUshvo1YM=; b=opZ1DnpOrXPbDn
	2aNutsb1vYORNsKkwT47mw//BQYZjqXhSeaQ4o+PiMQKlKoF4uYkmto4UKFi7XFi04E4t70P1olOk
	d2i7iCMyiLBNvV4cbEQXnEmt1CxKyuN/u7zOXXDOjqv/YZhsGHuV9psSAwJNh4zJTnozmv7RU5Rbd
	sTJisOxic315r+B/I5FLA1/MoSKj/u8ZwpfmV4jwlxd0JosFAOE4WEIyBqyXb+hD/2jb8BJjo3Hhl
	4dfq4NhCdIHnoZTrluT5r4GAKZ8Qyrb1aWrse7SyRGUIeMyYu376m1nPVX0+DyzjDYFvDIdStT2gL
	XB9LOJMbWw4HwCUpzIEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGf5O-007z1i-Hh; Thu, 19 Aug 2021 10:15:46 +0000
Received: from mo-csw1516.securemx.jp ([210.130.202.155]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGf5K-007z0a-NT
 for linux-nvme@lists.infradead.org; Thu, 19 Aug 2021 10:15:44 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17JAFJ7M031214;
 Thu, 19 Aug 2021 19:15:19 +0900
X-Iguazu-Qid: 34trpS1ar6PFTpFjb1
X-Iguazu-QSIG: v=2; s=0; t=1629368119; q=34trpS1ar6PFTpFjb1;
 m=34OHU9vZp4Wklx6tNgmAax1aefZ++4BN/iDhKv0PK88=
Received: from CNN1EMTA02.test.kioxia.com ([202.248.33.144])
 by relay.securemx.jp (mx-mr1510) id 17JAFIHs038850;
 Thu, 19 Aug 2021 19:15:18 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
 by CNN1EMTA02.test.kioxia.com (Postfix) with ESMTP id 23CC12F00E;
 Thu, 19 Aug 2021 19:15:18 +0900 (JST)
Received: from CNN1ESTR03.kioxia.com (localhost [127.0.0.1])
 by Switcher-Post_Send (Postfix) with ESMTP id 763781907AD215;
 Thu, 19 Aug 2021 19:12:55 +0900 (JST)
Received: from localhost [127.0.0.1] 
 by CNN1ESTR03.kioxia.com with ESMTP id 0002VAAAAAA0124J;
 Thu, 19 Aug 2021 19:12:55 +0900
Received: from CNN1EXMB01.r1.kioxia.com (CNN1EXMB01.r1.kioxia.com
 [10.232.20.150])
 by Switcher-Pre_Send (Postfix) with ESMTP id 6B40EA035A340;
 Thu, 19 Aug 2021 19:12:55 +0900 (JST)
Received: from CNN1EXMB02.r1.kioxia.com (10.232.20.151) by
 CNN1EXMB01.r1.kioxia.com (10.232.20.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 19 Aug 2021 19:15:17 +0900
Received: from CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) by
 CNN1EXMB02.r1.kioxia.com ([10.13.100.21]) with mapi id 15.01.2242.010; Thu,
 19 Aug 2021 19:15:17 +0900
From: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>, 
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Topic: [PATCH] nvme: update keep alive interval when kato is modified
Thread-Index: AdeHNEBfLn7U7T5+SsyG/rbRVH2ESP//rzwA//3+YZCACVBBgP/rod7A
Date: Thu, 19 Aug 2021 10:15:17 +0000
Message-ID: <00dc78e1d94d4b1d841214b3f0801603@kioxia.com>
References: <b7cde4c23c44485198f12739bb8fbca0@kioxia.com>
 <202108021253.QwqCWvYe-lkp@intel.com>
 <1f5231f5d0d14829ae72aa97e5f2487a@kioxia.com>
 <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
In-Reply-To: <06929ff1-107f-c00e-7fd9-3c8999e26051@grimberg.me>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.211.40.54]
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB01.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB01.r1.kioxia.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210819_031543_024332_34D7929C 
X-CRM114-Status: GOOD (  26.40  )
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> This is too specific. I'd move it to nvme_user_cmd_post similar to how
> we handle passthru commands (with start/end that does stuff based on the
> effects)

Thank you for your comment.
I will recreate this patch which adds nvme_user_cmd_post
for update keep alive timer and move update routine to core.c.

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, August 7, 2021 5:07 AM
To: sasaki tatsuya(佐々木 達哉 ＫＩＣ ○Ｓ技Ｃ□ＳＳ開○ＳＳ一) <tatsuya6.sasaki@kioxia.com>; kernel test robot <lkp@intel.com>; kbusch@kernel.org; axboe@fb.com; hch@lst.de; linux-nvme@lists.infradead.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: update keep alive interval when kato is modified



On 8/2/21 7:12 PM, sasaki tatsuya wrote:
> Currently the connection between host and NVMe-oF target gets
> disconnected by keep-alive timeout when a user connects to a target
> with a relatively large kato value and then sets the smaller kato
> with a set features command (e.g. connects with 60 seconds kato value
> and then sets 10 seconds kato value).
> 
> The cause is that keep alive command interval on the host, which is
> defined as unsigned int kato in nvme_ctrl structure, does not follow
> the kato value changes.
> 
> This patch updates the keep alive interval in the following steps when
> the kato is modified by a set features command: stops the keep alive
> work queue, then sets the kato as new timer value and re-start the queue.
> 
> Signed-off-by: Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>
> ---
>   drivers/nvme/host/core.c  |  3 ++-
>   drivers/nvme/host/ioctl.c | 17 +++++++++++++++++
>   drivers/nvme/host/nvme.h  |  1 +
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..89c52da15618 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1255,13 +1255,14 @@ static void nvme_keep_alive_work(struct work_struct *work)
>   	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
>   }
>   
> -static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
> +void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
>   {
>   	if (unlikely(ctrl->kato == 0))
>   		return;
>   
>   	nvme_queue_keep_alive_work(ctrl);
>   }
> +EXPORT_SYMBOL_GPL(nvme_start_keep_alive);
>   
>   void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)
>   {
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 305ddd415e45..0066728e77b2 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -231,6 +231,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>   			return -EFAULT;
>   	}
>   
> +	/*
> +	 * Keep alive commands interval on the host should be updated
> +	 * when KATO is modified by Set Features commands.
> +	 */

This is too specific. I'd move it to nvme_user_cmd_post similar to how
we handle passthru commands (with start/end that does stuff based on the
effects)

> +	if (!status && cmd.opcode == nvme_admin_set_features &&
> +	    (cmd.cdw10 & 0xFF) == NVME_FEAT_KATO) {
> +		/* ms -> s */
> +		unsigned int new_kato = DIV_ROUND_UP(cmd.cdw11, 1000);
> +

The section below needs to move to a core rountine:
nvme_update_keep_alive()

> +		dev_info(ctrl->device,
> +			 "keep alive commands interval on the host is updated from %u milliseconds to %u milliseconds\n",
> +			 ctrl->kato * 1000 / 2, new_kato * 1000 / 2);
> +		nvme_stop_keep_alive(ctrl);
> +		ctrl->kato = new_kato;
> +		nvme_start_keep_alive(ctrl);
> +	}
> +
>   	return status;
>   }
>  


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
