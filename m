Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97E5CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izcbLUCQQc+CYZ8kxktU8Dg7ydeYF50eFbT9wQtw5vw=; b=V1kztVxQ5ZwTxWGHMnMJgvkc+4
	ZuM643HkQMheN1EgQCvsF9FPpM3NZ7hWZfPK/UMDCadlrMsbAToZZDk8il9a68iIj2yxrDCUdbyu5
	LikgkZOwbWG1HBskKRIeMzwU4xsnqn1mWxZR2D8aePMQRFlVjmGh6H4rShIoklm0/x5w3gelnO9B1
	hBXz23zM3nHfP4suR8EVEjEJLLiQGXijA8RCF6/heQEQdXFEjC9vN18mPJPtaaoG9lf9goUoa2No4
	bLC0e8N1IyOZIOoMJj0Uo/ic1rUm46i120x1IlsJT4X942OJpt1Or3rD7Wr07nwKsRCxJ5rUMoZmC
	dJbYDi1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st2Eu-00000001tVU-144o;
	Tue, 24 Sep 2024 09:53:48 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st26h-00000001rty-0ruk
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727171116; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=izcbLUCQQc+CYZ8kxktU8Dg7ydeYF50eFbT9wQtw5vw=;
	b=Mx5kjJ1Ax/6qcTow9kuqVhj/LjHd2CilSmGR60h2owo/k0EBZuFZ3R3DjkScHe6CQyYB+S/gFKMN1TE3kykkrqX9h7fXReGqixAAamjt4XxfgKWtZF/+fJQn8ObdBCUgznKgKGXkdL+gF1jwakihd1zDiORSKDExvthJh0UgK0Y=
Received: from 30.178.83.97(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFfnKjI_1727171113)
          by smtp.aliyun-inc.com;
          Tue, 24 Sep 2024 17:45:14 +0800
Message-ID: <68e3d62e-0f35-4b1b-9d46-b8e7ff0110b5@linux.alibaba.com>
Date: Tue, 24 Sep 2024 17:45:12 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v9 1/1] nvmet: support reservation feature
To: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20240923094708.42445-1-kanie@linux.alibaba.com>
 <20240923094708.42445-2-kanie@linux.alibaba.com>
 <20240923163228.GD22571@yadro.com>
 <114ce6b1-13e7-418e-bd23-8ab32a7b4c8f@linux.alibaba.com>
 <20240924055433.GE22571@yadro.com>
 <3b315daf-76a6-4360-aeac-65def22aa196@linux.alibaba.com>
 <0cddf902-9e60-43ca-b138-630c5485efa0@linux.alibaba.com>
 <20240924082425.GF22571@yadro.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20240924082425.GF22571@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_024519_770162_67D8A366 
X-CRM114-Status: UNSURE (   8.54  )
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


在 2024/9/24 16:24, Dmitry Bogdanov 写道:
>> I take a look again, if we set self new holder before call
>> nvmet_pr_unreg_all_others_by_prkey(), the
>> nvmet_pr_unreg_all_others_by_prkey() will
>>
>> not unregister self, so this will not goto nvmet_pr_unregister_one()'s
>> calling nvmet_pr_resv_released().
> Yes, and this is a reason not to try to fix non-atomicity (anothter my
> comment) by setting new holder before unregistering.
>
> Regarding this place, here nvmet_pr_resv_released should be called for
> original_rtype !=*_REG_ONLY with a note that _REG_ONLY handled in nvmet_pr_unregister_one.
>
> Please, do not take my suggestions "how to fix" as a direct order, it's
> just suggestion.
>
I'm a little confused, if we dont set new holder before unregistering,

how do we fix the non-atomicity problem?

My opinion is that setting current host to holder first can not only

make sure that during unregistering other host can not access, but also

ensure that nvmet_pr_unregister_one will not unregiter the new holder(In 
nvmet_pr_unreg_all_others_by_prkey, I exclude current host),

so that we dont need to worry about doule call nvmet_pr_resv_released.


